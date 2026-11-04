Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826492;
	b=x4i/oFQZOi4ylqWFbXfsa2TkC+H6NjdmGs+H5rDpllkviOMjdYSAT0+hpNwEwUp5FDs5
	 IsTVHTJN/Uzhx525O6wv28MTheZUyMYokFt2Ofi1uTGY1llexsT9eoIRxa6CoTQgt5ddM
	 pwqHNnQUl+kC3LP+/3/oLBMCRYdbh/X4qvf88E/9gHlnqGlbT0egfEDrRoBh0QI5c+lnd
	 I504axJ8n/ALjVKQwoyKA03B65IYIgpA3DsoGnRm9iN17CpRwyF+WJgEQmOBMdTXb+meZ
	 pqm8L6SqpwVr4IivxCLZ8EBG8NnMCgwasmCD5LWyGpmzYqB46LJLyOYflksTCGuiuVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zLUlTrWUrZlW6da19wVYGoPMtRV5Cw9RHJvjglnzl1g=;
	b=EPlhk/DRJyOetM49JzW7dBdAeogtc2DDzcQ62MiAwFld1vB1bNXOriA+S/ilhyEXL4kM
	 6pyDpklev2u7srldYk3oU0F5Aeabnr+Uf5jsoDXAcykwF1GB3qdLbh0LYsrKK6wSP4g/m
	 YOtmd4U4X0lm8XzsK4V8pxKix+EbeUAKCngcnxN7BEiCEKbep2o6q3QPojCyeNx/2dBDf
	 VQ9BYCiiRj+X8DsmZkpSAzKqnxcfLrhwXwCOXftfEDo8hxoyNr5mMYpU71gkBYB5aN4u0
	 vFnm6292LQ3PhoEGnP2XWa/oofagiQ+GBSbAx2G3BAcLVx6GViDrZES0FwHutwlSDIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htoWSRom;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A36078C6B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE5A36078C6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htoWSRom
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso8895925e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826490; x=1794431290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLUlTrWUrZlW6da19wVYGoPMtRV5Cw9RHJvjglnzl1g=;
        b=htoWSRomIOo/HjvKNDbGno8MC+hQ4xmvxLcdoGx4PduHiasLQfrY55anLjtCQqyNOB
         x8tV0no2rvrXYwVrNEC60wvoMIz034KDLY71VcbGA++Wn5vTnXr9Z3RjpSFSCOluiBTp
         MI7jowfD9cOmQ+0jErrLEV08zPv5diBSwh1CeJPC8GMywOeIPiZipEuI7pFLMdvHoFRQ
         hZysZQ6H/NOPP4c/+/Hni2k0PMOVAq4sy+Jl5sLwILO1DBu6CXoBvrS6karhvevru0+i
         NK1hta+V+nnWugLy/aeksmFkyBrLf18j9NTXgxRgX+ucJ+JpUCa0mJdYmwuZwEC/VJog
         6+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826490; x=1794431290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLUlTrWUrZlW6da19wVYGoPMtRV5Cw9RHJvjglnzl1g=;
        b=U+8Nn7/9aZPTYgQ2uiW7/GE39XyaGqXn2vnkfp6l6bvBpIRSNTCll3kXmuYWQcpqgT
         gyg5TvyAad7QBbqYKA2gpaDGHKfd1O5nDRxu3Vqtrn46c5bXDTJZ+d9Y3xVKDvMZPspg
         Ufx7s4eLPeA1qa0g77tZYNTxLZhm3upIQbNFFcYIRMG7V/eukj4oVtEl+9RwFmqQGGH5
         ZdIdBMdGPpxKD4Ei+OPvIv11CJAugta++HkSkaEgJEgTzivy/igtZtYoOS0aG0rab5Rd
         irQMD7TrZzeS0BQN+sIdXIepMgZ1iRqu6I/LIf+PtRvklqa+TmhS9PISDd0EO0EP1p/U
         8lFA==
X-Forwarded-Encrypted: i=1; AKwUvBwUGMvyJsQZCNofkd9IYv/WIR/Kn+9ydFzzew3xW+prhepX87ud6kRnknfzo9FqfVduIIRoYxM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y9JBp0BlFuYIeYbu3uoXA9VzxNuuYeRiAnf+vebsaitF4y6YR
	aqO6IN5tsV5H3b3wdJF7xaUo4j4toACCDEqWqqQHp19QMkgh0CnWSKLH
