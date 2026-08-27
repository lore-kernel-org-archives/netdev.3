Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C419366075;
	Thu, 27 Aug 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854399; cv=none; b=MIziTHdCCJ1ulgWkWf+dHwEchzv7btDSq81TeiMiBaRV0ekK7bUzA0tOo2FzxSl/TsQEebgGScPi4Cjq47ibnf2ihgtSgl9sLuxiQnN2wzhIvmhZd+EUyw4lnYIH2Byy1HmPlKQx1qcb+Lx/f82UVXSRezEbX88Ea9p4XrBD/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854399; c=relaxed/simple;
	bh=67gFJyU1P+ShSTG8wExHaaoaRNU52SWxJIXR0MbC0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAZLKLIy4FJnkfcPOOOpKv5VvucihdRRR4t/oiajPh04N+qkVSoYMYuxUOPrc6elZb6mY9+J07a8fkQywshl8Mvjbi+0MZ8Zt8OG57BSAqTfEixkOFYWs64rh9tLcSlcMOPnNzwjA9wRHa9+fyZZQnyjQepXWrbUNYD6Hn4mU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dHqgXAoV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dHqgXAoV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IoQU/6fzzXlG8e+LszOJee1lrSsQe+ACl9wBVnDv6zA=; b=dHqgXAoVmI0kVTLChoKEvm9ki1
	0+1g6Rlq4XeWS0grpmb/rQsHCvZ8r+YlQc8p6GRYvmBcnm2TrEL61m8KpvyK/KqoiEi+QkFaHLi/m
	iQckVUu4djA4uI/ZpGarA5rEe+WaZ28I5I504JZe+DSnPODMsG/fMnNZOiI3DjQWrfK0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzeaz-001hnJ-8B; Thu, 27 Aug 2026 20:13:01 +0200
Date: Thu, 27 Aug 2026 20:13:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: "Chester A . Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <olteanv@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 1/2] net: dsa: mt7530: populate lpi_interfaces to
 fix EEE support
Message-ID: <55dbbbcf-f3b2-4e2d-bc3b-78fb0be4d843@lunn.ch>
References: <20260824024117.46154-1-f@lex.la>
 <20260824024117.46154-2-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824024117.46154-2-f@lex.la>

On Mon, Aug 24, 2026 at 05:41:16AM +0300, Aleksei Sviridkin wrote:
> mt753x_phylink_get_caps() fills in lpi_capabilities and
> lpi_timer_default but never lpi_interfaces, so phylink treats the MAC
> as not supporting EEE: ethtool reports "Not supported" and
> phy_disable_eee() keeps userspace locked out. That undoes what
> commit 06dfcd4098cf ("net: dsa: mt7530: fix enabling EEE on MT7531
> switch on all boards") arranged: EEE off by default, but enableable
> with ethtool.
> 
> Copy the supported interfaces into lpi_interfaces after
> mac_port_get_caps() has populated them, and leave the speeds above
> 1 Gbps out for now: drop 2500BASE-X from the copy, drop MAC_2500FD

Blah, blah, blah.

Please assume i can read the patch and understand what it does.

The commit message is about answering the question "Why?". That you
often cannot see from the code.

    Andrew

---
pw-bot: cr
