Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741992;
	b=GYhFzZfzkqurnQry4EDcYAwKUN6Hstql8rK+Jg1fEK4gjJMoY+qWLU9Z3BTfOqIvkpMq
	 ZUVpoPjTPoS6WIrimDsUzjPa12NnbxMDAKpMno6e+K5c7I/BxKw7OOlvbnkSCMXYy2x8c
	 jKdSMapkvWGpajCZ5FgNCWWY+8+mhVdoonk6qKLWs7tE8T8r2H4ytE6k0KDxiPjuHzHMR
	 lPRvToV8aVwz0pJZ7iYJTbS56I33OMk2JZLoG9omQdaokJaz42u74aYffeN9WkmtAvdwB
	 AXdInVeUz36aGsdJ2QzhEPAlYXl1AcEvESiSHyLoDvY4y9JVS5X85xCs8CTS1k8xftg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oKDGcISKRXyb1sB9uqlDY+pTllRaTOFvJWwaXJaklRE=;
	b=jDy3F0Zdfjh5bKHNCfKpS62feP4ZXGCYpm+hqd9Ysk88Cm68FpFtPHBGFhyENJrF2kVm
	 fAKZ3+foaUDTmFQkg9Tnd3GYvGXkWqNTVwbVLuY+SG47OE808ldtMgYoyVzjRiEtCnh8e
	 VkMItOInbPeZd/s5CHu0VTkHaXCErgnOARKuJ1qcbOOpQkC8foNCHR/Nub40d3ALinsIK
	 d0ttsaCTUFk3Oh8Md+kJufXBmCYoo5N8NNsVh8TtdqTaZv5E0U3M9vovfVwj9G6GlEISE
	 6mMFf+P3aeQAsnlq0T6WVUNUcSSOynFxeHUokqcJI8WihmkSRok5IEHtAciftoQmUVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eiOS3Opq;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF5B606A334
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF5B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eiOS3Opq
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35c95a3a303so64293eec.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741991; x=1793346791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKDGcISKRXyb1sB9uqlDY+pTllRaTOFvJWwaXJaklRE=;
        b=eiOS3OpqahCkc2IWWON/xelWyX4TPHoReJ28ISX+sQhBpCwrMIc6mPlvZRiBn8vvvL
         0QGmy6UNMBp+cwKIgTcHduqgWZNsD+75bVsJ8LwWnepmdHPxwkf3QHFboHpB6/uluIbY
         vZ6geobCl5/VQ04nodhtLqypj8NDEOHMJaopbIOA35Lou0fIqCLKD+TDv9hOLvfuPU2U
         G9dEc3+/bnU/mpAC7hyCkioI2g+Tr1z26urE+J4hO+JhETrc8PCMoPsx7o47y19vDHfi
         Tm9k0axGaB1h9s1Cu7GDvk0DGS5UK/7eHj2bbxe6PMlIjn8e6s9xwZVsS8lg008okPtw
         QZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741991; x=1793346791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKDGcISKRXyb1sB9uqlDY+pTllRaTOFvJWwaXJaklRE=;
        b=rW+AViqbjFpdyUg01kmlIEUuPUBjDKNoDrCQJiCtcv1npOoQb3IIDnjYFYaWoaV7jo
         QLKxv9mAbezc4Ni222+uATI1I/cm3MBJXu5iWpbPCPUJq9lY03IxUo6Eox+sPIdInv4H
         sdFRm1Pxj+HWksaW+pFvG8hXow2ahb0Q3+iEB0NyZC7SE0YwrvTDXmITWIpMz0EOljXZ
         r7T8Zej7H+6nwjSc7tr9//dux8PkGVM2I/xmn86bmN2T0R6Z6IthTTc/1jqlE7zOU6iH
         eqGjo90Yc2hgqaxISzuINeHyKoHopfuey3oz844MZ8yzIYK+/Esn8MVamzmP8yOBCxit
         1iGg==
X-Forwarded-Encrypted: i=1; AKwUvBxVvK8QG5aefIEHJVAwmujRctQwDZalTqaSW0wkVxmDrOgJjHMaXfYKocd3YuIncXCuLG+svNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcuXKMXOR3n3SWmQ8lEFrKu/bagfMDdfHojjdFxFUxlbdFQroR
	TYyu+6Rxp7j2J9VbmAScx8Ips+HfsU63XEsuChowgBwgRL8rIkCCUjhh
X-Gm-Gg: AYBFou1nFRARXzjgOWiwWUMtRyvwqGx3wYhtOxCxhNufXIo3QyhxkJXDYvkf1f/jrvk
	rDf9ebIETSWhJRfFIANTdjjBXrlzrLgBwdnoRs6C2lVgA71c6EnBVKHzofpgaz1ojYU0KOtcgoV
	w3fV0rOzR/s8/q5cd9p2eZjfzBGf1B/LbV7n6BTNVOTEIkOL4DKrIkTTz+jjCe10r7VN43ipFHp
	Nrv/d7BP54XvUVT33neiARxaAWJDhVanMN8Q8+X2zxFT4FdqE4qdEBJKiVSli/GAfreRNtoMjOy
	W+BMe7smPJ7JqP1G2Siz+OHO/qZXY181yETiTNQQNH3gueNG7oi9f/A42Kf98CgX6iJ/fqZM6cF
	LlL2te6wrh4oZOAm7fz08AUIfqlux0nzMYEWlDkA17Qg93ENCUH1y9SMnH/TQOrshFn5dU46Ptn
	mbf86CnpXgwJnfoEG+eYmqgHcMFmzVEXYnm1Mj/djsQwAH2cH9FwsKmxbQvKLQy97334RrKM8Bc
	kiKIrrsp9mcqxCiTo0VApygmwyEGvKsSFA6Z5O7d1fAdUGtJSsF78U=
X-Received: by 2002:a05:7022:3b89:b0:196:b805:9546 with SMTP id a92af1059eb24-196b814d873mr867259c88.10.1792741990964;
        Fri, 23 Oct 2026 00:53:10 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195eae0e830sm4122132c88.10.2026.10.23.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:53:10 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Coia Prant <coiaprant@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/4] net: pcs: xpcs-rk: fix cleanup action error message
Date: Fri, 23 Oct 2026 15:52:14 +0800
Message-ID: <20261023075214.1793922-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023075214.1793922-2-coiaprant@gmail.com>
References: <20261023075214.1793922-2-coiaprant@gmail.com>
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

The devm action registered by xpcs_rk_init_clk() force-suspends the
device and disables the EEE clock, but the current error message only
mentions the EEE clock. Point at the cleanup action by name instead,
so the message covers both parts of what the action does.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-rk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
index 698a43b75334..6f0a110e32d2 100644
--- a/drivers/net/pcs/pcs-xpcs-rk.c
+++ b/drivers/net/pcs/pcs-xpcs-rk.c
@@ -365,7 +365,7 @@ static int xpcs_rk_init_clk(struct dw_xpcs_rk *pxpcs)
 
 	ret = devm_add_action_or_reset(dev, xpcs_rk_exit_clk, pxpcs);
 	if (ret) {
-		dev_err(dev, "Failed to register devm for EEE clock: %d\n", ret);
+		dev_err(dev, "Failed to register devm for xpcs_rk_exit_clk: %d\n", ret);
 		return ret;
 	}
 
-- 
2.47.3

