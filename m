Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CE375ADD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021054; cv=pass; b=JOshi5pjFlITUblEn8CkxJbnTKVlpiZmN0Mgk2d/hyPkYr91ge2CPDI8W5oMtDxydyVIH7Vzp2mNH3H9d36yjenq6E5W4GJ1YsIDVyykxM6//pU7CtYUjyWSXwTWKvZ5zMLu7rnY8hPvNT5f5pe2553USYD/y+iYS5i19zasYXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021054; c=relaxed/simple;
	bh=i1hIKArw2z+oRyEwF+V+cdHrigWrPyd0/+gIXrg+VLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZfUgJugC9GqdD/Wdq1GeNnf786CszLhoLe5xSgN3oxo1TwJk1yi3wvecVlfqs/Cw2ZFj9Hcl8NfFfGc9X9kFL92HroMd5ilKZTJ2xhyMS6HR5C7pEqBw1TWkgEXhyCnklWXIxN8f7bJxynqn43Yh/LUhDh1PIJXXZoUBBiBZvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rUj/Au9P; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUj/Au9P"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7e0bcso39575811cf.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790021052; cv=none;
        d=google.com; s=arc-20260327;
        b=m8EZbAsAII4Z/VpiE/TL4ppZDvOOYGTNcjwgr8Ae8UWCWYgcjc0YB5ezNZ8nvFSChQ
         Q2Si2YhZKQ3Aa/mzQMvW3DZed16KKjEw/cSt0IzGsFiuoGFEcoxizr8FgV24jb+xkuWi
         hsZoTYokqpKRYv13ljTJbOqRzVWZacjir3RxfgBgR3M6+W6N9bvM9M2DJpD26KcDn536
         wP+SMVSrwnXEWc8JYbuO0q5Ez3iB/PAGZ12Nej1vf6yoEVHQKZ323NwGq8XnBVSO+wB3
         pBgAd6/dh//cz9ZHl6Fl/0fTSMn7Oklpg+jK5czHNzG5Y9U+lod1+oATtWkagnbqkiQ4
         i19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lEH4ebTcTbhteVaH+Ss5zVtY9kBmL5YvMqSSjEmbtGo=;
        fh=PTi0G8TaCmlngphbdE6Pf8i2hSOpDNvbfd5ek84ORMI=;
        b=eQeqEXE20qeZzS3aVO6woPLyzJw0ypLiUrNlMlsdxKDbKcxE7ykdh+O22FN1D+t4lc
         GXlJrPHRuRuxn2IgjorlhGHXkcQrIhmRDe9wubsq3PWyLI1GjflknE/kb/JII8b6cVYC
         hmz7EPPiU2rsY7BlYxHJE520pqg1NUja8QzDKs4f9ltKLmxrAxq8/m8K+oc6FdwGFhoO
         gQaKBB1iskh0BJEmOMsSEXKAox5ejWs0KvwnHmzB4FrGAaQ4/7/p3u1r/1mq/TQl1Qwz
         R8X6QfiZA/8q46u3lz/18lGDC4HKZ3a2VtEIBNTB3Akmm8ZpNbkfGIK2JR1j7Dzlehbe
         /ahg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790021052; x=1790625852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lEH4ebTcTbhteVaH+Ss5zVtY9kBmL5YvMqSSjEmbtGo=;
        b=rUj/Au9PU2dKHVbMBJ3Fqfwdd76b2TwHuMtjIjr90dcN1Xg4rPckOZA3Wnm0zFIaDT
         6b1aHpV/40Xo7R7vwvWR+OVeeNIIn+lTlZviOlVpTxPJmjczj8MQ+UJ+ghXISUHPW3Z9
         SfA0lJQL8yu0ORMpVEEsMXfnff8mE0BGIV8OYd2Xs05zRneAbFvqv0dnPcK98kT8/7ol
         m746dJbQFH2eqTqarrNA+T2jyC4p0ByLBGwuYutvcMKA0J0hr0h9JfWVlYZ/CJoYwQF5
         PmyZfUvjtsqqEK/BqouzKlYbpOpyXPMcODyYCn91EOf/pa9m4ClTjyopRBKhrfUEjaca
         ATpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790021052; x=1790625852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEH4ebTcTbhteVaH+Ss5zVtY9kBmL5YvMqSSjEmbtGo=;
        b=CGAm/ReauS9WO9hPBXbYLqQZmH4SZstY+kertw0flMPGnPkJOFmwQQsYUx4pAuxTQM
         vzDun3Cp5U3ghTb076lecSFzwHRkD9VQQ9Sor7KujUbRisDnisIrm7piYhu1ct8JTJyz
         Lw40YQrODINb5JDjQ07oS8OKpbBkssZRy5UPijS/q0Ga6F9b7B6j4glLIwy7Z+rBkyLt
         R0KDpZufxZDgWKW861jvood/dhsgLUXEuG1FUvf0QdOgeFBgs4RYGWriTIuVuTdpqDkO
         NA3cGRHvtjmdpuE21n0p5YiRYo+ESqmYuXHlA5X1p5LVMVHVP+WEptNAYp+OSptJ1vby
         o/VA==
