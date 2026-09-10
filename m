Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A453D9549;
	Thu, 10 Sep 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033127; cv=none; b=necq9c2uCFbk+Qn5Ev3Wcw/1N4NHKukhKjfhkggBZjH+hDmE5CUJnduj6+i8NQrLs8ZxUyawGOt2pQlWjDVxFPdKBFYzSQDoceG6FJgOw7v3NOYrmxFoy0tcWauw8kwxYa+S3ozdSDA2+XydGw24pxJPxsk6z6tBkL+SLL+CN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033127; c=relaxed/simple;
	bh=I+CpvqGceWZnjKcu9lcpQ82vVPlkPae6+r2SQbj9A0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKbkDSmx26usiNP0AGzBfWfhYDe20ttD6YgCAbRHoslVOFyMlsBFHI0UGHJMcA1xIU2JSwO2sOJZ9pkopD7LRZGG8s+0SchNhBfpAofbww7eMltwv/cEnKSRVd9ED8hYQ7+imy52hDv06m3kFKtKUR1eIE1Ym5agi3sRYFzxXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAl0THIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAl0THIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A081F000FF;
	Thu, 10 Sep 2026 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033124;
	bh=7+PwGDECKyn040Qn1KrU5zr4IVFEWYVYDrIesl0qDCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GAl0THICf4izMiY0b1ObPzFJ6ETOmiDquibdgiCYZCiodjBi7TGvP27cnNs2aH+Wz
	 dZN32YgDVu3ehuEDuAxH2pFc38J2fTLm51eSSmJjKXT147Ma93G6K89y+oalSsge81
	 lsMT+63VokiwiJBXCniAMqunvXJdlsEcoTddt7KKC+VQmIL+4TtgZ3n7S3fQyH/tbd
	 k0jCSScshOX/Y6tVCp0tPGIs0oMEFCQEPenM+RJ+p2qVpy/PRbnLSRguwwQVxWqkDD
	 bd5FjOmViKQ3pMk7Tk4wWHsbTk2u1NcT9PKB5yOykWKG4DtVZxcJTyrUdzraMK33bO
	 0uDmKYgEC2lPw==
Date: Thu, 10 Sep 2026 10:38:39 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev-bot+sashiko@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	rsaladi2@marvell.com, sbhatta@marvell.com, sgoutham@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v2 net] octeontx2-af: fix PF/CGX debugfs PCI bus lookup
Message-ID: <20260910093839.GQ40544@horms.kernel.org>
References: <20260904085114.3385530-1-rkannoth@marvell.com>
 <178900878938.219967.12274726532197277893@kernel.org>
 <aqIdw4TpfTRTK5km@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqIdw4TpfTRTK5km@rkannoth-OptiPlex-7090>

On Thu, Sep 10, 2026 at 08:32:27AM +0530, Ratheesh Kannoth wrote:
> On 2026-09-10 at 08:23:09, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> >
> > Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 1
> >
> > - [High] Incomplete fix: the identical PF->PCI-device lookup in the
> >   sibling CGX debugfs file is left broken.
> Concern is about a different function, which needs a fix of "domain" field.
> Will address in seperate patch.
> 
> > - [Low] The recorded commit message describes only the bus-number change
> >   ('It assumed PF0 always sits on PCI bus 1 and derived other PF bus…
> >
> > Pre-existing issues:
> > - [High] get_cpt_pf_num() (rvu_cpt.c:387-407) derives the RVU PF number
> >   from the PCI bus number using the assumption this patch declares…
> > - [Medium] The inverse bus->PF translation in rvu_sdp_init() still
> >   hardcodes base bus 1 and is consumed from inside the function this…
> Will take these up in seperate seperate patches

Thanks, this approach seems reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...
