Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D73624A5;
	Tue, 13 Oct 2026 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858695; cv=none; b=FxLuOHqwReidnYM6FdatrPKCbvhiQMpG3KGRrNtnQLz7/8vaAlGUmFXUfjaaTLzjm5v4+Aa3fmKWNehxhT1XF9dFAbnROOp8ZyAazjXpgS/qUcs8ubDZDgR35XDHJLtP+tBxLIufLOB1qRBgN1/zEsBVUo2eB/EmqkkDnKrBq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858695; c=relaxed/simple;
	bh=23RGPm43f4gLAQvpa5SiAH1VyN91mvXyyIqYeaD/w1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf/a2qUTJNBiA5u1XffxaUp9iNM/Ija0nwPmOEexAZ0mr/MVMkaAAfMQoRHsxSBYM5+2mtfRbS6k/kIatRCAnr0B3rg8RK0dVd+OtRI2+99qvwpaQiJzs+y8E1z3ql4zsSP3BKtmgn0tit9Z1D892FLaI29p9xfe2uFjbIJa/5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G51M1wIk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G51M1wIk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qphfJge9dYTT962tiIuQwN2ngh+Z2doyHeHHUhOH7C0=; b=G51M1wIknZNZJ0R4E8B+kpx5xm
	n5wqvdF4F9cfE8n38p4rgRSHdk/Iv1BFkrSDr7JrEjTdkXMNo1s5lLjHTi7iIXr5rAM3qTXQGnL0p
	vh3c223kKIAC29cvAdDtmtpdNAyrKCcBu13EhOOMS+FilYRlrJ1zCRGIbiF4gOO0L5FQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGSIX-00ARDo-8U; Tue, 13 Oct 2026 04:31:25 +0200
Date: Tue, 13 Oct 2026 04:31:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 2/4] net: phy: put the driver module the
 attach took
Message-ID: <afceacff-23bb-4cc1-a579-d53c82ebf155@lunn.ch>
References: <20261009180551.1234107-1-f@lex.la>
 <20261009180551.1234107-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009180551.1234107-3-f@lex.la>

On Fri, Oct 09, 2026 at 09:05:48PM +0300, Aleksei Sviridkin wrote:
> phy_attach_direct() pins the PHY driver module through d->driver, and
> phy_detach() releases it by reading d->driver again. Unbinding the PHY
> driver while the PHY is attached clears that pointer, so a detach that
> runs while the driver is still unbound skips the put and the module can
> no longer be unloaded; if a different driver binds in between, the put
> lands on a module that was never pinned. The NULL test added by
> commit c2b727df7caa ("net: phy: Avoid NPD upon phy_detach() when driver
> is unbound") avoids the oops but skips the put.
> 
> Found by reading phy_detach() while chasing a PHY driver unbind race on
> a Keenetic KN-1012 (MT7981, air_en8811h built as a module). The leak
> itself was not observed there: unbinding air_en8811h under the attached
> lan4 DSA port and then unbinding the switch faults earlier on that
> board, in phy_free_interrupt() or under phy_stop(), before
> phy_detach() gets to the put.
> 
> Remember which module was pinned and release that one.
> 
> Fixes: cafe8df8b9bc ("net: phy: Fix lack of reference count on PHY driver")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> Changes in v5:
> - The driver module is read once, so the module pinned and the module
>   recorded cannot differ.
> - Rebased on net-next: the failed generic bind unwind keeps the
>   interrupt restore it got there.

Same here, and i guess the other patches.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

---
pw-bot: cr
