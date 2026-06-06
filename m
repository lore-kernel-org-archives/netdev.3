Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48F27732;
	Sat,  6 Jun 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780711332; cv=none; b=eUiIC9Ip8Wcj1k3GQGBef4dFOijyHqSdveuzeKgGZXquPOhpwjHI2exvYaMQ2PYoEnKFbZu7tJ4b6sivH8gcnA+5vamixJ/Mnp1d2Hj05k39xxvLUYQKPvDM4M1dYVRjYsLRKzldNsmkSezuso4ADrpeHwzqtKQNAJ7x/48B/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780711332; c=relaxed/simple;
	bh=LeHSnjnqbLVXcDsKUGS5PgMUdfeDOJloiapbYXt7pBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFocith28xQXSxa4KWyIt9aCbEj21T4gzNdZKkz30z07nIIPEzlVJ5BwPSOkGHxNj/thB9jASbo+MVKpRZ+ov0S55fM+hGj0YAPWjKhGx0jg6Fth2gkZ7nJO+9e7xbxobK3NDVn30Wwbhoof1eEw7/s8oHsNE2nHQATXzH6icQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dds0bjfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dds0bjfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256401F00893;
	Sat,  6 Jun 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780711331;
	bh=yh0BXhqiIlcx6z4MpNCDBtu+5u/9s0k0Lsx3/FWcMtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dds0bjfi9cDSWxA73dhzCM5W1LCOmQYIqH6Glvas9cchmUy1wA9tAKEEFyH9lpxRo
	 s9K8H7IiG9ZYI01U1b5CAk+2ZepInw+t5/t2S7LT73KYFsdtryQJnzW64LGD88oldA
	 PCdQDL41U+P7+CaMKtM0O/U6YxBjVZhJnPg7t3StJmsOwNhYo2Lu34o61iujQPRxVE
	 EHqMGXu7LnGWg3b7Q+buEPocKKjdBy8fyxWUJ13+R7eyoH4CH61uprCADm6ASGU8tG
	 EYMHi/hU7W07TNqUUR8tNWXSQ5nthDogZynOvcQtxT+l/6t0rYG3rqbQjl7N5MwRmi
	 LUnU4eW2G1xyQ==
Date: Fri, 5 Jun 2026 19:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>, Jakub Raczynski
 <j.raczynski@samsung.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <linux-kernel@vger.kernel.org>, <k.domagalski@samsung.com>,
 <k.tegowski@samsung.com>, <cs0617.lee@samsung.com>
Subject: Re: [PATCH net-next v2 1/3] net/stmmac/dwxgmac: Modify DMA
 functions for future hardware
Message-ID: <20260605190210.13d9b18c@kernel.org>
In-Reply-To: <aiAiAbasQA3B3aT_@soc-5CG4396X81.clients.intel.com>
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162618eucas1p1fb6e7ed11e0a77e709bca37cbc7e4f28@eucas1p1.samsung.com>
	<20260601162537.553512-2-j.raczynski@samsung.com>
	<aiAULX7SlidVGmhq@AMDC4622.eu.corp.samsungelectronics.net>
	<aiAiAbasQA3B3aT_@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 14:45:53 +0200 Larysa Zaremba wrote:
> > > Because dwxgmac2_set_mtl_tx_queue_weight() returns void and is invoked via
> > > the stmmac_do_void_callback() macro (which unconditionally returns 0), will
> > > this early return cause ETS qdisc queue weighting on higher queue indices
> > > to silently fail? 
> > > It appears userspace will receive a success code while the hardware is left
> > > unconfigured.
> > 
> > As talked in previous mailing, answer is yes, there will be error in dmesg,
> > but no fail, for very simple reason that we would need to rewrite A LOT to add
> > proper error handling.
> > I just hope that if user misconfigured this stuff they will read this error
> > and fix it rather than complain.
> 
> But previously those callbacks did not have any failure conditions, so I would 
> say that adding a message-only failure does constitute a minor regression.

+1, this feels a bit sloppy. The driver has some painful abstraction
layers but if we cut ourselves some slack because of that that'd be
basically encouraging shitty architectures.
-- 
pw-bot: cr
