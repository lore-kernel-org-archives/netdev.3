Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE52DF12F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172158; cv=none; b=rzt2+D5s/Rhw18WTW6NSlFRkY2Gkac+e1c63AEmtm19zzL3leE64FWlf9wkIcIGY301CxnvNVBDHZBvuwN5EipGYk+JToOWqYKrQni3HnP56I4/yE3Ot8KcQ6NEJRJr7v4as51Vbl7DGUeq4gWkGW5J3Wjuijv/RuMg7ZYzs6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172158; c=relaxed/simple;
	bh=GIiG/DEsVcHRAE6yV16BlliGlNeHr3fS5C/huYcjOCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1PXqy5YHzIkfMkCFd3DFFoswJzsiL0bdBZTgnnRUt34o2wnqzHYgIFVQ8tYXkIayeqyzyg/83lFIh1Tax7bTMDyW73D5YhosEvcsEDos9GHafLbEM0saOhVsuCNYGVevMAXbzcxcKx+/8L3zd95LKfFHMUcvvGnjJJuJMZDJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AF0B66051B; Wed, 19 Aug 2026 22:42:34 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net 1/4] selftests/tc-testing: pass mp_pm via initialiser
Date: Wed, 19 Aug 2026 22:42:07 +0200
Message-ID: <20260819204210.23722-2-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204210.23722-1-fw@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script doesn't work for me:
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

Assisted-by: ollama:gemma4:26b
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tools/testing/selftests/tc-testing/tdc.py | 27 ++++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 511d66c36a2a..19b8a1fd1c71 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -600,6 +600,18 @@ def mp_bins(alltests):
 
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
@@ -615,14 +627,13 @@ def test_runner_mp(pm, args, alltests):
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
2.54.0

