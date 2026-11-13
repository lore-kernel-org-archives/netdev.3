Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536841;
	b=pQdVOKenVMkbMTMgGi/8VYKhORYiZPkEr8C/qaBVASlAfPIo/+40dyrdLQ8Y+ZHfs2Wv
	 1NKX2iBoBcN3C16cRwx59QOus/yiQbP4bGa3+c7sEN9Nv1oBU02RIXg6Hb5lR6skWDcZg
	 U+gHORilya8jSYPh3NrTFEkquU4vIhd15GJyoXwAHQk0hcm70QGC2a0w39zaPXRE/zPkv
	 oUJTFvFAojJmaMreQazkGY20P+3Djwhb4qqgmVZ5TDyxa8m/QY0QHgzJKL1UY9m3Lk83K
	 i943ebAqauKsR7J/GFYz7/ILk3BIdv5C3LIF+jYjoDn59mEk7nktI74nPNPGjIFLpcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dZCnN3zUSocYlZp/Mqt53uqs96/J8YMxA7iHx75dj9o=;
	b=N7dUqFQA40m36x9L40Ytjg7HSb0CibrvdRZU3vD28UE7npvO0OacUGG7NizJPM+EzVsx
	 BDVU4sGUUg9I7FfgDBHnHJ0HeEL/zvLtJgHN56rrNkO9q4GYow+Vugf0JCJ+iZ+ZQfZwN
	 TcOJwCxWO3Mm3fbcZkM9wJ+pGIbKWyu2Zfa4e4hEO+GDwayQqF7LM6mv0svDPBBZZSTi0
	 HKqpICgbg8GiuqQx4w5Q49sw/CMFIEsvI2jwIcav/oDYOwttWzkTw/h8/T3909nXa7Lxe
	 eJDWpZmwYo3UNXGtrOlCFEwFPMqX2oNAtizvhEMd3R6obTfwkAAt/5kQhSM286dXYbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKXLLfrH;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF9606A881
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DACF9606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKXLLfrH
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b3b57a31f7so4643657b3.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794536840; x=1795141640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZCnN3zUSocYlZp/Mqt53uqs96/J8YMxA7iHx75dj9o=;
        b=XKXLLfrHn1TvqoodREmJNONu5R98SSd6i+jsBxzTjl9MCQtryB7SKaWQ6KFrKzx/MW
         XFPBHM5fLPAZJPogD7IvWK/mQcWt0FywrVqOB1XbYlrJEuZUmV+SyQoKWqueFr0aAvKX
         As1v8X4oOkv/mTKmJDYKQsjB8iMWzlHThEBJGZKOS3+AFBXCU4N3K9fJP0X6rGUQna3j
         dgi4ngztdE8J9s3h+EU6ZDCCayree71DSEcTkuMd1BL5j+oHLf4BHYIv8SOVg2Hzt1E5
         UMzfD9D5wY96HBHs25b8SOVh4KNtFG6MHvk0NpeLZ/DyBu+AUwgfo33oH8b2k/f2BLQG
         BmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794536840; x=1795141640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZCnN3zUSocYlZp/Mqt53uqs96/J8YMxA7iHx75dj9o=;
        b=rZHFbE4zNEd7OaHONQLqbkY8gys4djTPsfzieA/GOmB0dL/U8Pna3ZAYvloRRtDEvF
         YfaKGLKX6uux7cU9xG82SIDPxRN9AQS0AxfJiYHwz1e3+aPhI9ZXUw7cIPjUEb6IIwxW
         vza06cfbwa4pudPSrBPNc4ndhNhSuKao2Pf2zwTZlWMdQb7VGjmxn2S/QNf51Q7uGwIc
         REKlPf7df6wDQFf3MWTrLZMb/QOTPB7k7J6wzAoyXfHCpR/Db4EY5bc0jh98iAMGJILh
         oPCeorJXOujM2DKuksTklakXG+l9gHWxNjA39rXMixo1shkmvWzTZH/d8dXZWOwhsYa7
         ZlJA==
X-Gm-Message-State: APuU4Z+9PB/V33B9RoQuH+YpqRDHbRMOy2LD1eZr8TwjAK28+a8oMxZG
	74gvn7yeUUL4+ISj4Kr0K4zxs6Lw8TixX5zRRkE1ITrz3mm3yTa1QTn7lzLIPFNP
