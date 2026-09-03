Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976744A64C2
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439024; cv=none; b=ec2l8iGRjkIE2mvjsWtSm54YmW4B243Stkd52o0X1SG4g+6xqMePuVU+nk6oZJal0J5d/EG7e3oCW3XFod6SV5uSXAKlGWpvd3wctuFHfhWbubhHuZo7RE7dob948NdWox4wzuocg0R6t9fEzMTjmq+UOleWkQ2iASCoaCQGTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439024; c=relaxed/simple;
	bh=JXRMCSTOVYqruevZDGOrAq0z24REEtuZW0GIiSGyGg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkwFM1rko5DHuicSFo1509TQZC4aHgOtG9AbccRyQFDFuhwl6bza4+6D26k57xaw8gCcLTcBSQgmViCfzX4zRe1uqFd6BRYPhWhWfX6HlMLyYGxreoAfnc6a30i5kvz19bXKDdIhQ+P9PTgvlVpx8wn3L1ZglzQretcjw+9qCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=YTgFr+1d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="YTgFr+1d"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4843e9c5960so2264512f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788439017; x=1789043817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=693kjaVs+p5BNOB1UBpXt643TYLBrm9lh0vgjjyHqkI=;
        b=YTgFr+1dgMKzRPQ/k6fkLNFTZUhG5N96++VhTPEwooh7nHxOxHH+qzbdWvf2rjsqyd
         V2sX60YTCDpdwkEQvqyTVCqEtiZsoLryOtTzsp/4GYmNRHnGWW6zgiiQeJVpOoiFuYcc
         0YLX9ATdf/0OMHlTNaDNq9F1JU8f45Ib/+W5htQec/pHc+GPMXVpZ1PcFWdgnOsNII8w
         EQaUsEZSRUKJvzGGTyilcVX7Ne00qM35WA/liBDoyppoyWE2pE88aLVjAEpPA09ExiAQ
         8Ng0Qna7I3Q4JnVEUJPMX0cowcPxTwpdYwWf+AS3ZaQSxi7jWfLTTm9acVyPaVVe3Z+Z
         kEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439017; x=1789043817;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=693kjaVs+p5BNOB1UBpXt643TYLBrm9lh0vgjjyHqkI=;
        b=Bz5ACIWtjIbdWUGk0OfGpyT66aJ+nxmW4+XAmMbWvts1bb44o7xATDoV3J3qFH3lIV
         DolfmpHDegEhWsLJsC2QBnf33Jlm5YgtNzYyKJT3JCicE4GOrYHe3Jvv00u6kvvvcgYb
         p2s1lpunNVZq+Qr8vIPsUGwsnDXHibba5cCexZsiEvQ5gw4PeNk06rxTLq6x68a7kgOm
         SGEXjwZeWY0dpZgBBTPte33/chffLojk9mEvLWPOJLB55yVpU07ccT8YCpgMYjG2ft9y
         CEXaR2hLyz3W7WGsN2rGkLLvYTBO/6rFAq/HOlXdnWQVdgPb67j68YYjwPnifNrL/DWH
         +kOw==
X-Forwarded-Encrypted: i=1; AKwUvBzcvGQAL1dbIfxj0fjfTnJcSSCGrxwDAo8DcUK+05bXM2L5kNNmdiDnD/P6aa0t1FdOEVE/Y7k=@vger.kernel.org
X-Gm-Message-State: AFuF++koJVl3PmoKnfBnmZSb3JQU39an2t47gipyoyXPW3BkVoTdUiAO
	OTpFUhc//JowVXjU4pIxc5tSv8sN0rfgcUSt0PkR84cC6nQeQ3smZG1z33TyBg8CM58=
X-Gm-Gg: AYBFou26gCjjYHEibxkKGnzkxKNd91tudHqymO4hVKmvXg1rDDiD+m+z6VQ4Y3SrLs1
	eFIpZYOOr9iS1Li0f+MEhS5az12og4SgEsmWRbjnpZkIG0p3QD+MDETuhQ177Bvqyx5P0ChRhrj
	khNFzhrYOsxiZoipezYZZzIeFbbq1ADgVtN3IqyGYv0OfVFCRNX0MtqsqgedS5LCq4THgmGQZji
	VDfFXtpkdRf/2kUp1rNW5kSr+pSCU7RnfyqW7qRGDzSwXDp+UrUFeIk4c0WT1OEQczdDrE8HyX+
	OEmoe0pMxVxEV3vOzO2hBeMMqihQ/pHVj0Cq+kZNW93vnUqtQlg7MXCzxRlStfkJExTK1SD4dOK
	8NPQAHBK0YgwKveFO/lq1Vu94BQl/kwF+HZXYv3dr1xTSehFP8ex5U/00Ng1ToFixVe8IULveOf
	EsLD9fQA8VplQ9GUtTBLlV236ZnAaseRkYEUN/RzI=
X-Received: by 2002:a05:6000:40cb:b0:482:e1b0:8a1a with SMTP id ffacd0b85a97d-484913b80e8mr19057331f8f.15.1788439016781;
        Thu, 03 Sep 2026 05:36:56 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed2edfsm13223248f8f.23.2026.09.03.05.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:36:56 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: "Th\u00e9o Lebrun" <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: macb: reject an unknown link speed in the taprio setup
Date: Thu,  3 Sep 2026 12:36:52 +0000
Message-ID: <20260903123652.23900-3-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903123652.23900-1-f@lex.la>
References: <20260903123652.23900-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

speed is a u32, so SPEED_UNKNOWN arrives as 0xffffffff and passes the
"speed <= 0" check, which only ever catches zero. That is what an
autonegotiating link reports while it is down: the limit derived from
the speed collapses to a nanosecond at most and the first entry fails
with a misleading "exceeds hardware limit". Zero stays covered, it is
what an interface that was never opened reports, and
enst_max_hw_interval() divides by it. Say which case it was in the
error.

Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
ethtool_validate_speed() accepts SPEED_UNKNOWN (and zero), so it cannot
replace this check.

v2: error text and message per Théo Lebrun.

 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 61838084989a..202bc688978c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4324,8 +4324,8 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	}
 
 	speed = kset.base.speed;
-	if (unlikely(speed <= 0)) {
-		netdev_err(netdev, "Invalid speed: %d\n", speed);
+	if (unlikely(speed == SPEED_UNKNOWN || !speed)) {
+		netdev_err(netdev, "Invalid speed %d, link-down?\n", speed);
 		return -EINVAL;
 	}
 
-- 
2.53.0

