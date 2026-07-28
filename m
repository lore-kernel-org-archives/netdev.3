Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5640E54B
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200919; cv=none; b=fNnJaUSSD0dndzs007m6Ti1BBbBo8e6NRI5YyYp4J41Z01CH3ZErz7xnGd1AHUGVO1xPowZHFc94qHCM3NpvHYriWzH2AK0mSIRV2vm0iGrFks343txU7J2oexA7ZBAa+mqATXnqBacC0yLyhk8j179oGMXpc87jbbfVZsZVpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200919; c=relaxed/simple;
	bh=9BvR8Rn1kS4P8SKL/5QbNKqXNaCMC9O4LiauY8Tr3jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFNdybNsCSqmwDK8mNQgYzUbpqG9Ywl72CYfnrZ8R6z7I1kPI06u6nlPA0rsL3ryuq6xXw1iObBvJfn/tIWPUZlmx47Ejknjsia4vnWEPba4+FSrc8nX/EcamCgTB3qmUDaoWfJW0ieZlmBbRVfEkwyMxPhKaHpgyvxgd1wu4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fvE4y3ST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y2LYxiYj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fvE4y3ST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y2LYxiYj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9ADFD7A07D8;
	Mon, 27 Jul 2026 21:08:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jul 2026 21:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785200909; x=
	1785287309; bh=ifGuP2LlYivg3XL0G/RuPgA9WesJuV7GtE4WOflQVUw=; b=f
	vE4y3STF51rADrnRD+pUjoFbPvhvElybWQJL/MCtBvnub3NAg+ArdITjiwQQqNDg
	i9uRfIM+moEVX+dnuTY444geUHjRhH+vrEpCyc5K6Ve5DBgQtuuCiqAHyPo6OXg4
	LI0wdHGhH0ahMPoPxy5nB06NfJbjJUSUpKvoTJFE8nBF134ANiOTsx5xn7KjkXFZ
	pP1qLEnXdCWIH3Gx9tsjRpxMI/7pD/aeX6TdKtdmg1SRh2nbyiV2vkJaDSHmOXMK
	6pJCX6fnIoU7CQtIz5b65CvsmNG42aPtixknseTAduypP6VW5b0NIN9+xUxNW2OK
	T6znioYPD1UULn9YgoWNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785200909; x=1785287309; bh=ifGuP2LlYivg3XL0G/RuPgA9WesJuV7GtE4
	WOflQVUw=; b=Y2LYxiYjShuNmvV7z1v+bITSzhTEB1/qlxVCHw5yw5CihDabblw
	2SVG7LfnmLFCiiKGPtsgAyCyXz7BSCkUdrmIxLQTNlBTv6sJgaJXi7pZ02m824fA
	rnB39D7fvXZHVsadoKcMXy+G6WBifaQLRhrS+V1YSyLmKjLwLgD0H/yuVo7rM0v6
	zSy1aw7t6xS3N48XhmwD/uJCwrCVGOqr+7UTxQoWjH40OzlVZTeXMup8pLmv+k/2
	CHrjAcQeq217OgdPWwxnaoTOwPvYe6PADSijlSM9TEoQlRB4dRbUIftYxUpsAChE
	puZGE3UrbCoOXBGwz7UQQBwL5Cy7u1GaWXQ==
X-ME-Sender: <xms:DQFoanMct6q9gOt1l3UU6siCbR2JJ_3DGmk8Ca1GkQPhDneo1J6ptw>
    <xme:DQFoakNzWCa8wfw-ZMrqMPJW86yeaMf-FU_OX46fh9zOAKu35cDl9u0ujobZfyiQF
    8NeVv4sXq1vtAltLUDR5VQ-3sgLOETAhdMUaLEuQ8RH9AHcDrIi6vk>
