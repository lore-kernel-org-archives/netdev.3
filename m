Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3841F5F0
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169206; cv=none; b=ty1yf/QC7NWRIuZdvfJbNXbXip/Xyzi6vSFFVgUQMUt2lN0ud5R4DIoYkj7Ijl6ge6ipVslE94OvRn1FnSrjXivKzeGiWtdZo3jn5w/VaebKFEV0OCG3O86+JchSUwXi3OrQUYiQrczWnY2GoHpN6JfHGJAbkgfqXikeayF9PdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169206; c=relaxed/simple;
	bh=wDCumMvFa5LaYCfj8t2zgXOxqEf3aJZwGrBxxlSH+hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERbAquPcV7idd3NrrmIIYJ+qVYhDVgiymd6cz4hc43R7UKDSRb5sElwAFzIVb8qyeuVN5+PIRDlUbt5N0rqHHdMFO4Q3NEy3Eqt/h2Hch2ajk5TsHaTMMr2e83d4EqMZ1iMolRb34apw0rO03APXfy/V32fl19Szz5g1/QnjqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxh9Hjqo; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxh9Hjqo"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so19436275ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169204; x=1785774004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4h2lDbuS6wgFYWmNXWGo5hdv7x4F0DvuiMCZt9z600A=;
        b=dxh9HjqoFt0+/UcyZEVRJo+v4f1uwSf6TR2CxbDB7v26hKRn4mLJ2uJ6jTilN0e41o
         cr76sYoJJ3HHd3jeIXGTtWh7ea/2G9DNEDfWlkGjMBavIdLW2+QVidQInWfsxhiTUU3P
         ICnycFqsdS8XGdQop6UQszLvUcScILEwKjxemk8WrtPCMUmnZvtsbm3o0IFdzbuwTvQh
         AqCd0gNyZ9T6AOiLjAhb7EIJF4hlKCmxNv1BI/oCq6VxcjIjPWgknSFdxeBTo0LjcHsz
         jb7sQrTAPIRSU4jvlAOSNWCMc5htXt0Tfy5wc667dbT9eGXhiU7CTvFiyf8bZJRQf3ne
         G0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169204; x=1785774004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4h2lDbuS6wgFYWmNXWGo5hdv7x4F0DvuiMCZt9z600A=;
        b=jLRqD2A5bOIoo2AjRzJasGmcdXikO9yDMLS4eobtBFeHyA8MHEYVOdd5RWkkGyUo7J
         W2BcWj7p/h5psfPCFkm29koBXWfsvKbbkAwo3ShfSPRMZ2tAEqqH1/uEx5EoEfsLDom5
         P++hKpIYoxsXdefm454gi4OF7kOCvSy66UroROon3GiTO7bpJtwv2lOsENFTAKm+SG1B
         e/Jrg82njML/JG3ea3poUocaPTzcoBPeNSFMOkontJ0Tt5OKDoSJuQeLtpZfXlP+eT1f
         vm++/0MXrnvhwlzTA7k+BeYGvREt4dr8EqvQM1QgVdUnstf4cO2Mz3aXAzysOoA/NaBI
         N14w==
X-Gm-Message-State: AOJu0Yz6OVkhXnavlhAL0LSpV55Wr+MUqTyctwfqY5u/TjzKY+WHd4Zt
	e6XYt+Qah824ZvQuoytS3CYli+aP9O3G0FZIAz3FDl2xPONJKJ5SGFtSzNm6zHVamoM=
X-Gm-Gg: AR+sD11aZr8ZFXNyNSqhToKBHxte+DI+AOCTmWBR6Ho9hzhhY22u4Lu2kGojATUFjpP
	jKcAA83+CRyALtgRiPottvMe7LSrAcvgMT6SCtglcY9TjE028sCK4G+CgfTkR56Ax8cPUWWR531
	yeUGPoQEtIyPD7SMqPAZm7se8yyOBDGuIDkvDpOoByQl51icL8RY7jSUtqK2u8wyuGyDn0OkMge
	+92n4kvlg+GrszUAoOW8xqT5UIvtQXld5V+5Wg63MCFKzT07/mVxst0xyD52+KxERX9LGQki97d
	67aLYQQ+pUwLndkbvxU7zNqJLRTJVYMWetmMF8sLMhteu0riBXSJZJYzWKFPkyxjO8PTGAuhsgY
	2oGM4ApqIQHji1+T3ZmlIiVLk/Qzmfl8SuZEOj/UWdeAUf2q4sGZRaa4H4jDngwWV+bxl3EKY3R
	5+5aOi
X-Received: by 2002:a17:903:3b88:b0:2ce:ceef:661b with SMTP id d9443c01a7336-2cfde8473c9mr75552645ad.29.1785169204004;
        Mon, 27 Jul 2026 09:20:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59b8cbsm37712705ad.11.2026.07.27.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
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
Subject: [PATCH net 4/6] xsk: validate launch-time metadata size
Date: Mon, 27 Jul 2026 09:19:57 -0700
Message-ID: <20260727161959.885642-5-sdf@fomichev.me>
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

Launch-time metadata extends beyond the first 16 bytes of struct
xsk_tx_metadata. Reject the request when the registered metadata area does
not contain the complete field.

Snapshot the validated flags for the generic transmit path and use that
snapshot for request and completion processing, avoiding inconsistent
decisions if user space changes the flags concurrently.

Note that only xsk_skb_metadata is properly using the flags,
__xsk_buff_get_metadata ignores them. Next commits address that.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/xdp_sock_drv.h | 17 +++++++++++++----
 net/xdp/xsk.c              | 11 ++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 46797645a0c2..68a787601357 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -260,21 +260,28 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	0)
 
 static inline bool
-xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
+xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+			   const struct xsk_tx_metadata *meta, u64 *flags)
 {
-	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
+	*flags = READ_ONCE(meta->flags);
+	if (*flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		if (pool->tx_metadata_len <
+		    offsetofend(struct xsk_tx_metadata, request.launch_time))
+			return false;
+	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
 }
 
 static inline struct xsk_tx_metadata *
 __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
 {
 	struct xsk_tx_metadata *meta;
+	u64 flags;
 
 	if (!pool->tx_metadata_len)
 		return NULL;
 
 	meta = data - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
 		return NULL; /* no way to signal the error to the user */
 
 	return meta;
@@ -469,7 +476,9 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
 	return (struct xdp_desc_ctx){ };
 }
 
-static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+static inline bool
+xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
+			   const struct xsk_tx_metadata *meta, u64 *flags)
 {
 	return false;
 }
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index fcc6f17f3576..7855ee09c4b6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -967,15 +967,16 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 {
 	struct xsk_tx_metadata *meta = NULL;
 	u16 csum_start, csum_offset;
+	u64 flags;
 
 	if (unlikely(pool->tx_metadata_len == 0))
 		return -EINVAL;
 
 	meta = buffer - pool->tx_metadata_len;
-	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
 		return -EINVAL;
 
-	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
+	if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
 		csum_start = READ_ONCE(meta->request.csum_start);
 		csum_offset = READ_ONCE(meta->request.csum_offset);
 
@@ -996,9 +997,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		}
 	}
 
-	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-		skb->skb_mstamp_ns = meta->request.launch_time;
-	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		skb->skb_mstamp_ns = READ_ONCE(meta->request.launch_time);
+	if (!(flags & XDP_TXMD_FLAGS_TIMESTAMP))
 		meta = NULL;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 
-- 
2.53.0-Meta

