Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88144D597A;
	Thu,  8 Oct 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474168; cv=none; b=sKLyLq2nLAQGely4E63iPbGwdM4bVrtk1uadqVuoX71kBi+rs2lH5QpgCaArYkZ+/nY3430gLM/9KPAbPyBFUN/1Ip4oqC3oQn7gobJEZ1htgsMwa62EcHDOXAparaTbwuXboubTmcEYc7DdY1PxllDdBbT4r4ViUTGgYnVMmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474168; c=relaxed/simple;
	bh=dnbnqbKAA/HXWfb3uJEeW3Gw6pGdhzRZhD6v1pWCTns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAK6M0dEVw4NyeopCmBKoBAacVm8uo8KUkbiIRIoDmeHRTF4522v55vpvdzEwughVHjNH4ac0twd6qigOH00cucYwk5N5wdGLBduvIxeACWRMtizf+jvmvbXe1bftm4+1A4Fc3SEmPpvKa/Juwa4Z8FtaIC/TIuJoL8oxrsUDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxHUW660; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxHUW660"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332C71F000FF;
	Thu,  8 Oct 2026 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791474167;
	bh=6rvQiUyBmDedQne1YRWyYGQ1d3Qyysw2fJh4rBZ2Rwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LxHUW6606+pyIjVDsHbA7DnzOW8I0Xp1L2uEtan4hVoCuhgYv6TrVV2hFXb5f1FHm
	 OIjMaK+3kREEoafJ7zz2BjSNCH6bBS7iYzr5b8Jp4NWy/jZFx4wfnzkjn0ONX7ZWAK
	 FzQFfoElyJDTPm0SrMcMSOqFQE/9D1kKITDQHzG+gXymYcv8o0fhSTvAchCJgKRb/d
	 r2RSd2UfUuJRgKIE2yoUpsKAG1e3GkDX8Wm4aCLE4GIBwQDBv9k2UIZlSY+XEkTSwk
	 WvRoMBEjK453U6z2cGrzu5H4vEoATILla5ZsruwbkFRMG5dMX92+yE61U6/7xPGTHx
	 +fp+jOYedtUwg==
Date: Thu, 8 Oct 2026 08:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: emac: mal: replace devm_request_irq with
 request_irq to fix probe error race
Message-ID: <20261008084246.03aedeb9@kernel.org>
In-Reply-To: <CAKxU2N8QddjJfx377npH94+Uaw4kG4GkAFh-6wofN9iXO-sNZg@mail.gmail.com>
References: <20261007183821.928263-1-rosenp@gmail.com>
	<179139868898.2527009.7529803204490860855@kernel.org>
	<CAKxU2N8QddjJfx377npH94+Uaw4kG4GkAFh-6wofN9iXO-sNZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 12:20:08 -0700 Rosen Penev wrote:
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.  
> LLM tool scan probably.

probably? Are you being sarcastic or you don't know?

> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> >
> >  - What hardware the change was tested on. For driver fixes please
> >    mention the device (and if relevant firmware version) used for
> >    testing, or say that the change was not tested on real hardware.

Please answer all 3 questions.
