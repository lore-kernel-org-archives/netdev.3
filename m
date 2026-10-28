Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222599;
	b=oAji01AVDsskgh2yvgkiyUtXDp6izqW+HpWzH47r7/D7Xe4ACGiW2ovAkhTaJGXPkSKG
	 PHvn23EfN0j5sTME9g3sEJ72BFFaEynQJ4sPEEC8ZfLACnuGLABKoQkHksdHhW8fM6lGY
	 Jpi0MPaUHj9lELOhVB5JL0liHWzShF9c20FMGvJ3fuWbUeLaT+mOEan+AGmleGV0kVvz6
	 eFqLf1nxg1B3beuwxeUbWwcXrBQnsgtoxKaOSNvAn21A4EFCcJJPD6GOHi/1qmF7Ti2NY
	 tCoIiuLpB1lr3GNF2mkB3q0ar5XAEIIKJBD8e3QQ/xni84qGbe5w0whNEEQyq1dhm5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222599;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
	b=fior+6409C5ybkN6yCmnIyjccRLLZ6iwH2MCMO6GN/3hg4S77xxnj0zSpy2JT5M0M3w6
	 U7Ypng5xr8mwa1c2glTbFwjWztA+5QFxiYEdS0IG7L6GdoDVg0QeocfvqXKyh++bBwhCB
	 +v1yy7DG3VeZJEFC54oNaLidQP96b+r9LuCbuVdVbISSal5+H/kIvMDkxP50ZHcux2wOa
	 a+hpYJWjMjp7E9qPd7AE0Z0sDUnRkT0hEdjb7cWcBLulHE4W5jMh6imI1qwRzdfo+OEKI
	 b4J+xQPy6Dg4OiF0W5GCty2Fx+JBWXP5mJKappht0RoQ9M0i61hhVZ5td5dq4WNdvPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="dSfw/E3h";
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998E606A332
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E998E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dSfw/E3h
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so936399a91.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222598; x=1793827398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
        b=y/ycKOsfFed2+AUzsuxbfhReay+nztXQnm8WZhInmVPg0b1Du6TTP0nS4E8LcY/TAS
         9HmxQq0iRiCin5rWOxueFosKuDEPLrydqIjAfS1viXTErttYC1OOrNho1ePA1w8gzY7n
         o8CweRfNCEzs55OiW4wZOY20lLuoPkvVhphP9LSq6aoZd/xzimQTDW/VHoSBCvg4hKH5
         LR2FrgME2pI9f7v6+d6pNkFvfw9ZMKFpDzigNUUmsS4oOCqkOAuBMwhpYAYZFF5lKS/c
         kelpL4Sk/+pxe8S5IduBFDxU2RjVsErCGEALENvmRwqQVbChBJUS+LCXR7D1/2dhWgzu
         z4zA==
X-Gm-Message-State: AFq9FYLEro4Us5v5qszJtUMff2fBx2h5q8ZtbJum46DOokwGuENAYrBX
	nWeB1Ospp8kSQWkqhlBOTRSZtcg29oq+LD8a05hk/OOLR/BcPdms8VLP6y/+HFZ2aGpg6vRsNJo
	z/RNCpeeRdT9U2l7ajXE60EIY5dYSs4Kuv6FD7E4O566NM4rAI2VmsnyFlGZHITf5EmIuv8hIO3
	lNHZ6Ouy3bPsSKOSDHA5HNCRFVMf8G9hxTmzjN8xNpOtUyutfvPbYWndVLMVGsEtWCg5CYJ1T9I
	SVRevUxZ92WEaF8
X-Gm-Gg: AYBFou0/S+VfGNBH/GeLZOM5q4ER/Va3G/FbYNHpVGQ678p4f5qK7ekKi6nvL1tj8yy
	8Y4BaPf7/4mvMjYDx7S+58kSuQqpwcEkJXAPxl4GMWL7IHKRG+3hb6akf2wklxtBnldiabYtmZo
	H8r9w2PltZZ81AYcSqYeaHOAqUF2cR6LPH1pnyIpq6aft9CKuErWmA3r0bZctttF0q66MNU21qP
	2z0vYcgMEytUiS2YpaIsM9+ijUCgcMyn32VyUFSRGO/bT6C0VJecgGiypqOG4rILiE++N5IJpE5
	jYE/pkQc8aVLMDbq+W18vETpfe425QN1HXy/RYJYrNXv6z19a/wZQ7r6Ib1fHnLjGEHy2adB5EE
	qel5/xqfixsskGLH4rAE0Toj3FTPJK425gA7IUKgzJ2ghWhWl/pv8CHBu3WeZAXrmxZLLrAeEEN
	n5pS7muqXRnShfegVVDUsJUlBmmmASRg8ZC6TAngw3
X-Received: by 2002:a17:90b:46:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3ae5823c672mr2774234a91.56.1793222598279;
        Wed, 28 Oct 2026 14:23:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57a6ece8sm1027875a91.4.2026.10.28.14.23.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:23:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so234903585a.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793222596; x=1793827396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7/S1yrh0Xh4BzOz3EN4N+JMRy3rpsmCaRVhbCsIs9Y=;
        b=dSfw/E3hAq6aXElazM9z2ErlpBFRtIhBYszqqDWBvGgmc/ltuipTXWVAHfYKP4U5aL
         6R25qFumJqNuVjAvjg8wRACR165qCuiUaz65asN/cBXiPLF0yIxQb+P8DT40BHdhT2Aq
         l5ZsBqjFNEWafjP+2jX1jeS41MNSxst0oDH5I=
X-Received: by 2002:a05:620a:2906:b0:93b:d7a3:45cc with SMTP id af79cd13be357-94408d03ea8mr517636885a.53.1793222596389;
        Wed, 28 Oct 2026 14:23:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2906:b0:93b:d7a3:45cc with SMTP id af79cd13be357-94408d03ea8mr517633285a.53.1793222595965;
        Wed, 28 Oct 2026 14:23:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669112sm1368755185a.10.2026.10.28.14.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:23:15 -0700 (PDT)
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
Subject: [PATCH net v2 1/5] net: dsa: b53: initialize the jumbo frame size register offset
Date: Wed, 28 Oct 2026 14:23:06 -0700
Message-ID: <20261028212310.3847553-2-florian.fainelli@broadcom.com>
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

