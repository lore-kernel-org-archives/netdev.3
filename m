Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC33DDDCB
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646260; cv=none; b=a2IN5gouwh59QPiLhPvLSVAVM5w6QIEGWHpfxN43LeOaYrG8MdAzb1v2ne/2ik9O43vIalCTKx7FAoQ01wJ14PkooWYrLhKjoDZqxe5Ez4waRtmuKOOj75rdZ1wxgz5FUjh8+5tNxFvBsOnl6dj3tKcBeDNrLWUpESivETfioKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646260; c=relaxed/simple;
	bh=DZQvgMF9MtoSMKn9/xxgPT3t+kYxUHeBLkPFZwmxGy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYWa2HC3r+LZAhZmp5WNOjmTu6+EBVFXIcrPD62XfSdZWFKM06uFX9VJbzlfzvfdZSwlYTd/onNGQIeYL1WqpDrblJK2yFZFBMZR5ALu8Hq3gn5ie4azgh58CrO1wb0IKvF2ryBYdwk/IW+ksqDvpFpqeQ7AXt/8QG/CTw9z8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BFeqlQ0q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BFeqlQ0q"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso719084366b.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787646255; x=1788251055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DZQvgMF9MtoSMKn9/xxgPT3t+kYxUHeBLkPFZwmxGy0=;
        b=BFeqlQ0q/iI/Y9xCCyZW9DcLrNuxdKfN+Y+//0GtDmUjYy2yEe/So/1C91iOhFggaa
         w+PoJMpJllcqUOV1XX00bD7B84xNhMcsllE/0Nmh9dN8tZqJJBTNzbShKDQnxPsEmaEB
         ADAFZ+g3kLKRuXMS8OJko/112mNWDH4sfjFIo4ughfQq/cnFDH/p9Dc0K0AtS70+B4FM
         F9fsHPDaiztrmyZ3lyUZT3jElm9oP2eZVU4cOzQu3ucYmiskPZDEWm9d/KJQ6ZtJ4Xeu
         uIa0swNl0ttsWWPbGXJPM6SHTBQ7jF+5mcgT6fWzV+zAaPzszidX3t44XfJa0Wfi3HSP
         gdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646255; x=1788251055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZQvgMF9MtoSMKn9/xxgPT3t+kYxUHeBLkPFZwmxGy0=;
        b=r8df8eHDcZ12o7DvaAhqbpjnSnKPB3pn6Nz2nvedecwkD1+9MGEizjgIJXjj6GvtVR
         vrQQalploTrGx+JQZILAdNfyZUWP4rxOcpnUO6El194kx4H0AMyAk8eYykY7DXeziO0+
         jMPNFd7FDzmfpNVQGkX13rqrMi1owtQyh4rUFFWhGJ3de2WAO5G/GR0VjF26hIWQ8DUO
         737aRglrkAKhWxhPuC+nuRSJlH6uXShJTdnB2hLMeyELoe4VPrAOt8Qv03SsH1ZyrmRX
         gDgVne+Po27SEWd2ullw88CVU6ju6dk6jB2IcWm5hJ7ns6cUnpV/a+av3LP0GKOSXikz
         GmwA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3aJmejHMfAhxlJcq15zXY/on5Z1bzic3D0XCmP2u3Bhii2TA5R3TNY1AlcixGEgxr/ge3azs=@vger.kernel.org
X-Gm-Message-State: AFuF++mD8Nj+4bndEoj2iGZuqzU3Cs2dUKWaJcaDxJnwkWzMFpKxCUsC
	ZrUP12cFzkPt61bAqVv1uOogHcZFZYZ/g9ys7FHPyugYYifsRsD7ke9+xpTZ3ItNZ3ywM+/jpPn
	wUzLUIGg=
X-Gm-Gg: AR+sD13fL1mBbZbIFdr9APASYhNeZx3Hqf95P9vtCK1zC6NfFmuxqtYfH9s7ppkOJ7R
	uwDzIiUYjpclt+nz069LsArHnIxwZeG5UHn8543mjicvbVmNIY+lCikkC2bd+o8vFyRolZ8sHjv
	ndphsFsDVcgNyCBjCNwseIyv97iOkPw/TMXAUgsCjrGjPlg3gytjDJ+4nbWJ3doR2WPijt50jba
	/Ew4U3KfQSJW+Ik+GyH6FdOSDhmkXVlgrHPjYm6ppqcu30IzscAXfYFWsBehaE9dyHarvhLT6RI
	ijEbGzS7QjaGjyz3G53P6JhAKH6YltlCUytTV9C+oFJM1KwM801zV/IXa4WATMxXWMhvUai3SAH
	cShedr5rYZ85L0oBzWNQKPR7OOvBI6MNRgRGvamX5mCslZoMewMt2eR4JoUAm+K0Q8b3WaKDldh
	dXA9DKNnt1R96dPhooWL9YBVzJMLcx5x8I5foeMAGkd/IwJMZShmc6MzntbtFxuCk4WqjzvQPm8
	LG1TgfD+yJF4B7d1BLFI+PzZrbkWpp6i+scZTGxAxDlBXhbVw==
