Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1F42048E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431807; cv=none; b=iVXrqROwXaV/oPvniwFrDz3L/gZD8HYCZVqfneebHYd7udYce7ds1rMmKEab7VG6dEYM+99ZAwnW3UGS02LK0NSEch/uLGYDcA86hFPj3IT0vlmhXMWVbGj2TpYX2hm+SGurN0hXrXUs/izI1SXM+he/paCRmA9T3w5vvNduCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431807; c=relaxed/simple;
	bh=Hcxe24RAOatgeyCxGiOL0aMbHmcJWxWoV9O3mU3rsjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBIUqY3ehgFTJ4UToOnbUfGhPDN34UuNwTRGdZBMp3qjLX/O0EqikYTBOxCrsOIgwdHX/uSttDk9GzbKHkAV6MSqtJc+pCDuwztxxVR7wWzARo+7keXF4Kgxr4jrkEP8kwOcH5oUJmspzqI/ATSeumuHPZCSfWJKZEr7wXFOntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5DB946060B; Thu, 03 Sep 2026 12:36:42 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 net] selftests/tc-testing: pass mp_pm via initialiser
Date: Thu,  3 Sep 2026 12:36:21 +0200
Message-ID: <20260903103621.13160-1-fw@strlen.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script doesn't work for me, "tdc.py -J32" gives:
 -- ns/SubPlugin.__init__
