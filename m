Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484E2741B2
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759807; cv=none; b=dBiqzCcpccaPDX7fgQ2xKrvAuhLMrv2LWmfrY1CJLcV5ox2k2nnYbV5b3BHWXJ6yRqPNkuG8vEhCJoDoShqcGL3TguFnYJYE6zSHku06q5IEjFuNwtS8Tc5ilBz49cnvFwB95h344aFjR0A69soN8jWD1e5gtx9Y7fBJovy6BWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759807; c=relaxed/simple;
	bh=DIQHmmiJAygM/SC1YbTx1ppwwrfubzjsKDeIbfDD588=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZUg9MBusr/OJKrHudwlUUaS8TbcBKOWYN65VHQMaAqJmBCtTuNI1fFqXGCJlO7D6pNKQEu7q2birGspt6kYQ+ySrG5Er5tm4UiSuwVi75BxWdYgJeEN9RKsQ3q+qNM2WquJnqjjaMUg0+x5lvDeXuc9End1tVViZdvOpJH9w98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNnvbgIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNnvbgIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A18FC4CEEB;
	Tue, 20 May 2025 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747759806;
	bh=DIQHmmiJAygM/SC1YbTx1ppwwrfubzjsKDeIbfDD588=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fNnvbgIjanV13cWpYLXONAqPJ/UpMpSkoCZciQh8qCmSRYyhi5qdGclgAsdTpaYZm
	 akHUbbWHm3yZpY+coJUzXse5KM5oLfx9L+dB+WosKyJh/AFJ0njsdqYcAyGwn1Lgsx
	 e2UTroLs+D7dl+nk1/F/aZxI/4mW2APxSdm1PFX4pyklDI+Lvnr/iG0iqzcXmUGXzW
	 vAa2WDNtIm0S9Q3ABUU6oTaz5Bb1mbUWxtCgEGzIMenui5JZ4+a18jplmF7Wu+Teau
	 YVuTOZRymDekxD86G/e+ov5DPXS11iHR2MrV2roBeSHhM5oFsY0ZsHc84EnJr7NMtV
	 mv+YX4aAeEaDA==
Date: Tue, 20 May 2025 09:50:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jstancek@redhat.com
Subject: Re: [PATCH net-next v2 10/12] tools: ynl: enable codegen for TC
Message-ID: <20250520095005.1bdd64c7@kernel.org>
In-Reply-To: <20250520183416.5b720968@kmaincent-XPS-13-7390>
References: <20250520161916.413298-1-kuba@kernel.org>
	<20250520161916.413298-11-kuba@kernel.org>
	<20250520183416.5b720968@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 18:34:16 +0200 Kory Maincent wrote:
> > We are ready to support most of TC. Enable C code gen.
> >=20
> > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > v2:
> >  - add more headers to the local includes to build on Ubuntu 22.04
> > v1: https://lore.kernel.org/20250517001318.285800-10-kuba@kernel.org
> > --- =20
>=20
> Now got this build error:
>=20
> -e 	GEN tc-user.c
> -e 	GEN tc-user.h
> -e 	GEN_RST tc.rst
> -e 	CC tc-user.o
> In file included from <command-line>:
> ./../../../../include/uapi//linux/pkt_cls.h:250:9: error: expected specif=
ier-qualifier-list before =E2=80=98__struct_group=E2=80=99
>   250 |         __struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
>       |         ^~~~~~~~~~~~~~
> tc-user.c: In function =E2=80=98tc_u32_attrs_parse=E2=80=99:
> tc-user.c:9086:33: warning: comparison is always false due to limited ran=
ge of data type [-Wtype-limits]
>  9086 |                         if (len < sizeof(struct tc_u32_sel))
>       |                                 ^
> make[1]: *** [Makefile:52: tc-user.o] Error 1

Odd, are you sure you have the latest headers for Ubuntu 22.04?
I added Ubuntu 22.04 to the GitHub build tester and it passes
there:
https://github.com/linux-netdev/ynl-c/actions/runs/15143226607/job/42572497=
918
