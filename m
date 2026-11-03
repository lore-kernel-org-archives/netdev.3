Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710236;
	b=0t6IZ5wF0A8+YLha6k9/W+oYYfE71j7TYwBB1Y8+DvJrd4hTfi690/DN/jtBip0KlZ3o
	 ThzkCKRx/AbeaFRZAbOn8t4BcYob/cBhUkr8B9OAKM9zPhDoeHXlv7ePIo6KhVSk+0Bc+
	 74u77KLj/hWJVGPKdmw0GWEa+MWH7VkiGo6C5KgHB1RigUuxk0q2H2PAQfXg/4pXLP3j2
	 U+Ae4sDdyatlPM4iu1eosvua3XAyIe8K6BA6v+U7HdscZwsZdlPaph+BU4KUQe1S/KjKJ
	 0PQiTePG69EtWzhgqU2UqX7XjhXZMOJwGxs/EQ4GwBUKabLuU27XO18hIPqsLW7Toag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H+cfFyacKnvXXbKM76/KTfUCfiKdR1kh7jxYi4VJtCA=;
	b=cWvXuo3/kGnzxkUFD1HdDraLqR3oQdDgYWAMIqdPN9Z+2DnMHPxgPqQ9jAy/9eSaWwyU
	 Y7F/5L8PsyftqFvHuO2tY69gbGxoPlWPMqcs6R+jc6KWvO2wbjPsnNRaYS/4E0QLsuhCR
	 RRmI6NLiq0wG4P7hfYodfLsBZqWMIRAo+l4kn6edpQacbd8jv680J9RnB7uuGbC7Vtp2K
	 kVw6P390CHogbjKKbSJf7MgJsojzDza4tO/wExvrIfSACe85iXLxDCInq/Lf1Bn/A8vPF
	 tkqRRsrPHo8kda1LG2sGRXZtAN2/mjeMg50l/ldVm5f6k6ekdLQ+A3QJ82zbCBVAndQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8KuSwzX;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CEB606D836
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CEB606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8KuSwzX
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so33344905e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710234; x=1794315034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H+cfFyacKnvXXbKM76/KTfUCfiKdR1kh7jxYi4VJtCA=;
        b=Q8KuSwzXjouMwWmBnts/XWeS42L0Ik3LHP2QrFv2yM8q1JKFFjQLu2UwNIvjNDzVtG
         t0pHOzE5D8KOvc9FYZ6CwQwUDDWPxWVaWW5ScjmjVA/hTMrrZzY+yR/k8pxeQjdRD3kZ
         98yBEQUGuMBa/S88Y5mUjcsz2mtt8a15INdB5LqRpgNLFAwZdRQAq8GA959gfr9DpwFn
         LXYIwDQIWHbMwczAeV4L8yvEhn0HieTFxv5xxEzRw4Bl3vdiBbeRzbk7LxCiJ3j+ohZ0
         VN/IDffICXi25aLJcEvS5keKHnTUscx3vYy34UZ6/yFlfPVECyWSOMaSu5yvC+dHv4Tn
         UtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710234; x=1794315034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H+cfFyacKnvXXbKM76/KTfUCfiKdR1kh7jxYi4VJtCA=;
        b=LYSmbxV0xfx8rwuMHkL26v9aiw4jFgn1B5e6ZdFIJJZydcYZdYsmCR3DuNbdqPO7i/
         0ADLsyKUvzw+wM6fbktfhQdfqL/kij7wPqF6qWuV/9dhgIocy2rb0tWEOqO5QvDD0E8R
         tgIGqk5xkP83tmtTIUtuvMm4xzgRbSMAcN8LaEnRPl16jkOS8zungsxL7DX99mJ2LNXe
         JfSJP7ooAnze4Bogxt+b2LXx1S/Y/IQhGOu4LO/lquXiNQBVMRGDQRqgzY885nCLPad9
         WHraPUKwkdc7nrZBhLB2TCi6ad8oUoQqSXGYL8Z1wIJPh6Fik4J11Ss3xublAFmYvQ4t
         rxoQ==
X-Gm-Message-State: APuU4Z8UEWpcPCvi67wvGkHRdJ1DB9CE3aPlTJUqVh0jEEBf/xYuhoWZ
	0EkiQzB0AW2JW2LjmBKs00kFsghaMV+zBNTX9JaACt6wpFAB3sbY+qB/TTjAFs6o
