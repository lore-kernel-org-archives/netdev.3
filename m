Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F4242D88
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786754921; cv=none; b=lBRc2hhz022JOOGAx0o+rN+AKvF0zmMd/vcSfp1qruML0Wn8sNJGHpafexJh6i8ulWuE54uey9rdJM0goMSWFfRE8LncNlguFPgRzw/1A1dRY7xsskJr8t0AAcrEpMqoQ2kZ5AZvEWLU66sgaL2CunutC76t9QUj9Wj/N1nneok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786754921; c=relaxed/simple;
	bh=w+LhzNyKmZfjHXx/GmE0qF8XZ+mdBicKEri2vAY7vLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huJh6Gnucf2XHu+NfJweeM86wrNbsd7tAf+XNnsR4yls/1CfIEFZxziGRMj9tf0DKopJPoeU7AFmlBOPv+l2hj8wMwq10QPgB1tgKAlvGEZYPV9P/qd6voEsuXNFb4YUYRmO4IWJGYJL1Px8SxkWw7yABQyVkCSek4uokUuonQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsz8WpbE; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsz8WpbE"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6ae9b721927so1095190eaf.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786754918; x=1787359718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EURhxKL3TrXjvLpoGsii38tCfdVB5DjMF9c8u1cOGE=;
        b=lsz8WpbEhzobrbX7mhkCfYVjv0YK8l6+OSMvm18jsjL751XgawbmCx56/NbSVwJY0M
         yH6+pEKO8VTA+o6KLTAIhQwz4wdP8Y6bSKnpNwNu471mv2uxC37fDcWgYLLWiG/eJkn+
         Xp8/YT7eW6lV/nLLWR3oxvc2WBauAPjyP4G2tAkozVWE7pZT5DEd3SgPgou89oC2JC1L
         TDq9YipQqcjwqk1RqEDHm5YZFEU9tb1vAaL6IKPrj6ciFmMEJjoiNcbfx54/cG0/HkTG
         xczwnpuo9HoVvxl+OlCfGMdnMIgTh76ZHunU41Kf0s4TZ9Bhqi7Ec2Fgx4Jbklau6qak
         jR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786754918; x=1787359718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1EURhxKL3TrXjvLpoGsii38tCfdVB5DjMF9c8u1cOGE=;
        b=HGEuZXEJE0OoyyBlcV1/4h/xzYle4pTOy5bL1t1pQ5zZC3qLpYPIicdYVlHtesbPxJ
         Eo32dXG2qoPVhqhX5ijbns9mMvRXXuPfHJaMt7+++YuERTQnAH87UKQeCS0ZMuzvfLUA
         QpS3XsJJdTuYS/0JLmUdTJMbdZQywlEsIXYChxGfjuLiG9TLp4J2mur45hIjTY8n1P+o
         roQiH6jgY4owpjOIhZ+IrpPJ8LKUQJ2ehBwapNKJ/J5C8I7CXqVPOPZeL5Zh7i2LYp7+
         PySd8ySrAq+YTkm3mE5BZoi9hrNzj5TCFbLKyzlx/kwCDvDWxQzhoRoyYQ8Srhdw0p+M
         eUJA==
X-Forwarded-Encrypted: i=1; AHgh+RptkTMOsFx0SwywrVppIIq58xPpGNo+Dudcnzbfzmq7WrKAY+p1KAaT/cm4+m1TOu4WTnpw1Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHu0S/a4si6lI16M/7fNWfDVxx36fRNZVmaSZ6LW7ZhHKN5a6
	FjQWKecXWtOERgFp1FpiZIdSDh49OV2Oad1RjOxgdUwwZPUZVPhxH+sb
X-Gm-Gg: AR+sD12ESpT9LYhUrzPropVSDbb8VcOnciyHNDNCoFaGBl1a1A1stGmC21XfguKK6BA
	MtoAQp+tRm1cguYmp4VjONo9Hg/p9KlCtPtleB/vh39e2wTw3dIojsDHNIRJmSucapKeSaWH1BB
	VZAgp6IZC4j/iZ7UmYOQB2ybScoOdI28+Ge2AkQZkx0W+dTW1166nZDTIgPx9tx1NDbXGFlWrvn
	GL88yRHqfAsC33D1SZjp+ZOq12qGcNL4j06JBELdfx2Wp0uA6xW/G+3e18darkLdVoEqmxao8TN
	qH7JG2JQrLv/EY8xSBIvOidI3ug/S7RRSg8ZJP4fFAlZ8xobYv2QEvu2HiEFEkgHpPdK1G+/dwT
	4L1iyYN0f5gEBc57sdyzJ+fEyarQtjc9PaPNoACr3dyLgpKCHKrD0wZJAz4op/jUh745BcNnhmd
	Qk10jb7OQLZh0tBtdsCpFHjLz0hL8ykMxr9co18cWsQ+dXhKnAwrQfEVy1y73avedf0BdrtHnd1
	GBTofc610K+y7clftizFd+r8Sjy7k27VlIHVu8+DK0EUGTti6JJer6eO6xw5fgag7KrE9gn8xUE
	NZZjgfWUP/tsBfQIas7GoGkRQYgFqqvgLlEfgIua1GyaUlCBTA/bKTOmLIoDkVSjOeV5ifEd8ky
	HEqLuxPkZKLljzWze
X-Received: by 2002:a05:6820:4b07:b0:6b0:abaa:bd3 with SMTP id 006d021491bc7-6b0d614726cmr8530774eaf.9.1786754918519;
        Fri, 14 Aug 2026 17:48:38 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0d9574d7csm3240730eaf.2.2026.08.14.17.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:48:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 14 Aug 2026 18:46:16 -0600
Subject: [PATCH net-next 2/3] of: property: link PHY package suppliers to
 member PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-submit-phy-package-fwdevlink-v1-v1-2-2319844f057a@gmail.com>
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

Ethernet PHY package nodes describe shared resources for their member
PHYs, but are not populated as struct devices. fw_devlink consequently
represents the package dependencies with proxy links to the closest
ancestor device.

The MDIO bus is a class device without a driver, so such a proxy can
remain available indefinitely and prevent a supplier from receiving its
sync_state() callback even after every PHY has probed.

Treat every enabled member PHY as a consumer of the common package
suppliers. The links can then be converted to links for the real PHY
devices and retired through their normal driver lifecycle.

Fixes: 385ef48f4686 ("net: phy: add support for scanning PHY in PHY packages nodes")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/of/property.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 72cf12907de0..f29ba818ecbc 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1272,6 +1272,20 @@ static void of_link_to_phandle(struct device_node *con_np,
 		tmp_np = of_get_next_parent(tmp_np);
 	}
 
+	/*
+	 * An Ethernet PHY package node describes resources shared by its member
+	 * PHYs, but is not populated as a struct device. Link every enabled
+	 * member PHY to those suppliers so fw_devlink can use the real consumer
+	 * devices instead of leaving a proxy link on the MDIO bus indefinitely.
+	 */
+	if (of_node_name_eq(con_np, "ethernet-phy-package")) {
+		for_each_available_child_of_node_scoped(con_np, child)
+			fwnode_link_add(of_fwnode_handle(child),
+					of_fwnode_handle(sup_np), flags);
+
+		return;
+	}
+
 	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np), flags);
 }
 

-- 
2.53.0

