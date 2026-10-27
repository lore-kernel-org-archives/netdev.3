Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112051;
	b=atKrqkHlL0vyNxvkaizNKsC/pOi1J9oFMruJqKW17qNg9wOu+uCD/7eyn8TrQ6jC/7hG
	 XLN07pEeOh44MAtHjeJeu5S+lsPhJf8jcIjDrT8/Uq/VRVL3SmJYAMGdg0se17lo/Xpi+
	 UpCRtiTr1RL55SjopMsSK+GR0RTPQLwkRmozGffEMYGDw6AFZ7yspzq8dLBDca7iU2mTD
	 5RCP+spQMueMTb3YxGDno1+dEUVVfvExCv4/Juftnxuj3iB6tst65ApDVOzy/90cVSU3y
	 N5DlwetfID0Yv2hoI/dIT0HQdp1PQJXm8NRnf2ltDSsmyYNWLPbe/qN+ePeUEvnnYeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VB7H2/azrF+1bwF5JqJO2AtcXUqBNk32tC8HASYM0KA=;
	b=oqVSJHnWhQqsfgsWFHk+BZCwmoUZ++xHLbDRo60Ebk6kL+cwMxXlrSUYgulVNxKFksDH
	 jNmZdRwwjEvmLd6eddKS4cCgvBg1UM4ypuX+YQlYrNFX7fWXAuU22YIGboK92RR890TQA
	 OSl8xLSmaRbih8Ke4m/iux+MlnnIacQwUc/EZporkAxqWDmlQ2S/PzLC/4DJUjUIi1R+L
	 a48pnW0O9fCk8+HH+lixJ1QcnF5tc5ilV3NxouNoC0gbTUiiSwAmABPMgwlPJH7AIEuo/
	 GVBVjKFUaU44p+N6u2OQaRLk5AmEE17ZQ0befgMmvr7/I5U/NPx/dSbeWDqGBdtKTQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hFKzeOUy;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E3606A320
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D95E3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hFKzeOUy
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so849625241.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112050; x=1793716850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VB7H2/azrF+1bwF5JqJO2AtcXUqBNk32tC8HASYM0KA=;
        b=hFKzeOUyEXFw8asiiPMvPqAWP1hLYNbsk4v70blvOqdyjLr7bojrcwBiSA9Rk3GPvm
         dn052xA63PNALXGZeF4okhB/qlcjvZiD7YoFLMODDMPRikAqQubJ5zo7TldO1osiAutx
         hA6Mudiw22j4YWLDTrNZQnaId9eSZsCYscAjPrc59KTd1J4g+e3CUzVAHaM3EsPUPPzx
         QOd4KijoXLZFGpmNGFFhoKf09/w2NJ94kbRHVBbZi+4zw7KaxDq3T/LqZ8Os1RxapTGY
         /t6leAvAFVlFG6DPjdCvbxA0uV5K1oi1YE57iIM4YmJA6O1czUpS3NJ/Rnz9pN7XdS4l
         fcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112050; x=1793716850;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VB7H2/azrF+1bwF5JqJO2AtcXUqBNk32tC8HASYM0KA=;
        b=OG3PXvWdsKvpzmvLCChqa5nmVw1iDKsEx5+Dc4V8vz7345wVJ84m5dBJKH2VTIJZPd
         idOK1FqFyPm4IxvN/ru0yUHiOZOoEKnTFrJCbIJXDSXMiwd7Pd2gi63dYK0CZZ6XOH4U
         JXYw1BdPvFbpSA55MtAVmFnnq2mkJdDWemZb3JcadMzrbsbS2wHtAUdMD1qr+g45nI9C
         dZOrJabOeP3QAxf1bgxoCXOtQxiJFfcLjBkazC6VhgOyXDkgRce1BhnYjl7V7cgm8tzR
         lruzZRzGdEJF4TPLyLQibZOYdJAjIV67WnqYQfkXePaHM3n94E22q0tjYnN95QyT+u92
         NZMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcUK+ZFHaujoUfylRwZIwJyAnu+RUYaovSN2ZDLKW5chC/f3o7xykh8B870UkGNsoMC6bvNNM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWKde7pcd36LmK7IeKzMMg0NbPx5Py6VIlEFeYF+K+B1EyQaMK
	HfAkO/LkwMUA26p5NLyYKraU3cO64TLkFVLgBTMf0XWbfk2kbIRyZX9jmfejLA==
