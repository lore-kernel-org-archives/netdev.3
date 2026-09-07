Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE13FC5CD
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762754; cv=pass; b=NAfMzkjhLG46H4YYcWL8uGWr0itla4zfGf88D2sf4nACxyTJZgLwyeuVeVATkwcT6O7Snuo7NYmm/pjRk2KV59+uCgsL/KiHYMk4Tjx291IGWTXJkyYPZqx7gOMeAJW6LYLBl9u82xHjt13MNZlluvmUyE5TkfZC/zRCdFCnXyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762754; c=relaxed/simple;
	bh=F/tnzoF4Zl7zIpw+TC5hY6iRqTExqnJ2U2STjqT+p9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdOAmdCws1aeT3+jCxLAVffXHWVBbRKDr4PcS2bETJBId9abnG4MYkCMaW0Yly3NwbfiTQsceOdBQ6YPZ/sutVxUART3zQAQkj8c53u0c0KOQ4dy7ckx/SL2EEMhZAh0kM+LzTbUQWoK2fq67sZIlBSGhpv9bw0wcQ5QgOcE9as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZW4O7Scs; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZW4O7Scs"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-939afd60d6aso40857185a.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788762751; cv=none;
        d=google.com; s=arc-20260327;
        b=S121u/Z5kyIzml6neyFZ+nlVfiDSyiUTYTnQ9KP0SCGDApj9qZf04prOMHfdxmugaZ
         1aglZsGAvGJpG9XMGaFJi0Wfdz2dXoVxTXJYXCs90UM8fMWxjUVhB0qhuPUZZdoHZS5G
         PMnwbCVSEfPAJ5WFB45Uuwm02QjfD4xRMP6oouEPCab6cPd0rUW4oVjF+ffUlH53BfL1
         ympomOvLs82xemEvKyerc4kjTqeNyTluo+z41gFOSmOKX1/pZPrfsrwz1mOt67oGLvpf
         Tum3f/Qw4LEhEekf0nStGtXbdu7Cn+snMZqWZIOgbYccPn3dYepKOY6S2l2/9lTLO6CR
         fEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cvnss1lCE0qCFiXzq9pF5TDnzaNA1tQkrA+fhWCfPak=;
        fh=Nyj8vCt1Ge4p4AG92elhFyL3mnimkL2zwi/zIRsa0f0=;
        b=Qzb1CDyFuuxpE5TcBcovxzBaEGvYZGaotsFDUSFh/e8xIwTU+DbFTzb/KDhJFaZ/Zy
         Xx8Hr0XO5STMEGLukeh0wNueAx9AShnNRQV+0+P6LECmxZMUwlePTP8nYoFkSYuMGa5k
         Ur88Y7PqLvx3y5Yv0KrwbqZvYP/GnVy8rxvlI+/Z/T/GPzOiTcpB5mH7Mnm44q9eXSBp
         JG0WepwCKvDkSGV/8TtsJPoekMOyTUuuPx3LVKoqHhkhgDxtRTjbrVh4cDsuAI2uOGe4
         W9SbjwONH3xwn2ps9vTVlrgxf2QBRt3AO+qS4EbbvqO8D6N1W4SU5U6Dk88xoGQcSHZ5
         LyfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788762751; x=1789367551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cvnss1lCE0qCFiXzq9pF5TDnzaNA1tQkrA+fhWCfPak=;
        b=ZW4O7ScshOATCEVwXPoY0U1XWUt1nKGuarB4h6lqUXAFPfUp46nG6k5BnZtSFTIzCe
         TmxJMiYQN7BuyGicDaGoLgPp9utp4i+RhEhLWOCco+nCF4j0BwuSpyW1xKifAMkYtNUT
         vmseLiS5B6T1OA5zgQcJjz3UCNwxaoNIeUh5wE224Bfxyh+MCnDewsOf0f9xbBP0O7Nl
         sImq2yJd6ITHTuCA3zNheNWdek85qFTjL4HqPq+rQbWsW/pqzNasIMkUdAeoDhj/woGV
         Y9bsJGOPBiq2K36a760/Xw2a5TWLNh6cWyIT3MHf0KSQbdzdtan1gPArqFbEbZMaTyK7
         DRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762751; x=1789367551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvnss1lCE0qCFiXzq9pF5TDnzaNA1tQkrA+fhWCfPak=;
        b=qDOAErSEVMNsbzm41dzrivZLTFrm5sg6uUpbMMIytq2htZ9NPOnF3MV63Z8ICyYGsM
         97/wkE6JUsJVwqFkUaQwojjoHG/uhBOpN7U4o4UKzSgf2wrdDp0UZhDGhUn1SYVFwldE
         s1Ax46OAYcUE6cWODdLtdL8BQtPHGzzu5KnhreRmbFPsU57hqBXXUQ0HI7+Gpe6AbD5+
         T0ivYpoxCWh8nNsIOrgaBkvVbomxiusfB7NfeeiyrOgHDVs0g922SI39mvFeVMzr4xap
         Aut6bd2iEHPfWuR97pplV7HRTKwqXXuCyLSYT6DPWxM1qYcOzHVC/90T8r+ND7YHNb9z
         TIPg==
