Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506629;
	b=KsjLH8tyGvb+goqk7rbyKW4nCBmpaKwY9uJP/t0ONPIcCVT29L/8MDOTaCXvEDSuqLB6
	 ie4zMeCmZPKNmc/CZDIlm19P1MqVZ++qG1wNrL2Sw560Hq+EjP4U4/EYn34DVFKc0GChU
	 w4D8lmdHiWu3CWQ+BmQ06ltnJGUjuU7rRGtFKEbuL1ulDAEO6e9DxvxP2ZrMhXtepMSf5
	 hqw7lY81lcupizlCv1vQ8o2kk2b7vf1FHKLAp5zLt+beY97gJ+xa2zpl5nl35A41RuJjK
	 lnmjnL+ulREU1cBDg5/k0UHcnTxMdtcXEEGh8VRJO3y0sDD8aTld7KaNbOcRd2w0bkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506629;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=OUNtryZiIEIq19vN65HJanQDCXRhp3Ynr4zR++YUTaA=;
	b=r9CiCwiaJxBaDCCnFrzW8MSOiEXV3ddQNZgQf1ifiCE3RM803wRgpcLfQTcMXqRqW5om
	 sysAq4UWKFmVL+BsgMx+5MyGVAU94MV8+7q0B6sLqkL7MIxBWqCL26NmGglbY8NH+7uwz
	 Rt/hcWrU/05F6TYhgCF8YMpSCkWNUua0x0f6nR+Y7NKkXsTuugwJMygEYVHf22outMi/r
	 4XysoLTG60dqHbO6f492qawlH/xUMAcimNB6iYPkWUiPiqF4WXHVcvEsFOHLLGT5hB9Zr
	 onF18XlkBZTl+BTnlu0OIfJLL2MD23yP1vaj+AFIHg9ami1jsKYHIjYwzFHbT8MIJ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YYk0I15C;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA6606A33B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39FA6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YYk0I15C
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so28510a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506628; x=1795111428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUNtryZiIEIq19vN65HJanQDCXRhp3Ynr4zR++YUTaA=;
        b=uKSBaWy49JNgNNrWK2oY08Gnv+MnDanTIDjqYJ25zAxk97ylUkVKVIwLK9Yg3Q+UGL
         BjeDlRbggrWpJPezmrZuFebMQvUE5Nue4m+7jsunmvm4sP4vxTvBwwBB6vizfQ+U5bSi
         7cVp6vDtvLKpii0G5gZTZQcSO4bWMBcmLn57Onn+zwhaVb0xXZAE3E5GkhWZxTokfgjL
         rG2IhbkCvDyVvoROCTDUU4W/iJmoCY+MFVg/kW17T/we2RTULutDToz9OUc8wb1iV3E0
         uAKwGpdkH38BV1nxvmmlCSXgADPZU98PBzYUKS9VK5dqpzAcP19HP5LtJJastB6dtORo
         Rk2w==
X-Gm-Message-State: APuU4Z97T6AVjUcATFUo5AmfRNx7LqyW8xMgwnP7wJ0Io2jxjEHfYsQa
	ZjiTv8BqHVz3GtNlhzNdpNYAHVut+I2LH+OOyfgsLFHE3A2jqKGiXxgqTvLpB998Uz8/ZrSdaF7
	YXzkT0lE62y4T2HpOmqcO1iZMOs0zLQTlCdBSmZW9nFFHUoLJH/6l8aKYNRY7KS7sLfcRADVWss
	oMUzlI59pqd81kDhLO2tFRVsyZxhz/8kc7OQ2PgIWE1h6AynmcCrWVwgXHUKwzXFcqnIb75se6T
	fe9inXBRnc60Rwl
X-Gm-Gg: AYBFou0v4UDmDyhk3X4+oJtp3xMOgPVOY6oPNiJBu9UV8/KBmGZSuLwwYPnwBTnVyJn
	kK96MP9ShkdiyvICexTB+DIHx2+FATbLtKDoDez4UpaQ40Wiqg28NUvTErZ3kDhCMogm5j0cfEy
	OLwArd3uvb24MqWLyFsoAGiAJhBN4HqIVAabrCO0gIk2I+vEfQ4EEYyHsiJve9GFqQtTufZHGRp
	RVoFb9+6fqEdXwDaycBnji895XNxexImW7I32MoqhakHIAZ3lA8DaY7cyBThHN606FhSngTPfvo
	qM7H/qrRJ+vWp/ZYStS0PSYLWi8qNjBcsqGZvrEbsQXvuE6Ae2lUmubMAh+SkF7AdHLCYJ35hup
	E0x2oQC4wtNy6ujMdxuMqfAG/oI/HGYGjLG5bTYTiHrs4PVvEdqaVCs99WJvPJG70gVDWlcoJfN
	XGagDSIJ5KR0QJ5EbXSl+wtD7+j28kW7pky8tCaW7k
X-Received: by 2002:a17:90b:1f91:b0:3b0:9782:8721 with SMTP id 98e67ed59e1d1-3b182f3e6cbmr5687766a91.36.1794506628315;
        Thu, 12 Nov 2026 10:03:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b182df81cesm2656972a91.4.2026.11.12.10.03.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:03:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad53f538d2so25678a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506626; x=1795111426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUNtryZiIEIq19vN65HJanQDCXRhp3Ynr4zR++YUTaA=;
        b=YYk0I15CFUnuH6VrRtFI0W3i+nJtfbuK/Q87ixhhGb/ebyq/tEwRK4qG106xJ1aUfS
         FC1nXSMpJZaylG5Mc4aFFkTLH9PdVGqIx+v7pdwHZejiw3xSZlvE49Yq84fbe7Xtifjq
         AwnkHm1MT4zwUOgHdE9RfMr4EuYnxV3Sv55ik=
X-Received: by 2002:a17:90b:4b92:b0:3a7:bb1d:3688 with SMTP id 98e67ed59e1d1-3b182f26aa1mr6246575a91.27.1794506626210;
        Thu, 12 Nov 2026 10:03:46 -0800 (PST)
X-Received: by 2002:a17:90b:4b92:b0:3a7:bb1d:3688 with SMTP id 98e67ed59e1d1-3b182f26aa1mr6246527a91.27.1794506625516;
        Thu, 12 Nov 2026 10:03:45 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:44 -0800 (PST)
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
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v5 1/8] net: dsa: b53: initialize the jumbo frame size register offset
Date: Thu, 12 Nov 2026 10:01:55 -0800
Message-ID: <20261112180202.324504-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112180202.324504-1-florian.fainelli@broadcom.com>
References: <20261112180202.324504-1-florian.fainelli@broadcom.com>
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
index a2a5754c413c..ca2ba8c157b7 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -3172,6 +3172,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->vta_regs[1] = chip->vta_regs[1];
 			dev->vta_regs[2] = chip->vta_regs[2];
 			dev->jumbo_pm_reg = chip->jumbo_pm_reg;
+			dev->jumbo_size_reg = chip->jumbo_size_reg;
 			dev->imp_port = chip->imp_port;
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
-- 
2.53.0

