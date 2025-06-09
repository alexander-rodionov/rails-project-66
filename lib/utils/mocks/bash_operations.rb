# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength

module Utils
  module Mocks
    class BashOperations
      def self.git_clone(_auth_url, _target_dir)
        # [stdout_res, stderr_res, status_res]
        ['', '', ProcessStatus.new(0)]
      end

      def self.eslint(_dir)
        [<<~RESPONSE, '', ProcessStatus.new(0)]
          [
            {
              "filePath": "/home/alex/Hexlet/rails-project-66/tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/terrible.js",
              "messages": [
                {
                  "ruleId": "no-undef",
                  "severity": 2,
                  "message": "'myGlobal' is not defined.",
                  "line": 4,
                  "column": 1,
                  "nodeType": "Identifier",
                  "messageId": "undef",
                  "endLine": 4,
                  "endColumn": 9
                },
                {
                  "ruleId": "no-var",
                  "severity": 2,
                  "message": "Unexpected var, use let or const instead.",
                  "line": 7,
                  "column": 1,
                  "nodeType": "VariableDeclaration",
                  "messageId": "unexpectedVar",
                  "endLine": 7,
                  "endColumn": 12,
                  "fix": {
                    "range": [
                      137,
                      140
                    ],
                    "text": "let"
                  }
                },
                {
                  "ruleId": "no-var",
                  "severity": 2,
                  "message": "Unexpected var, use let or const instead.",
                  "line": 8,
                  "column": 1,
                  "nodeType": "VariableDeclaration",
                  "messageId": "unexpectedVar",
                  "endLine": 8,
                  "endColumn": 12,
                  "fix": {
                    "range": [
                      149,
                      152
                    ],
                    "text": "let"
                  }
                },
                {
                  "ruleId": "no-const-assign",
                  "severity": 2,
                  "message": "'PI' is constant.",
                  "line": 14,
                  "column": 1,
                  "nodeType": "Identifier",
                  "messageId": "const",
                  "endLine": 14,
                  "endColumn": 3
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'PI' is assigned a value but never used.",
                  "line": 14,
                  "column": 1,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 14,
                  "endColumn": 3
                },
                {
                  "ruleId": "no-multi-spaces",
                  "severity": 2,
                  "message": "Multiple spaces found before '// Oops!'.",
                  "line": 14,
                  "column": 14,
                  "nodeType": "Line",
                  "messageId": "multipleSpaces",
                  "endLine": 14,
                  "endColumn": 16,
                  "fix": {
                    "range": [
                      236,
                      238
                    ],
                    "text": " "
                  }
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'unusedVar' is assigned a value but never used.",
                  "line": 17,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 17,
                  "endColumn": 16,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "unusedVar"
                      },
                      "fix": {
                        "range": [
                          287,
                          322
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'unusedVar'."
                    }
                  ]
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'add' is defined but never used.",
                  "line": 20,
                  "column": 10,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 20,
                  "endColumn": 13,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "add"
                      },
                      "fix": {
                        "range": [
                          356,
                          393
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'add'."
                    }
                  ]
                },
                {
                  "ruleId": "semi",
                  "severity": 2,
                  "message": "Missing semicolon.",
                  "line": 21,
                  "column": 15,
                  "nodeType": "ReturnStatement",
                  "messageId": "missingSemi",
                  "endLine": 22,
                  "endColumn": 1,
                  "fix": {
                    "range": [
                      391,
                      391
                    ],
                    "text": ";"
                  }
                },
                {
                  "ruleId": "eqeqeq",
                  "severity": 2,
                  "message": "Expected '===' and instead saw '=='.",
                  "line": 25,
                  "column": 7,
                  "nodeType": "BinaryExpression",
                  "messageId": "unexpected",
                  "endLine": 25,
                  "endColumn": 9,
                  "suggestions": [
                    {
                      "messageId": "replaceOperator",
                      "data": {
                        "expectedOperator": "===",
                        "actualOperator": "=="
                      },
                      "fix": {
                        "range": [
                          434,
                          436
                        ],
                        "text": "==="
                      },
                      "desc": "Use '===' instead of '=='."
                    }
                  ]
                },
                {
                  "ruleId": "no-console",
                  "severity": 2,
                  "message": "Unexpected console statement.",
                  "line": 26,
                  "column": 3,
                  "nodeType": "MemberExpression",
                  "messageId": "unexpected",
                  "endLine": 26,
                  "endColumn": 14,
                  "suggestions": [
                    {
                      "fix": {
                        "range": [
                          447,
                          482
                        ],
                        "text": ""
                      },
                      "messageId": "removeConsole",
                      "data": {
                        "propertyName": "log"
                      },
                      "desc": "Remove the console.log()."
                    }
                  ]
                },
                {
                  "ruleId": "semi",
                  "severity": 2,
                  "message": "Missing semicolon.",
                  "line": 26,
                  "column": 38,
                  "nodeType": "ExpressionStatement",
                  "messageId": "missingSemi",
                  "endLine": 27,
                  "endColumn": 1,
                  "fix": {
                    "range": [
                      482,
                      482
                    ],
                    "text": ";"
                  }
                },
                {
                  "ruleId": "no-constant-condition",
                  "severity": 2,
                  "message": "Unexpected constant condition.",
                  "line": 30,
                  "column": 5,
                  "nodeType": "Literal",
                  "messageId": "unexpected",
                  "endLine": 30,
                  "endColumn": 9
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'innerFunc' is defined but never used.",
                  "line": 31,
                  "column": 12,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 31,
                  "endColumn": 21,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "innerFunc"
                      },
                      "fix": {
                        "range": [
                          552,
                          622
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'innerFunc'."
                    }
                  ]
                },
                {
                  "ruleId": "no-console",
                  "severity": 2,
                  "message": "Unexpected console statement.",
                  "line": 32,
                  "column": 5,
                  "nodeType": "MemberExpression",
                  "messageId": "unexpected",
                  "endLine": 32,
                  "endColumn": 16,
                  "suggestions": [
                    {
                      "fix": {
                        "range": [
                          579,
                          618
                        ],
                        "text": ""
                      },
                      "messageId": "removeConsole",
                      "data": {
                        "propertyName": "log"
                      },
                      "desc": "Remove the console.log()."
                    }
                  ]
                },
                {
                  "ruleId": "semi",
                  "severity": 2,
                  "message": "Missing semicolon.",
                  "line": 32,
                  "column": 44,
                  "nodeType": "ExpressionStatement",
                  "messageId": "missingSemi",
                  "endLine": 33,
                  "endColumn": 1,
                  "fix": {
                    "range": [
                      618,
                      618
                    ],
                    "text": ";"
                  }
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'badQuotes' is assigned a value but never used.",
                  "line": 37,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 37,
                  "endColumn": 16
                },
                {
                  "ruleId": "quotes",
                  "severity": 2,
                  "message": "Strings must use singlequote.",
                  "line": 37,
                  "column": 19,
                  "nodeType": "Literal",
                  "messageId": "wrongQuotes",
                  "endLine": 37,
                  "endColumn": 75,
                  "fix": {
                    "range": [
                      679,
                      735
                    ],
                    "text": "'Double quotes are fine, but project uses single quotes'"
                  }
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'trailingSpace' is assigned a value but never used.",
                  "line": 40,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 40,
                  "endColumn": 20,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "trailingSpace"
                      },
                      "fix": {
                        "range": [
                          781,
                          821
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'trailingSpace'."
                    }
                  ]
                },
                {
                  "ruleId": "no-trailing-spaces",
                  "severity": 2,
                  "message": "Trailing spaces not allowed.",
                  "line": 40,
                  "column": 41,
                  "nodeType": "Program",
                  "messageId": "trailingSpace",
                  "endLine": 40,
                  "endColumn": 43,
                  "fix": {
                    "range": [
                      821,
                      823
                    ],
                    "text": ""
                  }
                },
                {
                  "ruleId": "no-console",
                  "severity": 2,
                  "message": "Unexpected console statement.",
                  "line": 43,
                  "column": 1,
                  "nodeType": "MemberExpression",
                  "messageId": "unexpected",
                  "endLine": 43,
                  "endColumn": 12,
                  "suggestions": [
                    {
                      "fix": {
                        "range": [
                          870,
                          904
                        ],
                        "text": ""
                      },
                      "messageId": "removeConsole",
                      "data": {
                        "propertyName": "log"
                      },
                      "desc": "Remove the console.log()."
                    }
                  ]
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'unreachableExample' is defined but never used.",
                  "line": 46,
                  "column": 10,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 46,
                  "endColumn": 28,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "unreachableExample"
                      },
                      "fix": {
                        "range": [
                          947,
                          1038
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'unreachableExample'."
                    }
                  ]
                },
                {
                  "ruleId": "no-unreachable",
                  "severity": 2,
                  "message": "Unreachable code.",
                  "line": 48,
                  "column": 3,
                  "nodeType": "ExpressionStatement",
                  "messageId": "unreachableCode",
                  "endLine": 48,
                  "endColumn": 36
                },
                {
                  "ruleId": "no-console",
                  "severity": 2,
                  "message": "Unexpected console statement.",
                  "line": 48,
                  "column": 3,
                  "nodeType": "MemberExpression",
                  "messageId": "unexpected",
                  "endLine": 48,
                  "endColumn": 14,
                  "suggestions": [
                    {
                      "fix": {
                        "range": [
                          1003,
                          1036
                        ],
                        "text": ""
                      },
                      "messageId": "removeConsole",
                      "data": {
                        "propertyName": "log"
                      },
                      "desc": "Remove the console.log()."
                    }
                  ]
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'terribleArray' is assigned a value but never used.",
                  "line": 52,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 52,
                  "endColumn": 20
                },
                {
                  "ruleId": "comma-dangle",
                  "severity": 2,
                  "message": "Unexpected trailing comma.",
                  "line": 55,
                  "column": 4,
                  "nodeType": "Literal",
                  "messageId": "unexpected",
                  "endLine": 55,
                  "endColumn": 5,
                  "fix": {
                    "range": [
                      1111,
                      1158
                    ],
                    "text": "3  // Extra comma (forbidden in some styles)\n]"
                  }
                },
                {
                  "ruleId": "no-multi-spaces",
                  "severity": 2,
                  "message": "Multiple spaces found before '// Extra comma...'.",
                  "line": 55,
                  "column": 5,
                  "nodeType": "Line",
                  "messageId": "multipleSpaces",
                  "endLine": 55,
                  "endColumn": 7,
                  "fix": {
                    "range": [
                      1113,
                      1115
                    ],
                    "text": " "
                  }
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'messyIndent' is defined but never used.",
                  "line": 59,
                  "column": 10,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 59,
                  "endColumn": 21,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "messyIndent"
                      },
                      "fix": {
                        "range": [
                          1202,
                          1327
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'messyIndent'."
                    }
                  ]
                },
                {
                  "ruleId": "no-console",
                  "severity": 2,
                  "message": "Unexpected console statement.",
                  "line": 60,
                  "column": 1,
                  "nodeType": "MemberExpression",
                  "messageId": "unexpected",
                  "endLine": 60,
                  "endColumn": 12,
                  "suggestions": [
                    {
                      "fix": {
                        "range": [
                          1227,
                          1273
                        ],
                        "text": ""
                      },
                      "messageId": "removeConsole",
                      "data": {
                        "propertyName": "log"
                      },
                      "desc": "Remove the console.log()."
                    }
                  ]
                },
                {
                  "ruleId": "indent",
                  "severity": 2,
                  "message": "Expected indentation of 2 spaces but found 0.",
                  "line": 60,
                  "column": 1,
                  "nodeType": "Identifier",
                  "messageId": "wrongIndentation",
                  "endLine": 60,
                  "endColumn": 1,
                  "fix": {
                    "range": [
                      1227,
                      1227
                    ],
                    "text": "  "
                  }
                },
                {
                  "ruleId": "no-console",
                  "severity": 2,
                  "message": "Unexpected console statement.",
                  "line": 61,
                  "column": 3,
                  "nodeType": "MemberExpression",
                  "messageId": "unexpected",
                  "endLine": 61,
                  "endColumn": 14,
                  "suggestions": [
                    {
                      "fix": {
                        "range": [
                          1276,
                          1325
                        ],
                        "text": ""
                      },
                      "messageId": "removeConsole",
                      "data": {
                        "propertyName": "log"
                      },
                      "desc": "Remove the console.log()."
                    }
                  ]
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'messyArrow' is assigned a value but never used.",
                  "line": 65,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 65,
                  "endColumn": 17
                },
                {
                  "ruleId": "no-trailing-spaces",
                  "severity": 2,
                  "message": "Trailing spaces not allowed.",
                  "line": 65,
                  "column": 25,
                  "nodeType": "Program",
                  "messageId": "trailingSpace",
                  "endLine": 65,
                  "endColumn": 26,
                  "fix": {
                    "range": [
                      1422,
                      1423
                    ],
                    "text": ""
                  }
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'badObject' is assigned a value but never used.",
                  "line": 69,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 69,
                  "endColumn": 16,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "badObject"
                      },
                      "fix": {
                        "range": [
                          1519,
                          1580
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'badObject'."
                    }
                  ]
                },
                {
                  "ruleId": "no-dupe-keys",
                  "severity": 2,
                  "message": "Duplicate key 'key'.",
                  "line": 71,
                  "column": 3,
                  "nodeType": "ObjectExpression",
                  "messageId": "unexpected",
                  "endLine": 71,
                  "endColumn": 6
                },
                {
                  "ruleId": "comma-dangle",
                  "severity": 2,
                  "message": "Unexpected trailing comma.",
                  "line": 71,
                  "column": 9,
                  "nodeType": "Property",
                  "messageId": "unexpected",
                  "endLine": 71,
                  "endColumn": 10,
                  "fix": {
                    "range": [
                      1556,
                      1579
                    ],
                    "text": "2  // Duplicate key!\n}"
                  }
                },
                {
                  "ruleId": "no-multi-spaces",
                  "severity": 2,
                  "message": "Multiple spaces found before '// Duplicate k...'.",
                  "line": 71,
                  "column": 10,
                  "nodeType": "Line",
                  "messageId": "multipleSpaces",
                  "endLine": 71,
                  "endColumn": 12,
                  "fix": {
                    "range": [
                      1558,
                      1560
                    ],
                    "text": " "
                  }
                },
                {
                  "ruleId": "default-case",
                  "severity": 2,
                  "message": "Expected a default case.",
                  "line": 75,
                  "column": 1,
                  "nodeType": "SwitchStatement",
                  "messageId": "missingDefaultCase",
                  "endLine": 78,
                  "endColumn": 2
                },
                {
                  "ruleId": "indent",
                  "severity": 2,
                  "message": "Expected indentation of 0 spaces but found 2.",
                  "line": 76,
                  "column": 1,
                  "nodeType": "Keyword",
                  "messageId": "wrongIndentation",
                  "endLine": 76,
                  "endColumn": 3,
                  "fix": {
                    "range": [
                      1643,
                      1645
                    ],
                    "text": ""
                  }
                },
                {
                  "ruleId": "indent",
                  "severity": 2,
                  "message": "Expected indentation of 2 spaces but found 4.",
                  "line": 77,
                  "column": 1,
                  "nodeType": "Identifier",
                  "messageId": "wrongIndentation",
                  "endLine": 77,
                  "endColumn": 5,
                  "fix": {
                    "range": [
                      1654,
                      1658
                    ],
                    "text": "  "
                  }
                },
                {
                  "ruleId": "no-console",
                  "severity": 2,
                  "message": "Unexpected console statement.",
                  "line": 77,
                  "column": 5,
                  "nodeType": "MemberExpression",
                  "messageId": "unexpected",
                  "endLine": 77,
                  "endColumn": 16,
                  "suggestions": [
                    {
                      "fix": {
                        "range": [
                          1658,
                          1690
                        ],
                        "text": ""
                      },
                      "messageId": "removeConsole",
                      "data": {
                        "propertyName": "log"
                      },
                      "desc": "Remove the console.log()."
                    }
                  ]
                },
                {
                  "ruleId": "no-plusplus",
                  "severity": 2,
                  "message": "Unary operator '++' used.",
                  "line": 81,
                  "column": 25,
                  "nodeType": "UpdateExpression",
                  "messageId": "unexpectedUnaryOp",
                  "endLine": 81,
                  "endColumn": 28
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'nestedTernary' is assigned a value but never used.",
                  "line": 86,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 86,
                  "endColumn": 20
                },
                {
                  "ruleId": "no-nested-ternary",
                  "severity": 2,
                  "message": "Do not nest ternary expressions.",
                  "line": 86,
                  "column": 23,
                  "nodeType": "ConditionalExpression",
                  "messageId": "noNestedTernary",
                  "endLine": 86,
                  "endColumn": 55
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'shadowed' is assigned a value but never used.",
                  "line": 89,
                  "column": 5,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 89,
                  "endColumn": 13,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "shadowed"
                      },
                      "fix": {
                        "range": [
                          1919,
                          1936
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'shadowed'."
                    }
                  ]
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'shadowExample' is defined but never used.",
                  "line": 90,
                  "column": 10,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 90,
                  "endColumn": 23,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "shadowExample"
                      },
                      "fix": {
                        "range": [
                          1937,
                          2012
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'shadowExample'."
                    }
                  ]
                },
                {
                  "ruleId": "no-unused-vars",
                  "severity": 2,
                  "message": "'shadowed' is assigned a value but never used.",
                  "line": 91,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "unusedVar",
                  "endLine": 91,
                  "endColumn": 15,
                  "suggestions": [
                    {
                      "messageId": "removeVar",
                      "data": {
                        "varName": "shadowed"
                      },
                      "fix": {
                        "range": [
                          1966,
                          1983
                        ],
                        "text": ""
                      },
                      "desc": "Remove unused variable 'shadowed'."
                    }
                  ]
                },
                {
                  "ruleId": "no-shadow",
                  "severity": 2,
                  "message": "'shadowed' is already declared in the upper scope on line 89 column 5.",
                  "line": 91,
                  "column": 7,
                  "nodeType": "Identifier",
                  "messageId": "noShadow",
                  "endLine": 91,
                  "endColumn": 15
                },
                {
                  "ruleId": "no-multi-spaces",
                  "severity": 2,
                  "message": "Multiple spaces found before '// Shadows out...'.",
                  "line": 91,
                  "column": 20,
                  "nodeType": "Line",
                  "messageId": "multipleSpaces",
                  "endLine": 91,
                  "endColumn": 22,
                  "fix": {
                    "range": [
                      1983,
                      1985
                    ],
                    "text": " "
                  }
                },
                {
                  "ruleId": "no-eval",
                  "severity": 2,
                  "message": "eval can be harmful.",
                  "line": 95,
                  "column": 1,
                  "nodeType": "CallExpression",
                  "messageId": "unexpected",
                  "endLine": 95,
                  "endColumn": 5
                }
              ],
              "suppressedMessages": [],
              "errorCount": 50,
              "fatalErrorCount": 0,
              "warningCount": 0,
              "fixableErrorCount": 17,
              "fixableWarningCount": 0,
              "source": "\n\n// 1. Undeclared global variable (no-var, no-undef)\nmyGlobal = 'I am global pollution';\n\n// 2. Using var instead of const/let (no-var)\nvar x = 10;\nvar y = 20;\n\n\n\n// 3. Reassigning const (no-const-assign)\nconst PI = 3.14;\nPI = 3.14159;  // Oops!\n\n// 4. Unused variable (no-unused-vars)\nconst unusedVar = 'Why am I here?';\n\n// 5. Missing semicolons (semi)\nfunction add(a, b) {\n  return a + b\n}\n\n// 6. == instead of === (eqeqeq)\nif (x == '10') {\n  console.log('Loose equality! Bad!')\n}\n\n// 7. Block-scoped function (no-inner-declarations)\nif (true) {\n  function innerFunc() {\n    console.log('I should not exist here!')\n  }\n}\n\n// 8. Inconsistent quotes (quotes)\nconst badQuotes = "Double quotes are fine, but project uses single quotes";\n\n// 9. Trailing spaces (no-trailing-spaces)\nconst trailingSpace = 'Look at me!    ';  \n\n// 10. console.log left in code (no-console)\nconsole.log('Debugging leftover');\n\n// 11. Unreachable code (no-unreachable)\nfunction unreachableExample() {\n  return 'I am done';\n  console.log('I will never run!');\n}\n\n// 12. Comma dangle (comma-dangle)\nconst terribleArray = [\n  1,\n  2,\n  3,  // Extra comma (forbidden in some styles)\n];\n\n// 13. Inconsistent indentation (indent)\nfunction messyIndent() {\nconsole.log('2 spaces? 4 spaces? Who cares!');\n  console.log('This line is indented differently');\n}\n\n// 14. Arrow function with confusing body (implicit-arrow-linebreak)\nconst messyArrow = () => \n  'This arrow function has weird line breaks';\n\n// 15. Duplicate keys in object (no-dupe-keys)\nconst badObject = {\n  key: 1,\n  key: 2,  // Duplicate key!\n};\n\n// 16. Missing default in switch (default-case)\nswitch (x) {\n  case 10:\n    console.log('No default case!');\n}\n\n// 17. Unary operators misuse (no-plusplus)\nfor (let i = 0; i < 10; i++) {\n  x += i;\n}\n\n// 18. Nested ternary (no-nested-ternary)\nconst nestedTernary = x > 5 ? y < 15 ? 'A' : 'B' : 'C';\n\n// 19. Shadowing variable (no-shadow)\nlet shadowed = 1;\nfunction shadowExample() {\n  let shadowed = 2;  // Shadows outer variable\n}\n\n// 20. eval (no-eval)\neval('console.log("Dangerous eval!")');\n\n",
              "usedDeprecatedRules": [
                {
                  "ruleId": "semi",
                  "replacedBy": [
                    "@stylistic/js/semi"
                  ],
                  "info": {
                    "message": "Formatting rules are being moved out of ESLint core.",
                    "url": "https://eslint.org/blog/2023/10/deprecating-formatting-rules/",
                    "deprecatedSince": "8.53.0",
                    "availableUntil": "10.0.0",
                    "replacedBy": [
                      {
                        "message": "ESLint Stylistic now maintains deprecated stylistic core rules.",
                        "url": "https://eslint.style/guide/migration",
                        "plugin": {
                          "name": "@stylistic/eslint-plugin-js",
                          "url": "https://eslint.style/packages/js"
                        },
                        "rule": {
                          "name": "semi",
                          "url": "https://eslint.style/rules/js/semi"
                        }
                      }
                    ]
                  }
                },
                {
                  "ruleId": "quotes",
                  "replacedBy": [
                    "@stylistic/js/quotes"
                  ],
                  "info": {
                    "message": "Formatting rules are being moved out of ESLint core.",
                    "url": "https://eslint.org/blog/2023/10/deprecating-formatting-rules/",
                    "deprecatedSince": "8.53.0",
                    "availableUntil": "10.0.0",
                    "replacedBy": [
                      {
                        "message": "ESLint Stylistic now maintains deprecated stylistic core rules.",
                        "url": "https://eslint.style/guide/migration",
                        "plugin": {
                          "name": "@stylistic/eslint-plugin-js",
                          "url": "https://eslint.style/packages/js"
                        },
                        "rule": {
                          "name": "quotes",
                          "url": "https://eslint.style/rules/js/quotes"
                        }
                      }
                    ]
                  }
                },
                {
                  "ruleId": "no-trailing-spaces",
                  "replacedBy": [
                    "@stylistic/js/no-trailing-spaces"
                  ],
                  "info": {
                    "message": "Formatting rules are being moved out of ESLint core.",
                    "url": "https://eslint.org/blog/2023/10/deprecating-formatting-rules/",
                    "deprecatedSince": "8.53.0",
                    "availableUntil": "10.0.0",
                    "replacedBy": [
                      {
                        "message": "ESLint Stylistic now maintains deprecated stylistic core rules.",
                        "url": "https://eslint.style/guide/migration",
                        "plugin": {
                          "name": "@stylistic/eslint-plugin-js",
                          "url": "https://eslint.style/packages/js"
                        },
                        "rule": {
                          "name": "no-trailing-spaces",
                          "url": "https://eslint.style/rules/js/no-trailing-spaces"
                        }
                      }
                    ]
                  }
                },
                {
                  "ruleId": "comma-dangle",
                  "replacedBy": [
                    "@stylistic/js/comma-dangle"
                  ],
                  "info": {
                    "message": "Formatting rules are being moved out of ESLint core.",
                    "url": "https://eslint.org/blog/2023/10/deprecating-formatting-rules/",
                    "deprecatedSince": "8.53.0",
                    "availableUntil": "10.0.0",
                    "replacedBy": [
                      {
                        "message": "ESLint Stylistic now maintains deprecated stylistic core rules.",
                        "url": "https://eslint.style/guide/migration",
                        "plugin": {
                          "name": "@stylistic/eslint-plugin-js",
                          "url": "https://eslint.style/packages/js"
                        },
                        "rule": {
                          "name": "comma-dangle",
                          "url": "https://eslint.style/rules/js/comma-dangle"
                        }
                      }
                    ]
                  }
                },
                {
                  "ruleId": "indent",
                  "replacedBy": [
                    "@stylistic/js/indent"
                  ],
                  "info": {
                    "message": "Formatting rules are being moved out of ESLint core.",
                    "url": "https://eslint.org/blog/2023/10/deprecating-formatting-rules/",
                    "deprecatedSince": "8.53.0",
                    "availableUntil": "10.0.0",
                    "replacedBy": [
                      {
                        "message": "ESLint Stylistic now maintains deprecated stylistic core rules.",
                        "url": "https://eslint.style/guide/migration",
                        "plugin": {
                          "name": "@stylistic/eslint-plugin-js",
                          "url": "https://eslint.style/packages/js"
                        },
                        "rule": {
                          "name": "indent",
                          "url": "https://eslint.style/rules/js/indent"
                        }
                      }
                    ]
                  }
                },
                {
                  "ruleId": "no-multi-spaces",
                  "replacedBy": [
                    "@stylistic/js/no-multi-spaces"
                  ],
                  "info": {
                    "message": "Formatting rules are being moved out of ESLint core.",
                    "url": "https://eslint.org/blog/2023/10/deprecating-formatting-rules/",
                    "deprecatedSince": "8.53.0",
                    "availableUntil": "10.0.0",
                    "replacedBy": [
                      {
                        "message": "ESLint Stylistic now maintains deprecated stylistic core rules.",
                        "url": "https://eslint.style/guide/migration",
                        "plugin": {
                          "name": "@stylistic/eslint-plugin-js",
                          "url": "https://eslint.style/packages/js"
                        },
                        "rule": {
                          "name": "no-multi-spaces",
                          "url": "https://eslint.style/rules/js/no-multi-spaces"
                        }
                      }
                    ]
                  }
                },
                {
                  "ruleId": "no-extra-semi",
                  "replacedBy": [
                    "@stylistic/js/no-extra-semi"
                  ],
                  "info": {
                    "message": "Formatting rules are being moved out of ESLint core.",
                    "url": "https://eslint.org/blog/2023/10/deprecating-formatting-rules/",
                    "deprecatedSince": "8.53.0",
                    "availableUntil": "10.0.0",
                    "replacedBy": [
                      {
                        "message": "ESLint Stylistic now maintains deprecated stylistic core rules.",
                        "url": "https://eslint.style/guide/migration",
                        "plugin": {
                          "name": "@stylistic/eslint-plugin-js",
                          "url": "https://eslint.style/packages/js"
                        },
                        "rule": {
                          "name": "no-extra-semi",
                          "url": "https://eslint.style/rules/js/no-extra-semi"
                        }
                      }
                    ]
                  }
                }
              ]
            }
          ]
        RESPONSE
      end

      def self.rubocop(_dir)
        [<<~RESPONSE, '', ProcessStatus.new(0)]
          {
            "metadata": {
              "rubocop_version": "1.75.7",
              "ruby_engine": "ruby",
              "ruby_version": "3.2.2",
              "ruby_patchlevel": "53",
              "ruby_platform": "x86_64-linux"
            },
            "files": [
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/Gemfile",
                "offenses": []
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/Rakefile",
                "offenses": []
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/bin/console",
                "offenses": []
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/hexlet_code.gemspec",
                "offenses": [
                  {
                    "severity": "warning",
                    "message": "`required_ruby_version` and `TargetRubyVersion` (3.2, which may be specified in .rubocop.yml) should be equal.",
                    "cop_name": "Gemspec/RequiredRubyVersion",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 15,
                      "start_column": 32,
                      "last_line": 15,
                      "last_column": 41,
                      "length": 10,
                      "line": 15,
                      "column": 32
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `module HexletCode`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 5,
                      "start_column": 1,
                      "last_line": 5,
                      "last_column": 17,
                      "length": 17,
                      "line": 5,
                      "column": 1
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/form_builder.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `class HexletCode::FormBuilder`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 8,
                      "start_column": 3,
                      "last_line": 8,
                      "last_column": 19,
                      "length": 17,
                      "line": 8,
                      "column": 3
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/form_renderer.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `class HexletCode::FormRenderer`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 4,
                      "start_column": 3,
                      "last_line": 4,
                      "last_column": 20,
                      "length": 18,
                      "line": 4,
                      "column": 3
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/inputs.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `module HexletCode::Inputs`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 4,
                      "start_column": 3,
                      "last_line": 4,
                      "last_column": 15,
                      "length": 13,
                      "line": 4,
                      "column": 3
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/inputs/base_input.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `class HexletCode::Inputs::BaseInput`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 5,
                      "start_column": 5,
                      "last_line": 5,
                      "last_column": 19,
                      "length": 15,
                      "line": 5,
                      "column": 5
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/inputs/string_input.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `class HexletCode::Inputs::StringInput`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 5,
                      "start_column": 5,
                      "last_line": 5,
                      "last_column": 21,
                      "length": 17,
                      "line": 5,
                      "column": 5
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/inputs/text_input.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `class HexletCode::Inputs::TextInput`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 5,
                      "start_column": 5,
                      "last_line": 5,
                      "last_column": 19,
                      "length": 15,
                      "line": 5,
                      "column": 5
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/tag.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `class HexletCode::Tag`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 5,
                      "start_column": 3,
                      "last_line": 5,
                      "last_column": 11,
                      "length": 9,
                      "line": 5,
                      "column": 3
                    }
                  }
                ]
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/lib/hexlet_code/version.rb",
                "offenses": []
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/test/test_helper.rb",
                "offenses": []
              },
              {
                "path": "tmp_repos/941649638/c7e6ca07d94bede24b78ee85d4f6e05df36b45dc/test/test_hexlet_code.rb",
                "offenses": [
                  {
                    "severity": "convention",
                    "message": "Missing top-level documentation comment for `class TestHexletCode`.",
                    "cop_name": "Style/Documentation",
                    "corrected": false,
                    "correctable": false,
                    "location": {
                      "start_line": 5,
                      "start_column": 1,
                      "last_line": 5,
                      "last_column": 20,
                      "length": 20,
                      "line": 5,
                      "column": 1
                    }
                  },
                  {
                    "severity": "convention",
                    "message": "Don't use parentheses around a method argument.",
                    "cop_name": "Style/RedundantParentheses",
                    "corrected": false,
                    "correctable": true,
                    "location": {
                      "start_line": 20,
                      "start_column": 18,
                      "last_line": 20,
                      "last_column": 60,
                      "length": 43,
                      "line": 20,
                      "column": 18
                    }
                  },
                  {
                    "severity": "convention",
                    "message": "Don't use parentheses around a method argument.",
                    "cop_name": "Style/RedundantParentheses",
                    "corrected": false,
                    "correctable": true,
                    "location": {
                      "start_line": 21,
                      "start_column": 18,
                      "last_line": 21,
                      "last_column": 74,
                      "length": 57,
                      "line": 21,
                      "column": 18
                    }
                  },
                  {
                    "severity": "warning",
                    "message": "Unnecessary disabling of `Lint/EmptyBlock`.",
                    "cop_name": "Lint/RedundantCopDisableDirective",
                    "corrected": false,
                    "correctable": true,
                    "location": {
                      "start_line": 106,
                      "start_column": 48,
                      "last_line": 106,
                      "last_column": 80,
                      "length": 33,
                      "line": 106,
                      "column": 48
                    }
                  }
                ]
              }
            ],
            "summary": {
              "offense_count": 13,
              "target_file_count": 15,
              "inspected_file_count": 15
            }
          }
        RESPONSE
      end
    end

    class ProcessStatus
      def initialize(exitstatus)
        @exitstatus = exitstatus
      end

      attr_reader :exitstatus

      def success?
        @exitstatus.zero?
      end
    end
  end
end

# rubocop:enable Metrics/ClassLength
