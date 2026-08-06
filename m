Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F8388E68
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037832; cv=none; b=WODusJunIXpl/vvNES1dqXc8nesQ31jwi94HZGJXC6MWL8pm50dggjG+pbDLn2rdP/9yIJVj4jqvWuBSFHbOek8UQXCqCXNnkVe2yswUCaBl/c9ymchyrZYE9OY2ENoWGbwLjZDVw6pcPwX+mFmYuMGzQHSq0wb4HHswOScD1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037832; c=relaxed/simple;
	bh=733+q3oLiMF4NUXP+xDaqRaTNCdZIqlu98u1eSIGdgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oevGvYZ+WsyjcvbVzrEncEv64dOcbOZ+qqWXrXmTjlPli7Hjixkz6lCOweipN9Ju9mM/8/BlmZ0Eqpbqvr10NUTad7j3ejJp51u9PVfzYvRJYUUD8ITktXUZhYVplMiY1wH1y11jL2m16Rdib4wKwb3Q9d1xn2R+9CKxNC88Sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYk8LfKm; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYk8LfKm"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dbcb505578so24168477b3.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786037829; x=1786642629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TZ868jygsgrf8t5w6NxHRJN5ScT5SxHgCIbdDERj1Qo=;
        b=WYk8LfKmDv+i0f2DauED6w0mbUm/Td71jNyHmjFg7+WYtEcxepMGJCZDJzXV7lNe9d
         oAZm5YzI3b5Dn80P+VFmU8+N8rrGxx+3Rseazvm5zp8QAbAn+RNycNs9vaECLXt+9CiQ
         EdZlOeIcjS9dtaer2NbC3uZCUXk82JjvrmOzSa4bZRqsmBv0uXf3rHJjkTWQQlDLI0F/
         0oASPn3OmLq1mLRYla1tBe5Kuf56JOoSfrLDRp4B7N0HURlrFk2PjUwU/liv4q6DxW7c
         tQJyrm68gP2OMFc4Ac5liog4pDnt5mIQASeav5A6gxD+N7Y46LEfGYMW4b/UfMSYhHVa
         JU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786037829; x=1786642629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZ868jygsgrf8t5w6NxHRJN5ScT5SxHgCIbdDERj1Qo=;
        b=PE3tmvGjobrc+zT9GaooHEgQca7V0qssGbnciZ0/HreiOxOispFSXj7tZXnBD/LYur
         nvD/G0994Lp8s0VYq3EB3qi/CP4fnvwYHkyQ26RtcLKlA6s5f5v6OBwx9U4hKaUNueH7
         IFh+H1LCraPyp9ps79NiyAB1IsXhqxHCCbyORN+qE09Git2JQukggUQ9SWHNuCcRSPnY
         iefKSkDpZ+InEymdquvpKsupPzYvxlAe6iOTW5WvkElVcX+qJXKlewLTRmMF7qTSVd2m
         fFQMOPJaUk3r938fz9nrhh95jxZr/1fKIhSQwtLKcIox/7QPea00B/zBkHdS2kfwaU6X
         ctZg==
X-Gm-Message-State: AOJu0Yzshv5oSMePLrogknk4V9y3bGlRmJqaZF0aYAcMCPg0vG7AKhE1
	pW7o5i9Hgl9v9UKQQ5leuBQI3ZXtI/o+ZuJ4X6EYPMYNAOwB34Sc+a7sWSzq7w==
X-Gm-Gg: AR+sD13W7PHP5FYG8t9nF2bMFPW4SYXGBl2l1P2dlK1a1m7WInXC5/ZHGbnU0P7wG18
	sseMMBLTqom6Y58ux/YOy5nuBt5OowP1QPmVkR641aW2Omo8RCaRsOGHjnFXmMgRHCilOs5GoEu
	wOQZfTwO/UtTbuiOZhi3rz88TwCNaB9Cy73onOBhutFOJ63t04LfjCMFqRJKyn097jz+VRY87C8
	j2kxgnUE8BKZvzo23RxBtU7mZdo2n/BqZVyGi6wnFZ+tFiYLhBWgjys6cECw7Kxq7L506+De2PZ
	efLrE5RwHZSaC2CmcCMPeJ6eNUuyKWZxo3tSEGe3Sq2KOgQ5I3oqrp40095HPyLM0BEIChqWp3u
	UGaKZvd/XJhn/h0oCfd5bh0jQE7RKLi5pksBPG/RWC83XQEwtZKenOfWJfSd97xU1qSDrDx3f0E
	Qj8sdseIfIv8z0aWrq6FAXG96P60BqHY8creqz7sInHfaDuT2P6XFG1HtxZGH/BKX5Cb/ZUsYJm
	nejHdkrR3v7QL78QMV2PF/euL3z7uGaN+YLwKLtzvyeUpat3Tq2dkecpGLH7SJrA8FekYk=
