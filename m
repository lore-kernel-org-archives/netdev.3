Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734403;
	b=YMkp/TFJ9p3Ep+tvs5q68wr8Y5nF3iq18M3ZsR5rX/PRbHM4DHfMGLCsLeEuNrI5P1lO
	 1i8tBJgQP9g+4IBLvKPHDOIEsmiTcaawiTKlEAKlmUB/NRG4tm1Gy4T1z4vjp9hx5gl4P
	 eM3K50pBSrea+law/lW4l0EB1rbrxBjQcalDUaW5xKm/a3A7s2FO61jdlfYf4AcZz7RN4
	 LwaYyMWQ3D7zrpAM28Tj7ZGJKbpdZBnLo5MX/L2FnAL/a8cR7YV87r9C9qw7kHo950aoM
	 FsAXX92IdXn0Z4Iv7PIQBoczLW4Z2O4Vp+JEe7RQsRNProIlzQnHLl2e5pv42C1lU4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+/+IILrbOopOCnLme60t9BvjxsRF8IeSCPeaXgfCLpA=;
	b=SSKuBhujyMoEZ04WdkdKJECsZpas4Y8WrNXcZ67hwRJGQw192d4TXaqsOsjFIbl1tF9r
	 E21Q56Q4Hajd5I87v4pO71jlf/0YIEGy75YHRdUwt9K++3x5xfTY4W9FtkSM4Hh2ttSVo
	 jH3h5fs6YNw+yC9vAeUQABG4OOXggUIeR4j51qoAcTCvdm9aRXx8X4JWgVYrHGnLaCRN1
	 j6IXxBl9ZPtxFKRw62FmkdWSjmeFs1DeKtmbOp6rTGhI2x4lZksRkbahVEkUMR11X+wkJ
	 pfqtQWZtHBpM0avQ5kBn7gHLUDUCXSqO65Ajij5fN5hmHWmqGYzPO1XwlKj2urzr2Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLOlwJ3e;
	arc=none smtp.remote-ip=74.125.82.193
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8C606A32E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F8C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLOlwJ3e
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-35829219da8so1188146eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734402; x=1794339202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+/+IILrbOopOCnLme60t9BvjxsRF8IeSCPeaXgfCLpA=;
        b=RLOlwJ3eELPPVZT985+ArtXPGXIAXSmgMhCqBjHZxWtFb81U4qfxqdHKO7E/nNFVxw
         +dWZuJUojEVNTMMSr5KEdRvo7Cu9/yOSG6ezN/5Mux3zoIBZJRn7HuQhmQO8cjEWuFcn
         7B+dr0mHGcivIrJbc2TbAHxL6fnVSWKdiqpw3dR1Ai+Z00xelMsZB+8oiopozrvxY48s
         NxMmo6tT1bUUPZsnVT3DXrh3kOutM6RWm/fJDNUWJLQl4zWtaRmAEs7cYVFHP1j6QNIw
         2TF9jiU4d9i/1vFgoS5Bbd1I/kcGnNAvVjYWdmt006xBeclMmbCc/J5GiG579Fx7M1wQ
         BcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734402; x=1794339202;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+/+IILrbOopOCnLme60t9BvjxsRF8IeSCPeaXgfCLpA=;
        b=LpSYfAKYHhYlB1ruRHI1UyF9Ujzosta4tUVOjpRYeqB2fWK4mU31z6Xh7eRVqgUemZ
         Vke6bdCtEztfSIE9uUy91PhB6GjLxeZ9WYzCw1ENhPWCIbynrFPTTbYwHZcNAwLtwzR7
         o8PxplXJawsdaJLdIO0cbodBXmDvR/5+8rEfvrwb9YuOk7DPD5fK1pXW5ZaqYkv45+X9
         nbBwY8a1HfROpWvsw9+iwgMQgfiLs0xULbSQ4g4JpqlArTBmfOWLzqX9u0D0T3XdCOFB
         CgVhGTHU4Mkb5LNhQlz674cIew0u8etAgr6sSqqLlMX8yJXbyQx9PLqP18Ot0SrzHoP6
         WmtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxovWZ3cXVEjtrA/pdUawPaOrdkY1WhNmF71p5DVgTVXkmRzA56d+3P00JKaRm+UoVong1UhoI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zagf12YePBUQsgVRuWWju4+2hQ412baB8K+AuJs6suPnFcsKI
	/QfN4aFFinWQ8DTEcvolcR9WRi/29OPFnNkqI2GfL00mDboNSa7AV5j1
X-Gm-Gg: AYBFou0ofLoKBC8ogfmNNqEN+d6+oSKmgFUm1SNKhcuiHIO1Vyh7qVmpwnRIJM9lvfg
	zj2Itxp9ms1y3a8SAI0GJL6ei9zwNv3e/nZqyaCZEcli2qtPuKt6BOrQOHIngn8e6Jov8u7GBEJ
	Ays66Sb8lRATRfr470E4hbosYgS9qkyYas5kVC+/gVSFSR8CDVpfU+aIjsSvjOQQEcq2SJEB1Ar
	tF5v79h4wSr7yckAj3AEJ0oJ1DSdNo1bj7U+namGDwH896nrTmc2MmzIz7CmDhbunhyePgExyAQ
	vlCbNBos+FNpCA96tQkXaA3XFtsVaXi87qAVI5Zz6qRkgzU4PHtqbP4/wUaZ6oWkje8wjmtd+wE
	gWOrUKFd9JMft9aQ13aP2eFl1lzRwdF63Uz9VadsQ/m3HrJTh1FRaplhQ8lTpRwc7lgfbgqwR9o
	kUbo0T2axsjYutwqNMoWE3RxRGxI3NXSuFuxhqodVhIeee4NE8zrX6DnSAqimcGMKO9ombQJ+L4
	1XudWV0nrQ3VaE9ssfBUy/Dus3FTQjUEIYa8Oyzo0n5P+i+1jqcIZ8rJXLqUelnfdyuWvakg/Ch
	avjH2u6fFISteemB+P59Xw==
X-Received: by 2002:a05:7300:f293:b0:361:a195:c46e with SMTP id 5a478bee46e88-36a2fd4c964mr24744916eec.1.1793734402208;
        Tue, 03 Nov 2026 11:33:22 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6f::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm238153eec.9.2026.11.03.11.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:33:21 -0800 (PST)
Date: Tue, 3 Nov 2026 11:32:10 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 2/7] net: cap sockopt_expand_out() at
 MAX_RW_COUNT
Message-ID: <auo2s-G1DHiLK-hH@devvm16445.scu0.facebook.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-2-2d36da923578@debian.org>

On 11/03, Breno Leitao wrote:
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
