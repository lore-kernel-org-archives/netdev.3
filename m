Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278929;
	b=yfQLk0Z5W2YYK1VtAWhgNTZKt9yW0CWES3fXcj652QJ8ScoyY1L00XiWs9+9T/nl7lJv
	 IRsL7sF92Gx1g0dPZchZhLPS521e4RXrwCKkghPu9n4Vbb1uQo01Z+Da33n3dB2VJ6i67
	 nt6lAymq7izdyXd+hhO4ivAQAOHcJELsAMvNwA9poA7/8e7sqC8qN/VDDnPdX8fRbD/VC
	 lkMaisKmy4gEV8Ubl9LpyWEJUEBgdbiI7A8n1XXsa5+o5i5TYiK0JMVeFUJHbqpn6z18S
	 PVxDoCW3Z9eaqWPmquP3Jz4WjyucoebrBce6oGrINxCsFcmZWsECJgNreiQ/ju65BRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OgSry7e2g9JnvLRslnsp0vdPuCB33JbamklOGcvQymQ=;
	b=uIRWUeRL10lXqFuGN1P+HTL/qTVBtZlp+rm3sLYbZGmVDFvebiJ0qvId+qQVyVIrYB7o
	 eoni70LdvPwcRD55Ph6hly6/bDakETdlnlWBVg4aBDa6wMqtbYAuklT7604MIqUcbEMKr
	 2wPEvwG+Wovjsz0lueCP3jstO32OqL1hd/Pouw4LVpLeW6tbysh4g404yO9GgNO3yuk3t
	 dkVGgHvkW4bgO9f3fpMNgLif2qRFbmvUAv/v9K4bDDldH9mqNGBRsoZ+GdwUIYXY5BgTv
	 e+bu8SRdETTrfU8AJfZ9LzxlhRBIV525lThA0zBYNA0ItdWvw3To+LCaN8IgaM0VOeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qMaP2fWa;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD57606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD57606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qMaP2fWa
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53ec2cc397aso863786b6e.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 18:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278928; x=1794883728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OgSry7e2g9JnvLRslnsp0vdPuCB33JbamklOGcvQymQ=;
        b=qMaP2fWa1IdIP/qpMN2FaoqsVUe90F4WS+2YQT/gI47mTIIiROmHTv/9fKDHOzNFZx
         vN4+GXG9a5foFAn1JP2X5owDAeGW0GK4Z8ALOURw0QMtH3HqRKgmPsYfA7qLrl/4NkjB
         ibFNL/J+MYlFTVVXtY38+1aUyZnWoCr24llQbUfCfky/b7fHrl/OaAb5xV8eYEnpkU6Z
         VrWaFqfjl/uiQkytrUZydtLRLvcfcNT8rFAPiPVjcKaLutVjDYoI7Q+ugFstmU9yqmd1
         /v0aG7rWIUGy0aDh/Et6Fns3P0sYYs8uc6YXk0PaVJPicHMPHW4RWxUsPJkMUrnuu8r6
         LRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278928; x=1794883728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgSry7e2g9JnvLRslnsp0vdPuCB33JbamklOGcvQymQ=;
        b=h/oN42n3lWMcYtwgAjZiWF6Z76S8TDD3ZhcrpxtrksqRBKRO8TC/Z56FHhlASaSZwW
         AJRLQ+I7W2niRe/mI6ItNDqoY0D05Zi4n6veIWw0xgDzlE5RH6Geoa4hyY0uQlJOfTi9
         NgtCy1VUZ3lkABXeldS7sCRchtDL6NZRqLNAmYPhMgSPvTDRPmAp99dqsSE1gcVH3j58
         IvgTd1fvxAMYhatEckEe5f7Bj9Li9t5gG+BBL6FTK0geqKeg9a6ArSTPomAVmcRoIcUk
         b9haKNgjH7gvA3ESGGLiucHZRrUGX30O0AXlXl0Za40w+9QBn3nF494yEUZWItFDfR2Y
         64Xg==
