Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9638175A85;
	Wed, 29 Jul 2026 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299510; cv=none; b=nwbS4BjSfGdsKEH9ha5wZhZN91idwqUBIYx9ANquTxLTPH6Yxw2/iXbiqOS2nWT2dXH/k34Mxf3hHr8M+XVIecuDC16k8WEeWjB9tJtyP4nfcYibz0iDbfncNl4xpsO4/1MQWn7v+yVfPBjr9W0G2561ffV9nAmoeeothWHjGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299510; c=relaxed/simple;
	bh=1XJw3ZIVNLVIjUuPwE5g/7zUOaAo2PmxEW3WdYarUvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYSyL+P/t6yQNeMNKJxzdiRvbPxsXeUifbWQ7nMFLEbM0XFKS9/gqA14j0x1L7t8sjhFPa1CnvxcHODB6t8UOEmPXzhauqlrQDoldjZPdz7xy+SDPfTLFM/8pJ7GmF1FfzFjNgMZ8yz5VmgTVz/4iWU/uQMLk1hGjXuibhM5omk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EnpX1KAa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EnpX1KAa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785299508; x=1816835508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1XJw3ZIVNLVIjUuPwE5g/7zUOaAo2PmxEW3WdYarUvQ=;
  b=EnpX1KAaDjVvgxW1xWsYdb617oJZJqO4lnCYIHSzL5e/eAEdrJsd/XnF
   2gjQBL7qMPhNMm2AWTFhLIznWGSKP7fBJfBDAlJxcP2Q/qUnwZsryQAQh
   taPtxi7Ug0U8G+ym4ofp+RbIatZxF4BzGvv2s5FMm2zMntM2icTaGPiT8
   qY/bxxe6QxES02GanwlRr1NprxuzrjPVMIUlj6iVKtM9OShg1IIvBJdsD
   8lERMf3Hh64y4GE+DSfo+uwBYjKPMHO0ZBQw/1VKaVmrFTnP6ZrBIifO2
   66+yPAUppqkogf8EJ7Fmy+qIF0b46pYu+FeG9vyKTg7Tw2hcYmtVv5GrO
   Q==;
X-CSE-ConnectionGUID: vBF/dsqGSWm2aw29QQ0F+Q==
X-CSE-MsgGUID: /T6vL0QaSEWiieDVb5wq3g==
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="60446960"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2026 21:31:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Jul 2026 21:31:47 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 28 Jul 2026 21:31:39 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC: Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v6 7/7] ARM: configs: sama5: enable Microchip/SST SFDP EUI NVMEM layout
Date: Wed, 29 Jul 2026 10:00:26 +0530
Message-ID: <20260729043026.1811147-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729043026.1811147-1-manikandan.m@microchip.com>
References: <20260729043026.1811147-1-manikandan.m@microchip.com>
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

Reviewed-by: Linus Walleij <linusw@kernel.org>
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

