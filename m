Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874149;
	b=Kp0pOi7/3ZmrcbKfBroZ3PXdRsW3SnrxsbB+UVkL+dJqOx4asx6LuTTSUvR5g/tvTEqi
	 clYxWo2pQ0HgRNCXksSgwsf95VT54S8+rMezKHcVSb+vQISGaK2BRMVd3HbKju0/l7bWj
	 i7Jq0SjEf+1maFIoupSJmDhh6jf8o/5io9NH/98TU8oyO5wkQDAcCy5GjpnDvlxsng5i/
	 W1u1D/rFQR/Xet5/AjW8aqdo+xAj1dHKniD4NomTORG5epOHPFhFRxicOFKVuJY2LO72o
	 LydhJF9ZuxORBx7pliw/hQIzxIR7XGYlvNhH/CPbHG7nAVsjcyD8/wSoouvkBfQJx3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GviQEbFMwY68Ziac/hb3JGL9kjJMsGNGVNwYWCldSbc=;
	b=5cVZKBjdsUQVin+MIlFKahFj2cmhZiUAJgIIlrGWHjz7xZKvwjexbKycD3WmuRscWI63
	 fgrakWdQMMk2arZLbw/BLsQGPSdUQ+1eHH4eNZqAZhk5UYk/dnKA+nYWNgkKT/VSM+M5Y
	 qaIno8zRvF32ifaTn8prZ3msrFbpA+SvxXb7n5KOSbqa5vF+0fowo/t3eTHT3Crqa3udA
	 KnU5veF23GHFtr/nCNjFjP7JlNa6ySqakeJVFqr5itUbQpILnkReMgYJJj5OlOdcEFLJZ
	 9XX5X6Xl7fb/FiKNgjIbM5h7/M5VDs7HhKRGcW5rckWiziX4AiWzntt9i9iCdMMT0+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L9zLPvU5;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E3606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B16E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L9zLPvU5
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso17573635e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793874147; x=1794478947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GviQEbFMwY68Ziac/hb3JGL9kjJMsGNGVNwYWCldSbc=;
        b=L9zLPvU5z58OWYeVISNo/+P4pew1dXj7Wjve3TYuQBD+xhgwrkM6Le22V23iH0hIK6
         d3nJeJDJuhk2MncGXTCz1rGyU6BDH1tWoyWIDuv8gGxh28i021ZEOffQ2SDkp023gVIJ
         4pPyLdQLnyyBx/ni33eA2A9e3ngxQM6q5JHtDBZoGOZhGsWt/IIuj0rAGojp9tf1/Ek6
         OAT6aZAG5utFIDaXaxm7f/tfr+bihxhUdI8OQSVEaV9sd43LlRwGfa34uDrDBuAOc/xJ
         WX73HGEZCW1SjnzTVFHzSv8z+vN3kbzLUNg/FdKgxS+//1HRuY9xZr71WhzRJqoVhOfr
         1nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874147; x=1794478947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GviQEbFMwY68Ziac/hb3JGL9kjJMsGNGVNwYWCldSbc=;
        b=rMej8gSl61prsn2klWM5DjvHrCy5mlPoZUkHKNkRFVENibh62GhKYW6249XEopvfD/
         PR9VJqCRVAZzT8ZDX7/yKUb6qIyVr1fpx7c2B0QOj1KCM/LVgD/K1HppfqumJcgXAp95
         MjucKJlqfd49XRAHAtLbJt1FKBOtzVzSiRNzndI3fhJ5bFUJdAnR68hBJNsZjym/9kbC
         ocjsdTpTcqArAJMU8Ii3c98EALZx6StfOeZQmX9qnsc3b2HDH7APY+8z/jhnBnGq0GOO
         Y9vcQg8KLxxhOI5y8gPyckMsrRWAOJHk4saWes3XyfNy3J2d3bO71P50Ti2PGTOaYBMW
         DZ1A==
X-Forwarded-Encrypted: i=1; AKwUvBzjBs082yuT88P5jxpkzZwG7kaCaWHL7/pygtt7DJt+eIodMUN18Thfx7+SDYP8LoicsjBIvVg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8v0WVNjtHqk2hLS1Hz8J9UhAIicouMDgxEnk7LtYC/A0s9h+yk
	bC5HpAwtDSxpGByR56N3mPdg5MatloLnOxf9khbtGg3dANXGp9dELWaQ
