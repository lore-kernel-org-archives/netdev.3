Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C82F8E82
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924842; cv=none; b=kdMEo4RnWdDpepfc28K70IOAuvrWd6yZENuU/2tjTqmkyc9Jao9ocs247sNAyKzI44hZTvJZiqeoY/bDvpBIhURHU3N2cren0wmFrtXszmNx657UeGvkZ1woCxeUbFJw7XYfJhcCpgBzW5pqntLO8Gx6l+sbrbadgunc75pN9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924842; c=relaxed/simple;
	bh=LS22LcmEJj8e3kqN7yGg2uzjNvP+oUDHt1HXDKQHKRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFDiQFAPLRBoXvu39Je4jA4/fIJ0o04EbIXPRqz4Bt5yfWBTo+S3j7phY7sSJajI9xI3CY+4SkxMp1RExwF2ANKWoBYCauVLalorhIpJY226DQmNnJkg2fDyhyo4krcVsp8KUGzLFNM2S8oPDhHzdrSiXhMrxkkGUjOaTqZRta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLkgRSgf; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLkgRSgf"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-448b0ff4a57so2698494fac.2
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786924839; x=1787529639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhr9mz2HpwDudTQs8av6vCMLVNHxqCHiSdPs5GamCT4=;
        b=nLkgRSgf5Bb6kUfn8dcHmpYI4d8N0GDLAeC7Dy0aWJrlA/NxYHFoqL6U7aGgIvPXDI
         IrQ04lspld8VengPH58ajHI1FG/KoXUesSP/kKexZP+y+EXLnBDBL1gLcFxOxWDlPx2N
         dF7JxF1qHOAik150kxEuirx3OI3fAy/kCt7SKNLLb04aR4frqJ5jCRU+goxl6kLygwns
         s8yjr8XmGfQ+IhRfOYmdimrx5IuPUJytiVs6XrujpHEg4jk272JJwttyAxjiYrnviED5
         b4Aebv9L6EsoMuA7Kdr0M24uLduvFZ6vKKpzT2j7P9/Rr/1ngNa1tc74BeoaLKhnLyaz
         whJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786924839; x=1787529639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yhr9mz2HpwDudTQs8av6vCMLVNHxqCHiSdPs5GamCT4=;
        b=C/o5h1cXKTJ9mGxOcIIJz0ZJPkWvbAz+vFyc+x/tQ2HobOKywC0t6U2GbdL5EK15M+
         4w7bo3TpNxK7Hio61rEKL250SZ7hmfP+GRFecdbfEZi6xCE0RaBMZZ5wdXwGFjmORzu6
         Wm9fWT/7JutmNPslYheTWRKbFeRX7jcgVN1JScrJByTceWKwy/Zcr4mSvrtsfoRWiwhI
         Q56i2yiaLcLGSKy2W1HdKlGqEVxj9tShvYdnvM7i7ZknpXLATbmn2ndPjwrIfSs7IQxM
         8SNi2yq+mB4GmEisVCphzg4eYFD/fcFQaveHwrShDT3IbWpunxLBR6FFFrBzPkPTEzQ0
         6Trw==
X-Forwarded-Encrypted: i=1; AHgh+Rpz4hSidfwaD8lOpf5Et260hazpmSnREtpztZmdsPwr0vdjSREy1W8iUIiuxynRCH1XTxRagjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWE4a+4rjS+xZTRyBFSx0wOoX/eAs1lyEdf8dotbvhsbWOplS
	g0xz4XVplmA06TPr0pBC5AnnUDRUegkcCDNZWYGDpsGeHXPbebcRh3t3
X-Gm-Gg: AR+sD10Q7HRUt6bjhlDnIEOV1xpTQKRVdInt+Oy43GKE7RlBHunzYk8WWigl7ezm6Ab
	tKfSiZOpIWpBsmlcUEXDAm1OgN9viF3R78lC1QPkhZEagouJ1SQ5Tw587Y0rNG7wwkc2eztpvCu
	h1flroE/w+TOi7vhNkgKQtx5Xg59oRzm8ThS1kpRIad+if0HfhK5D5JCqRL6qAanv53+WbldMP8
	cSJNA8uMz6O2ucMlIxFlj62zrA6BnOsRuV4IsR9KTz6e5ffvHERli7dX62MMuHJ9ctP5GxkMbyq
	bFrobrMVTw0E429Wwt6xcSbPbhx7PBfPmUU/Z3jfyEqeKWKdhLvaLmdXGhYJ8YNKJquRJDWSO2f
	G/TkpxtKedLNUfellPkFMzZ0cxa71CebYru8/+6fRKtyEWEaaL+MRTDcuqicplyayKLspJrkW1s
	aWuo8PG8jXFoJxLOfE3g/8MsQb/h5ABRPa/R3XZ3Q4n161XU200o6ahFzhZC9IF3n3cvGtAG0zQ
	XT5xlf6DFXEk02J5ZDmkYSZe75D8J6yAZsomYo3xEHEADorDRyDkqSTHpN9cDgqKj0nDo/0yahd
	B1MiWsnAHo6dANcmD0x6haeGPTkbA5D1/TWFP1L95dy+RENU5l+JgpRh6oGMSlaTMQRodAL/SLA
	XEjh2gZPghqr8ae2V
X-Received: by 2002:a05:6808:1486:b0:48c:4c00:596a with SMTP id 5614622812f47-4b2414ef9ebmr23059139b6e.5.1786924839124;
        Sun, 16 Aug 2026 17:00:39 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2714dc18asm2556802b6e.17.2026.08.16.17.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 17:00:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 16 Aug 2026 18:00:30 -0600
Subject: [PATCH net-next v2 3/4] of: property: link PHY package suppliers
 to member PHYs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-submit-phy-package-fwdevlink-v1-v2-3-23e55dd59fad@gmail.com>
References: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
In-Reply-To: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Christian Marangi <ansuelsmth@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, netdev@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
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
index 38c0c7dc428a..d59bcb1f29de 100644
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

