Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97766415F29
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924047; cv=none; b=vDopazMJd+p9X//nEgTJKVPawz+kKAlsHvt5qlg/he2BrSL+RFifOQ9aI69ztm/ECXJFI4MYKK4RwcqraEtiG6kEkEh0yxO13aL1yGAhIsvx0rYXKglwW5TJtuKv12p7ZnMFo2qsAGFUhNRlvCtc4MFQn8EryQd2FW+wf9TKEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924047; c=relaxed/simple;
	bh=MoNEDcWdGlP7UcyCq8wXBRR56spV4f4PPUO0eUL2OZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FI21zsSKImfJyYAeh4QX5YFvSVqpIm7+clhaGswqY0w4hRg/vcKttzZ8mYkdUH/FvKkGtHzL321Xj9fC/h5/nogTXaUQKJvMN2R0QMb+kcpKpIsjWoTu+RAWtLOi/flnNukRGmp1lig/ovAjwIjjuodNqB5mpVOxNvwQ61EgzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxbYk8Rs; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxbYk8Rs"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so2024216a91.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924046; x=1790528846; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+5OXkFTl19euajO1h3c9jy1KZ0WClYAUhVVTBNP2yF4=;
        b=YxbYk8RstqpNoQLxSV22rHj2WD/9cVINT6vI6PCf3oDmUoVKamqBQMaITd6AMf88zW
         +WmYeNe6xhJyLXwgGa6owSWwffxx4malxAJX6EA0iQyCCoQk0f12JSMk4cygi1+vHALH
         ISbQsG/471I0i6Pyxu59MVm33urf6afCcopbGmfOwlZN1GPazdMyUSnUvQw6ob9EzVsU
         kqw87eLGW250yl3z0Z0Hl1idiuFfetYTFeiYJ1bXPP6iWQeyLvngAy8ag0xFPqVX2fXb
         Yb7oyGHZ5YMP6A4OIs3U3TsuiSYRS7TUs1lU955TL3Cob3eDECtyDjzqYXXfdApXH8Nw
         VVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924046; x=1790528846;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5OXkFTl19euajO1h3c9jy1KZ0WClYAUhVVTBNP2yF4=;
        b=NcaAJzMmSu2YAvLq5fXYx1TpyDFp1E7WeifGDXOVHvIGCJTyFY15NSrjlRSNw5onrh
         GKBkMILRW6b2SPSr6ies0tksHJsExjN1SrzCAiRi5aobL4iDttZN85WP+WRr0jGlXEdM
         OcNzdqYD0acGkjTWoMKpbj+6i4H2hFDfmyoy7AvrqgjSk24Qjafe7NjUw95ALWI3USdP
         6sOUHGVVFldYvxyjMKH03wZpk4DNwGevwnonhlOECfY8ZP9MyNb9xYiJm5JlKKDUsnm9
         uJCmI6ee8Zw+rPCGET7SY5/R8GBa4DcqKfaG1YD/g7ZT/Vs23lpSLMhkQ7KpqS75QCEu
         ZYjg==
X-Forwarded-Encrypted: i=1; AKwUvBxpAMB26hjRGt9Fti2tmcYDAvo1xBnci4I23nu9zwna9/v9frv7YR4FbOGNvVe4FOgu9VhNmF0=@vger.kernel.org
X-Gm-Message-State: AFuF++nUT8zDCUdkHFHNkAzoP8nGhJVoxcoIHGXf4+ECc+i1r7T4Sr3O
	bjyQO8YdzmyDjsPUWCZM/iCLBfiho9oOr5lyqV7Cp8Un18ZeYDquAz5/
X-Gm-Gg: AYBFou3pkZWsUiIdRWBZpoKQi2Sk3Dsz/ogaRZReLMREUlTLjB62fGiJBiKyNM8sSPJ
	zq9/8VfTuLTeXtk20WpobKgjrNZ+RZzuZN/eMWbYI+nW8kpflHyPO2rM5Ax0uoeAqL798mm2rGm
	590EA+Z/757RyUbJWc9sR/iuNiAFzlnippZoV7QQDAI3HFjLqKyZy88iXA5KoHsV5z3z8dA6MK4
	4EAjfbAlPWt+8YQV9czzsEvOVRjoaA9JEQLtLxUyWNdnwt4HCLWRvJerklDgsItKWg0Cd/C60SU
	jff2U1Y3L1ToLZ9hZhGBgYsY35C2poedZ2Xe//PD94GkWD6Y+o0/q5Ml04M7XIvK/sLbKj4+Nw6
	x75sJZngel7Tuu5cXyXR6kjPE+5EWGEAXLny2z3Dj3RbMkGiyVzqLq2fjYvpusEQVYPaGGPcN7a
	J8SMJDD7pWjgZCXgRovV3GIOFVmWJXj/m1sgRep9XXtdvRl/mEgjwRyU3uxK68FDrmoo21pr+jT
	oLiw0X6lcpwd6/sbaFsFLnZRzRybgx5eRQW1oJsGtxZszLt7N+2e9g8cLWh/Work1plDoTK2qq1
	eH7V
X-Received: by 2002:a17:90b:2b43:b0:39e:1ff0:331b with SMTP id 98e67ed59e1d1-39e54d37ad0mr12487465a91.2.1789924045869;
        Sun, 20 Sep 2026 10:07:25 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02900f84fsm8679011a91.2.2026.09.20.10.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:07:24 +0000
Message-Id: <DLKB4AJ21W5Y.VSMC8ZB4EK9@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] bpf: propagate cb_access from freplace programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.17.0
References: <20260920163211.795547-1-bestswngs@gmail.com>
 <20260920163211.795547-2-bestswngs@gmail.com>
In-Reply-To: <20260920163211.795547-2-bestswngs@gmail.com>

On Sun Sep 20, 2026 at 4:32 PM UTC, Weiming Shi wrote:
> =20
>  struct bpf_prog {
>  	u16			pages;		/* Number of allocated pages */
> +	bool			cb_access;	/* Is control block accessed? */
>  	u32			jited:1,	/* Is our filter JIT'ed? */
>  				jit_requested:1,/* archs need to JIT the prog */
>  				jit_required:1,	/* program strictly requires JIT compiler */
>  				gpl_compatible:1, /* Is filter GPL compatible? */
> -				cb_access:1,	/* Is control block accessed? */

No. keep the signle bit.
