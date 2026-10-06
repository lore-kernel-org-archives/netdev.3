Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF237269C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308933; cv=pass; b=Jb3DdgEcaIVyLZESdPmflE1LFnhu1sATZGYcMWcEhHDMiKC0jmD5NsqiimjIKXAgw6NPRRDrq1wIhCBPu5n9DweBUkHrQ0AcCvqJGWAyZzrNOVUH8zmXOyKxO4ig3tuf+HWCmzgdnk+chj0fi58HSxqx6+SvfpzPj7jzwAM1B70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308933; c=relaxed/simple;
	bh=VRSArwJcRo79n9/mlWVHLIcO/a90TTkXWTwHqj889k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li+U2Pr838aX+pkwYR+PH4PaxMmTLa8qyIApn1qAfYtHAlBWPRIhpnc+u7IYWhJRrQyz327LR/ZIkf4UHZM8rD5j38hqM3NK96uy5BpgWqoTRPqMpd4Sy9D8k2f26y8D1YIZNuQWgXdZ5lDuMCwyL22ouYh9W9ZsjNkLAs9x0bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DzuzpwTr; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DzuzpwTr"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-825572e6701so1462327a34.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791308930; cv=none;
        d=google.com; s=arc-20260327;
        b=m7vmd2h0aKop2wQvIaTEMusSS7ga1KKW13QkQIkesYg+g3FCy7NcA8leMZwcjDPiI8
         v3qemIkNC72p+hLHOeV6sSTs88kYy8CJBs4DbaKfYCcgQs87sknx3iIGdTHTYnHfka/N
         1xYb2PQ4/lnBhhjDUZ8/UyKRezsiy++J7r6TP3mq+Pt0+iN0LXdlDiELXzw2OnR2/wb2
         vR+NnTro1eMx9lrIzVwHdWhZYXzdzfHgUdvd86tI/WlLdDeorqgjkL61cd5um55JqOQB
         SguM+bGNKJtyxtNYt/Tgj/EYvcrS9+hq1qVqW23m4wv9SrVUekBDYVYVLIncX4PiJ1Wq
         NquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKkGu4MISHQEsFFjUyIjKXrjUrAiNT5vrF+iXMX4HX0=;
        fh=hz5IfXCgrojfxpoUBszThL+YoFhutDD5k8ExxlA4QeA=;
        b=Qcd7lhhD3hCXK5N0UhK0dT5YvJc/YIIpAxnpBNqElDe+b5B4TrtHfW3MBImT5WpPu1
         PXTT5WBdFeKmbifGmYO3wrApDSMhM2dixPrUchKVKB7njZhdrH9RxlBj7+5UoRvizSyP
         mQbjt7LQuEe1YctFqCjndFhiPLYMWMOLE0GW/RP7OeiV/5ggXwSFFLfjbvmdNATMNfpw
         f7rx5NbnQkAwxHNo6PRAxi6QGa5oug1dN44WahleoVpxmvDFzn3xUZK/I/3+2DzOuvup
         TzetMZ8iZbuNPNlGGITklH/TlVJm4dOts8YImZ4XxkL2yedtFgmsbq2Igy2FYidy1DdU
         SlKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791308930; x=1791913730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oKkGu4MISHQEsFFjUyIjKXrjUrAiNT5vrF+iXMX4HX0=;
        b=DzuzpwTrkKtcDnXxD0hn6+9TImm7VEOD/gPZJMllMEnmoAuwr3+WcTob2Gj1ovdhZL
         eqQSSWC4WpNbmKOjz24kYhbFtsNbDp32zvh/xmzYySlovLdpd+rXQb+4d7z2f5DjXFKT
         bxEvC+MjpsQgZj3dmWAwy9WD/Q3Fp80YQ0A3vYXYVsY1aUJ94fiexwxEpOq8SFHX1h+h
         12ZxVGmwdAdfxYorAXNo4fHNKJfr0E2lmk3m82/4bkunhEYRaqHvEIzWftroYAsh0ecg
         qnXhnvrF4RZ9s4iQMmZDeo32fxyCASjScRVd1sYnpQ+Y8o5g6xmvsmwetNMKYr2qyW2G
         r+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308930; x=1791913730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKkGu4MISHQEsFFjUyIjKXrjUrAiNT5vrF+iXMX4HX0=;
        b=PCO3hTbOL0cUCcP/Vt0kU/dJ8B/8zl0nmgv6o781+hhUXgsGQhxz/5elcQoi/QGnnd
         sUfNiqWQSoky67BAoV9PL6OZ4wsXjrhzTLlZEsdQsM0yJ3F9HprQGO4rOIO50iutPYuz
         ZFtIRzk6cTDmx7NoFXWyT4APgjLGXJKN64tRJNYcidNWJOizWIeHJ8aO0vgbfEZPbMNF
         p++tSwOPrL5XHpJMGNVb9qvPvk/XzVejMcyYew1YGHj83sQac+SfrdMRdIu9n1AqS9Jq
         lDYl3WVRueGHfQQdxFpWnZP7y7OX5pkIhFOiQzfKalEpd/DozJD/kNvGhT5gboD/+2Aq
         0KLg==
