Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA056378D92
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281563; cv=none; b=MfpT4jOUuNBMo6ZGenVNc/1sf6XtQoqORq04IHgi6igm3lskuulvuE4C8/DLLgFnMo0BlgwhA8I83YwyozfgzABPBfS0BA6imj0CYdddbdygRERgvQX3Z6kR6M/zM6YHrJViWLzG0gjLRP33EfPyuCAOZTWbsAF10L4EJqy/gFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281563; c=relaxed/simple;
	bh=uRYPAtAtLif7i10854CTEewWmJAf/TWjXqRBv41TdEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tv6keqN5ibzCPkEXbog05lVPaRULBc9Q2RWHRQTXxPZtgrupCVisuMZiWeJ0Jyvab75P/d61RKhGbvj6ABgeDtAlC7Hy4s9d5GH27f1IM8RPQU/TLaeqLkpBmw6Nkjkx2Qsb42bHzhZMm6bWxE+7QcWtGU4MwbPwxzw5myideJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI4oiPFE; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI4oiPFE"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-98514b4115eso137847241.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790281556; x=1790886356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iv7JMCOOiStR26xduJ20yGu4jGk3+F31OuSygzoMJug=;
        b=XI4oiPFEvODXpDmkNwakyL26cPhBZO0fAkDbzIYLDNg6xgLvTAkKVqFwgam4Ojh4Zj
         1GsuEzJTH641jtPyku/gQLRYwtmylTydyUEgM6R0XYjqO6LGZEQI8LQ6hN6nxkyZXhGa
         7d1Q2uGNumuVABxni+c/deDXTBa1yO+AD0L0ULPNlplrPe2cglZXELUCSDIyrI2aWov5
         ZX4pL92GWVccxd6S1hNDBIqNpDDlruf1vOlgZCSbcJdlmfUE7ZquB+Trl1/bo7HO6XIU
         UWlwBKvq/NhavnzSHYDMqsVk5wnicTTlA+E9Is4YjVr0z4S5eJI7duLF57KyhTtzy2Ec
         1sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281556; x=1790886356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iv7JMCOOiStR26xduJ20yGu4jGk3+F31OuSygzoMJug=;
        b=IMPGP+YNFydCEyz0RH1+GJoDOJNMllRFrPDl11GIxQH0mTDS6BDnFLpE/vfA14s3aY
         WehQZBNeW47F+NgiaDYUK8buUw58cbFpGTy4z4DOiUbViyGxCINxxYlENBLpafl2YrBT
         ZhcYNei/BwENsDeMTNAsrdvZNCppoHSgG/sA1tpPQsmHDPWMfheaQ6RaH+iZU+gp4ZBQ
         tMFLkW/B3bQSDPWPfJsYdjYXXx9FALYsXLLumHlAimKc4oTxRBy1dF9+wQ64+KCMmB2y
         paueEr+gAed2fqfApXtm1vHCDTfMuLh+i9EK1rFV3RFWa4U3AeNM11VqNEfUOh+ux5ss
         fxJw==
X-Forwarded-Encrypted: i=1; AKwUvBxAjJ1ERaPc4rqa3L/zO+TRa8Fh5FVgg/DcDQzsSzkvXfTmptBXd9x/TR6hWSY8FVO4HQrdSIY=@vger.kernel.org
X-Gm-Message-State: AFuF++ky8KXRr9fsRgkd8QzUWWL5V8VTcnKICxz7mHN3lGedYh2vlcoL
	rVXeg6JOhY4918ttIVtdYnV9wgQfh1M6wboKnE0WG0MFYGUKUGbOOO6q
X-Gm-Gg: AYBFou1lFzRehdL+VY4fDrSsPrteCgOdhyHUCnv1nNFco8Qwi3Qo9UtYRZoZCTE70bg
	ylE6vbgYfmMyxOyyUKI7eWvhviaPOnOjZrl3+EGCIExM3xdoCX0X1DTJCFhyu2RusfZ6Qk5gZcZ
	XafA7HFLZNdfi+whyAe1/8fMFJu+mNhNbZwXkB3W9bwgyJkIVISTF3smWonNyS/nHZiXJPIiCZ9
	077QOsNm5DCp2r0Rz2E7NBCRd/JH2zsIe4D/sTGBXXc3UkYAQytkx/eJ4aThsNmWb8sFS7qFzWJ
	WbHkcToElMgwb7LhYfu6j9fjwsNEpjMm2SC3X8/+f/fMQeiKz3WA5g+355eQAc0BVUVauJYu716
	lBe2o4mnRUk4WkDY/PrQG0e7UMkrfpQtqHH0Kn3vcyb/ZH6n5VS7thggqq9QNC/kPPYZ7mGc+o5
	emXx+56qT+BcCghbHEzvRNMc+ycWlbOkg+UG2565Zjq+mRJutamP5FwynBn2onZhk0l1bi9cm2H
	MvvCg7nOaqI
X-Received: by 2002:a05:6102:c53:b0:7a1:f7c3:3a45 with SMTP id ada2fe7eead31-7af1d6c4296mr1934116137.18.1790281556440;
        Thu, 24 Sep 2026 13:25:56 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3dd5:d810:440b:4079:aa61:d217])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b0db1d1152sm782102137.6.2026.09.24.13.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:25:55 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH net-next] netfilter: nf_flow_table_bpf: populate VLAN encap in XDP flowtable lookup
Date: Thu, 24 Sep 2026 17:25:43 -0300
Message-ID: <20260924202543.1090535-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

encap[] is part of the flow_offload_tuple rhashtable key
(flow_offload_hash() hashes up to __hash), so a lookup has to fill it like
the skb path does.  bpf_xdp_flow_lookup() builds its key from struct
bpf_fib_lookup only, which has no encap fields, so it leaves encap[]
zeroed and can never match a flow whose tuple carries a VLAN encap.

Fill encap[0] from an in-band 802.1Q tag, mirroring the ETH_P_8021Q case
of nf_flow_tuple_encap().

Link: https://github.com/xdp-project/xdp-tools/issues/488
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/netfilter/nf_flow_table_bpf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
index cbd5b97a6329..479f8242da2b 100644
--- a/net/netfilter/nf_flow_table_bpf.c
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/if_vlan.h>
 #include <net/netfilter/nf_flow_table.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
@@ -60,6 +61,8 @@ bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple,
 		    struct bpf_flowtable_opts *opts, u32 opts_len)
 {
 	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	const struct ethhdr *eth = xdp->data;
+	const struct vlan_hdr *vh;
 	struct flow_offload_tuple tuple = {
 		.iifidx = fib_tuple->ifindex,
 		.l3proto = fib_tuple->family,
@@ -91,6 +94,18 @@ bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple,
 		return NULL;
 	}
 
+	/* encap[] is part of the lookup key, fill it from the 802.1Q tag. */
+	if (eth + 1 <= (const struct ethhdr *)xdp->data_end &&
+	    eth->h_proto == htons(ETH_P_8021Q)) {
+		vh = (const struct vlan_hdr *)(eth + 1);
+		if (unlikely(vh + 1 > (const struct vlan_hdr *)xdp->data_end)) {
+			opts->error = -EINVAL;
+			return NULL;
+		}
+		tuple.encap[0].id = ntohs(vh->h_vlan_TCI);
+		tuple.encap[0].proto = htons(ETH_P_8021Q);
+	}
+
 	tuplehash = bpf_xdp_flow_tuple_lookup(xdp->rxq->dev, &tuple, proto);
 	if (IS_ERR(tuplehash)) {
 		opts->error = PTR_ERR(tuplehash);
-- 
2.51.0

