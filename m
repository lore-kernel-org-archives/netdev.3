Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B93314C3;
	Fri,  2 Oct 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962471; cv=none; b=X7w+RGlPNlvnDYK13jlIVptZcG58I0uv7Y0ysIhLUgA5Tbzia1z4Pkx2BqoHRxoM1HoFmTyJ9ytBXc6Af5ds639sdzDAdkLAi3o/jhVOB/RnlEoGJibLK7p2D+3MFCIFHDBdi2GqYEV/DOAaPh4QzHZerfFx5RHmuiLPKh+eU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962471; c=relaxed/simple;
	bh=uBKkkvXcqWP1HdrlFH+/Kt+o0tVbOLeIX1KBoTYvCFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNVhSGgBMNECZnTMNu+hnVcNXGjcPXXIryVL82KhqtuAKzbAvwYjfZ72k9L0dZfDmmWrdsyyU88a8VRZlVNbPoRi1MRFwiBDnwLzVUTbyStE9MKwBY3wlZURVoyfVJmNEGwZzHdfU9APGsF1hnVBv4UaeLZduTGIj0c2t03CeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ndGxOaP+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ndGxOaP+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ve2dMC9PSdOrVvkkkeWzs54ySdoNlOjzWjR1ldamK+g=;
	t=1790962468; x=1792172068; b=ndGxOaP+/xiwWyYtxgmBfxQ3gLZJwqSUb3BLFGn9gsOGFyO
	09UpjrR044DrwuDqVwGDnbXdxmtn/nho9HoMqgkp9W3ha0auEbGoHsu878ne6HfTGBNB3lxfdjrQD
	v9jvgOLz0JURqx6DoQ7uwbjSlCdVD0TnmYUyq5cMSVmKSTH+u2KJDw4jwQC5vbMkLJHJ1oopkJMVP
	WDr5ncJC9PWUrS+yFaagzkyybjpDc+2/Q7X6XFtqCbQ9j+QMC0yVc25COVvbMfKb4chhkTY4xoyek
	waX4hkcmwoKq3yQ7milbC3M4n+ckPGY3okrJO2o0AhStgGClquPLBt0MGyTR8OsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xCh9J-00000001gCK-0oB3;
	Fri, 02 Oct 2026 19:34:21 +0200
Message-ID: <7fc3e2730ebea674abf750a39c53d6ee307a907e.camel@sipsolutions.net>
Subject: Re: [PATCH net v3] wifi: nl80211: document sta-info nested attribute
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	 <donald.hunter@gmail.com>, "open list:NETWORKING [GENERAL]"
	 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Fri, 02 Oct 2026 19:34:19 +0200
In-Reply-To: <6ae7fd5e4d24bdeb0f0df057f767107e08567640.camel@sipsolutions.net>
References: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
		 <20260817084713.7a7694d6@kernel.org>
	 <6ae7fd5e4d24bdeb0f0df057f767107e08567640.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2026-09-05 at 09:46 +0200, Johannes Berg wrote:
> On Mon, 2026-08-17 at 08:47 -0700, Jakub Kicinski wrote:
> > >=20
> > > ---
> > >  Documentation/netlink/specs/nl80211.yaml | 351 +++++++++++++++++++++=
+-
> >=20
> > Hi Johannes! Should we add this file to wireless in MAINTAINERS?
> > Or do you prefer for us to handle the YAML stuff directly?
>=20
> Not sure, we don't really seem to be using it for all I know, and so
> it's just been getting some random updates like this, I guess.
>=20
> I think I tend to prefer the status quo, but I guess I could also just
> apply patches to it if you prefer.

So that's what I said a month ago, but because Jouni prodded me about
our inconsistent documentation today, I actually looked at converting
*all* of nl80211.h and our hand-rolled policies to be generated.

It ... takes some work, and ends up being 12k (!) lines of yaml, vs.
today's 7.2k of nl80211.h and ~1k policy in nl80211.c.

It also requires a bunch of changes to the tooling:

 - kdoc comments for attribute-set enums
 - exact-len-warn check
 - validate-fn check support and creating their prototypes
 - combining min-len/max-len for binary attributes
 - strict-start-type support
 - flag to generate the whole attrs without linking them from ops
   (otherwise we get even many many more lines of yaml)
 - NLA_NESTED/indexed arrays support
 - allow nesting the global policy into itself (yeah ... I want some of
   what we were smoking ;-) )
 - allowing inheriting different members for kernel policy side
 - drop nesting when subset overrides type ... not even sure how to
   explain this right now
 - option to define only policy, not ops
 - allow taking ops IDs from an enum, because our ops don't match the
   ynl ops too well
 - enum-max-name for definitions to adjust naming

There's a license issue - we have ISC license on nl80211.h now, but
Donald and Hilal picked GPL/syscall/BSD-3 for the yaml and of course
that carries over to the generated .h file, not sure if that's an issue
for downstream projects but might be with advertising clause? Could we
change it if I'm adding >10k new lines from nl80211.h? :)

I can post it but ... is it worth it? Not even sure it would
significantly simplify our lives, although the generated header file
with documentation is much more regular in that it always has the type,
etc. (which is what Jouni was asking about)

johannes
