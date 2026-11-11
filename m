Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398233;
	b=YE+ezwppHYnfmRbLvUxeQXcjgfQBt4F8vnxC1AKUjU8YiJ0CnQY92YGPBoy+vz5vMhQn
	 15KsITfsZ6c++RiN6O1JOta7kbm3+hZcKg61gG53OADekgJpkohX61b842KgKwfpfhIk4
	 NcXZPZtnRcFisXsSw/nqOdk9Co2JONPXxpUbyoAGb5EUUI3kD+5eerPhuON3ccGwxIB2a
	 RyfuqT5bj0kUdxpopvspgA3TbcFAY9o0Q9a5rzfxS/MQZ1GVxAMevbvORNfajW567V5Ss
	 ELgNCJZQrVJKV9FW0qhVJKOMKALLVp25QV0034S5oiUN37PKD9feoZjLZrktTA1ehDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=LY2SWOxsJqbOxznpwl/qTBJZaImhznfIoKMaO+d3rnA=;
	b=nxQuWcQZiCR5VO8r5NIARAlhZcgy08HrgJaCsFgjlG1g/TGNShhXiA2JkHAxMIMBcpYZ
	 ZmClTvgaPGQBwx5rCPTqmZA8Yms80yGiIhaB4qw3dXnzM7unkrwqoqql5A4zo+KGgzhZ0
	 nwsls/Z/iDQpt7bmHQn+n+PfF9bCgJotnrMqxJGhIFQO6eFhtJ+4PWR+amee4ObNc3s3z
	 kegYC/bdLqKWaNx7kysSTigwerHxSGJLmgUWURjV6hXwTQIrSZEyPr3S5U43ip2pQIzNa
	 v2BoepPbZamxmGjLmUlq/WVNJ67+vMy4OFX6E9TwRS41H/gnZVVAcV6V4fXR9Pd2gvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YFBik3g8;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE747606A324;
	Wed, 11 Nov 2026 11:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE747606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YFBik3g8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794398232; x=1825934232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AP1aVJcfWeQCRbRFuJA0bQ52dwt1E9dh4XOxNt6hqek=;
  b=YFBik3g89CAejhGnVeFEpkQIA1p6+HYTmzr9nCzYrQkIpHVD5YZiXqEW
   VY5UiQRT6pNabYv3MEuqKm5bkl77CXDD/fxQSfNAOyR4t4C2tUt/FNYxy
   QRxJlPCN1k1YBWcFUqx0tqosdMT5FK2XZcIq4XWt8op7YjpnqtfQ2RvFB
   pSoL7OEaNRngni3udmsrSCmnbw+4/jbfm3Tpk2Q6K7s2j4GINoAcnKUTG
   ygb6FiWxArZs7G+m3MWLHcTc5MpgDXOugQDW1TP/Ed8t/bwpvQhuNsX5d
   6D+vpEhajnHI7bnTHPA/MYJHaPECevEjLOe9phAIoaXgzoJspEwreZ6h9
   Q==;
X-CSE-ConnectionGUID: uIdH9OJaSL+y3CqrjVwKMw==
X-CSE-MsgGUID: IQ4DUsstRnW4Mz9MkZGS4Q==
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="66350199"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 04:57:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 11 Nov 2026 04:57:11 -0700
Received: from che-ll-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 11 Nov 2026 04:57:01 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linusw@kernel.org>, <enelsonmoore@gmail.com>, <aaro.koskinen@iki.fi>,
	<pengpeng@iscas.ac.cn>, <mathieu.dubois-briand@bootlin.com>,
	<gregkh@linuxfoundation.org>, <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v10 8/8] ARM: configs: sama5: enable Microchip/SST SFDP EUI NVMEM layout
Date: Wed, 11 Nov 2026 17:25:40 +0530
Message-ID: <04714d8fecbed1fbc8401742087d0c7591359d4c.1794391660.git.manikandan.m@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794391660.git.manikandan.m@microchip.com>
References: <cover.1794391660.git.manikandan.m@microchip.com>
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
index 6e5f845e95db..4eb3238af5b7 100644
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

