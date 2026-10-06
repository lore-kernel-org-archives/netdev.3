Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AE38DC54
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324432; cv=none; b=pHZRwjcfg9Z8oNaIr+BzoEBtxBKo9F3tAH27hfroaQ8PFAhMfYZ40x964y6S2XHUVdH4vVQsYnbejflxMvDmysUCvKIIW/ZLqbm3lgRKaqiz27uDGA44bFBU/ldWMUEK2ByqMczdJjRxVi4810sdnx9usNOp1aB7HDIrO5jyz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324432; c=relaxed/simple;
	bh=EOLOCxtm/7tf+uvqYzhNqaRYiUNGG4nK8T5C5LBV4WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1xM1B+2iT0SHGeyKQcYkv1t0WGs7vrSXShi/nkKCfQP10ZqpWENtDQDtr8oBlIePChfm+jabcBqyhsXX95Yx4Od+cCuOcZBtHgyWSEWA4JwOynuk23VHVq1NZpomJ/FTfsjQrM9dCBBGUhC2suc2ouMPlTNt5qihwZPEhuE7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfXur5ny; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfXur5ny"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3a476ee8669so1478511a91.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324427; x=1791929227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=asaW3esXB7VA3zeulK04gS0Xy5AIFpiZvrmCwzQuisQ=;
        b=rfXur5ny9CGaGDA4CvhP+oD3lPy1pYL8J8a/7Rdv/fvHMcSMWtkHiY6KymFBMr2Wu/
         O2ISZvkDeAX04p7kqaytClF24bfieNxg1XP1YvOJQz6/k8L/BR6GXOmK4DY6l07/13FO
         qPHtMPRQd6nSutGM6cL2bf2FGIwFDWm/ahjxrX1NJr0ReM+cBhBh5JYpBjW0PWczY/vv
         5Uk8/anpPIl9KDnk5MEmj69NG6UxEU0PDAWElTsy0Vzq0H1Wx1BkRVmu74i029ozlr3p
         giW6RtkzXkXVb8m4B+7CNU73MU4YjCY4ty65vY7s13wd0V7vHFya6UTxb9OxmKP9IUP1
         rpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324427; x=1791929227;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asaW3esXB7VA3zeulK04gS0Xy5AIFpiZvrmCwzQuisQ=;
        b=aJqDXIm78vgI60Q55g4i6zl4lFtuftBxdJL70Tzv8c1e1S/yJ63hfPqODXldfjIifb
         m1IO+9la42+H0KWBAY0PxO11o2vshn+gSUMlfFT9zJGJmjHaaKwrDqx+oGdCAwot/TsE
         lk1/2C5xydeTAA+WSCGLcDJqK+oDtKoDxH5cAG1W1TL2xynnWluYfc0sRlP1SHPezTUw
         WdeJA0M5vo9KyCNAVK0WlTLyePio6+7sxxxI1tglKN7jPLqLMKEH7F4g30iMWXHWblHZ
         4CxGotqSlaELH+v5j/Re6x6PZnGsnRYBlXQQEipFY6YdAeIMA5MqGCqdr0yAEoJ1cYvd
         scFA==
X-Forwarded-Encrypted: i=1; AKwUvBw26dRQumCEqMY0mtK4yReISXALt1vTBJgHV78t8UE8E894aGUGfiNcKTn0XovDbxXgHUQNjLU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdY3YUCjwAj3s70meovPn4K4IpzqJKz7ZLA4TAfa70Ui2mQgCO
	rY1TYeQEzWYto8lkUAdgL+jg7Isvs1fjhUhgobVyx570ndT+yunJZoFt
X-Gm-Gg: AYBFou0iiG9Y8wu3+8i46LAMFSiLL922rFqhvDv0Skw0m4WjZpPwINnFhnIM6lztZ9R
	fM3SFlhIC4szpMxsTBbQ1nHb9Ke1MxpLGM3Rny6wRBOFMNT5jhEsrL+ZE7JsiNQbP5U1rczgQum
	Rnj0wNZTwdKyIn4vEzmlYRD5S0ByUDpwP+sk3K799w7Q0tdhc/JLDe0xt6Cfb2XK6wDtQU/ASbV
	M9hfvrE9s3vD5VKpGkoseN5aLAjcGWZbPN8LNMIm6ax7EO/ch9oWex3QaU+rW3CwlgsB4lECkvS
	GonPTnJTz4H/6AWw+1LgB0V21UdMKesh/rSIbF1MmkglZemwOj6Ka3nHIQ8+eS99XpEivC8f74k
	VyyBobe5hMpXNngdLSwLnjFvDG9UO+U+HDWlgJRl0legZx1/L9pGEROjSIWJ2deVkFJJFXOSK3g
	jepiLOK1AzfHuTysn9Man53Qbl7wNiPT2bY+QiTGOnlTF7CbLwMZ0dYvZWNStjIuO6
X-Received: by 2002:a17:903:184b:b0:2df:a608:27d5 with SMTP id d9443c01a7336-2e6003b5d8cmr5405275ad.12.1791324427451;
        Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6044388adsm1656485ad.3.2026.10.06.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:05:11 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
Message-ID: <asVwke8PQ0fVDSm8@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-5-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
> incoming / outgoing skb.
> 
> bpf_tcp_ops.rtt is called once per RTT, which is every
> incoming skb in ping-pong workloads like tcp_rr.
> 
> Even attaching NULL callbacks in the fast path hurts performance.
> 
> Let's guard them (and write_hdr_opt) with the new per-socket flags.
> 
> __bpf_tcp_ops_call() and bpf_tcp_ops_call_flag() are added to check
> cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) first and avoid accessing
> tp->bpf_tcp_ops_flags when no bpf_tcp_ops is attached.
> 
> Note that bpf_tcp_ops_hdr_opt_len() has 3 callers and previously
> checked the static key both in tcp_established_options() and inside
> bpf_tcp_ops_call().  Now the static key is checked once at the
> beginning of bpf_tcp_ops_hdr_opt_len(), and the redundant check in
> tcp_established_options() is removed.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
