Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B93783BE
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036355; cv=none; b=FdyHEmhiQETAFGWbNFuJJBWMEvsNnUL0QAOQNtVcOTmYqgDMk0pvWYSZ/HtE+sanh3X0YzvkhzIGXsh1xVXkuR5cQjEGYXuQ98ZBOuLZr+RVfcc5pLiLl/JuRlrqOcsyK1gBgqN7wuKroXzmpWghiewF9rz48tdKvwrtO8b2tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036355; c=relaxed/simple;
	bh=lpooMWHv82XIjDvzakLEMxHa3gXYODF/BcalyGR4G3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUFQH6gfMYoBVIthA0wmT4o1Dg0OVJhisg/9EyjYDLjh+NzSOXm/vYKMqZxKKisOCmfniBD64OySecPQZNLMUkli2nhgwzPZZiktyqrGNPqfaIlWY+b8eQZc96FXdArNivJWqutPrRLkZnvIUqYKW+8jS6n+NmLThOoIOwJje4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DubsuqS8; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DubsuqS8"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f42ef0b693so96331a34.2
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036345; x=1787641145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R217ybDpCpG69XJL0cHI6yEG9QeM+58x/vvK44Pn+nA=;
        b=DubsuqS8BAwX4BPczSNuq8eqtwVARspkZ/fljGSZOeKK9aemHeN+m0LYYb1lav3CIX
         1oeYwJkxw4aTBpa5y7/c/WyB3472I9Y/tvaHZQXUMyVHBzgrv1m+kk346HPAcoaIIExX
         xvBkZDHsVc6K4QtUJiYlETyrJOyxUQR44NcmHRdNxl+Gq/I6llIudYVqHwEGejHSmEr6
         NRidFKmRb/S4BiayjXclMEsgIYopV/tiHIx7xmqT/oQebwx1dwS3cvHAkeI9A1M/vCvN
         jZ+7VhbUQ9GEo80cysYIt6xl/aIbG+kF5nHhixEQ8Bbmu3SAgWOHmiGlzTSsUg2qkRKF
         3vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036345; x=1787641145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R217ybDpCpG69XJL0cHI6yEG9QeM+58x/vvK44Pn+nA=;
        b=jDAzde7MOhDpyTJkQVSy1qktmhQ14sGiLOs0zAOWUYF8czZD4ufvzE5o1j6T+iGkBU
         6HocBQaykeABD30/Pq20Po7Xv6bjurSe3hHtZh+wA/jpyj15dSXEn3bwhiRHtmkXAU9D
         4kZQLgIObOVIUtc28k0cznf3JnGpk1F+fM0WnplURMopIHHKiDXASqJw+kfDE1CMBLyR
         00bMnKkM8IZANqB5bjCTjkZTHrpNj9jUVBjnQ2KxlwWmD7Mg+suML68gN7rC6MYHp+kG
         LsVcwqYTM08qxJf97uLQ5bsp8XSYipgsra0PHrCO6bkhuxrWBgz/50Q6Mm7IrAv2eefc
         2I8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrcDYjCyB+0nysqDKfOOdg1jewnKu4oowgYB8XNgqFfJOUo3df1sp/roXiDCees5UW6E6hM3co=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUPHGlLMGHjMqeF9M7ArXanf0em4GFywCgS/Ou8r8pXAX1DGw
	VrX6rRbtXI0iP/9+FZotxKniJ2GshkB0ezqyAiOIHb6pRGQ/7+7jOC+7
