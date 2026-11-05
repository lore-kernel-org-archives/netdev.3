Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907304;
	b=Zk6cDLt1mpPUdoFukHNpBxEXgz62mDXZRZvUnUmKzd6QE+/iumKz2m7F9X/9ZaExYcA6
	 Le8mT4OQZfiTGwoD0L2QblFtVBcKxRwizifF4qIxWgfKrk87Lc7XIY2N1XjFZXQ2sgapZ
	 yLkU9wz+5yAxDu52wFsz2KR8/pY/vbe45QUISyiCBVvjiYEccpnIjB6DDFqEvqceTFyoB
	 n+JBQmRGQP0Gc7KTok7Axf+EmjiwZxu7T3TPiEZ9xkyliLXSLfc5E4bmYRlh+nkTL8dAJ
	 M79quhrvYE7iaGhUb+Q1/uE8KDmpiVP7ybpuBap01WjfEcM0NS2Vk+jZGhmB2RTSfDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6waUMbBW3PMNNkalcsbpj+noxC1InsPmZ1SepMjhk0E=;
	b=uun9nCu2uiuk1uhjP+nyML/YnzJJG/K9w+TZ1snoFkmNIHRTJdoheytrrC3fMxk6FyBe
	 R6VfRCh8fRiYEyjhgYDUI+xkA84BRCT73rf5jbAwOwau4bohYtohMoXUGb+0qbqH1VdIE
	 YLcaVNXLjnhkh2AyeVCNNkcm+T/2xO4kpK9/mmkVhjCQObWyVhtK94nlHLNUtAxzhAGV+
	 IcdRvTyzCJDImbRE1KCSanr5E4Fke/tJCWzcwmxCBadGBvI4HMrJUiJbpZyko8ybPE72k
	 UxWGa3hY1AMBqMEWQ9MNoeB2TX82q0N6NBP6VeNrjFYjbhWRIgYXuYw1LJDo2nZdMbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gF2H0qML;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7EB6075326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 19:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7EB6075326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gF2H0qML
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-19305bcb72cso2095155c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907303; x=1794512103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6waUMbBW3PMNNkalcsbpj+noxC1InsPmZ1SepMjhk0E=;
        b=gF2H0qMLqJEILl2WdYpdXO/kF4o/xA+zA11jGsk7q3DYsSiVSR4QAvQ4vNa8mrlh4T
         2PViehKuLqppi/478eA40zl39pgH9MZIfHzlgQqNuwY9J9Vpn2rJbUAAW0OIOpsDag38
         Cf2BEGqBCqhcr1Phfk9FSyg7cSv7ghsJX2sB4iF7m0JkqWJKYhadaDRqWeiJ6RCDfpV9
         S0XrT0JWFCMmCZskgEcesX0AJUGVCJ0UX76I7jBWE4rjK0rAYZHICCCqPG9/mUQMcy6b
         FZDlNrbQjfZimM3eqBJy7l9hijgjz0cseq5LkQyXt8hCmEqxuIDbJieVioSE0u9uAUfJ
         XuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907303; x=1794512103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6waUMbBW3PMNNkalcsbpj+noxC1InsPmZ1SepMjhk0E=;
        b=K72uCxkhCdSvdfj/icYRItL0MLCzxhDXYT85Bzbi8WxMSFBNsQGCa6XZDPmryBuKh2
         mNPMiKgHTw3xT5Cv1mkFogjoE+QRrqy2CD8cEDYJR3BIOrAgUmrz52Uey4uRMqpBLwDq
         BXrRKWuPIZCl8kbxH2WPQ5zgrkH52/I9Rkb/22RGwdSJBlu/tVjyAX9oGZZ4yBVNB26V
         ICHZYkmI46FgQZy07Tylv8RPcbqDbdil/0AFznY7LLjmfQj498cPnIAr2Ongx5tlzGcs
         gjj7TON8LmCL/V1WdDr7JxXVViYpTGhyd1M2hB7u5nKbIvEGvZ2Oz4X6SVCj27jJ6J3t
         Wi2Q==
X-Gm-Message-State: APuU4Z8TrAGNWj/PccrcKDg8dEAddvYHZ5wbTN3HBsIewFuY+qwMJ3bL
	VN/BmIXMW+41xRo7vVY+cxGhxBclznMTOfa/IsiRiLgDxUNafKVbeBG12MPkuQ==
X-Gm-Gg: AYBFou228VT/md2MHVnIedyKGPkd9jwqH0tds1Ygd54grYJ9cp9C3wTGgj8UuDA3KhB
	6tTf1v6c7WDVLYzDbpKTa7TdizuGbVgR4xa905Nbe9/4zcplFovzylQ2wxX/JDGX7ujQMDidCqz
	gVVjjGg8asCT7DSKJk4mplUDl5gBYdh6BUwh0Y/yrmIP2grUeYN8ycBt5IpFvgVpvVjMvTphp7L
	BH/B/6Qh3RQiUwj0vBHH9dKrhsQXZrn7kG26CYEXsdYQMbYpbV/KhquXWQPGH/DvITDP4mbzlGO
	eXl1cia4wRM6y2/euUIVh+3cPciZCrw4hPCt2qLJ7JxgztM/88utSvQboS0FqLpDmlLjcSFT9Gv
	D5RpnIjT8AiuLpTwROtgVnYG4lUl7xLbbn9mO1hAur0Gzehxhu2A78fr0GTseUibXP+ergY1g0o
	4oZCcbdm+D/qfGSRN270yxKzF7QjcDl9X/ren7MXkbRVsfo3JSI5n1zV7zrZh50OuG3SeKxQPee
	UOF0fWajodlIuP/I37l+B3DJjBC1gk4c3dtHjGAIPxtA46SKH0+irsYFR9WlKKpjdjxgS/1dKri
	9n1EzI06x/cgaG9shni7X/dkZ46elw==
X-Received: by 2002:a05:701b:4513:10b0:1b2:490b:6fdd with SMTP id a92af1059eb24-1b2490b7174mr7487167c88.24.1793907303014;
        Thu, 05 Nov 2026 11:35:03 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c127sm18023186c88.6.2026.11.05.11.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:34:58 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	macro@orcam.me.uk
Subject: [PATCH net-next 3/3] net: sb1250-mac: Add ethtool autonegotiation restart support
Date: Thu,  5 Nov 2026 11:34:35 -0800
Message-ID: <20261105193435.2050321-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105193435.2050321-1-f.fainelli@gmail.com>
References: <20261105193435.2050321-1-f.fainelli@gmail.com>
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

Wire up the nway_reset callback to phy_ethtool_nway_reset() so that
ethtool -r can restart PHY autonegotiation. The phylib helper handles
PHY locking and returns -ENODEV when the interface has no attached PHY.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index 546415d3134c..433aa1e24439 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -2129,6 +2129,7 @@ static void sbmac_setmulti(struct sbmac_softc *sc)
 }
 
 static const struct ethtool_ops sbmac_ethtool_ops = {
+	.nway_reset		= phy_ethtool_nway_reset,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
-- 
2.53.0

