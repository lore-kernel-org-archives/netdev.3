Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424334718DB
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134200; cv=none; b=dCBVTOXd4CQkmdTPtzmpaKjJcWr9HqIuBIVmBurvAC3YjCeJvDoVSqAtM5Vmy6d2I27YHkfvF4i0nRz5O5FTSyHT4aupiesGQrMw+sFULaLSwKKw/yoTKlPn/X0gwiS3g0kCStkU+ZG/wTMJLlAX6ul1HFWbqO9zsO04iCxYlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134200; c=relaxed/simple;
	bh=N2fEn5naZVynWAREy9aYIddLfbC9cTCqMP6evTuQQrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oABfMmdwBhCRZcR5mvaNOjmC2S+DBrPzhCw9eZUnkSvid/ZJUeAorhIMWgE66qd1xnVLrSlWcOHjhvgz48IwvTJRYz05r04IY2Sd1q6Ts4BaIpaRIgIUY6P3BFu3ePZAw6FSswhXgPt8YLriq38YfDk7sswkxFoLNJ7Q6qAx2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=gImvn9C/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="gImvn9C/"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2e69aa07c3so151618966b.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134191; x=1791738991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7pciMmt6xvkKxAILLtPxurNk5XIP3aiXY2Q8mmcn43k=;
        b=gImvn9C/gR68omXOgmOhHwB+3WO9azBAH1Vach+nKQaIJvVRbIYvjOarZ4WLaT7S6Y
         TzIVwG6JwBYrb3MV5N4pb8MQxzeLsJASfqKYwOlbmRHjnmoXsVIqFujn1pa7eKo7ZaAb
         m/fVlaQwrJT5hncJVqNrYVw1yc3gSpqdks04MW2Mp/RD80UABCaGODDtnzKxdrVe5dZ2
         iEVIoXDKWuH+8HPnkYIGuk9Jsf5mhWLoAmDvFySxvE5OocbHZ6xLboBMxPZpzFIwuuWP
         /kmUn4bPKsMsX+A3kVAUK/5+B9bYgdnfOwK5VIZaf1HzvBze2UJfi+RvhQDFQuC/E1NF
         toxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134191; x=1791738991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7pciMmt6xvkKxAILLtPxurNk5XIP3aiXY2Q8mmcn43k=;
        b=CZdZAeghPiFIHuX7L7aidxcLcLwDX06Dm7LKJekhBhxcnPpovu9Lv2Ux4EGhIhxzwJ
         hUOhnPRIpswzAs6f0cin5+vitxjrBJ8VgGrKDMU2ljxjBydi27XRzENxYj41yBP2RH18
         60n23jA1kDzipOe0nGpqNjCeVXRUG2g2/BgZyGRDSL4cXd39mqjoaEgfr6CzQ5sPY+Uo
         n9lWdr5EhykedxpuAjS+qw9l8bJ0sPn/nhQqjnL3TOcpVRIGSeFnjF/afInO3Us6e9qY
         Uq7lySdgJFZmUOr1uQ3VIxzr/xc0CST8Dmhn1NjV589feZnKjELEfmM4Yy2X4XO7bn/q
         RsjA==
X-Forwarded-Encrypted: i=1; AKwUvBwuTczhWB8GhSTPagRY/Z15HLFONg5KDie/i23XYDUXOVbc8GEIQuywNyoHzFXZaDyN9B6flhI=@vger.kernel.org
X-Gm-Message-State: AFuF++kLsH6fF6dl+nO07CONpTaZ8Myq8G0PUkMGzOlYGCmNFeT0brDt
	VzG2FUAHZ2pmpsaojHMa19SHP8W8702HV8B4gmt0nH/9lv2mCuFayDEhCP8s5dgb9A==
