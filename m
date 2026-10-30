Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349367;
	b=2PverV+s8WfUwspQkJB9NhjvRecTPHE66pxNgS3mdyET8BXJ5t9Xup9ojFzQ8FLIr47I
	 KXq0WYe8R+XSS/A62mjufDgG3hY4vkXFxJDoTuiU8CCmgc2i+tMuge2jJ2hiVTCXU3fyU
	 BeOAipcMQM/QvIxNxgZfy4ILerX5zvBnJ+xyf3OsJ2g55SZmBeuRDFic+zkMrAixiSwWj
	 NU9ANx5eK2HDULhtiAeh3YS+fgZIDLdxVnuAUKOkogIw6HbrE7l1+sVlp4YSQPZ7YmoD5
	 saYy0V37a3OGaC0bAld+gSKmwI5XB7HoRGs9JGTWjcSMt3yAiJ+N9/ry/1knwcyYTvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Z/0fKFpcOL8jDtKycmBdD2w0mXmNA4E4QEafzXaEJGg=;
	b=jIxfRpfk9cBPjHuk3EsOHZRrCJ67tfXPcQtytTpI5iXSRiH3WYfyyuzo2rnUut8X3Vzr
	 fCJRI845rcUzeFJcYpor/HFchTpzjv+cA++zVmWg+zMoFHdMw/Ees4Jzer17KLwVC4MLg
	 P+dCJNIEONhLJHa7r44ILy862OvRBBZqPIYWvAFqkHpAebziUu+6+Q0FGcYgk10zbsWNI
	 eS/V63RDMvm+h2YJlGzGFdqYlCcXHFqwDIpVctRn2aAX5skkw4/yrdGIOhXhW+gacbT/x
	 AkgFVd6AOk0rNJWdoxPrN9JcqlaF8m4WHcxGiDFPJUbvhf+IqXIRvUUzzMMn/1Va7nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffueVzOQ;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FAD60A263D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 08:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54FAD60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffueVzOQ
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a2551d7b5so2030659eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793349366; x=1793954166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/0fKFpcOL8jDtKycmBdD2w0mXmNA4E4QEafzXaEJGg=;
        b=ffueVzOQGc+pangLd5R4aw3Fl2k+ml76QXYStCqWEw5twV+CeSuaV+KVA0sKWquktA
         8puoSLyQKkdrfnHQtJJ5XLEqcpyZ5+hNE5w66ch6+5n1fFVr0gCabMOXJMeMBFfD9dAK
         DUQK3t1sXXRdKuFIFCuDsjM0pxZLCoM9gKKTSNwW888ooNS+2SVc0Af6C2ZqcxkXs6ot
         SFa/228BKDnr+rC85nhUq5T1zUesyMLeAHhiFJ551QJeKXtRX4L1CUiyjaAiCjU8AYoX
         xgKn3tUpZWLbTwiYOBDmiH0B7ja+ukWNqTjZT9c7uyCKUU9nVQgWZ7XXDx59fHPrqh6X
         YPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349366; x=1793954166;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/0fKFpcOL8jDtKycmBdD2w0mXmNA4E4QEafzXaEJGg=;
        b=ERKq0bEdNbPiE1W00ua/vYGdeLnAytbapn3WsWst8EejejuvCmIntbO8n0m0gE5t80
         3Z7JmpxdW3BeMgeAHvUkqwTpnaTRRafFhlTPv6E6EccSQORHzUank+ZcJm73xpGsbAzK
         Q3matz1LxtVnGNjlKRrm9Ci+M4uCu9D6CLcKYUhZbjAIZPsWho0qcoE8xQ3fzFvmaA93
         eubYXSAj0cmXigjhkPkwm7RBm7nf6V5x03yqKl/+x1SgK8KQplcHMEjvm89fUaMX1AFF
         7k9zyAEhReI1r8cy5HMIFZ2apKAyazQek2tQ/sghxfdpyvSlfW20S0IJSIIKMOJ5+CQA
         Rz9g==
X-Gm-Message-State: AFq9FYJZUCceBZeZptDENzbXj42j7f8kOvzEt4MeHrIlZggwEnKQ3JAi
	iFnWhJjWjd9jQu8e/M6Lve9BJL7jzEPEOwDCPRXmrsawGpTk+Ky+7jmW
