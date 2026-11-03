Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714965;
	b=aNzXR6c8IWvSAqO4HNikZB5Yo1rCYxeArXV4OFo1BsrLNkMDpToE8h9e/riIQqmlUpT+
	 faKinh3Pp768Q+MkMWzvuZjg/iEhcfK9yKktq2NqrNOR+ZVQkv0CH1y0oJlnu2CtCOHNQ
	 bqvsgudEwLav85mGv0N5gGgdZhpamCbJSchX+3ttT9sRutJI8WRlQQ3SiRvzzy5g2tdqb
	 JpgADnq5mMJgnb9BQxgdAidivIOl+0N8IFGTATPGqTJdE0DQOkEsOmsluMfT//GAqKM/V
	 xKhf3pOxCna47uSci0AyNeNKMPweGG7JX0KQcKzgVJRhhmNdErx3Obiz/st/J3uksZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714965;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WhmXURw+P/Jtah3L7NcpKPFAtgKqQYMYidsJk5jG/Z0=;
	b=bfBEPk+XxHoLZWe9O+/mvDNBKL5gNdwUL05avJeN6t9mKBpwqiL5NZXNfaOpsgsQFDhb
	 /WkuGpdsfwc+QK5VHWC2XdfFFz4W9VOFFzZ1ShlfQ5/Oq3mjisSZLllkIw1B5Q+NfK7SP
	 z3+DVRUiFGvwxhx860I9aQWVMDhQSBM7gjjKZndr2SjfMipqNzer/mXXyIf23Bu+W5VsB
	 s2qkyoLjgZLbnLzM/Lm/uF83xsjElxs8i6Ag7Kab11YTrpj52w8t5HiK5hoJqQD2BXOGe
	 59EBNhUpeF1yhrn0lK74VuIMyHvt+lrSeM2NUFNiJL9fEtVqBO8pWEeb5u22C8LgisA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=X4zgyPC9;
	arc=none smtp.remote-ip=92.121.32.54
Received: from inva129.nxp.com (inva129.nxp.com [92.121.32.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431C606D806;
	Tue,  3 Nov 2026 14:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2431C606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=X4zgyPC9
Received: from localhost (localhost [127.0.0.1])
	by inva129.nxp.com (Postfix) with ESMTP id 4C87F6000292;
	Tue,  3 Nov 2026 15:09:17 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva129.nxp.com ([127.0.0.1])
 by localhost (inva129.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSiLwKMnAJYV; Tue,  3 Nov 2026 15:09:16 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva129.nxp.com (Postfix) with ESMTP id C1CB5600009F;
	Tue,  3 Nov 2026 15:09:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva129.nxp.com C1CB5600009F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1793714956;
	bh=WhmXURw+P/Jtah3L7NcpKPFAtgKqQYMYidsJk5jG/Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4zgyPC9JEBp3s7awz5oJLpcJgzsyxKTBhf0xRJv/CfsICyvlbEfeMHmVBYymVxU5
	 c+69u3XaJUcXRXFZtsDoo72KK7hPUsugZX9M3KFpj0x+Lqlaqp3fhw0Jb9+d94W/Ku
	 0qjhzV+tg76mPbyEhKkEzuexBAy2w77VbqIE2hdpySNzu7JgsIp/TBoi6Iu4/GnNUy
	 pQ9BQR7s0odbfu7JncaxQ0cjXxPr+ZklMqGJsBb/GxSXeAQ4AnqmpU/NmcVwOmdDb1
	 pJVhI5KBxIKJ/LNuOBO+rfMXEZz7w0iZ57Ng7VA70zJcFnaayGCGVFjw8Td46EbBO9
	 B2m5sOAWqNYTQ==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id F0FAB202AF;
	Tue,  3 Nov 2026 15:09:15 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/5] arm64: dts: s32n79: add NETC IEP18 ECAM node for ENETC PPM ports
Date: Tue,  3 Nov 2026 16:09:09 +0200
Message-Id: <c76cf39edbce4e576aa7a3fe1544767fc7026f96.1793712309.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1793712309.git.claudiu.manoil@nxp.com>
References: <cover.1793712309.git.claudiu.manoil@nxp.com>
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

Add the netc_iep18 PCIe ECAM host node describing the NETC integrated
endpoint bus allocated to the first Linux cohort on S32N79. The bus is
enumerated via the generic pci-host-ecam-generic driver and hosts the
ENETC v4 Pseudo-MAC (PPM) PF and its VFs, which connect internally to
the on-chip NETC switch (not owned by Linux).

The node is kept disabled at the SoC level; boards that wire up NETC
enable it. MSIs are routed through the GIC-v3 ITS (msi-map) and DMA is
translated by the SMMUv3 (iommu-map).

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v3: none

v2:
 - Replaced the 'msi-parent' stub property with 'msi-map', as per H/W spec.

 arch/arm64/boot/dts/freescale/s32n79.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc8..65cf65e828328 100644
--- a/arch/arm64/boot/dts/freescale/s32n79.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -122,6 +122,30 @@ irqsteer_coss: interrupt-controller@4ed00000 {
 		};
 	};
 
+	nwss-bus {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x48800000 0x0 0x48800000 0x0 0x4b0000>,
+			 <0x2 0x40000000 0x2 0x40000000 0x0 0x20000000>;
+
+		netc_iep18: pcie@241200000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x2 0x41200000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			bus-range = <0x0 0x0>;
+			iommu-map = <0x0 &smmu 0xc0000 0x100>;
+			msi-map = <0x0 &its 0xc0000 0x100>;
+			dma-coherent;
+			status = "disabled";
+
+			/* All NETC PCIe functions */
+			ranges = <0x82000000 0x0 0x48800000 0x0 0x48800000 0x0 0x4b0000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1

