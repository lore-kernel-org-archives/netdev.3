Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742313;
	b=ARPK+HUARQDxA1tOuAPap5LEkb16BDfPmMvhC5njiNUUFgIxCpsay6P3InMIzbKa8daA
	 iqzTh11pU5yCueGrUI7Vh7Sn5UfuMqQBh2Tf9YgOp8w+T+H0DUwzHB5T1Fw0BAk+dzUI3
	 9wyZ/SKISYSnoZdqD77lPhARv+DZmRmpWBq7bi1XFAto5EXH/v6J5n+fBP8I89WHbRwJ0
	 JFrmoxxNzNsN6sa+uGcdQAgLkGDgx/I1VqECbGFCv/xRc9hc2QBY7WDS6OC+odenlaSli
	 1Rtx7LDY03lN9xUo3cl0XaBZBZjANGBjSu3DktBV03t42rMNC7TgDJ0x6PC5Bq8VEoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O+avdGunSth2prLtklqUzo2JveavBUeum6ierbVZfg4=;
	b=lWweEJS4IqQYIf8H3E9wBKxuDTlzOeV3dWRV5wTp6gFkw9BSBYvKhX/ef9hgHSF0Mtyj
	 mr8RGeeJGEJO4kbSHPLE/jsJyumGZH88ult9bOBJ1coV9goqj4e/khZvjDjmpZ5PR2rlc
	 lYnvupo45wByUwCMhS+S7OyRfreOoIc30oKsHZKbW0nlWVVy3MiGsO8mvKpQA7+E6VPFC
	 CSjDbUSu59Sjug3lMMTCATtllPpWXHjSsGiOH98x6nNKcRFOuy6Trb8U521ZqIOxPi+yQ
	 hAYo6RWf2BPXHcj4VBgnoF8lb/Wn/jb5oFpFVniScVWFU81a5zf5VKgvdkGTNkSaTQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Pta7O0Fb;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EF606A339
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E5EF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Pta7O0Fb
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc147d86bebso852856a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793742306; x=1794347106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+avdGunSth2prLtklqUzo2JveavBUeum6ierbVZfg4=;
        b=Pta7O0Fbv8w0e8LBRL1im8Q6uNXDtuEJIxVyW5IqEevEXa+Q1M2ZkaaA8t6UYpT/uw
         j6upPM7yggUu5MMTieBus01I0J/3rgB+FvADMK/lys9TM3/oMUmJU0EoE1M/YKS9bAkP
         ISauA7l/y2UUh8NGwfoNpwt2LAfyPUKaeujslHc8RY0xU69v+vhnbiUbOiYjJA7z8kJB
         wPOYTLpIiabkHMcH178CcxVm/XgnaP0yc0zA2r6+gCN79DmEYq3UmNCnPyPFxYy+Zgx9
         ifVZos1Aj3UFvx+jEGhuuiMiMiCbX0jbubaUh4+J+qQrc6launIT8JRbUYdte1xVv5Rp
         vOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742306; x=1794347106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O+avdGunSth2prLtklqUzo2JveavBUeum6ierbVZfg4=;
        b=lWhu5Zabb69JovOfnkINUxM7DxPmCNT7vvIorUDrmmfVebXWyUJGNGb3eQ0iJd+9zr
         y2MWxv9xDoPwuYMYktUIiEjmPnER0e3sQEv+8dx8Ton453+/aXusiWWF24sXrkDqEUYQ
         lmvBJoR4xvl1TPiePlODNflUq35gC2X+EdQbqQhDKV5pyWbC5FIGJ8Cg6WxogAQRGz7H
         v/ousHgOcqcDKwFvsAK2aH2AKkc0YjLtilxfSXWeI/DCYRxPxOb5c5kxTnwWXmI+dnCF
         jt6sp20uGuxGhFTjy2PNvi7IuRcYYRe3umcoKlkrkJgSZCTX9n6zX/fGGiy3K8d/vUBl
         8g+w==
X-Forwarded-Encrypted: i=1; AKwUvBzuRTUkIVjL1Z0IwCJkvyhuH9wcGyjU/cWq2HcTq1sQDZMOzFnz8kgnvghB0uKANjaFupRM3Hk=@vger.kernel.org
X-Gm-Message-State: APuU4Z82p/IS664ewcca716PMe2Pm/6G5lMHj9Hb/6DYQuqB7igjFCSx
	kna3iHXDe1BRP1LeRoW0c1K34biw4VeCdvWFSB6UeANcd212gs/iiTGBUv7+2R2dw6U=
