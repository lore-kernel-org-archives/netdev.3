Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655222FF643
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371023; cv=none; b=pOwnY6FHunXBV4TYoQ/GG9VDjehi3LVRg15PE4GRZt6fT2yrp9zQYSnJwLAE+bAPh8M6yTZduzPMWmGnpIE1YQNRRxxIIUoogi5ShpsqMMP/fZoHEbDEtlYDxLTKD5LDRkP4bnzBktfyEy+DCz2EIXt21n/o0S3516kcj7reAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371023; c=relaxed/simple;
	bh=SIzIr7J/ys6KuszxPkCxIdtPxJ+fKxE0gxsHSNnjas0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gosaKUlTwAdCN7KtZOa8uNNnBcifZpjnkZS7SPuJ9zDQ4mdAWSA1IfYXGd2CAlcSRWU78h3duiJuGjLlTP2k+cx1CCBDEqs/W4yuJyy14nF2RlpPBta0INMgt3s9Pe77RZb+/HFG3jw35yXv6AhFkAFChizX7ivpTE1ayqJ0o+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFvcrkP2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFvcrkP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782EFC4CEF1;
	Sun, 25 Jan 2026 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769371022;
	bh=SIzIr7J/ys6KuszxPkCxIdtPxJ+fKxE0gxsHSNnjas0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rFvcrkP2olv4yq0/cu+UtH6tgL08aEzZhTekeHkGiNnmk3lelbSH4iu6FIfkLfSKm
	 UwoLz1rV2d1m9+hm7LDSt6zFrJYo01yBTEt+6MWSM3pu6j8PJmbfNDU+OszJ4CF09P
	 lAGVy7uqLOLTtMgDGid1IUgvtEEiW4QM/uykw+UpcQ2mYeff1S6hUEhhohknQiCo1C
	 o+0BDXVP1NO0XUreUk8yvl5sRDWYntTY18vshqD4vjAx4gXXsCDzz8WEFfTBIaEKAk
	 mhpHOCbUhN0ft/VrWKJTyd/CuNrQCC9WgOgCowK5HjC1H7D+c29fxKUGT77fdStiQ2
	 lRq/pFfdR3FZg==
Date: Sun, 25 Jan 2026 11:57:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>, David Miller
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: make PHY fixup support always
 built-in
Message-ID: <20260125115701.27a3db0c@kernel.org>
In-Reply-To: <66f110ca-3a49-46fe-a996-c5ad477b8f4d@gmail.com>
References: <800595c6-496a-443e-92e3-37251195e610@gmail.com>
	<aXM96CNzkiSIPukf@shell.armlinux.org.uk>
	<66f110ca-3a49-46fe-a996-c5ad477b8f4d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 12:39:22 +0100 Heiner Kallweit wrote:
> Recent removal of the dnet driver removed last fixup user not being
> platform init code.

Oh, driver removals may need to be reverted if someone speaks up.
Could you wait at least 2 releases with the dependent cleanups?
We had to revert back at least 2 drivers we removed in the past.
