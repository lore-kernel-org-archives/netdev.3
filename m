Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654745;
	b=s6TO/dgrl26Mpzo3owSFnf0P+jfQtnUQzUaFPb7DpT23MOuYa2fRxuU8VyvbBsjxgFPS
	 vfevq7kjfe8XVNHyPTo0ZNAFN/A8Tf3+Yj6cD9Yrs0XxiVkWJ2R/9VkkX9WuZuQWXfc14
	 Vn9MLXWkLu7wVo7gUL8PRGqrEBww1ggdJxrDGDhaVN2CiAdFEVNrMc+GMLMplZJxhw7nz
	 xCwcABZbprL1yDydogI2ykmuTYSA2OnOsut32NGPlxgc3nBzk2I4ppa50CbZkp7p4OJAb
	 q6mVs2/zWyMVPLFfLNwp0OGhNmCfcKxQBp6EmCNZpacMCPw0+OtZ1jJhdz8/yBkHxOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0W+v9PJYl7SX+fCzm/LD8ucD6kmU8nLYTAcfnRV/Egk=;
	b=IeRQqF7Mzx9ce2BcNaL98LbVPvnEgs+f+4BHxAmiz/RFCR++xxGrpe046wje4NCI0km4
	 IvflxptTSSPoecyNrfGkT6c3AOyd/uDFxjoiqdSNYA3RIe/BAbaMLYyr2SxhUZMZZEepj
	 YNnXyI3T8BdBxM9sGEpLfUOhX5YAuIVbMbmFHzJMfZiPQosq+QksXGtjBYY7rKa51DPZQ
	 ZnJ2tfSehCjzrkJkEsljuj2v00T+BK3w4tkk7kCUvNX456gs8pfo2Izjm2HcskeKqq48a
	 8xERt/CXL/kwXrCJjXPTs1U+hWFWUpZuqG9ldEgvvm6YE2lq0W0v2msBspyoQdn/Jjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0KTyXh6;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C3606A33E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F03C3606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0KTyXh6
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso1403223c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793654744; x=1794259544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0W+v9PJYl7SX+fCzm/LD8ucD6kmU8nLYTAcfnRV/Egk=;
        b=E0KTyXh6fQjtB4la9A2uFpuvbHgCy2kgN5o//KtUiFjYqUzPuam2QEgKKgUP0jeXiv
         tAHE3EnHsP849pPrQCQ3cmtBG/HsJ0j4hnUO1YaH8iPZ5SmbNqhTC4Du6J1AwQV6ak4s
         tFbeGMebYh5ufE3OJtyX44QVTf9t1nS/TrEbzRcjYySnE5mwnMitQXiIwPBxZ2Uq+FCS
         L7wxwB7+pzTcvEjClyxXu+zjetg7mhiLOKkPwI108jkGDlRQzyWQ7ThDvjwGttx+neEh
         q+kK86162TVUu5FpbJkIa2oIkNwo+wxTPk0mOG50Ni81Gjh0EALZLV8R8GDVYvYelt5a
         tnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654744; x=1794259544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0W+v9PJYl7SX+fCzm/LD8ucD6kmU8nLYTAcfnRV/Egk=;
        b=w/h0/RrDg046JHYBRl47STmTcFkjcbPn2exYmMoZUer2loM3Bfj59/LiGeH8bo3OLq
         WbbU0qHSi0Y8SEyxi5l5fO6gJu0AhT/v5ESou2thFxzEE1ncSKvabQjHtGBH4RSbCbmq
         6LIDAALPn2ukObHBge51q7kDryhhRyjOssxUhLsA7AkOYZXr50/GCuo+pS63wOICvlH+
         78FGbn7O9y1GOgVBuH5WCEGclE/YHr2NgwAgK9gGiLnTQf34xDknKPSih9oKK4zbdfy8
         6/cKtONZF77izzf4ycg2I0IEsAKFnGX83JuhJmWQl1gzEqn41HiobBFkfyeXVhUNRegj
         a4OA==
X-Forwarded-Encrypted: i=1; AKwUvBw0x6UpuSoVinhhGDgH9tlCvkwFbZ4/55OY17TXtiU6ypmcsu+fpWcUaxMybkxd1u9dAPog0JU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NHB1LwDcNnX52jiayTRe0Yfnn5Uut5RXhxNO1I5S5Po3Y7tTg
	01KT0kAFoeQ3R54xv72SCTUFkYMAc0Br5EHCpqh0h9maXo8/NB8Ib6m/