X-ME-Received: <xmr:DQFoaoghPxInWBB3nlFGxfmBMaXilwqLzVKdr5HdB3IFkDE0exz_UgPsiSI>
X-ME-Proxy-Cause: dmFkZTGLNDDJC1XIRKB5lT0AkcvUtJnQaCeCVYKqXRuZYTmUHOQKRAG2/Y3DAISfILhsCw
    XKVTcWv+PIyrmbMVrzhNc66twEo/soGRKySHFJHvwin1ynYPdzKk/0163a/MoldvGAcejP
    Kt2HWOuoAmKjVhvypbIHpBTjErAh1K+efIgnuRzPjfaABsc3Zi2h97jdB/4YsTlS9YF3fn
    fQYqHyusCW7sSGM0vItt2eaGbRsNbqIG6hrFOqb22k7SUOQL6w7uM5yhmID0Q7hLInzwp9
    ygQaBZHKQCO5Oib4ta1++67KwFaYRO2C+CkHNAlz47+H18ScsOPso4YNlt3nh6uVtHQ8g7
    XrvtnigcqEsNkItBiBCqKlglmc/OJ/nGEY+6rpWLZye3RVeUG/BJk9cJETgqw9njLDIdL7
    cak/6hKroYXeQEda3R3Fzy1/RwL8YflDgjEdYKgvhKPOZFFbtYceFqQLmJeMZq4Xu96gX0
    yEm/me/b1yOD8dMyujA/Oa5nFxzdJSpQJj2nPlj90wQ2r6AYZdXTjRGxz3JoT7mOsj7PSB
    RqJnGZds/NVDN2BNoZCpfQRzk68Lcl7TjkEV0rqUTfeOi9Nexxs93HEGz5UFvLV3mFRWNC
    B2dWr/yrfR6kYRm5wHuwVgW8SI3VRHJDpTGBHGl5kGjwREnQAiY2xtTwlpmw
X-ME-Proxy: <xmx:DQFoahvlEOVKhrH_W7qvVuEdL0Ilfd_AkKaAd57IJUwlX80PXQQtcw>
    <xmx:DQFoauSioJzbq6EJgMFV6vQMvP8CD6TzKcnqaWITV0Xt15w0uj0wHQ>
    <xmx:DQFoat2SOzcFzfSXihgGVO4H7M7qL27u0WmsZzDp_4cJ1nPN9-37ow>
    <xmx:DQFoartx5odgqnNyeub98HwQJRSGvuspOhYaKwE4TMgb4bjr67Se2A>
    <xmx:DQFoanc1UW6_RBEv4jAAds0B61eNdAOG1I74VYRKyP6Am7qrcsOFSUuw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 21:08:28 -0400 (EDT)
Date: Tue, 28 Jul 2026 03:08:26 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Message-ID: <amgBCpqbkrEIiCuh@krikkit>
References: <20260727204724.2787038-1-kuba@kernel.org>
 <20260727152517.312895f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727152517.312895f3@kernel.org>

2026-07-27, 15:25:17 -0700, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 13:47:24 -0700 Jakub Kicinski wrote:
> > +All bug fixes must clearly state how the issue was discovered and validated,
> > +and how the fix was tested. This should be done in plain English, not with
> > +special tags or annotations.
> > +
> > +Example statements describing discovery:
> > +
> > +- discovered by a non-AI static analysis tool.
> > +- discovered by an AI code review agent.
> > +- discovered by manual code inspection.
> > +- triggered during code development.
> > +- triggered in CI testing.
> > +- observed on a machine in real use.
> > +
> > +If the issue was not observed in reality (e.g. it was caught by an AI tool
> > +or manual code inspection), the next sentence should describe the
> > +reproduction. The reproduction should state whether kernel modifications
> > +were necessary (e.g. inserting a delay to widen the race). The commit message
> > +must disclose if error injection or loading a special kernel module was used
> > +to trigger the issue. The reproduction steps should be included in the commit
> > +message if they are short (roughly 10 lines or fewer); longer reproducers can
> > +be posted online with a link included.
> > +
> > +The testing statement should explain whether the fix was tested against the
> > +reproducer and against kernel selftests.
> 
> We should probably also add that the commit message of a fix must
> describe the impact to the user.
> 
> FWIW the intention is that we'd either quote this text at people
> until they comply or even get an AI bot looking at all patches coming
> in and deciding if commit message is good enough. With some tuning
> LLM should be able to check that the 4 items are covered.

I see what you're trying to do, but making regular contributors append
2 paragraphs to their commit messages (or ask their LLM to generate
them, and also fight for an hour to get a reproducer that actually
does something) just to check the box seems painful. Reading the git
log with all this stuff mixed in will be worse.

As someone who's probably never sent a compliant patch, and who has a
tendency to forget new rules (especially those that are inconvenient):
meh. I don't think the commit messages we've been writing all this
time have been so bad.

OTOH maybe that's the only way to handle the volume of AI slop
"fixes". 2 more paragraphs when the commit for a trivial 1-line fix is
already 2 pages long doesn't make much difference.

-- 
Sabrina
