Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732785;
	b=z9mU4w0ZEjv2wDXzicPSDRgLvg1vXpOq8IR0E2nsbLjdJaNyrVwT5UhD9MiGB25fb/q7
	 xbW8gWifn/LDCsV6rbV4FGkWTwAcUQnBU38zeLxid5LZ733efF942JM0pt04/Y86WzD3T
	 ghk03WEqyo1q6jdfICLx0GQcVgF7jQDwz4ofl2ofOEWmdDr6zsINd5DkN9ZPjxYOPH3bJ
	 q/5YErYNqGIQvNkS5v8nztYEBjzsUwJIA85y2pyzw1T3c5gSk4yFT3y9XWuuLo/0YeRZk
	 fsFoGAJSiVg7XfOFKhLK3cAAXtILxpeJaqPNgPp1d+j6HniBj3VIbd0z5DRXW1bIp+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=w23UU4RsTFLW6CdOUkTXg7K9HL/THmO2wvldeMpkC24=;
	b=QvT0oymEZlaTO0J/YIGWKrvdxiLYNISFckKMuFayjGgLBHZzc0+obtKXRVjiu4dIEtff
	 lqp3GR5yS8MnxJNFqo6EIbkIStiEuWhoiBExAGR1CuV+I4OVaoO+iTfKe+fZIMHjg0RaL
	 6qXR3Lp7QUo4hBtTi9jInMV6v/zZBfOcbUrWQJdfHynFGJk4rdi8wRZOhM/Jf/KThgBOs
	 fPdT523ukWw/bglUHKG6nnGUkbuc1jQpzlrANvN16oLdy+vf3IC49DjKyEajL7E4vRsvG
	 kAjHZL8DtjFPgiEAhc/P5VNFPpTjExTqB8cl9wxgj71q798SYd4a317Uxkvk6SpOLAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nx18a8nQ;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF9606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50FF9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nx18a8nQ
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0dba37a7fso42405067b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732784; x=1794337584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w23UU4RsTFLW6CdOUkTXg7K9HL/THmO2wvldeMpkC24=;
        b=Nx18a8nQiMwMs0whFB3XiqKQVoU+9b0kTL0ooG+7p5lJx4Pj+a1usmKz2vrx+wH741
         D5f00YXix3ceT/19Hd7xovBA4j75Ga4vcB2qadiJwbvLTbBLvggqeYbtVN0ZzTPtupXe
         oAZWMi1hVLzej+PcPorqhEImi1hzwiN9qbIUZiOAp4HO45C8j93QQ1cIqs0x6yTAzht/
         WbffkwFeZvcfSCO8b4mAYInoLRkMs5u6opymKhncErmZtN4Khjl4RbrbnL8EHbVtDksV
         FQfje1tgVJ8Tzr1c2Vz4zC8oGGoHwGsCjBXTg3OVEmSDCNCZXRX79cxbLpHNXxY1BrRt
         rUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732784; x=1794337584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w23UU4RsTFLW6CdOUkTXg7K9HL/THmO2wvldeMpkC24=;
        b=H7Pk2GFrAxl7zWqNkaW1s0On88zuH06NFfI9FSm3mfZUSCMZ1kIYPeRUtX6tc5ZgZ0
         pQioB8GOK4/0EmkkfHquY0CnlqFEZxgA2mMkMsUgf9plaUXe9ULOEuLbArFUHxanglbZ
         /Q/B2tBRDQC8EYlYs0dznZfMh+JY8Yj5Mlj2ozu+7dw/bNgIeJZcnZWbrmJZa0phNock
         kQimCUoRD2a751gsnNbw6wgqr1FYUt4szSge7ElbGLRV/30r0+AiagKIh3mt4HE488Cl
         OW6p23A7U1YI5tYBa/Bo3BvViybqt8DA5E78qS8QjfHD6bppm+Wmpd6xwQdmELJ2YK5y
         tJzw==
X-Gm-Message-State: APuU4Z8HiV1MnRt7aAXWiqxoUOwFsqOvS/ic9VThWwpnbXNl+sxZVjWw
	RNp/gIgI6Tme4/+Aeyj4i3v4RT9Ype255BkA+GkI/ObHJTI/ZqlgPZ7d0xBumw==
X-Gm-Gg: AYBFou083duVwwHg2YHHQKN6Hvi07JfC0RbcmtY2fhqhFYnSNNkh2D5r1dNQXQ2c3qn
	OCm12TrObet9Hj33YAuM6KdlXVBoTPyzV2yUwbNnBjl/lSJdOdyZ7lHqgVFsx+oO6XJexCk2rlo
	pULyfLEFwjZNkYQFIV7l2zE7jcCHbSai4BFWdnJI20QOYP36hGvY9t4OMbK1JdUwZ01DjwOwNwV
	XXj9oNcvNH2tZa6Hrm/DbsAcb98/XKgRFAXugXnYe/BItRFcnN4DkDV6r1uSjhqUUd7aCr10Jsq
	yIxwYvTuK3gfSzecDmXmADDZmPWL2lOR4ETDvKvIsDqbSeS15xmm9qtsEQ2dmejqcBl1STVxJfL
	l9PBsophYmrQXJqawVYVFJDWi0zepQaNSjuL23JaioozGL9/rYT6NXgTAyH9cFFWDZDf33jcfza
	ruh3697bSNoEh4DXDdHQV16zVXSiH4j9QC+ZrKQfvifmvKdrWJfK+UQusqTITki2zkuyKYgB31p
	TxA63910bzmwRLs5hSBgw3Lh//NgbHRfMgJMNajyIOvsMmVdnKr/4FfJ172NR7km74bs6sJuci/
	tX2LgQ1eegnk4NPhFQv23M0/1OCE2CzpqdLY5aZ995wxGIIN8Q==
