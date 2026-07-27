Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F3423EBE
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169208; cv=none; b=A1luJhn5QFgZl+PAXrSoHR4Azo2n63iY52REPH2UGJ/IkDzmKAct5N7VwDHRSrpcVEOZAV1NBHmVJi1oMZh+f2FZTRHPdTE3oa33GKGRKn7xkEU6yA9xt/YP5YOW1Z9BSzvPAXttx6onvc05ftzKWtTBjm27+t8oynX1Vvnxo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169208; c=relaxed/simple;
	bh=KxeNp93pwCEuioO3uavxojOIQiFQPvELBNqJqMfdJsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7qqjKqRkDSiZ6rS7tzTre2UAAn0WV3iNJED5oExovs9YV/ICQF9oGXa2d1WgXbN8TF8MWW2tmi+mnVvdTRbo7ZEjrj8LpU9j5ZNYFEmwVZyUD3pysW7VV89MP8S3Xx6+F88+VI9MNvgRJmax3CYr1uZ21xCCO1E/ZLaBacypys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBGawNOj; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBGawNOj"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883fbfso1059556a91.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169205; x=1785774005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jOKl9cuatMBwnsyU1wJ+nM+sSfz+zrZVzuTsvqWf2Wk=;
        b=ZBGawNOj2gvc54mOMpfB6OPELSokkE8QrxVoUoMwLg+ljxAYCIvAwW05540efMqqOK
         l+/p8BEB8uNvvCPL6bZnYpMC9WQyQuhs4Zek1u7bl0mY13GTQnAxZiK/BBKSbycFAELr
         5u28pjTwzVh5HK4gbXj2/bUBx0ZBZdB99WyGlFc4Rvrcbgtl/RyRYB3JPYX50kLaTfBJ
         weEEldfthpavC6modoeAL2JeZlQC3fVER3I+s4UvA5BwWerfs0CnUt7aQWLswf/hwVWi
         bDulmZsJSXBRRaxVfK/h/jJgFGbkVvt5gp+RxretCXavftigB4vY6Uyg8tzMsvOB+4lD
         u0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169205; x=1785774005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jOKl9cuatMBwnsyU1wJ+nM+sSfz+zrZVzuTsvqWf2Wk=;
        b=QnI2U1x81vgAD5JJuGIkx2CLtI0rNAIhD/mOD8nfh9+QkpFssiWfAVePiVCt3yTb/L
         YqT7s1Q8fguyIN3jt+na69Qni2X5Z5PWNi9wEIJAgVK+Oh2i8ae0LhFkZipO6EbTt+Er
         QXvzzICRgR2KWiINW8tS8hvgXthPKcjRNGRbwRO+0qNfMGaieCwXBNFNh/wV2+mOJ6ae
         1uB62DQ73ydnAnIqle0+BDSu4JEgD7L7y3ts4i5MVQlw4fXdi+/eTP8eN3IDhrAr6qxR
         3e0/7COhG6QDluljHa90v+ZjGbN6PyGP+AnyfUhTH/JN2XEj2IJEcZH0ORtgQBuV7eNl
         WtmQ==
X-Gm-Message-State: AOJu0YynMyg0nQHViq+QhQKeB2BE71gy+VMSrf682gUxSxpsvLweUSeB
	EY/SjpNpoPto93QZi9ZIIB8O3tBzu390wLbaHBBD8LYCKbZSzDB3xV0wiuItINHKsiM=
X-Gm-Gg: AR+sD12NE0zj8+1oX0yxSgG11llWQptIZJs61Kj4RW5IKBN6R4dm7I73CpCHuA+tZvE
	WJc0IWw5qtTJyBTnbZ7IwfN1sugnOpWxrXqF0s1FRJLngOzaAcDqkpN58oRYKB6w9N9/Bjm/55q
	4fiwWwEtbYc/5gM8XGjzvEiJV5QnUhrB6I8zg+7jX1Fzi/s96XlZ2ZyjxAJT24xyxofrZhKzsrd
	hr8ZLw230QYFWKhMNRV2qEHKFDaWpRuc/XToJpzKCAJz9/Ptr13blZWINhIJwL/RptaR4WRhes+
	ZxLj/hp/EnRXpTBERSTxBXXickaQiPcxcAX79s5pmHA6OkmqxPoGOt5GGLsEcQFP3gN2NvZvyGY
	VBnnZuTno3FPL7NKRVrtAMUsJrtCPS/BXGV3SCYc3+5qy5IS9lMcqtSyq4kYlMvnesJNpewQ=
