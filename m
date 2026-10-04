Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52F3ACA4A
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134187; cv=none; b=Wh6jO3XKdLgxwRd2rkHcqJ18ZhGW/7Z55AxGwDrBZHz6qN+uw1Xsy6Ju7n7ymcetlzbNUQwCDwRlHB/di9KK2bbOHv7p6Nu3Yv0eodSHKqPWvpHKsP6vKaVk3oDPXXEP4L9rHLp7Dmw3n8VlWrUEzTFi9jveq+n1ld5/ugeC4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134187; c=relaxed/simple;
	bh=dj3NwmJPrPWb/bw6YKz6XnTWInhGE7dX0FcP3wklm9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCxWptfC/UHeOH9RWXWbIJ7t8HbPxibHKkifViVwv4KV3dzjb413NggpruPOW0BJkN4+3d6/zcn+UdO7mbBZmu038s1yTLckOnCMbWKwGZUXxUHU7eUiVV9LXU0X8VWE9E4Eb3n/w8njgXp6Fl+PHefJENB7xfUb6Y9+eADFXzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=Mm2sSM17; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="Mm2sSM17"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2e4a2f00beso184612066b.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134181; x=1791738981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQy1p6uH5D5EZA+BdR7YHzdsKEg9LefUPPRF/B7n4zU=;
        b=Mm2sSM17vVAzKT20oK0g+uDXswxBLImaEhGqc5eS2W6BQ0fQLZQkSY4HBP/KXxCE7t
         K327YbYlwP6WbZqWvZBDImm0ULDv9OxztUnJslzzlNrRdaTprV0/CHOonmKFaVQZf+ta
         7P3LXOTL30Py3LJhv0yMWRrmb2cvMgmYnar2XvOq95pg1wpyB4or1iiKjzo0m0l5n8SY
         eWdcrTny2rKauowywnxX8IOi510RUd+ZXGUEsDFfkrroIsk2aRFDx9FKW+ovwRXCNHoq
         XI4nQoCDvZQis7rPLfOPDH7lwjHVEc4T7ciNN2R8kQh2lnJU7ljA9CqcOBuabHZMAHaQ
         jF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134181; x=1791738981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQy1p6uH5D5EZA+BdR7YHzdsKEg9LefUPPRF/B7n4zU=;
        b=opOC8Xhn/flu7PXrShsKbaf/5ubayFXpVpQ68oB62KyFweBp00Big8TuLEMC7Yt9Cn
         QhHChs08s78+D/fOI/NYlyozBnTkMndS82Yvy2FktJitecSh5cD3cjZkmGGRAu3i6Eo2
         Q2QcJKttrIn2NXCH4Vyo7OlMtdr484UIYNsCCDqYXXsn5QNBtIynjWq5UMS/k8NyrJmz
         qJIbLhHInGRXpd4/MFuOmatVDcfOCboORJWRs7TW2gmdwHXGxQkNFkHZkyHyq1T+hbN9
         4UNv5Hojd07BXXB0ru7kaNXllwpi7SG9KRBO7GKadzLl/b6309gSJN/sRyBgD0NoDm9f
         AlNA==
X-Forwarded-Encrypted: i=1; AKwUvByOyVgXx+C1yP2KuzpNUMz1wbkKofJPhPw75LS0bbtHAEUclVTAdm293wBT/dXeyGGtAk8POCs=@vger.kernel.org
X-Gm-Message-State: AFuF++mnVTocGla/UZJ3NiggUhTDcqKx8cPGjMmuhnlE26og+e3h/nFR
	GhrAIR0zFEnyzYDZmI118iI2fqS16/nzBNHceWoRXUUiu0uD3NYEgzbW6/OecHM1GA==
