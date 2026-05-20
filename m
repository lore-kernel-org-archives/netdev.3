Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCF3CA4A8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315813; cv=none; b=itYsvy0kHRkjk72W42qIWiselAiAOZVMNkGCYY+Te7usjLMhIsmIuDtj/JNVc4G+fe/W8amb/26SM7wM5tESh7m9ioeSdQM7ollU82C5Op/Uk3+up2L4RjDh5jc4jfcOAwCdLQEOeZ6223DK9/CRLLpg1PzHwWFaJKsuPbG88GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315813; c=relaxed/simple;
	bh=JKCn/Wz6Euz2vV2rgLuJfAmhYMXsAB35B2YMpYvbl/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBDWEQvl7r4x5Svv/f8WMWWWiS7A6G+g+XL5BVZiRUyRsUTyYrRCpF3ysQ67s+EIC2xO86JYc0OhCJwrhOsynh21F0a9VGxgBsTlrduA3bzkzPAjdNZ8LxgAmDwvFJvmBtA9BG92K3sggYjdgL0hG8MNZFg0HftDVYZ8bM4JAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkAza7Kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkAza7Kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B231F00A39;
	Wed, 20 May 2026 22:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315811;
	bh=JKCn/Wz6Euz2vV2rgLuJfAmhYMXsAB35B2YMpYvbl/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PkAza7KfOOK2FtFpCl4ENyUVkHTj8cSdxSRgbg2CVBFu/kXjywjQjT7Vyt6D4ciEw
	 BjfKid8Gmhu29Gi1bvRYsaoxS+bDJ40W39vw3Ks8rxfBCpycKVEuZgKr2N5KXRebV7
	 lc4HCyJ8yeEGZqt03BIdtYetdQCdy7GAjXVTHEbmNwCEZyArbJdsw4NgaHFEF7SDee
	 lC+JXJVWZU1rHTuSXa9IzMqc4/KJ9djh6JFxO5yOk1mfUbjGxP226/2dzfO0+uN9Hl
	 fsvxH9cw6Q3VC6klihPDyKaq2bom2aLr9ATwht0xFqn5ULEEDrqcrtDzdcxFoVugth
	 ZpNhbTUKcMi3g==
Date: Wed, 20 May 2026 15:23:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction
 macros
Message-ID: <20260520152330.699e2ee7@kernel.org>
In-Reply-To: <CADkSEUhXU7f+k+yBO2Y=eonch2k7YmwbQe6o9RP9osRoo1KFBA@mail.gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
	<20260518010739.80979-5-enelsonmoore@gmail.com>
	<20260518182220.78a9ae80@kernel.org>
	<CADkSEUhXU7f+k+yBO2Y=eonch2k7YmwbQe6o9RP9osRoo1KFBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 19:21:05 -0700 Ethan Nelson-Moore wrote:
> On Mon, May 18, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Sun, 17 May 2026 18:07:24 -0700 Ethan Nelson-Moore wrote: =20
> > > Now that the BUS_ALIGN variable has been removed, the
> > > arcnet_in/out/read/write* macros behave identically to the functions
> > > they wrap. Expand them and remove their definitions to make the code
> > > easier to maintain. =20
> >
> > This one reportedly transiently breaks the build. =20
>=20
> This is due to incorrect patch ordering on my part - if you apply the
> ISA/PCMCIA removal patch before the two I/O abstraction cleanup
> commits, the code compiles after every patch.
> i.e., use this patch order: 1 2 5 3 4 6 7

FWIW we're expecting repost, we can't fix the ordering on our end
to re-feed all the CIs. Build breakage prevents any deeper testing
from kicking off.

I'm writing for another reaons tho - I've been meaning to ask whether
you know of any reason to keep arcnet in tree in the first place?
We can start with this series, mostly asking about next steps
'cause some are posting fixes for arcnet and I'd rather delete it
than spend time making sense of this ancient unsafe code :/
