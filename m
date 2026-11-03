Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714965;
	b=lsvX5b3J0NSt4B/txSHWzcnPbE8QOA8sE9/iKH5qxmqYh/C8FzwxtS/mIqCsYu5Mr8vM
	 lMiKtWJXj0WKut1IlsU4Qn3IFH0rwbo2ULL+dNd+mZRUCmT4Ks5wHjwOm97lFjsA+EF27
	 jKwdmBHAVtBB8ErE+H/dyFLrOyVZX/m7yboh6A+pH+cMK7L5ekrhyU//H3gj07t+KWV9e
	 c+i8lUf4m/cYSccplsEFBBhADRjB7sIrEMaN0w4Kjf+CwePVl9k2+aCIrs32nS1JJaaPY
	 hrpKdNz1YytDFan/uTB48QrcZ5kaezryXBlr5qER7yvW+ozJfuf17PoePN7Jexj3KNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714965;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TaZ88bdbVZsQtosXQnNR3xMLn3i7UigiA3FkxA/swXE=;
	b=ucf1h+LZ7xPCwdxzFiqjc7rkcEmm67XXVtfymSB1koKFk36IwK12QBIdkfJyWVPFQTnu
	 EK3UQlikJKmWSnqSlbosDyRB4n4UpEHR5oEpUnSCB5A9/CBUp+F9XPbjK11m3XLgW/D3V
	 6zT0tasJWdyeDnXZD5805Q5o/EsMw4BOZQK8qf4PbrJCZ0C7Vf1gm7UdpuOWZG+fzxLdN
	 uvAoMuoWDcO5gvVzLp9WrlawHlI7A1Sc3hYbwFdOWBn/kjyPkEm+5mo4iboJHe7rgO9Ue
	 HS1tUWinQUIlsozcCZVdjmjonfDyHS6C+pcjijse7dsT4DPbNzMr+JmTN+DdUUmE6LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=EKswpJjh;
	arc=none smtp.remote-ip=92.121.32.54
Received: from inva129.nxp.com (inva129.nxp.com [92.121.32.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A6606A32E;
	Tue,  3 Nov 2026 14:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E21A6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=EKswpJjh
Received: from localhost (localhost [127.0.0.1])
	by inva129.nxp.com (Postfix) with ESMTP id 34A49600028F;
	Tue,  3 Nov 2026 15:09:18 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva129.nxp.com ([127.0.0.1])
 by localhost (inva129.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1cHhj4KGFOqx; Tue,  3 Nov 2026 15:09:17 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva129.nxp.com (Postfix) with ESMTP id ABD8A600009F;
	Tue,  3 Nov 2026 15:09:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva129.nxp.com ABD8A600009F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1793714957;
	bh=TaZ88bdbVZsQtosXQnNR3xMLn3i7UigiA3FkxA/swXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKswpJjhgNOXT5IvZFhJxY9np0ncS5pcthx9z9kqnr4+MZ0EuEYijQxv3rimBO94i
	 B2QYjrnG73KmO3TBfRv+bAbjmg+vl3ynuHBX0Vdr5OfMG48HsfuYNbJnXWjgfLYGeW
	 5Zd7lePuxqtupmF1r79doOmYZiqRP+poE+TWGAAX21H9VjbfnvaXXUUDsAkpaDnS2I
	 gJyByDRfXFkYFUWNXiQ+L8Cs6w+Ven1GPZqSVa/6/yYHP/AiZLpE1EKPai28K3R5Wk
	 e6EFvwLw7UGI2LiD1U8GGwTQ7fAOyvGk+jmJGFQjLPBVP2edh6vMaQJq67VRjswOvW
	 wznbXOAYM7IzQ==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CF663202AF;
	Tue,  3 Nov 2026 15:09:16 +0100 (CET)
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
Subject: [PATCH net-next v3 4/5] arm64: dts: s32n79-rdb: enable NETC IEP18
Date: Tue,  3 Nov 2026 16:09:10 +0200
Message-Id: <324f8f8178ed54e3b494a7f1b9d70acb0615ce35.1793712309.git.claudiu.manoil@nxp.com>
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

Enable the NETC v4 ECAM bus #18 on the S32N79-RDB board so that the
ENETC v4 Pseudo-MAC port (PPM) PF and VF instances are probed.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v3: none
v2: none

 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
index 1feccd61258ef..897ba24ac03ae 100644
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

