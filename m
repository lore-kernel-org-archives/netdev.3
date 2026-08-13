Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3D3B6BE5
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613577; cv=pass; b=Uf5tstGOZz0GfIoip2D5ErYkLTH8eJnxZRyNa3suBa+zCUiyAb74EG9wD5SdsU59ya6XLZxSbwRQ1YzorMUmT+wTqvTMOhHhF9acm8USomg1ndw8n3HlRanoiUOb6SsOObxuR/ARC32y7lfGeW81CyK/D73TieXg2yaRvGV3Dn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613577; c=relaxed/simple;
	bh=hxPH+ehBPzRCWk6w7xeKnqdyk50jcH5XyZCkn0NKK1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omtcjjLfBdfunTrjy72wuw5ala1mevCSAISm1jmhcenmyMVgn84w8Vm20l+/d7YFH2+yAmqrTQKCm4uct816HMej3YanPrmL1fnfxnmhp0DWcYwWL77x7Zih2ugyl5a7vwhQ7XTZIJdZ2pAsZ3ryaSfQT8XBBleXB1C2GCv7U4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki0S4C8W; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki0S4C8W"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d01548ac96so3665805ad.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613575; cv=none;
        d=google.com; s=arc-20260327;
        b=Vbr+REEoMzUyE3YuOesRMtbmP1YhNYaaL1vFY4ec5qTQ46Py7N4hKl4h4QuWdPH0G1
         EWoJq+diBNSvwTuaI8biq86GWyvG19n/sxq3FjC7+eTHqWeP8U/CfYRd40O8HyJKVroY
         W4JHc+6RB9UJdBQvARQQyv/vkcB5eoiuwzAJJMKvd+M3I4jKsCI0R2265p1gnvETfOSF
         OTkGAgfKdA1rNcO9UWkpyD91lFtprTvFhHj789PWP1fGc3LWa836KMHbQHE0bLhA7wlT
         LUnpnsWmHAr/m8Y3ugsMpoFYTyuO/8P9Jx9deBU4l2fSgYc0IOqbzKW5qHjHsCD2bY2p
         qY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        fh=A8mDVVTlUI9d9GvRAtkAXbSRA2RIsYFFEWUiruCZn8g=;
        b=jKZ5TM6G9m6ms6hn8Q2mEGh+KGMBWeyS38MxnMgSMpxropMdqs5p0wlAr2poqOteLI
         Xr1gj6wPl1ZwNZUAY2zS3VY0CXdFZUzi858i8j2KpLLWrpnU64jfuxhRnRezhWEYP1v4
         +oNAg4+ctv9P0ZjGmfPk1jMgnQAJkvD/zoBcJv8e6KVXxDAa5GunX/6BH75KJoOu9jN9
         bddeBUNfv1+bsfZYb8PmUHfB9hmTOUaqjT0nw4K+ll2cZn+vGv/ppMplh9C9b7EE59u0
         vUTgoVaD63e2plaYZiqXfE2FjowmzVahqo+qbdzC2+nLIfTFdb6N05Tn648pPFbrBvlO
         OIVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613575; x=1787218375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        b=Ki0S4C8WDWmasGaotvQ0nFof4wEoVQlo7An0ov6Gl0rUwXMSgg6XVEXZo6N2Goo3So
         O3/FgHe2UfkWJy/r6cN/eGa9shVxGjV8+Bh0wg8UFrL+p1qKMHJ28Yi8H4mkSOrl47YM
         3nAsY5Jw5yPDE6Tl6+UUx8L50Nw2GceIHZWxlSifOIY0qi81DPGXV1vCFZR4MyImM3S0
         9XraUocr2791q7nmxmZZxmE2r7aJ7qIEatOVqrjx2Orojbo0aklqiZABVkTYQ5o/JT0+
         DMg+Ns+B/w++Om6XoscYdrCTs/9WeCwcfWy+JqozQyENao+7695ruzUgy5KCSXK8V5Em
         h96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613575; x=1787218375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxnZHFdFswxuxe1B8yyzSCFANjk8+GYT1StreigHL/8=;
        b=fCtoUjlcVc+XFtIJx7R6QgphvI3L1DLlnVULFc8mqAN3KPbTsb/uaOJWC8sHq9EwK7
         VOl5qP+I6q5B40zmA1LUX9X+Dp3jrwS/xZfx8zMDGe3+ZSf7tI8LsgRSWCMq1U/xDddV
         6YrKFBoTAFvhuzsMmrrkvx4sk7KvZwoVSdTKb0EkUcudpUQwVy8/Skz+vHVzDt3xZJaw
         nwKoSm4h9BZjPA7xvXVoWbom2e4U+IrCxkCgpmzQhYp5xEjpv74P2RaJSwJYjMGHyWt6
         gI5jitrqc0jXuo25ZpcjUM/wpqLSIvmRXAfh/R3K0TC49fe3y08VA2cM2OsHiWz5DF/a
         z6BQ==
