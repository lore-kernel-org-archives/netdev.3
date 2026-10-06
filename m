Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46E3932CD
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328344; cv=pass; b=irKaKB+3eVX5qrA4BDJrsej5m0wAQu2AD//8Bo0Xpoqh4NCyjOiBHMr4zFC5zVlSHazX+qAlg70tXqY2T/B4qpEGL41oonTBhqB/iKWrOksfG9TJVXwr/I2e8pMI07YCytGxVkL/5T1qejaVmU3t5116cSEabH+8+0CtxREbwCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328344; c=relaxed/simple;
	bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKfABAWD3ayYS7V3ZNbHMQi+Zkm6DQVwTf1B31hTEydsSQNHArG7Y9FQJ2uYeVnfxpRsU3la/8F/MfXDEqj9QubenQV4rZKBgezBtCZM7gw72KCQJvZbtY2OsoIz8CLBgyitHEJktmUxQ/mIX+QiXKg1CqWkXPoTKbpJotgs90M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/UOYQV7; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/UOYQV7"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f5d3bff929so2275399b6e.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791328340; cv=none;
        d=google.com; s=arc-20260327;
        b=XDy+f2bDHID/xf0x100vcy4jY4rC234494CXWFov5qfu96kMKDKnLu2hO+YhYMg1ta
         JyThTBk4KAzvZnguhvYP0ajNZl8ZwyReRaJ/4HYGSyt8Opb6tzj13j8ed9yinJW2EjXu
         WK2gCH38dzfTszd5R0cfGemIFPbFEhE/AZ3Z8p+pGkYt2LxXiI6cALkr5+Ox+zUp6x1p
         M+sUC8Nn6VhY5zsSNO6JkOk7tRy62M8eIeAztT9khNvR0tf9Js33pGS0ABpxBWbDmMRK
         fxzN4VoUnj4JZ++uw7tAugI3v8Sx0UOZPIWbPi7iHBXrf3FiUPgym81FZdQPTDdkICGV
         WlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
        fh=cmNq06UAF30oMOj88azKDMq6XC1zZsQKvyJY357PdQ8=;
        b=fACQ+oaJiVausvXn0ixAAfO1u1TGK+u/wrl2mtqrvOj5CvTGxmVHaOwDCji2kz9cVm
         +bSDzRU6vhmWHWh1ETdFBgaPOCLTBZMdNPB667/FshTKkplhh9AR8VTPx6M7FEcFYR2D
         f0wdaSWNCEKXwIlRBrq5dCDcwJOVNadXJOSUbk2OBujZdOBk3aEWKMhMabQKFSOOZt+3
         5whKuesDiu6fYqcovFYPn3SNJr16EngOs+jkFISjLwAiF4/XdtfSnwjHUl7bjWgYLYcE
         OXXmb3XXH0L2qOUCJEYP550zBOR0WYpxDyuD9b6NCCPBHBiurNo/2HBsGOs7+EvjhBKu
         6bcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791328340; x=1791933140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
        b=R/UOYQV7x3GP4uccj8bB9IhEKNFFZ3s5KNxhJpKw89OTZI2u3XkJwR3X6X9dy4sNZu
         1HYI3W6UdF5LYDd3VdOKUrqm9UbrRvLFgvu7kV2rQODbh/oJ/nAZXfvmR7GbCSgGcr+S
         4kpiArWAT/ANz4k+1h5WCNKsho/pFzl3W0jS84i74JI92wqlNpPk7Hh/+hHZFGrBPMc3
         2XAtPLB4RMgU/4GgltzyXGUCpMZEXeZmBM0mdBnVRY+rDdow/UnNlnkrJCLWUYMrP0oa
         /IyvlAOQzFxg5uQHdMeHcu/pfKW5/7yZw/b2zLBu2Q9t+muTDKPr7rUpa7B7cLEWUDbo
         VtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328340; x=1791933140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6xPrmlkyguhHKDxpntIY2d4H6WRRKWpaP4dH+hr6vI=;
        b=T318qdBAb0Iq7fo5oiwLCQoe4t0/4r1OQ67JqZ98zpiKkfU7Q7vXMTF5rXVG75DIZz
         XhCv8V9d6jg0KpbzVWey7sOQCxO1Nx37t/Ai89t3m6SXDixT4EoWoF4yJUR5JUtVqssQ
         po1vDnKoIfk8FmXorbtc4S7B74Hr85VG5n91xaCV7BBWk5DVTD1Xy1/FUsqEq9Y5zost
         SJt3WtYjCSqLyYx8RY54Ny5DAlwVoSVsSetCAlYuP+6RYdDhMo3RoEfZuc1NzovL5JPK
         CFqudVSJWQAgT3FoZ0JepYXXPRR5lV1e3dl7UW5GJDCkNu1abEYLkkwt8Ffr+7f8Nocm
         aziA==
X-Forwarded-Encrypted: i=1; AKwUvBxtqVaxRLxCWU+nt75hzZuztRbazAO+cA5tEm63CRtKeIA4royEzoXXw53w7ilEJptpbKCDVT4=@vger.kernel.org
X-Gm-Message-State: AFuF++mk+k7sSx1UhRA2Qikh0P3BZxnF6bA5HMnUdGKSxDyim5/yOQ8o
	pjAHZ+bFEOLc2AAwd8B+Oaee1RawuIGIPyXFR3ZWzj+ArMugxc5pYj/Bx5Npbdl/8+ME3snq3t+
	j9a27q223rO8Znfnvs5zdEqBXDa0AdFU=
X-Gm-Gg: AYBFou32J/5NY6fSm1q3OVfTNM1iSYr7YddPBQK62vpd3XDFwY/rz9sUpIK0UdSNDp8
	qHw7s2oMObhCGLQcF6EGfxagQpCugIjkE458qG5UB1YARJe7s6E1IRkQBbXlIUjxQYAA0lDHlWI
	OxGSgXn25IZj10bgsFFUgy5DC77SbbBRaQoAN5uWH4IOIdbifdxiW8VBscM1o6omfaeYwvKNY32
	oDMaRgARyRwkAMbWxrt6ERfoYqZylIIJuQZ01xoBW5OXGWDp5Ti3oVFbVunwRr7MH8egRmqCab4
	ELnj6C7GomPbifb+kglHTR3y/lUHqIjQ4Z5ZzHtCDMOc/bz8VXUw3L7Ot2fxNqgxnw==
X-Received: by 2002:a05:6808:16a1:b0:4f4:4de8:9373 with SMTP id
 5614622812f47-4fc46890902mr831448b6e.21.1791328340247; Tue, 06 Oct 2026
 16:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-4-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-4-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:12:09 -0700
X-Gm-Features: AclHuK8B-88YW137pfmmCWsnwNdwV76mFfbjw9iApZp3P37MJmBB-x2hO4iEa84
Message-ID: <CAMB2axOh_b0TmmjFdonmr_7A7QEFmtO7nfRbYRD=LcfyxKMfMg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 03/10] selftest: bpf: Use bpf_tcp_ops_set_flags()
 in bpf_tcp_ops_hdr.c.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> The next patch guards bpf_tcp_ops callbacks in the fast
> path with per-socket flags.
>
> Let's use bpf_tcp_ops_set_flags() to enable flags for
> parse_hdr, write_hdr_opt, and hdr_opt_len.
>
> Note that BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL and
> BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN are used on the
> server and client, respectively, for better coverage.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
