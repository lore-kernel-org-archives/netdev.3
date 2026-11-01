Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554214;
	b=KNqcEQs5R+eSOsZKzm6SWHE8A/KcRo9Fw7g7l5JIsQYS0mcT/xCl/7pWdXqM4MBc6n3T
	 5IAoj/m5vJrISLMfsVXDm8evNVfLh/7GGY3xs3e+D/Mu1ICxx+fiTz3O+zWtf4APfyLLk
	 zCQIfLNClF3Tdzb+dfm7ZB7Sc62D6oUylJ7t0pX8Srf64V7X3Mc+gnFCBFLtOhTFgqmST
	 OAqz91iib12ImGag12moXu3SweOUgbVKjhBUBTxijGu0Y2lwx7cQRGAaPauKS7KTdjUhP
	 pkS3HZ9HoKu8GAF2iFvoUzM9XMs1minqtH21utIotVNUA92Gb0MH7G/so8XsAhZDrtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=h8oZgXrsWtNdxBo95ZuMY1ZDGtn9QAcnUMh/6pblsEw=;
	b=cKzJvhuCFJOpneiLUvBzQkAwBKzPFafYIOBgK5R/4eEbrsVIuXvQtGVKCooxD+xjU/L7
	 ZOkZlfHzjrggMp+IV51vTQoSyfP1mOxZ72svIOKt4s2Med9ljRv0xa7iPkQNo3BkB6kcX
	 5k0wT63VGeLpokNsVNVMbiw5ZPBz2jJO/EKxUDIRbnOgt/4XNsArvEvYc4BiOFzqtEiCp
	 b00KZdHYO4cYDODrGHJfmz6VNdvzjTm+iIo6jj04ASPblAMw1kJc+UzpVcwN2V2c9qdPR
	 +JMeBPs1KRQ9gza3tjgBYdJp5mzyPC4XTzLXcuMM8ieYB0Nxlh8AexnUjVHOLJdlXlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJBzmjvf;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35C606A32C
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 17:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D35C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJBzmjvf
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1190098a91.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793554214; x=1794159014; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8oZgXrsWtNdxBo95ZuMY1ZDGtn9QAcnUMh/6pblsEw=;
        b=DJBzmjvfSco3FICFg2idv+0ljye0HNTj1MdvnD7nftPDGb8VlDqyReKmVc+brgqqZx
         qQfKLXru/2BHn89Xw6q/OxGwhNTqQeji7wfTKshpPGaBA0JMCmUzCFOB4qwTbg0BS30k
         xqxmYhI/Xfamjdr2+ELsO7+0l93qDVPLJIEb09CduJeBE+KGPN++YQmdmUbezKKCmwSI
         1d7YP6zUC0P5QLCrrWLOMgnQ9OpWwMhDO9lr9MdSQ1HmmH9wAmwGvCv8IwdYWVFz/nIG
         enW4g87Kq0h96XpT3XaU67d73zYqp/AtL8/z2y5JGDh4GsspcXF4CWU7+ZQADRPjE1kA
         5oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793554214; x=1794159014;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8oZgXrsWtNdxBo95ZuMY1ZDGtn9QAcnUMh/6pblsEw=;
        b=r/coLjZ7/WULlkB+OeEQwl8BM+aV5B52raUaPWYXU+uBCr8nEcJZTIV/o03AaDx+27
         pQ9k23p+MkL3QGI+Ny0OQtGN7y4YcAhk8ipyaB++4Ele3CRx7IYLPcK6HKrsITiE2yf6
         EdEgVE+b+DaN1FBvLvxVrf5fAV3aUS6+wc/zKILCStbyhrRKJcsoRSiuLW3PqaJJm0ad
         VmbVSCmkkg2NTOT/jxqKh1/MX5wtrKqKHAov3S1j7oYZIbnkZlSrnCyoFW7vsXOWmkQg
         LvJszlSlBbEfUwCVIbeBVTEEMSG1FHxdcnEbNUwx2WO9JiFM3pJmX8F7gmgYxI5LDJ4U
         1zsg==
X-Forwarded-Encrypted: i=1; AKwUvBz6aU2h666R8Zow354P7ihc+MzxeX7bNTXoNAVafonx1WcUIOGaypBiXt10CNKlIxn94wPDw7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HMMagpRNRscwhH2QsZr+6fUzG9JLTWHF1uvvLmRgd8hlUb9n7
	uifL9lTKpbFZ0/lTdpSRLpvRBk5VWfPH6RmVcqHhF9ZFEKMdKsI7ILDn
