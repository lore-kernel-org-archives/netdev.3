Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9024499BE
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514462; cv=none; b=Ct4l1//1kx+zSYYdgmSLkFfTz4FuQ+YVrbMt2Pdi2+hrK+lzzt0zHNTPmCsWQ1YOKFfVzTTVpzCJ2oC9oiJq57wdZ8DdmybSnVJB7FO/sFZQy8W6PTWf6g26fhfjRckL8zJEnirXRTqNIGHuqLieH5K+/5obbtc45gMawK3ZsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514462; c=relaxed/simple;
	bh=5JOON6ugIR1d0E8GVuOUtOJ3ZKqEXg05GE7/ZQCPswQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgANPcCBbUyMUbqTgii+6auGL7N3zFcVm0xQIc/zxl6oeQuY1bV7wwxTsbbUtUsX4Iag9nCt4rqjVLAHin0d0qrCvT3I9P5g7VnffeB8hHlLUwiEO4fsSoJHUoDcraUBr6NaJkDsu6SKtLEqD53uOqS+AcHFD4BKo29nGgKOZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQSwsN4j; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQSwsN4j"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-caf45fc5202so731902a12.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514457; x=1786119257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARP06WocnAfqnx38wlDxcCLXWFVWx/Pmv/oo2KGc88Y=;
        b=mQSwsN4j+iPqK1SZXszssvWrdmhQznA/7W3S9fp8U4Hry/ph2QHPOG7UXwrxbjWM/M
         zG/oG9FoFwmvvrC2lcwEclq5o0d4+S6fAkb6uvlHHS231qRdi2GLz1vQVs6erN8SNPPP
         OvXM+nKv1SkISqIlARlEpKCxmuiEP/3OoGZIk7IeSUNR+aHmODDwaIv6K2PGBMIJFiq5
         ALvxLtAmGe4jKnLSwMsRUsZ40vgDHgkP0uZDrQNvWkn7+kBHe8q2rvAwufm9SVz3qIqU
         7PyMMgJpegkbscWILnXQUi+9pOTA2AQ8x9tYRHRmAg7SHuBLLYpBb+gBVrlecc8PzwEi
         F5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514457; x=1786119257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARP06WocnAfqnx38wlDxcCLXWFVWx/Pmv/oo2KGc88Y=;
        b=Uz03wBy+CtGXkdd67UBdUmq0U6gMIV9fV5jq4zDgX84CWEoWpSKIVTrr5bKaH7qo0e
         ifaO2E7LpbkAwlqJohK05z0kJG9/sIL+R53Hg33SPxvUyvmJ+84hxyTIX1ofKviHM++o
         wButMWsemRzg5kQh71aVt7hqaFR/Qg61NJln9eo/icpj9U7MLnxgjYPYlbXGygLzQaS6
         XRltJ7Qo32jS4SPCbAsIFhEloD647AGHDMj0oXXklJEQp3XKZ21oIWvgZAHzLfz7Yh0k
         AhuehMcEAABrqGbpjQN1n47la5dgu2h1dI1Qau0yN9GdvNktzXBZZeXeafCCeVhBaA34
         HJfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqlb0TrpsCA4ZRv6m5x1IWKnYLk/AqCm8gaA4L0/veSJG3WWx8SNpKzgZ/TsDn+clwaRqyLfcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwaZah8NynSHZO79BE3YMkk9GmuZN/kK7yci69Sf0CYVov6S90
	YFADaK/zUjKDVsIu01FEdLMnYB4yEkLBWZdyL+567xpDY4smGtvVKaGs