X-Forwarded-Encrypted: i=1; AKwUvBw/fz4UaMs/1SWT4+i4sMKjop434ldcccoWLgOs7P8VR1IH1WE+bIY4YCmTbHtxNbL9DtvRL/U=@vger.kernel.org
X-Gm-Message-State: AFuF++lVXmXlskQwxr9mG5T7gdLB4TbAYupgYFyzs425fCBmReiD6hk2
	lRJ40QQBU6jar9Sh1VPWrwJohUtjI86/E/vn7fYejnUdJUKnLSF827NaVtKJMX6B5zWCw0XtnGm
	M6hUKbXeeGWVw0hcxgQivUP5NEuSuE1J6UFe17xnO
X-Gm-Gg: AYBFou2GURdp4EhF7bfchpE7Rle7nBNfSDtY3U78sruWedGrYTP4/9d8n1Rvd6zJmEN
	SbA79GA6493BPwpKZZEtUAtOHqLWueTWhIpOvnkmYf47RJCs2PCn5gAh8f7W7cH0yAhbDC8kYVZ
	GNq88Deh5PZHswGP+P/wVcUkVrjScVSOP0qnuZtweEbe7pXx5m14XO879JqBl/MiGd0PHaJPPhD
	FfuAJSKL0wI50aewVjWYfFmR2r/Sx/kkeAjmL3x4H26riJM6tMzi6YETvfLt9sTAgX2FkjPGxXK
	6IpQJKI32OUZDPLsFPArJmCGUINvWizlV0uGl9R+ZWwZv6JBKWMxxvNCIaETxxbNdsHTzNOaKgz
	erUUxfWFvLFL5+c2fb++d1w9r51Ba4J6dbv7zAauflIjmQrf94uDPDo+FGw==
X-Received: by 2002:a05:620a:27d3:b0:937:631:4dfc with SMTP id
 af79cd13be357-9398072e033mr1976064485a.42.1788762750845; Sun, 06 Sep 2026
 23:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788262122.git.petalzu987@gmail.com> <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
 <ap2ksmdL1FFulLnF@lore-desk> <CANn89iKeNgRxhkUvxeMmyAJGcT+3hpbWaM+VubQ2sBVGSDeouw@mail.gmail.com>
 <20260906224300.21884-1-iprintercanon@gmail.com>
In-Reply-To: <20260906224300.21884-1-iprintercanon@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 08:32:18 +0200
X-Gm-Features: AcwNN1XkoRCkKkxF-8dDC6WdgnrJtI3v0xg2u5jZxMrz66y7uKuoPxXxxysiGaI
Message-ID: <CANn89iLjMMsKLYkv8J3uX-FvzfMvkzi5wtLfY4pZYW2G9C601Q@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Zixuan Chai <petalzu987@gmail.com>, 
	Ren Wei <weir@nebusec.ai>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 12:43=E2=80=AFAM Artem Lytkin <iprintercanon@gmail.c=
om> wrote:
>
> On Sun, Sep 06, 2026 at 07:54:34PM +0200, Eric Dumazet wrote:
> > The general answer is : convert tunnels to RCU based configuration.
> > In my quest for RTNL-less ip link dumps, I converted SIT tunnels to
> > RCU configuration.
>
> I have ip6_tunnel and ip6_gre done the same way, after your geneve
> conversion: the encap and header lengths in a config under an __rcu
> pointer, changelink validates and then publishes, fill_info without
> RTNL. Seven patches, built and sparse clean, waiting for the nebusec
> fix to reach net-next so I can rebase on it. I mentioned it on the v2
> thread two weeks ago:
>
>   https://lore.kernel.org/netdev/20260824194741.215979-1-iprintercanon@gm=
ail.com/
>
> Two things I'd like to line up with your sit series. Your patch 2 and
> my first one both touch ip_tunnel_encap_setup() and the encap ops in
> ip_tunnels.h, so I'd rather rebase on yours; is it close to posting?
> And you put sit_parms under RCU as well, while I kept parms out of the
> first round because it keys the hash. If you'd rather have parms in
> from the start, I'll do that instead of a second series.

It was ready last week, I can post the series right away.
