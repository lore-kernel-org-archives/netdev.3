Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E03D4119
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770596; cv=none; b=mamzvF/Yg9mx/cg3XXXF2YxYGGrNSYAYppmWLt5u/VTtUVEaK/shntYBdv111CsvVAbmM3qqvaQb6eh3xcALqa7F+PJB9iZgatpFJXxG8a8AKMaYUcUFKz6OAiatDd7wGniBSYKDUU+7EwLCtTwTByXyUIPdS52C1i+1//JtUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770596; c=relaxed/simple;
	bh=92dQhlBzWQsewmwJcNk7DV+NQgbagynAnpL/bCd1URI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzgfE9hivhOI23R5tJ6gh30IeIQzOBfRsgfZ1/zsbxQUo/HUrgwf1kAiAlA2/Gnn8ichwvymSj/W/tbdiBuT/wlwfBNSo2heKIJ3/dNXTf+Q5xS4xJu5iq6mLuTXIexieNPJZkNJQA0W+B5mmk4L1AP16d+9/hXOV2Qx1Azujio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/kH6e6P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/kH6e6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1599A1F00898;
	Fri, 18 Sep 2026 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789770592;
	bh=LxVTvFAb+58oW39esFCfuZ3f5OW1us54GclQWcYhfDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/kH6e6PQfjJXEAKjy/xV1PCYxL04Y6OlAWMhBWr731P+gvlFMbwq3XfR+Uml4Qk1
	 FKFcF/PgmzO4trTsWijTT+KBEBA0XBQolmP4CLfdYeMGstyCtYvwvJT/g3wYRTiOcX
	 977ru9HvtcYG5QJDgpFD7iFjfs6AiRkNtJr4fOQVFHnX3zAVbZsEmFz5L7K/dJgQpn
	 g82fbD9jZuIbnHCbeXSnP0WwskcQkgDm1HavbTFQjy36sAyzqzdBblM8hWD2sutnt5
	 lPaEDn7mQltHcc8TF6jLUZfIKe5iaQiMbcftwQkevriOmroO5AS6sxx1lKVN4cxAZH
	 DRJHlzntOKETA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] selftests: net: nl_nlctrl: check the op ids in the policy map
Date: Fri, 18 Sep 2026 15:29:49 -0700
Message-ID: <20260918222949.4190284-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918222949.4190284-1-kuba@kernel.org>
References: <20260918222949.4190284-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that the op map in the policy dump is correct.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/nl_nlctrl.py | 116 +++++++++++++++++++----
 1 file changed, 99 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/nl_nlctrl.py b/tools/testing/selftests/net/nl_nlctrl.py
index fe1f66dc9435..237b3d273260 100755
--- a/tools/testing/selftests/net/nl_nlctrl.py
+++ b/tools/testing/selftests/net/nl_nlctrl.py
@@ -9,40 +9,86 @@ from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, ksft_ge, ksft_true, ksft_in, ksft_not_in
 from lib.py import NetdevFamily, EthtoolFamily, NlctrlFamily
 
+# Families we can expect to always be around, and which between them
+# cover ops with a do, with a dump, and with both.
+FAMILIES = ('nlctrl', 'netdev')
 
-def getfamily_do(ctrl) -> None:
-    """Query a single family by name and validate its ops."""
-    fam = ctrl.getfamily({'family-name': 'netdev'})
-    ksft_eq(fam['family-name'], 'netdev')
+
+def _get_ops(ctrl, name):
+    """Get the ops of a family, keyed by command id."""
+    fam = ctrl.getfamily({'family-name': name})
+    ksft_eq(fam['family-name'], name)
     ksft_true(fam['family-id'] > 0)
 
     # The format of ops is quite odd, [{$idx: {"id"...}}, {$idx: {"id"...}}]
     # Discard the indices and re-key by command id.
     ops_by_id = {v['id']: v for op in fam['ops'] for v in op.values()}
-    ksft_eq(len(ops_by_id), len(fam['ops']))
+    ksft_eq(len(ops_by_id), len(fam['ops']),
+            comment=f"{name} lists a command twice")
+    return ops_by_id
 