X-Gm-Gg: AYBFou1vBhR+bahKqMfLkHLr3XdLisGpcHd/oPjc915dhg13tRXcTc+m1xZmDTAsa+b
	q4Go1d3p76HYPmG9eBP8kzHIaTU129Riz40ShTZXITl6DfTv3n6CbBbwyVFn/dKhzAhthipH1ze
	cWbasradidWOZEwSO4c7tO6PBlKUOgRRptHAXF6bSPjtMfB0FJ7NvP8N1x33oY1XFGneMKdVZjr
	ALGzhGKwM5xSMQpbLXKcpucjuOen1YQBdMOLJMYAMwIdq9IHYQcsbSU7gdyogXwW9X/rCnXoJcW
	gKIHyKT5dNB+34RUGvViGZVEpgfk7XOHd1nibsiSaOXjuZhN++/MD5aVQwfh3Of+nuhwPQcFj52
	LdawTpM0exPXI2Oiya8xRb5MUty7Q1oGTBMmgf9Xu0yKLrNttWTNxaetmX3MA4TWfUI6Pv/xRZS
	JM1CUkMTFTdx51jajkLjqv3yTAhqe5S0J56PjE/2CjaD9ILESRHvTwqzbxr3x/uo3DgoUnSRLta
	rJqtAuktZ/24zuR7jIeEzvu99atEgZ8BhuK0NEUDAxI5CTUwxx88liEowcuzMQdWMrH+kCqmuTk
	OXm/QERyELNWdn61z4sRFC/y8Fs=
X-Received: by 2002:a05:690c:399:b0:8b1:3707:86a7 with SMTP id 00721157ae682-8b4aa2dd736mr8776587b3.83.1794536839855;
        Thu, 12 Nov 2026 18:27:19 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:34::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa8f3286sm10637027b3.15.2026.11.12.18.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:27:19 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com,
	linux-kselftest@vger.kernel.org,
	hmohsin@meta.com
Subject: [PATCH net v3] selftests: drv-net: pause: Avoid cleanup failures for unsupported link settings
Date: Thu, 12 Nov 2026 18:27:17 -0800
Message-ID: <20261113022717.1914724-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <hmohsin@meta.com>

pause_setup() saves the initial link settings before tests run. Devices
that report link settings but do not support changing them can reject even
a no-op restore with EOPNOTSUPP. That turns pause tests that use
pause_setup() into cleanup failures.

Fix this by queuing link-setting restores only after a link-setting
request has succeeded. Keep pause_test_support coverage for devices that
cannot change link settings by falling back to forced MAC pause on the
current link. Run the extra link autoneg on/off checks only when those
link setting requests are accepted. Tests that force link autoneg off,
including pause_autoneg_link_autoneg(), now queue their own autoneg-on
restore after the force request succeeds.

Results on fbnic:

  Before: # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:24 error:0
  After:  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:24 error:0

Fixes: cbd8a536cd6d ("selftests: drv-net: Introduce a selftest for ethtool flow control")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Changelog:
v3:
- Drop the remaining unconditional autoneg-on restore from pause_setup()
  and only queue link-setting restores after a link-setting request succeeds.
- Since pause_setup() no longer restores autoneg on, make pause_test_support()
  and pause_autoneg_link_autoneg() queue their own autoneg-on restores after
  they successfully force the link.

v2: https://lore.kernel.org/netdev/20261103190622.3981970-1-mohsin.bashr@gmail.com
v1: https://lore.kernel.org/netdev/20261030173516.1002250-1-mohsin.bashr@gmail.com
---
 .../testing/selftests/drivers/net/hw/pause.py | 56 ++++++++++---------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index ca4a55e59c30..c3398c7452e0 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -402,16 +402,13 @@ def pause_setup(cfg):
     if "auto-negotiation" not in link:
         raise KsftSkipEx(f"{cfg.ifname} doesn't report its link modes")
 
-    if link["auto-negotiation"]:
-        defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")
-    elif "speed" in link and "duplex" in link:
-        defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
-                   f"duplex {link['duplex'].lower()}")
-
     # Local interface admin up, link aneg on
     ip(f"link set {cfg.ifname} up")
     if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
         ethtool(f"-s {cfg.ifname} autoneg on")
