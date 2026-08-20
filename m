Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B14398F0
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226151; cv=pass; b=ePNjYuvUXv0zzJPlFhYMy+sSLmy+rIQR7NAsi0PGZpy4ESP+V/6YB91c1+sn8rZgpuahuz40tmwoqbp4wm8q/i/AXsVUyMPQociDDU025Ez2gvkp9WMPC4YYN8iDwqTJiIjswFmfYzlEBTquMry2IfO1fO4y4EO3fn6ZhOf8GvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226151; c=relaxed/simple;
	bh=OPIncQ/ebj1NDzn0CR0crT56MTwjKetzw7gQ/rjS4rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2R/vE1FJbBw6CCTTuE83/yOZ6+e0y6fiPDwb8zK+aEfBvWqC1CNPJ61ABJWo9cctRK5tRvlbBHMoTKqPPqn0pdAey3C7EgAkDZP9lL9rJa4c0gsf8dDfTmc+oibJ7cSLFmT41ccaAlUFQWYn2x1hYiKRTQ+2OSbKu0slLy7HoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhPiQx1a; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhPiQx1a"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b3119957f0so2413532e87.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226148; cv=none;
        d=google.com; s=arc-20260327;
        b=U1TcKKXzeGZj/u1V3HspIqItHZGPwp649O6xxEqJ/9YWh0odlWdiphK06cvrnhS4y4
         WJgJpfEUmd5EcNuKJzGEnn1UPuCoBwp7Hv7SIJN0DFt3OQIxEONx6lnXzycYhTpFMP7m
         0HmwebYAtuklYD2NUazn3XNNnL8w1yT3ytOpQ3oE9zcxkLqhyX21mSaN5s4YeHtaWU6V
         lQ1Gh7EGh08xFQRJDkoBzO/AltUTKxtAuF7pEcClNkHcvJWSbMICxBAZsXuGsq1kZN9e
         xfHlkZ3oyILJvSyYaJuNIv2FWFE3Bt14B9iJXv8crHXeGLeuJ9LgKMrtnwh3PZrKbYl8
         n9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OPIncQ/ebj1NDzn0CR0crT56MTwjKetzw7gQ/rjS4rU=;
        fh=gRdrq3V8f1DDIrDfUjpXsqf1rM1NpHpN9ccNqVXgZY0=;
        b=sO4FSY0Y1HXcMXWAIaG08bvuGV7EcdyuLp+fVbU9nF+WpknmHSVQimD0dJMUsO5LBr
         ixauKfTbS9TTBnffHwEkj4ieRSV+gVsSAjvj/5B2gVSAv3dnnAGGncN1Dpz4Ez5/IV6K
         M0UkuqOIKgTqq/WoXCibn2y9zQTk61yC343doWHa7waTm2LBDfdgf9nzWA6RU0tpNYh5
         GuoP50RygY6KgHkBEedRXSAxoqdamEZ0gh5e/++2br9uYjErpe7KNsEUUTtaqJT8LJ9r
         umjPhN2gkICBnDvYGEfI+yblFFQxz8Fj/4Ao/fr5q3Q+PooAaw0Wv2IatJHIucuxnzGq
         77Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787226148; x=1787830948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OPIncQ/ebj1NDzn0CR0crT56MTwjKetzw7gQ/rjS4rU=;
        b=UhPiQx1ajQqhPCYJPdcpbzioZzRc5Sb9fjfjlgZSFUa1AXNcUm4BImgpn4W2bLy/UL
         3ziQNXmcxitpHT5rhZ8ZXrm6FWgWk1lflfmQRh0Q0RB5Fw8t9Mvttz5u+XIWFlwKTnBN
         jH72tUwjzEcFAAS//1/OHbqr3h5Oj+bbkNwKmuc7GsaUhAqq/uYXlXIqV7D0UcaWc4Qw
         tLWUez9hQkOndxwNzCJSzdpCeQlj6yDiMejuSuedpzLxHYx/bZujqYTm5Z7vyc1STUlj
         q49gQBLkRjD+hMWnwT4vSOitCgAF5ur52nr7SE9DFEMylX3SiN0IZRlxnp6OxJqRjM3N
         aV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226148; x=1787830948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OPIncQ/ebj1NDzn0CR0crT56MTwjKetzw7gQ/rjS4rU=;
        b=p0NA7QUJ7xRfTk83jQXg7crxOtQgLnAOZ36w8t4PciiFHhmb851sNWzahj4KfQviKZ
         jbKyjEHHSIq7EuVJQYvmlF7z7a7yvWqSbNLWTbl9dJ4xqIAGTrJ7YVb5mrD+vFGKGACn
         IZ7iyIuTlADuo9X3xX4A8h1Sel+QQk8dTqqvmN4gsdWZJ/yipEI81Hrrqx/8CMY8fuHq
         fCAE9K2rB8Cxu8rfiEgM3Sk4+ENnSpBhwD2QiFMU5NpNJN8GiEYf5ZTEprsMlopFyDSV
         KjVULU4+H8KQDPMGsTcR7+BN0sbr2hRlj4SjASlzdckQATOgduXe2gttjebQmbmUgDlR
         Sj9g==
