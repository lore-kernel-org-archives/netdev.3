Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748773;
	b=kf9F2bMW90ltSe0q3CHOp5xi6VYClaSHQwjAdalcHeCRHqodBFdJWfcvhu17RbWTi7hD
	 POzHoeHv/65Y+vWv/54bRY1iz53D4pE5V5AnY0O8uh694cyiTZh6VoANS3Ak3in0SkBOu
	 XL1MDNWTj3mKnv+jVh0feK+v6X1YXMzyzbVPFtuIUoGL2mftEAfb+MYYeRFSIcK63kCa3
	 4Zgu3gjX+U7BD6afYHBDjch07tBuCdZz+rP/rmph/0Tq3dYnm2O4N9ioV+8ES7kGB100P
	 oVmpy5syNM5xkrPxi4jXRsA+w70EvkOL/18AgiFy4dDpR2xsU8PCm0FbhoeiB0mlqbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zku5BWLrJRdzbWUuQu8yNcvLZ9kOnl/61VOfHmMJqfU=;
	b=WKIHwuZ5mlLefMaDG7gFP4OmJYhCoKWAQUd/bQOBSjuOZGhJc0brZ6ai3diDXMo0s+cT
	 ohhTTC7vEKU3NhOXJW1+ra3HT5tdNO1gRdxVsVVeuoYbpGq3u9Ahi5C++zPj1qKvvI5aa
	 9QjqT5FimKb1AOajVMyILsLlNMnf/WEo4BN9CrRWpsIKqoe6v+xmW+GSKRCvYqyHmSbfx
	 TuYHo1UzYRo/EbrlSsbZa6feqDzILTR+EN50iqlcAqlOVdNZTe9rrvBQvh/HWj7GYplK1
	 BEizu1b9I++vbO0lgk0c9QaySYkwQwpLmV9K78kG7ilB8pdxr29dIPmLXvrSk/AjbzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KAm9GhIv;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE689606A328
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE689606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KAm9GhIv
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab41538192so152628a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793748772; x=1794353572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zku5BWLrJRdzbWUuQu8yNcvLZ9kOnl/61VOfHmMJqfU=;
        b=KAm9GhIvM1i3lQ09CP6GFl7b6KUngZUbIdfMCDVP8Wf6Dy63FBDa9vkG+6GSxV9tUI
         WoVuXlmyuu8mTEXG4dXlKdpE88vjFBSLFbYd7ddyTXWEnX5Row7dRvJ0IcIEs8QprX1n
         R0kYIwLZaqpi6zAySJPBGlDz6r3AnRwd5tt9I9Nx4nzobpA8PuifSRThpiGEdtritx8O
         x+2pPBOxnJkXR2G/YTun8ZoZC45aYX1aJi92PUgdu4DgvPSwhADCeqo2pYPiSZ6OFGGH
         VcsyWyoUFWBz7pGQ3H3gfJ3jTl439DsVVTAQzseRUNXoL03a8TyJyc40KM6t2Z1ThQ7d
         6P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793748772; x=1794353572;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zku5BWLrJRdzbWUuQu8yNcvLZ9kOnl/61VOfHmMJqfU=;
        b=DuK9HdNdG/GDZXcgzXtqpfWRCSxEK936lV7J3OkHvK+HasS4/oEkLEVyCfCE6oORrG
         CJ7Z2CdEgm+Rj2eGSKxBJw2L8K4MDousBTi7+brgd6XvQPDFVCIuCFXPza2rX1t/7dHY
         Xc8QfoZowvAGETfqbNehwxer5gz3e5ZthhR8tfj2hLG7vyrBErv3/r21UOLVFIRELYE6
         zzr59zzAYVMOOy+Ooo44d5A1ifKGhBu070OHenm6OAlyFCuDF9crz4Kl/uMtR1HXEY3T
         A8LisLCF2FudPfbzqYZkPA6i9ZNyAfa+uLWezuawaetsO0kixxW78pVv6sudZlfkohlb
         S+aQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpvcc8gO1YTXO6aixPwm2h4jCKo41s9gOb6JqBWXeJc3RLkd0ucWeJyhfZCOHI0epQ+fgUZpo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sONiAk1PTl/nI6EiIKl7e4FQ4Nkja4Fw8pDgVrzgwj8Bwkvcf
	Xb2SzkgLleaKVf4cnG1lzW1jhy3FHKr+ZMXhTYOsgFRSHyR/rvLoel4gXrxwaQGAlXk=
