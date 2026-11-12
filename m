Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503973;
	b=bxtGinSfr/rJyavEB4eRmD2ZjLcnqJkbZe9FAygy50CEfp8hhmZzfrfoEkEKoQXA05cq
	 fuZ0K4PANzsbl0w9MnoFI5N7+mHTQ2CP8t1vdXDeHCQF4p3CA54N06RvaPP5S1Vy4qc6L
	 MNtQuORJ5hqdlc9DMzaWpawk8v8XNvmtKn2Vz6hEwPhEQ8fXjSaSFSmFgrCd4Io/Ao9G/
	 tpfhQzg09HzZjyeRgf0xW/DtoY2sx38L9gVEQqWzZRAZkvMk0DcGoKyki8MXVrnrhJXi3
	 UAF/TTjHHf3VLaJkldw1IQAIXwaxdo/yrR7U0qhPeJWcyz3+aI52gZzoQkHdhtS2Khw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
	b=3sVoTmqaF2NuE/MWPUXLaxc1T/KeR9rtLOALZpHuj++tvPESGxf209Fbyp/bnA0ZlDz/
	 UuFoXZFqT0xOlpfql3h/e43Jq7niuTpNlFnwNmmqpE8EEckz4k3QxwCo0bvnaD9WmMxTU
	 j9n2NpmlvdbDKKxM7A1bgDZf0AthKDCSwOaqBMYkPsU6FbE4Zfdu+KnQuou/11/JvMZaq
	 Ap/q0NNhObpBEupH7Ruyi2jRM7w2JOVJGeekFbj4t7GT2MsE8T5/OIqn2ncDCgwvFWsCZ
	 X/8XtqXJ51ZZFyGJRco9DnogYs0J7u/tU8hc8BvSS8FhsQipMuLZhcvxKjrUufnTQrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SxHHPHu6;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD13606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD13606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=SxHHPHu6
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so722758266b.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794503971; x=1795108771; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
        b=SxHHPHu6cOtDhPmTI0xil8LF/utx0e0n/AffFmGVb5C1nV0MuNSbFJ1aANN9HWg2ab
         YSm0N1XvrmItrbUR0VlarZ82AzzABbYdxyiXurTK2t/D1NJizsPhWTkbun6Xxc2tthdY
         Tm4DlO1hbdrMxjB+8QAydj1qnqovgUM4cSdbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503971; x=1795108771;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
        b=mqOSSxNyu3fRFfW2Xj87z0iorc1CNQZhEMHqGiofl9Jz/dlCkP5bPVQMlNnwJ8S3K8
         Ka0NJFIXpdipeLbO0NUKMUB9zqqFc++q5rBY1tza9Ciq+5yDgBlKY1GYNEqXs1xWLS3L
         iKmRibtsPwXhBBUdIQ2HRIqsqpvK8ASsTmJrS85VjGzMVtu79O4emx8Xva0tmqNa63wM
         PInEUen7X1O5JZeGGCYw3mQiGnMum/OdLDzvCtQBRbE+WSbS06b968lZlyQpOrRelMc9
         iehV8fe21Ie5oqu6A8LGCPngGENTCao/+87GMWSI25/Ntu+svYGyLDuyEmBWWn6dAQb3
         19Cg==
X-Forwarded-Encrypted: i=1; AL+hErGgK1zdwbRqfkdTH6TlnW/z/h7mAkujrULEKtO4Bqntt1Gw3pOu5cCrovtgvfTOSDm6UEGMENQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qpkGXU0aGcH/niuwdjyJvdAUWNqTWINIK9Is0hAUqIEf6MsV1
	X3C95i+CqltmZv6UpRgjARhj7Z/S1ovHccm8AzbVKjZwyOidi9hkjW9ay0sRV7bfe+YyyEM79fd
	HjN2tXlJg9w==