Executing 1205 tests in parallel and 89 in serial
Using 39 batches and 4 workers
multiprocessing.pool.RemoteTraceback:
"""
Traceback (most recent call last):
  File "/usr/lib/python3.14/multiprocessing/pool.py", line 125, in worker
    result = (True, func(*args, **kwds))
                    ~~~~^^^^^^^^^^^^^^^
  File "/usr/lib/python3.14/multiprocessing/pool.py", line 48, in mapstar
    return list(map(*args))
  File "tools/testing/selftests/tc-testing/tdc.py", line 604, in __mp_runner
    (_, tsr) = test_runner(mp_pm, mp_args, tests)
                           ^^^^^
NameError: name 'mp_pm' is not defined

Other problem:

run_one_test() appends random suffix to NAMES[+ (NS, DEV0, ...).
There is a chance that other run_one_test instances pick up the altered
string, not the configured one and append another random suffix.

This causes spurious error when pyroute2 plugin tries to add
a device like "dummy0id1234idabcd".

Keep NAMES[] as-is. Append only to args.NAMES and update
readers to use args.NAMES too.

Assisted-by: ollama:gemma4:26b
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2:
 - detach from 'reset conntrack after packet munging' series.
 - make global NAMES readonly, only change local copy.

 .../tc-testing/plugin-lib/scapyPlugin.py      |  2 +-
 tools/testing/selftests/tc-testing/tdc.py     | 64 +++++++++----------
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
index 254136e3da5a..26998deea0b6 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/scapyPlugin.py
@@ -49,6 +49,6 @@ class SubPlugin(TdcPlugin):
             pkt = eval(scapyinfo['packet'])
             if '$' in scapyinfo['iface']:
                 tpl = Template(scapyinfo['iface'])
-                scapyinfo['iface'] = tpl.safe_substitute(NAMES)
+                scapyinfo['iface'] = tpl.safe_substitute(self.args.NAMES)
             for count in range(scapyinfo['count']):
                 sendp(pkt, iface=scapyinfo['iface'])
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 511d66c36a2a..7c7f96aaef55 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -188,13 +188,13 @@ class PluginMgr:
         self.argparser = argparse.ArgumentParser(
             description='Linux TC unit tests')
 
-def replace_keywords(cmd):
+def replace_keywords(cmd, names):
     """
     For a given executable command, substitute any known
     variables contained within NAMES with the correct values
     """
     tcmd = Template(cmd)
-    subcmd = tcmd.safe_substitute(NAMES)
+    subcmd = tcmd.safe_substitute(names)
     return subcmd
 
 
@@ -206,7 +206,7 @@ def exec_cmd(caseinfo, args, pm, stage, command):
     if len(command.strip()) == 0:
         return None, None
     if '$' in command:
-        command = replace_keywords(command)
+        command = replace_keywords(command, args.NAMES)
 
     command = pm.call_adjust_command(caseinfo, stage, command)
     if args.verbose > 0:
@@ -374,11 +374,6 @@ def find_in_json_other(res, outputJSONVal, matchJSONVal, matchJSONKey=None):
 
 def run_one_test(pm, args, index, tidx):
     global NAMES
-    ns = NAMES['NS']
-    dev0 = NAMES['DEV0']
-    dev1 = NAMES['DEV1']
-    dummy = NAMES['DUMMY']
-    ifb = NAMES['IFB']
     result = True
     tresult = ""
     tap = ""
@@ -396,6 +391,15 @@ def run_one_test(pm, args, index, tidx):
             pm.call_post_execute(tidx)
             return res
 
+    # populate NAMES with TESTID for this test
+    args.NAMES = NAMES.copy()
+    args.NAMES['TESTID'] = tidx['id']
+    args.NAMES['NS'] = '{}-{}'.format(NAMES['NS'], tidx['random'])
+    args.NAMES['DEV0'] = '{}id{}'.format(NAMES['DEV0'], tidx['id'])
+    args.NAMES['DEV1'] = '{}id{}'.format(NAMES['DEV1'], tidx['id'])
+    args.NAMES['DUMMY'] = '{}id{}'.format(NAMES['DUMMY'], tidx['id'])
+    args.NAMES['IFB'] = '{}id{}'.format(NAMES['IFB'], tidx['id'])
+
     if 'dependsOn' in tidx:
         if (args.verbose > 0):
             print('probe command for test skip')
@@ -409,13 +413,6 @@ def run_one_test(pm, args, index, tidx):
                 pm.call_post_execute(tidx)
                 return res
 
-    # populate NAMES with TESTID for this test
-    NAMES['TESTID'] = tidx['id']
-    NAMES['NS'] = '{}-{}'.format(NAMES['NS'], tidx['random'])
-    NAMES['DEV0'] = '{}id{}'.format(NAMES['DEV0'], tidx['id'])
-    NAMES['DEV1'] = '{}id{}'.format(NAMES['DEV1'], tidx['id'])
-    NAMES['DUMMY'] = '{}id{}'.format(NAMES['DUMMY'], tidx['id'])
-    NAMES['IFB'] = '{}id{}'.format(NAMES['IFB'], tidx['id'])
 
     pm.call_pre_case(tidx)
     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
@@ -468,16 +465,6 @@ def run_one_test(pm, args, index, tidx):
 
     index += 1
 
-    # remove TESTID from NAMES
-    del(NAMES['TESTID'])
-
-    # Restore names
-    NAMES['NS'] = ns
-    NAMES['DEV0'] = dev0
-    NAMES['DEV1'] = dev1
-    NAMES['DUMMY'] = dummy
-    NAMES['IFB'] = ifb
-
     return res
 
 def prepare_run(pm, args, testlist):
@@ -600,6 +587,18 @@ def mp_bins(alltests):
 
     return (serial, parallel)
 
+mp_pm = None
+mp_args = None
+
+def __mp_init__(pm, args):
+    """
+    This function is called once when each worker process starts.
+    It sets the global variables in the child process's memory space.
+    """
+    global mp_pm, mp_args
+    mp_pm = pm
+    mp_args = args
+
 def __mp_runner(tests):
     (_, tsr) = test_runner(mp_pm, mp_args, tests)
     return tsr._testsuite
@@ -615,14 +614,13 @@ def test_runner_mp(pm, args, alltests):
     print("Executing {} tests in parallel and {} in serial".format(len(parallel), len(serial)))
     print("Using {} batches and {} workers".format(len(batches), args.mp))
 
-    # We can't pickle these objects so workaround them
-    global mp_pm
-    mp_pm = pm
-
-    global mp_args
-    mp_args = args
-
-    with Pool(args.mp) as p:
+    # Use the 'initializer' to pass the unpickleable/shared objects
+    # to each worker process exactly once upon startup.
+    with Pool(
+        processes=args.mp,
+        initializer=__mp_init__,
+        initargs=(pm, args)
+    ) as p:
         pres = p.map(__mp_runner, batches)
 
     tsr = TestSuiteReport()
-- 
2.55.0

