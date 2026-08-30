Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FC3BFACA
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109092; cv=pass; b=Z4+BIepuyzVKWbDAcYCTI0jphrrsJhzdM0nN8URHf7VKa/FdRDpfEk9X5UJTs6HKWjX5X6pT7gmnBS1o8R48LmUvVAvosykLk0wCvQYDAwjrPJwu9s+CVzGjj9l9dT6/l11hh9As/2f96r/7mZJP7DMQr1Tbbq7c/+HbqOeLILg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109092; c=relaxed/simple;
	bh=E815F+dIEHf1oXFrp0h+rhmpQKySt4t8/mljLKMC7bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/lkUmOrGWc6He24VwI9TYpz4brkpeU4zbSR+0tKaaaU29cZFhWanHPJ3B0hsHDBjexXF849HoyCjaCBgADIOFSEfDd3QZBMjXP0mzl2hnRTJAawefhKYPOAZ1zCokMHkEkWuManKxVAW6sUUA/M4B5p4k6us2n1xetQSc91yUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkmT2Dm7; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkmT2Dm7"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10e86e52so209681cf.1
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 09:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788109086; cv=none;
        d=google.com; s=arc-20260327;
        b=AhcfARvYxgWERRGccnwD3Zh2ITbcHwfVMKcXIFXcnN55fHOyY5NCEV779YCO8G0FxM
         7b/1J6h1LYJsgD2EnsSZ5omauF0mMWgxSfnB3IQoTBPyoX4gwcK7bU6d/ncfC+mAcjKF
         tJhdo7dU4ulteWql0QcRyTvGUqAt//k+5IRcoh91UdgYZpsQFc9p0exu+hYkZFkacYfc
         qsF4mbkZusXMIeDubGb3a/Hp16eowKMvJGSTPVnykSfBS27kl0jHUjmFFZf/O0tq99IA
         zrrZc4MOW3Sqqc5tk9SzYonKMB8OVqCdf4fbsZCracntc2fniYzRkbI4vb6cl9Z6AELt
         jH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eY6S1CuOxppKERshHyMUDaMx3fFTWDyqBYaQ5/cHRXU=;
        fh=V2Hc/lki7p4tg/Z0s2tZ/CC/o7v/tQw7j+zIPprHYow=;
        b=qIP+1zPCpKCcopv7Cf4qlbcQ8fSfr3EV03DiV/1NBKgiQMnjPd20b2DyVrmNXnqQIY
         ICdGkNyxavGRvjrR+5n8hYZRky7tAVQnoEDbnh0R2V7QllItqrFhuneN+k3FYDS1PDkh
         Uo6ctLu93ef+RZ25VhZRSa1pQl4YAWQJXKic+CJSM0Nt+aCYYNuqTD4FyZN6n3AElFDY
         B6pSd2DkjfvWE64nqoG/1DQgxlfbXiTDD4jJl1BKbn6CVZUb6FkHMpAL5QPwLULgd1wV
         W6zK4M2/vUa055rxJ8OXwEyCX5nbd/mGQiPGYtIxI/agnrzZF7ns5gB/pymbZApYoLD0
         4huw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788109086; x=1788713886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eY6S1CuOxppKERshHyMUDaMx3fFTWDyqBYaQ5/cHRXU=;
        b=HkmT2Dm7x5H8V48D4QbjMtUKO/kKmwAqc4NXTMBQP90uRZLasNJ5zGKnzu5utSdMGm
         BchOBT+zc+qUK5Y2BWS7ztc7zSwbFzJ/c1b7UvUPQBKhBxpYNEVElCjIom9wLGBOrFKg
         X5rxv6IEXkS24RpzwFQ+jcDizGP+UY7OKaXao28/3FjTw2NvFwa5MILRYrtvQXIdfa42
         8zY+ErqpwI1wZsP6qUYRxub5IScmbZJF4YBhJqCw+evFIhmmRyxAcOMYjdZMZKRyThvH
         0wfAYpy2BWywYVYUnZc+c4hmrJgRslUUsQQesGp60hli2+oSB7ZBba954Bom7xA+I7KD
         24qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788109086; x=1788713886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eY6S1CuOxppKERshHyMUDaMx3fFTWDyqBYaQ5/cHRXU=;
        b=mT6P8155sYNnO66YuSbnMhx+I3RSg4ESE6+XCRnYJmkwuE7dQEqwaJHCOJFzW+41cM
         36moKUumgkrobQSiNaJQ/swKhhc8gYEszG2LsYdyLOitC5P8fenuQqh5vy8SJRYyLnoK
         oLQQ/8xbfGREqeJ0xdDgFRydHgvqzL9Y0PUTjy2SxmSUNXUVOEWWd2fuh7ODqX18yG08
         rdVpVPV+WzCf8P+msrO2ycNx4sVDjXR45TGd0H1vRtOjGvHnzJOZc+aEXn7aVsG7M1lm
         ooUeLiprKStnJ7rTwlxEduhE0bnlXUnqwieqvIiNzrB6gY5aJBuwzjafP6VfcX4KxV3u
         Xy1g==
