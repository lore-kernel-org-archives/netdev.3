Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A03D7D89;
	Fri, 28 Aug 2026 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903865; cv=none; b=pFHeBGBgl4dmgM0S4bKuwvbzYlWeOdGCkkKmua/MCgZqFFoyyHgZfGwo3QN9lfV3y/1eaNKUZ82ZJ0or7sqHtMEWsoRVL9oRRXYjYcCZjzW0PVUPZHR8CGQp8uDvuRT0p0df+01m+6MVppIrUAgBsI4ajDCPdD3Y8JnBvA1VoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903865; c=relaxed/simple;
	bh=iSupq5fhD6RKiuSnL0iJAjflrNswUh/qfGnW5qvE63c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVF52YUAdstl1tDLj7eujDs1QZGRIrdk1j3bp25YvVTGy85hN/j8PgdFZ2AMth9CNYN3EiEk7P4dxexRspCee0+tc1F+JAOZXIo/oyTgt5wQwdvKA/mstRC34umH9PVdfIrKMbsnDHFXnaL3oYyLBO19lFmXXyABn+sFUWGrM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=EYyXpGnT; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="EYyXpGnT"
Received: from localhost (82-69-49-219.dsl.in-addr.zen.co.uk [82.69.49.219])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id 128A27D3E7;
	Fri, 28 Aug 2026 08:57:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1787903856; bh=iSupq5fhD6RKiuSnL0iJAjflrNswUh/qfGnW5qvE63c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Fri,=2028=20Aug=202026=2008:57:35=20+0100|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20zihan=20xi=20<zihanx@nebusec.a
	 i>|Cc:=20netdev@vger.kernel.org,=20davem@davemloft.net,=20edumazet
	 @google.com,=0D=0A=09kuba@kernel.org,=20pabeni@redhat.com,=20horms
	 @kernel.org,=0D=0A=09bhong@brocade.com,=20stephen@networkplumber.o
	 rg,=20sven@brocade.com,=0D=0A=09linux-kernel@vger.kernel.org|Subje
	 ct:=20Re:=20[PATCH=20net=200/1]=20net:=20l2tp:=20ignore=20multicas
	 t=20notification=20errors=0D=0A=20in=20netlink=20commands|Message-
	 ID:=20<apE_bzlcmIK1FOs1@katalix.com>|References:=20<cover.17869622
	 20.git.zihanx@nebusec.ai>=0D=0A=20<ao1QMuGwSzhtlmo5@katalix.com>=0
	 D=0A=20<CAANe3eR857ZyGa_2PdBOVaehCoHr+6qH1J0jid66-z_0nCEgMw@mail.g
	 mail.com>|MIME-Version:=201.0|Content-Disposition:=20inline|In-Rep
	 ly-To:=20<CAANe3eR857ZyGa_2PdBOVaehCoHr+6qH1J0jid66-z_0nCEgMw@mail
	 .gmail.com>;
	b=EYyXpGnTUZc7KZcwg1BbyUuP0FW+yxVz0ZaQ/hxcb/bFBtzBqcsVBPPgDpk95UZ7F
	 oQmqylBp3paSb6Lq9nqp4glBbPcAgm89V19f9pmlpE60O8Xbwk3Pvgj9TWQI36KwEo
	 KmAOUL+++1xfeL9IntbF84iwa5vpEotH3ex9ErPaC10h5fQq2upgYPwPyacjBqQzPX
	 pPrjx3yIkI6qKperUbnz3SxcDbe0nT9jTMtjHSBHWgG2ilhdyfFioC1TrVn7R4cfhH
	 Z26cY1LhxjXkREgSxqDh4AJ0RCaYBMedpjfdspj1iLR2WNumsNTTnUyb3+KDGSYPFR
	 t3SUMZkSJuAjQ==
Date: Fri, 28 Aug 2026 08:57:35 +0100
From: Tom Parkin <tparkin@katalix.com>
To: zihan xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bhong@brocade.com, stephen@networkplumber.org, sven@brocade.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/1] net: l2tp: ignore multicast notification errors
 in netlink commands
Message-ID: <apE_bzlcmIK1FOs1@katalix.com>
References: <cover.1786962220.git.zihanx@nebusec.ai>
 <ao1QMuGwSzhtlmo5@katalix.com>
 <CAANe3eR857ZyGa_2PdBOVaehCoHr+6qH1J0jid66-z_0nCEgMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TWalUHQLgH2pfhjG"
Content-Disposition: inline
In-Reply-To: <CAANe3eR857ZyGa_2PdBOVaehCoHr+6qH1J0jid66-z_0nCEgMw@mail.gmail.com>


--TWalUHQLgH2pfhjG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Tue, Aug 25, 2026 at 18:35:21 +0800, zihan xi wrote:
> On Tue, Aug 25, 2026 at 4:20=E2=80=AFPM Tom Parkin <tparkin@katalix.com> =
wrote:
> >
> > On  Mon, Aug 17, 2026 at 16:53:17 +0000, Zihan Xi wrote:
> > > Hi Linux kernel maintainers,
> > >
> > > We found and validated a issue in net/l2tp/l2tp_netlink.c. The bug is=
 reachable by a