X-Received: by 2002:a05:690c:dd4:b0:8b0:a37a:b1d with SMTP id 00721157ae682-8b2b66fb17amr86527197b3.24.1793732784124;
        Tue, 03 Nov 2026 11:06:24 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:17::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b30997aa84sm3037217b3.29.2026.11.03.11.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:06:23 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com
Subject: [PATCH net v2] selftests: drv-net: pause: Avoid cleanup failures for unsupported link settings
Date: Tue,  3 Nov 2026 11:06:22 -0800
Message-ID: <20261103190622.3981970-1-mohsin.bashr@gmail.com>
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

pause_setup() saves the initial link settings and queues a deferred
restore. For devices that report forced link settings but do not support
changing link settings, this can queue a restore even when setup never
changes the link. On fbnic, the deferred restore returns EOPNOTSUPP and
turns pause tests that use pause_setup() into cleanup failures.

Fix this by queuing the forced-link restore only after setup successfully
enables link autonegotiation. Keep pause_test_support coverage for devices
that cannot change link settings by falling back to forced MAC pause on the
current link. Run the extra link autoneg on/off checks only when those link
setting requests are accepted.

Results on fbnic:

  Before: # Totals: pass:0 fail:4 xfail:0 xpass:0 skip:24 error:0
  After:  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:24 error:0

Fixes: cbd8a536cd6d ("selftests: drv-net: Introduce a selftest for ethtool flow control")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
v2:
- Drop the require_link_autoneg() approach from v1.
- Move the cleanup fix into pause_setup() so all pause tests avoid
  restoring unchanged forced-link settings.
- Keep pause_test_support() coverage on devices without link setting
  support by falling back to forced MAC pause on the current link.

v1: https://lore.kernel.org/netdev/20261030173516.1002250-1-mohsin.bashr@gmail.com
---
 .../testing/selftests/drivers/net/hw/pause.py | 40 +++++++++++--------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/pause.py b/tools/testing/selftests/drivers/net/hw/pause.py
index ca4a55e59c30..99ce6a59dfcd 100755
--- a/tools/testing/selftests/drivers/net/hw/pause.py
+++ b/tools/testing/selftests/drivers/net/hw/pause.py
@@ -404,14 +404,14 @@ def pause_setup(cfg):
 
     if link["auto-negotiation"]:
         defer(cmd, f"ethtool -s {cfg.ifname} autoneg on")
-    elif "speed" in link and "duplex" in link:
-        defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
-                   f"duplex {link['duplex'].lower()}")
 
     # Local interface admin up, link aneg on
     ip(f"link set {cfg.ifname} up")
     if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
         ethtool(f"-s {cfg.ifname} autoneg on")
+        if "speed" in link and "duplex" in link:
+            defer(cmd, f"ethtool -s {cfg.ifname} autoneg off speed {link['speed']} "
+                       f"duplex {link['duplex'].lower()}")
 
     # Get remote pause params
     ret, params = ethtool_ret(f"-a {cfg.remote_ifname}", host=cfg.remote)
@@ -429,15 +429,15 @@ def pause_setup(cfg):
     if link["auto-negotiation"]:
         defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg on",
               host=cfg.remote)
-    elif "speed" in link and "duplex" in link:
-        defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg off "
-                   f"speed {link['speed']} duplex {link['duplex'].lower()}",
-                   host=cfg.remote)
 
     # Remote interface admin up, link aneg on
     ip(f"link set {cfg.remote_ifname} up", host=cfg.remote)
     if link["supports-auto-negotiation"] and not link["auto-negotiation"]:
         ethtool(f"-s {cfg.remote_ifname} autoneg on", host=cfg.remote)
+        if "speed" in link and "duplex" in link:
+            defer(cmd, f"ethtool -s {cfg.remote_ifname} autoneg off "
+                       f"speed {link['speed']} duplex {link['duplex'].lower()}",
+                       host=cfg.remote)
 
     wait_for_link(cfg)
 
@@ -470,9 +470,12 @@ def pause_test_support(cfg, pauseparams):
 
     forced = forced_link_settings(cfg)
     _, supported = get_local_pause_supported(cfg)
+    tested = False
 
     # We check that what we can configure in the pause params matches what we
-    # support under various contditions : Link aneg on/off, pause aneg on/off
+    # support under various conditions: link aneg on/off, and pause aneg
+    # on/off. If no link configuration change is supported, fall back to
+    # checking forced MAC pause on the current link.
     ret, _ = ethtool_ret(f"-s {cfg.ifname} autoneg on", is_get = False)
     if ret != 0:
         ksft_pr("link autoneg on refused, not tested")
@@ -481,18 +484,21 @@ def pause_test_support(cfg, pauseparams):
                                "link autoneg on")
         expect_pauseparams_set(cfg, pauseparams, True, supported,
                                "link autoneg on")
+        tested = True
 
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
+            expect_pauseparams_set(cfg, pauseparams, False, supported, "link autoneg off")
+            expect_pauseparams_set(cfg, pauseparams, True, supported, "link autoneg off")
+            tested = True
+
+    if not tested:
+        expect_pauseparams_set(cfg, pauseparams, False, supported, "current link")
 
 @ksft_variants(pauseparams_variants)
 @ksft_disruptive
-- 
2.53.0-Meta

