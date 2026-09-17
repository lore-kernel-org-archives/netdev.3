Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AEB4A99A2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639937; cv=none; b=Y5MoNsMR5mfM/QHXj2OrsbnN/oSnvvj8erwjwzVHdqhC9rhQkjqGri/n4ifvlPOTTTFcZF6+X5kz27K1ql/g78heDPYXNmW2uM8rtpkXXZ0vnSHPYBKNCtuxs+4WtYMuz+HKOe5T7yWzIlGDJlCHp9gY6jowhIGCGAelkY6Pu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639937; c=relaxed/simple;
	bh=qtKtKBO61OoCe8lbDkcmUG8lBmk30/Jv2wDq64SQZuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qK03x48XCEhUWUtUahS4+aAAnQO+yZgMBqnJ2OW3ahHl15RaQkIX4qLMfQdEciW5Sp0GLP8YzYazQzqnbihNR0u7i2mfUeyaujLpEGcHFGij7VdDT+jjFnATdjrgnTqMMcI0NGotYq4iV3KyVaeBwTaOBhNDKs/YsTXOBMqaiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTgPfqKH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTgPfqKH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso4844915e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789639933; x=1790244733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jXd66g/TmmiGHEM82GWIsMZ57cUtyZBBMLPotbvyTAU=;
        b=nTgPfqKHOpWdTeEDbKrvIUgX6y+oMWwgmkTWBTc0Ipjn2WJpuBFkeCNr7zV/U1i4qC
         +XcI6hAAsMEjK6E/F7gqSCvy8+wnCo8pCmbuRBdpAGVloVPtQrdM7JLo/RlEOlYwq4iB
         zO+kJYrmEZD1RCh3PnN2NvHtx9EAl9KqIbBKzjP552B99w0Fvm2VPaIYDtaXA4thsMlI
         XDA7F0pO+/SkAE6xkyzZ0FZta/Sck9EWyJrnroKT2gWLlljAWWpLUqrs313V63ePfpRf
         kSmSmdyazoL0EK0ztjFUqQQLGYJfPCFAclYVTibdtaQkbFVPEHjhRllpbkccr1lGvbp8
         f8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789639933; x=1790244733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXd66g/TmmiGHEM82GWIsMZ57cUtyZBBMLPotbvyTAU=;
        b=mjEMCNvEef7g4ar50Ax92gZjT8og83aW60Zya59WPCJeePkaQ0iczQm4fuX3wgRCcl
         k1a/3A13dbyMrDqaeBfmHRObfdDZeN2nsFCQg4wn3BLL0v0vz0SzPOAgln6Q21w5bN2J
         AbTs0UjEbRAA+XkMLw83h3XsAcci/U62uBXYCNcSAFCd/3tJS6bt2EC7DKFxPyND63OY
         xavlXDAEKaayOSnF+qr5kPYNPKyqaaj9cnQbMjWFGFT1+3SKRYlkGPRKd4sqboCDyi9v
         vjeIRDgbpd+ZKTJuexXi0Q7rqckqyKOzc996q6K9tA8BxgSbjKMqN6Eubc/bOYboRpsF
         awpg==
X-Gm-Message-State: AFuF++ls8z/XuvmbFvYmhurS8k/o0+8y+DEu6cm5i2WOni46ZPRkGr8K
	OEyqIZgEoV4ChM3H2w7VjgI/CKfGUR9nHv559bnc4N27nmNTNuUP3N6I