X-Gm-Gg: AYBFou0g1ThsmlDy9YE/ObT7YVcxvmvqPFuwBGFXtdc2DNII2Z3vNMuWnzd2kbY/Tvs
	l1wG8Ta3B2J6PP6tIv6vI7n0V8cxiVSZnAngvYzOZ1PamJhnuUVLI+F0MhsLcZUVL5MseyyQYWQ
	gn+gw4Vp+0nb4h9aPlTZvMbhhifnKb5D9m53aJscdYIl1RIR1nb80Zrbkhk9baWdHUH+X0+eKOX
	pMmvhkMipHwYcHEsHOnH56ykvlTQpttZZopBTJd4NJS6u0K1Xt2+t4H7gz4eVpsycahFswV//Qh
	t8Cv41UNadBFUEgaM4Wbf8gMMv3wTOSRHqrroWdVoPSB5dVaDsyfpCHEyc7o6LD0SeZ6zh8Qp9J
	eo++0HqGEmarlzz9BrXDB2rHULntogxCddnwtYeMOPtuYczkH56dsV1vLd9xpkpC0mrfHs2V7i6
	Bi5Z2wHsCO+RzD26bJdfQzwltS6PGGsyZYTIRRFgYfEhSRkTENYXQXjHfe0hwAe4UyoUlACKScm
	KVSb7RlsM563OY0AbCTUWDh7WBnvEKrPstWjEhUn7Zy5MTss9nuotDEAyBiVPSIg0Mulbj+EEBu
	wGg5sVBHrJ01NkMdESDgcbMRx3Wi2shkolJSh1Kd2vx1e8qMU2KEKo4X4sp7gPmnCapeME8ZO4U
	SYWwcavR8FseS581SQgeZISTXSwH6JNgWIg==
X-Received: by 2002:a17:90b:4a11:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3ae896f7fc4mr6014943a91.14.1793554213552;
        Sun, 01 Nov 2026 09:30:13 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm14819745a91.15.2026.11.01.09.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 09:30:12 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 17:30:12 +0000
Message-Id: <DMK1WMB2XY42.29D4PNQZ4JVBV@gmail.com>
Cc: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <dsahern@kernel.org>,
 <idosch@nvidia.com>, <richardbgobert@gmail.com>, <willemb@google.com>,
 <ecree.xilinx@gmail.com>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <martin.lau@linux.dev>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: keep the TCP fixed-ID flags on the header
 they describe
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Julius Bairaktaris" <julius@bairaktaris.de>, <netdev@vger.kernel.org>
In-Reply-To: <f689def2f03965d7e4c48455c3926d7475044910.1792857378.git.julius@bairaktaris.de>
References: <cover.1792857378.git.julius@bairaktaris.de> <f689def2f03965d7e4c48455c3926d7475044910.1792857378.git.julius@bairaktaris.de>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 08:46 AM Julius Bairaktaris <julius@bairaktaris.de> wrote:
> GRO sets SKB_GSO_TCP_FIXEDID for the outer IPv4 header of a TCP packet
> and SKB_GSO_TCP_FIXEDID_INNER for the inner header of an encapsulated
> one, and segmentation reads them the same way. Three paths do not keep
> the flags on the header they describe:

When the same mistake is made in N places the interface is the problem.

Before commit 3271f19bf7b9 SKB_GSO_TCP_FIXEDID described the innermost
header. Encapsulation didn't have to know about it.
That commit made it describe the outermost header.
Now every site that adds or removes a header has to move the flag.

This patch changes 9 sites and it's not enough.
xfrm_output() sets skb->encapsulation and SKB_GSO_ESP.
xfrm4_tunnel_encap_add() adds the outer IPv4 header.
SKB_GSO_TCP_FIXEDID stays, so ESP tunnel mode has the same bug as IPIP.

> tunnel GSO types of the removed header. Keep encap_level below GRE and
> UDP tunnels, as ipip_gso_segment() and the IPv6 tunnel handlers do; the
> inner pass then also masks the features with hw_enc_features, which the
> tunnel handlers have done already, and resets the inner headers of each
> segment.

This undoes
commit 5197f3499c47 ("net: Reset encap_level to avoid resetting features on inner IP headers").
With remcsum __skb_udp_tunnel_segment() sets NETIF_F_HW_CSUM after its
mask. The mask in inet_gso_segment() clears it again on bnxt and mlx4.
Their hw_enc_features has NETIF_F_IP_CSUM and no NETIF_F_HW_CSUM.
Then skb_segment() checksums every segment in software.

> The three changes go together: with any one of them alone, fixed IDs
> are lost in a case that works today, such as a packet encapsulated and
> decapsulated again without segmentation, or one forwarded into an IPv6
> GRE tunnel.

Lets keep SKB_GSO_TCP_FIXEDID on the innermost header.
The second flag describes the outer header of an encapsulated packet.
Willem's intuition in the review of 3271f19bf7b9 was right:
https://lore.kernel.org/netdev/willemdebruijn.kernel.a8507becb441@gmail.com/

                               this patch          flag on the innermost
                                                   header
  encapsulation                move the flag       nothing to do
  ESP tunnel mode              missed              nothing to do
  decapsulation                move the flag       clear the outer flag
  SRH decapsulation            move the flag       nothing, outer is IPv6
  FOU pulls offloads twice     needs a check of    clears it twice
                               skb->encapsulation
  GRE, UDP tunnel GSO          keep encap_level    as-is
  sfc, mlx5                    as-is               less code

