Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311C313272
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547885; cv=none; b=P1a37i7FUGkdt0/W0bnV+LzE4F05zB7MjnNKjE30k9fQFcz9YAcPE7Y531w2ed9lqZI7k0Jshp2O4qr/2e1qTt9t8Zdfj7R+ZKMeNR9c3F+0mZSvWukhAXnWbnwWT8Zf7/f9D/rDoTcav+6gmMm5oOUCcwjBLLbHvuT0wk+csWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547885; c=relaxed/simple;
	bh=y+o2Fs4GZ/ebWipNaFmuMlIk6Pe57kwzoVKgEOG75Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEkEPsjbWLGGcg3hoiwnvFecChQJR5tV9mRK+v+ImlSkKaICIbe8GA9xds3CqsR4VGuk/DuLqAAFzu8L0F3TBtzpx14aEsDhLNNzBcHe97xWXOHuIqQxf6bAtaXqW5J7j97GDvwhSMZHRfPzCufVpLwhXmdVzrccMF8xBgAAvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2kNTJh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2kNTJh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB221F00A3A;
	Mon, 15 Jun 2026 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547884;
	bh=PjnhFUV+DJ9M61y56ZqgW0xHhwIxT8Qwu4XkMPllLkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c2kNTJh2aBQiG81BkrjZ7qaMs+guw2c/oHQSgzCSSrpqbFXsfBln2egNz0QdtmpgJ
	 vuTuZXJWgpkGl76/189axKlmJh8C+rLpiltEZQjg9A5GpVfxaqB0KB4oa6tiK7h7Wt
	 WjkqEAH/wjiabz9SrmAKH/m4QTPwCn+YCCW+57m58yDnWWezZzYX77ngrOursSuWBL
	 x9rWn0m+5UaacYFN9d9REKY0SuArwrvjScf35mBdlDRs0nfM2RLyoD7bJ6LUDHuXdw
	 N8Vdk5YJ1c11l4nWlwfTBi6V1+83Cj7IbqiHoHhRdcDCGaGoaLNVl7yafII2nv/XX2
	 JPvXw1TYTiUdg==
Date: Mon, 15 Jun 2026 11:24:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, 3chas3@gmail.com,
 mitch@sfgoth.com, linux-atm-general@lists.sourceforge.net,
 dwmw2@infradead.org
Subject: Re: [PATCH net-next 0/9] atm: remove more dead code
Message-ID: <20260615112442.26c423b1@kernel.org>
In-Reply-To: <20260615163319.GO712698@horms.kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
	<20260615163319.GO712698@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2026 17:33:19 +0100 Simon Horman wrote:
> On Sat, Jun 13, 2026 at 01:10:23PM -0700, Jakub Kicinski wrote:
> > Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
> > ATM device drivers") removed a good chunk of old ATM drivers.
> > Our goal going forward is to limit the ATM support to PPPoATM
> > used in ADSL deployments.
> >=20
> > A recent burst of AI generated fixes for net/atm/signaling.c and
> > net/atm/svc.c made me look closer at the remaining code. PPPoATM runs
> > over permanent virtual circuits (PF_ATMPVC) with a statically
> > configured VPI/VCI. We can drop switched virtual circuits (SVCs)
> > and user-space signaling (atmsigd) support. While digging around
> > I noticed a few more obviously dead pieces of code.
> >=20
> > Annoyingly, I have applied one "fix" to QoS config which will
> > now make net conflict with this series :/
> >=20
> > Jakub Kicinski (9):
> >   atm: remove AAL3/4 transport support
> >   atm: remove the unused send_oam / push_oam callbacks
> >   atm: remove dead SONET PHY ioctls
> >   atm: remove the local ATM (NSAP) address registry
> >   atm: remove SVC socket support and the signaling daemon interface
> >   atm: remove the unused change_qos device operation
> >   atm: remove the unused pre_send and send_bh device operations
> >   atm: remove unused ATM PHY operations
> >   atm: remove orphaned uAPI for deleted drivers, protocols and SVCs =20
>=20
> There is a compile time nit on patch 4/9.
>=20
>   ../net/atm/resources.c: In function =E2=80=98atm_dev_ioctl=E2=80=99:
>   ../net/atm/resources.c:227:20: warning: variable =E2=80=98len=E2=80=99 =
set but not used [-Wunused-but-set-variable=3D]
>     227 |         int error, len, size =3D 0;
>         |                    ^~~
>=20
> It might be nice to clear that one.
> But overall this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Ugh, I thought clang is strictly better at finding these and
build-tested only with clang. Posting v2 shortly...