-    # All ops should have a policy (either do or dump has one)
-    for op in ops_by_id.values():
-        ksft_in('cmd-cap-haspol', op['flags'],
-                comment=f"op {op['id']} missing haspol")
+
+def _get_policy_map(ctrl, req):
+    """
+    The policy map in the Netlink replies looks like this:
+
+         [{'family-id': 16, 'op-policy': {'do': 0, 'dump': 0, 'op-id': 3}},
+          {'family-id': 16, 'op-policy': {'dump': 1, 'op-id': 4}}, ...]
+
+    Return the mapping:
+
+         {3:{'do','dump'}, 4:{'dump'}}
+
+    The policy itself is discarded here, only return which command has policy.
+    """
+    pol_map = {}
+    for msg in ctrl.getpolicy(req, dump=True):
+        if 'op-policy' not in msg:
+            continue
+        modes = dict(msg['op-policy'])
+        cmd = modes.pop('op-id')
+        ksft_not_in(cmd, pol_map, comment=f"command {cmd} reported twice")
+        pol_map[cmd] = set(modes.keys())
+    return pol_map
+
+
+def getfamily_do(ctrl) -> None:
+    """Query single families by name and validate their ops."""
+    ops = {name: _get_ops(ctrl, name) for name in FAMILIES}
+
+    for name, ops_by_id in ops.items():
+        for op in ops_by_id.values():
+            # All ops in nlctrl and netdev have a policy
+            ksft_in('cmd-cap-haspol', op['flags'],
+                    comment=f"{name} op {op['id']} missing haspol")
+            ksft_true(op['flags'] & {'cmd-cap-do', 'cmd-cap-dump'},
+                      comment=f"{name} op {op['id']} has no handler")
+
+    # nlctrl getfamily (id 3) does both, getpolicy (id 10) is dump-only
+    ksft_in('cmd-cap-do', ops['nlctrl'][3]['flags'])
+    ksft_in('cmd-cap-dump', ops['nlctrl'][3]['flags'])
+    ksft_not_in('cmd-cap-do', ops['nlctrl'][10]['flags'])
+    ksft_in('cmd-cap-dump', ops['nlctrl'][10]['flags'])
+
+    netdev = ops['netdev']
 
     # dev-get (id 1) should support both do and dump
-    ksft_in('cmd-cap-do', ops_by_id[1]['flags'])
-    ksft_in('cmd-cap-dump', ops_by_id[1]['flags'])
+    ksft_in('cmd-cap-do', netdev[1]['flags'])
+    ksft_in('cmd-cap-dump', netdev[1]['flags'])
 
     # qstats-get (id 12) is dump-only
-    ksft_not_in('cmd-cap-do', ops_by_id[12]['flags'])
-    ksft_in('cmd-cap-dump', ops_by_id[12]['flags'])
+    ksft_not_in('cmd-cap-do', netdev[12]['flags'])
+    ksft_in('cmd-cap-dump', netdev[12]['flags'])
 
     # napi-set (id 14) is do-only and requires admin
-    ksft_in('cmd-cap-do', ops_by_id[14]['flags'])
-    ksft_not_in('cmd-cap-dump', ops_by_id[14]['flags'])
-    ksft_in('admin-perm', ops_by_id[14]['flags'])
+    ksft_in('cmd-cap-do', netdev[14]['flags'])
+    ksft_not_in('cmd-cap-dump', netdev[14]['flags'])
+    ksft_in('admin-perm', netdev[14]['flags'])
 
     # Notification-only commands (dev-add/del/change-ntf etc.) must
     # not appear in the ops list since they have no do/dump handlers.
     for ntf_id in [2, 3, 4, 6, 7, 8]:
-        ksft_not_in(ntf_id, ops_by_id,
+        ksft_not_in(ntf_id, netdev,
                     comment=f"ntf-only cmd {ntf_id} should not be in ops")
 
 
@@ -103,6 +149,41 @@ from lib.py import NetdevFamily, EthtoolFamily, NlctrlFamily
             comment="linkinfo-set should not have a dump policy")
 
 
+def getpolicy_op_map(ctrl) -> None:
+    """Check the op-to-policy map consistency. Each op with 'haspol' flag
+    has to have a policy. The policy back-references must name only
+    real ops that exist, have given modes (do vs dump) and have 'haspol'.
+    """
+    for name in FAMILIES:
+        ops_by_id = _get_ops(ctrl, name)
+        haspol = {cmd for cmd, op in ops_by_id.items()
+                  if 'cmd-cap-haspol' in op['flags']}
+
+        pol_map = _get_policy_map(ctrl, {'family-name': name})
+        ksft_eq(set(pol_map), haspol,
+                comment=f"{name} policy map does not match the op list")
+
+        # Walk the op list rather than the map, the map may be missing
+        # the very op we are after. Asking for a command the family does
+        # not have is an error, so it must not come from the map either.
+        for cmd in sorted(haspol):
+            modes = pol_map.get(cmd, set())
+
+            # The kernel only reports a mode the op actually has.
+            if 'do' in modes:
+                ksft_in('cmd-cap-do', ops_by_id[cmd]['flags'],
+                        comment=f"{name} cmd {cmd} has no do")
+            if 'dump' in modes:
+                ksft_in('cmd-cap-dump', ops_by_id[cmd]['flags'],
+                        comment=f"{name} cmd {cmd} has no dump")
+
+            # Asking for one op builds the map in a different place in
+            # the kernel, it has to report what the full dump did.
+            single = _get_policy_map(ctrl, {'family-name': name, 'op': cmd})
+            ksft_eq(single, {cmd: modes},
+                    comment=f"{name} cmd {cmd} policy differs from the dump")
+
+
 def getpolicy_by_op(_ctrl) -> None:
     """Query policy for specific ops, check attr names are resolved."""
     ndev = NetdevFamily()
@@ -122,6 +203,7 @@ from lib.py import NetdevFamily, EthtoolFamily, NlctrlFamily
     ksft_run([getfamily_do,
               getfamily_dump,
               getpolicy_dump,
+              getpolicy_op_map,
               getpolicy_by_op],
              args=(ctrl, ))
     ksft_exit()
-- 
2.55.0

