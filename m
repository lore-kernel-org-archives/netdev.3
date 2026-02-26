Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53744103F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121987; cv=none; b=fgG9Lb0pFKa7VwDmjKH3y3O1hf6fLaZWoRarKgnDK2WKWzLSRQLoNP6/Xp2z49tL7oEc8qO6pueJcnWWsXpLx2VwbLmWZX6Fv4ze0yo8e7kTDYgkNkTPe0UTmSOjzmLjyXDXBC322wefLYwKIBZXOs7pxwta2OxcWQJPf7OqDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121987; c=relaxed/simple;
	bh=Ihx26FJcEqx3rS49sNroyXVpZ7+ilkUxM1VHMpsimPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwltfKdSapSYr9vtxyX9zsay0/A3UTtf2UygxD2yoU6OL/i09x9XXXvqLAFR1D9vK7Tb5nTzYvlSq4SHKRaRX4TIqffrFth2cW1crWVTuj66Px/dNj8ZDkitndzRNrsiVsvbxMOfVkje+hu0T+qxj5uoVEkySO/W8qrp2Z+nxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vvdsO-00000000310-1Uak;
	Thu, 26 Feb 2026 16:06:08 +0000
Date: Thu, 26 Feb 2026 16:06:00 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v4] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers on MT7628
Message-ID: <aaBvaG3M58W4lhVC@makrotopia.org>
References: <20260226154547.68553-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226154547.68553-1-joey@tinyisr.com>

On Thu, Feb 26, 2026 at 03:45:18PM +0000, Joris Vaisvila wrote:
> The MT7628 has a fixed-link PHY and does not expose MAC control
> registers. Writes to these registers only corrupt the ESW VLAN
> configuration.
> 
> This patch explicitly registers no-op phylink_mac_ops for MT7628, as
> after removing the invalid register accesses, the existing
> phylink_mac_ops effectively become no-ops.
> 
> This code was introduced by commit 296c9120752b
> ("net: ethernet: mediatek: Add MT7628/88 SoC support")
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>

Reviewed-by: Daniel Golle <daniel@makrotpia.org>

Cc: Stefan Roese <sr@denx.de>
