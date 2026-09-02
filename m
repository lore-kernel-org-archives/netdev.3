Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37D2E7366;
	Wed,  2 Sep 2026 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352489; cv=none; b=mxt720GPKVHxN+IIGNCFYnJ3ZDnYZDYoKyciYLTwm8UgSqkTqv7isexegw2hhygmj0uFzb3FON7MbgTKroTeRJcyNzDZR025N3zaz0DjOyM9qXu4DwvXWY0xQRyLfG5K/EAy1dwVatjEBcLCtMbE26FplH/WfdAiXbW08+pgKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352489; c=relaxed/simple;
	bh=QTOz9WuygDUf9f2kuZRKTQxDJxuXW5+qSiq0sqlF5bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOlZDxdFdO+9ikV6XcVqa5TAXpPPaXcyBiIAJZDc7IT3b4b4dXbFJYaklFRXVQhMxIgMUDzh8L0/KOOmqbs+rRdFysMHVXNlKdWZ8OvLWxFZvq2LyPIbSccdfdVwYizJE6To5L0EqwS/4ZoSgJcj3Wfpek1M5K6jJpXGmhHWHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hp03u8TH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hp03u8TH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DqIr+thPrbep/O0pQIu8oOVm6WAFx0khwrPGH8+faaI=; b=hp03u8THC/bL/aO0tZNb/guAdj
	6JE1X0XikSOzaUI55ijxAp09/JKsp8VYSxaBtCILzK3/necMgjMbyUS8KowWKVI2++f5v2jYh/SFR
	ft1e9Zn2OCyYQFzftb9gGc0MIseKxQTQiZiDR/nfi2Xv9NdenQD3jOd4KSUxGwsZAgHU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1kAc-002W90-LK; Wed, 02 Sep 2026 14:34:26 +0200
Date: Wed, 2 Sep 2026 14:34:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v5 0/9] net: dsa: mt7530: modernise register
 access and add two DSA ops
Message-ID: <e3b0d41a-ff23-4dc2-aa8e-3fc279f750fa@lunn.ch>
References: <cover.1788190568.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788190568.git.daniel@makrotopia.org>

On Mon, Aug 31, 2026 at 04:37:43PM +0100, Daniel Golle wrote:
> The mt7530 driver carries its own register accessors that predate the
> regmap conversion and now largely duplicate what regmap already
> provides, including locking. Most of this series removes that layer.
> 
> It first moves the MDIO bus locking into the switch regmap via
> .lock/.unlock callbacks, matching the PCS regmaps, so any path reaching
> the regmap is serialised automatically. With the wrappers no longer
> adding locking, the thin mt7530_mii_* indirection is folded away and the
> remaining accessors are replaced mechanically with the plain regmap API,
> using the coccinelle semantic patches included in the commit messages.
> The two remaining reset polls are converted to
> regmap_read_poll_timeout() and the then-unused dummy poll machinery is
> dropped. Open-coded register fields are converted to
> FIELD_GET/FIELD_PREP. None of this is intended to change behaviour.
> 
> The last two patches implement .port_fast_age, which flushes dynamically
> learned MAC entries on topology changes, and .port_change_conduit, which
> moves a user port's CPU-port affinity at runtime.
> 
> The swallowed MDIO errors Sashiko flagged on v4 5/8 have meanwhile been
> fixed in tree by "fix swallowed MDIO read errors" and "fix remaining
> swallowed MDIO access errors", both merged into net-next. This respin is
> rebased on top of them: regmap_* return values are no longer ignored,
> which is what most of the semantic patches had to be reworked for.

I only had a quick look at the series, but it seems O.K. to me.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
