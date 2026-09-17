Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83649A3A8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679937; cv=none; b=fRV4E2pSFkhZfXvsSmeVDMOhxuaDEOuu0HMfaHaLlScnuyhk9Id9iOnE1jiIreX4Ic9O+b352mZnGvnZewhqRo7OezvtCJ1CPiFKAb1LqtXkKYCztFpsDUOyAek+ho4lCJgIE7IK6Wx6atlk+i1yWQDddE6cQEFmhiSujN2PEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679937; c=relaxed/simple;
	bh=8CQK+sDFvJB3uSUiYZsYjT0EqgB7/JFzXYwZ/nvgjDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edvjiWz9ShuMVLzzntqfbEg+xMyUEu740Yt1JybcfOY3CEurEjNat6cTW1ztgjmvb9zSHWKdogWabOxpukySikMiueFXviRLaJwdsRfTgQ4PrWw9iUD63eeroB9jqY9wOrCzAovRrkylaU6Rvg74u+sTPruSOzdaw6dRJJW2ZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHpRBtbH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHpRBtbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABFF1F0089C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679935;
	bh=8CQK+sDFvJB3uSUiYZsYjT0EqgB7/JFzXYwZ/nvgjDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KHpRBtbHyumR/Z/5xjYECdi4tiucGZFURQ3sZPF6x4XhPVdBWvzHbHjEzpWLXfDpa
	 LEYAFREuXfYeDjoTOTzZTktOEqE9I+OZQvDDFEDalR+W5B+35UX6Hj0aQB5SkCowh0
	 5cDaSSvMYig8b5HhLqJu3LHy3FRmeoezMxQlQo3ujkVOMUluWbcc4v17GL4mGqARJt
	 eJATqnemGdQXY2pMIyIG43AUGZlkykSlEXQcgvaVF5D8MSg2MxoS1dIB/vSGcs1PXJ
	 3uiVgabs9Cdb8vxE6rq5XnxkVULMXl7J0kkvA0f5X/WWa5PUqfeZlvQsk+TnM2Aj9O
	 S8sgySdRANgaQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b76668f4ddso25120e87.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzfTLpcqU7osy1qW1NWGe0UEIlKnLa3VPExDkDkHjGjoSe7oYf8E6U0Ed/ztUubXnvZDD2K3io=@vger.kernel.org
X-Gm-Message-State: AFuF++lXmFuDw86hlbUM87CcaE5mbXVQYFN0MzrNAz1N5Hslf9tIKk+r
	8DvSbaSdlWMKG/wFTOXdBrh5tqmJoJRIJcCHoPJuu7plUXosjZclu83nFtA8o8vNyFzNEszzKrj
	KVTBvWYa6Td2OzDRlB/W/CCVUXBPPVz4=
X-Received: by 2002:ac2:51ca:0:b0:5b2:c068:3530 with SMTP id
 2adb3069b0e04-5b8c1477f71mr95651e87.13.1789679934327; Thu, 17 Sep 2026
 14:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-ks8995-to-ksz8-v15-2-8825ff5fd4be@kernel.org> <178965134740.22033.13313484925246996796@kernel.org>
In-Reply-To: <178965134740.22033.13313484925246996796@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 17 Sep 2026 23:18:42 +0200
X-Gmail-Original-Message-ID: <CAD++jLm7UQGiS9C=HnAUGOmnjA0AvjLc_qOUTRCK0PeRsVn0JA@mail.gmail.com>
X-Gm-Features: AcwNN1U_gKDI4mQNmA5dDrABMIVSHiDnkPM6eupkAQilbjai7xkg_f-DLiW4TaI
Message-ID: <CAD++jLm7UQGiS9C=HnAUGOmnjA0AvjLc_qOUTRCK0PeRsVn0JA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 2/4] net: dsa: tag_ks8995: Add the KS8995 tag handling
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 3:22=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:

> Two details worth noting: this only happens with a conduit MAC that strip=
s
> the non-standard 0x810X TPID into metadata while preserving the port bits=
,
> which was not demonstrated here, and the same OUT_BAD outcome already
> applies to other VLAN-metadata DSA taggers such as the tag_8021q family,
> where proto becomes ETH_P_XDSA and also has no case in the switch. Should
> the receive path here rely only on the in-band tag, or is degraded hashin=
g
> on the conduit acceptable for this configuration?

This is just getting too fringe. What about we merge this and look into thi=
s
when we have a user who actually want to do these things on this
old chip?

I don't think this is a blocker.

Yours,
Linus Walleij
