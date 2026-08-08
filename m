Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1711238C2A
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149459; cv=pass; b=gDJwR5nEdzdEpo+HS2rzA793OQCjztb5ilRi5saxr5BBqVDrq73BmZEhMC0ZaWGsoZOzFJLjMvzycMh+pDDUg60/Lf6NnxMKhAU8GK2BD0gRsKh1r3Lxq53UDWD7tz21wW7KgBm6HQ+uReOpQnLqDeMq/UaV8UzJ6jPNottnkAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149459; c=relaxed/simple;
	bh=CGuDQ16nfUgnqxp6o6p8whu+K77+5qFgpiP88IDltZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq0Ao8B9j+AtRLqAbO06YPHYFer5t+t6e6fpezhDdSXX7rXZUkmfW2AZ8TMwlt2EjLhxL5TcfAXU4ntk4LPiHBLRMDg0+EnKfQ7mcbEIICqRSWNau0Bv8Ca1XAK7ok/i6LnpYVre1FrhrthY18o/9UDYbmFk9drrEI6JZY81g7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6o5uqIQ; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6o5uqIQ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b01146b205so49954e87.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786149456; cv=none;
        d=google.com; s=arc-20260327;
        b=svHshBmYzTCtF55rPELyqJwbg6reXkyTjIIbRyUxvbQMQdjsw/Rb01gsObqckJ/ESe
         jGpe0DSWR7pRS80wtJ2J7PoV1RuwOI3r/Cl8ky6z/ny+V0H/XZ5ZgTt9Q67ZVCN7wBlV
         LxewSh5o/MNOoLwcnGARsKyumpX53siQJPcLSDaUP9ql+FvTgTi6ViSCUTTkhQ1SzDZi
         nXHiqda6g3O2C2mWBxqY1x55D34hAO7FtXVwIiZ3qM7RLJYXNcFEjAPWwG8X70R8jptU
         /ahCwnAMGmVzssqYKlzyl48NlEgZHyEHgqHxzO5TihPJ6Ng0eW+CbYjxD974c3dwmM27
         UzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGuDQ16nfUgnqxp6o6p8whu+K77+5qFgpiP88IDltZY=;
        fh=agDsvpIfbQzRbmLwSqvk/CtkfgXunXw0huGhH631mwM=;
        b=Tmvkm64j2ZQ5ll5mVu0lFvu7xKkGJEp2t/jJF1WrzRIZlo3eijVVWdHSPaxhHl6mT3
         XklobT76uVM+Rc0bOqOL600DnUWV57izMDtI0BDiO0rWjRdaVwupAqwf8qkpyA94/ssw
         8AIGeAXo+Vokrr9WykULPGecEr1rNt6AfkszvjvvmcKo+OVUa9IRRLs4zLPHzUoa4WiM
         D2y/lN2mN9IcxKvYzCcqaz7Z2njVeRoNA6FEMyaCniL1Ui7cKDABaSFVNJCT/OTMjLeR
         GlPU06OnMNlG6ehhbEk1OIeEnNdA5keqtEIU9yk6jaBpC1NPlcQXTAxy0wRo++py8HFT
         v49w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149456; x=1786754256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CGuDQ16nfUgnqxp6o6p8whu+K77+5qFgpiP88IDltZY=;
        b=k6o5uqIQ83QQKJJpcQMXDE8n67hBbvLdwsjn7RoI44/61bDP1ehxTxsgsM28EO+KxU
         sC8RNsSMdMwfxM82QAYjK5H4nNg07fJIC8K/dmoXpTsGCS8w6sNrD5UbBKCkIaLhlo5A
         nYJGu3+7viopCP+GFTE0DN9fTeMFHGLI35NrCHXpzyMknzM3s8X2XpfG3BmzcrPZWHGt
         JbJimuz1T9KZoWjlrRrpjxW+Mrq9ekdfmuIxCp/lEcaVni3/9BW2UiReGRppp2KSOiGA
         0dqE01FUrlZ14+uvxDMiCZJ740Azbt93EyODZGJDsvj4Ng0juKLXC6s2tM7lGGXGlPBi
         EvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149456; x=1786754256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGuDQ16nfUgnqxp6o6p8whu+K77+5qFgpiP88IDltZY=;
        b=NIYHJ92l1kqnnHYzDePB06N5B0dDOgQhmiAleG72xi2RwIYZMUhCXyQmQr42uVs9p+
         3FGzNSNomfdR8weWAYa+h7ca0ZdbMmCy3Iwhn/C7lg/OXvVed81ZECAcAVZ3VM+Tr+dT
         XJQhodGffoa0bRmtUspYKp/UvCrsyRE4tT7kv4j8dAc0enx2r/oI+urIei/hhz3binI3
         9xbqtGDWrs0UWApFBHjtDqs/ZgATdQtPIKFf+ICg2IFKmT7seeTIKd1GlFBvw0E2a4dV
         VN5Q44pC2pED1bv1bW3rarLvc3zX+XSM/Nv53oqcAGdZ3AE9d4t7wfrZbG7b/0AXgk2x
         TozQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEvoXgPGuwwgfNhM4k459i11Zad+womvtMrXTj6C5Uxeij9gvPEWHbCgQFcAqb1Eifn0zvn/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyD1Xd11gHoLJ6WqdEk8+ktOr02zfKNypBMUFmjjx/peAdQEeE
	ZWmxjTbol3sYtPEOi11sEUGaUI9WyPD88Ya17JXrGy05O9h0b/CjA7HD7qVOxiGWCEqqEdokT1z
	dgMvo2KppDmvJ2oroeijULEubHpbroYc=
