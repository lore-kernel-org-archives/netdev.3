Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394844;
	b=L7KAimCzl1zL1Pj7nN9+xZ2MX/4oyNKIzq9QbwKSwnkDWcGoa2CLykCgGs77v7K1IzC9
	 xQqZUx1KO5x64R4uuea7vZP55//+L0IN4GcrB4iq7SxG6lWMSXCmvMFcWuNaLV3/IPsE/
	 eoiEf1bNKsT9KOgzDZMvS7YXdWbEvTdNYmsLpqDrAXPR3OAXMVdIS8TmJ9Addk8DbrFpv
	 Eaa6J4Mk9odzJaoAlXXu7KOT+9PkhNRDRJD+kUKsMhDeFCycG7ODswc9tm12GhUWXlj99
	 MCbRMbRww8sgt1w00c2UdY9zqed7D+8B3Lp2LLc+hrvit+ajK7SxfumwoLGTL4Vj2UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394844;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
	b=gQ2TWg9IDVCKNkGsSQ8cHv8KMNbstJVXBoTb0Vq49rjdeRU4m3l3n6N5/mRenUxTYvfQ
	 H5YMFHaMZLa+nn04j5/5g5vCQT50OOtAOyzHxBBLCw6mzqRkWm4tiqpNDej+tBkOj7yor
	 f3x7piAK0HeCr6RN1eiPJ4rYy1pMo60toyxeRF5p/M5HcykpPRn8IGtcqto6qyctNTc7v
	 Wh7rrGyNt0Zg+35eJ/IpQHFXQUlhZWLtmX+fOJ4r4eyXe3mVaoEb+csb/dCU+c5x0+LDS
	 nYSSMUqhjUiWs9CbRjI+8tgGUBZPRX6D6A1VZwTh13j5IHFHt8sfUv3nQZU6cStiQpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dqSSuh7v;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38D606A326
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC38D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dqSSuh7v
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso449605a12.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394843; x=1793999643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=aNjtAdTzcMwAnB6KcA8Fkd8h65YPNY9wPiqEvQpgCi6OzAkgw1NnXOnpjPwmWVj+a3
         Frt1oJb0HhAxDGr4VESquOQeqV2uxbNgZ6Iv758lJaudopqV1k6ObX0V0OP7albV8jA1
         vfM9DPTPkFcTEoSqOG4hfgynNg9jjBzatUTkGDGwZ29PY1mp3Mc3CVynZ9DydS77C4XT
         SNJ0tJ+gjaYgrS1Bi54pJ7WVJ7AFY5BVtUgOziL2CM02uehgyQssYova5Vh8pnW59afj
         LoFU4djsH++WaMp3oqwfYHsSTmx/7LBzc/awz0sfJDZ6/TnEn+kGVRFBXA7890tjFuOt
         phDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqrdMxAeB5P7d35VkPJzB3JwJnb4w5CoiV1I6A9ks7dXv8L5jige/un5WMxpoi8U9wzrgfP/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA+DVTh9mZGtcycRc0QaqzqLq1vr3uE1cC/5HFSoDv37kqdix/
	r5bHu/OG4jeR8r6hKlvXwhHdkURE92/EcY5toVRYX5NA5TdSTX6Ktu8+WZADBih72my2MAkuIrS
	SKtfj9xccX9Jw8NdNgAwT0KQ5bWKvyxhl8Mfggw2dhgB5rjBRxbEpbfxVeY5m3KjX5lEBOCgB3c
	SAbT0jn/vEMxf/JAyYGZWE96C8G1QHK4YV8oKj6grhQFZCz4QeYL0k06k/dEBrM2I2WgrLQzjIs
	vS9EVLd5855x6D7zrk=
X-Gm-Gg: AYBFou0i2lWooTJpy6fCardOBxFvRNuO80XZLwqhR5Jxvme5AaIYYT3vLLeAYivSrGl
	+54Z/m4JhRe48WGwSYW1fWr/t4fJ54SVC0HccRFggQZPPxCbs48qg2DDxN8leFk0wCS2zDWzxtT
	p6Dbl4vrJlfhK4e/xfLVYPFUp6+WFnZzh3MngHK4CdFnXGib7B5+8uP8Q/AaGgnMUY97I1VpHss
	Ba35QpF6uUfAf2/+9loI+Ri2Gbnrwq3Xj+jI1F7Y8k2DWKST92bSJ2If93NprpemIKZACy5RRh9
	WYvle4qMrv3T1LzMrtdqKM5vQaOC5JiJWW5xmZKnsi+gaoXfiAxBbH2zdzb0rpl9MBIRBT4C++n
	i6u8hFGzyKk+ERLoC7UEsvRxxZ01nRHjBKgTBUEM6zgUKfPDfMzJshvumvEJkdv+BrxBbrqQKIC
	6I+nHnLoljViYqIz7Ulqs3083Liq1QPgraENLckG8O
X-Received: by 2002:a17:90a:f6c7:b0:3ac:a521:960 with SMTP id 98e67ed59e1d1-3ae89536bc3mr1935721a91.1.1793394843123;
        Fri, 30 Oct 2026 14:14:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85cc363esm808638a91.0.2026.10.30.14.14.01
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a3451ea93so1786484eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394840; x=1793999640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wh0SeQdNWzsZyoJ4vl/0g4hHaNPzl6qxcqRd7BCWar8=;
        b=dqSSuh7vsFy0wxN80SDEscy1x7RWRc2g0oDZZPDTuuOazj8Ijrb446UHdRn/T+z6re
         IBEbsY5kPARkanDJHugLrGIwxiuape7i17iKmET9xi/1deQfBmXWN4RP1VQCYicywZp5
         dOAgYLXrt388RaukTiK4gq2sYnLYZgBDRLHak=
X-Forwarded-Encrypted: i=1; AKwUvBxcu0X6NjAoH+bIQA7clqute7wqGRm9Jb0kdYME22pQ5U7E1/7pAnd9bGNqDt07SbyRWcMYw2c=@vger.kernel.org
X-Received: by 2002:a05:7301:fa4:b0:36a:713:a76b with SMTP id 5a478bee46e88-36a4236a5c5mr4971851eec.6.1793394840147;
        Fri, 30 Oct 2026 14:14:00 -0700 (PDT)
X-Received: by 2002:a05:7301:fa4:b0:36a:713:a76b with SMTP id 5a478bee46e88-36a4236a5c5mr4971801eec.6.1793394839469;
        Fri, 30 Oct 2026 14:13:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:13:58 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netde@vger.kernel.org
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
	netdev@vger.kernel.org (open list:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 2/8] net: dsa: b53: fix the SRAB grant timeout check
Date: Fri, 30 Oct 2026 14:13:44 -0700
Message-ID: <20261030211350.287566-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211350.287566-1-florian.fainelli@broadcom.com>
References: <20261030211350.287566-1-florian.fainelli@broadcom.com>
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

