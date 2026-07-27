Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA24248C4
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169209; cv=none; b=QOmsOPjqZbh4Pm9XPXYbK0cJ+nETqRQy61FAjsxVHKZrYNMv3vgnbY0Oqmma0DUM15ccAzmNAN7RHlqq3AK5faQWMt+gfZD1nfmGLxFQUnvfl+VBQBaw6ms9441qpTNZ+u2TMs2Y1H6TW8S6SmsRSotIOgVbBkqYTcPlAUaMj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169209; c=relaxed/simple;
	bh=Snj7tN3213DSDgwseAsqfrgtXI8K9m2udF1tBcekBKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3OBiJxB59Cboqndbxp1mHmdd8+NN4WDhetniuw9OwV1y57Mxs0o0CM/2HqYr5amf8XJUoVhWB7S1fcmfEDC9mgNRrEDUXNGTrBeAgAMp/WXOS2tM0Z/evsCiNNLq3akq77EUYoE+CrCFKE7qgxd7ImxvuLag5UJWm4L1USsxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wrmld9bO; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrmld9bO"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fcd903839so1305104a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169206; x=1785774006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7nQzsLqBl8zE6x57DDhN2FKu5g/8XVApDzbXi1A1P1w=;
        b=Wrmld9bOqb/skXnRPDLnCrPNXNvfcpDfOH/t/dU4wZeOD61Fm+jcFdPy5LI/5fquSi
         WYvvPgbIToSusGVKcyi3BuI2ToYhfm9JllZ0ndOekfVmxi8/JO1oXDaCC1s/l7YU8YlZ
         TGHAi5lEBbMwm9kOKI/8cQUS0JQDD7PEiFRukxlVNZ0TpIR6+rOqOuxMGcWlKwYkhOnc
         kAX97M5t/pcTRnOrfHkl2NNU02hf6AESigf68zuRoYj6MJIkAhTUhsSii2bprlPMu1oU
         teKKgKyhYWLnE50CskadE5wSm6a35+gtrNhHpOTSIRA4L0d4dPN+9SkcuywuDvCFvKll
         cjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169206; x=1785774006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7nQzsLqBl8zE6x57DDhN2FKu5g/8XVApDzbXi1A1P1w=;
        b=n1gozQNEg/mgANhjpSQFUlN3IkGwtU/8pSoEJLVapR5gsyPSOltz+lrxWFd77sznQ3
         wKrDUI6+lzW5eqHOCCyCLXGzB2gUl6gCZ2VIQGe9o1uiqnuBNUNc6JOL09HVTK2f3Bne
         V/AL7mK1kwuCXnMkI4+jv07rMzO0hdtfAnAuhfWrkfPADWC388lx0zgAu75Pe9/tDcgY
         u2pynjiaVj3G1UPUrlD+4fpwyoyrvwRSPc0MIvo0YsQcgB02Z7YYCa3Jzdrz85TU5ZaU
         yn7RMnMYmx2le4FMPJOU0fA93fMV4njAVTQ3fycmpGTE4o7cv/ZzGZOAOOIC24ByAT+m
         ECvQ==
X-Gm-Message-State: AOJu0YxUm2gLKe71uG26P4aMiVXQdTgaBsxQnAguQIdd2XHXq1Yvs4pD
	pdI+talzzw5L9IUc3SVvZiOuSHtlp6fSYGrE6A+KIhpXS2eEQhlOeu5DTwQjGS2bNEs=
X-Gm-Gg: AR+sD13iv1sDwFikgrGr/Uu9P0ZDipP1f12wF88dZFJlEeLI358rzCv6/2fNY6rZsNJ
	ke7ieZLo4zbJCELdOfL2MPlymOJdV0HdXYChR8HJ7YjL9GevMAw+C0iC/Nscxua7g37hMdGGxPM
	6y/uRoDqmB00VitgNU5yidnd3hjgFh6PDNKijJ7B6b/vCXpdP8Y3XtyQt6s0MRzpXTRSR7/5DpI
	utQgVzwKCqlk3cMqKC7zLhfVhA1H+Je6nWGi2b4uIcde/Wws32YcszAhTkIs1ahuCyPaBtLj1Co
	ReYtIcNid3aoEEtxn4U2y/oJ/qVFtnecIErtxswZGMV/HOCgDqxdhsH4A7GyDhsogK77RMh2n2w
	ALN+fTwj2UqU3RAtcb65mdNZb1dAfXtwTSUsjUYR/uST8H3JN3xEeNQeSoD1XOe12WolYu6Q=