X-Gm-Gg: AYBFou0QjXYmVZHz6il5yQOQjS7b83opadTBP48yu0/FuNHxHlfPCRqfJWP9MZb57OS
	fA1iFJxehXaPdzxtTvH/H0pczRV6pxtIzpLjRQv9M5BRdOvuIEVeZidtR8UByLX2H4ArKuni+Mv
	f9Bgz4PerGrjiRg/vR7ZUW8zkIMYzoFhnjlA5AZ2NUaQQodjieQK27y7fHlRd1MwBgpnx50RDjG
	Nn6kw3KsjDzau763yWAdSrlYE0umn/eH8gnvtf/uCzBgifFviTBZ5/W6cDU4+JCqeLQUdDD0y51
	jvHlkccgW1YdcVzww7eeE4lRemQZ8mz46W9OH2J1nUONNIxP7Seej6km/GV9x7QzYlM/ugq45s8
	LehtVAuzF1fA1vrFc+aVSDaX+gi0+Ug2mqBkMRCQ7LhIgE+m7oYs0mkBoT8wVVB6uYfwvy9+kee
	tsCXVA+NZV7SPkpw1Q/F2/yyjsniXhalP+5eRXQG2RhCs+iP4AMA59g2R0svWOCfeFqBlwpxIWF
	HCeXWSk/+XF6O/GXoxZiE3zt8ACSQSJd1IVZSJFdSxD2f2LKWKB
X-Received: by 2002:a05:600c:34c2:b0:49e:6c27:d093 with SMTP id 5b1f17b1804b1-49eb72f7043mr68451005e9.15.1789639933119;
        Thu, 17 Sep 2026 03:12:13 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:d1c6:8f88:e273:c9da? ([2a02:a03f:a75e:9a00:d1c6:8f88:e273:c9da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd226ef3sm63094115e9.1.2026.09.17.03.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 03:12:12 -0700 (PDT)
Message-ID: <fd0ffc06-f1c5-42d6-ae16-b592208c6d69@gmail.com>
Date: Thu, 17 Sep 2026 12:12:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: keep room for the mac header when growing the
 headroom
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 23:38, Yuya Kusakabe wrote:
> __seg6_do_srh_inline(), __seg6_do_srh_encap() and
> seg6_do_srh_encap_red() all grow the headroom with skb_cow_head(), push
> the new headers into it, and then rebuild the mac header below them with
> skb_mac_header_rebuild().  The headroom left after the push has to be at
> least skb->mac_len for that rebuild, but the three requests ask for the
> pushed length plus dst_dev_overhead(), which leaves LL_RESERVED_SPACE()
> of the egress device, 16 bytes for plain Ethernet.
> 
> Where the mac header is longer than that, as it is on ingress through a
> VLAN device with reorder_hdr off, the rebuild runs out of room:
> skb_set_mac_header(skb, -skb->mac_len) computes a negative offset,
> stores it unchecked in the u16 skb->mac_header, and the memmove that
> follows writes skb->mac_len bytes about 64 KB past skb->head.
> Forwarding plain ping6 traffic through such a device reproduces it on
> all five encapsulation modes; skb->mac_header comes back as 65534 on a
> 704-byte head.
> 
> Ask for whichever of the two is larger.  These requests carried
> skb->mac_len until the egress overhead took its place rather than
> joining it.
> 
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Assisted-by: LLM
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>   net/ipv6/seg6_iptunnel.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..0e60bbca19ca 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -153,7 +153,8 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
>   	hdrlen = (osrh->hdrlen + 1) << 3;
>   	tot_len = hdrlen + sizeof(*hdr);
>   
> -	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
> +	err = skb_cow_head(skb, tot_len + max(skb->mac_len,
> +					      dst_dev_overhead(cache_dst, skb)));
>   	if (unlikely(err))
>   		return err;
>   
> @@ -255,7 +256,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
>   
>   	tot_len = red_hdrlen + sizeof(struct ipv6hdr);
>   
> -	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
> +	err = skb_cow_head(skb, tot_len + max(skb->mac_len,
> +					      dst_dev_overhead(cache_dst, skb)));
>   	if (unlikely(err))
>   		return err;
>   
> @@ -351,7 +353,8 @@ static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
>   
>   	hdrlen = (osrh->hdrlen + 1) << 3;
>   
> -	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
> +	err = skb_cow_head(skb, hdrlen + max(skb->mac_len,
> +					     dst_dev_overhead(cache_dst, skb)));
>   	if (unlikely(err))
>   		return err;

Overall, LGTM, thanks. However, I think we'd need a v2 with the followings:

- use max_t(unsigned int, skb->mac_len, dst_dev_overhead(cache_dst, 
skb)) instead of max()
- apply the same changes to ioam6_iptunnel and rpl_iptunnel (all in one 
patch is fine)

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
