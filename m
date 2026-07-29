Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EE330B07;
	Wed, 29 Jul 2026 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291128; cv=none; b=AMgDuPx7cUeArcbKah4HVx4Pcsqx8wNF7VYxn6AD3DRJniRb8wgE9D2StXAsvznY/BX1d/mXQt0JlpVk71U9jCKh9VDD0XWCdLZlYS4rhCt3MAHgS319G0MNbDIXVzq6FcLfjS4+7kB4kFRdFilsZETw8rSIMzpFW42y8P0XB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291128; c=relaxed/simple;
	bh=Q+GJp7OX219gUcwhIbLyIzNm6VEsZQl4yZeAoi+zrg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRXS/h4bpGO4oRd0effPnftZ6/98L5fulde228bGBG2upQ7lld7VdCcCQy5wvS+tTP4xdt7VBLRy/48zaVHlu1ui9QiO8baif2VvzTYaweYZkQKe7pXhYZoHJUWn+Y8qt+guUEP+0cDiNEvNo0cQB1EoFodg2UT5kKIqhqMi+ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct8e0p7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct8e0p7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A36D1F000E9;
	Wed, 29 Jul 2026 02:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785291127;
	bh=/7dA1KFOUnW8nxWm55N4DeJuVD3fe/HXDBn/67aoe7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ct8e0p7szQVbpJH+qZ1dT2HyXHUzAtO1cX8aTSGeLRzjp+JWhS5SA0erZ/iR3tR2B
	 a8XciTQ42vAD2KBkiHxYVXc2+0wSYwe13MsKjw1lU/t//hQeyLzax7YMaYR2O5Vrze
	 MA4UXoLDSbEy5klno4WbB70lh+bXCm1Do0GlGnwPult6mBOmh4dru0MUJ2n66iT/5N
	 dSd4gC4VB6+/59885+4M+SetwNpazQhorY7o6hprrv7uRBMhsuQnUObw7tPZFYVpA8
	 gXstjHOanrvj1u0Vc8aN3602WBveLJmB2ZRK67dlmlPuebf0UAYqOvpbQo67QyCvK/
	 8YADF5M/nnaaQ==
Date: Tue, 28 Jul 2026 19:12:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Zxyan Zhu <zxyan0222@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Russell King <rmk+kernel@armlinux.org.uk>, Serge Semin
 <fancer.lancer@gmail.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Fix PHY attach when custom
 PCS is in use
Message-ID: <20260728191205.53e347c0@kernel.org>
In-Reply-To: <f14a1712-8315-4e64-b23b-ac00d7f82c3a@bootlin.com>
References: <20260726132618.3580612-1-zxyan0222@gmail.com>
	<f14a1712-8315-4e64-b23b-ac00d7f82c3a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 08:49:11 +0200 Maxime Chevallier wrote:
> On 7/26/26 15:26, Zxyan Zhu wrote:
> > This series fixes the issue where stmmac platforms using a custom PCS
> > via the pcs_init callback fail to probe when no phy-handle is specified
> > in the device tree.
> > 
> > Patch 1 is Russell King's phylink patch that relaxes phylink_expects_phy()
> > to allow PHYs to be attached in 802.3z inband mode.
> > 
> > Patch 2 skips the PHY attach in stmmac when a custom PCS is already
> > configured via priv->hw->phylink_pcs, avoiding the "no phy found" error
> > for platforms that manage link state entirely through the PCS.  
> 
> I've tested this series on the board that saw the regression from Russell's
> first attempt, and now with the associated stmmac patch, it works :)

Both Sashikos see a risk of regression here, could you TAL and confirm
it's not real / unlikely?