X-Received: by 2002:a05:6a00:340b:b0:845:d286:1fa2 with SMTP id d2e1a72fcca58-84e5955e7c8mr7301859b3a.49.1785169206009;
        Mon, 27 Jul 2026 09:20:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532acee2sm3273714b3a.27.2026.07.27.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:20:05 -0700 (PDT)
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
Subject: [PATCH net 6/6] xsk: validate metadata when processing requests
Date: Mon, 27 Jul 2026 09:19:59 -0700
Message-ID: <20260727161959.885642-7-sdf@fomichev.me>
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

The zero-copy path validates TX metadata while obtaining the descriptor
context, then reads it again later when preparing the hardware request.
User space can change the metadata between those operations and bypass the
original validation.

Validate the metadata in xsk_tx_metadata_request() and use the resulting
flags snapshot for every feature check. Read request fields once so all
zero-copy drivers process only values observed after successful
validation.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  5 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +-
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 51 ++++++++++---------
 net/xdp/xsk_buff_pool.c                       |  6 +--
 6 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5a18d00deb4f..7b6cdc037c00 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3082,7 +3082,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 		meta_req.tx_buffer = bi;
 		meta_req.meta = meta;
 		meta_req.used_desc = 0;
-		xsk_tx_metadata_request(&meta, &igc_xsk_tx_metadata_ops,
+		xsk_tx_metadata_request(pool, &meta, &igc_xsk_tx_metadata_ops,
 					&meta_req);
 
 		/* xsk_tx_metadata_request() may have updated next_to_use */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index dac5e9d4c8bd..77ea51bfbaae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -505,7 +505,7 @@ mlx5e_xmit_xdp_frame_mpwqe(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptx
 		 */
 		mlx5e_xdp_mpwqe_session_start(sq);
 		if (meta)
-			xsk_tx_metadata_request(meta,
+			xsk_tx_metadata_request(sq->xsk_pool, meta,
 						&mlx5e_xsk_tx_metadata_ops,
 						&session->wqe->eth);
 	}
@@ -653,7 +653,8 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 	sq->pc += num_wqebbs;
 
 	if (meta)
-		xsk_tx_metadata_request(meta, &mlx5e_xsk_tx_metadata_ops, eseg);
+		xsk_tx_metadata_request(sq->xsk_pool, meta,
+					&mlx5e_xsk_tx_metadata_ops, eseg);
 
 	sq->doorbell_cseg = cseg;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f5111969c41..eb666b0bcdd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2747,8 +2747,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta_req.set_ic = &set_ic;
 		meta_req.tbs = tx_q->tbs;
 		meta_req.edesc = &tx_q->dma_entx[entry];
-		xsk_tx_metadata_request(&meta, &stmmac_xsk_tx_metadata_ops,
-					&meta_req);
+		xsk_tx_metadata_request(pool, &meta,
+					&stmmac_xsk_tx_metadata_ops, &meta_req);
 		if (set_ic) {
 			tx_q->tx_count_frames = 0;
 			stmmac_set_tx_ic(priv, tx_desc);
diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
index e2fa6bf6b1b3..5dcc0d7f65b7 100644
--- a/include/net/libeth/xsk.h
+++ b/include/net/libeth/xsk.h
@@ -205,7 +205,7 @@ __libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
 	BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
 	tmo = tmo == libeth_xsktmo ? &__libeth_xsktmo : tmo;
 
-	xsk_tx_metadata_request(&ctx.meta, tmo, &desc);
+	xsk_tx_metadata_request(sq->pool, &ctx.meta, tmo, &desc);
 
 	return desc;
 }
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index f87c4215673e..b344789f5df8 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -245,7 +245,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
  * details.
  *
  * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
- * pointer, if it is present and valid (initialized to %NULL otherwise).
+ * pointer, if it is present (initialized to %NULL otherwise).
  */
 static inline struct xdp_desc_ctx
 xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
@@ -274,54 +274,56 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 /**
  *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
  *  and call appropriate xsk_tx_metadata_ops operation.
+ *  @pool: pointer to AF_XDP buffer pool, used to validate the metadata
  *  @pmeta: pointer to pointer to AF_XDP metadata area
  *  @ops: pointer to struct xsk_tx_metadata_ops
- *  @priv: pointer to driver-private aread
+ *  @priv: pointer to driver-private area
  *
  *  This function should be called by the networking device when
  *  it prepares AF_XDP egress packet.
  */
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
+static inline void
+xsk_tx_metadata_request(const struct xsk_buff_pool *pool,
+			struct xsk_tx_metadata **pmeta,
+			const struct xsk_tx_metadata_ops *ops, void *priv)
 {
 	const struct xsk_tx_metadata *meta = *pmeta;
+	u64 flags;
 
 	if (!meta)
 		return;
 
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags))) {
+		*pmeta = NULL;
+		return; /* no way to signal the error to the user */
+	}
+
 	if (ops->tmo_request_launch_time)
