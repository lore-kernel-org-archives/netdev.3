Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C2377AB6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855976; cv=none; b=j6/RnYsC8ypVXCA/7i+/IA8kmlV3zIxGGqpz2NcIHLMFSjGSMcFwoQS2z3FxsnuGHz8mgPM/CBCNTQ462av8A0A0pPAX01d4ysRT62vbxFq2LcUZYNFzG2fNXone44vHTy4ocLxX60d+rNXS5T+Tzlpxet98+s304c5xAuOx/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855976; c=relaxed/simple;
	bh=9daxbI0HSht0wVJaWq5393Mo55rid9S27R8KYlr+y8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAMwQnwVX6HvNM3t02L0VM/wXi/aA1+1E9G+SJ3bhSeKL03z7CCdq8/UMrqIp7z8a7Udwo/rGX5mhCT6Ho5PKesIclsJp5zjERAqG+JxG9Ac1YUoIG/P+bkWnHMtB4xQmM+owMiv7u/pys/KQ4QUIdvB/p73g3jycCB3MfClw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=IElsANR2; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="IElsANR2"
Received: by dvalin.narfation.org (Postfix) id 39F01213F6;
	Tue, 04 Aug 2026 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785855968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGyFUS60OFb+RkdYW7cYUTt/u308Yp1AYWaW9fby3MM=;
	b=IElsANR2n3GLKaSmQfO5wgzwf0qstSc3xb/a73kwuJ1tN6ooGRRoulNm+NEqHl9qtkgNE8
	4Z8jHOw6iWl0R7j4HfIvOdxZ2wmlSO9RM3IacFTtBlyxNzJXiB+KFoiFg0hvFvV/i6Byd7
	3EKJin36dswXo/KQ8D0QZL12L0nTbaw=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject:
 Re: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-07-28
Date: Tue, 04 Aug 2026 17:05:59 +0200
Message-ID: <4072288.fW5hKsROvD@sven-l14>
In-Reply-To: <37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
References:
 <20260728133918.643267-1-sw@simonwunderlich.de>
 <5248054.31r3eYUQgx@sven-desktop>
 <37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2995662.yaVYbkx8dN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2995662.yaVYbkx8dN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 17:05:59 +0200
Message-ID: <4072288.fW5hKsROvD@sven-l14>
In-Reply-To: <37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
MIME-Version: 1.0

On Tuesday, 4 August 2026 15:08:01 CEST Paolo Abeni wrote:
[...]
> >> Note that it's preferred to avoid fixes and stable tags for changes
> >> targeting the net-next tree. If the fixes are really minor, both could
> >> possibly safely dropped. If there is some real problem behind, such
> >> changes should instead target the net tree.
> >>
> >> Can you easily rebase your tree and adjust the PR vs the above?
> > 
> > I have a different statement from Linus:
> > https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u
> > 
> > This is why we started to not send out net.git fixes PRs for things which 
> > aren't highly critical or for Linus' "just merged for this release commits"  
> > late in the development process.
> I actually think netdev preference is consistent with Linus'ask: move
> the "fixlet" to net-next.
> 
> The additional twist is the ask to drop the stable and fixes tag
> (otherwise stable will be flooded, too).

I find it quite unusual to drop the fixes and stable tags - just so Greg+Sasha 
have to use their tools to figure out that these were maybe fixes and need to 
be backported? This already caused problems in the past and had then go 
manually through literally years of changes (LTS releases!!!) to figure out 
what was lost in the backporting process. Yes, the years in which it was 
disallowed to use Cc stable@

But to be honest, I have no idea what "fixlet" means here. Is for example 
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20260731023333.70727-1-heminhong@kylinos.cn/
meant by it? Because this is for example something i don't consider worth 
backporting. It is definitely fixing something but I never was interested 
enough to do it myself when two or three other people tried to send 
incorrect/incomplete patches for it and then disappeared after promising a v2. 
Which at least makes me think that it isn't worth the effort.

But maybe you are talking about something completely different.

> PR are a bit apart from plain series, hence my initial questions WRT how
> problematic would be stripping such tags and how impactful are actually
> the things addressed in the first 6 patches.

Sorry, I am lost. There is stuff for which people have actual PoC code. Afaik, 
nothing for an RCE but enough to locally be a minor annoyance. The things 
which have no "Reported-by" are things which I have problems with on my 
installations.

And about the others: The "bla: avoid CRC corruption due to parallel claim 
add" + "prevent CRC corruptions after claim flush" were a problems I had (next 
to another which was not yet posted to netdev) but has a "Reported-by: 
Sashiko" because it was also reported by Sashiko when posting other bla 
patches and I think I've stolen the example from the commit message partially 
from the Sashiko report.

On the other hand, "dat: atomically update mac addresses" looks like something 
I had from time to time problems with but never found a reproducer - and 
Sashiko provided a convincing explanation when I posted completely unrelated 
patches. Not sure if it was the sole underlying problem (next to the ones I've 
fixed recently regarding the vlan + tie-breaker)

The Sashiko-reported fixes "dat: avoid unaligned fault in IP extraction" and 
"mcast: linearize skbuff for packet generation" are luckily nothing I had 
experienced first hand. The latter would end up in a BUG(). This already makes 
me think that it is worth backporting. But at the same time, I didn't hear yet 
about anyone complaining (and it is already in the codebase for a while) - so 
I am at the same time not convinced that I should anger Linus by asking netdev 
to integrate it to net.git so late in the game.

None of these things, are super-critical (I could be wrong) but all of them 
are worth backporting. This is why I was trying in the last moths to 
proactively backport similar patches to all stable kernels and either directly 
send the backported patches to stable@ or provide backported versions when 
only some of them have backporting conflicts.

If you think I should sit on them until them until the release of 7.2 and then 
submit them around the time of the merge window) then I am also fine. It would 
then not be sitting in a "linux-next tree". But this is the best I can do 
without submitting them to net-next.git

On Tuesday, 4 August 2026 15:16:54 CEST Paolo Abeni wrote:
> Please be aware of net-next commit c82ff94592fb: the expectation is that
> submitters reply proactively to AI review comments.
> 
> Specifically it would be helpful an evaluation of how critical is
> problem reported and if it could safely addressed with a follow-up.

The LLM situation is really starting to get 	unbearable. It is like cutting of 
the hydra's head - it will directly bombard you with 20 more "and now for 
something completely different" reports. But preparing proper fixes is now 
also not ok... And at the same time, LLM tools are becoming a must-have for 
posting patches and now I even have to start to write rebuttals/explanations 
for these reports. I get why it is helpful for you do see comments from 
authors/submitters about the Sashiko reports - otherwise you have to go 
through the reports and figure out if it is unfunded or even already fixed in 
one of the next patches in the series.

At the moment, I feel like the last survivor for batman-adv which tries to 
solve (at least some) things. But at the same time, it seems that what I'm 
doing isn't well-received and I get (for me) conflicting information. Not 
a super motivating situation.

Not sure what I will do about it.

Regards,
	Sven
--nextPart2995662.yaVYbkx8dN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanH/1wAKCRBND3cr0xT1
y88KAQDRPo8M7KDQ/oyE+SXYC6MJsOBgNhmmZhPte5+jYpYWkAD+IPJHzwQxa5nR
So36jC+yvTFktKpvMsyD99yjGwuf1gk=
=itWf
-----END PGP SIGNATURE-----

--nextPart2995662.yaVYbkx8dN--



