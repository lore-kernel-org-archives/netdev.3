Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E0432E80
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537723; cv=none; b=DzsU5PHgxQUOAmdlHjNBvS/F9ZeZoSMRrnixeGf63CW65FjE4ChfOMqbSueh1/g2G1dis7BLVeRm8Oy92SU+AXEuo3JJ5tDkRs8Afc9E7u8iZuf+WWy+nol1/VLLKfhVniubuYaqPtMdpuSLR5yivDMycDsQBfXpej7XuTaHj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537723; c=relaxed/simple;
	bh=88f9d2BUrgkhy3LVgpQwMbhrUIGdq9Oyss4iFvdVUbk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HuajVI+ZyVVQsMx2soHGyRurvY3/hDEzW9aFB0+nwqMKpxjvxZyNsdr8hq8N+DMYVdd8O4GcsUnxeV0EXIeynBDkHToRsOdkywuztupYZIXz6Tr3iPQa6geSwLWGe0CcDnyPP/K4tQmWOlefBD2/9zQrRmTm73HYCZF8KhkC378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR1x0rwz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR1x0rwz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81f3b227a4aso13616227b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786537721; x=1787142521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0CjelUjNxSUEcr0ca3VFdthDgG/go9h4jG0ssyrUC9Y=;
        b=oR1x0rwz74tkdNtZ/C107VdEIPp72gDBR6hIszckJ/Cen2QSVY6hnD8hRlEZ/ODpdY
         S8VJsaJdNYt2ZC7FMh3r3KAk1wdJgFNpiFkFWkOm4+P3BRUpyv72EMFeicbz/BIAPQYV
         1nWjpO/AMMC6EO6x/OpOZtKqkO7aGQ8FCjrRSvgFvsV1CneZix+Kp8LyP0bQX6aov76i
         52/ctc8t3p829LRzwn5U/tKXphgT8JTf3uAlfWD7kLIEcZN3ZsAxdE822A526Bgsr7cr
         LyNQXX/EcUsrd8Xk1/Uh4tq4AeTSzy5kqkzAEEQkj3l5kcCXvBxA8gAY1/4G7zzb1Sa6
         q37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537721; x=1787142521;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CjelUjNxSUEcr0ca3VFdthDgG/go9h4jG0ssyrUC9Y=;
        b=WbUx+lpZ7NjmQe1t8snwZbZzn++yhNEPGm6icfegDaPzxkGClWVKokfSe8U/YWUHFI
         b3ByivLDkENuu2RLaXAZJO2Hv9d2uYCCx0DgFpkRi6Y3lKQgtiaqBVBP/cdsn/zo6OP6
         VNHWOBcnIKer9ZipX6h8SIebEU3IECcslDtd15BlcdG1N3sCjTUT57Wtp7V9i3/YOYeb
         XgEI7bBLseVkMq67hizaEkcVkpDdY8hETMxaCNGDBkcdhOPw1TJBTvzS1MMdIENrdvq2
         6xmvoXxfp+WUF+iaAobUK5Mr7KXcOKgfAmjwsnHPNhwDZL2N/nwA0CibS9wyT9qRjQ7d
         RKKA==
X-Forwarded-Encrypted: i=1; AHgh+Rri1YaAYsdiKt0eXH81nQ2LG3tf7lwaM6fHgJ0qk+HVE92d+QZWMN+oX0j8uJQzw7Jv1KTIGW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygAvhleY9/Gq6uwLZBRXHDHOplM1OvnXpm9EsY9UaAXVXCMA+A
	66B5+OhRrMrEW0yMi3ow2VA+RSxlDAnNZ4to5q4JdFnTF18sJcrs+v8K
