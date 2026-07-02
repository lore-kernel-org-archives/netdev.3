Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376E48BD32;
	Thu,  2 Jul 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996967; cv=none; b=BmCZq9P071U1Xe8TXCERh/UBD6gJA0DUURkEhiqhY049rdMmDbsIwKX+26o1exWhtEQE3Hrzm8gZhpmT3gFfa/nTtbAKh5tcx+2v4P1xT88PX2Dtp0SJsB+DvbMHxDDflOENeeU6kNobnTaInguHMqfiGz6wlpzTuHYOSJtDHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996967; c=relaxed/simple;
	bh=PpoJ8mSDeO5J500ag0sun37EeE6AvIqeZEsWDfHGEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLf5eni1ZGcVRxOJy8q3LRCl9pd26DS38ZORQyUoJTVmSgiw03Y68+KaQW/uJWh+OujNwKnGqTsl1Fr07TULx0TQq09EwbRmjngb0hHM16n4Qv+vJ4G5x+b44yWctd6on6dQQaQ1lAdc9RqONlkm+8+FR3iME+UYi6DlzM1czLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ifCXH/6L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpParjzF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ifCXH/6L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpParjzF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DC247EC00B1;
	Thu,  2 Jul 2026 08:56:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 02 Jul 2026 08:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782996964;
	 x=1783083364; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=
	ifCXH/6LLWkX3f5iQmwzPX3gfOP7f2JI5CtXbBtP+wvK71Xmb84kH5g4lzr/R3OG
	g7xuJkNC2HwrI+9che4RhfHRO60HSbrkzrZwiDaFEOtGXJBjeXP8ULwI7lHn9HiL
	bMZ0FQYt7wyYe7zQcJQSKgRBFjxjjd25pS8E4MFGbGi161I9YShSGx83FkgzewqN
	RDxLbWnxt4XjOrkUVX4Ytr54TKgER8iCgLgZnLjudSPZSDXJE5YT7QwhSTmkqkbi
	If0SIlnCe7nafv3PWtx4lgcdxaTc9uxATTblORKF5OOfv9ZpIBT7Ukw/wTdOLe/s
	m2XI+mcflNnkyrxzZFMhzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782996964; x=
	1783083364; bh=sLmOrxWgSzKesbLl24YL8N9oK1UdIQD9gnT9tarZDw8=; b=R
	pParjzFzwMbffdbLG5lU9OaDGqkuZ4eSA3Ko9nIXudFN1S6D8yYZiMSsuptNSrGc
	YP7I7/PhpcCCsmGQBFE+Jz8r2DJXGGOQZpe/Jelzgk/z3CzCNwdqKMnRIxFTB6p0
	I4ELSout5OHCfEZp2hPYYCEuWpkTrsfCjlEjHRteU167uagn3gumVeISbYPEDlp8
	/HXqGvTKvd9mtw8soyS6+RPC96V7WtMY2CNBKD8rCNVT0maqu9/DGndlmhyMQqIe
	MGG0HqFXqHYMPbOoLgR1AgmnAi6J4ShYVUUzmOplVhur8tJ988Y0xLoM8UHpq1vO
	wpXux9eu1duenXLeVkh7w==
X-ME-Sender: <xms:5F9GalhVWgykerBOaZ8O-TwRoUMMUpg5TzDCjPXY-Av4aIS0H0k-Rg>
    <xme:5F9GaoikyUeixZzpgx-wOkqwOwz2YMeq7-BVZztYVFT0y1C1jRefHuWx_z2H6rlAu
    wmrEOb5W2U776lsiP-vePgQlA0YBGZ1ZbtfGM79USgS9HSA9hP7diN1>
X-ME-Received: <xmr:5F9Gar5ZCc4kGQFjDnYIWtxJh6mEyNDey53x0Wu0XCWyb1wX8iM5L7jbvQoLfQJUGaqA4QTz1dj2_BuCngwrA5jXxHx8-dA>
X-ME-Proxy-Cause: dmFkZTF1Wm/hbx4wKB7RR77todSlySJTpNhfXOJ/yd2PhYYiPGw37qDK8rMMd09Q2azuE/
    nzrscVUY4BHVBtAKg7TyEvnQ5ypyaNZ9h00nHDzh2cfuLJYphWxOdNDGjsapRO9spk4VLz
    13GwkSociu8raM1MBsFFoKxoTVDG92zYimmUZQgGlhmdRaQjUqHsp5l2CPhB+Li3uKsDZC
    LganBO/QY351N3JtlvNeOWULXzWrurPYpmanYzbpJmGeY1nD2SDhyvgz3wgbKAXjKrFDWj
    2ERxE8D7j5v5wWaOtumcWVfyqy1KNwsDmoZjnyUodLtF11MG1q7Bc6vIpgpoCv1MCmgKIp
    zHFTvDZ7XlKIx/EWcUP82IPlJW1eZroPjWcDM9hq+daonUwRRkCHGtkc83Zj54LUxDlvnU
    z9xdy5taySFzJiVGuJX+nMh6KItuDdfRpPlYRotwW6mkOdNaNQp+9kUjRqQDbDPAZiIOWd
    VVxbeCPzBqteBDXqhJ8cCR82sQOHRXzDqQzBFsiK4uFzAwEF3/p4P2OUNjzeY51MX1y2nB
    lnwp8S+r8MNUS7mSu/XnpmNyg9D7KkV4B6oUT53dA71I9k5szVX6Vtm4k5vCC5RWjkO7iZ
    40Qp/mGx7keO89RMAjDOi5d2LMJA9Cbr/9vspkjNsCyLNT+TIBBSXzpnLAAw
X-ME-Proxy: <xmx:5F9GaqQ1KnHc5cud2lj5TEyk0BX_CATSV8cKsbJumWc7tUUD21pmoQ>
    <xmx:5F9Gaq9sWZaKOl9qvPuHIPMAUpwZxhr-Z5sSeUvXqTp0wxIhzUbuug>
    <xmx:5F9Garr-RIvrVCfV8WmsWAh3R3aHekBZcC6nwm9BPy-ZWysww0uWVg>
    <xmx:5F9GagWXYEdLACJY6GTJUIuHXDBFMqn4fieccZ29vQOclS3Yb4skNQ>
    <xmx:5F9Gal8mVKI3AqyOCxm8N7LvOoyHHI_STR7TF6JXty-Rt0MCFsHuh-C3>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:56:04 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v4 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
Date: Thu,  2 Jul 2026 14:55:25 +0200
Message-ID: <20260702125525.2230427-4-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702125525.2230427-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260702125525.2230427-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The gPTP module is shared between the RAVB and RTSN Ethernet devices on
the SoC.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v2
- Preserve sort order by unit-address.

* Changes since v1
- Rename node ptp.
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 82a7278836e5..b9b860ef7035 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -589,6 +589,15 @@ tmu4: timer@ffc00000 {
 			status = "disabled";
 		};
 
+		gptp: ptp@e6449000 {
+			compatible = "renesas,r8a779g0-gptp", "renesas,rcar-gen4-gptp";
+			reg = <0 0xe6449000 0 0x500>;
+			clocks = <&cpg CPG_MOD 2723>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 2723>;
+			status = "disabled";
+		};
+
 		tsn0: ethernet@e6460000 {
 			compatible = "renesas,r8a779g0-ethertsn", "renesas,rcar-gen4-ethertsn";
 			reg = <0 0xe6460000 0 0x7000>,
-- 
2.55.0

