Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6255477E58
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061136; cv=none; b=Bwx2R5OXsCSFL6YD/rtw8k5wq1tV6hGTpOEmDV5wvuOWjHB2amqkhjMlXTNtBJvq/eKp2tKKXvkRA5sBdnRJ2eaHDSwOFhZh4tOpGFHFQX2VWDIkbWf06igRJPhll1niGkgs0ds3cdVQhKWVzeFoHlFVRK0oJR4yrfA4ZnU3ti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061136; c=relaxed/simple;
	bh=ybEdMnj+IV21R50M/Nq06VgnFb302XMUbdzsNI1SGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyJSj0l2T8GXYAAJrXKj8cgXvSTnDCZpxr92khEHqb2OFg+KAINrf2+iqWna+Kp6lDweX4Y0n7FVzBmuwty55TiNGZeUhCQj4iWniMvkKoXHqXe9C1P80/2JXEgx+VPJm2KT1XEBkNcYQtdYfEgP9OKbgKIyAr+FJZ4XG+T8X7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RP4aia8n; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RP4aia8n"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b886fc047d5so1147058066b.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775061132; x=1775665932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=RP4aia8nubY0vdY1PS/lQURtvDB47wVLd9f3f1XT0Tafn+n1LpVals7E9bCn/doEdE
         bIlbGxWgXj0MZuJ2LyUbxO0EUFo+db6jJh0WSdIer1N78YEo0td2kER3N4v5CesvFgVm
         H7fOBReFgIvncIQBPObIJ/77TIwxW2SevngZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061132; x=1775665932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMfn5M+yor9qcHDuzn1ye+wM03ph8KGxN0vfAlP2l30=;
        b=lWcz5cQhAjNXlxXMFggWhhPuapfa8jLuHr8ZQAk2fVeXTxGaQMzAT0iL+GTvCw0Gd4
         Fo45dGGRkKH5A6nxGzBe5I3GSet1R9vC0lrVRxzumVyPFdwEFjpqr3cpga1ZbeStcdBK
         rzHzJ028zKnNZYDcnbqz8E3ZnfEDPme4B3XUN6zd0JWSnUFRj4GyoBzezKg1p6S17XAG
         lsO0OnOekjN1SHjQOF+umkmD7iuIKD45qwr9u+5sQMAUqaHyuVLdXe5Nnmq+ddCaSpdV
         v8ymS0Tr2pzWTIpBbuGU2hoWMYrurOne1OnoGlK/YHGFgfzwiNGHyDivNNL6AVNfJAlA
         4g2w==
X-Forwarded-Encrypted: i=1; AJvYcCU/wc3ffg93EFHH8TtPmGfTg3V5xhIJXm334rm9YmtH+c7WNWn/zPnn+ymkU850nLdObqA7cqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDouUE59nkxLtp8FIZRqN6NvjQdcXQxfY/IomVOF/uiC128dLG
	+ekqW+reBwgsbbJ9EoFvA4BvgD4Xv+QaEke4dgDkjQ7C46l+9+WvdLITYKKAmP2tk+fOozGEcOL
	Iwyi2hq5Uyg==
X-Gm-Gg: ATEYQzxOortOVc1yJB8CiBGRYn2glK2XPRbisogAZqyB8hHJXKYEWQRO+vjIenQJSYl
	NIkpA+ZWqqvRxLmBfTe3GlIG8FCiB8wqpq5yAFU1Rq/quiUT3VVXcnuw1gElT0+lyBaZtHnKzLs
	Spi6nzQox3y+FAy1GKQu8z/kWmX/k/79Qj3ZRGCQLt6wesWeGaErEFzv7cHiU3qGWZ13anoinZk
	7u6tI5xvOwj9COKGtFyPYcF+07Dsc3YwFUpYl3HpeI23eI1oJOs5uTBKQyQYHgbV90kbaJl/B37
	GAxdXCUkiDVE2u7Koxm6Bddhxbs0gS/cFC1BEnzmA1P1bxPzXZOUZtZzTfeEdZbVtsTUkLJ2W+V
	u1tjr2W6ffnhbeg0/0PUCtvGXLXO7VHk5TdtIQv5AUtf024pGttNznuPYhgmJS5Dca9sfXghxGo
	aH2X/RSjCLdxJq5HuMkFN8EFy8atV9Z9MbtthxM1V8yw1AcdAj1gf2rZ7KHPAsxhK7Mm8hLAzu
X-Received: by 2002:a17:907:a604:b0:b98:50b:e94a with SMTP id a640c23a62f3a-b9c138e208fmr309419466b.16.1775061131838;
        Wed, 01 Apr 2026 09:32:11 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e02abf32esm49255a12.0.2026.04.01.09.32.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:32:11 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so7479472a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 09:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/1dxVACWnw/ZEeMoRPiD/jVymqKECFkwyiza0M+8Y1dL0n40wm4ztUTL9le78wS0ezeWfoJ0=@vger.kernel.org
X-Received: by 2002:a05:6402:35d0:b0:663:4315:7271 with SMTP id
 4fb4d7f45d1cf-66db0cfbdaamr2927572a12.23.1775060766098; Wed, 01 Apr 2026
 09:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
 <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
 <252823d75e9221647e7f8ccef6105432aabe8d6f.camel@infradead.org> <20260401080657.70cd9bd1@phoenix.local>
In-Reply-To: <20260401080657.70cd9bd1@phoenix.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Apr 2026 09:25:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
X-Gm-Features: AQROBzBuhMzLrgonz6WGspEvkWFhuj-ddiDGEYTFKbMu2F_LUT3de-t_k_EwsPU
Message-ID: <CAHk-=wj5KW97ZHUi_5kCwC+Lh53_sj2HJ1SnBU1pQAOtnk7oGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, Kees Cook <kees@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oss-drivers@corigine.com, bridge@lists.linux.dev, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 08:07, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 01 Apr 2026 10:28:23 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > Maybe on this date next year, we could make it not possible to build
> > the kernel *without* IPv6... ?
>
> There are some government agencies that used to require that IPV6 was disabled
> for security reasons. Yes they had broken old firewalls

I think you missed the big clue here. "This date".

Sigh. It's going to be a long long day.

              Linus