X-Gm-Gg: AR+sD10xDTy2QUPh+rkP9+V8W/zkI5DJEnHWWEXbCd0bdzS25wnqD+RRk849Bcy7ycm
	uBUkTwmGdtnSL89Qz/KEzB6rBaVY4/+2ePMh6/8dhcRTuxY1Miy3omBQCA/r6WG4DKcLh6B4ejT
	NxWJPv7eFSS2E0vPUxk9HxSQzCE4TbH2MBmbQ7Rd1OdqmTLMv0ajrux8yspvpQtBHLWTXpenjUA
	nZbrRMCgj6WEVX3whiATxIwe5Uq0OrZUxChoSjqaTudmdMnhldbljatdFtI5RCm2KjbilLGaWe9
	G0sII3gE5WhBc2qwe2LX4fHNBgBN9I5EPvZdsQd3yrNBA2f2VC6kPNUkIi6noeZHw+xeXMDAX5r
	78TDzbrGCmRDDaZFRbdB4i9+/HSg5ArlXvQoJAhJYSlJxGt/te+6ID9IZub8SLB5etdlKFQCQ1T
	+OWU2kIV3sb0J6RpGJ0A4UbvrVCa8xdHJ21Fm28Ycc7GirnwvHUWlAAYgHReMmsHGxzfJVb2ceg
	uwA2ByhduGaBuZ325ufydRK3O7OvTwlXnTp
X-Received: by 2002:a05:690c:841:b0:7fd:a7b6:8d87 with SMTP id 00721157ae682-83109b146a9mr21194837b3.25.1786537720803;
        Wed, 12 Aug 2026 05:28:40 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a34a1df3sm11762607b3.4.2026.08.12.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:28:40 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:28:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.57d27685522a@gmail.com>
In-Reply-To: <20260811184722.2612345-2-joe@dama.to>
References: <20260811184722.2612345-1-joe@dama.to>
 <20260811184722.2612345-2-joe@dama.to>
Subject: Re: [PATCH net-next 1/2] net/packet: Reduce VLAN tag code duplication
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Reduce code duplication for VLAN tag extraction by factoring the
> repeated code into a helper and using it.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Especially with the improving AI bots, we're getting even more fixes
to PF_PACKET lately. Cleanup patches can block fix backports to stable.
The bar for pure cleanup patches has to be high to warrant that.

Plus, they add risk, if it is not trivial to review that they are NOOPs.

Subjective, but not sure this one warrants the cost.