X-Received: by 2002:a17:907:1c07:b0:c15:f26a:3438 with SMTP id a640c23a62f3a-c24e5c1ffd3mr497229766b.24.1787646255345;
        Tue, 25 Aug 2026 01:24:15 -0700 (PDT)
Received: from localhost (p200300f65f19a904037016a565660d5e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:370:16a5:6566:d5e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c24966f9cbcsm1874351966b.29.2026.08.25.01.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:24:14 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:24:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	kernel-dev@igalia.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	fsverity@lists.linux.dev, keyrings@vger.kernel.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, bridge@lists.linux.dev, mptcp@lists.linux.dev, 
	rds-devel@oss.oracle.com, virtualization@lists.linux.dev
Subject: Re: [PATCH RFC v3 03/13] sysctl, mod_devicetable: add macro
 MODULE_SYSCTL_TABLE
Message-ID: <ao1P_mEJdyRExG3v@monoceros>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-3-aab90569365d@igalia.com>
 <aomlfGJM61qZKxx2@monoceros>
 <4e3eaf1d3419e808be046035f114bf6c@igalia.com>
 <aotteDcc588iwC6g@monoceros>
 <4aa22e41e8ff4bab6638cf0baaa9d07b@igalia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajsyed3ibfmsggn6"
Content-Disposition: inline
In-Reply-To: <4aa22e41e8ff4bab6638cf0baaa9d07b@igalia.com>


--ajsyed3ibfmsggn6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v3 03/13] sysctl, mod_devicetable: add macro
 MODULE_SYSCTL_TABLE
MIME-Version: 1.0

Hello,

On Mon, Aug 24, 2026 at 06:04:03PM -0300, Mauricio Faria de Oliveira wrote:
> On 2026-08-23 19:12, Uwe Kleine-K=F6nig wrote:
> > On Sat, Aug 22, 2026 at 01:57:24PM -0300, Mauricio Faria de Oliveira wr=
ote:
> >> On 2026-08-22 10:41, Uwe Kleine-K=F6nig wrote:
> >> > On Wed, Aug 19, 2026 at 03:16:16PM -0300, Mauricio Faria de Oliveira=
 wrote:
> >> >> The MODULE_SYSCTL_TABLE macro emits a struct module_sysctl_table va=
riable
> >> >> with pointers to a sysctl table's path and entries, and table/entry=
 sizes.
> >> >=20
> >> > That new struct doesn't seem to contain any pointer?
> >>=20
> >> The struct module_sysctl_table fields .path and .table are pointers,
> >> although with kernel_ulong_t type so that the same 32/64-bit size is
> >> used in file2alias.c based on KERNEL_ELFCLASS (and not on the host,
> >> which might differ with CROSS_COMPILE).
> >=20
> > Cross compilation isn't an issue for the already existing device id
> > structures; many of them also contain pointers.
> > (While modpost doesn't use the pointers, the size of the structures must
> > be known to correctly interpret the arrays.)
>=20
> Indeed. I missed some device_id structures with pointers, and that
> devicetable-offsets.c is cross-compiled to generate
> devicetable-offsets.h for file2alias.c to use offsets and sizes of the
> target architecture.
>=20
> I'll change .path and .table to pointers in the next version.

I *think* the existing device-id structs use char[] for strings that are
relevant for modpost. I look forward to you finding out if there is
still a justification for that :-D

> > I would be great if your series didn't introduce a new obstacle for
> > [CHERI].
>=20
> Absolutely. I'll be happy to adjust the series and testing for that.
>=20
> Could you please confirm one should just follow [1], which uses [2] to
> build the LLVM toolchain, and use it to build the kernel [3]?
>=20
> [1] https://github.com/cheri-linux#building-and-running
> [2] https://github.com/cheri-linux/buildroot
> [3] https://github.com/CHERI-Alliance/linux/tree/codasip-cheri-riscv-7.1

I used
https://github.com/CHERI-Alliance/meta-cheri/tree/codasip-scarthgap and
didn't care about toolchain and rootfs. It also has qemu integrated, so
you can actually test it.

Best regards
Uwe

--ajsyed3ibfmsggn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqNUSoACgkQj4D7WH0S
/k5rHwf/eQKyjSm4dfYOnpO+kyESzhGSDXacrU0BK/nrQ7Z3BN+QipNdHe9BZ4f7
k+3uxaB8pZmyHeh98alfg/5Bq9HBt62YSsVo0f1LrxdEuw+otojZstZ5BajlC1fB
uCZWsGYJ1lROqcGUkm3WTuwmO+VkI4no1e0+OMnKjMkIdarwm+SRxroNmGXPxjFS
0c5XzO8ufI4T330xBhTtUCfIGtmOib0XeyZT/dCtT8wNoKlznA36ojMl4ZOArWgW
VYBN9/JdmoDGTZxdbWqXoETzY//dT0yaCQF2J8+eM7vMW+ay0vkBIpxXkR9QmIGF
KIDH4l3txv82X35T5GJP5y9myooT6g==
=Ph6i
-----END PGP SIGNATURE-----

--ajsyed3ibfmsggn6--
