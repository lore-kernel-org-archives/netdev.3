Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8173F58D7;
	Mon, 24 Aug 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567735; cv=none; b=CM+c1AFvsS0rbMbag/7C35jWVfuffQLUGSMcmeuISb1DHQcrGF+CHECv6zlhLbD6lzjZubR01m+811NF2SJVudveKeSDW53TJazQ+hhLMeO6N7QHigFZoREmjQ+yP+VW3NlzOf6alYX/sJWdKz8puGTRdS2KlpOQhpQWt6OdWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567735; c=relaxed/simple;
	bh=q2Uev4tNxxv6lwZok/RAmcFGK7tgqpTIAMxVrSmNDFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5wXWOno2UxeuqyrFLFP4drTy5LgkqVrv8aaGDG/oKZtz3fUmE0PXahpFPACxjxa7btj28jWzo4UkUgmI3daXBJJarXoGEpbCeaROd8QrcNoIip8O/04qWWZvPhz7EG9HPUH62iha1yoQu3td5mx9rgEG2uOme/GmIwB9zpmCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWEVOyqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWEVOyqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E663F1F000E9;
	Mon, 24 Aug 2026 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787567734;
	bh=RJ+0ewlbjrQTQ0DjT99npV9TM6cnXI6dD14ESh+QyIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RWEVOyqcNShaNwnF2hZXmWigJ9k2EvdAiizAn17bnP81GOBR7GHPGbLm133sDINkn
	 ungKihkmdc2gSDkwp6JZmy+otPR3MgWekJ+3D+Wy9tmaeBMoH0uYyPrCO5aKQwTEve
	 mJpKObE+5r1BlikMP6ah4ODFhAah/blKUFXYrTschsvcqSxdY6pWa1Q6EAHdsn6PIl
	 5IWr5K1tlmhwTlCPUGFIb25Sm901SKObZXUrhHNHCHIbvpVjnXueUf45Py1c2Khvfe
	 Y0W29lFabA9JafEihiwgGOrgwTUDIHfEvQs7rDXDW0cEpCzctFt0s5WvGVDXbedi1Q
	 9AUkd+7D6Xxow==
Date: Mon, 24 Aug 2026 11:35:29 +0100
From: Simon Horman <horms@kernel.org>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anshumali Gaur <agaur@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Sunil Kovvuri Goutham <Sunil.Goutham@marvell.com>
Subject: Re: [PATCH net] octeontx2-vf: fix workqueue and netdev race in
 probe/remove
Message-ID: <20260824103529.GO265046@horms.kernel.org>
References: <20260820083634.1641740-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820083634.1641740-1-nshettyj@marvell.com>

On Thu, Aug 20, 2026 at 02:06:34PM +0530, nshettyj@marvell.com wrote:
> From: Anshumali Gaur <agaur@marvell.com>
> 
> Initialize the VF workqueue before register_netdev() so ndo_set_rx_mode
> does not queue work on a NULL workqueue. Unregister the netdev before
> destroying the workqueue, and add proper probe error cleanup.
> 
> Fixes: cbc100aa2205 ("octeontx2-nicvf: add ndo_set_rx_mode support for multicast & promisc")
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