-		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-			ops->tmo_request_launch_time(meta->request.launch_time,
-						     priv);
+		if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+			ops->tmo_request_launch_time(
+				READ_ONCE(meta->request.launch_time), priv);
 
 	if (ops->tmo_request_timestamp)
-		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
+		if (flags & XDP_TXMD_FLAGS_TIMESTAMP)
 			ops->tmo_request_timestamp(priv);
 
 	if (ops->tmo_request_checksum)
-		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
-			ops->tmo_request_checksum(meta->request.csum_start,
-						  meta->request.csum_offset, priv);
+		if (flags & XDP_TXMD_FLAGS_CHECKSUM)
+			ops->tmo_request_checksum(
+				READ_ONCE(meta->request.csum_start),
+				READ_ONCE(meta->request.csum_offset), priv);
 
-	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+	if (!(flags & XDP_TXMD_FLAGS_TIMESTAMP))
 		*pmeta = NULL;
 }
 
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
-	struct xsk_tx_metadata *meta;
-	u64 flags;
-
 	if (!pool->tx_metadata_len)
 		return NULL;
 
-	meta = data - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
-		return NULL; /* no way to signal the error to the user */
-
-	return meta;
+	return data - pool->tx_metadata_len;
 }
 
 static inline struct xsk_tx_metadata *
@@ -520,9 +522,10 @@ xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
 	return false;
 }
 
-static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
-					   const struct xsk_tx_metadata_ops *ops,
-					   void *priv)
+static inline void
+xsk_tx_metadata_request(const struct xsk_buff_pool *pool,
+			struct xsk_tx_metadata **pmeta,
+			const struct xsk_tx_metadata_ops *ops, void *priv)
 {
 }
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index a4089480b22b..78c14f106395 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -765,11 +765,11 @@ EXPORT_SYMBOL(xp_raw_get_dma);
  * @addr: desc address (from userspace)
  *
  * Helper for getting desc's DMA address and metadata pointer, if present.
- * Saves one call on hotpath, double calculation of the actual address,
- * and inline checks for metadata presence and sanity.
+ * Saves one call on hotpath and double calculation of the actual address.
+ * Metadata is validated later by xsk_tx_metadata_request().
  *
  * Return: new &xdp_desc_ctx struct containing desc's DMA address and metadata
- * pointer, if it is present and valid (initialized to %NULL otherwise).
+ * pointer, if it is present (initialized to %NULL otherwise).
  */
 struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 {
-- 
2.53.0-Meta