X-Forwarded-Encrypted: i=1; AHgh+RrvGWH353w7WCazgHvpMlui8lJx+KluIbECbFX5PjbiprDgEjBkvdMm8FgaBKfk+I9dOc+2vXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5499KzxblY5O9SuceZIJoCcPkc51UJwXjcsG/Mk9XyxBzwnY
	Vyw++0ezziPLh4Tj6uMz6VU6NHRabc6mU3F//VrHizqYrKQmr78azybYYUX1MJTFyqHcwuUDBkX
	6bHdEJt7JTlb4xxVxU52/VVZ5mVoXjnc=
X-Gm-Gg: AR+sD11QiAB431ehxheZ+Ctbk49wvq9TIyGGSAEpy3C/gqzuRRDO3RASo9Od2JYRQxv
	MVDoTbLQMTMJpzIE+JZEoA0fbthJiAyX9BYkpSHGk+Gv11tBIGNznBs8m5Rf6b4TvFAICjC63Cb
	WnYSHCzM/xufgEV0i5hr8+Sv/nh8anZXajtqS8S6FlCM3KQq2Kdlk2o2E7Cn7ddCCxOt41rB1zq
	2Na7cgdcbESAOMhNw33FTJwb0Te7Ii/i7iWyX/e9b74Uxy6vAYbt/WvRQ4m/383JdZSdvR6yVLF
	dm8rQpney0D9IcVYXNLdYNFKK2xEAR7UzfTUr4FBtEUm9D9jMzneJ400X7xnn8P/6yybCYBKiYk
	FHynyY08TFuwwR9MRBOr8pyM6P4E3qXNNCg==
X-Received: by 2002:a05:6512:4028:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b478bc8814mr4448978e87.6.1787226148029; Thu, 20 Aug 2026
 04:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815095436.90534-1-sigefriedhyy@gmail.com> <20260819115054.GA1136981@shredder>
In-Reply-To: <20260819115054.GA1136981@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 20 Aug 2026 20:42:17 +0900
X-Gm-Features: AcwNN1VUt_6GnYToCGKY8-YqvGWgJcq1gfzI67yKf6sXOQA-1zJaynwt71Yw70c
Message-ID: <CA+7S2v+fzeZ8HGCupDH5AF9LJmydYAyxO4G3WhDtY-TTPi_WqA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: Serialize hardware flag notifications
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Amit Cohen <amcohen@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 8:51=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Yes, it's racy, but I don't have good solution that also covers IPv4.
> IPv4 routes are protected by RTNL and taking RTNL in this path will
> cause lock inversion.

Thanks, I agree it seems like the same idea does not apply to IPv4
code paths. It seems like to truly this issue will need more
thought/refactoring.

> Also, as far as I'm aware, this isn't a problem in practice. These
> notifications (disabled by default) are mainly used by routing daemons
> that want to suppress the advertisement of a route until it's offloaded.
> If they added it and immediately deleted it, then it doesn't make sense
> to advertise it.

Hmm, this argument seems weak. I think relying on expected userspace
behavior is not sufficient to dismiss the race, since kernel can emit
RTM_NEWROUTE after RTM_DELROUTE seems really should't be expected.

That said, I agree that an IPv6-only fix is incomplete, and I do not
currently see a good/cheap way to cover IPv4 without introducing a
lock inversion. I am not sufficiently familiar with this code path to
propose a broader solution, so I will drop the patch for now.

Thanks,
Yuyang
