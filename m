Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74534AA1CD
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149086; cv=none; b=MpMJlGTl2Fo0ja401VZKjZrs8c/r5XwB8RiffnDprMScO0DojXfV3jCBhe7uefbAadflIb9LutuiVKLDNgMkbZndffXIL0X1eBRk/rhp/mpMYj3ntsDXp+6TDyfA7taiOsKoiN3SCFIXOt4cSISlA8un/7UKgn0QP1HUDJgaBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149086; c=relaxed/simple;
	bh=yd3SvQ1usHAP4aqbb+hfLrE84zju6x7zQRRGsOcQdx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1jipzTXZw49oKBXYefztorYcXX8gWty57qchRFzs0LnA3epLn/RGQ8kBq1PWalwvzAE2zYnDvpUT5KARMRzoSoB9vlcixgyLVC4UUC9gDBKi7GibLYLWhllAEwDXJ3Y9p41sLjKFCcBcvxX5M8Bie8YKCqvFsQmgIDVngnShPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnn81NSO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnn81NSO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7951095e9.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149082; x=1791753882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrVnCdYeysPlKE3eqVZUbon5985jaaujr6rHDKXwGGE=;
        b=gnn81NSO44KA+Bsj2W3hrpsvLdEcNIvYZuJqaKGUWMv8C9fEgzbs2OC6ZyW1lzYf6W
         xIeBtSNvjILDN4Da1xWgZF7wn+dtpwMcOLbuXwKHCsOBS2KZLHae2ypuuccZ8eVEnNZE
         OS7JXf9IDnDn4xKwSsNp1blcESgGtLmANzcd1sZWl9HghPfZdjNTUEfyI7D06EAG7uHZ
         RSgiQpu2/HrcjVs3mxFonMvfnwHO/NBYBUEfT7LVl5HM+IE8iwezwYZ4bKldz62OXKsv
         n1V7NlkwHms0jRVy1zgEYNX4Uyv3BsnNFOFaDP34dJmAYibKXlrprePPncAPcsLG0o6g
         8u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149082; x=1791753882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrVnCdYeysPlKE3eqVZUbon5985jaaujr6rHDKXwGGE=;
        b=dEjuYwZSHiCxiCuL6QEqhYX5tTuPnFY9eui3e9qzBtEdpqmBxQ1x0MBZ1ZIrTf2HUp
         3rBKhHXxjdWgo0ncFpHagF26ndvzC3BbrOMnEvkHW9Iyk0GS6/HNfZBT3v6yQiF1wP3z
         okAPHaAn3Q4rRQUTvOMq+YViVjMGe5sgirEEOSUi7XDGFsbj3Z1IgjcACrxIriCf0Evv
         6Ua9xSqc02iigq3ibw2jslEBXUsoYWZq302XNdVdDAb5UdBlmLduN3YA4M60XjagLsqj
         UIqI2NEc7gculehlJyWIF8G8cFFcqD0nQQA8WKX31XvGLoj+64acPJE8+loWZP1qMrX1
         SsHA==
X-Forwarded-Encrypted: i=1; AKwUvBxz0uFPy3DUbylthqDVOqnWrOSA6xdQjIZvJOqwSI6JghvY9xkJvSEcujU9crq2OhO+KNZoG2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++m1tVceXLBZqZeCUWbKs9ZKMtwCkCUvvBfpEJgkwK3Ue8thGFeN
	09+836FKDc7GTyvA+4qJPij8KZ9qTegpCohj2zKrg0Zi0keWirz7kccH
X-Gm-Gg: AYBFou1fUP8ijtBzyrr9LxgzQsgYuTaLkzsp7UlpuFPGtGyZUvduBDCrfc7berTGpTG
	WQcmXDpptUC4CsmPCnpUNKxO/uquGxJHpjiMRhHHd/PWLdpIGex0U/zIFjewjDE0Rh9ai9E+TBr
	WNInfl3XzJanh+Ta+qOJi2JbCie1LfUJyXMuKvYrnOx074s0PXE1oRGOOOrOXfUQiVpTbaYPoQ8
	PnGO8n7hUOSHp+EIJZgPe7VCnRLV1HRjlk2eWS4MlbbEXvOgMl9q2BDFR1HMGnMccPdgbPfiySq
	wYXevAOZNzVpBYGow6Tp6kyHePI3Q5P1inCgkDXOCvXXLBbEmjDrgLIuc3CGOPkaKAjKviAcmmg
	D/WBLsY0/B66WpgxtlHIP/xQGLAKyONtnHbYLhWnzYoYRIlgWMfCgNVHRjbReYsuCrMqdkvcd6h
	1nwjzLRL9xyWPVIEvctXUAQlR8Zs+a7EpFSSARcLPnx4lttHjuYjvbXzl/WFdNAvkj8bryyollC
	nAF118EdOKdpl2GWXha4M4BtwvslUA7zFH8n64xoqOzgJScLw==
