Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58F346E5F;
	Tue, 27 Jan 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513710; cv=none; b=gGQSbE3UVvk6RVvd5vYImKg/B+Wc/v9rNAjo9S9IPtRcs0UFoD7K586nTroGJ0rtQkWAHX1MkrAj1gW1Y4DX7HvrEPaKBHQbBRaVZ38/GelpXxo2un2cABEC10XXNp5DbsEmytLKLCu7dtS9SIYKnvInCDIFGBRECzQUbMKgVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513710; c=relaxed/simple;
	bh=GVspYd10DxPhbhP46uvJwpu59C//6wmJDjpQq5xM1xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtmIiTQfPOMxnQqICM0l6YW2vxnroj+prAjrYJsuNg0ghyfoH5zvfFIMQZVtZAoKmV+KncGveOb0uw7z3waA9qPxEKp18JtFveVrSKG9a2zmcj4ZIP9rxk8vsj1rzjH9Jrueeb+kVThNwv169UG4ctq0TrzjKNCXMpgRPCPGIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=eXEeqGAQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="eXEeqGAQ"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60RBYSS602868731, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1769513669;
	bh=Vo0aMRzYf1jl6v9fuoTunTjRKBFOkKzeqCas/adOSu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eXEeqGAQCEzDe0UwSKkL4ygsLYryyEr+yR6Ajd4Nnk74nWexCvAltMCQXCdz5cAOx
	 QM+Ge1F+4P7r7yhD0G5GIwM9N37HPQ2zZeGQxRefqftKIPjbE4udi2nHWSBlgu84Gk
	 PqW3S7+ABIkPS/70OmQKG2+K0K2N0SLHJf8T+hHOK0OV6lMF96a59dXJ6zRkJeKoQM
	 GJs3oae8HjPOI5F8VAmtbeoswVgfumxSIO8FPHtCuHkgI8qxEFuT7tcxsM+NdM0Uhd
	 /3y4CEX3RT7LEccRAKFeyLS15vhHStWe6Um9ADvPXMyJDl4uPaac+hPcjAPQX2OzBH
	 ASu0A75mySUKg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60RBYSS602868731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Jan 2026 19:34:29 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 27 Jan 2026 19:34:28 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 27 Jan 2026 19:34:28 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 3/3] realtek: Update Makefile and Kconfig
Date: Tue, 27 Jan 2026 19:34:25 +0800
Message-ID: <20260127113425.1989-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260127113425.1989-1-javen_xu@realsil.com.cn>
References: <20260127113425.1989-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds the R816E entry in the Kconfig and adds the CONFIG_R816E
entry in the Makefile.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/Kconfig  | 7 +++++++
 drivers/net/ethernet/realtek/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 9b0f4f9631db..f2d7edaf299d 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -126,4 +126,11 @@ config RTASE
 	  To compile this driver as a module, choose M here: the module
 	  will be called rtase. This is recommended.
 
+config R816E
+	tristate "Realtek RTL8116AF power management support"
+	depends on PCI
+	help
+	  Say Y here and it will be complied to ensure the device enters correct
+	  power state if you have Realtek PCIe nic RTL8116AF.
+
 endif # NET_VENDOR_REALTEK
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 12a9c399f40c..c027667df74f 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -9,3 +9,4 @@ r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
 r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
 obj-$(CONFIG_R8169) += r8169.o
 obj-$(CONFIG_RTASE) += rtase/
+obj-$(CONFIG_R816E) += r816e/
-- 
2.43.0

