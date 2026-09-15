Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB143F4D2
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496236; cv=none; b=k1LIP6dY9myBMWOs9YrFgGH+H/V73Ct4kCIaHXeQI70aTXHL8OaCfXlrwrjkUFmpX2yqV++xKTpVBCYMje9EkNwiIwNpjFzghLHzDgKHpLqdrFzODXF8G++72NeL20RrAasFCq0yrm2s0wHCmnDL75P5cT4ZYWNgMOE9DUmrjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496236; c=relaxed/simple;
	bh=A7in0Alu7BM8kUxRkWxLv9TvBfe4QvgWoOD+yHVx2j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIeVoN3gK6LnB3IoUasECpL1zaXSAj4WUPoNblgr5jurItt4bIRNBy0vDIL2kZh6j9Xr702O1/xIBVtaWMMRNynUJQ9Fe2t41+9FicHBWvuYEo+kq7qL+AiysVCQYAl2/VcgvMIWxxXZR8R8esuDuAuFCPBNfgK0ZSA68iBBjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g//yLgFJ; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g//yLgFJ"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982db8d3ab8so27051241.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789496232; x=1790101032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lhABGOr78fp2q20gHs/L/QQ2y1BCAwuXhlRy5NO8sA0=;
        b=g//yLgFJbe4+i6+NUjaUGafxtqFGMS47x7HDcC8tenhLuMMEtX44pOpIpENyfN56W+
         JbQIB8oE8sW2RvlHam7BMD4bBTgl5sG4dfft6v1fSmIpOtjnbq08BaU2aWUGaG8+sGci
         YMovr2qcVyvg0Dq1zf2VW/2Xbgg3RJLMGwUBy6qtZlApLFavfdutJE7D7NhwuJ7xda4d
         1qP+uen6AICgUBX3eH/C6NTpnlwrUY51+V2GgySSWJ4vbnxDQ2AUv8TKD24OtM3NKLMn
         PWgsN8gUQi5fEy8HnE/X1qW5Y7n8z/rpJEQYg/usO6Q5UJPQ9KGB3+wEMY9JYuXFg3gu
         pCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789496232; x=1790101032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhABGOr78fp2q20gHs/L/QQ2y1BCAwuXhlRy5NO8sA0=;
        b=xVOqsPXNSlue1qyhdqi7GsGj2aXjG+9M9WN+X/jbnDDBwJPGulxYvTY1mCyc43/QY7
         HAuLTvjiUC65BWelprcGGq45A0WL63RUrdrhwzQA8AZEiCmwKyS7sTZdslQD4Vv7Wi5V
         sbNPtuvzakoSlpbVShFVEyZkmZjnRkTUjTY+xpzNgGquhVREdSQQwhsFzL1TEgrVAwZe
         1/jDuhcijmRdYpijYNxeQ79r8fZyliPizS0KPNojGxALbgMjxjErujEipPj2vEJTn17e
         dHhzyesGHWq2suCxmVmMhet26St1WLdL4eXnK5vM4DWvP25RkpG0x+YwALXJ+GKGpyEf
         +3JA==
X-Forwarded-Encrypted: i=1; AKwUvByEco/Yn90eVR3Zi/Dk7cRBnkdvuqHeJR3551Dg85ifuCvdsdz8QyqukyJJEtc7SSztBSgNBlI=@vger.kernel.org
X-Gm-Message-State: AFuF++n7hWVmvXoW0/aByaTCsr2EMXI+gWFuN+UIegXJ/s8lN5AjDxMc
	YoxhNZ4jSd6sDNZ+sAJWdunFs1GEBJFcgmRuGqAqn8pzWobk5aEd6yjc
X-Gm-Gg: AYBFou2icuX/nKmewWXZ6f/fftVRshu/nYCJPrgM9A4o3sOv7BmMDvMR6nu3mXFM7tT
	zSE5QXOVK/OHJRcSUie9pj2XePKbIMKJYz0NexlqH9wxtM5O9G4GWG/rrt9TMq+fE053oYh5C1M
	AaZ/YaFodH9jaeExMYDTR0QARaoxXvzqKFXL76zAGnPdwEPBJOsTV9hVg6AW66MXPKv2/4KhReH
	h4kUWpKYTlKviZ2eKHxS2HsQqaSNAWDvEI7eGzTc0mmlzSXry9NnAnafDUT4wk6PI9OKtQ8r/IH
	77ajwX2kmCfcgLbgZsV6G9QipCXaEZR5DQa/4CZI6dpyeV8M84UaOG5/h3oKCY5dze+I9BIEicl
	vxNqwN1I8WY1iqN6Kc8IWQhCMAFErbvoc1aYt6ul6WdDB6UjiOhCEF06gzWZ7zF6bU+QV+3F6+P
	3AtGegf1SnRFbnDqZJ4VweOWYL1z44sVrA6wjjsaHv29kGkPEOw+RIDpRKMBUJmTLidOGGMnWFC
	bTpW3MdBGIIMpuqtGbcM22oCee2whMLJlX0voqwQe/RY3Oims4wC1GdMZwT0nxntmlrzsnBmIz0
	g1f/U6uTEqh993UutEuT7tmRgdOJhYFwNWtEPdo6A2aptzDO
X-Received: by 2002:a05:6102:6a85:b0:79e:221f:704 with SMTP id ada2fe7eead31-79ed4c2905dmr5071549137.7.1789496232542;
        Tue, 15 Sep 2026 11:17:12 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be5fcfasm4717636d6.12.2026.09.15.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:17:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
Subject: [PATCH] dmaengine: bestcomm: Enable compile testing
Date: Tue, 15 Sep 2026 11:17:09 -0700
Message-ID: <20260915181709.11323-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the BestComm DMA engine to be selected for PowerPC
compile-test builds.

The freescale ethernet and sound drivers now need a dependency on
PPC_MPC52xx as they use headers/functions from that platform.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/bestcomm/Kconfig           | 3 +--
 drivers/net/ethernet/freescale/Kconfig | 2 +-
 sound/soc/fsl/Kconfig                  | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfig
index 5dd437295964..153b5492c93c 100644
--- a/drivers/dma/bestcomm/Kconfig
+++ b/drivers/dma/bestcomm/Kconfig
@@ -5,7 +5,7 @@
 
 config PPC_BESTCOMM
 	tristate "Bestcomm DMA engine support"
-	depends on PPC_MPC52xx
+	depends on PPC_MPC52xx || (PPC && COMPILE_TEST)
 	default n
 	select PPC_LIB_RHEAP
 	help
@@ -34,4 +34,3 @@ config PPC_BESTCOMM_GEN_BD
 	depends on PPC_BESTCOMM
 	help
 	  This option enables the support for the GenBD tasks.
-
diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index b34c0fcfddea..d81984fcec64 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -38,7 +38,7 @@ config FEC
 
 config FEC_MPC52xx
 	tristate "FEC MPC52xx driver"
-	depends on PPC_BESTCOMM
+	depends on PPC_BESTCOMM && PPC_MPC52xx
 	select CRC32
 	select PHYLIB
 	select PPC_BESTCOMM_FEC
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 04940879dfd8..101bc952aa14 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -234,7 +234,7 @@ config SND_SOC_MPC5200_I2S
 
 config SND_SOC_MPC5200_AC97
 	tristate "Freescale MPC5200 PSC in AC97 mode driver"
-	depends on PPC_BESTCOMM
+	depends on PPC_BESTCOMM && PPC_MPC52xx
 	select SND_SOC_AC97_BUS
 	select SND_MPC52xx_DMA
 	select PPC_BESTCOMM_GEN_BD
-- 
2.55.0