X-Gm-Gg: AYBFou1tk1fGM8HWyq4mIbzSpZJv26YkWu6htnb+ujUREhpOntUnRxDMcPCG8lTp3WQ
	yyFvouB4h3VLFDOC0uSgcMxduW6n+5lcMFc+rm5AWJr4GXeOuMMahxAEH9X5bN9AP8ONozcJgP3
	GhTZaaC5W7XWFb5eAwNft27Rp+WSOXNDincjdsR1pj+FgUhndOsBZLZtrmjQvOP6BPYYzfCddWm
	AxBibTtNKUcLWva/mTNmeojky2oKwysS1TB6cd4eSk6/4SgF5fIppgSw2LGqisvEV0OGmOjPUC4
	s03/T0r96n5X9yw+YygPJREQlYgk3BBf1tZuceDIViQosIXYIGKirBZHXjoVts8i5abcO2whOzJ
	lhvfU0qXjVFAPghnitKwr+kO8nbTjf2+yq+WMV9npwBFWxu1qPARACic48TYNJpSnOhGHPWLEJu
	9ba9XeZr/odC9VrDTAp/Ov49FX8+gkXD9PQmHyGFml4oCAOI+LFVxv9chwvKSQJCegCOtNirlAF
	dr/LR5pbp/h8c6sw3kNy7BWQzRhiw7bIlyRYgoADSe7CITfXu45uHKQOieKhT6bKKENsZVzp80k
	OZ1iSaK8RiAS1AmRKwPKWTdQ1QLXncv/cNUUndi9yA==
X-Received: by 2002:a17:90b:3b85:b0:3ab:188b:c5b1 with SMTP id 98e67ed59e1d1-3ae897e4182mr12303028a91.56.1793748772265;
        Tue, 03 Nov 2026 15:32:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8329afsm6343342a91.8.2026.11.03.15.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:32:51 -0800 (PST)
Date: Tue, 3 Nov 2026 15:32:50 -0800
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
Subject: Re: [PATCH net-next v4 7/7] selftests: net: getsockopt_iter: cover
 ip and ipv6
Message-ID: <aupvIuOSQpv8nJ5F@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-7-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-7-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:06AM -0800, Breno Leitao wrote:
> Add an ip and an ipv6 fixture, pinning the returned length and errno
> across buffer sizes, the branches that answer empty, an unknown
> optname and the options dispatched before the switch. The clamp tests
> also compare the bytes copied back, not just the length.
> 
> SOL_IP answers a sub-int buffer with one byte where SOL_IPV6 clamps the
> int. IP_PKTOPTIONS and IPV6_2292PKTOPTIONS want a stream socket;
> MRT_*/MRT6_* want a raw one.
> 
> ipv6.pathmtu_negative_optlen pins the clamp of a negative optlen: taken
> as 4, it is too short for IPV6_PATHMTU and fails with -EINVAL, where it
> used to pass the length check and fail with -ENOTCONN.
> 
> Only the two hop-by-hop tests set IPV6_HOPOPTS, which needs
> CAP_NET_RAW, so the other ipv6 tests run unprivileged.
> 
> The MRT_*/MRT6_* tests skip on a missing /proc/net/ip_mr_vif or
> ip6_mr_vif, rather than on the ENOPROTOOPT the switch also answers for
> an unrelated regression. A kernel with CONFIG_IP_MROUTE or
> CONFIG_IPV6_MROUTE built in no longer hides that regression behind a
> skip.
> 
> The config fragment only had CONFIG_IPV6_MROUTE=y, so add
> CONFIG_IP_MROUTE=y for the ip test, and CONFIG_IP_MULTICAST=y, which
> IP_MROUTE depends on.
> 
> MRT_VERSION and MRT6_VERSION are spelled out; linux/mroute.h does not
> coexist with netinet/in.h here.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/net/config            |   2 +
>  tools/testing/selftests/net/getsockopt_iter.c | 372 ++++++++++++++++++++++++++
>  2 files changed, 374 insertions(+)
>

Reviewed-by: Joe Damato <joe@dama.to>