X-Gm-Gg: AR+sD11/DQD+LLTGJNIM1X9MmDaUceAjq6+TtZSKq0zr6o/p0g7+PPvUfbd1gaWOBsJ
	qcvi3YCRmEIsQQhQttHLy70J3KdSoTbtib9KEY0au/73JKc5fbPy3oBBKX0HNQWJEGXYQQ9i0EO
	H+C+HE48xG+vKs5S4rjEaEdcJqTLapsdRRLw0KTWibWqrRJ+2k7+abiEIqnHjFoB1WY9xXmx/WE
	kBoCKXIhgM1kWG9FUFuOU53p6/mAThwE/6uECUZsvmWjm0e6wiEjKrc07kCoFqZInSorf5sep58
	0owG0BI2LcLqmnU+ueF7LZnz+iin4RUEmVs+4y2aPw651IGByU3CcynuriC9R+c0CjkNOAt8CSb
	sAzpJQUJ8p9+xW7pS6xtxfBu8iceLHiTVzw9k56+odAyfRPRTwaGmUsxXRggSsKqrNtrGbxj4Xj
	emBTK6lcJcoP/jFVQ2LIH7J8ezhQhgMk0Kvz07gbLwzVnBZ1QAe2NXiodnDK9x39/gsfTkk0ft/
	u0L8C9vvhij9Jg3mVO0PeWPv5B9N1nBfmgqJbi1bAZogL90Ob+Ak5LPnt2HQcRGvTsTl56hZl1Q
	KRnUmdJzUyAxy1mohMyFWv9fw1QePpdTc7dh3vs1M5FWvj3Hqa4APMdhFKEbyNBW52yE+90pFJN
	d3hSksCMzwWyvOyXmWHxQQiSHJQY=
X-Received: by 2002:a05:6830:3747:b0:7ee:37dc:59e1 with SMTP id 46e09a7af769-7f3de6bbfd5mr32618951a34.16.1787036345565;
        Mon, 17 Aug 2026 23:59:05 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41beef430sm3599463a34.5.2026.08.17.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:59:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 18 Aug 2026 00:58:59 -0600
Subject: [PATCH net-next v3 3/4] net: mdio: defer supplier sync during OF
 population
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-submit-phy-package-fwdevlink-v1-v3-3-40a905ea16b6@gmail.com>
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The MDIO bus class device is fully added before the OF helper creates its
PHY children. Once driverless class devices complete their managed links,
the bus proxy links are retired at the end of __mdiobus_register(), before
PHY package member links have been installed.

Pause supplier sync-state callbacks across both MDIO bus registration and
OF child population. Each member PHY acquires its real package supplier
links before the matching resume, so suppliers cannot observe the interval
between proxy retirement and member registration.

Use the existing nestable device-link deferral mechanism, export it for
modular OF MDIO code and resume it on every success and error path.

Fixes: 385ef48f4686 ("net: phy: add support for scanning PHY in PHY packages nodes")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v2 -> v3:
  - Replace MDIO-specific proxy-link deletion with scoped sync-state
    deferral around bus and child population
  - Put the deferral in place before enabling generic class-device proxy
    retirement so every intermediate patch remains safe
---
 drivers/base/core.c        |  2 ++
 drivers/net/mdio/of_mdio.c | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cf3f4133391d..d2f9ff65138c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1256,6 +1256,7 @@ void device_links_supplier_sync_state_pause(void)
 	defer_sync_state_count++;
 	device_links_write_unlock();
 }
+EXPORT_SYMBOL_GPL(device_links_supplier_sync_state_pause);
 
 void device_links_supplier_sync_state_resume(void)
 {
@@ -1284,6 +1285,7 @@ void device_links_supplier_sync_state_resume(void)
 
 	device_links_flush_sync_list(&sync_list, NULL);
 }
+EXPORT_SYMBOL_GPL(device_links_supplier_sync_state_resume);
 
 static int sync_state_resume_initcall(void)
 {
diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index ff540049b847..9b73fd8eed41 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -243,9 +243,10 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 	of_property_read_u32(np, "reset-post-delay-us", &mdio->reset_post_delay_us);
 
 	/* Register the MDIO bus */
+	device_links_supplier_sync_state_pause();
 	rc = __mdiobus_register(mdio, owner);
 	if (rc)
-		return rc;
+		goto resume;
 
 	/* Loop over the child nodes and register a phy_device for each phy */
 	rc = __of_mdiobus_parse_phys(mdio, np, &scanphys);
@@ -253,7 +254,7 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		goto unregister;
 
 	if (!scanphys)
-		return 0;
+		goto resume;
 
 	/* auto scan for PHYs with empty reg property */
 	for_each_available_child_of_node(np, child) {
@@ -285,12 +286,15 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 		}
 	}
 
-	return 0;
+	rc = 0;
+	goto resume;
 
 put_unregister:
 	of_node_put(child);
 unregister:
 	mdiobus_unregister(mdio);
+resume:
+	device_links_supplier_sync_state_resume();
 	return rc;
 }
 EXPORT_SYMBOL(__of_mdiobus_register);

-- 
2.53.0

