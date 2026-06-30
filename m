Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B53EDE62;
	Tue, 30 Jun 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811614; cv=none; b=NXR1/0w5c7FAfInYQZX6Vw30civmzrjkWfnfmRiydeH0iK7pwfosXs2Oj8GtwQCAuqohJbTWvkt46rVSeIAtj9gWXrYy5kYaOy6sUVWqjKvIQUlBgisrthrjVHpuatrH29QIkZ3XLVODUnxwZULAB+nf/mS2omEI3tHzuRbIVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811614; c=relaxed/simple;
	bh=JITfwfmBfz9FGpcy6YY4iQQZZ0bchSkWh6fdczzfXlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLm7QuORNEFux0L7OjzVRoaRGB6fyEMXviVjncEhd6NjFov5AvyOw6nvLoldbLJ3M20OEZnSzbPNKN9yRHTKK6kIMHZYpV/1TnBQcWfmqaOt0dfEri/oV4l/yc2TQdtrIfPSSkO0yipTVdyQMG0KH88fGaH9CQhQTXWP6pKSFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NeijI3Jk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NeijI3Jk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782811614; x=1814347614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JITfwfmBfz9FGpcy6YY4iQQZZ0bchSkWh6fdczzfXlo=;
  b=NeijI3JkLwjsjBANkwLSwBd2WWb/W331RlqLpZBuq3lSbcdK0pIFyBVx
   AN332YGZIUCu25LWMe0XLK5DTSCPYLKygQn/wytYMbaLu//EOKx4902eY
   FQKluSxnge/EYfW2/7YYnv6sQN08Qh53UhqOqVrEStNt4gvt/bGuINjmL
   Q1B9/i8MgULh6O2Bm6YxcQkQr3hyO+T9D+4hWuNVLoIVqSBm1IHmIRfi5
   dmSspM7LfzareO6M4jJqd6PiElS0jlTdyZfrsQQjZU7qS68m2brA1enLj
   wByCpw+wbPKAdKoxYD95Woifb/Y60vLOkdCWWJt+1buAk0oIllvu+TnWu
   A==;
X-CSE-ConnectionGUID: lQi6qUsFTYyp4rovl1Lg4A==
X-CSE-MsgGUID: ZHDP5R5bR6ilBCfpCQuS6A==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="291266576"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2026 02:26:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Jun 2026 02:26:51 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:26:42 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v4 7/7] ARM: configs: sama5: enable Microchip/SST SFDP EUI NVMEM layout
Date: Tue, 30 Jun 2026 14:54:06 +0530
Message-ID: <20260630092406.150587-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630092406.150587-1-manikandan.m@microchip.com>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable CONFIG_NVMEM_LAYOUT_SST26VF_SFDP_EUI so the factory EUI-48 stored
in the SST26VF QSPI flash SFDP can be used as a MAC address on boards
such as the sama5d27_wlsom1.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index bd7f0b5f7d66..14dda4b0cfd0 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -220,6 +220,7 @@ CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
 CONFIG_PWM_ATMEL_HLCDC_PWM=y
 CONFIG_PWM_ATMEL_TCB=y
+CONFIG_NVMEM_LAYOUT_SST26VF_SFDP_EUI=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_AUTOFS_FS=m
-- 
2.43.0

