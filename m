Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747236;
	b=TUkzELSd7mcUUlKMMd4O0VYNo6/ISH+Y6lfy2STbNbw7fl1pGx2SeSidmdYjRhl6Pmi8
	 9UOOkRR5XrNzc28o0V2DaIBYktH8bigje10lkSYQ26CDNN/dr3S4uz2gWRj16KW5X8lyg
	 XoWy8OfFpL/GEvVYhrmL8lkUD7hzwsO8++9tWZjCUiEQaVhdNGJG98eIB6SpQYQM98AZE
	 6tre6X+1XLx8ogQ71K6scqP4ajTj7hrHuS9oiyNnPd8sgCSVGmdh7SumyCG1tHtAusBV2
	 +si90O0OyX57SQuNbYuOms6HkBh1mfC0NOBx/ksZ/BILrlhIeYRY1JqBRiIUtrj4NLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NEFwsaly/pYEQSMPZ8dIr6fdqKf0QWqwNabPuOPmqrE=;
	b=wYhETDHnsCtqon8lTc7KuBdWAhp6JCeXsC5tryJim0GN2gRJD+9/8EK8EykHvpghYq+b
	 0Q0y3t/whdco0zp+olpFSkuZhjPmqz6WaFiPOBzC3Z5tJsWnWtwdLMibzGcT0dwn5akwF
	 yOOs3CJE1lTlbGBma3gDgV419PbmBbmNH8B6VVy1B+Iqopn7twx748yotM/IA4RGWUZIS
	 N7y1zpf+fTFLCyMxV6LohDn/Zr0egJ7qSi8cw9raI6O0t57ldDTO4Kt3fejgIrAJvylPd
	 b/r4e4GK6PjSOSci6699vcz3kmWgSEsQUUZ1loI9I1N+aRe5xNlcGvxQiNah6DLSoBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F1hoXgMf;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96C606A32D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A96C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F1hoXgMf
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8fe8e343fso289305ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793747235; x=1794352035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NEFwsaly/pYEQSMPZ8dIr6fdqKf0QWqwNabPuOPmqrE=;
        b=F1hoXgMfAF0/YbEteRqywfhn3WDCOe4J+F7YsQfU+D/3o6FmVI2GwIO0WaM1ac3baR
         35ufkik72WxSbkFRY1fRv5bpxm5vqEkgCD3Ry3wd3KX4fSQ5h3k1T6JTywj8JW1BiUAN
         BJDk/LfHH0wjrSawD0qSpmMjDcJHLbrEs0pX7M6rHzXtfw6544U58ogzWEn0XlTP9WNI
         PX70yT6wNU8OUsv6fQPZ3psN/mJhhv4Al/IZiqXWsFzrMdy63A6V/Vq0RQBoDoDCESwX
         He1opzYj99jkXpfmO09oP2DTaQHyfTbXm3byGlSEnla8MbyTnxubrAvL/NdTbb8kIoEE
         65nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747235; x=1794352035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NEFwsaly/pYEQSMPZ8dIr6fdqKf0QWqwNabPuOPmqrE=;
        b=LgGcn+mJE66SzZ/Gmc6d0v3DLr9yfNtmuPY9tL6y4sc5ssB+L3jLnTle+EQE2tZF5G
         ZkIlxuCxBU9HmkZkhN3s2IAmRSIdeOBwG9FKQ/kV1K4odysiVW/Zi6It1w7F+MmNxDKm
         iTqrIeXCfJfc1g3GBaa44FKUQ1NGKnCrS8VvWL20P8BW9JEu00zYHplOzFEwJzxu2aNm
         lNjdyOjcVC8or/Q1LtFRSUQZA3l1f2U/YFtFARot9LvEoCTzGAh8xfISaLM1VCyheMGt
         Y7IZqhR+RL4vb/Ar20lDSNG9hB5RlZLjNr4MTNMB7FTaAuZPcPoV3S35cQ7S2Q52Hib2
         AD0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxG0xjGJjSh81ktPmZzxUgLaYIiQpqqGByf8xWeyr+X3P1axUuTL09TxwpSuZ5DYLj5Z84V62Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HwensTPu1/YV4v6cD0b0eYRQ/r/1xlHY7e0yMa9D/kWMnn/FT
	HZTxiK5miNUJrruAsfVQKOL5bR1cRGnU9/PCzTp8FegLDtnJ9Hz+Epguf6PYX6WGNjo=