X-Gm-Gg: AYBFou1GAePvshNLn3gNjhlUTYcb7ERatsafWm+uL5ujf07YrXiHKR8FkXu0FiHFR7A
	zFgy7p9j1XIotJxK2Dk6evqSrsrSeRmxmqk/zkRrBMjew+NNVf5KZT01yfMxWKXXT+PJpP7J+AR
	e5bPcsbPpAVSR6qzZ8MSYWX4nRTpSrygxgDYXHomDsWLvetjDhvB6mVHi+5sDF+mtH5m9LkMKe+
	G9AjeprGJhb3FF/oL8AlQrznoX5ykuHErcwunYNIodSdKwEDz9MAPjhixFOQFkJ/80v0jLVBAic
	qrD/RMWApi2PxS+4uw19YgpnuSBnOUAKrKvmwpIHNpGGWibLawwbf37vrTJ6DHbNm/XY1iGJ09B
	Fa7X7d2uS876RAK8+R62UAv/DVst/7gybi1oGYXUUYkJs1C2K3Ig1k62nUnFDC8NUAg5+J2juR1
	0j/T8Hrx4ZTj6+0bX9t9svMvR6gZuTg/N0zmg6JGSGrOYXzB6gtBaNkYg8/1EDQnr+8Xna2sm04
	GFFICIwyEQpgGYIQ41JfhU1Hcp7+dIGa21P2bNbmA8oOjJOaF656GZfYG0PTlfEFsJombHIuX1J
	Had84jUWaZgqiOA5iy1iSkUppkZMKakXc7NGF49hiVujfurL5h25Btshh+H8HDKmj/YOBrJwacO
	rsR9XI+6plJAydI0GESo=
X-Received: by 2002:a05:6102:6e8a:b0:7cb:cfcf:3d01 with SMTP id ada2fe7eead31-7cea15c6056mr943519137.33.1793112049724;
        Tue, 27 Oct 2026 07:40:49 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4a5f26c7sm38302e0c.9.2026.10.27.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:40:49 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:40:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 dev@openvswitch.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ren Wei <weir@nebusec.ai>
Message-ID: <willemdebruijn.kernel.22807e0fe104d@gmail.com>
In-Reply-To: <20261027082604.1485903-1-edumazet@kernel.org>
References: <20261027082604.1485903-1-edumazet@kernel.org>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> NIC drivers always provide this, and they should keep using the fast
> version, without an extra pskb_may_pull().
> 
> Devices looping skbs from their transmit path back to their receive
> path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
> act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
> or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
> than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
> the BUG() in __skb_pull().
> 
> Instead of fixing every producer, or adding a check to all
> eth_type_trans() users, fix the few consumers exposed to this:

Definitely a nice approach.

You previously suggested catching most of the TC modifications with a
single check in sch_handle_(e|in)gress. Is that no longer needed?

The few mirred/redirect cases are a bane, causing so many issues. And
escape any such check, as they call netif_receive_skb, netif_rx,
dev_queue_xmit, directly.

If it's only act_mirred, bpf_redirect and OVS, maybe a single
validation helper across all three before they pass to the rx/tx
path, that for starters calls eth_type_trans_careful. It quite likely
won't be the last packet corruption they are capable of..

> 
> - Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
>   header first and returns a drop reason on failure.
> - Patch 2 uses it in loopback_xmit().
> - Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
>   ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
> - Patch 4 uses it in OVS internal_dev_recv(), covering both the MPLS
>   (TEB) and NSH pop cases at once (only the MPLS case was tested).
> - Patch 5 (from Jamal) fixes act_ife decode on egress, which was
>   consuming the inner Ethernet header. This is no longer a crash after
>   patch 2, but egress decode never delivered a correct frame.
> 
> Other eth_type_trans() users already pull the header or never see
> such skbs:
> - vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
>   before vrf_local_xmit().
> - tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
> - XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at least
>   ETH_HLEN bytes in the linear part, and multi-buffer tail shrinking
>   only trims frags.
> 
> Tested under virtme-ng with AF_PACKET reproducers. Without the series,
> all four cases crash in eth_type_trans():
> - lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
> - lo egress "action ife decode pipe", IFE frame with 8192 bytes payload
> - lo egress "action vlan pop_eth continue", then a BPF program doing
>   bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRESS)
> - OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
>   eth/mpls/eth/4096 bytes frame
> With the series, no crash. An ICMP echo inside an IFE frame decoded
> on lo egress is now received and answered. Normal traffic on lo,
> veth (including 8000 byte pings) and vrf is unchanged.
> 
> Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebusec.ai/
> Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-4@mojatatu.com/
> 
> Eric Dumazet (4):
>   net: add eth_type_trans_careful()
>   loopback: use eth_type_trans_careful()
>   net: use eth_type_trans_careful() in __dev_forward_skb2()
>   openvswitch: use eth_type_trans_careful() in internal_dev_recv()
> 
> Jamal Hadi Salim (1):
>   net/sched: act_ife: do not consume the inner header on egress
> 
>  drivers/net/loopback.c               |  8 +++++++-
>  include/linux/etherdevice.h          | 28 ++++++++++++++++++++++++++++
>  net/core/dev.c                       | 18 +++++++++++++-----
>  net/openvswitch/vport-internal_dev.c |  8 +++++++-
>  net/sched/act_ife.c                  |  4 ++++
>  5 files changed, 59 insertions(+), 7 deletions(-)
> 
> -- 
> 2.53.0
> 


