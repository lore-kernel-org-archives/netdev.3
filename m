Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61D19046E
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204902; cv=none; b=V6z6paroL/XwnBsOer2Q5dYKrI1fdGrECSlfvaM6A1XETPEhx77eKyz4AFOtnowVNjR+HrxEDhbSP+PZDHgOgnbPvaPAt1Dj1d/3xVm3oPm0tAsZv6jaflP2Of2pmyAXxJFT78tutnUgjMIQ0WvIkMF0Z6z1PEPVghnbs2jtWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204902; c=relaxed/simple;
	bh=YSS1HTfnNODdPWKhpmedrDVsyXvI3FyYRwUdyz4pKaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VST6ByMaJ690Ls/lyOJJHogSEfz6qoU6K135gDa4lOUDPJvcbia1Y6x4NPkKVoeXr4sMLDk5vhXHGWp4pPPlMHM/ifeYgnUNI/6EDHPQ28GnQ7VT/XaI6dGgWuJbHStOfNXx/m3wIGKhFF+99bVv73ixQVMAswLRQHMbqPrZK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCh5Yfho; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCh5Yfho"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664b05d408bso355523d50.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786204900; x=1786809700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFNhVkSHPj0WeYBlfAdkcf6O8nFgALPC/v4fh/1/jzI=;
        b=rCh5YfhomlSs8AXuPMgLSmCC7WIZJztDtb5WtUTVp9Lxchy8eLgCOoOKVLjNBY5iY8
         mILwu1jHzPe5oYzXejY9sDcYLbm8EC/lwHCgPPtV+nhQakUsnjqmWzr85PAWQ/GqvU5H
         RY7/dRTmNm9DyPjelJo3q2g50vlXLlg/+mEZ73KE/yJRObQATv0/a1OSy8ihPSNApfhK
         /NDO9uUD06YUGFA5igz6kzdQjxQkRdDiHh/n68e+N6xvydVF5mZU0/vfgI+9vIiDZTqH
         Cj8bYdRaqG2OSSnCbEZc+QPepcutymm/o1VMmuK6YBmKZSCEtO+sC5bB1LmGXRZfCL55
         8XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204900; x=1786809700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFNhVkSHPj0WeYBlfAdkcf6O8nFgALPC/v4fh/1/jzI=;
        b=TO/FpD/vkmpRjPvFM06PYE6C1gdCQc1g31Do5R1OrrgnPRl6E2YvywEfbYsAYe1gy3
         t7pxyNtUTjUdhZRumENFLyEDdwOHZsAUtBrnsLa9xVHMMg+K5UMq4YqZPL9hAs3RInwG
         oPrFOPPbeqw7CsYtwzI05QuGOSyBKIR5rylQcOVgyvF8nKEkjqXQOrHqnS/+BG9SbBhl
         8p56ezfZ69gAPnrR07EyX8c1ALRoBTdO6kS1hPgAd8yZGE+HWZ0MJJ6A9MSMUxxhA6km
         nAUSQeD/uYMfIMHXnqNgxpUt1gDmLmRG9uNxwGjM46PVyG5iec71xTS3y4Gwk6PCU8Zd
         3Yrw==
X-Gm-Message-State: AOJu0YwxZWlZ5ZUDQPFxonW63h8pM3a+mQTy8USSFSehK2VeNS2KZnqK
	4nCF0gUSNAAENlNoHyR+AZ+GXka5tk5PdmxE/1X0ST1DnnYCt65905SlNBR/dg==
X-Gm-Gg: AR+sD12r0FNo+P2HQOkhOmuXEYScJBCbKTG97h1atxv7AJnwZfQh74A5DzHWETrls8J
	mUrSm3IEWB35eqyL2KtmUcXg+vqea6FnqvwcUfMv1o1UEQx22uGBkiKTOM7jdFhv/vbjt/RVOyM
	QRv7m0caPWYssnSkBqGznbcaUDpkgo8mB6IqDBT+RubriwWxowAx7KsWEtBBdT0dHtxbFFNp8nu
	YF8akYnBXS9xwURoOJcOK7NIESvgVJwuhxN1TVtL7YDFw2yUP2kYs/PvpX5SEtqszehlIEX/s+j
	MEjCAV+ncSmfzXK0MXzzOhGa105MnN+jtzUZXM3tamjHtOgjlHiL5uBiuY7zicVafBbRs9srwib
	mMr5m7yRrkeJUD4Jgii0lr8IlElI9OmuyumwraWWV72ooYhO/v+i/vPiTFMfmO7xdvz2/wokmQu
	S9hJ5zNDWnbwivQPMJJwbkEcSuVyHW3GvRXRmew9CdxzE4HR6gMuBExX++jeeYUjFsCMOOCM/SW
	O0z+UDDNPA6ixDALDa8tvsG+59AwmScp5t02x5GNErpzhAS9gFmaW9TBK+fHYoLgSFMfQ==
X-Received: by 2002:a05:690e:134f:b0:667:debe:494f with SMTP id 956f58d0204a3-66acd369af1mr7130854d50.44.1786204900320;
        Sat, 08 Aug 2026 09:01:40 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acad53674sm3270298d50.9.2026.08.08.09.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 09:01:39 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2] selftests: drv-net: so_txtime: only send test traffic to sch_etf
Date: Sat,  8 Aug 2026 12:00:44 -0400
Message-ID: <20260808160129.890119-1-willemdebruijn.kernel@gmail.com>
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

Changes
  v1 - > v2
    - redirect to net-next
      (address new conflict on ../selftests/drivers/net/config)
  v1: https://lore.kernel.org/netdev/20260806173702.3857148-1-willemdebruijn.kernel@gmail.com/
---
 tools/testing/selftests/drivers/net/config       |  2 ++
 tools/testing/selftests/drivers/net/so_txtime.py | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index f3933cf3e6be..b6989c7d3d9d 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -8,6 +8,7 @@ CONFIG_NET_ACT_SKBEDIT=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_MATCHALL=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
@@ -17,6 +18,7 @@ CONFIG_NETKIT=y
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