X-Forwarded-Encrypted: i=1; AHgh+Robjz6B5sEKQMnXhT7QCjFTybCYbhkf7OfgLNBCTOzUxw0m6vG7zfyvXMTHQQFHaoBwHDPQIy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuLBUomyAoZfljUH9IC+hsurrE8R5PmNUi8/O65riTq5qkD7u
	UU+PU4SCMWBdyNSXm8BA3g6eu8uqotbjODzwaw5fYTZIkn8OU1Siv52W313Tln1sE82EFxV4Cns
	4C51wgD6TuN8xtFDWWVJJqn/JRldlcog=
X-Gm-Gg: AR+sD123/95yGPZk5ybG/mHaHq6Gn+P47d7641aLUdo2nOEr6AFXLvRRJKNECeX2IM2
	lIn2y4wJPhI0Uwrxb60AZLy3/YtoYQ5Ps8v4o7I8BfWiKy0GNx1ErPXU4z01zBomNVBta4Bbswf
	rtgOEVp4hVpr1We0BSk9bDm4vJgA2whAE6ggEcSya000pxy2+hMNhdBvqsJryOExUt05OzGLAqa
	j4loTYp5V3sFB8nv8UiHp8VcNBPtBVxMlve8nSxnG0M4VVR7PmwhyiJwv+5mgfRMQQD0MTETomK
	JWu+U3NqUy/5QIwGX/RKBSGDL0qh1qucuCqq/Jvkx9fDNSnRi9eFFgSjHV71kChjB3J9yL5l9Is
	moffJ8VxMZF8J8OXB1I5Jpq+slFYg5jLkM/7pKBF3bNbDZ56i9F9KIJOjifTFww==
X-Received: by 2002:a17:902:d4c1:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d389a366b2mr27617905ad.2.1786613574868; Thu, 13 Aug 2026
 02:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org> <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
In-Reply-To: <DKNDF3WD27GM.5VP6RBRXZBUS@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:32:42 +0200
X-Gm-Features: AUfX_mwSjTSmX5g9cpyULDa32fuXt2Yd5-MIkCd-iXvVUBlQKiet4rzS7F5uPZo
Message-ID: <CANiq72=SP_nT7Z6NSH-GT51-8hJ8qLUa07Cs+SarSFTO9Z7vUw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>, Alvin Sun <alvin.sun@linux.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:57=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> IMO this is the correct way, also consistent with
>
> https://lore.kernel.org/rust-for-linux/20260811-fix-fops-owner-v10-3-7e71=
776f9dbe@linux.dev/
>
> It might make sense to add this to rust-next.

Yeah, it is also consistent (in the sense of adding a fallback) with
the other fix I added when applying the series for the `macros`
doctest; and the `kernel` crate is not an actual module yet.

I guess yet another solution would be to have an even more local
fallback, but that would be too local in my opinion, i.e. we will want
to use it elsewhere sooner or later.

So I could fold [2] into commit 98f256e27262, but a commit on top is
fine, I will reference that commit from the new one instead.

Ok, done -- Danilo, I took your diff and converted it into a proper
commit, please double-check you are OK with the Signed-off-by:

  ec6fcf8a175a ("rust: kernel: add `LocalModule` fallback for
`#[vtable]` `impl`s")

Thanks!

Cheers,
Miguel
