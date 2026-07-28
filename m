Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3683AFB19
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279399; cv=none; b=hjVqs+9hYQ4JsLZggkFhTo3raNHeP59TAEFe6q6QBl2mp62pEYColX+UsctlpT+ZBBh2DFFoVAWchdZchf5S2ctmWJZwjs0ZvU7iRGzxHmJoPwF0LYv3jmXfVrHNyR5A2diGClx59aCbWobN1LxUxqXWWid9vOKW96tz7HXIf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279399; c=relaxed/simple;
	bh=nc7HdALFJqmmRLqfZYJDc+Gmo/XgwMSvXOi3WQTsETU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlAeJBWIFEbQo2ELDdd1WLRuH1yKahQ3doRPCFrnnS23IPNy8jh/b7tl2AhYhp46eGxCj6NUqfd86yQqItmJxdnU4dJbFvQj3ezZfV0NqUg8yN0uxwx5QMsG6z6G7JcNeopJCo1+Oig5J7h/3lrlPQpS1tptJT+JmQ7ycCfAFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=rKOtkw9n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EoqFTZct; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="rKOtkw9n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EoqFTZct"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E8C6EC01A2;
	Tue, 28 Jul 2026 18:56:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 18:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785279394; x=
	1785365794; bh=oC1I91TKDEvENrCiidHN/0hBndbGLK4lNZmiBybzC9E=; b=r
	KOtkw9n4uNDAEmAHm41D4J8qe8vuJHPgVqNn0nRfH6rXjsKlJeYBBIln1Dw3gGz1
	zz1Wxb7bPoJNWWVFpBK65alazVqrWb30qtz8xjSmzdcujD8IdT/dE9+faujwC24N
	vr3lagvh1083Qc3QuiM+sgvmbmbAY2wkSUtnEVFjkYQ1Q+PAggXcNuszbVHZ5qD1
	d5yOlOoJocrEyHE3IyY9Q/sPsBEz/etraIKQO9hRxREs9yPaZwwzbpkkMha7MJFU
	/S0aPsrFdopllUuKxmoq1+PZjIPBAs9CawBSai0y2XCJG+AHTDtHowIoWG3Rxqqr
	Q5gtXgkZ6y9hqGZCyRiTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785279394; x=1785365794; bh=oC1I91TKDEvENrCiidHN/0hBndbGLK4lNZm
	iBybzC9E=; b=EoqFTZctRz7So2S5G83C3nDR6bGSg6dPys+vnH5ii2dkKQ4Tvtk
	QpSmlYbsVPieQcs11R5yyb43Jh2vX7muoAlNv2xMvQpX0gJDnGnHgBop4FSoGLib
	RKjHmNZbHnakYsKjxTt1U8szcV5DkSGwOco0KZGwBZ6P0FTWStMVPNllNTZC+Lmj
	KN5xAUULAwHhFJ1jtnQaeV83CfXOgPC4fgulSGnSA2OirnsvBFgU+v5i4bAZZHm9
	ZKGChguiScaSQ3Wnj+8ZBwqz/xVsblBRxnmfZtBJmd69OYH+NJ0CJzMNDJZbQk6O
	7VFm/P4BE/qB+h9jxCbxHcwKflVYxALBX+w==
X-ME-Sender: <xms:ojNpamd_DA45fJIKTMqjHfpgz3su5Cuzwn04U8yPb18c21W7R8-m-A>
    <xme:ojNpaqPmpW9nVGNMuil9_DC0mn47Duot_uNQtkzepqPQXhgtweG8j3D_SEhfDW1aR
    a2GC37HVPLim92lLFK_tiNrSgfLKK3C_OL5pu3srCV4bqPq2gRV_Ryb>
X-ME-Received: <xmr:ojNpauIzXLeCW9SdD_LgBGG3EKw3sSro7a9tzi5OMFsoUfz6aXec2dgYNX0>
X-ME-Proxy-Cause: dmFkZTETz5PhtS5SW3P1uvVEWjqjMuaTfragFDxCRCunXy6w7DaxfzXWBL3nt181YfdBpe
    OGw8PQGHT4TgQ6rHqbhnnjwXpf1eZxUS/5IG0hicX4S/PooCQpqFUBSr3qRhDrFMKXL+7p
    dy+CoOmlyW/zxeVofgdKvH2evdHyenHwkGQ2SDyFKk8UfNpeLYt2BXq9PY4R6MGhJLiAN3
    jsu0hdKiETn/WX2uDNrfVYp6Ll7xyPVEtzDvGvml2bQX13LIlna6hbqGzIv3dYrY/DRlbL
    Z97DkzOSL4auoKlVGuzrtFwU5KdkJVSm5ilE40WdO58PYfSd9v/NeOSSfVAm572bHSbKQm
    CRyLlbG06eVO7xBn00MLIHDM8zkX2Oh5UuDrx6E/Sizgu7cRjp5MsWuCbxEEIyXVhdo56K
    YGyWT1AAL+Z9zDaIxYL1Qcb9lWtE2wqJ4x+0Lw2WMOhhPUR7eomdT6WlyWosO9mDCB+j8l
    uTaZ931ujtSKQOrXB5gjiHCboH+HfChT280gpDRAkmNE7VK3NE4LccvZxX1w7wTK8b3fHZ
    LosCmOVKxT2e3Vw5LBreWcvWxkRqrxmGzYx1FMFp4X9jgt20ibO2be3oDky7dw4Nw77SlZ
    ZWbK6domVLoskkAfQLhheCBAS6EK2H4LmfBcCFn2cXGoqDpYVCkX2VZIxGiw
