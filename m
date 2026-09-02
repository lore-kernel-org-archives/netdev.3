Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28CC3B42CB;
	Wed,  2 Sep 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360132; cv=none; b=ir96d8EEM/YAqVXzDWP8W1WlImLzrXao0q9/tIjrrSguJv8EPfKU0UW1cAvOoEsNiZIWtI8EEUNpu7qWO8sWvzQive0H6tFSEipvX7NLxYmD4rJCFGiDBJBY9VvDAtSlJPAzrR95tH+JxfMiJHPq1dJ7vAA8sgHl/hwTHiZJi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360132; c=relaxed/simple;
	bh=0tW6v+dws5Rma1rN+y7Wh361qovrqrHE/s6XDMtOuMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeGau2ZT4Ffeug8905YHzGKB8BdmH9PTrShYNT6Jlo6nFl3qV/gOwlnm+5xbcsKnonGsAwhBHvON+FKD/s8yg1OXudtqGqjjEql7yjaE1SEWk3h0xlSXTUAvZVYsXXicuPqctncBqk4B8lSxOPo0ce6RUNRdaz2tIKYcxYpMbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HdpFrX0/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HdpFrX0/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L1zsNlaXnwlKjAjDCHeh23GgQRdsehxwNNIFDmUiATE=; b=HdpFrX0/MCfayMGrAJO8ANFv00
	ZVmGsP8yv346XltZeZDIkbjXyxWS5fCdw59G5lc1cPi55Hopx+ulLgyY3mDIuAYkkiTOWAnrSxiNZ
	PpmJE/Z3WOK+vraF1whK1QsGTHfD6m8RtSRqqGWjw+5QZU2aSDGxo7W2XkwgqEWpVBeU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1mA5-002XFS-Mo; Wed, 02 Sep 2026 16:42:01 +0200
Date: Wed, 2 Sep 2026 16:42:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v9 6/7] r8169: add ltr support for RTL8117 series
Message-ID: <1ef37ebb-3f8b-4c8a-8abd-e7c9cb7092c8@lunn.ch>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
 <20260831053745.1197-7-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831053745.1197-7-javen_xu@realsil.com.cn>

On Mon, Aug 31, 2026 at 01:37:44PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds ltr support for RTL8117 series, enables RTL8117 series
> enter l1.2 state. This makes sense for the system to enter c10 state.
> 
> This patch drops the COMBO_LTR_EXTEND_EN write for VER_52. This is
> intentional, as this bit is not required for RTL8116af.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