X-Gm-Gg: AYBFou0JXeNn6mjCBY13Fg0hXnet0c8yRdQ/xzLJkyb8ghebYil9RF8TqYxSfNFsp3i
	VZJLCgdXtuwVMZ2ahVJT0RnCQwy7XczRVewZfK4k+KsPQtYD1TACvvp7g+HNH6zVMIRRohBU5Oo
	RV50L8md6VSoroIXAXFs/nlEs96W1ewgfnCOdVjfezT+x5oEs/727p30DVSVq5YUlrKK76dv1Ux
	lsM/cgDQK2G7wqqFdEi6qiVmOblNm4Ulhlv5XoAjtXbFZDIvhh/aP68095ZcRYad0rkMlIzha4s
	guuIvyt8DJ4Q2PxYMwTOcZKVhJR00ktYt1vhySVWfKDb1Bc9MY829oqGhcJ++Ne9kRqXEYsVeum
	eQEREv8aEkb3nNrDoZ1vmMyap9yjCjJCqX8qPQvspfzgECi+/6i5hr5LJZ83pS2n1LsFWmLxhhO
	nXpglZrMvgw9eXjG4tD9OyzFt8CCtUVq74s4m1TV5OvRbEtMyvOO+LQHKe2A2ai3y6PSP3aetg9
	xMtv5lGq5NxKLKsiiBF0mlWrnNn1xDnz0i02umwv+S+kR2QPhmUCNTqHltv1U1Z7GPO3sfCJqQK
	m196b5O0zWPYan2yFXL97ixqwG1XkfWlkvlE6/m/nr3WlZLfhobXClQv74VDSGQ=
X-Received: by 2002:a05:6a21:3991:b0:3de:71c4:a22b with SMTP id adf61e73a8af0-3e928634704mr8781404637.1.1793742306503;
        Tue, 03 Nov 2026 13:45:06 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b65fcf5sm120759b3a.41.2026.11.03.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:45:05 -0800 (PST)
Date: Tue, 3 Nov 2026 13:45:05 -0800
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
Subject: Re: [PATCH net-next v4 1/7] ipv6: treat a negative optlen as 4 in
 do_ipv6_getsockopt()
Message-ID: <aupV4R2eAVlgupXZ@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-1-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-1-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:00AM -0800, Breno Leitao wrote:
> do_ipv6_getsockopt() reads optlen into an int and never checks its
> sign. Most of what consumes len compares it as unsigned, so a negative
> optlen reads as a huge buffer, and the reply depends on the option.
> 
> The int options clamp it to their own size:
> 
> 	len = min_t(unsigned int, sizeof(int), len);
> 
> so getsockopt(fd, SOL_IPV6, IPV6_TCLASS, buf, &len) with len set to -1
> answers 4 bytes and reports 4, rather than failing.
> 
> The other options see a huge buffer. The sticky options reply with
> their whole header, IPV6_2292PKTOPTIONS writes every pending control
> message without a limit, and IPV6_PATHMTU and IPV6_FLOWLABEL_MGR pass
> their length check.
> 
> do_ip_getsockopt() rejects a negative optlen, but doing that here would
> turn a call that works today into an error for a caller that passes an
> uninitialized length. Answer it as 4, as the int options do, for every
> option this function handles itself.
> 
> That leaves the int options as they are. The sticky headers are cut to
> 4 bytes, IPV6_2292PKTOPTIONS gets a 4 byte control buffer, and
> IPV6_PATHMTU and IPV6_FLOWLABEL_MGR fail with -EINVAL, as they do for
> any other undersized buffer.
> 
> MRT6_* is dispatched earlier and keeps rejecting a negative optlen, and
> the netfilter fallback still sees the caller's value.
> 
> This changes what callers that pass a negative length see. It is a
> behaviour change, not a fix, so there is no Fixes: tag.
> 
> The conversion of this function to sockopt_t builds its buffers from
> optlen, which the standard helpers reject when negative, so the answer
> has to be settled before that.
> 
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ipv6_sockglue.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Joe Damato <joe@dama.to>
