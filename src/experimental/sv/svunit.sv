package svunit;

  import svunit_pkg::*;
  `include "svunit_defines.svh"

  `include "svunit/full_name_extraction.svh"
  `include "svunit/test.svh"

  `include "svunit/testcase.svh"
  `include "svunit/testsuite.svh"
  `include "svunit/test_registry.svh"
  `include "svunit/global_test_registry.svh"


  task automatic run_all_tests();
    svunit_testrunner svunit_tr = new("testrunner");
    testsuite testsuites[] = global_test_registry::get().get_testsuites();

    foreach (testsuites[i])
      svunit_tr.add_testsuite(testsuites[i]);

    foreach (testsuites[i]) begin
      testcase testcases[] = testsuites[i].get_testcases();

      testsuites[i].run();
      foreach (testcases[j])
        testcases[j].run();
      testsuites[i].report();
    end

    svunit_tr.report();
  endtask

endpackage
