Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428D3DD525
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539573; cv=none; b=C8z2ZCRwBmDDKPE/R3nRmQT8WffSMxYiF4gFDRvJya9GbHismilHLbBA55wO9xuD+uX5KzIhvs0zAqV/qNkuN1kVzBJ+aKFArjYZwiosfyBnjRMSbVvsFkfR9O53XcofwlDNh4g7odhTin6IoneTKW8q+kp8J1jFEC4Bjj0mrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539573; c=relaxed/simple;
	bh=1er2AwOtW+Q5pN+4saTyA7iFWqAVhtkHRfcGy0PqazQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMpbnAJoCNQLVWQB6lOS4qWxeelhsusB7RGtSDDADq00ijbwmMozRzoYm2h4inz0D0SkIzGl+LAeNtmItk7BclJ1ar4WJ1HA/t16zZrP6e+ewAWJ3vudchwpeNfvbToQjKgSUkoL8Zyb9O+RCppgVVa5ZAkP5AnBQNwwR0U+MCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VC5m23L6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VC5m23L6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956242332dso3059985e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784539567; x=1785144367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f4Q/SpXFodA4HEULFpbuDXr3Dy9TdKlUl0euy6i0Tv0=;
        b=VC5m23L6zpF3/di/2ilQvdYBpCH4i3+bcDCZy3/952LQKiGfwM06fwcH0ZZqxFSWMu
         +jeF79HvL3n2OEeOtKb2Ms5JoZs00pPw5SC8DgzSzRiNN0Af2R+zlbQBBYmQwdGlzGS2
         TL0eOJXkWL3FtFVzzL6gw8LywXR0zqX7NVSxyUyp+lc6HkX5ND8rbEqzHt78X3uwI8af
         2d9c7/AWsiCrnBfPlCpDAnZlfpBc9jfYFBHhWzafUPF1Psinx5DcD3O39fI2QLzBMvUK
         KT1vefO4KfKMJUZo6fET0OgPJ0Vov+d4TiSDlYLIkjI7QbnmHpyZJs5yQ0RXLr/O9T9D
         z6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539567; x=1785144367;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4Q/SpXFodA4HEULFpbuDXr3Dy9TdKlUl0euy6i0Tv0=;
        b=T2YUzYgCyG9UetPQPOFCJlLQWGQSFXfieiFepFDWURn8NcXfxEds7+XJvmVqm/tsEx
         Eu0jfLQ8QO8fHAoaVmfmPSDqCqmntxcCYJVUNj6yC60oT235ed7C4EGYaxfibCFLxRLa
         U7dgIT85FLys571riDsN8hBEYhpnJ+157KnGCENbb0EAkJh4H3hYVsgU6V9E68EAb70n
         0KN9pIuHRkweu6Amxmkn+RcqL7e7HjYB1E3kP/mMEdqp+9pMoVgYsyal3ntvwncVlywp
         1YMsIJSG5SQHkDwoQiE2XnZRLs3lTOdo68MTMaiscIkh3EY1YlqxHnu0s5Tcu7K5Ou4Z
         dzVg==
X-Forwarded-Encrypted: i=1; AHgh+Rqo/i2/lrdWmhoPth6/niry0kqTt3tZ2ATrk6UDYmMLGgHhgxjHpSawvaWuH2ePKPnJnZ/pU6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5C5jtMBplpSLLFsa3clO0wt9WL9INGPWelrDhXtj74qH9HvJm
	PMrKY0ETnpvC+1hXW3SwHNm4cQRnGBOrcmj2MWkNtEC5yQPimXjWEnkYyLf/FIl0DKw=
X-Gm-Gg: AfdE7cnw21xC/CyyF9o0mlJGl5plXT68Kia87lofpKXVDcO8CJS1Fwlybbxsnp/zI9T
	+SzKZjqaKrU79v4OJsCW8a6UQ+Nyqpce8qIBA54+G5lrKqQ0L37M58F23llLCXvlB+jxVj6uFHC
	c+87gdcZa8HNF8qGmvsFWF5smfLsWPXBhjlb53KiGZwNA9m2lEVNXbe1MoRJqRjZohJdSUn5giv
	JIfg7xZF+LGxV2MJbkgB7HgFNy/tGAapr4h9lueh+Gty+wbrc1bpiEsAK4vnGPO/P+C02OYVuvE
	rs3g5q/zd4BWNou8gK8mhjEsQATJWrHz8BYG8nqWhn7OccBQIWEzvLMgUX4wlBM8xdpRitNwIal
	grIIi0ldd6f1SNrDNrd1T+R1zcKzV5PpTvnQzeV3nkfdSUi9nTxGtCYvdZ0AGyZwdFCypnXo3Q0
	TpSbRycuaNKLjliGQQLVQ+0fMJSS4LKU+Xn4EOfM12yq4=
X-Received: by 2002:a05:600c:4687:b0:495:4df2:7412 with SMTP id 5b1f17b1804b1-4954df27450mr119179575e9.32.1784539567008;
        Mon, 20 Jul 2026 02:26:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e83ddsm256560825e9.10.2026.07.20.02.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:26:06 -0700 (PDT)
Message-ID: <27d8e26e-3498-4741-949a-742d057bbcde@blackwall.org>
Date: Mon, 20 Jul 2026 12:26:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] bridge: Linearize skb once the ND message
 type is validated
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <c431f129eb438c12ef1e48d91039e09489a8f862.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c431f129eb438c12ef1e48d91039e09489a8f862.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> br_nd_send() parses ND options from ns->opt[] and therefore needs the skb
> to be linear. Commit a01aee7cafc5 ("bridge: br_nd_send: linearize skb
> before parsing ND options") ensured that by linearizing inside
> br_nd_send() itself.
> 
> Move the linearization up into br_is_nd_neigh_msg(), right after
> ndisc_check_ns_na() has validated the message as an NS/NA. This makes a
> linear buffer a property of every recognized ND message, so that this and
> any future ND message handling operate on a linear skb and cannot
> reintroduce that class of bug by forgetting to linearize.
> 
> Since the skb is now linear by the time br_nd_send() runs, drop the
> linearization there and derive ns from the transport header set by
> ndisc_check_ns_na(), instead of recomputing it from the network header.
> 
> If linearization fails under memory pressure, br_is_nd_neigh_msg() returns
> NULL and the packet falls back to normal forwarding rather than being
> suppressed.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 445c930ed59b..46779d9fad61 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -240,6 +240,9 @@ struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb)
>   	if (ndisc_check_ns_na(skb))
>   		return NULL;
>   
> +	if (skb_linearize(skb))
> +		return NULL;
> +
>   	return (struct nd_msg *)skb_transport_header(skb);
>   }

This one is a bit weird - I wouldn't expect the check and validation to also
linearize the skb. I'd rename this helper to show that it also linearizes the skb.
Other than that the patch looks good.

>   
> @@ -259,7 +262,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	bool dad;
>   	u16 pvid;
>   
> -	if (!dev || skb_linearize(request))
> +	if (!dev)
>   		return;
>   
>   	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
> @@ -276,8 +279,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	skb_set_mac_header(reply, 0);
>   
>   	daddr = eth_hdr(request)->h_source;
> -	ns = (struct nd_msg *)(skb_network_header(request) +
> -			       sizeof(struct ipv6hdr));
> +	ns = (struct nd_msg *)skb_transport_header(request);
>   
>   	/* Do we need option processing ? */
>   	ns_olen = request->len - (skb_network_offset(request) +

