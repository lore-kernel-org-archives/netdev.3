Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394988;
	b=je2JsL6Y7Z+Bo6cWLRSb2Fb6v0ZY3bFt4AzmO8rQsbNWkcUolzugijZEfZ3jqGvvN0gK
	 mACHWvmi13VVyZkqvvrAJ4MvF6v/n+vulPIftGdT/XZuwYW6aDO37RBmm+J6zX6gWY5pZ
	 XGxW/jr8Fpg343pEP5KRu9tg/piwpQqRksVgV5OGMOYxqRG1peUxXWC0G3yMWBfsjgUwI
	 bLfJ8ooI12y4Ttv0nlpb19ElJCuLcmvCBviIdSAQxqQ5JhkZ/ttHQ6QWKC0CH3O1AglqG
	 05OufXfL0keIHKUDaLnrVjCmCybKwGeAVwV7CiqzwqNti11dOqlF9J8SFkcf/UnQ1CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394988;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
	b=FRZLO/zXp20YCK3Mzqepk41wm9jbFdZHoYc2d9Dkx7tUuQzKnuTiQeVfFqnc/ZotoRaS
	 KUmMWj5+aOiT81NGcyIitR11O0nVR1scKCk52eig56GOfJnMxsB/79V2xVOuZi+Nt1KcN
	 vGT4SMC+fC+OQb5CoVYIaaYZZ0hw+x5SqhftAEwwiH6ChASXBRVD3muEDekmkQPdL8yIf
	 1Ih+9jwLvqhqf9vAeB2fbflQmHr2qXvqSPAZ4NIvLVJNKYH9Kd8gcZHPL4uoHuEjEdlGF
	 J9evS4atOq3wumTqf+qzs3yTuWdFFuCfUrn8X8rfKDb4M1cxTOzcm7SOmgRcxgN1kNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LRwUa2Iq;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB5B606A334
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FB5B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LRwUa2Iq
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so562025a12.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394988; x=1793999788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=oKVgAvnstPf8WOfuyjx9GgVhsdspcDKNMGIx8Ws0Q2u+QdcY8/q/zu1IU1ZlgcH4Ae
         RwRJuLjooe70G9I88xG9XPF5+D1n/LQH1dX6BCFmnjJ8C35vYaUKiVpVAW/+204MzC8F
         gxWQwMSB066mOVewDUyq/j/iaHjn1/DTikqX2eMq0zxu2fLy1B8554LE3xDqqo1jeNtW
         nnfVG7F7eYf2Q81X6U6wW8/jTc/huLhwK2pUDNIme0u6zUq2W+nABJ72nFhCC9GhIo7O
         Zt8vKeqlBVJvE5a0fitviPVQ59GW/qRxsrS9CZca8OZXDsYM5v3G7p+K4V8YT51Nr8/m
         qh9A==
X-Gm-Message-State: AFq9FYJXUdMUdso/LBjroQ7J9xbmHwhYz3N4IQvq9HpeEQSzPspksD+l
	TtpEjjeLcmNq1A8Tod1J6ButkrqBUV93nYom9DbbKjt1iaEI2JJE5rERMVrC+MRffoxaE2uA3gt
	v21UDXBr9CTO3Jf7L1cdjsxFvguGwsOO2gcNB1PMg42E1IOWq1XYY82K68u/H1er+jHOmvwqw9B
	ElAq1HX6mN48gFZjkiRv6Emlh6JDZlhOvCuKggLa2oI0KZDh+XMj/n0LYctpm7UsGTmKll/VRri
	0KG6yQxMXERfcTANGw=
X-Gm-Gg: AYBFou3jDQ6i8BVVecVJFOPHYSXOXH0giTLxLtRfXx8c+6DJrVfmtGhVm1bYCRyFVnm
	lDwVMwqLoJDy+6jZO2f2vIEGCpSAUfF1V4xbpzSxL2zQSAsRlaxCLuBz/sOLyC7UioH1KEsJNYH
	PL+nJRAEDJE+MoaYwvLQ2anxU6k/IUhLz6puKDdDzbgg3HQue/qLDDKb4fQ9CvkMHqpZKB9Or9R
	1yNRDzo4oGp3bt7oYGSuZE3lOBN7vHMWOFImK1M6c9SCVdMpbsUasHZnlZfOID7tRWsOeVi2qTt
	ioGMOxtGl7nNVH7/7HSWqUDz54bJ8aPCC2Bqug+8WFqMkM5aM3iTQKnJDZAxSY+WGcVRLN5fIdi
	DKMDT5C04Fg2YxXwu0eV0ZDnEV5OcYcXY2WUzuhthGZ9tm9RpxS0ECIcoZpKxxdt0b1C+QqCB9L
	ddhCJJI4lIJNBIIYbXvoatjm/cILZAS5kzsCMywPFg
X-Received: by 2002:a17:90b:2c8d:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3ae8987e32amr2900558a91.67.1793394987650;
        Fri, 30 Oct 2026 14:16:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae87fdab62sm919804a91.2.2026.10.30.14.16.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:16:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a1e2485fdso2731528eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394985; x=1793999785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=LRwUa2Iqd8B6LLZctA6rXiL4e8vN4/Ai7p/i8Ae6VTlLAspykxkPVk9Q6Atz3NDqO4
         o/6vIR0Gk5GYFHPy/APTqM+mCCT09cL6kgrs2NKQM0lrmvFkzARIX2rtX5C0Y1z5i4dC
         2N38BIxImCVOHIBQLlKwfbSbfseBJy9hA5rpE=
X-Received: by 2002:a05:7301:152e:b0:366:83dd:4713 with SMTP id 5a478bee46e88-36a4249ba39mr4582348eec.30.1793394985359;
        Fri, 30 Oct 2026 14:16:25 -0700 (PDT)
X-Received: by 2002:a05:7301:152e:b0:366:83dd:4713 with SMTP id 5a478bee46e88-36a4249ba39mr4582301eec.30.1793394984512;
        Fri, 30 Oct 2026 14:16:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm13513535eec.16.2026.10.30.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:16:23 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 2/8] net: dsa: b53: fix the SRAB grant timeout check
Date: Fri, 30 Oct 2026 14:16:11 -0700
Message-ID: <20261030211617.288562-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211617.288562-1-florian.fainelli@broadcom.com>
References: <20261030211617.288562-1-florian.fainelli@broadcom.com>
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
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
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