X-Gm-Gg: AR+sD10Zs64zom9gW6zYhKXw/WqH9baLlVK5naA985kNKEJFHACZ2dZk0v63TXUo+jQ
	D3SmSt0zSN3bzl5RewRma7BollqJi8Bh4YT2Z6yb/u4lESNpJN0ud9mCyOA5FniE6RqG5RKBu3+
	CuCa8xN11UWDL0xCMPu/hOlUybpd+OQ0jvBX9BOiyYZCUSyFTU9elxKLCFXxSNCeAJLz26532N+
	y5KCSfgviP+ptEws+dPenkyob4RzT0qULOzCF4ynk4/trZR86zOKd7cSWXGa3f8eryRQT+y7yGm
	iMVz4ANeapD4z7jfwQrlUF9/d5XOGNzQIYWvEOucW3z8mNTDKHqdcs7BZqrQAvhA6Dpj/xA45BN
	GyO23LieCnPNKboJQo+5G7Jddqqesnckz+4dGfpVMcvqcfZmQscPG9UilmePPs4u1JUlUaPpmGY
	SrIwtf29ZCXKsAI8UkE3oCKp8GLEAUbPUWMAEiUVCr7QSwhGzce2bA5k1iY43HdedigXskbonXB
	ALp3mmrylFf5St0zePzMcnTX88Tfaf5S+rAWwBgUQsLrCFJ/DaKh+vq2X0=
X-Received: by 2002:a05:6a21:330e:b0:3c4:3454:38a7 with SMTP id adf61e73a8af0-3c92a864157mr343544637.54.1785514457056;
        Fri, 31 Jul 2026 09:14:17 -0700 (PDT)
Received: from ?IPV6:2601:646:8f02:5350:ce4:701d:f6e3:3a6b? ([2601:646:8f02:5350:ce4:701d:f6e3:3a6b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e0700e8sm7237107eec.24.2026.07.31.09.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 09:14:15 -0700 (PDT)
Message-ID: <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
Date: Fri, 31 Jul 2026 09:14:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP frag
 adjustment
To: Sun Jian <sun.jian.kdev@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, stable@vger.kernel.org
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260731032357.6114-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/26 8:23 PM, Sun Jian wrote:
> veth exposes non-linear skb fragments through an xdp_buff. If an XDP
> program adjusts the fragment area, veth_xdp_rcv_skb() copies
> xdp_frags_size back to skb->data_len but leaves skb->len containing the
> old fragment contribution.
> 
> After a fragment shrink, this makes skb_headlen() larger than the actual
> linear area. In the reproduced UDP receive path, __skb_datagram_iter()
> copied 1024 bytes past the actual linear tail to userspace, starting at
> struct skb_shared_info. The copied bytes included the affected skb's
> nr_frags, xdp_frags_size and a kernel pointer from
> skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
> amount and truncated at the end.
> 
> Subtract the old data_len before replacing it and add the new data_len
> afterwards, keeping skb->len and skb->data_len synchronized.
> 
> The fragment accounting must run before the linear tail adjustment:
> when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
> releases all fragments, and __skb_put() requires skb->data_len == 0
> by that point.
> 
> A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
> 1024 bytes from its fragment area. Before the fix, all 10 runs produced
> corrupted payloads. After the fix, all 10 runs matched the expected
> payload exactly.
> 
> Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>   drivers/net/veth.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 00e34afd858e..348391e87e14 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>   
>   	skb_reset_mac_header(skb);
>   
> -	/* check if bpf_xdp_adjust_tail was used */
> -	off = xdp->data_end - orig_data_end;
> -	if (off != 0)
> -		__skb_put(skb, off); /* positive on grow, negative on shrink */
> -
>   	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
> +	 * This must precede the linear tail adjustment below: a changed
> +	 * data_end implies that no fragments remain, and __skb_put() requires
> +	 * a linear skb.
>   	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -= skb->data_len;
> +	if (xdp_buff_has_frags(xdp)) {
>   		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
> -	else
> +		skb->len += skb->data_len;
> +	} else {
>   		skb->data_len = 0;
> +	}
> +
> +	/* check if bpf_xdp_adjust_tail was used */
> +	off = xdp->data_end - orig_data_end;
> +	if (off != 0)
> +		__skb_put(skb, off); /* positive on grow, negative on shrink */
>   
>   	skb->protocol = eth_type_trans(skb, rq->dev);
>   

I am most likely missing something here but what happens if we have 
frags and we attempt to advance data_end while leaving some frags 
present (e.g., bpf_xdp_pull_data())? Looks like, in that case we would 
issue __skb_put(skb, off) with off > 0 and we would hit 
SKB_LINEAR_ASSERT() because skb is still non-linear?