X-Forwarded-Encrypted: i=1; AL+hErEaSqDIMfJj76+391YsWqlJiOapPKpK/2gVTe8RCXpWWSLKodxd6VFxUYRMoMuoKelCROzrG3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lBq6XUZCKDETe97hMRDD56aYxCjE1KxMVOjM8l7cWQxddK8rF
	cUbBpyfDCFY2BUTMzFdhK7jZsI2Hixr/AUjJO0y9yCn6zQ8mBKhZXnt2
X-Gm-Gg: AYBFou1pa09X78IR1Q5QvOxiwrcGbhKYNbpWamj/ktJZ62necHjCI9IJSYpA4KvTpPZ
	FqVTZhdHfkfj3ozY04kG18ShxukljQNiaXe9pWW4NgVxwE1dkL2eFTTi2sEJxc3BNafRL1DCO7s
	yViWbdQSfBMVebudf+5dDIMgr15mbwpyu7Ar3bEtlxX3ROoG1lVbx2zhKT2tls2HsntFDzTpyc4
	KQWi7l02ICxuOzhhPUWk+zOXE75mdHOdu9V7KE1wSbCwd5MgfD4OqsZbJ7qMNGEhoJDH6KvgLK9
	M2p4IdJQmO2vVpnUF9GBWlZLFMrRJMFK1DPZt24+XNAWTQpmM362WGFhhPa0BU6TLVNMr3hPPPb
	YS9Lh20vgIwL0QQVaRcSyja6+EMB8x2s+hUpBHotzPbZv47L7aNNtMUE86cOUMk5HlhXJqO5f/W
	7n3gg/76RhV5blFaVc65Y4mIaXlJ9kJYwI09ovVihQczCruEsCf3b9cNTCbRtPJdkJi0gm2xlV+
	OQgjtda91sfLH+3et7PQMG3S+NNlxvNFJg/0/X0Ni02LaorU9Z9ItOC/svRkcPm3AlAd7Fx2qEW
	4MaRCCNovsupLHqsLaHgolyVuRnT9YqISmtE2frrahLfoosn06rHStlKgi8McVy3zE/GFoJZTr8
	N9p3T+IBCglL8+VEeGVz7nsjKEEQSpUtb7JjDf8OZHm+cR2EpA10RnUS9DKRP2cnWMAwfls/oIF
	+yMH1gQ43tJlzaY7VHG03nd7POPdZK13HIAP7IrmH+/jWAnOWI090x
X-Received: by 2002:a05:6808:c234:b0:53b:f634:83b2 with SMTP id 5614622812f47-5683c70cda6mr1164034b6e.0.1794278928446;
        Mon, 09 Nov 2026 18:48:48 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f39c60sm943233b6e.14.2026.11.09.18.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:48:47 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 19:48:34 -0700
Subject: [PATCH net-next v3 3/3] net: phy: dp83tg720: report inclusive RX
 packet totals
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-acx00-phy-stats-v1-v3-3-fbc6327c5be4@gmail.com>
References: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
In-Reply-To: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The DP83TG720S-Q1 datasheet describes PKT_STAT_4 and PKT_STAT_5
(0x063c and 0x063d) as the total received packet count, including packets
with errors. The driver currently reports this count through rx_packets,
which is defined as successfully received packets.

Report the accumulated count through rx_packets_total instead. This
exposes it as RxFramesTotal rather than RxFrames in the ethtool phydev
statistics group, matching the hardware counter's semantics.

Fixes: 677d895af1cc ("net: phy: dp83tg720: add statistics support")
Link: https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/dp83tg720.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 391c1d868808..5824eff92937 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -309,7 +309,7 @@ static void dp83tg720_get_phy_stats(struct phy_device *phydev,
 
 	stats->tx_packets = priv->stats.tx_pkt_cnt;
 	stats->tx_errors = priv->stats.tx_err_pkt_cnt;
-	stats->rx_packets = priv->stats.rx_pkt_cnt;
+	stats->rx_packets_total = priv->stats.rx_pkt_cnt;
 	stats->rx_errors = priv->stats.rx_err_pkt_cnt;
 }
 

-- 
2.53.0