Then no need for skb_gso_fixedid_encap(), skb_gso_fixedid_decap(),
the bool in iptunnel_handle_offloads(), etc.

Something like this (compile tested only, the mlx5 hunk was not built):

diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
index 25a8b7e..0f20bb6 100644
--- a/Documentation/networking/segmentation-offloads.rst
+++ b/Documentation/networking/segmentation-offloads.rst
@@ -49,8 +49,8 @@ The default behavior is to increment the IP ID with every segment.  If the
 GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
 ID and all segments will use the same IP ID.

-For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the outer header.
-SKB_GSO_TCP_FIXEDID_INNER can be used to specify the same for the inner header.
+For encapsulated packets, SKB_GSO_TCP_FIXEDID refers only to the inner header.
+SKB_GSO_TCP_FIXEDID_OUTER can be used to specify the same for the outer header.
 Any combination of these two GSO types is allowed.

 If a device has NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 22fea47..b804a75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1175,12 +1175,8 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
 	tcp->check = ~tcp_v4_check(skb->len - tcp_off, ipv4->saddr,
 				   ipv4->daddr, 0);
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
-	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id) {
-		bool encap = rq->hw_gro_data->fk.control.flags & FLOW_DIS_ENCAPSULATION;
-
-		skb_shinfo(skb)->gso_type |= encap ? SKB_GSO_TCP_FIXEDID_INNER :
-						     SKB_GSO_TCP_FIXEDID;
-	}
+	if (ntohs(ipv4->id) == rq->hw_gro_data->second_ip_id)
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;

 	skb->csum_start = (unsigned char *)tcp - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index 0300575..162cfa5 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -201,16 +201,10 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
 	bool outer_csum;
 	u32 paylen;

-	if (encap) {
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
-			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-			mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
-	} else {
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
-			mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
+		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
+	if (!encap || (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER))
 		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
-	}

 	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
 		vlan_enable = skb_vlan_tag_present(skb);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 6f7fec2..ac3f664 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5535,7 +5535,7 @@ static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
 	netdev_features_t feature;

-	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
+	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_OUTER))
 		gso_type |= __SKB_GSO_TCP_FIXEDID;

 	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf..6eb913e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -716,9 +716,11 @@ enum {

 	/* These indirectly map onto the same netdev feature.
 	 * If NETIF_F_TSO_MANGLEID is set it may mangle both inner and outer IDs.
+	 * SKB_GSO_TCP_FIXEDID stays with the innermost IPv4 header, so there is
+	 * nothing to do on encapsulation. Decapsulation clears the outer flag.
 	 */
 	SKB_GSO_TCP_FIXEDID = 1 << 30,
-	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
+	SKB_GSO_TCP_FIXEDID_OUTER = 1 << 31,
 };

 #if BITS_PER_LONG > 32
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 5cccf4c..a8e1cd7 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -667,6 +667,7 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
 			return err;
 		skb_shinfo(skb)->gso_type &= ~(NETIF_F_GSO_ENCAP_ALL >>
 					       NETIF_F_GSO_SHIFT);
+		skb_shinfo(skb)->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 	}

 	skb->encapsulation = 0;
diff --git a/net/core/filter.c b/net/core/filter.c
index 09c60a5..0b8d363 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3803,6 +3803,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		/* Clear encapsulation flag only when no tunnel GSO flags remain */
 		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
 			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			shinfo->gso_type &= ~SKB_GSO_TCP_FIXEDID_OUTER;
 			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
 						  SKB_GSO_UDP_TUNNEL_CSUM |
 						  SKB_GSO_GRE |
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7677b03..d5769a5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1402,10 +1402,12 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,

 	segs = ERR_PTR(-EPROTONOSUPPORT);

-	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
-
-	if (!skb->encapsulation || encap)
+	if (!skb->encapsulation || encap) {
 		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
+		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
+	} else {
+		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_OUTER);
+	}

 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b84fcd0..7919004 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -459,6 +459,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
+	const u8 fixedid = NAPI_GRO_CB(skb)->ip_fixedid;
 	struct tcphdr *th = tcp_hdr(skb);

 	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
@@ -473,9 +474,10 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);

-	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID << 1 != SKB_GSO_TCP_FIXEDID_INNER);
+	/* Bit 0 of ip_fixedid is the outermost header, bit 1 is the inner one. */
 	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
-			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
+		(((fixedid >> skb->encapsulation) & 1) * SKB_GSO_TCP_FIXEDID) |
+		((fixedid & skb->encapsulation) * SKB_GSO_TCP_FIXEDID_OUTER);

 	tcp_gro_complete(skb);
 	return 0;