X-Gm-Gg: AYBFou0i2qLQLKb8+oO1msP6QYYj5AiDxV3T7H8fAMktHdx5/tl8n4z9t0+a/R+5vX7
	zEJhQD038SjJIkn9wnfP/4FsYyCnnTsYOxnqs5dM8fDiGWniy8vIfwOB6d3HXWE6h9tPWsa9G7j
	atEypHsPQh0K3fQMwhtANxo2p/yf0jL5nB6FSPKXlvi26joCh4VU4c4YlHE2lO240OCxxMJv9eL
	AvGCvBZuT1cxO6M4vBBlch3D/YMziHTveGRHEnwtGHo92/NDR7acVgHf4qIxypCQ5tfzaLGuHHH
	G20Ge5CypHG5YfpaaqrD0BjJ8xa/3DsB+H8vX+d7+pd8UVdX4+rWUUQ1cqLC/TGd3Jbv8YNx4nI
	bOknga1JRoM48ddYw/1lrcAi+PJTL7nZbmObJUuQL2REXaroTiuj6+J4Mqsc0zeAXfx7B5qEDHV
	dW71s983BENMtZh0Un0+4UgjhAJS9F1w63ar4qGqz/4WivzUwylc1IwB1Vtc8Vyevg/z9c5Xl93
	UQchnf1s6XS9tNBBHix6igdl85oOw+jRa9Q17JqWglGtotQQWYqWYEyU5O5TdI3FXS0MZoaFgiY
	BQA+cKIIaHz3UFckY6l0PnDZo0GSgSxYBdNtCsqjuVuW9Ek7BeU8+5HRh2w2k8fJeFxrFzwTJ2Z
	8pPibGDIvKftSlvK1jlREJU5hKxfB58CIlEoX6Q98yAmYjHlnWMBk4zzFZdRYiAAwQ0wSyuNLa9
	wWdspiyn8=
X-Received: by 2002:a05:600c:a49:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4ac17ffb2ffmr301644235e9.9.1793710234379;
        Tue, 03 Nov 2026 04:50:34 -0800 (PST)
Received: from localhost.localdomain ([2a00:102a:403b:96a2:e8a9:f4a7:ed37:36a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm61406425e9.0.2026.11.03.04.50.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 04:50:33 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/5] net: mvneta: serve the TX queues in weighted round robin
Date: Tue,  3 Nov 2026 13:50:19 +0100
Message-ID: <20261103125021.70845-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
References: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
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

Under load, some TX queues get no service at all. With four TCP streams
on a 100 Mbit/s link, up to three streams sent nothing for 20 seconds.

The TX queue arbiter is left at its reset default, which serves all
queues in fixed priority. The stack spreads the flows over the queues,
so a busy queue starves the others.

Give the TX queues the same WRR weight and clear the fixed priority.
Like the Marvell reference driver, use the smallest weight that is
larger than the largest packet.

The mqprio offload never configured the TX scheduling, so its traffic
classes lose the fixed priority of the reset default as well.

Tested on a Turris Omnia (Armada 385). With this patch each busy TX
queue gets an equal share of the link and no stream stalls.

Fixes: ee40a116ebf1 ("net: mvneta: fix improper tx queue usage in mvneta_tx()")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 79711a117c39..75d46349df37 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -253,6 +253,7 @@
 #define MVNETA_TXQ_CMD1_REG			 0x3e00
 #define      MVNETA_TXQ_CMD1_BW_LIM_SEL_V1	 BIT(3)
 #define      MVNETA_TXQ_CMD1_BW_LIM_EN		 BIT(0)
+#define MVNETA_TXQ_FIXED_PRIO_REG		 0x3e04
 #define MVNETA_REFILL_NUM_CLK_REG		 0x3e08
 #define      MVNETA_REFILL_MAX_NUM_CLK		 0x0000ffff
 #define MVNETA_TX_MTU                            0x3e0c
@@ -264,6 +265,8 @@
 #define      MVNETA_TXQ_BUCKET_REFILL_VALUE_MAX	 0x0007ffff
 #define MVNETA_TXQ_TOKEN_SIZE_REG(q)             (0x3e40 + ((q) << 2))
 #define      MVNETA_TXQ_TOKEN_SIZE_MAX           0x7fffffff
+#define MVNETA_TXQ_WRR_ARB_REG(q)		 (0x3e80 + ((q) << 2))
+#define      MVNETA_TXQ_WRR_WEIGHT_MASK		 0xff
 
 /* The values of the bucket refill base period and refill period are taken from
  * the reference manual, and adds up to a base resolution of 10Kbps. This allows
@@ -1629,6 +1632,24 @@ static void mvneta_txq_max_tx_size_set(struct mvneta_port *pp, int max_tx_size)
 	}
 }
 
+/* With the default fixed priority, a busy queue starves the others */
+static void mvneta_txq_wrr_set(struct mvneta_port *pp, int max_tx_size)
+{
+	/* In units of 256 bytes, must exceed the largest packet */
+	u32 weight = max_tx_size / 256 + 1;
+	int queue;
+	u32 val;
+
+	for (queue = 0; queue < txq_number; queue++) {
+		val = mvreg_read(pp, MVNETA_TXQ_WRR_ARB_REG(queue));
+		val &= ~MVNETA_TXQ_WRR_WEIGHT_MASK;
+		val |= weight;
+		mvreg_write(pp, MVNETA_TXQ_WRR_ARB_REG(queue), val);
+	}
+
+	mvreg_write(pp, MVNETA_TXQ_FIXED_PRIO_REG, 0);
+}
+
 /* Set unicast address */
 static void mvneta_set_ucast_addr(struct mvneta_port *pp, u8 last_nibble,
 				  int queue)
@@ -3760,6 +3781,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
 
 	mvneta_max_rx_size_set(pp, pp->pkt_size);
 	mvneta_txq_max_tx_size_set(pp, pp->pkt_size);
+	mvneta_txq_wrr_set(pp, pp->pkt_size);
 
 	/* start the Rx/Tx activity */
 	mvneta_port_enable(pp);
-- 
2.54.0 (Apple Git-157)