X-Gm-Gg: AYBFou0Uk2lE9CNa3fkQsoGcO4kxc7bCxNPkEcvq60dvX8fq6CLat6rt5gTewTFY4l4
	wRQ+op3U6vvIdvsenLpiAM33YASbXCOTcXKO25mxKWpJs9nC4pJW3e6dbTbmThZaQ8Yg24R+cz7
	6nfou/ZP7y0XE0KSe9BQi5Ght3EcFmolcT5SSoOFsfEpL+2nN8FvjudSVLlISUli3LPv7Fc2hAK
	lzb176r41Uq8UmcjKrnHCFBTmTtsakBXX1xsmnTuldMHr+E7UJmyYKImEZvVSl70fuanHZMz5NC
	BX/S7FusJ2eh/p6m8f1490qQl/GdttTU5pcQcep0kp5HSOh6Pyuxh1MGBVXvXDltTCeqLFNibTX
	LMBBsa5I1BYfFES58CWrNRf6y5Kt4JSwWZKOJk/12f98rdKeKXD9kymhrQnXzHoYY+ukPzv6ZSK
	lSr9dvE8xIcIzR7/Bmoq1dn+rMPBhDodzBSxXkvUCBVbHf+USYf5jFOjZcGjikvG6UxfNMXLUSp
	w9UohGDrxRE6RMf3nKzEOAim1/Hp5VbKt8EJvUUglMZRWll2BhCLg7i1pmbdbl3HCcuMaXvV+b9
	gz1KR9qN7a/9623DJHoHDViMHk4=
X-Received: by 2002:a05:7301:4b0a:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36a424199eamr17269236eec.23.1793654743982;
        Mon, 02 Nov 2026 13:25:43 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm37195851eec.12.2026.11.02.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:25:43 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Stuebner <heiko@sntech.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net v3 2/2] net: pcs: xpcs: make supported_interfaces authoritative
Date: Tue,  3 Nov 2026 05:25:07 +0800
Message-ID: <20261102212506.3348537-4-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102212506.3348537-1-coiaprant@gmail.com>
References: <20261102212506.3348537-1-coiaprant@gmail.com>
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

pcs.supported_interfaces is the mask of interfaces a given xpcs
instance actually supports. The compat table describes what the
Synopsys IP can do in general, but a specific integration may support
a different subset: the RK3568 XPCS supports 1000BASE-X, SGMII and
QSGMII in hardware, but does not implement the C73, 10GBASE-R or 2500BASE-X
modes that the Synopsys compat table advertises.

However, xpcs_find_compat() only walks desc->compat[] and does not look
at pcs.supported_interfaces. If a caller ever passes an interface
outside the mask, the core would still find and configure a compat
entry for it, contradicting the mask the glue already set. This was a
known gap: the mask was written but never consulted by the core.

Fix both sides:

- In xpcs_find_compat(), return NULL when the interface is not in
  pcs.supported_interfaces, so the mask is authoritative for what the
  core will configure.
- In the Rockchip glue, build a platform mask with the three modes
  supported by RK3568 (1000BASE-X, SGMII, QSGMII) and intersect it
  with the core's supported_interfaces using phy_interface_and().
  This narrows the mask inherited from the generic compat table so it
  reflects the actual SoC capabilities.

This is a logical inconsistency rather than a user-visible bug in a
released kernel: the affected Rockchip platform is not present in any
released version, and the MAC side forces the phy mode, so phylink does
not normally pass an interface outside the mask. The patch makes the
mask the single source of truth for both the core and the glue.

Fixes: b9e7cb89aac8 ("net: pcs: xpcs: add Rockchip RK3568 platform glue driver")
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-rk.c | 10 ++++++++++
 drivers/net/pcs/pcs-xpcs.c    |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
index 6f0a110e32d2..25fdc9c6b72c 100644
--- a/drivers/net/pcs/pcs-xpcs-rk.c
+++ b/drivers/net/pcs/pcs-xpcs-rk.c
@@ -483,6 +483,7 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
 	struct platform_device *pdev;
 	struct dw_xpcs_rk *pxpcs;
 	struct dw_xpcs *xpcs;
+	DECLARE_PHY_INTERFACE_MASK_ZERO(supported_interfaces);
 
 	if (!of_device_is_available(pcs))
 		return ERR_PTR(-ENODEV);
@@ -536,6 +537,15 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
 		return xpcs;
 	}
 
+	/*
+	 * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
+	 */
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_QSGMII, supported_interfaces);
+	phy_interface_and(xpcs->pcs.supported_interfaces, xpcs->pcs.supported_interfaces,
+			  supported_interfaces);
+
 	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
 	put_device(&pdev->dev);
 	return xpcs;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 6466e0ff2a98..46878a66064e 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -169,6 +169,9 @@ xpcs_find_compat(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
 
+	if (!test_bit(interface, xpcs->pcs.supported_interfaces))
+		return NULL;
+
 	for (compat = xpcs->desc->compat; compat->supported; compat++)
 		if (compat->interface == interface)
 			return compat;
-- 
2.47.3

