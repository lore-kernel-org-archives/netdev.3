Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAF2765E2;
	Sat, 13 Jun 2026 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781366996; cv=none; b=QSN+zF9I7DhWz/0fhtfbZH5tENTPsR3n7nMB7shij0XjLjlSMR5dyQTYNTQvaMCp5D2eLr+6mKZza5LS/tKQYXcXtfEy/TEha0gvBgWz/3B3V7NthSK+DqN4Tu+CC7M0zybAah9EgozzmiDKe8ihTKBuESAOAwvM8V+f8hFleSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781366996; c=relaxed/simple;
	bh=QOJNy3fk4tqXbe57IEudcI2M43CdJjDbj69X0pe3VgQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTATbKi49JqFXlU3QI6KrQ4P+iUA1Wf8WLwxsL0fG60Gr+XofIwlyfqtZ79A2mzNKJ8QuwNhtIW0iCYzGn7rzo5PdRQf+8+WLAdIFbtADm2t4m0oZ0IsfJbWYrVPQj2NPffFt4s8dC+6MepHhzVvXAODHAnPJvNuN1iSr/OZ5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYQvO-000000001t5-42FX;
	Sat, 13 Jun 2026 16:09:35 +0000
Date: Sat, 13 Jun 2026 17:09:31 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/8] net: dsa: mt7530: implement
 port_change_conduit op
Message-ID: <ai2Au6DuxYcE-bH9@makrotopia.org>
References: <cover.1781312667.git.daniel@makrotopia.org>
 <8dd8cfe32bc8e38b92c49e30a6255090fb0998fb.1781312667.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd8cfe32bc8e38b92c49e30a6255090fb0998fb.1781312667.git.daniel@makrotopia.org>

On Sat, Jun 13, 2026 at 02:11:45AM +0100, Daniel Golle wrote:
> Allow changing the CPU port affinity of user ports at runtime via the
> IFLA_DSA_CONDUIT netlink attribute. This updates the port matrix to
> forward to the new CPU port instead of the old one.
> 
> Limit the operation to MT7531. There, trapped link-local frames follow
> the per-port affinity, as the MT7531_CPU_PMAP destination mask is
> further restricted by the port matrix. A conduit change is hence fully
> honoured by the hardware, for regular traffic as well as for trapped
> frames.
> 
> The MT7530 switch, including the variant embedded in the MT7621 SoC,
> instead traps frames to the single CPU port set in the CPU_PORT field
> of the MFC register, regardless of the affinity of the inbound user
> port. With user ports affine to different CPU ports there is no
> correct value for that field, so per-port CPU affinity cannot be fully
> implemented for trapped frames. Routing a WAN port via the second SoC
> GMAC is conventionally covered by the PHY muxing feature on these
> switches, which bypasses the switch fabric and does not involve a CPU
> port at all.
> 
> The switches on the MT7988, EN7581 and AN7583 SoCs only have a
> single CPU port, leaving no other conduit to change to.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

I forgot to include the previously received

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>

See also:

https://patchwork.kernel.org/comment/27003848/

https://lore.kernel.org/all/02ad5de0-ea6a-4267-8686-72e3f98fce4e@arinc9.com/
