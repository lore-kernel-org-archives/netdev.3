Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33806522F18;
	Tue, 13 Oct 2026 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911577; cv=none; b=gK9fK7p6gGltCCuHWIhqrE8lW7O3VIgZVBtbouxS/4UneN+YTJ0lhLA3FTDoZm43SozfHRv0/IE3qU6K7MJ49qDodOhEY2A644Zhg7kpfVswAGWHQCXXk9pjYZNjf24Pz3bmVhOqMQSbu32eoycZCNFoBf1Z7NbTihbwTtHO9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911577; c=relaxed/simple;
	bh=cqDECBxwrHYBWjQplwyf061XTHVqB98z7aV36iGk5w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXA0nYBE++8rCE7jR6/f4YHVvb50BGfadwMhP2Vz4Ezf86lmNG1AwmiSRjZv5DpfHwXCBhwc7TBGbiyGb42Xsey4ndtjIKAjOQF6CVUKVQd0s3ia3ubK0ohU6dCZQMPYhCBsEL7OwKHMUqEmmKFYhjODW8ujsU7L29HXQcbqZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC3F52000F5;
	Tue, 13 Oct 2026 19:12:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F9972000E4;
	Tue, 13 Oct 2026 19:12:54 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 95601202DA;
	Tue, 13 Oct 2026 19:12:53 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 3/5] arm64: dts: s32n79: add NETC IEP18 ECAM node for ENETC PPM ports
Date: Tue, 13 Oct 2026 20:12:47 +0300
Message-Id: <1072c2802167fe3914965b176c84fdc1efe4a801.1791908694.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791908694.git.claudiu.manoil@nxp.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

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
v2:
 - Replaced the 'msi-parent' stub property with 'msi-map', as per H/W spec.

 arch/arm64/boot/dts/freescale/s32n79.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
index 94ab58783fdc..65cf65e82832 100644
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

