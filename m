Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305D347FCD
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786274316; cv=none; b=lkv4RfBWoP8JVLwffF3g4FvcjhwxtfcwJ5s/XZh6AZTWvVtPJEetTt54C2RJfjYm+KpmPA8D2NEiSK0EN3RzlHfasBWf+mytNgYx2ci02ecpm4h3a+d/kffDid6F6UDeyVoVLd+XJwP5RfHDIUwVK1N0Byh+uurDYW1F0ki6UWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786274316; c=relaxed/simple;
	bh=+9ZjbX4UQFviH7Agoe1xwf+FTfMycR2CovtparGje7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJMgomjcrtRcLokSiFJ/olMtBWkoNLO2O5RJBlCu3cDUTzWEpx89RXcw6Vknoop4IrbtvhHS1NwFGDWcrCIv9Q2Cls96f1VENfPDSXo6+7Zcct3K9M1no4w9D6ZPN+P4KnZORpC9RQ1Ay/WLaeKCPJ5ybmb9/ZHyRSyayp2nuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Dg1Evw9s; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Dg1Evw9s"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so887704a91.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786274314; x=1786879114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjK25Df0SDLvqraZ1GZPGP7sM8hZJyuv8qAUSFjj/ss=;
        b=Dg1Evw9snn4gy5Oi14l9Gj1Dv/z8cHhKe77VXTav4lwCEbPZMCmco0eYfG2zl+3iLA
         rKPtQlu65QiSqSexQ03wqctmOVTU1KbFV2uUIyZXhsd922fLc3iD014rX/In6fIIT07b
         CnDpBKhITN8l0FfLwORCO7ZdJDPIvp+P2V1jSnq03t7A+/8tRvB/xPXkrmYRotINMVAi
         8y7jlJ8iYJjV50nMZZWEKR+wIk211rgNK9snnUfxm/eDX1BvHc0kH+0lb6m13gZyU4gx
         ffH+xa5ynENlIUjYtVSU7hZ7ljmr0O0k2YFUkj0V9dxpiClgP8LGBQtgysknIcup1jIk
         x/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786274314; x=1786879114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjK25Df0SDLvqraZ1GZPGP7sM8hZJyuv8qAUSFjj/ss=;
        b=hvGEYpG7nq2sckVEgiuWyds2ffFJX/OtLSnog1i3qdiB7+kJLMcVoYZvzVxV2UFbLv
         7kDyZQtZlfCobXuNBerocBUhLT+Z1J2Bv4EwabJjt8WyZrIZcoV1Fhp89LLIffBxcvuW
         rTv+fGdxOgAZVrat9D5PVqNzMofdo8pi66VY5fec8FEtmFEc7DRfHVoQW9o0h2I/hmeU
         QtudMX8eZpFlKk97s21i6dEybDWoNZgbghJCsKbqyp2okUCVLLmFL4DSr+iOkUlEfPMy
         TlK2ImhN0ubBK7Ln0TMEULZaD58fg64kDZ35vemJGTmTCmGFdc8UaDCKt9Q81AEl1Uco
         tdNw==
X-Forwarded-Encrypted: i=1; AHgh+RqnSux5rcuhU0OyV7JwNOKroaOod+fWbKyyNNyndW0aHmPTF9wZ9vt9Iqrt6jCu7NgY9f1yCss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMfyws4ZCcKFiVZ5SsjXjC1uq9T+rBgLAfyD7GmP/Q8mwrprv
	LezEmXEknHkegEK4pJQ/DKnldXgiu9M6b1FeLpwV0O8WDCs+di2s/CMvuE1rIipZPAk=
X-Gm-Gg: AR+sD10B2oKtDdEwNFv7RExA0V/DOHFrK9tqoDROtFPpAqB9xnBZYEEWFk+LsQvT9LY
	925Yxp0WNDzXNPZ490QdMTrVxD7HHSngcNFgZRFNu5U4f6/LAr13vFt7+N5l7wbaGzByO1R+i5P
	TmtMBagW40E3HhKpvHmKvIRTXPnqD5Dd1N6GBij6LV1CTQWA+/Vur6ot3SiOy1FQ5aiJA5mj5pC
	lrOqf5KTs1GrcxOprVAvdlFC+lQOTxNAmV6dCMamxnR5aySiktnTDlU8UQ4rPG1rygGwj672yjY
	H67f5O4J7iRj0SXVhC2fIqJGKiQdPM081Or3AAK+FR1J3CIxUrXUpU7G+OdrYdqeHSVHtk7MTgB
	VJ+yCkgzeVqwzFJytn3xQSljIK33ThEpW25KaKzYpEYswg0WXkx51dKStfrUile3PHWfJUQbeDy
	2wn1hRd2LPuyi7K8nemFq/eii0n+6nPNr0Etwtt9Y0os8rH1z8Vcw4Sb4rp4dSrI02UBQLD5U71
	OebKT6Q2UpLwnpV1PHa3dxuLJl7
X-Received: by 2002:a17:90b:4430:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-390b41acf2cmr11096291a91.4.1786274314360;
        Sun, 09 Aug 2026 04:18:34 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b136c67bsm4138321a91.0.2026.08.09.04.18.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 04:18:33 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vxlan: do not arm the ageing timer on a device that is down
Date: Sun,  9 Aug 2026 20:18:29 +0900
Message-ID: <20260809111829.78834-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_changelink() arms vxlan->age_timer whenever the requested ageing
interval differs from the configured one:

	if (conf.age_interval != vxlan->cfg.age_interval)
		mod_timer(&vxlan->age_timer, jiffies);

There is no netif_running() test, so the timer is armed even on a device
that was never brought up.  The only synchronous cancel in the driver is
the timer_delete_sync() in vxlan_stop(), which is .ndo_stop.
netif_close_many() drops devices without IFF_UP before
__dev_close_many() runs, so that cancel is skipped for such a device.

vxlan_setup() sets dev->needs_free_netdev = true and age_timer is a
member of struct vxlan_dev, so free_netdev() releases the allocation the
timer lives in while it is still queued on a timer_base.
expire_timers() unlinks the entry before it loads timer->function, so
the timer core writes through the freed object's list pointers:

  BUG: KASAN: slab-use-after-free in __run_timers+0x208/0x654
  Write of size 8 at addr ffff00001adace68 by task true/192
   __asan_store8+0x84/0xac
   __run_timers+0x208/0x654
   run_timer_softirq+0x154/0x18c
  Allocated by task 189:
   alloc_netdev_mqs+0x64/0x720
   rtnl_create_link+0x4ac/0x520
   rtnl_newlink+0x758/0xd00
  Freed by task 191:
   netdev_release+0x40/0x58
   netdev_run_todo+0x4a4/0x8c0
   rtnl_dellink+0x200/0x4e8

The rtnl operations involved are netns-scoped, so an unprivileged user
can perform them in a new user and network namespace.

Arming the timer on a down device never had an effect: vxlan_cleanup()
returns early on !netif_running(), and vxlan_open() arms the timer for
any non-zero interval once the device is brought up.  Add the missing
test.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 40051c4dcad5 ("vxlan: Allow changing ageing time")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1ded27768a97..824144bb7774 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4500,7 +4500,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
 		err = vxlan_multicast_leave(vxlan);
 
-	if (conf.age_interval != vxlan->cfg.age_interval)
+	if (netif_running(dev) && conf.age_interval != vxlan->cfg.age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
 	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
-- 
2.50.1 (Apple Git-155)
