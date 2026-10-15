Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9224AB3C1
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087459; cv=none; b=tumSKpIKCJKo75ChFpv5kARFaALv0jGSpS9dJsBKQoroG9Nie4tm/W3HlrRmGSma9wXsqDZaQwEOE1SGkpFFDj5vbPfoTRDgZyWiOoEshAg5X6YqlCtxCkglXaT6O0dPa9O8r3KOd6b0YxLEPh9xDqecAcEzHbs/zRciZQNaej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087459; c=relaxed/simple;
	bh=RBnf8b8QRw1/pS3XpaIdJOrSUHXXX4v/3KfV3aU8d/U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mEEZDfC5aTmpLbzF3vJgMDLf4XNS1WQXUH1/ftzvJrJNs2PFFTw5oaJEe+bagT1DbeNfkLMrg9GgLkUHb0WHp6GNKGNshrG94CYDqYXi3zwRIWVfFIFT/tQgymD+Un6w/hLI/Cgrxw8iYPmivJE0R+RaephcmvlVaBzwjBJPSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0y6/JQV; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0y6/JQV"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5dc2dc6d3fdso2082435e0c.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792087449; x=1792692249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKibE8p71HG4LdZ63GfDMEy7h78ItNosZth3y1tUgIw=;
        b=K0y6/JQVckusR3gCgEbpAKjuQSxK6tDEeEUf5EVVhI1Bj5ZSnD26bZ8F2ZV/lHKRto
         rsCwM/lczhyCXf78PNWk4NUacMavAu+c5N5zZmXRf5g2GfIXJJosZsbgRfXyaimSGWx3
         OnYn5ImGCVwQyYc1/iTvNG4Km3VSKyR94MBjaqse896S5fX7BXd/u7Z71cEHwmqKEsa6
         uOdEfD3794t+wGlmJjywZbIpFz7XgnRs4cj+nVMgxeXTF9zawJ5yuKdPqVQhircLoErh
         G17KDBq2W2GyHfIaj3eGW7DoY9D5+MojkuOFd097ebegIgZskywyH1g4C3iZHAXxHwG/
         gaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087449; x=1792692249;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKibE8p71HG4LdZ63GfDMEy7h78ItNosZth3y1tUgIw=;
        b=LecsIV1SiLgdHgG+M4xYBM/Xp7mEa2ysMo6E+ndNE7O2RiU3h3oRyp2F6L+5fzF10F
         SLFoPe/+i+wfOnKpSJcI7mO7ucGQQo+cngvloRVOdfZIr8ITUQa5QHfaJq+diRB/RTPw
         lfo+Huw2z2pPlpfdP+q/1//9EPnaw8dp51KQQc4VYfJkc6wG7yT5QOpjOk8h1nbjeFy0
         vGfs/iCp8n+VfoLUqyrPUEc/NB/tS50/2INz/hJ3KFCaRCeuzw88lyJep2sdJLSxSn5t
         qEyTuol57pAUk7XTRDJi/lnCAYFv7/ASr6lNJDgH/KU923TS86p+m+adI/WMUiqk7bqw
         hToA==
X-Forwarded-Encrypted: i=1; AKwUvBw1N14TgUrGwMVD2PfFzQ1heMyE9dBOqG91DvxQCzhORhDL9OJ8g1V1PChFD+uj+0s2J8lCrtA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9VDdJfYyh61fdBkXys/cHMw4iN0bMHBN1AYNCw9RqcTw3cFOX
	seiC05RebLTFq7cOitmlUnKBmQiRg8Dlde5wQ7hn23oAwh5meqpvEiIf
X-Gm-Gg: AYBFou1dF+mqc6xL6T7gkiVCV1Au3ibm+eoOoKPu7dQ/GKJddO9jo0OjVp6E2BuXEZ6
	AU4Y0p4vTUJYhgLbHw+1XFl1Vb93stp5do/JQHTWztxEnftNQ5ZGKFz8IcVqMuNMUijhxWPCbpu
	nMUYV4DCs2ZAroNjg/fYXH+s3VF6cfmszyCPHMFtMg/6ie5cFG7Dx6Pgo8IUqDgf8Ph1AD3kQlx
	ZN0bOggLklWTbjVabTXsz/k13+v6kTIWeS26DW2mPiuAwUr671gM2jXl/G7w1gqTEsteXtscTxy
	dvQOA4cbL/0VcF8EAevIUVtuW6h8zVcSjkjxEmagVQmjfWEcwvhBGi2hU7JAHn5o9x6HerDeUuY
	OdbxR8PARHmfJQMLlAenjvL4HBPImzNxDyNyB+MdM5fE1odi9GAp60fc8nW6AGfhWlWCmem0cns
	MMXVyhymRq91PVGozsfgQKRuYuuiRQiDbsneAY0SEfx6VA03rGM+cTQOwVXZZLpsAMSs+713jMg
	1sRQ1v9XZ/7JYFTcn9AWsOEuqOVY6eIzogASDrSST1eVw60DfHQyErP6ORq6S4yVMmZneRRwRiR
	p8prmmFVsMhx4vMGfuFCqnM2zwf5G76vKRFpSw==
X-Received: by 2002:a05:6122:2388:b0:5ea:98fb:e9de with SMTP id 71dfb90a1353d-5ea98fbeb25mr215788e0c.3.1792087448837;
        Thu, 15 Oct 2026 11:04:08 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9943cdabsm280979e0c.6.2026.10.15.11.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:04:07 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:04:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>, 
 Chris Arges <carges@cloudflare.com>
Message-ID: <willemdebruijn.kernel.1a9a8b3792ae6@gmail.com>
In-Reply-To: <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums
 at ingress
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users) a
> virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> If that state is retained, later checksum completion can modify the
> packet after protocol processing has made decisions from it.
> 
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
> 
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that shouldn't happen.
> 
> There's some risk here:
> - non-gso packets which can't be parsed get checksum calculated in
>   software, adding performance overhead
> - gso packets which can't be parsed get dropped
> 
> To mitigate the risks, the following patch will add a sysctl knob to
> bypass the resolution. This is reasonable if the setup is such that
> there is no protocol processing at all.
> 
> UDP tunnel headers get the same handling on the inner header.
> 
> Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
> 
> Assisted-by: LLM
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> Tested-by: Chris Arges <carges@cloudflare.com>
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_net.h | 251 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 241 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..357115ff0ec2 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -5,7 +5,11 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/netdevice.h>
>  #include <linux/udp.h>
> +#include <net/gso.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
>  #include <net/tcp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>

>  static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					  const struct virtio_net_hdr *hdr,
>  					  bool little_endian, u8 hdr_gso_type)
> @@ -158,8 +327,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		case SKB_GSO_UDP_L4:
>  			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
>  				return -EINVAL;
> -			if (skb->csum_offset != offsetof(struct udphdr, check))
> -				return -EINVAL;
>  			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
>  				return -EINVAL;
>  			if (gso_type != SKB_GSO_UDP_L4)
> @@ -167,10 +334,6 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  			break;
>  		case SKB_GSO_TCPV4:
>  		case SKB_GSO_TCPV6:
> -			if (skb->ip_summed == CHECKSUM_PARTIAL &&
> -			    skb->csum_offset != offsetof(struct tcphdr, check))
> -				return -EINVAL;
> -

Maybe keep this and the above check, to keep things exactly as is when the
sysctl is disabled.

Removing these checks weakens validation vs the present state.
