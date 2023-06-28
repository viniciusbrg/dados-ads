from json import dump

monolith_path = './monolith'
microservices_path = './microservices'



# each file will have data for 30 tests
number_of_tests = 30

# report takes 13 lines
test_report_lines = 13


def parse_file(raw_path):
    input_file = raw_path + ".txt"
    output_file = raw_path + ".json"
    try:
        with open(input_file, 'r') as file:
            lines = file.readlines()
        
        start_time = lines[0]
        end_time = lines[len(lines) - 1]
        results = []
        for i in range(number_of_tests):
            result = {}
            for j in range(test_report_lines):
                # 1 because we skip first line
                line = 1 + test_report_lines * i + j
                clean_line = lines[line].strip().split()

                is_percentil = clean_line[0] == "50%" or clean_line[0] == "75%" or \
                    clean_line[0] == "90%" or clean_line[0] == "99%"
                if clean_line[0] == "Latency" and clean_line[1] != "Distribution":
                    result["avg"] = clean_line[1]
                if is_percentil:
                    result[clean_line[0]] = clean_line[1]
                if clean_line[0] == "Requests/sec:":
                    result["throughput"] = clean_line[1]
            results.append(result)
        f = open(output_file, "w")
        dump(results, f)
    except FileNotFoundError:
        print("File not found.")
    except IOError:
        print("Error reading the file.")


for i in range(4):
    parse_file(f'{monolith_path}/result{i + 1}')

for i in range(4):
    parse_file(f'{microservices_path}/result{i + 1}')