X-Forwarded-Encrypted: i=1; AKwUvBxpfD+1b7D33ExaxSH2rGHiAtco7cxPyoQP+ktTdsEaD1WL8hyNyLNKrdoWbC5At2voFSKLEew=@vger.kernel.org
X-Gm-Message-State: AFuF++l+FlaCUkt+KOnw8Gn2Ip2mxjpnrRbKesPaUyTns5PC7wZJsEW5
	Edh7df9tJGm1GoUjdLvnLQcoZjnWyrDmjbbJyrVGVymlUaQ9szPcQfv/kEPr+zHZidqbYWoD2dz
	0+wQ8AEoZUuJ3VYM6iWC0ahJ5vSycBYQQl/kOFQV4
X-Gm-Gg: AYBFou3TmJB7ckA0pK9NLzISB54g7ffNflM/o03bvVYKnuo92hMdVTYyZzQbg1xLW0P
	L/FV0nzFzJ7FTiE20+zdGnrOguMMYyCaJcjNDyAcAx1UPogHGTLjzPdSOMGHYHeDA8vigS2FjjO
	5MjEno87/1O5WXRi64Njz7ZMcJox1ytoDCccskt7M2UBZOL5PZT8udQzCxkFNnJMefDSJS97lCO
	awBlyys628CJvdqf+cHrhO5nVOXGU7FP5VviQjdA8lCf9txopD4IM2Adje7be6WJ0c5mp9K1Gx2
	dU7ldjLyicAMAL+osWK/BxFdRkKwd93DSlEmEiDh0IvNv8EA+uF+zGRXaG0zTGSocTBZSZ5NF97
	P8M3DEtx/epZbBypd7nImrLtHfBzdRsFc24ha4vBm9ZEmiPlhFDMRcliJ5vBcn0E0PVYQfOZoDi
	Wq8JWs
X-Received: by 2002:ac8:7f51:0:b0:530:f214:6240 with SMTP id
 d75a77b69052e-532d8e9673amr22547061cf.60.1790021050919; Mon, 21 Sep 2026
 13:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com> <20260921183758.1812310-2-edumazet@google.com>
 <20260921125156.6623d5ec@kernel.org>
In-Reply-To: <20260921125156.6623d5ec@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 22:03:59 +0200
X-Gm-Features: AcwNN1XZ6GApxcSO1p3hsnJPRV7dB0YyWJ83hX_ptyaH59Tbn30WGWsZA52hWMI
Message-ID: <CANn89iK-+qp3tYmphZO1q_5s-UzOWkOt+u7RN2KZqjxJWuNVwg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 9:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 21 Sep 2026 18:37:54 +0000 Eric Dumazet wrote:
> >       struct ctl_table fake_table;
> >       char *pos =3D buf;
> > +     bool initialized;
>
> reverse xmas tree
>
> Maybe we should call netdev_rss_key_fill() from the proc handler
> and let the net_get_random_once() handle the safe init?
>
> IMHO the concern is entirely academic / hallucinated so adding
> LoC for it feels strange

Sashiko raised this issue while reviewing the second patch:

Apparently the potential redraws in netdev_rss_key_init() was enough
to flag a bug in netdev_rss_key_init(), without noting this was a
pre-existing one.
