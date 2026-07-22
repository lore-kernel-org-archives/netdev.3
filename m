Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A17348C4C
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728022; cv=pass; b=eIXzkyLpG0ac7+BMJ0gax6GpAOpSju3zhLTZwekkgiWaiggl1xnBtzgyLv0/ixNeFQq5jxpQF0rt9V9A2Do+FDszUsUr440ysNxk0BuiBSqOlwEvXtX2+6ANH0uPuII0D3D1mxzD6/FeyvY4+tWt7oqgbwTm8bDpl0b2icaLWBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728022; c=relaxed/simple;
	bh=jOYQuVEhe8w3B26Nj6IksKG2qHxsWwmeUaHRx7s3Y6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=upoQTlHYGiXhmmKxOprIPeWzI4d2NM99tAilPOGBfNsehKF3mIb4Tec/mAn5GkOrmr6Am434wl9SqPnAVxl/cAMd0HhbXPPYr7xt0hMp74PMFt759SIvTd5EUtcQw0kazAf92YCCeYpg+JDyeHcvb3nyCPZQlhhqxPNXmNYQ4Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BIQu1nw/; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIQu1nw/"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5218927884fso19245381cf.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 06:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728020; cv=none;
        d=google.com; s=arc-20260327;
        b=fGUt+Xf0VkOlpDTtIkAFBGfebGH4zVEiRSWupLW6OLw7Zwb7M2B/lJ+htvbu8gclwj
         LiO2646fPkKkfd+ijuHyMKFN/i5xFz1DUfWXGGhBRbqy27RACpSUXWVmGHfIXfx5XZ38
         bKr4x/hcBwaDZz7J8LdcvEQ1HTgxpzzEtLCjP3945dY0V7gWEXpr7gQvG4Re6UOLYVB+
         Z5XZLOlG7oJCglfwhJuxnzr9IVDiOd2fA2ln40hh4NfgOTQowakcpaMW8xFk5Ore/Eki
         2jz9JFE01OIpsOOW+ptQmjArAXd5Hg2BsgmgFxzokjPpL0Fovjr597Txe9ZetErIXwOn
         dkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ygWq6V23prC5KqbjFljnH4YQ+kPoaR54/QVzcXpLx4o=;
        fh=VURHWMB5Ro5mbBicSfKD4YuZgs43VGkGA2vsKi2zxAk=;
        b=Jfs5QnVLWxq0KW5HPey5hxTMSXNKc9PpP7u744UgBUnGiinEZRD8r0r8EdngbeGI9k
         afd13zN5/50AkWyOFj9vbI6phyTvxIqINNU4XV4LbhNKYr1YwQBITPtZPr/Kgy4FzjTE
         kvFnBkRG2maqm/vucu38KEBMX3E7jYiQSTW+ieFXJ8N2Rl6S7pbfPccTz8Mo8wCdjLFu
         CrAQw6IrzzH8U1eA1/KmnExPVu7tJCkvMxUJfFXDFguqBdPXMR3e6V/2JbhVoBmKL40C
         l+HubNIp/6a4VwrxT6nEcbkaxQpUANHV6zZBGie7nm4Z2uFAeEkwoDq5Tfs52U7r++mr
         9fjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784728020; x=1785332820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ygWq6V23prC5KqbjFljnH4YQ+kPoaR54/QVzcXpLx4o=;
        b=BIQu1nw/RVgOa1yWKPc7bfXYD1ssuK7LX4Z1gZWPOjcplXt+95BWqi0v4YreHgZYQa
         owuefwZatwbnmWSBVgvwVLaR7jbvZ8P1/FoLeB9rp19IYSck94/5vpqNk9hhM7gEQd1M
         g9T2/JUNZ3ixNxX+wVAa67DdSC3+DLk7tyxddnzJm6jcvx/sGJ36dRObjr3IYBdXfIHk
         8AdBaiPdR6Q6diy+QdZ5voWJKmOW8WUBB64+4FDJ+i+/s6Wf3X9n/r06V7m00S8edV/s
         3jCpxlimAJCqt4nkxYTRQ8Nv5whGTquaWS9Q7VUJNzcnnBw8ha+lt2zE5Yp7T5ZficwK
         rOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728020; x=1785332820;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ygWq6V23prC5KqbjFljnH4YQ+kPoaR54/QVzcXpLx4o=;
        b=J3k/Mpgsp6/vFmVH/Gowqede3AtAgWad8OIaJq6+Ktsvb8XJYk6XQ0xBydNg3jvbpw
         +kb/xnvOxMp9NjlJIpJZDlgZHr2ar1zf4HldfJfhBMDdPI2s8cwJ2FqbdOSI25wTPqhW
         NSYep5iS0NJSzBNb1eRepJViWP82GmM/4CHNmVxK6CNfE5WMFBHDsV89aZvGHa4VPlnm
         NGRkWeaY431Nh3d3Mu0IAKxUxIQviWN12RJMLuMg0BDdmZQN5TgIK/IoDFKlO7pwAFKF
         qZK7jDJ999H9yoHj42qw3aPP7osFpb2zBimaOhAsGiH5h831qxdWUfx99hX+Fi127pv9
         7AMg==