X-Received: by 2002:a05:600c:548e:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a168106b7bmr77512805e9.33.1791149081734;
        Sun, 04 Oct 2026 14:24:41 -0700 (PDT)
Received: from andreayoga.localdomain ([195.122.200.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104417sm20407354f8f.27.2026.10.04.14.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:24:41 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bernhard Thaler <bernhard.thaler@wvnet.at>,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH nf v2 1/2] netfilter: br_netfilter: restore VLAN tag on refragmented IPv6 packets
Date: Sun,  4 Oct 2026 23:24:27 +0200
Message-ID: <20261004212429.3648-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004212429.3648-1-parri.andrea@gmail.com>
References: <20261004212429.3648-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bridged IPv6 packets can lose their VLAN tag or acquire an unrelated tag
when conntrack-reassembled packets are refragmented. On a VLAN-aware
bridge, or on any bridge with bridge-nf-filter-vlan-tagged enabled, this
can send fragments with a different VLAN tag from the one selected for
forwarding.

br_nf_push_frag_xmit() restores the VLAN tag from per-CPU storage, but
only the IPv4 branch of br_nf_dev_queue_xmit() saves it. The IPv6 branch
leaves the saved tag from the previous IPv4 refragmentation on that CPU.
Newly allocated fragments do not inherit the tag through
ip6_copy_metadata().

Commit d7b597421519 ("netfilter: bridge: restore vlan tag when
refragmenting") added VLAN tag restoration for IPv4 only, shortly after
IPv6 refragmentation was introduced.

This was reproduced on a VLAN-aware bridge by first refragmenting an IPv4
VLAN 100 flow on the same CPU. All fragments of subsequent IPv6 flows left
with stale VLAN 100 instead of the VLAN selected for their egress ports.

Move saving the L2 header and VLAN tag into br_nf_save_frag_data() and
call it from both branches, so the fragments that ip6_fragment() builds
use the current packet's VLAN information.

Fixes: efb6de9b4ba0 ("netfilter: bridge: forward IPv6 fragmented packets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 net/bridge/br_netfilter_hooks.c | 45 +++++++++++++++------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0a394e5f43916..fe8d2910dae21 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -832,6 +832,25 @@ static unsigned int nf_bridge_mtu_reduction(const struct sk_buff *skb)
 	return 0;
 }
 
+/* Saved for br_nf_push_frag_xmit() to restore on every fragment. */
+static void br_nf_save_frag_data(const struct sk_buff *skb)
+{
+	struct brnf_frag_data *data = this_cpu_ptr(&brnf_frag_data_storage);
+
+	if (skb_vlan_tag_present(skb)) {
+		data->vlan_tci = skb->vlan_tci;
+		data->vlan_proto = skb->vlan_proto;
+	} else {
+		data->vlan_proto = 0;
+	}
+
+	data->encap_size = nf_bridge_encap_header_len(skb);
+	data->size = ETH_HLEN + data->encap_size;
+
+	skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
+					 data->size);
+}
+
 static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
@@ -866,28 +885,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	 */
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV4) &&
 	    skb->protocol == htons(ETH_P_IP)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv4(net, skb))
 			goto drop;
 
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-
-		if (skb_vlan_tag_present(skb)) {
-			data->vlan_tci = skb->vlan_tci;
-			data->vlan_proto = skb->vlan_proto;
-		} else {
-			data->vlan_proto = 0;
-		}
-
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = br_nf_ip_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
@@ -895,20 +899,13 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	}
 	if (IS_ENABLED(CONFIG_NF_DEFRAG_IPV6) &&
 	    skb->protocol == htons(ETH_P_IPV6)) {
-		struct brnf_frag_data *data;
-
 		if (br_validate_ipv6(net, skb))
 			goto drop;
 
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
 		local_lock_nested_bh(&brnf_frag_data_storage.bh_lock);
-		data = this_cpu_ptr(&brnf_frag_data_storage);
-		data->encap_size = nf_bridge_encap_header_len(skb);
-		data->size = ETH_HLEN + data->encap_size;
-
-		skb_copy_from_linear_data_offset(skb, -data->size, data->mac,
-						 data->size);
+		br_nf_save_frag_data(skb);
 
 		ret = ip6_fragment(net, sk, skb, br_nf_push_frag_xmit);
 		local_unlock_nested_bh(&brnf_frag_data_storage.bh_lock);
-- 
2.53.0