+        if "speed" in link and "duplex" in link:
+            defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
+                       f"duplex {link['duplex'].lower()}")
 
     # Get remote pause params
     ret, params = ethtool_ret(f"-a {cfg.remote_ifname}", host=cfg.remote)
@@ -426,18 +423,14 @@ def pause_setup(cfg):
     if "auto-negotiation" not in link:
         raise KsftSkipEx(f"{cfg.remote_ifname} doesn't report its link modes")
 
-    if link["auto-negotiation"]:
-        defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg on",
-              host=cfg.remote)
-    elif "speed" in link and "duplex" in link:
-        defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg off "
-                   f"speed {link['speed']} duplex {link['duplex'].lower()}",
-                   host=cfg.remote)
-
     # Remote interface admin up, link aneg on
     ip(f"link set {cfg.remote_ifname} up", host=cfg.remote)
     if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
         ethtool(f"-s {cfg.remote_ifname} autoneg on", host=cfg.remote)
+        if "speed" in link and "duplex" in link:
+            defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg off "
+                       f"speed {link['speed']} duplex {link['duplex'].lower()}",
+                       host=cfg.remote)
 
     wait_for_link(cfg)
 
@@ -470,9 +463,12 @@ def pause_test_support(cfg, pauseparams):
 
     forced = forced_link_settings(cfg)
     _, supported = get_local_pause_supported(cfg)
+    link_config_tested = False
 
     # We check that what we can configure in the pause params matches what we
-    # support under various contditions : Link aneg on/off, pause aneg on/off
+    # support under various conditions: link aneg on/off, and pause aneg
+    # on/off. If no link configuration change is supported, fall back to
+    # checking forced MAC pause on the current link.
     ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg on", is_get = False)
     if ret != 0:
         ksft_pr("link autoneg on refused, not tested")
@@ -481,18 +477,23 @@ def pause_test_support(cfg, pauseparams):
                                "link autoneg on")
         expect_pauseparams_set(cfg, pauseparams, True, supported,
                                "link autoneg on")
+        link_config_tested = True
 
     if not forced:
         ksft_pr("link speed unknown, the forced link is not tested")
-        return
-
-    ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}", is_get = False)
-    if ret != 0:
-        ksft_pr(f"link autoneg off {forced} refused, not tested")
-        return
-
-    expect_pauseparams_set(cfg, pauseparams, False, supported, "link autoneg off")
-    expect_pauseparams_set(cfg, pauseparams, True, supported, "link autoneg off")
+    else:
+        ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}", is_get = False)
+        if ret != 0:
+            ksft_pr(f"link autoneg off {forced} refused, not tested")
+        else:
+            if link_config_tested:
+                defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")
+            expect_pauseparams_set(cfg, pauseparams, False, supported, "link autoneg off")
+            expect_pauseparams_set(cfg, pauseparams, True, supported, "link autoneg off")
+            link_config_tested = True
+
+    if not link_config_tested:
+        expect_pauseparams_set(cfg, pauseparams, False, supported, "current link")
 
 @ksft_variants(pauseparams_variants)
 @ksft_disruptive
@@ -902,11 +903,14 @@ def pause_autoneg_link_autoneg(cfg):
                          is_get=False, host=cfg.remote)
     if ret != 0:
         raise KsftSkipEx(f"Can't force the peer's link at {forced}")
+    remote_restore = defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg on",
+                           host=cfg.remote)
 
     ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg off {forced}",
                          is_get=False)
     if ret != 0:
         raise KsftSkipEx(f"Can't force the link at {forced}")
+    local_restore = defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")
 
     try:
         wait_for_aneg(cfg)
@@ -917,8 +921,8 @@ def pause_autoneg_link_autoneg(cfg):
     check_local_pauseparams(cfg, True, rx, tx)
 
     # Re-enable autoneg
-    ethtool(f"-s {cfg.remote_ifname} autoneg on", host=cfg.remote)
-    ethtool(f"-s {cfg.ifname} autoneg on")
+    remote_restore.exec()
+    local_restore.exec()
     wait_for_aneg(cfg)
 
     # Pause autoneg must still be on
-- 
2.53.0-Meta