X-Forwarded-Encrypted: i=1; AHgh+RrU7p/n+mxF8SHFFXb/OZfirjKOAh0gz/rKuA4E2AlP4uGHzNM5tfLwQtpw9w5fuD4wFUGW2Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxddq6eFb262hIvGpzaqcH7h2L4kZ9m1tlcKXxtZJ+Q8SyC9IUB
	S4ZTZfOi/qxPUj+RIOAU4F+uJCnjG/bsYVMMlxWJO47Im9aBcVw6b+2g1Wxv0/6X/bqt7aVipgH
	ewCxcjGGzR3DdB9IP2hp4a8zEOqHME+fl5og3FNvG
X-Gm-Gg: AR+sD13lFw8YJksU6e4DeFAHwEDXYRMdqm5GF9WmJxJgn6ErYJcnMyKkLjmY9YVVz7/
	BzkPr23xa4cacQiNhjySylB/LJd5gUkthB0fKblh7oCTLjQIZ8coi7RytljXMIXrF+GTgTkmeew
	2OGYjQq+7zAdW8CeY1b4ZRDfxjnOEjPcHbSoSPcWqXWkik7fqLu5AvjVHgyVtZkm9dfexPOnZdx
	/j5NdXdLK1nYshvWEVLBP77P0wBB5TUD2+S0KfMowgI3VAKVOWLLU1LLL7Z/A5Bp/nXXzRCgqXZ
	WOu2fK29MlQg3SQkELe7ueZ8GucBfjW26N8ZYQOXA0ILJqP0naRepUg6jihaC+9WsV+OvPEP
X-Received: by 2002:a05:622a:48a:b0:51c:9ab2:dfd2 with SMTP id
 d75a77b69052e-5213ae555ffmr223765481cf.33.1784728019641; Wed, 22 Jul 2026
 06:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722015129.916-1-yanlonglong@kylinos.cn> <amDCZ5t8wDtqNAIe@devvm20253.cco0.facebook.com>
In-Reply-To: <amDCZ5t8wDtqNAIe@devvm20253.cco0.facebook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 15:46:48 +0200
X-Gm-Features: AUfX_mxcHk7xgSRJVZJlkUyJITANWQAilS7A1ELIqqoIUPEbdk7UP24_6QDPH18
Message-ID: <CANn89i+P5pZr_QFKgd1uX7r=r5M1nVRbuynytzcEXbp_HHPr4Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: use MAP_FAILED instead of (void *)-1 in tcp_mmap
To: Joe Damato <joe@dama.to>, longlong yan <yanlonglong@kylinos.cn>, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:15=E2=80=AFPM Joe Damato <joe@dama.to> wrote:
>
> On Wed, Jul 22, 2026 at 09:51:29AM +0800, longlong yan wrote:
> > mmap() is documented to return MAP_FAILED on error, but tcp_mmap.c
> > compares the return value against (void *)-1 and (unsigned char *)-1.
> >
> > Replace these with the standard MAP_FAILED macro for better readability
> > and type safety.
> >
> > Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/tcp_mmap.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
>
> Looks right to me. Not sure if it needs to be set with "net-next" in the
> subject line to make which tree this targets more explicit?
>
> Either way:
>
> Reviewed-by: Joe Damato <joe@dama.to>

Yeah, I doubt linux will ever use a different value than (void *)-1
for MAP_FAILED.

Reviewed-by: Eric Dumazet <edumazet@google.com>
