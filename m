Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA8A265623
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786754922; cv=none; b=ePN+LxkeAebdiquAIKipTNJnyG2Rhf/ewI0RNoi9AuStnYniHAWi1zYIPAtVcdjPdLvk+QqyhA7woRpXFPXS+bnqFIooHyJQkUeymd0fhLO+B71hPV2CmTouQgWfDzcypMsDTkDJYEayHluI6MOPDYiXEZDwmHheE/Ob3W+D484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786754922; c=relaxed/simple;
	bh=1LnCRgjE5GrtVilnDq6Mw+CJnt8OEZLKDembPlnG1UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSvI99viecoJCDTE6h5YPvzSl/jeKNt1Eq0KmvCnICzZxMMOwdkb0sXYYT9fAANFR+/1T+5wvO+HdrQns1YKePgoH4rZCsiWLo+6epiUrnOXcJ3JR3LdFrXfIFhFKiNFNWlunLlv6N6QmAcIQ/I7yi+ynRV7+fMQLZO1bOvcYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biDmOmnD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biDmOmnD"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b04c0b9159so1003193eaf.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786754919; x=1787359719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kbg4qcFK/mBxoYXCkGvYYK5TXUGZpjr2DCvrJZaXNS8=;
        b=biDmOmnD7DTVdha8hx+DQkfJo+m7eWvL2KNHnqgpVwgSSBQp4dOSCQPg2JstGhupJZ
         jLCmqX9/opdGbGpQ6VCF2jtojZ/XPIw2RT49PkObJiL9A0lkqYMjAF529RapyAHlSqZ8
         CFPOA70KWgu223eIeQaXrx5HR1l/8TVpcv8EALoO3sPJPcLMpZBoUIMN0T48HUpu9jO0
         37RxqNjymsIGuyzmQ4GhjIvh9QQyiWlLLuIOLbRPODyrQNNm5eoUZZIEcR7tWKppgn3M
         HJ7FVSiGMbwbqqfJLxMBSvMWJ5irY8iYLLHZ2um3OC3sHOdTO0A345PHRsZ/cOmm/Ket
         /xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786754919; x=1787359719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kbg4qcFK/mBxoYXCkGvYYK5TXUGZpjr2DCvrJZaXNS8=;
        b=Jm1vmiIpBJ5MZu72Rt0XGuBy5LFbp49DOMeWc7QbJaYWz/dadYI1JWx3bJUTL72srS
         R+PUElspbR2Tnvck8GQsKZE0fPtJeUjtiAp1vfSI/CMt+TYDB8rn/o+ZIkOJw8d81oBi
         Q+xLTK0uUHLBIgeUTADzSseUPh6eo/7VbKtAAN8iaiyJIwpYLmSMZqz31V9XwNp4dHKM
         PuCSb93+YEFrkL2TKKXXLqXWv0h/CNwpnqMIbPFo+8PoubACZikwanx/62ZB3j1d31lt
         X4eqXezjrKuK/Sqnwr53e/IPV7Civ4IIPw/GXgI28S3cWwR9vpHmyI5XWtFjlXa2Wl/e
         PR/A==
X-Forwarded-Encrypted: i=1; AHgh+RooezBQS3UABXxY6I8jtNNn+yO7kwyhHcm2NiPdJ7IfcfkAS3ZcK/7TH7s7xMO9vfRlQyogA7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8XeWRhyl3OyyN2hzfPMChqQwu9v+NBeYNPrFNraur9k+ybWw
	oS+phlao1O2Sa9sH/zdRz3kILxyrz2r12sufk84rFwAHJLIVimblePBswknHRQ==
X-Gm-Gg: AR+sD10JXj42tcAvQ2QPr5Lh3gvaXl6+TVArL1DYDFxe3Vx8zazYoMndd3QN5o0hOWc
	cz0GzTcTs25xSJ7VM5UEHy7uxyqGToLP2otLE68h5Gcv6aVs+a3+ELE2f/viIH1swWpczysgWWe
	UYMRynq6WObJaIY2zT0uIw40KnI3pymcOh6hYXZZxxtSoB5lz9WRA251K1j4TC3N983UP/AWScQ
	hmuHB0I+PL31TNenPPy1NoeO7qbbiysgKoJt44khZrls/ajFi/vVuoL98N8NowL6ShOtx3n3iKb
	0MOwDIIA3jjiPKLwrR2w0kBE26q4Q5cR0/dV53o1qytm42yaiSZoTIdu/LSPHrQYxiof01Wlz3W
	e0wlQtTAajEcO3fPuDIV+bLdHxzb+8b4vlXHkiTInj9Th/xT8vtAHRTKAwiSkXWJIUQCvreGQW+
	RToUMoGRNbKDihWAE/XndoxAxm3X/bjnNXFDHwtWdASCtXQfmSiacPC26arjBp5q8nyDxcK8LwH
	9Q9GVRdElFFLyRhx1LPJE+C7ieoRvzkZeRyQWpWZDCUN1ktKvzt+ak40xHDNZXn+ANaF552ZNX6
	WPvtaMMqeUtpOMhWuMx10nQpSRHWVggEJohF+WKj0K8S58cejXb9lFvp98HrHasl+5fcNMH8/rH
	ZC7sf3uGhjbt8zkFQsQ==
X-Received: by 2002:a05:6820:2916:b0:6ac:9729:6710 with SMTP id 006d021491bc7-6b0d6a8e9b9mr8697804eaf.18.1786754919602;
        Fri, 14 Aug 2026 17:48:39 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0d9574d7csm3240730eaf.2.2026.08.14.17.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:48:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 18:46:17 -0600
Subject: [PATCH net-next 3/3] net: mdio: release fw_devlink proxies after
 population
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-phy-package-fwdevlink-v1-v1-3-2319844f057a@gmail.com>
References: <20260814-submit-phy-package-fwdevlink-v1-v1-0-2319844f057a@gmail.com>
In-Reply-To: <20260814-submit-phy-package-fwdevlink-v1-v1-0-2319844f057a@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 netdev@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

fw_devlink creates sync-state-only links from the closest existing
ancestor device to suppliers of child devices which have not been added
yet. It normally drops those proxy links when the ancestor driver
finishes probing.

An MDIO bus is a driverless class device, so successful OF population
never reaches that lifecycle point. Its proxy links can consequently
remain forever and prevent suppliers from receiving sync_state() even
after the real PHY devices have acquired and activated their own links.

Call the driver-core cleanup helper after successful OF MDIO population.
Only sync-state-only links are removed; the real PHY links continue to
enforce dependency and runtime-PM ordering.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/mdio/of_mdio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index b8d298c04d3f..49f9b4062cf5 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -229,7 +229,7 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		goto unregister;
 
 	if (!scanphys)
-		return 0;
+		goto done;
 
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
@@ -261,6 +261,9 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		}
 	}
 
+done:
+	device_links_drop_sync_state_only(&mdio->dev);
+
 	return 0;
 
 put_unregister:

-- 
2.53.0

