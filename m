Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C63EFFD7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021442; cv=pass; b=XaAHTLKO3m1Gv1DPCjxQ/K6ClK3valsx2eE6mMeY8XzFQCBSmVltnfXHMg78rAIGNa0NxCwDQfb6veqQ0wLzvJ+mK2xxK2OzEeBW6A1B96s8D3dzF+SQWqmt61GBAXKBgiwS6wHphZoyZa8Ai/X5YKcRLjAvC9QaAtZH1/RXhEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021442; c=relaxed/simple;
	bh=wGmrYl+md6qzRE+BCBefbC/d0hnSD5OIpXF1e6zGTr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fx0hcXRzS2eHNBaRTmae4WcjTGmhqy9S4gj+fSAxX3QEWK3P//JBGl89gdVyD7pJ4D6WbT6oTwESD4sVAr0+qTrOsyaEK2OQYrpKY2UhyvLRd7j2HIjdsB4sBi6KqDgP/KlkayfEmKj3VFH3meNGADhiZlHIA1rSa7PqkxyMAGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHIeT+st; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHIeT+st"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53122c5bbb4so37370431cf.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790021439; cv=none;
        d=google.com; s=arc-20260327;
        b=jqhYAFyTtGa29GKe92rvyAl8PGFQayDByxU9NGQWJQbbyiTHgMaMnlsmhQxv6vV799
         LOk65wivIlLyWHApL3iUmwwnomfg/L/CQkUxZhjCiWQOrHl1Zs5mQtjEn8AtKRlYrxiU
         mrmJKUd66lBWT27CitnJFNc1eG+SjOtC4vZC3+NAZoWDkOA92urhMVClJgzfNs3lBwLJ
         ps5lDY6wZ7NCU8kYMy3Gbmy4GXh9zkRrcxaHoLF9slu0XO4C5tl7Sf0adkKh3C87/NXh
         hLgy5Lg59aMNVnl5rxtEL1J5ZF4wPPG45fyV5oAmCAr9TR/Bf+DBPKRGGRRCA5tUhTWK
         efrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wGmrYl+md6qzRE+BCBefbC/d0hnSD5OIpXF1e6zGTr8=;
        fh=FtNkcQ0gnBHp9l9uxENktWHdzI+OCXSPuz4XVBMm/wY=;
        b=iquk+HGCdjxiZgbqh1vRSMZ459/1Irr0rfmVOdeu1rz0YeOzIPug1l8i4ZU34lRcnG
         t6c2QbpmkYFGy0qZPPd7LU/l5a0S5DqD032P+q+iJAQ+7RSncs5yZ6BGTxXjjcsQD12h
         jKSsJEJJC63HNw1iCMHOwDNes1mU8gm18DWmur6TJsNO/qbp7DuGFF3KeMV0yaGTpCle
         /xEch/33V/BP8IE7lXjG421Hik/rt+731FdX01ZTFmNM5aQJqT/FH7rSKiVuIEvy4INd
         FyqV3F80swJVaOy5f5utl6uZkIXcBAS0Khfu/wpeeGasYbuZ1zqhEqj8m2GaxmPONOkN
         XOgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790021439; x=1790626239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wGmrYl+md6qzRE+BCBefbC/d0hnSD5OIpXF1e6zGTr8=;
        b=WHIeT+stQIu3b35WXuwZRqw+usQEAKCuRhh1WPmZzrC5kewbH16e4n/wlER1894Ckl
         Aj+q4ht4G/iTC5l3/6e7+TsKl/TiottApxc46k4QKepFcNekNiqrH03TjL0BfCvO9KJb
         CT0B5ta+iY4nAD4VsEAVOJaIo2oZTS9ikl/E7qTLygJIKnkcMKeUI9C3XjsSITVYbkfw
         cmovh/S0AsxujjggiW+qVDFKkoS4/V9C6BeMOn+9U9i0t6tpZj3Ci2vqG5xoW3bVSQ0y
         8ujr4twujDcobqMD+XB5hdwZuMlcTlQ9PuqujNKYXJe12/7Qyq2GjrQoul7C54grgfeW
         tVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790021439; x=1790626239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGmrYl+md6qzRE+BCBefbC/d0hnSD5OIpXF1e6zGTr8=;
        b=Ja+V1vR3jeE+IMwvreHBNgZDMqge5aG7lZaH1ZS6I7X6T21J/Ub7ys3pMLO2q/NoYV
         5siwwgVfYpBv+jK48fwX+2+Adn6ZRzm2ZFd+WvRIgCDhfm+qdiLvTN0DNqiNSwUM1UZe
         tmlie4r0fZfwaY+E3PGPPT9b76wcGpWv3i8IAZ8NNywAu34eqQhEPeuNoW2WZZyU4OWg
         9yoiC7uScEjLxiMWwBBgGwu3Mz1qA9oePbKkd5iipIqsA+KiVZVbFCa1Rrhu8rxKYGZZ
         vpHctdWO0yRWNWTrP+3Z7//ZhUMYp4HM1kgZsSsclH4qtiLvi5S9YfynG54rSk1MV3T1
         WnfA==