X-Received: by 2002:a05:690c:338a:b0:81d:4f4b:94be with SMTP id 00721157ae682-8202b070533mr103676217b3.32.1786037829297;
        Thu, 06 Aug 2026 10:37:09 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201447eb4fsm41608107b3.36.2026.08.06.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:37:08 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] selftests: drv-net: so_txtime: only send test traffic to sch_etf
Date: Thu,  6 Aug 2026 13:36:57 -0400
Message-ID: <20260806173702.3857148-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The ETF qdiscs drops traffic without a socket or txtime. Even with
parameter skip_sock_check regular traffic is affected by ETF.

This test ran fine when run manually in a pure software environment.
But with drv-net across two hosts tests fail as early as when calling
cfg.remote.deploy due to effectively losing connectivity.

Isolate the intended test traffic:
- mark that with SO_MARK 100
- install a regular permissive root prio qdisc for background traffic
- install the ETF qdisc as leaf
- install a filter that only directs SO_MARK 100 traffic to this leaf

Technically other high prio traffic will map onto this leaf based on
ToS band mapping too. But that is immaterial in practice.

Fixes: 5c6baef3885c ("selftests: drv-net: convert so_txtime to drv-net")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/drivers/net/config       |  2 ++
 tools/testing/selftests/drivers/net/so_txtime.py | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 2070e890e064..de7af08a188d 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -6,6 +6,7 @@ CONFIG_IPV6=y
 CONFIG_MACSEC=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
+CONFIG_NET_CLS_FW=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
@@ -14,6 +15,7 @@ CONFIG_NETKIT=y
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_NET_SCH_PRIO=m
 CONFIG_PPP=y
 CONFIG_PPPOE=y
 CONFIG_VLAN_8021Q=m
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index adf6c848d6d8..9fbc0278d28b 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -27,7 +27,7 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     cmd_addr = f"-S {cfg.addr_v[ipver]} -D {cfg.remote_addr_v[ipver]}"
     cmd_args = f"-{ipver} -c {clockid} -t {tstart} {cmd_addr}"
     cmd_rx = f"{cfg.bin_remote} {cmd_args} {args_rx} -r"
-    cmd_tx = f"{cfg.bin_local} {cmd_args} {args_tx}"
+    cmd_tx = f"{cfg.bin_local} -m 100 {cmd_args} {args_tx}"
 
     expect_fail = not expect_success
     if slow_machine:
@@ -45,7 +45,7 @@ def _qdisc_setup(ifname, qdisc, optargs=""):
     """
     orig = tc(f"qdisc show dev {ifname} root", json=True)[0].get("kind", None)
     defer(tc, f"qdisc replace dev {ifname} root {orig}")
-    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
+    tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")
 
 
 def _test_variants_fq():
@@ -96,11 +96,21 @@ def _test_variants_etf():
 def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
     """Run all variants of etf tests."""
     cfg.require_ipver(ipver)
+
+    # root qdisc for background traffic (e.g., bkg())
+    _qdisc_setup(cfg.ifname, "prio")
+
+    # leaf ETF qdisc only for intended packets
     try:
-        _qdisc_setup(cfg.ifname, "etf", "clockid CLOCK_TAI delta 400000")
+        etf_args = "clockid CLOCK_TAI delta 400000"
+        tc(f"qdisc add dev {cfg.ifname} parent 1:1 handle 10: etf {etf_args}")
     except Exception as e:
         raise KsftSkipEx("tc does not support qdisc etf. skipping") from e
 
+    # redirect mark 100 to leaf
+    filter_args = "protocol all handle 100 fw flowid 1:1"
+    tc(f"filter add dev {cfg.ifname} parent 1: {filter_args}")
+
     test_so_txtime(cfg, "tai", ipver, args_tx, args_rx, expect_fail)
 
 
-- 
2.55.0.679.g6767b8d81c-goog