X-Gm-Gg: AYBFou3YVLZummCqhWQ/O3YWG4Z3RZn7PwtjkArWCWnoCNPFknv/V7SGrs5VJkjLLpt
	ZqQuwLQRv8HDJbQTu1+kxirXUDDj8hCftSieDSV1LBgnjyhgXK+yhHEnVJhSpjMBKPVVC0LWLr9
	MgSdQWF4NJO6idScxzU5YsHozQpu6MwEe2woIN/xokLrhf5brYmsFmCyqSSGZJUaHKxPLLm8MEr
	27uLUKFIIyOg5mnMoO+I0+K6DrZO7MFt7/93RbwArxrU2ULV9YZG3FBB+JdILiBkjvMyfoBIDYE
	mubmMEl4kjGkzTBftm81oIxeY0UjRH1YjADH1x9l1FHXr14q0LOZ96gIVZ1YwgxQxgg0xSBAAZD
	FLKCP342K3avCtMtoB4XJ1FOXelVgkEL3iNbS/55quESsKxTBSvfKAG+l7Xbf6emQrwtbJ6gpK2
	7X11QpQbzhjx77Tz5kUuO4OQNIuJQBTNXIgAUl1BXP38nWv/opdQmJdP0qGAMpXOlf3iGf1+xGs
	GqXUJTErN2MgiKvS1BUUiIAtYZjWp1kD93Jgrdx0eJhhNSdBbUbC9ZhQXnWVqZtM3CygxtU/7eI
	FpKTp41MvhMNt8daLsYwSjcquoYXOvjLeT1HxORR0kCnBJH+pAk=
X-Received: by 2002:a05:600c:6212:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b0a7aa0a54mr220156985e9.25.1793826490149;
        Wed, 04 Nov 2026 13:08:10 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c23:788d:6769:d03c:c916:2aca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm11998855e9.1.2026.11.04.13.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:09 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yongzhao Chen <yongzhao.derek@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: dsa: qca8k: bound the data of a management ack frame
Date: Wed,  4 Nov 2026 22:07:57 +0100
Message-ID: <20261104210757.467964-5-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104210757.467964-1-kuncy7@gmail.com>
References: <20261104210757.467964-1-kuncy7@gmail.com>
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

qca8k_rw_reg_ack_handler() answers a management read by copying the
data that follows the Ethernet header into mgmt_eth_data->data. It
trusts the frame for both the length and the layout: the length field
of the frame allows up to 32 bytes while the buffer holds 16, so a
frame announcing more than three registers writes past the buffer into
the fields that follow it in qca8k_priv; and qca_tag_rcv() made only
the 2 byte tag linear, so the copy reads skb->data without checking
that the frame has the bytes it announces. The handler runs for every
ack frame, whatever its sequence number.

Size the buffer to what a management frame can carry, and pull the
announced data into the linear area before reading it. A frame that
is too short is left unacknowledged, so the read fails and the caller
falls back to MDIO.

An LLM assistant (Claude, claude-fable-5-1) helped write the change
and this description; I reviewed both and built them with W=1 on
arm64. The management path was exercised on a QCA8337 behind an
IPQ5018 (GL.iNet GL-B3000) with tag_qca.

Fixes: 90386223f44e ("net: dsa: qca8k: add support for larger read/write size with mgmt Ethernet")
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 21 ++++++++++++++++-----
 drivers/net/dsa/qca/qca8k.h      |  3 ++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index bc77dd45b6..01834e16a2 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -170,6 +170,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 	struct qca8k_mgmt_eth_data *mgmt_eth_data;
 	struct qca8k_priv *priv = ds->priv;
 	struct qca_mgmt_ethhdr *mgmt_ethhdr;
+	int data_len = 0;
 	u32 command;
 	u8 len, cmd;
 	int i;
@@ -190,6 +191,17 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 	/* We can ignore odd value, we always round up them in the alloc function. */
 	len *= sizeof(u16);
 
+	if (cmd == MDIO_READ && len > QCA_HDR_MGMT_DATA1_LEN)
+		data_len = min_t(int, QCA_HDR_MGMT_DATA2_LEN,
+				 len - QCA_HDR_MGMT_DATA1_LEN);
+
+	/* The tagger made only the tag linear. Leave a frame that is too
+	 * short for the data it announces unacknowledged: the read fails
+	 * and the caller falls back to MDIO.
+	 */
+	if (data_len && !pskb_may_pull(skb, data_len))
+		goto complete;
+
 	/* Make sure the seq match the requested packet */
 	if (get_unaligned_le32(&mgmt_ethhdr->seq) == mgmt_eth_data->seq)
 		mgmt_eth_data->ack = true;
@@ -199,13 +211,11 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 
 		*val = get_unaligned_le32(&mgmt_ethhdr->mdio_data);
 
-		/* Get the rest of the 12 byte of data.
-		 * The read/write function will extract the requested data.
+		/* Get the rest of the data.
+		 * The read function extracts what it asked for.
 		 */
-		if (len > QCA_HDR_MGMT_DATA1_LEN) {
+		if (data_len) {
 			__le32 *data2 = (__le32 *)skb->data;
-			int data_len = min_t(int, QCA_HDR_MGMT_DATA2_LEN,
-					     len - QCA_HDR_MGMT_DATA1_LEN);
 
 			val++;
 
@@ -217,6 +227,7 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 		}
 	}
 
+complete:
 	complete(&mgmt_eth_data->rw_done);
 }
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 79754755f1..b7aa0d832e 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -396,7 +396,8 @@ struct qca8k_mgmt_eth_data {
 	struct mutex mutex; /* Enforce one mdio read/write at time */
 	bool ack;
 	u32 seq;
-	u32 data[4];
+	/* The data a management frame can carry */
+	u32 data[(QCA_HDR_MGMT_DATA1_LEN + QCA_HDR_MGMT_DATA2_LEN) / sizeof(u32)];
 };
 
 struct qca8k_mib_eth_data {
-- 
2.43.0

