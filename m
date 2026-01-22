Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F193E3D8074
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123227; cv=none; b=fF5PAX0kOhvo/Witjan2yaL+/pzSk0IrgeRtozoj8GUeYHlTUrCAjfvx6SoCjekmlPXhhQj64xG8zNbw2ml7NLGOUHDStFPjQ4gHMMqZOAvG5KziNwMbZt15Ev4YqfKtsTbsQ+9GlI8OCnLh441kkitXR1afeIxiBl9+vasAVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123227; c=relaxed/simple;
	bh=Y9WKbaAbGay0g4onmupbqsi4v+2SSyPctEJha1HkD/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCWeHwOZPH51C0xYS4BIQACsoumVCnwO/YL2KmWaketYuCr/NQjyKJ8AIizbwTutJnjvpQihXOWsIpNl7yNTJer8qjRSks/kniVTnDZW7tK+dO4XkPuLgH2tYjxfXiqVuIidscG+lFCa2/GVWJfrBGJEg/dorR/SGuaDwi6d7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2p/uhZM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2p/uhZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E59C2BCAF
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769123225;
	bh=Y9WKbaAbGay0g4onmupbqsi4v+2SSyPctEJha1HkD/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b2p/uhZMHnwNj67Yoy5CtSPK6G4QopUeXrMebyoB6+PKS+sTalD47qalM0vgREZLU
	 0QJCajxbWGrUlmcTMdt5AwMbiSWcq4utLz/AMgJKIk+CvtDoZMhA9WtB5LfE6ZnDRP
	 Iqd6t5sbo6BK+IjRhwsVr8KHU107O0YgQOxiXU+tg2tXuaju6NjrbYgyvPqzz4pRRZ
	 RMqrGhFfOBJQiIR4BeLJt5HwuK0yckC7mnIJ3uRAf06EZ8Uhvd8XTM921EmL0Q3bRG
	 0DsbOoEORO7XpcKH4qyms9/U+wFFQAbSn6RCBn/738UZWElmRslN+l424FKtm4gfrC
	 Xr4/g8c05Zowg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65813e3e215so3011546a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:07:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW3sqQph24JucfVE1ZiXsAkUzdFkMvnjgpd7Cq1KJ37QYC5sJAF3BWh6kJicy/JjpB/G+RMck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KbXdHSE6o5zuCcVLekrh9w98ZzjVVZPUnxxGdjIptWl5BK/o
	uH39mvr6gulUoUV4oVNQh+fZuCnSM/tDWTRZh5zIzNY60ZB5fWlc2uzncB46M0DoefTEPLzzRgd
	kwXXgTSz6/QaypE/tsspVQCWMEJleVA==
X-Received: by 2002:a05:6402:1ed5:b0:64d:46ad:da66 with SMTP id
 4fb4d7f45d1cf-658487b7fb7mr710772a12.25.1769123224341; Thu, 22 Jan 2026
 15:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121151506.813783-1-dam.dejean@gmail.com> <20260121151506.813783-3-dam.dejean@gmail.com>
 <20260122165102.GA2564919-robh@kernel.org> <916AA508-4097-42DF-8087-4C82ABB87D76@gmail.com>
In-Reply-To: <916AA508-4097-42DF-8087-4C82ABB87D76@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 22 Jan 2026 17:06:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLojaLya08L7GbocT3s3Gv2mfHrftE1yfy+Gi_VyAUqcw@mail.gmail.com>
X-Gm-Features: AZwV_Qi840gfE0Q9gDAEExJfLTww1TWyvSgxhEpyAESJsHeuPYmLbwLXEOjQ3qc
Message-ID: <CAL_JsqLojaLya08L7GbocT3s3Gv2mfHrftE1yfy+Gi_VyAUqcw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: net: realtek,rtl82xx: add a property
 to set MDI polarity
To: Damien Dejean <dam.dejean@gmail.com>
Cc: andrew@lunn.ch, krzk+dt@kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 2:47=E2=80=AFPM Damien Dejean <dam.dejean@gmail.com=
> wrote:
>
>
> > Le 22 janv. 2026 =C3=A0 17:51, Rob Herring <robh@kernel.org> a =C3=A9cr=
it :
> >
> > However, are these properties something that should be common?
>
> If by common you mean =C2=AB not Realtek specific =C2=BB

Yes.

> I have no idea if this kind of mapping is possible on other chips. Marvel=
l Aquantia phys have an =C2=AB order =C2=BB (marvell,mdi-cfg-order) propert=
y like the one I introduced in the patch before this one (thanks Andrew), b=
ut that=E2=80=99s all I know.

Seems like it is.

Rob
