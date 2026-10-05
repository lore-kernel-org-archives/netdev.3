Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011262D2394;
	Mon,  5 Oct 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219982; cv=none; b=nVZtag3kgtkGxz45fecxTf1pBaLbme46DGIhC9Q/9oOp3IEamGQEbwJE0B+cM8uQ6+08FuQ2OnkSm2k9fY3ZnvOWE8XRzYQ9mFOr8Ws4NzcF3IywTaNnB+Luch+P4zkZOZe+6ABITDzYcFyQx+6rTD1XxqTBgXYNuIFPSUZQY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219982; c=relaxed/simple;
	bh=wKPbvTUlum8b/MXva9+HkpD0cHg4n8zzHNKigK8mEkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUDL8EEPMHGquRtWOPdR5Mvc+Tqtax5VpWG6baSiD75PJ6WUtnzRApF8nNbFlVqmykoRExER9A9CvkNoWrEAFUkBGWHR+g7AL9soYfp53r6WHUinXCOWUetZiu5Ogth7/LCu2dvTZAul+vKUnYK5EB5++1yj//PVtdj14QZmHa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D/rup/hj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D/rup/hj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2S7gaNWgqQiuKDsfMDn/exk2aU/N8PLaaxbYvBU/GWw=; b=D/rup/hjHssmghRD9ZitXjCE6g
	fAxqW1TIefOg0kVqvuAawl+lfwY74K2b6fdaQJd0q+i5q9vVkOeeCm0eCjFHPVN8H2aeIaUj3X3Ju
	3IchrOBLTn2/sYcNV0hqe7SOzdkJxs+QoNtelKEH1nNU/r8fyV0FaTEvQ5krAhyGGuD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDm8k-0095dc-F3; Mon, 05 Oct 2026 19:06:14 +0200
Date: Mon, 5 Oct 2026 19:06:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: dsa: qca8k: do not clear MASTER_EN
 after a failed page select
Message-ID: <6c5a59a0-a75e-4d0b-8231-9a126ed9fa9a@lunn.ch>
References: <20261003172405.342-1-yongzhao.derek@gmail.com>
 <20261003172405.342-3-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003172405.342-3-yongzhao.derek@gmail.com>

On Sat, Oct 03, 2026 at 07:24:03PM +0200, Yongzhao Chen wrote:
> qca8k_mdio_write() and qca8k_mdio_read() take the common exit path when
> selecting the page of QCA8K_MDIO_MASTER_CTRL fails. That path clears
> MASTER_CTRL[31:16] with a raw write to phy 0x10, reg 0x1f, which only
> addresses MASTER_CTRL while page 0 is selected. After a failed page
> select that did not reach the switch, the previous page remains selected.
> The write can then clear the upper half of an unrelated register at
> page * 0x200 + 0x3c.
> 
> No MDIO master transaction has been started at that point, so there is
> nothing to clean up. Unlock and return the error directly.
> 
> qca8k_set_page() also keeps the old cached page when the page write
> fails. If the write did reach the switch, a later access to the cached
> page skips the page select and reaches the wrong register. Invalidate
> the cache on failure so that the next access selects the page again.
> 
> The Sashiko review of v1 identified the stray cleanup write. A userspace
> model of the driver's functions reproduces both problems by injecting
> page-select failures with and without a hardware page change; these cases
> pass after this change.
> 
> The cleanup write comes from commit 759bafb8a322 ("net: dsa: qca8k: add
> support for internal phy and internal mdio"), and the stale page cache
> from commit ba5707ec58cf ("net: dsa: qca8k: handle qca8k_set_page
> errors").
> 
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