X-Received: by 2002:a17:90b:5826:b0:38e:7268:220c with SMTP id 98e67ed59e1d1-38f2966033emr8517144a91.32.1785169204964;
        Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64150874sm75066a91.16.2026.07.27.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	witu@nvidia.com,
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
	yoong.siang.song@intel.com,
	martin.lau@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	leon@kernel.org,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Subject: [PATCH net 5/6] xsk: move xsk_tx_metadata_request() to xdp_sock_drv.h
Date: Mon, 27 Jul 2026 09:19:58 -0700
Message-ID: <20260727161959.885642-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727161959.885642-1-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xsk_tx_metadata_request() must validate metadata with
xsk_buff_valid_tx_metadata(), which is defined in xdp_sock_drv.h. Move the
helper there before adding that dependency. All callers already include
the destination header, so this has no functional effect.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/xdp_sock.h     | 43 --------------------------------------
 include/net/xdp_sock_drv.h | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 2b2eb9b9d580..6e70b320b399 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -153,43 +153,6 @@ static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 	compl->tx_timestamp = &meta->completion.tx_timestamp;
 }
 
-/**
- *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
- *  and call appropriate xsk_tx_metadata_ops operation.
- *  @pmeta: pointer to pointer to AF_XDP metadata area
- *  @ops: pointer to struct xsk_tx_metadata_ops
- *  @priv: pointer to driver-private aread
- *
- *  This function should be called by the networking device when
- *  it prepares AF_XDP egress packet.
- */
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
-{
-	const struct xsk_tx_metadata *meta = *pmeta;
-
-	if (!meta)
-		return;
-
-	if (ops->tmo_request_launch_time)
-		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-			ops->tmo_request_launch_time(meta->request.launch_time,
-						     priv);
-
-	if (ops->tmo_request_timestamp)
-		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
-			ops->tmo_request_timestamp(priv);
-
-	if (ops->tmo_request_checksum)
-		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
-			ops->tmo_request_checksum(meta->request.csum_start,
-						  meta->request.csum_offset, priv);
-
-	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
-		*pmeta = NULL;
-}
-
 /**
  *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at completion
  *  and call appropriate xsk_tx_metadata_ops operation.
@@ -239,12 +202,6 @@ static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 {
 }
 
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
-{
-}
-
 static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
 					    const struct xsk_tx_metadata_ops *ops,
 					    void *priv)
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 68a787601357..f87c4215673e 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -271,6 +271,43 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
 }
 
+/**
+ *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
+ *  and call appropriate xsk_tx_metadata_ops operation.
+ *  @pmeta: pointer to pointer to AF_XDP metadata area
+ *  @ops: pointer to struct xsk_tx_metadata_ops
+ *  @priv: pointer to driver-private aread
+ *
+ *  This function should be called by the networking device when
+ *  it prepares AF_XDP egress packet.
+ */
+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
+					   const struct xsk_tx_metadata_ops *ops,
+					   void *priv)
+{
+	const struct xsk_tx_metadata *meta = *pmeta;
+
+	if (!meta)
+		return;
+
+	if (ops->tmo_request_launch_time)
+		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+			ops->tmo_request_launch_time(meta->request.launch_time,
+						     priv);
+
+	if (ops->tmo_request_timestamp)
+		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
+			ops->tmo_request_timestamp(priv);
+
+	if (ops->tmo_request_checksum)
+		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
+			ops->tmo_request_checksum(meta->request.csum_start,
+						  meta->request.csum_offset, priv);
+
+	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+		*pmeta = NULL;
+}
+
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
@@ -483,6 +520,12 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 	return false;
 }
 
+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
+					   const struct xsk_tx_metadata_ops *ops,
+					   void *priv)
+{
+}
+
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
-- 
2.53.0-Meta