X-Gm-Gg: AYBFou3M5eY2He/WFCpQvbPPLaFbKe+FKPgfdeebe7jwaLZNwSA9dtyqQq4RB92pqPT
	Ypn7AzVTUXr5i95iflGDVYfBF0MLxO06ed3/OXVJp6pGT8u2Z0MolYTPdlSi+pdQSJJfzdeEGgE
	3WDbV9ssGEr56q93iFp+4deTXqgcoPSNIpQ08AlT5WPw4wJAS+vrRXRdUdeMGbLdMrM/swWKvNg
	cdRRSKlY4vGQ+9N1nUWuNoopeTSx8NRc7cwEKZtdUM6MS0/CKZxoN9wX6OtCBpkeNjoGnwAornV
	eqcOWLS4oN5gXXJQ89PNgFJmEWJEZBosbHqZaHaucOFIzhaHc58k/HBRHVVyQjFXC+/jDt99Bg7
	8+RmeP2eTlZILlW+h7kPBem4tdTLPSR0y1dW4kbAmqgcJcnqr1EsoYSi5tyEgxyOvx3M0TX2hrp
	klvrGu4m18ndcokLW2VQlZZFyQObMHaji6UWzSXrggCPNWcfvPQkGLpZ65puZiEoZqRMe7bxjPh
	JTAdDLqmeiF57xZ00UhkDaSSFnj7e/mNvVdv4U37f1HRfbucHer5pdGjkWhqE6cUFnpe/A5fSyN
	l5WMAKRm52zPCkiT400CGiGlakHjwx8wdnBaw2qiOeafMM9p0uyHGU/WHT34d2oaMvCssPbWG2Z
	SaZ6hxOpiDMm17c8JmZsn8GwEwSdNjYkRhtaaeYaw2wTv3VqdVGnDpFF67phvrES/NtlszG6Xcz
	Oe0bBWp/qEjYZp3A8lHM0pFCA=
X-Received: by 2002:a17:907:3f1f:b0:c2e:317e:d711 with SMTP id a640c23a62f3a-c2e6edf32b9mr428205766b.27.1791134191269;
        Sun, 04 Oct 2026 10:16:31 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf9ddbesm317345166b.69.2026.10.04.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:30 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v2 2/4] netfilter: flowtable: promote a flow offloaded in one direction only
Date: Sun,  4 Oct 2026 19:16:26 +0200
Message-ID: <20261004171628.3544978-3-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004171628.3544978-1-julius@bairaktaris.de>
References: <20261004171628.3544978-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch offloads TCP flows without a reply in the original
direction only. Keep the reply direction of such a flow on the classic
path until the connection is assured, then offload it too, as act_ct
does for UDP. The XDP flowtable lookup does not return that reply tuple
either.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 net/netfilter/nf_flow_table_bpf.c |  4 ++++
 net/netfilter/nf_flow_table_ip.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
index cbd5b97a6329..7070bc600db1 100644
--- a/net/netfilter/nf_flow_table_bpf.c
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -50,6 +50,10 @@ bpf_xdp_flow_tuple_lookup(struct net_device *dev,
 
 	nf_flow = container_of(tuplehash, struct flow_offload,
 			       tuplehash[tuplehash->tuple.dir]);
+	if (tuplehash->tuple.dir == FLOW_OFFLOAD_DIR_REPLY &&
+	    !test_bit(NF_FLOW_HW_BIDIRECTIONAL, &nf_flow->flags))
+		return ERR_PTR(-ENOENT);
+
 	flow_offload_refresh(nf_flow_table, nf_flow, false);
 
 	return tuplehash;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index c8c29a9a1684..289fe6c9e4f5 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -465,6 +465,26 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 	return flow_offload_lookup(flow_table, &tuple);
 }
 
+/* The reply direction of a flow offloaded in one direction only stays on the
+ * classic path so that conntrack sees it. Once the connection is assured, that
+ * direction is offloaded too.
+ */
+static bool nf_flow_reply_unoffloaded(struct nf_flowtable *flow_table,
+				      struct flow_offload *flow,
+				      enum flow_offload_tuple_dir dir)
+{
+	if (dir != FLOW_OFFLOAD_DIR_REPLY ||
+	    test_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags))
+		return false;
+
+	if (test_bit(IPS_ASSURED_BIT, &flow->ct->status)) {
+		set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
+		flow_offload_refresh(flow_table, flow, true);
+	}
+
+	return true;
+}
+
 static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 				   struct nf_flowtable *flow_table,
 				   struct flow_offload_tuple_rhash *tuplehash,
@@ -478,6 +498,9 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
+	if (nf_flow_reply_unoffloaded(flow_table, flow, dir))
+		return 0;
+
 	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
 	if (flow->tuplehash[!dir].tuple.tun_num)
 		mtu -= sizeof(*iph);
@@ -1074,6 +1097,9 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
+	if (nf_flow_reply_unoffloaded(flow_table, flow, dir))
+		return 0;
+
 	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
 	if (flow->tuplehash[!dir].tuple.tun_num)
 		mtu -= sizeof(*ip6h);
-- 
2.53.0