X-Gm-Gg: AYBFou1qHDMhM0leCaalgs7b7CutLQWUpUZ4Tq49DHp0eMETSNhlnUFKXokVIWNROCS
	vp3vElz489j+OJ/akBnrBsST2MVMrCsCHEAKFySXTd/ANHJYLxY99BFxHJei6PjguuTW9I9OsFE
	CHN+5fY1OnTFaVt5REQbdY/TRTHttVRlYmPOG1CCfUzNwQjtPTtlH70tJL9ULTzgevUM8mNxzOq
	xTAP4m/WuGfYqpcZB12WHQxQLPnXU52aN50I+bX2OjNuoPxTF23+iJhHuUEXrWJM76ggFfDcbiR
	FDtz/6XWBczTHLmJGyYJAy4yMOBYthBN9WtG5XrMdpRW6kRavlPAfUr/6HZP68En5pYCdNxFwFN
	FEkCaSWEHFJ2pswpgwoZOSDFQc+eefuk9TIgn0QDqE7Vp/UKktnR/qsE4kWxv3kqOpv2xLS3EXj
	AHO27Q03JAitN1berCt/rjTmdt3rPaSdNw+o9W3lUmKKA/bC+GRdQdP089Srx1prqGm8aUk3tNx
	3NnDOGNHuCMOpmvfyqtih6C23YSRJdQLeZuVf/WBNxfJ7tEQWqu+R45DWlLqCxhE/6gpJlctuei
	d6NRFwESUnilKdTVZ/8bI16N7xhjPgPjUpDucLNhv+k575Gzg4X6fGGXil7yJGUO98Uq8PvVITq
	dpqre6mqTbqvQf0YOHQL3HTQShDXnOKY1z1RuiDkmD88tkr4GjKztEzrOlCkgSmypG+nbffovMB
	ci1w74pCu9izkSDlDyfe3DLKdU
X-Received: by 2002:a17:907:7281:b0:c2d:c6e7:9e9f with SMTP id a640c23a62f3a-c2e4ad3fe21mr707178466b.27.1791134181453;
        Sun, 04 Oct 2026 10:16:21 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd278cesm314885266b.37.2026.10.04.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:21 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@nbd.name
Subject: [PATCH nf-next 1/3] 8021q: add vlan_dev_sw_netstats_rx_add() and vlan_dev_sw_netstats_tx_add()
Date: Sun,  4 Oct 2026 19:16:14 +0200
Message-ID: <20261004171616.3544880-2-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004171616.3544880-1-julius@bairaktaris.de>
References: <20261004171616.3544880-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let code that forwards packets on behalf of a VLAN device update its
per-cpu counters, like dev_sw_netstats_rx_add() and
dev_sw_netstats_tx_add() do for devices with tstats. The netfilter
flowtable fast path uses them in the next patch.

Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 include/linux/if_vlan.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 20cc16ea4e5a..4873a12958da 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -231,6 +231,31 @@ vlan_dev_get_egress_qos_mask(struct net_device *dev, u32 skprio)
 	return vlan_qos;
 }
 
+static inline void vlan_dev_sw_netstats_rx_add(struct net_device *dev,
+					       unsigned int len)
+{
+	struct vlan_pcpu_stats *stats;
+
+	stats = this_cpu_ptr(vlan_dev_priv(dev)->vlan_pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	u64_stats_inc(&stats->rx_packets);
+	u64_stats_add(&stats->rx_bytes, len);
+	u64_stats_update_end(&stats->syncp);
+}
+
+static inline void vlan_dev_sw_netstats_tx_add(struct net_device *dev,
+					       unsigned int packets,
+					       unsigned int len)
+{
+	struct vlan_pcpu_stats *stats;
+
+	stats = this_cpu_ptr(vlan_dev_priv(dev)->vlan_pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+	u64_stats_add(&stats->tx_packets, packets);
+	u64_stats_add(&stats->tx_bytes, len);
+	u64_stats_update_end(&stats->syncp);
+}
+
 extern bool vlan_do_receive(struct sk_buff **skb);
 
 extern int vlan_vid_add(struct net_device *dev, __be16 proto, u16 vid);
@@ -249,6 +274,17 @@ static inline bool is_vlan_dev(const struct net_device *dev)
 	return false;
 }
 
+static inline void vlan_dev_sw_netstats_rx_add(struct net_device *dev,
+					       unsigned int len)
+{
+}
+
+static inline void vlan_dev_sw_netstats_tx_add(struct net_device *dev,
+					       unsigned int packets,
+					       unsigned int len)
+{
+}
+
 static inline struct net_device *
 __vlan_find_dev_deep_rcu(struct net_device *real_dev,
 		     __be16 vlan_proto, u16 vlan_id)
-- 
2.53.0

