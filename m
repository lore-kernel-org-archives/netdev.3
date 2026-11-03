Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742435;
	b=iEffuNSwdGocPJ87Cmf0ZZJzcTBNU0N6EqxZIXQVWAMO4llHXzpnkXhWIhYwdWipdXIS
	 DUu1WnEjjM9V+DPEtz0JEqpVaForBUax3i7hd1sWC2o0iRBUq8Quem9jT6wWk8LojWysv
	 CQyr3Ps6NJ4LTEZNU+nzPkMt5oqfHT/BxZfGoS76DrlJykj2U9JImp9FNYWcS83tH8j39
	 HznA3u4lOWBxBEMAKqT0Gk4qorWIMQEwpo6vvyCreWhMxQ7+1dlqibS647soIUjK/vk5g
	 mSEFFsU+Muy1GviQ9gW4fFEPPFCVBf52CKP+0sP6MQmsLingSPe1JDR2whQXf/NP55g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Gslbebf1LMvPLM8Q5E/+GJDx3HzrVAFeNFBvrSeRD3A=;
	b=ZfeWzV2olHhWHYGpMMxu3qf7zfoP2Xxf1GnNowPnLyAmSO3RzdwYGvz4IDSMYdKVjyAG
	 8dYTcRSa8I400To3R12mIk5cwpklqpw5UOaMb3MgSwNNmOyEhN1LZgazWncAQHMIn982z
	 351esqsTshXw5NCdGkcpfSoQE5cBMn/iwfi5aEZ4S6akYlUDduDL69+cm5uSvQwWKXdUN
	 hRcsvL2C4d0GOPMg8mkWEB/612rvlMLr55/khrcdYTpSljnf9eOFvm70bBcfvyhoNTtY+
	 ciDi3iTqqmdUFj/hkbibpEYyoUkhwiW/Ljv/cj6Bhy9iV0nTjQBagv4gAX5u+5M/7Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rz9zp9i3;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC37606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC37606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Rz9zp9i3
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso65419a91.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793742434; x=1794347234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gslbebf1LMvPLM8Q5E/+GJDx3HzrVAFeNFBvrSeRD3A=;
        b=Rz9zp9i32GrLsqYq1Wv4k+MOEXRHkge1QpJ7C6/aNofnyPzJwsED2mBJ+BO36t2Hut
         U/X3EX/P4yEQJBoeXN5o24QnyrjGOEkzSU+wtx5SH/xuFKBlH+Cty7/2p2y+FTtjgmls
         7I7QCjDZfxEAhev/iKP3MQSpbIsLV8Ph/6Q+DPR/n0huTq4GXHNbcfILEA1X4NPlfLj2
         ND391PjSxTHj0exOiD1aylibkcBR08bsztmT24DXhejY8LZmDn5tUiL/cjmU17IMgXiy
         Yh3kpGdUO96yk7UD5JPAXXx4ItoLfJNwcyTu4xlyq02RpXu59D1Buwn7SqITNQ1GbrHI
         y5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742434; x=1794347234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gslbebf1LMvPLM8Q5E/+GJDx3HzrVAFeNFBvrSeRD3A=;
        b=GaQ1SC6722WbuOcs6sb58FEgcTI/ZWnSXoZHyuRnWWKexA0eQO2Y7tU2dd7pO/u75U
         bHDVG6rf5dg+ek1/xpu47NTjpdwlSIltyxunVGdZQPEkF+db4HufOvo/UPUrEpc3H9Yk
         MqE4u97mRco3l9TLDg0lnBP+40NJro/uKnlazSn2N918IFr9iIbwTqHLbI+2ACs9gk/6
         uojSmVePi/zuEHaIDD53bD3PWmkEGodQc1AYQNEZfyS5nArujDMLxLOEiQJWExlb60Ch
         4JjPKj2yUhzmWr1IvD2PtONj/Oe1WBZKLdyhk85qaZrVmcNfkDQBorVxy8v/vAAqnNHd
         Tcuw==
X-Forwarded-Encrypted: i=1; AKwUvBx2ZeUlUbeExPClKYaRdWt//0DJ9XKEiA5pNHSAwkuzSDf8qwFI/qhHlxdKYClcYnUsjvoy4ig=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mLQ9KwDExLX9Rq3KnsbyZvgvhpr87ECIFHtZMcZpTcM9dwC1F
	/jVxml6TYt3RPSytkIv2ZdZsBf8kt73kV2BFIooOZN3PsPrlgxigoWgi18nZgwXVB+I=
X-Gm-Gg: AYBFou2wVyCVz4aWaRLzKVVIUWIqgnwp46RFsIUaNovUePQlN8a+BiotzYMaUcQr0AL
	i7YzQD1rwhcsDdSgRn6Rp5L8av2J/ev5S4uh4QfNNrXkBsLuWzcd7VRMh8ZZUgCwnFt3X0FUEv4
	qQv07jFsyVOk36Auqdc5TPzezVvyw/vb2RO4hIUDtYTrQXAzqQLYaOKeL7FP4rgspEJxKXpAB2q
	2z4zHhd073ERYz5/gTtzXiGChbErzBlHbKA42u/2vM08xyiTNtEpJk5i8lyFUe3T+MgL8YO98lh
	snl9303IqLG87wDME54rs8APRBnmYZW0Fin9VTWyyhwLY/ldJGtTGqCcvPZUwBeQRUWWn+WW702
	/18IkgAlanrY7oDyQYFVPg5xShfNNlr1dpWqpVtub2yX34jy7MIGYacLgOGoirSA5VkpiABkgUn
	95g48Jure1EwjzPdzk42uWBmaFomoDHW53I3jXPStsZDWeunejTCiYMNngvUIgk3f6yCWZUTZVp
	sBVnRdt86LI11075+VcK6JRc55S47W1Ss3oDXuVvwWLsk5hrE0tapvmv30+y4geEmg5xMa/+D41
	q9UcXpfLiFC4XA7EUiQbY5Fz57gBydiGN6QpYLLOnFv3F06pnKfMfL7REawuDpg=
X-Received: by 2002:a17:90b:584c:b0:3ac:fe93:a731 with SMTP id 98e67ed59e1d1-3ae8981e640mr10608128a91.56.1793742434015;
        Tue, 03 Nov 2026 13:47:14 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm12790312a91.4.2026.11.03.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:47:12 -0800 (PST)
Date: Tue, 3 Nov 2026 13:47:11 -0800
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
Subject: Re: [PATCH net-next v4 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
Message-ID: <aupWXwkFZIQi7Mae@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:01AM -0800, Breno Leitao wrote:
> sockopt_expand_out() grows the output iterator up to INT_MAX, but the
> MCAST_MSFILTER getters converted by the next two patches rewind it with
> iov_iter_revert() once they know the real reply size. iov_iter_revert()
> refuses to unroll past MAX_RW_COUNT:
> 
> 	if (WARN_ON(unroll > MAX_RW_COUNT))
> 		return;
> 
> MAX_RW_COUNT is INT_MAX rounded down to a page boundary, so a caller
> that expands into the (MAX_RW_COUNT, INT_MAX] range and then reverts
> hits that WARN_ON, and the iterator is left where it was instead of
> rewound. So does a caller whose optlen already covers such a size.
> 
> Cap the size at MAX_RW_COUNT instead, before the early return for an
> optlen that already covers it, so a size that could never be reverted
> later is rejected up front.
> 
> Sashiko found this while reviewing the conversions.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/net.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
