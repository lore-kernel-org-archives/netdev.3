Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5A26A0A7;
	Sun, 23 Aug 2026 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787450171; cv=none; b=I8PnrqQ6HoNdwEgy7Ncu3CwMqt1m+uW6WVHRM967NzGQCviPmONn3dFpvJwOx1Jr5rdOMv8iPE3Y+Z2tWe7idHRSxbgaRe05yvA4cP63CcUDdACxg4sWnSCUVbp2bRyBryckkSQGcQtm0e/JjSJkz1cGexqNCtDnh765ke5QD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787450171; c=relaxed/simple;
	bh=zo6sTmV/CBy0u4J5TSzsgnMnCFF0UakRHml/ZSEiBTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvrcVYSO4GYMlqMM8aDwsg/oUiyoQTrhSfNh/d+O9VqzXKQET++f3ZzHE3xY8wHRiA76fcON7g/NPyFvQMeCffD9BtPjZTXA23GNsU2dSIBr8vkw86m8QUw9zlkgsLdVWtnN1D2nnNhGqyEA+GOgBqAo83bfZTLmqoCmzjMnTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wxxRA-000000006xL-2s0B;
	Sun, 23 Aug 2026 01:55:52 +0000
Date: Sun, 23 Aug 2026 02:55:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Aleksei Sviridkin <f@lex.la>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 2/2] net: ethernet: mtk_eth_soc: populate
 lpi_interfaces to fix EEE support
Message-ID: <aopGvtyZ_208mrXu@makrotopia.org>
References: <20260822195252.2934-1-f@lex.la>
 <20260822195252.2934-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822195252.2934-3-f@lex.la>

Hi Aleksei,

On Sat, Aug 22, 2026 at 10:52:52PM +0300, Aleksei Sviridkin wrote:
> mtk_add_mac() fills in phylink_config.lpi_capabilities and
> phylink_config.lpi_timer_default, but never populates
> phylink_config.lpi_interfaces. phylink only treats a MAC as supporting
> phylink managed EEE when the tx_lpi methods are implemented and both
> the LPI capabilities and the LPI interfaces are non-empty, so EEE is
> unavailable on every MAC that uses mtk_phylink_ops:

Thank you for tracking this down. The missing lpi_interfaces and the
placement after the SoC specific fixups look correct to me, and so
does keeping the xGMII modes out of the mask, given that
mtk_mac_enable_tx_lpi() refuses them.

[...]
> This also makes lpi_capabilities take effect for the first time, so
> correct its value in the same change. MAC_MCR only has EEE force bits
> for 100 Mbps (MAC_MCR_EEE100M) and 1 Gbps (MAC_MCR_EEE1G), and
> MAC_EEECR only carries wakeup times for those two speeds
> (MAC_EEE_WAKEUP_TIME_100, MAC_EEE_WAKEUP_TIME_1000), so the MAC cannot
> signal LPI at 2.5 Gbps: drop MAC_2500FD. Correcting the value here
[...]

This conclusion does not follow from the register layout. MAC_MCR has
no 2.5 Gbps speed setting either: FORCE_SPD is a 2-bit field with
2'b00=10M, 2'b01=100M, 2'b10=1000M and 2'b11 reserved, and SPD_STATUS
in the MAC status register knows the same three speeds (MT7988A
register manual, GMAC chapter, MAC_Px_MCR/MAC_Px_SR). This is why
mtk_gdm_mac_link_up() programs MAC_MCR_SPEED_1000 for SPEED_2500:
2500Base-X on this hardware is 1000Base-X run at 2.5 times the clock,
the MAC operates in its 1000M mode and does not know the difference.
By the same "no bit, hence no support" logic the MAC could not do
2.5 Gbps at all.

FORCE_EEE1G is therefore the bit which would govern LPI on a
2500Base-X link, and whether that works in practice is simply
untested. That was also the assumption in the original submission:
v2 of the EEE patch, before the conversion to phylink managed EEE,
had

		case SPEED_2500:
		case SPEED_1000:
			mcr |= MAC_MCR_EEE1G;

so MAC_2500FD in lpi_capabilities was not an accident [1].

The AN8855 comparison in patch 1/2 points the same way: its PMCR has
a 3-bit FORCE_SPEED field with a discrete 2500 encoding next to
AN8855_PMCR_FORCE_EEE2P5G, while mt753x folds SPEED_2500 (and even
SPEED_10000) onto PMCR_FORCE_SPEED_1000. AN8855 grew per-speed EEE
bits together with per-speed speed encodings; their absence on MT7531
follows from the absent speed encodings and tells us nothing about
LPI in the overclocked 1G mode.

There are still good reasons to leave 2.5 Gbps out for now: MediaTek's
current SDK driver only sets the EEE force bits for 100M and 1G link
speed, EEE signalling on 2500Base-X is outside 802.3, and it is not
documented whether the 1us unit of the wakeup timers still holds with
the port clock at 2.5 times the rate. So I am fine with the resulting
masks in both patches, just please reword "the MAC cannot signal LPI
at 2.5 Gbps" to say unvalidated rather than impossible, in both
commit messages, before someone quotes it as a hardware fact.

If FORCE_EEE1G does work on the overclocked link, the rate matched
EN8811H port from your cover letter would be exactly the setup to
benefit, so this seems worth an experiment at some point.

[1] https://lore.kernel.org/all/20250210125246.1950142-1-dqfext@gmail.com/

Cheers,

Daniel
