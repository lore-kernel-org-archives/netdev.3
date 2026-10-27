Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132564;
	b=GXbZU33e0r4W27MMCilQMW71PL0eq93YBIpjJvbk+fIticQTH/FXRfBsCsl3srHAkBON
	 F91T+8UCPDFd2CdeGBWVUlGPj68YsFnCZjnPk/kyBuXWazTytUu4yULeLlNs8vycPPbJz
	 TxbWUNG/H2+1EkHFfCojFUUvUicItSNG4YoYazEgR0xsLDWiKraLUkfwTVIaxoF4lrcpZ
	 PACUvkTAnGmBCozzxzhQVsWrm92p2KyHd4mg1WHyrzUdXJxO0G3IKrrktNHm3PqkeTCQ4
	 76wb3HCSmRJRTF8CTN93FiSVWnT0jrjgHAuCDanboQV5ZPvmlER4Qa8iYNj8xQaNdlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132564;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=xS3INcmyp9xwvFRPGcegU8mkYfG4iN3+4RM2xAf/dV8=;
	b=IfFRR6pZ6/1oLjauNyl4zqlpES7BcF619nnXc3IMtEtB6yv5QApvfp0FrQ7msBBgD5+p
	 AOD/zTqFiwdPyjdBh3PdzOmLQvhZ5Mpy0elpN9uLt/eUSXB29mi02RBjFoZp4O7fjRfh2
	 3jBJwVGD+nnkqprKb0ly6xpg6CwVlK9DJ/oVyBFOFH5/75DZnVqnLq3klQS88CSJTMN+C
	 FG2H371uhsqp5QVr+ic/Yll1nmpRs6ekRgHa2yYEQh4E0/WdBXsoSnHeNofK15JGy6xki
	 DeAsoKRosC8bFwzniFwCs2GyS3iog1FNrpFFyCssQPv7CAA+NeztSdt+168sFV9A24w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MSg+ZW4m;
	arc=none smtp.remote-ip=209.85.160.97
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D14606C90B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39D14606C90B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MSg+ZW4m
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-483a66818edso164212fac.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132563; x=1793737363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xS3INcmyp9xwvFRPGcegU8mkYfG4iN3+4RM2xAf/dV8=;
        b=xs173eZ8B+jItHYl5f569r/D5eKcocBufwFXIss6yEao/h7t9UgOFCdFzGmbcAT9HG
         9IKae0Mfqi5EOxMk46PFcWw053WDah4hTT0iwST2t9MMHWhdSdEXjiG1ELBXpxpNc9qE
         oh4chihQulACMYT9ePQpP97BT1D6H+Cj76KGCatx+gIYiTEfVuIrssq9RRaynyRypAAh
         zPqdG4gIPYb2DYuCy5ceaBWmNytyHSFz89ySpJuho5rCYGIiCEER/e/E2c8H4ugHKWmI
         vy5Coi+oLov/73gIA8jRUic1KoigJLthSFL3yWzX5Ju1V2Sy6yunCf+poIEyKaUmKBI1
         3QOg==
X-Gm-Message-State: AFq9FYIGvIgyAT1V9BMLLov4DTXEzwY60tDz7UZhPfLeINl6A56tGiSz
	2Fa5L2RxFJgrQe58do8LDlOjyQ02ReOcN6iCbolqKxi+YLAcVKeza7bnc+HFqONbJ+Z/ccyITfN
	RgqvfPHDG3vXW3GAZPpNduODdSvAVia59T0qrT+Dl/s41gNxU7CC/2s5jVpokwGhHOJZ5zm2l4B
	xFm4V0fc18/v29ZtkQDNBw+DZIH0+4ti3oDeJ/xy0xAdz6IkWH6xW4eORaAcK4Zj2rDzRfc/0H6
	JyvbCevkGHxLhU4EGU=
X-Gm-Gg: AYBFou10iIX3ZkC5l91WseHEUz5IKjW5uja2R51oPZNwSdBwonsp4PqtCA64M4Do0xu
	LqjcnbgjcUqJVhq8eR1ttcavJGgkllZpIdUr48H2hj2Aa7qsGmXt2db2PAqqCa99HYAtsRmbzwV
	6fu3sYWNts7CnH3hvbgwqyspTASBzPNOei+6Ej/9S5ueKwQnfc/g29Da3TFogKI2Vz58AIDu0qU
	p34TqiXK1F1uFI35zwIWQDdo8hNJQxsHhoiNvJ1/vahZ3IftDgafhve9tZb0E26bNquGXXTejIi
	9idtQIPCggBVcdYiTnGxkmJjPlU3E3Hl+99VKaOEsnuZjrmKa3D2CtVLUCdwb7iBcMGlUMrtYhU
	hrToojfwhvEWzsUOYoUma7oAtxEXrW04ieifYxUr9Kbk/FfVvQ+NfY1LuN6va0ud6EQe68qjv5z
	1JZHaenhEoMFPk+552tt154E/LTGLtqYM2J/ByUI+E
X-Received: by 2002:a05:6870:1695:b0:490:1ff5:92a2 with SMTP id 586e51a60fabf-4a8bb9b9780mr454899fac.62.1793132562971;
        Tue, 27 Oct 2026 13:22:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4a8b7726ddcsm10730fac.11.2026.10.27.13.22.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:22:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so462070a91.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793132561; x=1793737361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xS3INcmyp9xwvFRPGcegU8mkYfG4iN3+4RM2xAf/dV8=;
        b=MSg+ZW4mlEhby3XtDxBFmfXlyr6eJb2MWT6M/OMU7MIUxsHTUcWigpznf8ckUU7SDV
         gk7yh2d5N0jQHWsSDGyv6XgWLj0X9fRkD4gpchhUFRrJDsTERKrqeJVL7E48N3joHvoa
         +9g5KotYSNZncsodsT0Br7dLN+TIBws+I4xpc=
X-Received: by 2002:a17:90b:1a92:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3ae580df590mr145715a91.41.1793132561378;
        Tue, 27 Oct 2026 13:22:41 -0700 (PDT)
X-Received: by 2002:a17:90b:1a92:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3ae580df590mr145692a91.41.1793132560929;
        Tue, 27 Oct 2026 13:22:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d1650csm275486a91.1.2026.10.27.13.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:22:40 -0700 (PDT)
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
Subject: [PATCH net 2/5] net: dsa: b53: fix the SRAB grant timeout check
Date: Tue, 27 Oct 2026 13:22:27 -0700
Message-ID: <20261027202230.3539646-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
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

