Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73C47F769
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163182; cv=none; b=TqA7QV9Ako33z2v0eoBU7/GlFSXZk4W3In8VSHKKXcPsS0nToXf4L6BAGkSSmhSuMN138MEvArzvkfos3O8uxqbCe5/IQXg4JUA6aaSoGSWc05rwL2Xu6wkIf2c8HQcqwEb2J0MW/BEVSsxsdv1AcVZ/uOQlSWvWw4ftPlx14sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163182; c=relaxed/simple;
	bh=F9tVYstefVXNBFGdnpQ2yzC11l3f4oySkF0wmLDMJRg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=YdT3pNouUXDs4/5JVbwIu9rap0i7VLcoq+E1PEyiYm32FjdV65qn6B3DstB4WHOEOP4PGqifaWcxecaR07wVZwvWkC5cA8EsosZzLR1d9kGU443cOAKMfWMTNzw6InsNKDEf5D5ekEMaK1qpnVdzOt8EhG7/kwDvFYjmr8O9UbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyQaJg3F; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyQaJg3F"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab3260b2cdso52943a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792163181; x=1792767981; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R0/kOu9Vo/zJiBjLTBWedq2zmfz3+xfDwpc4EXkFj1g=;
        b=QyQaJg3FOWuUZCIJGv0XttYjGmZ7QcAuO9HnZkcj3S69RVeZoDzMSqQ7yFB3VQBxuk
         GCpm9cqT+Yi/4c9NoysajS4xVeTmckI7sLpwmSgbPDQu8qvhWrK3t7gQyTLRc37RjR6Y
         UD6KMTe8qEql7olxy53oYZuFDjXJywYsZ+Pt91ZbVvS/TZTdpNBfMzkTdXkn1qDrwj59
         Nw2n7M87O/FOnGbCMfQ/HVwk0oDpikubVWVsv67cZhS7gqsaZf1aSdgxqw7IkmgkhThr
         DY8fYh6XggSYtGmZeCQ3LNt9aBKn07h4AGNzAt9v8o/Smxe9tz0/XKUB1GtERWVpWzrp
         kXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163181; x=1792767981;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0/kOu9Vo/zJiBjLTBWedq2zmfz3+xfDwpc4EXkFj1g=;
        b=0mlGjj2vhSh7wPTat4Cu32hhSdzcxSRZei5irXwUC1GRT6c/pZqmFOdyGTtEr9Ys94
         KdCgQUaKssoqfeD8AH2g6YbvI742EYECLOuqtlfW65iZTM2SLwlMvnyxyKukei/Qx32E
         D+eS7jE2sKwpm+c5L4tVah5uQ2NOzw4C7ZzsyMC6WsLa0efEnxwbAgI3caf2dS2o5QMP
         Gs2lcAFoPPnsENFCzPxa8Nr+FYR3H/+f2Utf1XStIObpoujtPdsMju6tc24Rtz40nAHh
         gELH7sqpwgDzkDkS8IBea+YJCHOgmqZn60qDtifVclfR3RN1QMZzufcndRtDO78jcZ/D
         8cPg==
X-Forwarded-Encrypted: i=1; AKwUvBz7ByFkRwT8uSbGTnu6DUJ7iYaHFf4RUenYqufYa7n1zXhGRpbpHd+ws81IijvO4uyVoIaf8+I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfXHqvgIb2NDPsnvnr+9tPJzEs9yNiboBUFhbDQpyZYz9X5TST
	guUH/pvRCdbKWI5u+C2I6DhV/NtlxwTxxAZMpFj9D3ImV6ToHoGJcEOA
X-Gm-Gg: AYBFou11ouRmCxWwuyH2DfKkfNrQb0a+zr8+hsa5BZ6ImI2oPjSoSlLkBRPiUVAN7yL
	mIICEXUMr5EYkHljU/aG+q1MRhbKIUb2uKdHRfPDSB3OdYjNcQ+FNKCI5DwnAXCU3NJwadoproo
	5NDcsnOpg5WycEhRc1hpSIBJsrWx/gIIu/6n4At404OeLexn2K3X+b2/N9Kj7zsKIbqIlvCPxzI
	2ESuU4z7bhGjoP1e7zwqXxs7/vMLqUBsSamD3hQdI+JcN/cmjISH4VxEaOrRXq3jDZj5jcfHE7K
	yb8OtUK5BnU7CUalRT+SadmwEHMcIujt5jjznfsV2DvVMK9JZF7jn5Hh7w6khJ2BqTCCkPQ9BYf
	JkMZ/74yy4/rOxCBBe5jW2AAvmpqbmTjUbFxjlMARdWauk+m2iyenjkasevFcpe4TLygW1g7wdV
	RWvzuoIOspurnG3rXzcWzb1ygUWHxQibj6j9Md6yIARvn/BslYTsQHs9TMkjEP6ylAita/TZGU2
	98hMmccF9dFQKXIMr8c2dZUN/ny3vXwQ532hxrnAVDghOkhkwvSKalY5csRlRZhIcVMUwbsPTSb
	nlb2YIW+ZheTRhE=
X-Received: by 2002:a17:90b:17d1:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3aceec25263mr109707a91.23.1792163180660;
        Fri, 16 Oct 2026 08:06:20 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05c9255sm1984298a91.2.2026.10.16.08.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 08:06:20 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 15:06:19 +0000
Message-Id: <DM6CTQQV55G1.1AU1HIBPQYW8J@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Kaiyan Mei" <M202472210@hust.edu.cn>, "Yinhao Hu" <dddddd@hust.edu.cn>,
 "Dongliang Mu" <dzm91@hust.edu.cn>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix verifier WARN on narrow read of
 bpf_tcp_sock u64 fields
In-Reply-To: <20261016111643.247553-1-jiayuan.chen@linux.dev>
References: <20261016111643.247553-1-jiayuan.chen@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 07:16 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> Just disallow the narrower access by matching the whole u64 range of the
> two fields, so it is turned down at check time:
>
> 	invalid tcp_sock access off=84 size=4

Pls add a selftest as patch 2.
progs/verifier_sock.c already has
"bpf_tcp_sock(skb->sk): tp->bytes_acked".
Copy it and do u32 load at offsetof(bytes_received) + 4 and
at offsetof(bytes_acked) + 4 with
__failure __msg("invalid tcp_sock access") __failure_unpriv.
cgroup/skb is loadable by unpriv, so both modes should be covered.
See
commit ba578b87fe2b ("selftests/bpf: Test invalid narrower ctx load")
that Paul added for the same warn in ctx fields.

I'm hesitating to apply it as-is, since all earlier fixes for this
warn came with a test.

pw-bot: cr