> > > non-root user via user and net namespace.
> > > Here, that reachability statement refers to the finite state-commit t=
rigger;
> > > the OOM transcript below is a separate root initramfs leak-mode run (=
UID 0,
> > > PID 1) used to make the leak and panic deterministic.
> > > We've tested it, and it should not affect any other functionality.
> > > Regression coverage includes the root namespace and an unprivileged u=
ser/net
> > > namespace, with notification-queue pressure and successful ACK paths =
for all
> > > three commands; no broader regression suite was run.
> > > The finite fixed-kernel runs returned ACK success for all three comma=
nds in
> > > both namespaces. The leak run returned ENOBUFS and reached OOM after =
41984
> > > hidden Ethernet sessions.
> >
> > I think the underlying point about allowing l2tp_tunnel_notify and
> > l2tp_session_notify to impact the return from l2tp_nl_cmd_tunnel_create
> > and l2tp_nl_cmd_tunnel_create is not unreasonable.
> >
> > IMO it seems relatively silly to allow the notification to cause an err=
or
> > response to be indicated to userspace for the create command when in
> > fact the instance creation was otherwise successful.
> >
> > That said, I think it would be worth clarifying the behaviour around
> > the "hidden" tunnel and session.  From my reading of the code, at the
> > point that the nl notification function is called in both tunnel and
> > session instantiation, the kernel has already performed checks on
> > input arguments, allocated the instance, and registered it.  Even if
> > the l2tp code then returns an error to userspace, the instance is
> > present in the kernel's tracking structures.  I would expect that if
> > one then listed tunnel and session instances the new instance would
> > show up.
> >
> Hi Tom,
>=20
> Thanks for taking the time to review this.
>=20
> > That being the case, it's not accurate IMO to say that the tunnel or
> > session instance is leaked, and the fact that you can cause OOM by
> > continuing to allocate new tunnel and session instances with new IDs
> > isn't surprising.
>=20
> Agreed. =E2=80=9CLeaked=E2=80=9D was too broad a term here. The tunnel an=
d session are
> already committed and remain present in the kernel after the notification
> returns -ENOBUFS.
>=20
> The PoC does not use `ip l2tp show`; it sends generic-netlink GET requests
> for the newly created objects. On the unpatched kernel, the relevant outp=
ut
> was:
>=20
>     tunnel_create returned ENOBUFS at tunnel_id=3D1040
>     hidden tunnel is live: tunnel_id=3D1040 ...
>     session_create returned ENOBUFS at session_id=3D1000032 ...
>     hidden session is live: tunnel=3D1040 session=3D1000032 ...
>     session_modify returned ENOBUFS as expected
>     post-modify session state: recv_seq=3D1 send_seq=3D1 lns_mode=3D1
>=20
> So the OOM result comes from continuing to create new live Ethernet sessi=
ons
> after userspace has received failure responses, rather than from an object
> being lost in the kernel's tracking structures.
>=20
> The more precise description is therefore that a best-effort notification
> error overwrites the result of an already committed operation. This can
> cause userspace to retry and accumulate live L2TP objects.
>=20
> The v2 wording was updated accordingly, and v2 has since been applied to
> netdev/net.git.
>=20
> - v2 Link: https://lore.kernel.org/all/cover.1787247008.git.zihanx@nebuse=
c.ai/

Hi Zihan,

Sorry my review was late (I saw the v2 was applied right after I'd
responded to the v1!) -- but thank you for taking the time to expand
on the above.

Your explanation makes sense and aligns with what I was expecting, and
I'm glad the underlying issue is fixed which I agree is an improvement
on the previous state :-)

All the best,
Tom
--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--TWalUHQLgH2pfhjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmqRP2sACgkQlIwGZQq6
i9DFigf+JzXcHfxoC3NH1UM2cvpOxEFRgO23cljMTzALe6vqh6XFYKk8MS6y/6W7
OZfRmSZ8LROoWDqaXbDZpTNHLwpsc3fgIEsEx1xNg2Xl8i6SZdSErhhw23nyH0LA
u1wemLaKOAX58m9jMVAHiizWpbtIwPK5AObbTAC6RkAOhMYr36B1Go16YKRsf8Lt
ckbuVC3SUkDjWSYHQUhnly6NAUNKdJiJNMwrl6qA9nhfvj2IVqUcbNyG+c4CWKc4
YCBxlRPE5cxRnR/8o8aZKAhLju1F2rUBglr1962xZ2pyNQdPgci5s3x5HWYQInvz
4oIqhU8l9jtseukiZ/VYKJ+/3CR+iA==
=TnJD
-----END PGP SIGNATURE-----

--TWalUHQLgH2pfhjG--
