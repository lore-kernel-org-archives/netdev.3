Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579748;
	b=FfruGCVfjpESzhQzqjJf+0UGV80Cfj3Mic4oH6R9sNYFrHszElYa8zO7UayXK3uZghkI
	 ZnFGc73utIKdLj1y4V7irI+DKbNJ2N6kvndgR+GM6SNC7zpUcPL2nyuxSeOYswGjfYmXZ
	 14/zguiLuaKFZtYMlJoK2s1O7L1OLRoisqtNnD3w69F54o73z0qtMAmkwfW+TyEsPoplG
	 wszKY+OJzCnRzkfJXFOAsdMWq/tcqNkUCkRZZ0aAjSeugGOL7m686VdGbmfn3YV8cc9No
	 hpWWFavJggApJKv7TNwdiNIJ2NBEsm5w2oQiCMN+u1Tky+KmAx5exya/ftjeEzkK6hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579748;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=HFVvyD1aHnlLu1dMDSGzg74kJ9XSDJgZ4PQQxQ1rwMM=;
	b=eHkGCIdR8jkQinKjoi0edzUb7qrvolt9q/1XaupVGb/13Rrp84AKbpHu1SzVk22Qst1s
	 AbWwGazwFRvSUgzHhV8GVnw5csqeJuAvWlmPYY9/tKkpNBlCKEGIqh+Df7XQxC7Vr1O4i
	 oePkxQjLb5QSyXXomRQaVNJvFxB2yhZDNiyqdO6J99NtKNOUpi/ON1A8ZQGahqFVCKcpG
	 IAcR4OZra0E5xLxhyNFRmZqCFfVB9Wx7m3LnhOCPF63uDDDYLsBI09NW/4aYqXkhTw4U0
	 +l+JzjY3Mzfg0lYJbdNhfHiKCSCmW4KkeXKEOtr5Qa5R/klTRU1HUwNImP5luoLpjCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=zFHic1Hg;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D4606A31B;
	Wed, 21 Oct 2026 10:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A2D4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=zFHic1Hg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792579754; x=1824115754;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Gj1oYLTBDiA87DUaik7BYJ9swhiu1prPvBcMftysvEE=;
  b=zFHic1HgX2kDdaUG0wrb6ZLBt/4EQg6NBfQx1LlWW9X8w5PQhjkZYkfY
   k8qcJTsBs+LpLGIwsqUaLM+kc+DA2TojVuRpH7eI+hO+9NK/rhhgXCmqO
   dWT7O9PkpHFsmsZuedvNd0gZZSdVFrgMkR0e3ZYN9aciuGBbEERPH99sx
   dvruSi6gQOVuWGsqOYOmwVU+SZYxvPteF8TZCvq1DpDzYD0roTLfeNbQW
   LXf7H5Bu7XFrkGcmfTamL060yRE2Pz3ukg/Q5eSztWuLM9LKROW927TaQ
   Gcb0fnYgqWcwHF8m0UKsjfd5P/iVQCzAfmNPbPbEdqz+r/J58PQU73tW4
   g==;
X-CSE-ConnectionGUID: Io7L0h0CT6WwngO0rpe36w==
X-CSE-MsgGUID: kTsDSRMPSsePhOScqVszTw==
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="75804722"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2026 03:49:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 21 Oct 2026 03:49:06 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 21 Oct 2026 03:49:04 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 21 Oct 2026 12:48:26 +0200
Subject: [PATCH] net: sparx5/lan969x: do not read past skb->len when
 injecting a frame
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261021-sparx5-inject-tail-bytes-v1-1-7dcc035c8ddf@microchip.com>
X-B4-Tracking: v=1; b=H4sIAHmY2GoC/x3MQQqAIBBA0avErBtQwYiuEi3MxpoIC0eiiO6et
 HyL/x8QSkwCXfVAopOF91ig6wr84uJMyFMxGGUarYxCOVy6LHJcyWfMjjcc70yC1Gofgrejaiy
 U/EgU+PrX/fC+H+mnxbFqAAAA
X-Change-ID: 20261020-sparx5-inject-tail-bytes-e81cffc5b065
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Bjarni
 Jonasson" <bjarni.jonasson@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>
CC: Steen Hegelund <steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

sparx5_inject() writes the frame to the injection FIFO one 32-bit word
at a time, and pads frames shorter than 60 bytes with zero words.

Before this patch, the last word is loaded whole even when skb->len is
not a multiple of four, so 1 to 3 bytes past the end of the frame are
read. For a frame shorter than 60 bytes those bytes are also
transmitted, as VLD_BYTES marks the whole last word valid and the
padding starts at the next word.

Write the trailing bytes from a zeroed word. The number of words written
and VLD_BYTES are unchanged.

Found by an AI code review agent, and reproduced on lan969x and sparx5
with register injection: bytes 57 to 59 of a 57 byte frame were not
zero. With the fix they are zero, and traffic still passes on both
chips.

Fixes: f3cad2611a77 ("net: sparx5: add hostmode with phylink support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index f713656f1fae..14c9ae673e35 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -169,8 +169,8 @@ static int sparx5_inject(struct sparx5 *sparx5,
 			 struct sk_buff *skb,
 			 struct net_device *ndev)
 {
+	u32 val, w, count, last;
 	int grp = INJ_QUEUE;
-	u32 val, w, count;
 	u8 *buf;
 
 	val = spx5_rd(sparx5, QS_INJ_STATUS);
@@ -189,14 +189,23 @@ static int sparx5_inject(struct sparx5 *sparx5,
 	for (w = 0; w < IFH_LEN; w++)
 		spx5_wr(ifh[w], sparx5, QS_INJ_WR(grp));
 
-	/* Write words, round up */
-	count = DIV_ROUND_UP(skb->len, 4);
+	/* Write the whole words of the frame */
+	count = skb->len / 4;
 	buf = skb->data;
 	for (w = 0; w < count; w++, buf += 4) {
 		val = get_unaligned((const u32 *)buf);
 		spx5_wr(val, sparx5, QS_INJ_WR(grp));
 	}
 
+	/* Write the last 1 to 3 bytes, zero padded to a whole word */
+	last = skb->len % 4;
+	if (last) {
+		val = 0;
+		memcpy(&val, buf, last);
+		spx5_wr(val, sparx5, QS_INJ_WR(grp));
+		w++;
+	}
+
 	/* Add padding */
 	while (w < (60 / 4)) {
 		spx5_wr(0, sparx5, QS_INJ_WR(grp));

---
base-commit: d06ae66516e1aaf023808912af6292aef09d46c3
change-id: 20261020-sparx5-inject-tail-bytes-e81cffc5b065

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

