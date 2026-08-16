Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D6211A14;
	Sun, 16 Aug 2026 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786853090; cv=pass; b=SvplJ/1N35D1nPO4VozphJoRA/p4bU+ppkuPSdwDQDU+kWxUYS7SfesndWbvMAGrM5KfT7jKUFujRyOYhSHjdOx7kg5jdJbv7a3R37A6Ig+Us98HjVPx8ZLx3nwOvK5KAZDXU7UPEOwsoOkR2w7s01GPjUfrou387WVxxn2GmY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786853090; c=relaxed/simple;
	bh=vnWbeG6jNjVzSW5eXOTDCKHq88HEcr/5VLWlIp2mAuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvikAZHQLK6T0FhSozBtgyxpF+Yhcy7yiRYAQDiNQFXeAfwqDJ3iDwLE5BkJswP9kfSi7Q7+zRZf8TnsEUCmkUpmds+v4fCHVTN3LEBesB6CozvF1Uw+viGRKrrbqphOUUinZQxcGWhXP7ra4tBNnG2bO8PxfrPwldYMWGEfTo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=signeen.com; spf=pass smtp.mailfrom=signeen.com; dkim=pass (1024-bit key) header.d=signeen.com header.i=mehrdad@signeen.com header.b=XHtxE/HP; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=signeen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=signeen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=signeen.com header.i=mehrdad@signeen.com header.b="XHtxE/HP"
ARC-Seal: i=1; a=rsa-sha256; t=1786853071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NnM+AJjMQ91dAHuXd1JiKMRVgrkXyvWiLfimKCE4i9uyKNPbBhh2wuBwGTwFSdvhQsX5n/nFbOYyWT4H801p1DWTF2ytGMQg7pld6o4oa89Dc1b9Xn76tfefbO+r4yWRVn/r3JYPt6k1cPJoJciJ4BvmwZxxc/X3S/Ok/Njhcsg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786853071; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lQRqyJJ6rsb6/t6lPsSdDdhPi5P5tAJq6wXmkDnZVkA=; 
	b=Ff/yKULjbEYHAlheJ4NgLMbrZYyc1NzPWARCqhYFbJ9YKWt+Zv9AqUliVkM1xCHMiEPsQkd59M1hvu6qaW9IwARHj5jcdefvDEep4JZI4GOkiRbG88PnWHL0FON/RJWR6FX2JdNIvdFfTJ7ZIQRJv5+q4pD1S3JhP1Z/oKuMj9E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=signeen.com;
	spf=pass  smtp.mailfrom=mehrdad@signeen.com;
	dmarc=pass header.from=<mehrdad@signeen.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786853071;
	s=zmail; d=signeen.com; i=mehrdad@signeen.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lQRqyJJ6rsb6/t6lPsSdDdhPi5P5tAJq6wXmkDnZVkA=;
	b=XHtxE/HPFdt0SZUXQtcDCVOo2c6HAz0WaUruCGPVY6Kd+QQvfH6uZKGheV8RiBqM
	xtgsCdtCxKCCR0faxCv4+m8Ci1EpCry+2bjUQhuknOiz9wlLnO3mGC1Q6Y6YcnXJyaf
	Gd0nIAecljTUD51HZIxprrclAC2yBFT0toRHoSss=
Received: by mx.zohomail.com with SMTPS id 1786853068327967.7775185495542;
	Sat, 15 Aug 2026 21:04:28 -0700 (PDT)
From: Mehrdad Afshari <mehrdad@signeen.com>
To: Oliver Neukum <oliver@neukum.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	Mehrdad Afshari <mehrdad@signeen.com>
Subject: [PATCH] net: usb: cdc_ncm: add Apple MacBook Pro USB product ID 0x1902
Date: Sat, 15 Aug 2026 21:04:26 -0700
Message-ID: <20260816040426.57132-1-mehrdad@signeen.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The cdc_devs[] quirk table special-cases the Mac CDC-NCM private
interface personality only for USB product ID 0x1905.
Some MacBook Pro models (e.g. M1 Max) connected over a
USB4/Thunderbolt 3/4 cable to a host whose Thunderbolt controller
lacks PCIe tunneling support (no NHI function, USB4-only mode)
present themselves with product ID 0x1902 instead,
using the same descriptor layout as 0x1905: a Communications
control interface with zero endpoints (no interrupt/status endpoint)
paired with a CDC Data interface, at
interface numbers 0 and 2.

Because 0x1902 is unmatched, these devices fall through to the
generic cdc_ncm_info driver_info, which sets FLAG_LINK_INTR and
therefore requires an interrupt endpoint on the control interface.
Apple's private NCM interface never provides one, so cdc_ncm_bind()
fails outright:

  cdc_ncm 2-1:1.0: bind() failure
  cdc_ncm 2-1:1.2: bind() failure

and no network device is created, breaking Ethernet-over-USB4
between the Mac and any USB4 host lacking Thunderbolt PCIe
tunneling.

Add matching entries for 0x1902 alongside the existing 0x1905
ones, reusing apple_private_interface_info as with the other Mac
ID.

Signed-off-by: Mehrdad Afshari <mehrdad@signeen.com>
---
 drivers/net/usb/cdc_ncm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 0223a17..35db38c 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2013,6 +2013,12 @@ static const struct usb_device_id cdc_devs[] = {
 	},
 
 	/* Mac */
+	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1902, 0),
+		.driver_info = (unsigned long)&apple_private_interface_info,
+	},
+	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1902, 2),
+		.driver_info = (unsigned long)&apple_private_interface_info,
+	},
 	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1905, 0),
 		.driver_info = (unsigned long)&apple_private_interface_info,
 	},
-- 
2.55.0

