Received: from mail-ed2-f30.google.com (mail-ed2-f30.google.com [74.125.228.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22453518125
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028480; cv=none; b=D8OVOw1Gfi/Rpuc9YPRf5kA8hYxellobg3+wgQcGeQ8Sv5xnBVWbsx68G3B8oDesKJO4WPhEaeHa273JXwHVYnqqt6e/O2J1aZQZw34dcLtuv421MhyrkbOge68Sisp4mn8SAY8PQIcq+5mZltFLJtoRTn4VG8GC6k0IeVqFmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028480; c=relaxed/simple;
	bh=ddn3hw42wG26XWdsFpmJBgiUOAHN1Wosbj+AD/5UoQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX4wH/ngv+rvDlir4u8Z/TKek88PK8LDV8NdK/5l99ZZQ5OUrU65astmeL1cXaqcxRaoqR4YtJ3Cd27FsJbXRsVb0QnU/ADDMO0MkzD64LUtaOLNAm9oRa1xYBNZseMdxthxMYZ9H77Ub0+QcNdgEFgBv1HuTkFHgX5KXyts0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5hdUmUp; arc=none smtp.client-ip=74.125.228.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5hdUmUp"
Received: by mail-ed2-f30.google.com with SMTP id 4fb4d7f45d1cf-6aa06e51bc3so5719105a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790028477; x=1790633277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1pgNsBmK2/dFKUlz3XZGd+vlj9HEQ93howCfc/y5AE=;
        b=S5hdUmUpEolJFbB9H0nwC75SIF2fFegeM/odLBRgUfeB+/5iMrVZIffDL3DW83K9Np
         my9cLVhpyEZH3cvwaJj4Qqc/2hGOD/sPn8yxc5s3TVNA2JcqXjnNOyhxL56KRIpkOFuz
         G3tQsrEdO1StXys0UPjsIZPYJL0OXf3P6N08qXtL9uAxNOjjDtcngCd5UudGziraMP8E
         GjiGaKRLH0d9rlWzAf2jc0rVoaG3vCuFeoqhLO3usIrg6g+t9VbM6D3qOkZeLAMUgT2W
         QykGWtj8d7eZqn1BQQ1f1Rv6E9K/Bkj213yPD2iA3Zq0EhkdHBmC02JjMdIQjAczA5jl
         BP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790028477; x=1790633277;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1pgNsBmK2/dFKUlz3XZGd+vlj9HEQ93howCfc/y5AE=;
        b=jCkqZdKFpZ8XZImPEKqfYMv01a7MwZOfDLbVK+rl5JgYkxwIS4j8kKtTyfPVwQirK3
         QRu9bre34PjshHigcNtXwujPbZ8OplOFjtIPVjqRRb9IDgo+K+6zBNpzwRCd87Pd8LHK
         Wx/63TlTnQ93xC70viNDBee0GKvht8eQ+kdqkACjDXWabJ9jcX/I4bin9ko1+S0hsr2h
         HHatMQ/HGMjS6TI2/pL6UzzOq6wZJqwr2VhJh9jEmPHRFkrkuuoxrQ8C0jLrmRYsYbyr
         aEHVQM06D2c4Ezlv71Gk0mg+sr2g4GZJt4uycKLAMrUSDoL0H6FW4LE25s2v8q8+mcJj
         ekHg==
X-Forwarded-Encrypted: i=1; AKwUvBzI/RGKhfpymLIe0EYhWRW72/FnxFKKie5pw0soXk5VAGksKEazwcgw1X/q7Wr/zQAMVPEkBsU=@vger.kernel.org
X-Gm-Message-State: AFuF++lPiqOHafnSB7UvqGSWzTwoMQuRuuBvjmAtTzdzD+LStlx+eJgt
	e5EbNPu+8IacqXyjxe5uQd1qVuJEd0qgrFRtdjOvQxspTYkPsgyps5aj
X-Gm-Gg: AYBFou1Y7HKquJxU+XUBN/h+FY7n1n1xFRcMeF+IZIshu7LHl4WKgHz0m7plSNiKk4S
	iHjj359yzMNuiEvfXfDjs4zzms42Ot1Sem2vLXVaY1KmbyBdClk40hqpzUa7q4PRj7AY3FuKX4a
	kHFRIMVFYNeVbK/vHh4TPuyVrX0aWeGQ85ZWGUMFmMosioW7Q7Ju6WDC/SmoXynfoqpax1sABkz
	5VQKeNoythlw0SdVxJvGdveziHMKLsNnu1Pkt8H9aEUU0WhtcRSQXjxKl5xy7oNfhd9g8g9WcvI
	dRt+sK+y9b/hmfHfbBIoNhyzSWX5K3mR5vWjEneNJYKtFu7YXR/Tpui8axhA6tpK9ku6nZdQqEB
	212JEuflqa/KHVEJSY6otTx8XVc5fpwZtOyL4mGiGYiP6CJN8vsv5Tq0nt7ZIhOvmmBRJ9kfvaF
	RNCtsWaZFjKHcW49JdIOaC7ORhxKT3R0VNz5TYJXlLuBOwqHW41eT2k2h5ZT7zNw0lYEUG1rfGv
	EEIc1u4PIXPIwBNgmt8D2NOz6yYlVrD2TboMh+sAGs6hUQco8M8
X-Received: by 2002:a05:6402:24c9:b0:6aa:2:97b5 with SMTP id 4fb4d7f45d1cf-6aa56890b40mr7853797a12.32.1790028477306;
        Mon, 21 Sep 2026 15:07:57 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:f474:15bf:74b7:bee4? ([2a02:a03f:a75e:9a00:f474:15bf:74b7:bee4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa0f7bfe8sm282195a12.2.2026.09.21.15.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 15:07:56 -0700 (PDT)
Message-ID: <6a083020-71d5-4302-8eef-af4c99d2ee81@gmail.com>
Date: Tue, 22 Sep 2026 00:07:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
To: Hui Peng <benquike@gmail.com>, Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, Simon Horman <horms@kernel.org>,
 David Lebrun <david.lebrun@uclouvain.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <aq-E5MPYZS5s9_bk@fedora>
 <20260921044025.1535982-1-benquike@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260921044025.1535982-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 06:40, Hui Peng wrote:
> In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
> .len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
> maximum payload length and permits shorter payloads (e.g., 0 bytes).
> When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
> kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
> triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
> skb->head memory, which is stored in sdata->tun_src and leaked back to
> userspace via SEG6_CMD_GET_TUNSRC.
> 
> Switch SEG6_ATTR_DST in seg6_genl_policy to
> NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
> validation rejects any attribute whose length is not exactly
> sizeof(struct in6_addr) with -ERANGE.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
> Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
> by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
> succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
> uninitialized kernel heap memory (tun_src =
> 836a61ecc4d25a1042a8d60411cfb378); with this patch applied,
> SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
> -ERANGE (-34) and tun_src remains zeroed.
> 
> Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
>    sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
>    NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
>    length, as pointed out by Hangbin Liu.
> 
>   net/ipv6/seg6.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 62a7eb779202..8c2b156c227a 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -138,8 +138,8 @@ void seg6_icmp_srh(struct sk_buff *skb, struct inet6_skb_parm *opt)
>   static struct genl_family seg6_genl_family;
>   
>   static const struct nla_policy seg6_genl_policy[SEG6_ATTR_MAX + 1] = {
> -	[SEG6_ATTR_DST]				= { .type = NLA_BINARY,
> -		.len = sizeof(struct in6_addr) },
> +	[SEG6_ATTR_DST]				=
> +		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>   	[SEG6_ATTR_DSTLEN]			= { .type = NLA_S32, },
>   	[SEG6_ATTR_HMACKEYID]		= { .type = NLA_U32, },
>   	[SEG6_ATTR_SECRET]			= { .type = NLA_BINARY, },

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
