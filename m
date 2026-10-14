Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E4470438;
	Wed, 14 Oct 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960118; cv=none; b=CTwCTD+i+pBQVW46Y5hdr8MBIo8FbSoFpm70sU2VTmspijTeOhdKpy7zUTKrMnzZvMJcs+UfV4YBQ/Ob38437a7d2FCxtLk31zKRR16/bAPNa3d5whwa9x6GZCyGkLgELKQf5u6dRh5usB1XJaCN9gdhwkWh916bzvv/tndVLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960118; c=relaxed/simple;
	bh=o72n1cSWA/x66f0FI2qYr1BLdnEOvPwevayrmClAUPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A74zKRL1Kbiv4sg/L5zRoqZbl4i780l9WExkx2s+Y/Nbh65w9o4YE2mbrYDsT/wEPNHwbKaourhH3ZcZP2d3wG+tGtR/N1+tH6sEMtLcJ0VqMZ9ZkmgcvLhXr1PPoSM4U1GEsp9iNHw511FtxAXMOoFwcH8AiN6ujxAN1hBZAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q6O9wOBr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q6O9wOBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791960117; x=1823496117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o72n1cSWA/x66f0FI2qYr1BLdnEOvPwevayrmClAUPE=;
  b=Q6O9wOBrwkVt/1dkHVXc0XefnaZCWEEcf30KpqrCa/fiKyVZ9dAeMX4p
   lvF1cY1AXI78qCp9jTjs/RTuK+0TVgjdOWA55nx3n8Fc5bbN1MEWLF2qx
   IHKNq+tua9RwbJG/DjCVdjc7SH+ycp7g73t+UE40tdFbxOo9FlSEsAImy
   7tjQiO7ulHqg8GULp22r3GLRkJySCOE9FI+cIpN3MlXYrFcAknuws1csO
   /GhWvTDAYh2iegEggc1DACMM8esScCWIT78YpbWvyUspy99wx2EVnEI3Q
   dFx+YQJfCGusNVzSEgBPfgp84NjOIs1TTBtAhfHalnuUrb8Gtt3SQYEcv
   A==;
X-CSE-ConnectionGUID: E6UD/4c/S+2Gk9hz6D3ZCQ==
X-CSE-MsgGUID: 6+O+i4/pSjSq8LcJWDXNQQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="232101734"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 23:41:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 13 Oct 2026 23:41:55 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 13 Oct 2026 23:41:47 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <aaro.koskinen@iki.fi>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v8 8/8] ARM: configs: sama5: enable Microchip/SST SFDP EUI NVMEM layout
Date: Wed, 14 Oct 2026 12:10:12 +0530
Message-ID: <dfe67f77151c9e2271477bd30a5262fbacea9a4c.1790847519.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790847519.git.manikandan.m@microchip.com>
References: <cover.1790847519.git.manikandan.m@microchip.com>
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
index 1eafad9139f1..f8cc94106c54 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -219,6 +219,7 @@ CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
 CONFIG_PWM_ATMEL_HLCDC_PWM=y
 CONFIG_PWM_ATMEL_TCB=y
+CONFIG_NVMEM_LAYOUT_SST26VF_SFDP_EUI=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_AUTOFS_FS=m
-- 
2.43.0

