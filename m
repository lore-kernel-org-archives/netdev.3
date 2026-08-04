Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98644E053
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838461; cv=none; b=nRt7XNlSi1b1832ik/1z18aZP4ZkaX+K/y0qa2OQoMN9XETTEGKqh8m4CXWwPyhl9vOPZ2RSoixIzFwmQh/mmGUoTmp+VSPLeRa8uZkLdpJfYUtd2tRm4mJTx0S+AIuTT0Sazc3jMTAQs4gPlpvK8HiFPpASFJBi9UcboZOEED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838461; c=relaxed/simple;
	bh=KpZBFyVOZN6T3WZQDyMUDJB9FDOnzr878tykr+VvuoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JnxZ64Jtjx23govbo9jvAOEWZiqK5R8U1guYUsj5wqq7kufiWdtKZ7/w2sqPn4QAvvEn9H97MuZCUjDnPSeQ57t6Wm3qbYG4NV9xzlxBmOSqPp8v1V2cze1C1qZogJ7TWvLgv5RcyRgkpLcNgigOuYV4CID6rfE2IVPsb9e5kgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OGKfKHHE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OGKfKHHE"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso623249966b.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785838457; x=1786443257; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KpZBFyVOZN6T3WZQDyMUDJB9FDOnzr878tykr+VvuoI=;
        b=OGKfKHHEdDEA5FO3z+wPhfjCAedsWiy5Wxs2Mx1qJwJJX2Pkd4G2zkyuBk3/wyRjT0
         D9qkdWUjgiD3t9y8f+V8+g1XLbFMZMEQ1VjpEZ4u9y+aGOtndcVzF5ggMPkb8QsoLb3x
         DRZKvntEFoSeNowKsDzphPp7fDnRhV6KdFqJFbysaRamlylqxc+QJqrmfriio0zqD/Jd
         mGl8y5AFMyXNSzqD6e9Kw1wmgvv24ynoc1YrLuWTiglcxDXxhE0SDcuPOQuwC1FdtWMl
         yjLHOWUyhHA/UGTTSoecQutyMEfIrS+birxZexLPxNnJrxdBF5y3mLd62yPaVv3nuf1h
         e8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838457; x=1786443257;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KpZBFyVOZN6T3WZQDyMUDJB9FDOnzr878tykr+VvuoI=;
        b=W+NUf4AhOdk1X9rtKTf8VHqsGEJGn+cKztGyFkO9o/0l4JCxLkTpZYANW88FXyGh4C
         ccxLSQ834waFloXJMOkbIjcqVkn5ZE5kwdz/dQbS/gVErHFN9oTlcSL/brDj79ypcBS9
         wiHqyVbdLEvotH8F9nfBiprHN8a7aQQI1AB+FqXoq8pDtDe2eNZNQ9AuXSbx3gwDvQZ9
         /NBg/AtAjjMgowC9DJ9jDxypknhn+vbkuPtNtJpmVzRik73nSVePlqPQEDQRKI5Rry57
         t58CnsFB/rm8dyDWBJjCFLrAP+i4ycYhc+UaUcxCUAvpfOk9LMOSMk9rvUfcXpmRDqB7
         dO9w==
X-Forwarded-Encrypted: i=1; AHgh+RpT/pGARFf+VYGVMUWxdJQmPK0pxQKtII8jWN7ATl+9gXboyNPuOC40+TQXtEcqwCm8tfRymW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpQ9aEtNUZbkqlvxCLGWKAbjwFBcGs5T4VJ4mc/IidYaspbd9
	xUi8UiFv+UxzC6rjUaBAJzDe1tqE2UphNniRXoZxvX3qiGPFp4zD+5Uu5eBxXATSKAE=
X-Gm-Gg: AR+sD11hZ+MCwuucDFqfKLHJ8vK+YnlAKO2KNWgnMoyG78Uod7ENWRrABKw2GDiyQWw
	nZ8sTL9CZLKZquqQ/PwxkM2Ttjt+72D/FOsF6U1PuzUDVJHO7rwlmEWtIzOYf6wKkdNsm8oslIb
	avTJq/lU7tMc0tC1tUrem6gggnKpBTjOcZeiqqcbsun1LH1qhT13JjqWVwUTWfaNU8ePQxK5YTX
	A0DarSVNXNpMFygak75X0j/Xmb7qzhYt/5j/Bky7n1VhQMf6EyEE50gqDarN8zVkMrwBtISfbO3
	DQcoerpvDyM2CpzyBGYwU0wGrOatAwvzc8AV+eI/kZW+6M8tWpVFOyGVJam6Bg3F9c5U4/IKJle
	GvsL5SBQbfLWmC4ACnfnKSX0JwLhSgcbgN5xPMUdN7nXncwzLeVGscY14mSPVJ4U8/Sr+IZZ2AH
	GoYCDZer0ZD1KkY1laO6YWLjXJT+Fr/q4vY9DWNBzG9YhvRr8HiRaifUP0COmmaQc=
X-Received: by 2002:a17:906:6a18:b0:c20:1c9d:8d4b with SMTP id a640c23a62f3a-c201c9d94e0mr545949266b.2.1785838456557;
        Tue, 04 Aug 2026 03:14:16 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4534fc4sm644439366b.51.2026.08.04.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:14:16 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Willem de Bruijn <willemb@google.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  Joe Stringer <joe@wand.net.nz>,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references
 in lookup helpers
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
	(Michal Luczaj's message of "Mon, 03 Aug 2026 11:00:43 +0200")
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
	<20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 04 Aug 2026 12:14:14 +0200
Message-ID: <875x1qyyyx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
> Lookup helpers gate whether to acquire a socket reference on
> sk_is_refcounted(), a check re-evaluated at release. An established socket
> refcounted at acquire time can gain SOCK_RCU_FREE via
> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
> then reads sk_is_refcounted() == false and skips the put. The reference
> leaks.
>
> Make acquire and release unconditional and symmetric: always take a
> reference, always put it. Adapt sk_select_reuseport().
>
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
> TC bpf_sk_assign() has the same issue; it takes a reference only when
> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
> destructor it installs) re-checks sk_is_refcounted() independently at
> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
> socket here too. I'd welcome suggestions on the right way to handle this.

Can we make this scenario unsupported?

listen() could return EBUSY if called on a socket that is refcounted.

WDYT?
