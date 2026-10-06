Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C4195B1A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791250043; cv=none; b=kSdDbmXhO0uwRYLRnyv3cQs7obAwBw3Q9GPJPcaV9nNdn/meyjXQUIRcH+/bW78U9iBhYp/QKfW/xVqxV1LSTVq61mdt5CtNZ0Y3MoDNmYFXR6jtog5qJTuCwwqVyUczgw1cuqmoi2Y8o5++AzvNZWRkR2qmJZy99oIHTarA6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791250043; c=relaxed/simple;
	bh=to2esl2cgAcf4ISkjFoFFsqyUqx5bBglFrlwk5ApYzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNRvhsUWUmOAdwkoRor47IaZU0eBcn7DFDh6x0UF8iThVmFXBVbJr7/CVMo7VVQdYq6FMBo0IBRsniQ2Yh2kUq+DurXIBhXc+6NMeafY6zfJkwVec6tYM1hJy2dhSE9rc561EJmvmKb2+ZulOnAR38KHdiwoUst7MOt5Y5YSbV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL1mwmtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL1mwmtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83401F000FF;
	Tue,  6 Oct 2026 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791250042;
	bh=KWdhXzsnAVpsPiPBE4tknyDEqZocKlrdxaYNwSJe32U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AL1mwmtkcmNPESAzBm4SL9ivDonMy81pgmT/RHdiI0l9yjDsRSHa3KUaDetFO2q35
	 j40suSOWmj93D5Ipf/IMelQ4DETFEPjKKWlYmU9wcXLqO11haFxjO1nzeEPNY6+HAC
	 MjweirmB07u7nQtI4901bF8huUX5I4JsQ0O5N/fFre8tgYtB9PxLqOArMMddpBgF3u
	 nL3MLhJgo7umTPzrb5deFKCwPHDv5+ep9pvmPVZknZ3ZXBKk2tPv8gt57lWxrdcHxW
	 r17HZNYaJj91L8JuvTUOKnBFWpDnryPpOhSvYPk4xUwzn8zT8rBWeav4oI0Gnu0cR7
	 SEfn7at7XmdzA==
Date: Mon, 5 Oct 2026 18:27:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in
 SW_RESET, restore it to SW_RESET
Message-ID: <20261005182721.776af8b8@kernel.org>
In-Reply-To: <897ffc5a-48ad-4516-89f2-0cdac082d7a8@broadcom.com>
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
	<179080972360.31693.266631430009737406@kernel.org>
	<20261001184130.2b7ab18a@kernel.org>
	<897ffc5a-48ad-4516-89f2-0cdac082d7a8@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Oct 2026 09:16:15 -0700 Justin Chen wrote:
> On 10/1/2026 6:41 PM, Jakub Kicinski wrote:
> > On Wed, 30 Sep 2026 23:08:43 +0000 netdev-bot+sinfo@kernel.org wrote:  
> >> Hi!
> >>
> >> This is an automated message. This series looks like a fix, but its
> >> commit messages seem to be missing some information:
> >>
> >>   - How the issue was discovered, e.g. hit in production, hit during
> >>     development, syzbot report, manual code inspection, LLM or static
> >>     analysis tool scan.
> >>
> >>   - Whether the issue was actually triggered, or is only theoretical
> >>     (e.g. found by code inspection). If it was triggered please include
> >>     the symptoms, like the stack trace or error messages.
> >>
> >>   - What hardware the change was tested on. For driver fixes please
> >>     mention the device (and if relevant firmware version) used for
> >>     testing, or say that the change was not tested on real hardware.
> >>
> >> Please do not repost the series just to address the above. Instead,
> >> reply to this email with the missing information, so that reviewers
> >> can take it into account. If the series needs another revision for
> >> other reasons, please include the information in the commit messages
> >> then.
> >>
> >> The evaluation is done by an LLM so it may be wrong, if you think
> >> that is the case please reply and explain.  
> > 
> > please respond to this  
> 
> The issue was hit in production and I verified the sequence keeps the TX 
> disabled in my standalone test. I tested on an internal development 
> board with bcm77122, but should be reproducible on any genet HW that 
> supports power management.

I obviously meant that you should respond to all the fix info requests.
Not just this one in particular.