> ---
>  net/packet/af_packet.c | 95 +++++++++++++++++++++++-------------------
>  1 file changed, 53 insertions(+), 42 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 435756877aba..ee60dcc639ad 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -568,6 +568,27 @@ static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
>  	return ntohs(vh->h_vlan_TCI);
>  }
>  
> +static bool packet_get_vlan_tci_tpid(const struct sk_buff *skb,
> +				     struct net_device *dev,
> +				     u16 *tci, u16 *tpid)
> +{
> +	if (skb_vlan_tag_present(skb)) {
> +		*tci = skb_vlan_tag_get(skb);
> +		*tpid = ntohs(skb->vlan_proto);
> +		return true;
> +	}
> +
> +	if (unlikely(dev && eth_type_vlan(skb->protocol))) {
> +		*tci = vlan_get_tci(skb, dev);
> +		*tpid = ntohs(skb->protocol);
> +		return true;
> +	}
> +
> +	*tci = 0;
> +	*tpid = 0;
> +	return false;
> +}
> +
>  static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
>  {
>  	__be16 proto = skb->protocol;
> @@ -997,20 +1018,19 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
>  			struct tpacket3_hdr *ppd)
>  {
>  	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
> +	struct net_device *dev = NULL;
> +	u16 tci, tpid;
>  
> -	if (skb_vlan_tag_present(pkc->skb)) {
> -		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
> -		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> -		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> -	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
> -		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
> -		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> +	if (po->sk.sk_type == SOCK_DGRAM)
> +		dev = pkc->skb->dev;
> +
> +	if (packet_get_vlan_tci_tpid(pkc->skb, dev, &tci, &tpid))
>  		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;

Does this change behavior, now setting tp_status also for the second
branch, where previously the flags were not set?

> -	} else {
> -		ppd->hv1.tp_vlan_tci = 0;
> -		ppd->hv1.tp_vlan_tpid = 0;
> +	else
>  		ppd->tp_status = TP_STATUS_AVAILABLE;
> -	}
> +
> +	ppd->hv1.tp_vlan_tci = tci;
> +	ppd->hv1.tp_vlan_tpid = tpid;
>  }
>  
>  static void prb_run_all_ft_ops(struct tpacket_kbdq_core *pkc,
> @@ -2247,6 +2267,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		       struct packet_type *pt, struct net_device *orig_dev)
>  {
>  	enum skb_drop_reason drop_reason = SKB_CONSUMED;
> +	struct net_device *vlan_dev = NULL;
>  	struct sock *sk = NULL;
>  	struct packet_sock *po;
>  	struct sockaddr_ll *sll;
> @@ -2262,6 +2283,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	__u32 ts_status;
>  	unsigned int slot_id = 0;
>  	int vnet_hdr_sz = 0;
> +	u16 tci, tpid;
>  
>  	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
>  	 * We may add members to them until current aligned size without forcing
> @@ -2436,18 +2458,12 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		h.h2->tp_net = netoff;
>  		h.h2->tp_sec = ts.tv_sec;
>  		h.h2->tp_nsec = ts.tv_nsec;
> -		if (skb_vlan_tag_present(skb)) {
> -			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
> -			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
> -			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> -		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> -			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
> -			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
> +		if (sk->sk_type == SOCK_DGRAM)
> +			vlan_dev = skb->dev;
> +		if (packet_get_vlan_tci_tpid(skb, vlan_dev, &tci, &tpid))
>  			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> -		} else {
> -			h.h2->tp_vlan_tci = 0;
> -			h.h2->tp_vlan_tpid = 0;
> -		}
> +		h.h2->tp_vlan_tci = tci;
> +		h.h2->tp_vlan_tpid = tpid;
>  		memset(h.h2->tp_padding, 0, sizeof(h.h2->tp_padding));
>  		hdrlen = sizeof(*h.h2);
>  		break;
> @@ -3547,7 +3563,9 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	}
>  
>  	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
> +		struct net_device *vlan_dev = NULL;
>  		struct tpacket_auxdata aux;
> +		u16 tci, tpid;
>  
>  		aux.tp_status = TP_STATUS_USER;
>  		if (skb->ip_summed == CHECKSUM_PARTIAL)
> @@ -3562,29 +3580,22 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		aux.tp_snaplen = skb->len;
>  		aux.tp_mac = 0;
>  		aux.tp_net = skb_network_offset(skb);
> -		if (skb_vlan_tag_present(skb)) {
> -			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
> -			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
> -			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> -		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
> +		rcu_read_lock();
> +		if (unlikely(sock->type == SOCK_DGRAM &&
> +			     !skb_vlan_tag_present(skb) &&
> +			     eth_type_vlan(skb->protocol))) {
>  			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
> -			struct net_device *dev;
>  
> -			rcu_read_lock();
> -			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
> -			if (dev) {
> -				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
> -				aux.tp_vlan_tpid = ntohs(skb->protocol);
> -				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> -			} else {
> -				aux.tp_vlan_tci = 0;
> -				aux.tp_vlan_tpid = 0;
> -			}
> -			rcu_read_unlock();
> -		} else {
> -			aux.tp_vlan_tci = 0;
> -			aux.tp_vlan_tpid = 0;
> +			vlan_dev = dev_get_by_index_rcu(sock_net(sk),
> +							sll->sll_ifindex);
>  		}
> +		if (packet_get_vlan_tci_tpid(skb, vlan_dev, &tci, &tpid))
> +			aux.tp_status |= TP_STATUS_VLAN_VALID |
> +					 TP_STATUS_VLAN_TPID_VALID;
> +		rcu_read_unlock();
> +
> +		aux.tp_vlan_tci = tci;
> +		aux.tp_vlan_tpid = tpid;
>  		put_cmsg(msg, SOL_PACKET, PACKET_AUXDATA, sizeof(aux), &aux);
>  	}
>  
> -- 
> 2.53.0-Meta
> 


