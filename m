Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618905;
	b=PcV5hJW7z5XmTX/N9zqCiqMnfbOOZg7vktbFOs9GJp+2zzI6CA4WptJaOfZQ+/NaLM2W
	 jHxMPW43ulkInJBm9mr028RmRf59CF0CnQNcngn+qVugMIDr91+s3/WgYAGQ3agpAz9RL
	 EwQOgonD6whGwTbt1/nS3P2/ZYwL1kWD45Lttkx5WFEkioQABqG+DCFIgIy9H/LNjzoUX
	 WMJ3x2nJAFiLzGQlRS9c560ulT06/o48uDZBUy16yYSelDr52X7MMO3Q9dQDIYAEoBMYw
	 I/r9R+kxlNIIcp3CezM6709DGeMKFUtD+LARKuTiVBK3IwuXRpKRP3BgB6ie7i/awzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FzucKFRc/0FsGEtKvweQO1wEmVDqjPM+A+iwpDIaZJQ=;
	b=uRXdNlptYsZVSXg9r1qwqODoisg21EBnWx1kJGxlMAT51M98QFyNZbUD/mpcaecI2H1i
	 z0Jx4+v/rmAeamsYwJOfJSsXVUCOCZ3qkaOhUJb85pFRv7/VZVdyjPGSccXU28v0g5lXl
	 ZYVPjP/sxqSJWv2QSGtN07y4KGOHZHQQTmS4qsrfPgHwFl+Ux9oIYKQFRvZLryUsDcTU1
	 fJeTurDklQz6vqMhqEdBlNXeL65mU1KIZJI/ytH82c5reGuQ7nGk9tBvF+TjtjHDN8pn+
	 Vi52QRjMODXjr0f10pg/hZxHpQlU37E7tY0R8mBZfFZ3iHB/MmYPsxVE8jAt6XTmm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vFkFVvXH;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CE60A3814
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98CE60A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vFkFVvXH
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d05d51553so17963085e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618903; x=1794223703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzucKFRc/0FsGEtKvweQO1wEmVDqjPM+A+iwpDIaZJQ=;
        b=vFkFVvXHi0NlYuN6jVG30IWszK9gUAmUNh0/1hALC1T/quF1SbmqrGtCxB7YyixTOf
         u291iALbYmhcwvQpFkAd3TSDdhLdu4ySRK3/wjwHQNT6SKdAMKppB/XlCeEwfePdVvUI
         YQvNSf+5Wv+nINeL//seMqGlM5+iBQM49hQniBWAmKhKTBp8FiQJuo6I1Zt2CVLEYe3a
         IxmSeiY5ZzUbu1v+B7TvxmAyA7exBSdjmr0metJIrqlWwufqs2lKBAU52PDM6d8IUjDh
         ZKdVFsWH5+4aHp5touEE+HPj9Xi/dVR0dp+BSPF7O1ya0wvLVHK/qX2CdzSB4f9vnLVA
         6xEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618903; x=1794223703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FzucKFRc/0FsGEtKvweQO1wEmVDqjPM+A+iwpDIaZJQ=;
        b=IKsjuTh5hoRTKMbZ33qiOpntrYoYJM7epkbun9PbuhVsqZ2xjdgn+2D07yiSiufN2m
         3+WhALalbUo5be0cpsDVwx70Y8GVBtMtOs+1586aaQHJ7LCuYhotUU11dUVlybL6wEv8
         SxE4J46SnmCfZfietnszjAYJZrgrC3msfnNqsC+o5RC5xvhRn8TNtSkOMj+OSHEROeL2
         AriRjOVYB6Lm7IJfAT8mVwg4ccw9OdlfQHC/oA9+5BqflvdK4tvwdKpGOFD+Qpw9vRB6
         khWl7faaeEXCkzG74yTrd31p3zXcsegSVZpmd8aFzNcdTKYdrw3EWxZzPU/hJjpZuAoU
         gG/Q==
X-Gm-Message-State: AFq9FYK9bVmpCBlySL87eRvFxoRTsLvA6ohwwu1ibPjwMLMqRX/bA1Sv
	1ErU4enSd7jWGmZesbrcAqaYtIn+gPuL3HHuvkB2IPFYVeJ7yZlqlQf6xWEZNh7Z
X-Gm-Gg: AYBFou1oGXWmVTsduRbATeu7C1dZg/ZiBocQhEYEplOvba9RTjRVfmR7cI7JRpeYiv5
	IhTJMSXHVduFHvK24Bkb48stcFWGU3/0Rpg8yIFlUXyCv/FJ60BF2jTDqcIE1H2LqHBJ+rqsPaF
	Xoh+y8BEpqV31/rPK1cO1ORJrIxiX94l4iJJqSCmm+QIPogVA60hSGXotjYVp3Y7iqN9qCOx6sU
	R1Jk63T65TImbgHypfYTiXhgXujLoZiIpNa3y6gZ+es80T8t0nWE4ocj9Vz5hsqvPhipgmt8FpN
	j4Yjn49DWYHjgSg1uS5jxoJadA8PtbOll2v7mEpbKoXrfCz2vg61dwYLkiI9U/9n85VwXOoUnEb
	1vbDeTT/jvz3h7vDQWrkOfjKDLv6FBx4DJY1ajOOupW3CSjZ8m1pFyxu6XCuZv4HjA2uFacLznG
	n6PWQeYGzD1F2jHA3gUSfoUNrqqx5JFTZ1nBoHYNgx9e2yXRGl7Dy8T85jlSHls1ABs4qnpS67V
	4l2XVa6KSyJQ4F19Sqjljd/q1vyk7n7bzTfZgzuGZukpr+DtmvlgOKfZtQzsF/UPiIJJRP8jsEG
	H6er8Ma5yFVYo5y6JPguZjfWyJzft0z62ijLmgLt6ADeIcdgv5tLDqE0rOfr/3S7PzHlbLiPXck
	EcQ3Zgo9goTEZkwD2JfKXCYbSj/CqrnUQ/gx1HBj5mxWg1XIJED3agqfvOUfdygrLvQMYoEW6GW
	07YNLDZuEC2cDHwhtomFTrsdE4I6BXaCbftQBUkBEVIe20JeP0FajuyQ==
X-Received: by 2002:a05:600d:e:b0:4ad:181a:4350 with SMTP id 5b1f17b1804b1-4ad181a44a0mr141947245e9.21.1793618903221;
        Mon, 02 Nov 2026 03:28:23 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-f91d-46ab-c9c7-94fc.ipv6.o2.cz. [2a00:1028:8388:a84e:f91d:46ab:c9c7:94fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm311382215e9.12.2026.11.02.03.28.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 03:28:22 -0800 (PST)
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
Subject: [PATCH net 3/3] net: mvneta: serve the TX queues in weighted round robin
Date: Mon,  2 Nov 2026 12:28:16 +0100
Message-ID: <20261102112816.12322-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102112816.12322-1-pepe.schlehofer@gmail.com>
References: <20261102112816.12322-1-pepe.schlehofer@gmail.com>
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

