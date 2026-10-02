Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4D424655;
	Fri,  2 Oct 2026 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973058; cv=none; b=cIDl4QDDjBNm5sgHWmSFU03F5wFNajZQ1hUjWjca11EQ+zQcI3wCioETCeGQUFqV7dMsbILiGlJqMbF/IO7pGfp2NaEQRKyDTF7Pr2HYRUk4RpqHzZOnNQR4Ph/Np7hlR7EfzROjytYG0uXZ9yJ3RxA3omiMgF2zqQaUDLSQLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973058; c=relaxed/simple;
	bh=Uyo2TrSeXDlUHQS1CGR0Bgo59RRrDPOcyOuuDynewT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwIr8G1Pr/YyImOiBpsldySV/W7HzUfwv85IrIctW0xcNNRCV6LAj7KNgjlmPPD7hNPXvsTXOfVXyJtqNz7IcEDAnn6j+6NkFKj1j/295lTjljGjcVhNyrjGrICQMVP62Le5a4Hho0sLAj2BN2fmWU/RBW3RIukiCyjy7acX6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fSaQ5SB2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fSaQ5SB2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Uyo2TrSeXDlUHQS1CGR0Bgo59RRrDPOcyOuuDynewT8=;
	t=1790973048; x=1792182648; b=fSaQ5SB2xIMCrMGGJ6Sg5T60qWP1d5UgRJdUCvcxWY+M/4B
	TzDz/1HWXGlhZDRUA0UjFV6uKH/BoD1/42aE6aLB7KckBCAt3Z7ca9zzjGoaLhHK65AJ9sMQgaZ27
	2jEG1M4bsntJMYnlJAZrwzXV1Fm5K4EFRoTRF4RHbJxDaWm9oR0y0X9XJk18lqzjFzRV3gaWOZYTW
	hWwdtdMwh28d3authh3tT/BYQC/+Z21t8RI2bcYgz2owOioQ3wn29tYZI2mp2udMTDygxH99ZLFp6
	+Xy/Ie1ofOaBXjydlfsd7OhjOUnvZWixCKVcByh5JsiYiHmjTIGsHMg17NMJdJBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xCjtt-00000001nXW-1sZC;
	Fri, 02 Oct 2026 22:30:37 +0200
Message-ID: <649cc93941ed71c60d08151d8d13570f5e5319ef.camel@sipsolutions.net>
Subject: Re: [PATCH net v3] wifi: nl80211: document sta-info nested attribute
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hilal Rahmatullah <hilalrahmatullah11@gmail.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	 <donald.hunter@gmail.com>, "open list:NETWORKING [GENERAL]"
	 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Date: Fri, 02 Oct 2026 22:30:36 +0200
In-Reply-To: <20261002132500.0b71889b@kernel.org>
References: <20260816101216.20947-1-hilalrahmatullah11@gmail.com>
		<20260817084713.7a7694d6@kernel.org>
		<6ae7fd5e4d24bdeb0f0df057f767107e08567640.camel@sipsolutions.net>
		<7fc3e2730ebea674abf750a39c53d6ee307a907e.camel@sipsolutions.net>
	 <20261002132500.0b71889b@kernel.org>
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

On Fri, 2026-10-02 at 13:25 -0700, Jakub Kicinski wrote:
> >=20
> > There's a license issue - we have ISC license on nl80211.h now, but
> > Donald and Hilal picked GPL/syscall/BSD-3 for the yaml and of course
>=20
> That license is required for all netlink specs, FWIW
> It's totally my fault if it's wrong, I just didn't want it to be
> _just_ GPL since that would propagate to use space code which
> we want to be permissive about. The spec is effectively a uAPI
> description it should be public domain in my non-layer mind.

Oh, sure. But BSD-3 isn't (advertising clause), and people copy at least
the nl80211.h file around to other projects. And the syscall exception
doesn't really talk about distributing that code. So presumably going
from ISC to this would require people to update even their binary
distribution's docs (where it's built in) ...

> > that carries over to the generated .h file, not sure if that's an issue
> > for downstream projects but might be with advertising clause? Could we
> > change it if I'm adding >10k new lines from nl80211.h? :)
> >=20
> > I can post it but ... is it worth it? Not even sure it would
> > significantly simplify our lives, although the generated header file
> > with documentation is much more regular in that it always has the type,
> > etc. (which is what Jouni was asking about)
>=20
> Well, I certainly don't care so my choice would be not to have to review
> the code gen changes (:

Fair :)

I'm not really sure it gives _that_ much benefit ... I guess I'll mull
it over and maybe run it by some wifi people.

Thanks :)

johannes