X-Gm-Gg: AYBFou2ZCsEmI4AZdjJ1n2lCUXo7xbU7bnskOsc970hkf6vruC3G5vRJdBsLmkoZIJh
	yUkc28zk/Oit0pkHO4M9METdDK2ZzLi3xUAFdOfTDItxu2YN7RoRNjXyY/n2Bs/IpzG1wNbEy8I
	9Y2PJKpq2B+XFALgNHmbB61r1SZ7bWB6hItpDAduQt70rqxzxYG9FOaIL6aOP6MjbTls/9oI1q3
	g/4rV0H9ox0InQVSTz4U2Kmnfe1+f4Gg1oCN7ZBuupNdU6lvTs4P4u138eIQnLS0eWEYFKMY/s9
	m9S4mfX7L2j952JKnlOeb49jiZb6+79x5S/54frmC5xlhhE6ZwyEQIDD4M8KVC6WvIwSdaQ0GIi
	60anKdHBADpIay23yXlfuwVcnnJL9ilrQudXaWLr66G2uIAwvFWZqeAlBwPQBcQWJ57mfDJohnq
	m15l40hDmCZlycmZ853rFKoZsLr3uSBxts1ez2tpEHWi2ZAeEAqm0LRSIALLI4wE2r8ibD4px2D
	6vkuqk8YVBULcpEhwlf6dh+iOMsRVCg40UdvCyT5z1RQ+oOJ6jyerSrIS69mb7w+GdJZv4vu6C2
	leybUWVyzbFYJeTBjipVgiyqAHp3QXcgelqqR0GIeBO2OfxBzpfTO74Dy8ZSJO13VHXZ4wXOA4t
	T+U0=
X-Received: by 2002:a17:907:940a:b0:c3e:ee86:d2c with SMTP id a640c23a62f3a-c5066c8764fmr642966666b.27.1794503970828;
        Thu, 12 Nov 2026 09:19:30 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm565266b.27.2026.11.12.09.19.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:19:30 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso38624a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:19:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHoZ4/UmgCtPH8TirSgcYdcYf08Jf8lqfoMtC6AJL41zG8yHQHR+Xl3b2Ea3EbHXIJxKjInTqw=@vger.kernel.org
X-Received: by 2002:a17:907:dab:b0:c35:babe:ab44 with SMTP id
 a640c23a62f3a-c50665538e0mr626078766b.0.1794503550222; Thu, 12 Nov 2026
 09:12:30 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner> <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner> <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
 <e94bdf7c-eae6-4f64-bf93-0aeedca1a22e@app.fastmail.com> <32ad880e-5946-4703-9c6f-43ff59da39af@kernel.org>
 <3eb60948-8fc9-4682-87c2-c113e54e7d4e@app.fastmail.com> <4d6a3d68-3fc7-446e-9f59-f61d7475e22e@kernel.org>
 <bf186643-780c-40e0-bde6-f2af90404a18@app.fastmail.com> <b90d4bcb-b865-4a41-8496-78d751c03dfb@app.fastmail.com>
In-Reply-To: <b90d4bcb-b865-4a41-8496-78d751c03dfb@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:12:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTG_hWYC=a2+uu_+SeN4E1ra0n=ytGqyk83Yr7tDuEJA@mail.gmail.com>
X-Gm-Features: AclHuK8_5teM8idFuSWqym8O4N3OQPYF_Y6jfMJ_yh9uCx25qjwD1XBnjE0OwRA
Message-ID: <CAHk-=whTG_hWYC=a2+uu_+SeN4E1ra0n=ytGqyk83Yr7tDuEJA@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nishanth Menon <nm@ti.com>, Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 03:35, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Posted with a somewhat shorter Cc list at
> https://lore.kernel.org/linux-arm-kernel/20261112112528.1116405-1-arnd@kernel.org/T/#t

Lovely.

I'd love to expand on this kind of early removal: anybody want to get
brownie points by just removing the remaining users of the legacy
'kmap()' interface entirely?

I don't think we actually have that many of them. Almost all users
have already been converted to 'kmap_local_page()' and friends.

If we got rid of the legacy kmap() case, I think that would get rid of
the whole "pkmap_page_table[]" mess and the PKMAP_BASE / PKMAP_END /
PKMAP_ADDR games and only use the FIXMAP area.

                   Linus