X-Forwarded-Encrypted: i=1; AHgh+RrQY72crxBtb23Xaz+h0GZ79PSZHDWS8lkv+Q8o5scFK/BZUWBj24VEgmFx3MEF407tWsZAgEg=@vger.kernel.org
X-Gm-Message-State: AFuF++nnHVzzC2kVdzRO9ogHoOgOuY2OOY/Dgi2tK3p1wbVgwB5zrK30
	HaeGdeC65G37xxm8qjDCmx1ZiuW46oUH1LMXrBq4PZQ7yWrWI36xXQD6k/3Qod+CZ8lJsNbKfhN
	s15iDMYoIPDn0al/5kez53aibGJk1wCFopCFKsiNX
X-Gm-Gg: AR+sD13ZLGBsKqtAhSjrSi6jJ430C1OQO79l5+sLcSic/g1SXS1uWfBnUrGrztypf6o
	hzgnXuZQgFnVimH4mQlJAZ1Q/9m1pjn0eYbAEFHJ0JbehrkiarSkwna6DXdj7j0fn5J1RXYhZZN
	ct2f3WruMif73kndC7/5koiJHXpZHE6zgZxhCzgDzz/MTAooF/XBulnZ0Sh/QkWVq7Ri+E1tJ8I
	VxOWBoB45nvi4VgzKO5+cY5bKB8XAVb7Pbt8nvkYDfcqZ3S2hW1C9XpUV3kIdsz84E2sBEP6aQN
	ncr3ON1we9w5QATy7n/QcPZNANtutxUFjTwgU3Ey0d8=
X-Received: by 2002:ac8:5a4d:0:b0:52f:6e06:89ac with SMTP id
 d75a77b69052e-52ff7392cdbmr18296591cf.13.1788109084962; Sun, 30 Aug 2026
 09:58:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813193433.3318288-1-surenb@google.com> <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
In-Reply-To: <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 30 Aug 2026 09:57:53 -0700
X-Gm-Features: AcwNN1Uwp2PnQgLvcaKuLpOXbpaoKSzdckjfmxjUMDcpe7gynTwxBKZlGUetcPI
Message-ID: <CAJuCfpFtq4Y-dDXNHJWDEXayhyCqqjTdJUCM3QTdbeBB1rXUNA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
To: Andrew Morton <akpm@linux-foundation.org>
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org, 
	david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com, 
	cmllamas@google.com, christian@brauner.io, tkjos@android.com, 
	dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 6:56=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > v2 version of this patchset [1] was written by Dave Hansen and per his
> > request, I'm taking over this series.
> >
> > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > of the per-VMA lock users now that they can rely on them being
> > always available.
>
> It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.
>
> But it applies well enough and is adequately reviewed so I put it in
> there for testing, thanks.
>
> AI review might have found a couple of pre-existing binder bugs:
>
>         https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@go=
ogle.com
>
> and a small rusty thing which you might wish to attend to.

Ack.

>
> > Binder and networking folks: Your code is the target of the cleanups.
> > I'm cc'ing you now on v2 because there's emerging consensus on the mm
> > side that the approach here is sane. I'm not quite sure how this pile
> > would get merged, but ack/review tags would be appreciated if this
> > looks good to you.
>
> As said, a resend might help with this.

Will send an update on Monday.

>
> More binder/net acks would be helpful, please.