X-Gm-Gg: AYBFou0kWgHx/HiDVMEsy3yQ+BL8eDzffryeRM5Nm82XlmJqrQYYufT7t9yVpB3+Cpp
	AcR5tx9onx4KIqlHs3K9d47nzRASS+TnVISu1ZzLAj/AlJmVdJH66FYifLWWfCbDPOOSGfKk8IW
	feQbFDWqS3fANXLgBbqp5ZfHL86Xv+mVVMrcDUfWJ1RHlcb9Dt9KZLD2KtDHp3x1yACrud9JlH6
	9mKnRfqFzAqsWQP1yOxe2iDBn16T0tXxlOuunS4uN8bUIiDNLQkK0tZ/+l1X1ffiFVARq9gcH10
	QIqa85OornbZl8xKh8mWTR2jP6/TctgkrS/izelQDzKDooIqVq6bK3760ZQHMeQ5gVe6PfaA6Tg
	DXeWypAVtMYoqf0zdbjcjzaxjJ5i6QDZ9tishrImCBc2HxEzW/aVQndhyTF6nrLs5S4hTcAPgDi
	haFoE8+Uk2hQ3rmwEdrF1iQhBhz+qDrWKyUg2vqki64oji1ihj9fIKYeyy8siqcxq8LliszoFx1
	/ynmmElo6268BJpR1wxxhQNTZNcC6RdhRj0yV9sGNTn8QNb4dnhyn8HhQ4R2FkpGIVYH/+yK+t5
	FlAwD3NnI251T6cvbcljuqPc7vC/cER0jIYsuxBiwJL4il0UpwYnb4ExkdTZ7nTx3krK1Us7t+Q
	kEbh8D2TcdEIKQuGFEg1K0/VDUxq3hwkQee0q5XSofdqNKExk5lBtifB5KSEbUWzdOvvhlTwwaT
	p7faTKinfeh+BgPK+V6a0k5RTXkiN37GzHfPhGGy9pcx7dJu9xgbP8J+xbshXNwGczQg==
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4ac182dcb6fmr406060475e9.13.1793874146783;
        Thu, 05 Nov 2026 02:22:26 -0800 (PST)
Received: from zev-paneth-HP-ProBook-450-15-6-inch-G10-Notebook-PC ([2a02:14f:178:32c6:f503:6a6c:9224:7686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b432a883ffsm55519065e9.3.2026.11.05.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:22:26 -0800 (PST)
From: Zev Paneth <zevpaneth@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Zev Paneth <zevpaneth@gmail.com>
Subject: [PATCH net] net: wwan: iosm: Re-bind the driver around system suspend too
Date: Thu,  5 Nov 2026 12:20:09 +0200
Message-ID: <20261105102009.34534-1-zevpaneth@gmail.com>
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

On some platforms the modem loses power during suspend-to-idle even
though the driver keeps the device in D0 and its s2idle resume path
only sends a wake-up command. After a long enough s2idle cycle (about
five minutes or more on the test platform) the device comes back in
its boot ROM stage: resume logs "msg timeout", ModemManager then fails
to open the ports ("PORT open refused, phase A-ROM", "Failed to find
primary AT port"), and once userspace has touched the ports the modem
stays dead until a full reboot. This is the same failure mode that
commit 0b6f6593aa8c ("net: wwan: iosm: Fix hibernation by re-binding
the driver around it") addressed for hibernation.

Extend that approach to system suspend: unbind the driver on
PM_SUSPEND_PREPARE and re-bind it on PM_POST_SUSPEND, so the device is
re-initialized from scratch on resume, exactly as it is at boot.

The cost is a full modem re-enumeration after every suspend (about
50 seconds until reconnected on the test platform), also on platforms
where the modem does survive s2idle. If that is considered too heavy,
this could instead be gated by a DMI quirk for the affected platforms.

Tested on a Fibocom L860-GL-16 (Intel XMM7560, 8086:7560) in an
HP ProBook 450 G10 (BIOS V72 01.13.01) with kernel 7.0: with this
change the modem survives an 11-minute lid-closed s2idle and
reconnects automatically; without it, any s2idle longer than roughly
five minutes left the modem in A-ROM until reboot.

Signed-off-by: Zev Paneth <zevpaneth@gmail.com>
---
 drivers/net/wwan/iosm/iosm_ipc_pcie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
index 49052eb51..ebd4c45e1 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -534,12 +534,14 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
 
 static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
 {
-	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
+	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE ||
+	    mode == PM_SUSPEND_PREPARE) {
 		if (pci_registered) {
 			pci_unregister_driver(&iosm_ipc_driver);
 			pci_registered = false;
 		}
-	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
+	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE ||
+		   mode == PM_POST_SUSPEND) {
 		if (!pci_registered) {
 			int ret;
 
-- 
2.53.0