X-Gm-Gg: AR+sD10OZ0SEpIKnWtz8bOr0Hh0lR56LC/5TyOQY2UHFaNSPsc7+FDDX0y0Ua6HLT1R
	xJdSZxc2be+rIBcsA1Sf5xZtbRwG9kgLAFgH73AGjSB9FRaBHA5JIyCrY63zlv8bJmUPOEj+SEa
	V3Qf2YAaM7++pAjPNJcYUZ7tr3EotSu/J0aOwXxfWOT8jRh8xRdk4ImiizbGdXwhJ6+VShJq7nS
	hZpMZmhPJqXhKCh/2i9V2gSduMZET7K2VCP69dXwCiHLsppPq3Mo75VgnwaGm1fVPhKEeNQviuG
	8r3fXHx0FFt9oPhdOebIITgmJPKtHZTcdbQFuJqn3UHvI25RuEDs9XJJ2gSMv8WPHR6nTjuF7vS
	duy0BB4O0jizV5+aTCtg5KovNIbeVS2CPJg==
X-Received: by 2002:ac2:4901:0:b0:5ae:be69:49f7 with SMTP id
 2adb3069b0e04-5b2f4c92660mr2879963e87.23.1786149455584; Fri, 07 Aug 2026
 17:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804014714.4362-1-sigefriedhyy@gmail.com> <20260804014714.4362-2-sigefriedhyy@gmail.com>
 <20260807162154.GB2186508@shredder>
In-Reply-To: <20260807162154.GB2186508@shredder>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 8 Aug 2026 09:37:23 +0900
X-Gm-Features: AUfX_mzrMnAMjlRW4rdKMx1SejzLIoQ02rv_v6mycJ6dnSZWRpOLrZP6x_qM4Xc
Message-ID: <CA+7S2vJ7DSnU2xH6dXUj1+-db_JFJF8kdvb0g2UttFgO5HintQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/10] ipv6: add ip6_del_rt_reason()
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Chris J Arges <carges@cloudflare.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, 
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Nimrod Oren <noren@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 1:22=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:

> Since the function is only invoked by IPv6 code there is no reason to
> put it inside the guard and it would also suppress the comment from
> Sashiko. You can place it near ip6_ins_rt().

> Please add a note that this attribute is rejected by the kernel in
> requests, like you did in patch #9.
>

Will fix them in patchset v6.