X-Gm-Message-State: AFuF++lFuM/ARR0Kjt4e7+vvNXWggT8gr6Z3gG19PKGwBXlc9ej89jZo
	0L/TxUaOh6c/G5OG3vcQHYZX7dmT0B6jluNWYMgNQbxeBuD4UcwnJdHGcOd0CTMgQ2O7cou+cFl
	LjbzEzGmOqpvlTAs+W4xMT4JKYU/6bFpQzO0fdsDPc4Ojn2nbvJfFdajKYxYz
X-Gm-Gg: AYBFou3irvzhweOvg4gf7tc6AFi4EKK9JddW/dLghEtbVysImCZv+6MQtjZrSLF1bpu
	nEnOJCdFggFj3DL5Nq555NrMw8KXOMfSngTtkgVau1bMHeQIMqqRjK+F5S9rPuT65VxkPDhFfV7
	M6MydBYQvxe6EGDWfoYungBDcJAJ2ILnafRFJHsY0MYDmTxVdziMynwdQqwaUEO8MhxJ+/Dc9Jr
	/Ll7J8XVX0i07oC8VyKcGBzaZHC/f3mWSgTcD7Aj6Ej2UNqFfQou2r4nnsCA+U1SZyqgd/SUiDb
	CNutzas6Qtbw2QsXvhKTFE6aFJyqA10QEXNkji1pjKRiErQiXOgQA+yOI0y8jcbqYpxglLZjE6P
	MBqylPLDexg==
X-Received: by 2002:a05:6808:e305:10b0:4f6:a504:1897 with SMTP id
 5614622812f47-4f6a5042d3fmr7722009b6e.13.1791308930476; Tue, 06 Oct 2026
 10:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006173241.65945-1-tianyi@cloudflare.com> <179130839329.2231598.14859340679278349582@kernel.org>
In-Reply-To: <179130839329.2231598.14859340679278349582@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Tue, 6 Oct 2026 18:48:38 +0100
X-Gm-Features: AclHuK8tusQKzC0_fjG45JZf9NjrVrFoAQ9mJo_jQw5ddNkxc7dATehHk_JKOlk
Message-ID: <CAG4wq-eXM-mbZ=WOzL_M3u=yYm2YMoxshCJPjDqT2GB3FL0AbQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO
 is toggled while down
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com, 
	lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org, 
	hawk@kernel.org, kernel-team@cloudflare.com, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I was testing XDP redirect from a physical NIC into a
veth whose peer is in another network namespace, and found that the
redirect worked or not depending on the order of enabling GRO on the
peer and bringing the peer up.

Cheers,
Tianyi

On Tue, Oct 6, 2026 at 6:39=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