X-Gm-Gg: AYBFou0RZeVwoz1nAAr5Q0Uv1FCs25B3czumQaM4OwstC+xj4VNd2yIcgSJOtfXhAqf
	Ok1cuOpg7fuqUK4wbbtgh+LazRX8Tznv3Z6n5lp4H/D79WlOFkie3pMv0D+37yz0O69DGH9EWUx
	uVSLibz6kMg67DGZW1hpWjhE8C9908pw0h4/Nhya24DR+f4TA4wvB9m47a1jqtJJTgQx7y60afv
	vIoL+uhaQ+XaGR6KqA+fp/nR0VX50iftJgEb8h+G9GJb8Cd6jGRQeFZtkNN7D2YhMviOwU6ZiPw
	6byEXjbdAvCcfjQBAgfAM2APrWIpZc3LMyxsjs7va66sJOji3hHr5YxYeXBzQPO2gLnayP/Jqoz
	CM+rMnNVlFp8BvpD98oxui31AzDLSRrwgso7yJDvjYJaNnob5jc3TYX+OumB/w4oocgAljpu8lC
	0Ul/psPf/ZA8yQ8qCzndNPVrorBd70GvHRQLhHegmrq6sngp+f0T1Ibp7JPeTvugx+XAk0JDFmr
	M7VP4zJCitUmhxk//sw3v9lAHLBnjRpUxZl6LgVSPDinHla1erfdz6M9RRNlrPIR4sMF4Jw3BmD
	zD3xejLMnPX7h68xL8QkXTjxzMZe0g==
X-Received: by 2002:a05:701b:271b:b0:148:ece:8cc3 with SMTP id a92af1059eb24-1a94adc93b7mr6251263c88.24.1793349366218;
        Fri, 30 Oct 2026 01:36:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4b08bsm5936042c88.16.2026.10.30.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:36:05 -0700 (PDT)
Date: Fri, 30 Oct 2026 01:35:04 -0700
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: bo cao <treebacker@foxmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
Message-ID: <auRVazv4xBe/q0P0@gmail.com>
References: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>

On Thu, Oct 29, 2026 at 10:38:57AM +0800, bo cao wrote:
> ipv6: fix dead half of the MTU guard in __ip6_append_data()
> 
>  net/ipv6/ip6_output.c | 41 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 

The patchwork check indicates that two more people should be added to CC.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a..ab4eee51f173 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
>  
>  static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
> @@ -1499,13 +1513,23 @@ static int __ip6_append_data(struct sock *sk,
>  		     (opt ? opt->opt_flen + opt->opt_nflen : 0) +
>  		     rt->rt6i_nfheader_len;
>  
> -	if (mtu <= fragheaderlen ||
> -	    ((mtu - fragheaderlen) & ~7) + fragheaderlen <= sizeof(struct frag_hdr))
> +	if (mtu <= fragheaderlen)
>  		goto emsgsize;
>  

It might be simpler to just contain the whole fix within __ip6_append_data()
without changing ip6_append_data_mtu().

Just factor Sashiko's high severity finding into the check
suggested by Willem. Something like this (untested):

-       if (mtu <= fragheaderlen)
+       reserved_headerlen = fragheaderlen;
+       if (!skb && !(rt->dst.flags & DST_XFRM_TUNNEL))
+               reserved_headerlen += rt->dst.header_len;
+
+       if (mtu < reserved_headerlen + sizeof(struct frag_hdr) + 8)
                goto emsgsize;

>  	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen -
>  		     sizeof(struct frag_hdr);
>  
> +	/*
> +	 * Each non-final fragment must leave room for at least 8 bytes of
> +	 * payload after the fragment header, matching ip6_fragment()'s
> +	 * mtu < hlen + sizeof(struct frag_hdr) + 8 check.  This rejects
> +	 * MTUs that make maxfraglen underflow below fragheaderlen and
> +	 * defeat the datalen clamp, which leads to skb_over_panic() from
> +	 * skb_put().
> +	 */
> +	if (maxfraglen < fragheaderlen + sizeof(struct frag_hdr) + 8)
> +		goto emsgsize;
> +

You could then remove this maxfraglen check and its comment.

>  	/* as per RFC 7112 section 5, the entire IPv6 Header Chain must fit
>  	 * the first fragment
>  	 */
> @@ -1635,10 +1659,11 @@ static int __ip6_append_data(struct sock *sk,
>  			else
>  				fraggap = 0;
>  			/* update mtu and maxfraglen if necessary */
> -			if (!skb || !skb_prev)
> -				ip6_append_data_mtu(&mtu, &maxfraglen,
> -						    fragheaderlen, skb, rt,
> -						    orig_mtu);
> +			if ((!skb || !skb_prev) &&
> +			    !ip6_append_data_mtu(&mtu, &maxfraglen,
> +						 fragheaderlen, skb, rt,
> +						 orig_mtu))
> +				goto emsgsize;
>  

The emsgsize label returns directly, which skips the cleanup done under "error:".
Could this, for example, leak uarg if msg_zerocopy_realloc() already allocated it?
If ip6_append_data_mtu() remains unchanged, you could remove this change
too.

>  			skb_prev = skb;
>  