X-Gm-Gg: AYBFou0dmij7ZnmhsFYYODs06HgHYVsrVRCUKStElWzitu0dXhe4K/u+LPALE7LUqBn
	4bIDbIxZneWyLNPHxVcKyU1Brw1yeHtMx13rMiBodT2HJBs7s3aYJbvdk7CkQz60B6fCQQ+YVgH
	KMYieB14Ia8w4UWJEzhHr1U7F89UcPYbZX1VkIVEDtH8Wdxbu6Ln77qE4bnJh1ggamY/8yvFSkM
	3L1T33PD/2C9fCKZw1BBXJrzq/Q+XpPw5f/0Hu15N3zu5sQKvD59WTra0kuk9t4U2HHh6uzBqBQ
	jDLelkBTj/e5sjpMR3ZSaq7JREc083Z7zc1M58nhJQnCKYD+r7R1Evi1pgD7i9FdMLqtDHct7gp
	wRWE2eKEfiaVUDpWaQPaoDST/k+V8dp4SNSULwPlSW8WDAhmu6d1DthRTxP4di4gcQ+sSmEGwrg
	bHiv00Qrd8WOImWNH6RxrH+BrWMdo6Rrxhne/d9AbHuud6eUotS2uw61EbOTxACInjs54zkw83a
	cnDzJSZBvrDvaVR9xY1oFBwnxJnIQ6MKJkSScTQOvnBARat0TghOEARQU5coRSC1kwRABtoPrGM
	EaFYsxHMXAAyJ0sxVdqpB9zDw0jjwcYVFi6mruKyyg==
X-Received: by 2002:a17:90b:584c:b0:3ac:fe93:a731 with SMTP id 98e67ed59e1d1-3ae8981e640mr10743037a91.56.1793747235227;
        Tue, 03 Nov 2026 15:07:15 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46444698sm276077a12.4.2026.11.03.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:07:13 -0800 (PST)
Date: Tue, 3 Nov 2026 15:07:12 -0800
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 5/7] ipv4: convert do_ip_getsockopt() to
 sockopt_t
Message-ID: <auppIKnm1NvzBIzH@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
	kernel-team@meta.com
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-5-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-5-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:04AM -0800, Breno Leitao wrote:
> Convert the SOL_IP switch and ip_mroute_getsockopt() to sockopt_t, its
> last leaf on a sockptr_t pair. The IP_MSFILTER and MCAST_MSFILTER
> bridges go away.
> 
> ip_getsockopt() builds the sockopt_t with sockopt_init_user() and
> writes optlen back unconditionally, because IP_OPTIONS and others
> report a length and can then fail. ip_mc_msfget() therefore stores its
> length only after its last copy, so a copy failure can't report a
> changed one.
> 
> The write-back also happens before the netfilter fallback, so an
> unwritable optlen turns any error into -EFAULT and skips the fallback.
> Likewise optlen is now read before the level check and the MRT_*
> dispatch, so an unreadable or negative one wins over -EOPNOTSUPP.
> 
> IP_OPTIONS with no options set and IP_PKTOPTIONS used to return the
> result of copy_to_sockptr(), the number of bytes not copied, so an
> unwritable optlen made getsockopt() return 4. They now return -EFAULT.
> 
> sol_ip_sockopt() builds the sockopt_t with sockptr_to_sockopt() and
> stores optlen back as well. This extra code will go away when we
> convert sol_ip_sockopt() to talk sockopt as well, but for now we are
> converting the leaves.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/mroute.h |  4 +--
>  include/net/ip.h       |  3 +-
>  net/core/filter.c      | 18 ++++++++---
>  net/ipv4/igmp.c        |  3 +-
>  net/ipv4/ip_sockglue.c | 87 +++++++++++++++++++-------------------------------
>  net/ipv4/ipmr.c        | 11 +++----
>  6 files changed, 56 insertions(+), 70 deletions(-)

[...]

> @@ -1711,43 +1707,25 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  	case IP_MSFILTER:
>  	{
>  		struct ip_msfilter msf;
> -		struct kvec kvec;
> -		sockopt_t opt;
>  
>  		if (len < IP_MSFILTER_SIZE(0)) {
>  			err = -EINVAL;
>  			goto out;
>  		}
> -		if (copy_from_sockptr(&msf, optval, IP_MSFILTER_SIZE(0))) {
> +		if (copy_from_iter(&msf, IP_MSFILTER_SIZE(0), &sopt->iter_in) !=
> +		    IP_MSFILTER_SIZE(0)) {

The line wrapping is a little weird looking to me. Not sure if there is
anything that can be done about it and not sure it would be worth a re-spin
just because I think it's a little ugly :)

Reviewed-by: Joe Damato <joe@dama.to>
