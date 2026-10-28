Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222600;
	b=WDCMqN4oOgFowDn4fx95p1mDShldKTo6T3C9mqIHCf3zKBHclA58DWF+jGRHM1U7PxEk
	 d/0J6spIOE9HKOpEgegiYWeUtX5d76jRghDDdqtzvXy/cbYcDJzYfTVz8B9EX/P6RgcHG
	 QRO7CdYFD6JhYb6BdnuZF2j3Up5RLYCpEpKuYYik2gCtiFDJNIscsfMpuTfrOIeHhU7IP
	 oCse+Mr409EFtUMhHND6EG9bE3AJDuz9b3jZepbbyN0p/m58c/NjhaMxtjWObS6ePqbjS
	 rSXRvWICyqeqgYlP7Xde7UliT3WrS/9DM2FJgkSv410SxNs/8uz3CeztUc7CIa4M1yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222600;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=x2+Z6GJFzUD/ZnT9mDP7KfBV4AkjsgrICZGh3Cd+Wek=;
	b=bUERQglsFTvvuMDz8f2T9XovYLYWyMevyF5j7Rw8ttgSOPnhHpFhnMKX/IvX5fJL9OfW
	 du+AGy1LvR0juef+oJ9atPcHUrqCTUioSYToivQD7X7Fx+7yhmw5gYCvu+mIf7+X8v5Pu
	 /plbr+Pxa7/y/fZqFOvsxt4KdIXv8vtHZSVpMQKFE5gGFTpDIF1U5qnPxrRN/PYXttZE6
	 mStPaYYD3/WXb2O0/ZEhp5X8tB74p4s2X2tE949vxDtrh5dTbAY3HSxMZTUMKWzQdRCeI
	 8P/zwHLIW+sCm9dm1FIcvxjv8TSn8WxvQl9+RJVQ/DaWkMVQ5004Y4tuVmpqAUPi51g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TpxDq9Xb;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776ED60A2601
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 776ED60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=TpxDq9Xb
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so48172a91.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222600; x=1793827400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x2+Z6GJFzUD/ZnT9mDP7KfBV4AkjsgrICZGh3Cd+Wek=;
        b=HHYcaZoavZlxpOHa/libYA4yuistT/cI0LDGSklQRkCUh60fqxxFaU/uJliYetInPO
         pBORcfB72YYZFzFjH36X/St43R087reo16jNioyG7KM6iw/GQoY5Y46OkHqP7t0zk9X9
         Y7y0jO6SXwsH6fFd8Pgnv/YsSUobFixsAEG6/d/WC6csCshD2qXSV4IasV0Lpo0U0UeU
         A7acB5vcQ4ETn9S55okzY5Xjsn9SG0vTlPGtc0hy7gnNKSfkuOullU7N02Lzy/vaK0MK
         f+qXNvBPXrCqOjvcvIfdxv7RSRVVT2MVQttod6Ap2TfDtFuTnKsankJI7kV6zhprfndM
         yR5g==
X-Gm-Message-State: AFq9FYLHI8RCrHqFeU4tby6uy/YN+tHR8TpaWg/7f8M8vO/44ovZCY9l
	Gn4DzjNp6p1fKb75tdly7n7QGQdm/a3ckDeHLP2G1D1EJAKT4MMxu9CeuvKOcuGpm0TvJEo6sE1
	aGWB2my7vPP8p9IUX3Xw7Hf5smCFih6hDl37QOpF9cdeQ+/8AwCF8ftyHG+ODVGz5JvZDUgPg4X
	946s55OkR8wNagiibnGLXnT1EUjXTjcKOiUeNJ8c2hXXogb96cnIWGQgKVqY4YE0rFBgS1cNUqv
	J8TMJa4QRNUpCOD
X-Gm-Gg: AYBFou26ITw9KfN2Qm1iYTsC5ibQirRoI3eQaDWtrOJTnOJnsJdb73++AG/GJ4XV/2c
	fcW20kiPRjB+dnidQUUJV7urLQsNPMJLSwtGqxkzE3Il04Y19I5eBKblTKikn6IUk3C43gsCw6V
	XTUd5uXyjlnKMr50WYfppmmB9f5Hj3SiiDargr3fEXvkvIGRJeG3H0SDJhg0KJ7ZZVEvPLKc40b
	gDS2Waxqffgfm193ZKLJRdotRLOa/jRDMDijNFbiTH/joxDkb+oXHZQE4068CsDG5WgJqlEI+ad
	lHfsBM7nyiLEn2srB+6wXUbiihhIfGOucZtIfsu3McbOn7iy87jQ0wDTkk4K7EtBEY02lldTg9A
	zUc98aXjqMA6sZ7e0E5BWkDrJT8GeIrYCdrUeSJiBC0evc8aHIQO7ic6+WHFAk1vKkxRPOcrfH9
	4mE5XEtcj+Q2mFKz494SEZmKTcBxosrTbiVZU2DLH+
X-Received: by 2002:a17:90b:580c:b0:3ab:d26b:c2df with SMTP id 98e67ed59e1d1-3ae6ed4d63emr384980a91.27.1793222599774;
        Wed, 28 Oct 2026 14:23:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e88749csm513757a91.7.2026.10.28.14.23.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:23:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c6c1e082bso2049726d6.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793222598; x=1793827398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x2+Z6GJFzUD/ZnT9mDP7KfBV4AkjsgrICZGh3Cd+Wek=;
        b=TpxDq9XbYcFWNahXtOKK2z4Hi88iZzWlkaNi82KUjaqsOqd9hpbbNwiwFtlvQtDQwo
         T6PHdMs1cX+dwLrv21KVIc8HXXGneJaUeUMHPe5hq0KMOSioo4Sw3IbbBgoNh/lfaaPs
         Z5J/FTwR/EGE/ET0z3tV17hDKgq6afmOt67ws=
X-Received: by 2002:a05:620a:2916:b0:93e:6618:f4a5 with SMTP id af79cd13be357-94413255560mr128677185a.3.1793222598695;
        Wed, 28 Oct 2026 14:23:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2916:b0:93e:6618:f4a5 with SMTP id af79cd13be357-94413255560mr128672585a.3.1793222598124;
        Wed, 28 Oct 2026 14:23:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669112sm1368755185a.10.2026.10.28.14.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:23:17 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/5] net: dsa: b53: fix the SRAB grant timeout check
Date: Wed, 28 Oct 2026 14:23:07 -0700
Message-ID: <20261028212310.3847553-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
References: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

b53_srab_request_grant() polls for a grant up to 20 times, but checks for
an iteration count of five to detect a timeout. This rejects a grant
received on the sixth poll and reports success when all 20 polls finish
without a grant. The latter allows a register access to proceed without
ownership of the switch resources.

Check for exhaustion of all 20 iterations instead.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_srab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 83a03fca142a..f4689078ccd5 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -105,7 +105,7 @@ static int b53_srab_request_grant(struct b53_device *dev)
 			break;
 		usleep_range(10, 100);
 	}
-	if (WARN_ON(i == 5))
+	if (WARN_ON(i == 20))
 		return -EIO;
 
 	return 0;
-- 
2.53.0