X-Forwarded-Encrypted: i=1; AKwUvBxpb8t+noo6I/MSpib6Ab1mFyS5vBPolAllSAIS7/OKJS/P8AvSYVIju2DKAz7PradWwG2sw8M=@vger.kernel.org
X-Gm-Message-State: AFuF++llFWSPxKxG6nZquhJEJHEb2qAyP9tWoywyvo34Bb1OFDbGT3f4
	ADo4teBAk2K2rhMzHENBtcQkrkuAdhBtXi3HmWj5lx1taugWJFuiuuiyIEIXJ6qqMTHbkPifT8z
	RJj7k34IAYed2+3WdBBzd5h3qiNcEQzIxHvePKdAG
X-Gm-Gg: AYBFou3j8eJPRRb+pRn1HAZsPLd28m77g1vVhtJjwE3wzq1S7Wwopij22yt9IWn+bAi
	Pf8z64VelTryEYDaONku8CEYZrUsj8eRm3c/aKO8Z+riLMjwpd3JtLmScmqluxQH368MoZUZTsz
	BbkqUUb27xrTJPrm8+kfoqh9vv0KhzUvl1Vw6LmgLoaXlws+kGqHVqj50B6WRBkJ1hBmEZXcjUT
	F/g7PYSpfBAaZQoQDkCBuUeiBXbn0tbXk/g7QpqFAeRbFE/umNeUzFOMA6wwQKJCi+i1HtbT8el
	m46Lh8VkmQ9KzOHyT3XzV9c79evnJ1OUnzHiQ75B2JVpWGEKzgZHJaahT89fbPzgJTIUufFBvax
	h4B2XFY7RTy4aQAtdp8j+rGTRF+kdsGGJOvc853XQleMQ4iP3TbqSJXkHD5E4A9tkPivsnA==
X-Received: by 2002:a05:622a:1dca:b0:530:f997:a93a with SMTP id
 d75a77b69052e-532d8d5d490mr26059311cf.21.1790021438863; Mon, 21 Sep 2026
 13:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com> <20260921183758.1812310-4-edumazet@google.com>
 <20260921130337.57d93c2f@kernel.org>
In-Reply-To: <20260921130337.57d93c2f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Sep 2026 22:10:27 +0200
X-Gm-Features: AcwNN1V4fAdoLkuhP_ohzV1iKc7cKh8OpETH0R3r9D984J31Kxttli50RgYIKMc
Message-ID: <CANn89iJkB4BERbG_7yCmvguMdTcJUBzpM_Dkas+L2LnB6nraMQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: ethtool: add KUnit tests for the
 generated RSS key
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 21 Sep 2026 18:37:56 +0000 Eric Dumazet wrote:
> > Check the property from the definition of the Toeplitz hash, independen=
tly
> > of the way netdev_rss_key_init() achieves it: an aligned block of 2^q
> > consecutive values of one field has to land on the 2^q queues exactly o=
nce
> > each.
> >
> > Four checks and a control. rss_key_property_test() does the algebra for
> > the named fields of the usual hash inputs, rss_key_grid_test() sweeps e=
very
> > 16-bit aligned position of the key, since the generator does not get to
> > know the layout the hardware uses, and rss_key_spread_test() hashes the
> > inputs of an actual burst and looks at where they land. The control,
> > rss_key_checker_test(), feeds degenerate keys to the rank check so that=
 a
> > check accepting everything cannot make the others pass.
> >
> > rss_key_alias_test() covers the other half of what the generator promis=
es,
> > that no two input bits read the same 32-bit key window and are therefor=
e
> > indistinguishable to the hash. It sorts the windows instead of comparin=
g
> > them pairwise, so unlike netdev_rss_key_init() it looks at every distan=
ce
> > rather than at the multiples of 16 alone.
> >
> > The field table includes a PSP over UDP over IPv6 layout, whose inner T=
CP
> > ports sit far past the plain 4-tuple, because that is the case the offs=
ets
> > of the standard layouts do not cover.
> >
> > Commenting out the fixup makes three of the five cases fail and leaves =
the
> > control passing. Keeping the fixup but skipping the redraw fails
> > rss_key_alias_test alone.
>
> Is this AI generated or do you think there's some genuine value here?
> I don't want kunits which can be trivially re-generated during
> development to be merged. But perhaps there's some genuine value in
> this one?

I added all these tests because Willem wanted them in our internal bug entr=
y :)

This can certainly be removed, although I have to find ways to launch
vng so that
/proc/sys/net/core/netdev_rss_key is populated.
