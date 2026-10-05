Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781B4734EB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195256; cv=none; b=Xo6tTv7fEpN/0ZhrD9QWbhalu4CmFD4LVpDRC78JenAkKTGAQMvjLoSPa0SBCXatSY4Wav/MxMRTaYVlHd9xn8lo4iKpQUi6IYFtK9wmKZ7egYG0Px37MQhHDIHMeq3XhNGTTi88Pw1CmTDxV1qBBCsEhQZ0T189Z7kgQh2WhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195256; c=relaxed/simple;
	bh=EM0J4RW0TJcHUV0GbCldQVqg7twkRwPbEZ1nyYBdBv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zu0Zn1WoyX9eCENYNERaqpk2B0zIlj2nRDVuRd0WVrwWCvPKbEzTMqUPzS5paZ0kkmFZurbqWiU75jIAQuBA37K7AYG1HSLZOVRH72s/AwDVI8GbQJY22AcwVuOIzphWWCDL/9xv9tJ2sTQ9xe+PsMnBj5DtGzvHT8rHtSA8iXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctvazm6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctvazm6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F051F00893
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 10:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791195255;
	bh=xSsLA+IqY51yLDT1KxVLTTzC4fGN0KbJY5YYj55fyhA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ctvazm6db9gjdOpT4qz6zVvhnrB6ialwRUe3e6eXPIOhrSMmFPm+1UE8L34fbkG9+
	 9YNT95FC3S7ZCME+A3dLlu7JSlq75muqLqC6L9MWI/jpni2/0SE5Y7dKlQZOHBplO8
	 6sglVCAw0vm1vNwdXEwp2Dx+6y5OlRZCpqH8T8+547dwGqiV9qLl+inlWwmKB0iyj1
	 U0qxWK4r91l2PJr5+LpgG6I2VCeqyJyQyD3T7K6xDfiABZmunr3oKv6JXY4Fkiksr4
	 Sq7y2HVk9oanNJ+p5pdBwN0IbzaUglYahzw7swqoqiH1U+VsSTKrDfpCVZ06X9ARj4
	 hY2abzt3OvgSA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-483a66818edso682307fac.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 03:14:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByk4SPBOrJA/r0fNRc/vl1xPkLBqkxFutsJ5m6zv9cOd/cQZJiWD2w6JRodHmPiu/yGsA5Vc2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5Sk2VZXs82LMPODNqbrlsE9EDRQv1dmCjvo8TzOli7ptBU9iD
	eh8tQKYLz4YlTAhhmepki9+iMiIEO35sE7ar7MT4bbBo6S+hqL2RRdWXLObDoepRiE2Nh16Zlo3
	pU3oZPILHKZN7PAPmBFpZhmEg+dXdE6E=
X-Received: by 2002:a05:6870:b02a:b0:493:ce9e:5c7d with SMTP id
 586e51a60fabf-49e3aa0d200mr5742235fac.60.1791195253538; Mon, 05 Oct 2026
 03:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004122616.56714cbd@nargothrond> <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
 <20261004163532.3134dd41@nargothrond> <20261004192902.3ab3b7f3@nargothrond>
 <919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org> <854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
 <CACKFLine2gKepH57mg5j2YYWsX-qU8-EfJfnqWiYUEhpXL1F9Q@mail.gmail.com>
 <ef6eb827-71a6-40a6-a4b7-8e514ab595d3@kernel.org> <1791193344.w5j2m55mib.astroid@yuna.none>
In-Reply-To: <1791193344.w5j2m55mib.astroid@yuna.none>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 5 Oct 2026 12:14:00 +0200
X-Gmail-Original-Message-ID: <CAL4WiioggQU3VtWSL9nrExg5SZZbKiPA8pWmzeH+uRa0gy2ApA@mail.gmail.com>
X-Gm-Features: AclHuK_byAt-ykfE_NIEd6L8_DC36yPcKDXrW_cT-wbCsEvjo3tLjEFgx-SE9lo
Message-ID: <CAL4WiioggQU3VtWSL9nrExg5SZZbKiPA8pWmzeH+uRa0gy2ApA@mail.gmail.com>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Joe Damato <joe@dama.to>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev, 
	Stefan Fleischmann <sfle@kth.se>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 5 oct. 2026 =C3=A0 11:44, Fabian Gr=C3=BCnbichler
<f.gruenbichler@proxmox.com> a =C3=A9crit :
>
> On October 5, 2026 3:59 am, Eric Dumazet wrote:
> >
> >
> > On 10/5/26 00:29, Michael Chan wrote:
> >>
> >> I think skb->len is not updated with the padded length here.  So the
> >> HW will drop the packet seeing that the length is too short.  There is
> >> another skb_put_padto() that might work better?
> >
> > +1 Exactly, thanks!
>
> FWIW, we suspect we have quite a few users running into this since
> importing upstream changes from 7.2.2-7.2.5.
>
> Will report back once we've provided those users with a kernel with the
> below diff.

Patch has been sent for review:

https://lore.kernel.org/netdev/20261005023812.130639-1-edumazet@kernel.org/
