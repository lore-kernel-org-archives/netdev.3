Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394841;
	b=hMtWzspDOqT0CZ7hgk8nsN+vGfMsOz+pmNIeiZ0FRf26xiaMZ+s1OA/6lw5POzJE8qGk
	 RGPDMLF0T/0zc0yzeUv5C6x5vsJo601Shqg5V/xOmnhnRbuovtQwiVBS0Y5kVyBe3QKRi
	 Cv1SZPYESJ43jOLqt/DvThs6SQGCDog1ow+bHNaIqiRj83ceeJVZI2wNni6bA4H7efdXy
	 vCv+b9FINPKnUHrm9GoGympbFiN+VqWkSgM//KvqWrwZTSI5N9Iar9HhbnK7lYp6rHT/z
	 eyxxCd4gH63srmpiWVXHCDabfODXkd8kM4aCeSU1DNAAMjKBk7uU0IaB7QiFr3NgIoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394841;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
	b=E/e5IZXQvY4RxVA0wQ5DbZPimzxTcQUlkQLUh8l33KY6Fwj/3NpdcZgO2inde6MnY3fl
	 va5PWnLLdFiFCqPfpJSKFZxCKN0g7SR9D/vDcDi8vlgMDCGcHdXhG/O1VlWq2EQ8mJzkS
	 42ifvrsiAslU2LJ2lJZzCNy03OPTGffEPfc2Ig0a2ITQe3FthbDFeXt0sTTaQl3mOuiG4
	 11OHdD4MA8LALmhnYugAh7lXveW77NkaBkF2G6MEtW1mTr13f91mH+3WCKAEkMBufU0S8
	 ctNC/EdGSeNS6YyMUEbW1kZ4/2NuZR57FaQIeEycKgQJgUTj8coYSvZpUUFDviL3DcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RaHcKpl8;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E708606A323
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E708606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RaHcKpl8
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso648260a91.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394841; x=1793999641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
        b=logTJEtMqiXap9pI1XvWcv6FDu12dFSQvXWCzksAzclTnomgQkxFeqve2cqXpSQCm5
         ohO179QVfwXC9rHeZ3+tuYpXOM50rC1oEG070LpqCKPD3f0xgwJW/dVZe8h8quMXgq6N
         I6dg1PlsNnX38z9pkTzWTMrTQ9y497cUaaLNWhTVzHpio998ZJlkAQq7G57YzAZr4ciw
         hoQ1yvFuVBMlB63Y1BwM+S6J5hqvjDRaMRco8UWTQm0V/CvDa59Qs4jHRh5v0+oPlQYc
         Omk76MetbaAQRe04HkrOJ4wJiHiXRhvQrkSyjxzp4DtIorsP1ZDeVXlH1qdbyl6+5+bO
         7ahQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpUurCNWnGSJUhe5Hsm1wosmaOi7IZvb6bq6+umEJlz7cH+D4nA/LcPfzoa1Xdtj4knB6BCIE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjeiJLbChI+uRbJZAXXkRmg0ot6By8W9iwiKZf/3DdO/vt0hy7
	G5bukBQyTSn0GC6EKsahPaSCj2ZW6CSm02v8fC25NAa6+g1vn3upUit5YvVRapdiI4AsuZ6syzm
	rSJnnWomrNARGyubncniMYA27YnGCUrPhI/TWONYQqPiOvAiAJTN0uc+0ELFgtTJOiYpILL+ZMV
	zymBf0CX/QSDmfVv33YOFMV8gtMAs1m9FG+BWjhasr42RexHw8t69TYC2k9SO39lKU3RQ+SwveM
	OJwG+0mJpBXUFfXyi8=
X-Gm-Gg: AYBFou3+1RzxQy68dtIO824srdlYCgNaCBWyh6vEzE07pdYzc5p6OnhWgpkV4QVKWNU
	2MgcIXd0b32YCaHcZJoX8FqVXBFzKLDUq73xEMf4RXt6VrlzmCiEOUcky31+QdZ6anTuatQa+P2
	pCRHm0HN8srcc5J2MpbOFTnIWcjD/f5QJen7wRPaVxrL6dGfAqw67c/WNltHQsfudkfpySbPqxM
	aC3PLfwimn/uxyTwPQKpUehnkrdbfdpC9f8niT6sj4EvNRBn+Ngq60Hm2GAEaAdjOgWfqtdQMy/
	m9mpnSG7sm4qllSvCpp6QeNczhXtt8MPoMACtwyNxTboP+6H2awKu0/icNSAOGKgiL7PC5BposC
	g/PZXWwxPXEoYrFB320jLe/R7SUNjfSjXdSCog5YsT7gx4rhjO/+bZXc6/0Ml2NDGDUsCyTX1Yq
	GmmuluHRbGPl0iDGGIfwLlyOxtj/4Q5fGhFbbe8mns
X-Received: by 2002:a17:90b:1c07:b0:3a8:cb54:e135 with SMTP id 98e67ed59e1d1-3ae897c9501mr2861596a91.19.1793394840551;
        Fri, 30 Oct 2026 14:14:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae845878b5sm2820433a91.4.2026.10.30.14.14.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36998507c13so1736577eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394839; x=1793999639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
        b=RaHcKpl8UsAkdGHP03D8WbCKw7SXZ3DUK9osDNmFZ0OrOmddGG1Y5VI+E+ErFHfxT5
         BKhznPF5HQ87sRxC6OKJMem9b6AXCoVczLeTFwS8UP1s4uPe4OSi2jOV64F3IkuSaV/0
         I/KK4x2qbuw4o3/+OB4h6fMStVShZOO2z8Rrc=
X-Forwarded-Encrypted: i=1; AKwUvBzetMT9Ba3td5wCEWq8LZedMYYtutqev5ch5i/6M9lWBuGztLPuCStBKVfcKsHlfXkA6hMGQVU=@vger.kernel.org
X-Received: by 2002:a05:7300:cd90:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a42454b8emr7287582eec.22.1793394838503;
        Fri, 30 Oct 2026 14:13:58 -0700 (PDT)
X-Received: by 2002:a05:7300:cd90:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a42454b8emr7287512eec.22.1793394837655;
        Fri, 30 Oct 2026 14:13:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:13:57 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netde@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	netdev@vger.kernel.org (open list:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 1/8] net: dsa: b53: initialize the jumbo frame size register offset
Date: Fri, 30 Oct 2026 14:13:43 -0700
Message-ID: <20261030211350.287566-2-florian.fainelli@broadcom.com>
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

The chip data specifies both the jumbo port mask and frame size register
offsets, but b53_switch_init() only copies the former into the device.
Since the device is zero-initialized, b53_set_jumbo() writes the frame
size to offset zero instead of the chip-specific size register at 0x05
or 0x08.

Copy jumbo_size_reg from the chip data along with jumbo_pm_reg so frame
size updates reach the intended register.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0880310c9ce3..559d4b360c82 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -3109,6 +3109,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->vta_regs[1] = chip->vta_regs[1];
 			dev->vta_regs[2] = chip->vta_regs[2];
 			dev->jumbo_pm_reg = chip->jumbo_pm_reg;
+			dev->jumbo_size_reg = chip->jumbo_size_reg;
 			dev->imp_port = chip->imp_port;
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
-- 
2.53.0

