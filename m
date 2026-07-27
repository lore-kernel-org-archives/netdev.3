Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A342254A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169206; cv=none; b=ghkz2c1IF9xjKceTElriAttuCD2jP21QxH5sUldFTgkRszCOTg2mlr2AO6NgcU24BA+4hYwj1XEG2EoD/qO3/tKhzGXLQ634O+GSD3gNLxIjVPIcRNjb61/BfNo7Y0/aAAcVidHD646FWD+OCC+bLl0UjD1MhbMD69ERUESbu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169206; c=relaxed/simple;
	bh=ZqQ9Uw/Y50YV8AtDkt+7adMr8+1jDB1scctEEKirKpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otixLJjlX3a3eh9csUgY1KUI5VWXBqHeywVUXyICZ9VTHrZUMpKS7h2PZAYf8DiSis48VXGKY58DGmppi7LSHV5vUBFhFnV8MHwTsGZuuq3kdES14G05OP2CLr0gu5jM34fDAUPAZhDMjLtoZQEUkIkJe7gz2X9ToO97tDtFhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzh/05Yz; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzh/05Yz"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf49dc298bso28700295ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169203; x=1785774003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XKcSH10NxhyObCdsXRn5dtH9ICKV5W4CaAB3/o++lY=;
        b=dzh/05YzIn6aW0D6RLWdhyTDq7o18x8RtJjzJV2JQII/BNK9Qk7ddEYWPAzyW3KSCf
         EF4dI3Jn8TRmnVD9AGa5EqWJjTXJCEBQ7Tpdv0TT1s2M5e4lQ31CCdgUWBnpdTZOTl1p
         MNkXMowDDcmwtBJ6S1HyDc76yuCI/bxvmAgobkKZmjtn7z9LnyfIFlWmsHviPKXEfTVe
         q5/37S6WSovJ6PLLNTRBgWGy7lvAnLgM7K61qwapf0ledd/Om0KeLZEw3fcCV2BXHtBj
         Nw++NhhudR569k6PtrOYuGsDrxfW+BusHyyuzJjauaweMFResx3RG6437Yt95ryzuMKL
         QEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169203; x=1785774003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1XKcSH10NxhyObCdsXRn5dtH9ICKV5W4CaAB3/o++lY=;
        b=k9k9FNrisoECGZWQ3+E/2RXb+WHv/M/R7i4sFWWsl+ef3iiOYTLIKBIBwkyrA7iQBx
         w14Qx3O0e7gvh6UIoPFbLYx/NPYlLya8NJkNN24Pfu+fxl4yW2fIe7+YeFn2aMe4lXCf
         JPE2vBHDNcqdENnS/z5Y8vvydewjAGbqK2fayEddP5qoTFmnYYYPk1+fQ0gKbj6/iZ0f
         Derux47YDacN2CrD2BIRZjOtT5KzgqXiNaHJsKmdzq+Q+jtTmQn2o1HxFWTP4NKWCM3H
         Uwu27LS/zpJwahM10oLMYO8bgXM8QLrcHnj1zIN3vZjUy8bfz39Avue87uGz8HMq2wD6
         AfPQ==
X-Gm-Message-State: AOJu0YyzIRAy3mlho2i7ZyPbravFRVWTC0Qv0ou5RzOrfbWhxVefyAmT
	xwX2iZhkVQwQPskBj5pRoc8N1A/rEdepz4NJ4x3+4XNvyPm66lpGRlKqurBxS36zD0w=
X-Gm-Gg: AR+sD1073EW0JtaoTi1NeS/4e7g2DOOvcobBD96ogYAELT4/lXcWGCPffEnNnOigeHA
	KHXfZq/NdsTaxzGAVzRLZaqjJ3qjklA0NfAlrsjVicJ5GtVHP135Dl3aaYTaHKsL1NTxt9QGP1n
	40jJSUoLz+MdKVDuizYGXkNvtihq4RxaJZETs/oUVly/AWXeE2ZMLZrM7DkaICb56sTqGl49LqT
	pdpwguteLUjDbAGhvSiBsTIj9deAhGbTPbl5dg8U2MWe6IHEY3Z8WTuFaKclLvKzhNJBBPs++ue
	JRprQUi6JZCFv7GFHtW27oT1KemTzEQszWWcHslCUUa9kQvE1u9Tj1uXBB9yN0QstpNsvX5s/M7
	dPDSOsQPjYqOfmZ0PK3u4XrfY87SBqggH9PIsHcb7d90Nld1GCQHLv8wKp+Rv/r8B8TYIBhfK3o
	LWyCLF
X-Received: by 2002:a17:903:3808:b0:2ce:9439:59a5 with SMTP id d9443c01a7336-2cfde878665mr86179875ad.36.1785169203061;
        Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d00599b631sm8906615ad.42.2026.07.27.09.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:20:02 -0700 (PDT)
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
Subject: [PATCH net 3/6] xsk: clear metadata pointer when no timestamp is requested
Date: Mon, 27 Jul 2026 09:19:56 -0700
Message-ID: <20260727161959.885642-4-sdf@fomichev.me>
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

User space can change metadata flags after request processing. Rereading
them during completion can therefore make the kernel write a timestamp
that was not requested when the packet was submitted.

Clear the metadata pointer during request processing unless timestamp
completion is requested. Completion handling can then use the pointer
itself instead of rereading the flags.

On the mlx5 multi-packet WQE path metadata is evaluated per batch:
xsk_tx_metadata_request() runs only for the descriptor that starts a
session, just like the checksum offload that is applied once through the
shared WQE. Only that descriptor's pointer is reset, so completion
handling can record a timestamp for the other descriptors of the session
regardless of their own XDP_TXMD_FLAGS_TIMESTAMP bit. The write stays
inside the metadata area; the single-WQE, other zero-copy, and generic
paths reset the pointer per descriptor and are unaffected.

Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to XDP Tx metadata")
Cc: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/xdp_sock.h | 14 ++++++++++----
 net/xdp/xsk.c          |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 06c081feff42..2b2eb9b9d580 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -141,13 +141,16 @@ INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
 static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 					    struct xsk_tx_metadata_compl *compl)
 {
+	compl->tx_timestamp = NULL;
+
 	if (!meta)
 		return;
 
-	if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
-		compl->tx_timestamp = &meta->completion.tx_timestamp;
-	else
-		compl->tx_timestamp = NULL;
+	/* we can only arrive here if the completion timestamp has been
+	 * requested via XDP_TXMD_FLAGS_TIMESTAMP, see xsk_tx_metadata_request
+	 */
+
+	compl->tx_timestamp = &meta->completion.tx_timestamp;
 }
 
 /**
@@ -182,6 +185,9 @@ static inline void xsk_tx_metadata_request(struct xsk_tx_metadata **pmeta,
 		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
 			ops->tmo_request_checksum(meta->request.csum_start,
 						  meta->request.csum_offset, priv);
+
+	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+		*pmeta = NULL;
 }
 
 /**
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f906d51b6699..fcc6f17f3576 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -998,6 +998,8 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
 		skb->skb_mstamp_ns = meta->request.launch_time;
+	if (!(meta->flags & XDP_TXMD_FLAGS_TIMESTAMP))
+		meta = NULL;
 	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 
 	return 0;
-- 
2.53.0-Meta