X-ME-Proxy: <xmx:ojNpaiIh75lRatXx4wSbtV8B4QvYdRHYK5K_2WcUot7tD1y6lnxoRg>
    <xmx:ojNpag74sOw68bLQw4UA726tKYi_SLHPiQaWDzs0mzgt1nHdn1q8fQ>
    <xmx:ojNpakcS0slcoxtgr92g_1uwmvdeLdrHGFOl5zCh8oZzuaoR-Pdd2Q>
    <xmx:ojNpajFnb50B4LvDfRwHgX182LdamI9wf8a4dx0zanM1-0tlW9K6Sg>
    <xmx:ojNpaiyUwLs6M-FlYaPTbbiEphLL0Uo6VIqM1afl62MumVIP2J-JOcMb>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 18:56:33 -0400 (EDT)
Date: Wed, 29 Jul 2026 00:56:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Message-ID: <amkzn_79gJWAjGEV@krikkit>
References: <20260727204724.2787038-1-kuba@kernel.org>
 <20260727152517.312895f3@kernel.org>
 <amgBCpqbkrEIiCuh@krikkit>
 <b39fa14e-1bd3-4e02-8d44-648628303197@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b39fa14e-1bd3-4e02-8d44-648628303197@kernel.org>

2026-07-28, 18:17:27 +0200, Matthieu Baerts wrote:
> Hi Sabrina, Jakub,
> 
> Thank you for the patch and the review!
> 
> On 28/07/2026 03:08, Sabrina Dubroca wrote:
> > 2026-07-27, 15:25:17 -0700, Jakub Kicinski wrote:
> >> On Mon, 27 Jul 2026 13:47:24 -0700 Jakub Kicinski wrote:
> >>> +All bug fixes must clearly state how the issue was discovered and validated,
> >>> +and how the fix was tested. This should be done in plain English, not with
> >>> +special tags or annotations.
> >>> +
> >>> +Example statements describing discovery:
> >>> +
> >>> +- discovered by a non-AI static analysis tool.
> >>> +- discovered by an AI code review agent.
> >>> +- discovered by manual code inspection.
> >>> +- triggered during code development.
> >>> +- triggered in CI testing.
> >>> +- observed on a machine in real use.
> >>> +
> >>> +If the issue was not observed in reality (e.g. it was caught by an AI tool
> >>> +or manual code inspection), the next sentence should describe the
> >>> +reproduction. The reproduction should state whether kernel modifications
> >>> +were necessary (e.g. inserting a delay to widen the race). The commit message
> >>> +must disclose if error injection or loading a special kernel module was used
> >>> +to trigger the issue. The reproduction steps should be included in the commit
> >>> +message if they are short (roughly 10 lines or fewer); longer reproducers can
> >>> +be posted online with a link included.
> >>> +
> >>> +The testing statement should explain whether the fix was tested against the
> >>> +reproducer and against kernel selftests.
> >>
> >> We should probably also add that the commit message of a fix must
> >> describe the impact to the user.
> >>
> >> FWIW the intention is that we'd either quote this text at people
> >> until they comply or even get an AI bot looking at all patches coming
> >> in and deciding if commit message is good enough. With some tuning
> >> LLM should be able to check that the 4 items are covered.
> > 
> > I see what you're trying to do, but making regular contributors append
> > 2 paragraphs to their commit messages (or ask their LLM to generate
> > them, and also fight for an hour to get a reproducer that actually
> > does something) just to check the box seems painful. Reading the git
> > log with all this stuff mixed in will be worse.
> > 
> > As someone who's probably never sent a compliant patch, and who has a
> > tendency to forget new rules (especially those that are inconvenient):
> > meh. I don't think the commit messages we've been writing all this
> > time have been so bad.
> 
> Are these rules mostly for new contributors using AI to generate
> patches?

Based on the commit message, I guess yes. Based on Jakub's reply, I
would say no.

> I guess regular contributors are already applying these rules,
> either by using a Reported-by tag, pasting a call trace, or describing
> how the bug was discovered, no?

Reported-by doesn't describe how the bug was discovered, just that it
was discovered by someone else than the author of the commit. It can
just as well be an AI report, CI testing, someone else's manual code
inspection, or a "real life" bug.

The call trace could have been produced by adding delays to help
trigger a race found by code inspection, or seen in real life but not
reproduced by the patch author.

I'm not sure code inspection vs some tool (AI or not) makes much
difference, at least when the patch submitter has enough experience to
check the output of the tool before writing/sending the patch.

Without checking git history, I suspect there's been a bunch of fixes
for issues found via code inspection or sparse that were not actually
triggered/reproduced. The code was obviously wrong, it gets fixed. AI
makes reproducers cheap(er), but not free (in both tokens and
prompting time).

"Impact to the user" is probably missing in most fixes I've sent (or
severely lacking, ie nothing more than UAF/memleak).
[a few examples: 52501989c762 cbada1048847 5502bc4746e8]

But I could see an argument for "well we should have started
mentioning testing and impact to user ages ago".

> I find this important to understand how the bug was discovered, and ask
> for a reproducer or another sort of proof when this is a "potential
> issue found by an AI code review agent". Otherwise, that means the
> reviewers have to do the validation, which will certainly take them
> longer than the author to generate the patch.

Sure.

> I don't think regular contributors have to change their commit messages, no?

If that's the case, good. But "quote this text at people until they
comply" and "get an AI bot looking at all patches coming in" doesn't
sound like that to me.

-- 
Sabrina
