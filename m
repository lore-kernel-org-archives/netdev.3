Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583017;
	b=RrrO+ZIRxMHNDHDHBtndo+TPGFxapKH+fYK21Ky3c3DDzP61nNA6DDzGdkLQXt/g06wm
	 t/OjQk1OqAStaQ23QBH1Sl15eW95dklTKCN7k5TukhuVXgSPtbyfx+vmZZRJlwF2NcvRM
	 z+MCx/AIxw117K/tLi4bzGlVi6+MK7ws7vtEDo3Wp3bDXsaskIxobg6JixMNGWzOlQEM9
	 1PblbIFTrH6bUIUh0K9cut3lQP/jtUsLC/2hxbVTEqbb0gJo6s++nFrqCe/NlOoSxx7Nf
	 yQU7bh+ERFnE3p9bj5sFCJ3DqBuKlVZcRvRPxOOpbQ19AFSGR70A8YRPJjPlYxFI7Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583017;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rRQOqc0GZd5tQdW7FSO2PqP+kKXJUKP7tyAXns2ykuo=;
	b=eXaFSkILmp60F/5Ut33brFpbn8JJ3htAkvIVnfwFJm45GN5y5+iy5aOTVCQlfCfBQREv
	 yWU0pHlMQ70YMNB2EE3mZOR4kK1xLsqzEwTYxE7I3aa+ZD5PRl9bU6xuww2AS4GGX76ap
	 J7tLRCyh1XzhVCW4M2uyEjt3Tz4e5TI+Iylwi+WdjbkLEVBHvETtM3GHv6H40VQGJR3tC
	 FwaxojLBxss/xcAyp6rNzobT87v6nVgXHpXXQr5m8kB59TCSCe/5PIQgoyWSjh8GPg0ix
	 H1vxWg7Bi5AR651nb7+LeKfVdh5wFlCFxpZKrRuD5qDevNYVC58aIZGLyHKfMLvwT7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b="nl/c556e";
	arc=none smtp.remote-ip=92.121.32.55
Received: from inva130.nxp.com (inva130.nxp.com [92.121.32.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B25606A893;
	Fri, 13 Nov 2026 15:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43B25606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=nl/c556e
Received: from localhost (localhost [127.0.0.1])
	by inva130.nxp.com (Postfix) with ESMTP id 4528660193F7;
	Fri, 13 Nov 2026 16:12:40 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva130.nxp.com ([127.0.0.1])
 by localhost (inva130.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xk983Pls3qEc; Fri, 13 Nov 2026 16:12:39 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva130.nxp.com (Postfix) with ESMTP id 8DDAA6076D34;
	Fri, 13 Nov 2026 16:02:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva130.nxp.com 8DDAA6076D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1794582164;
	bh=rRQOqc0GZd5tQdW7FSO2PqP+kKXJUKP7tyAXns2ykuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nl/c556ebd9ke7HOGgEJqno0lmg9sGdds6j7WHarlTOWJy3z582Z4rl/mgvK9BdAq
	 vE10xMi9oHkDDF/qqxNCOeKBfla9QZUgCgRPwTMW53caRAEZ2QMSen5uUCbNr84zAR
	 d8rkke9O5DyhKqihF1rb1G/JQt8FJ1ivfWSlhgF+inXL2OvPSC8SwS0Zqx0ziMHwmg
	 Fb4BCVN8j1FJFoG86gcVEpqom5iJDE14fBzBnGpg+roN1/KYYYMqq9Wfj0QxLH+w/f
	 tyebf2xdsw5c3MLmrVmxn9QBxHHjWHTISIxTfED9aoKGLNtFIoYHzYBfApFrrOfYxx
	 KXVMwGKIJc7Dg==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 527052034B;
	Fri, 13 Nov 2026 16:02:43 +0100 (CET)
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
Subject: [PATCH net-next v4 5/6] arm64: dts: s32n79-rdb: enable NETC IEP18
Date: Fri, 13 Nov 2026 17:02:36 +0200
Message-Id: <6f1ea6caef6ca01c9a6384cd1024384d31848c53.1794581338.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794581338.git.claudiu.manoil@nxp.com>
References: <cover.1794581338.git.claudiu.manoil@nxp.com>
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

Enable the NETC v4 ECAM bus #18 on the S32N79-RDB board so that the
ENETC v4 Pseudo-MAC port (PPM) PF and VF instances are probed.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v4: none
v3: none
v2: none

 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
index 1feccd61258e..897ba24ac03a 100644
--- a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -68,3 +68,7 @@ &usdhc0 {
 	no-sdio;
 	status = "okay";
 };
+
+&netc_iep18 {
+	status = "okay";
+};
-- 
2.34.1

