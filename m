Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C438B131;
	Tue,  4 Aug 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865541; cv=none; b=n+38Q6kLk1R374BzcuLDeo6oArI6zpClu3ZPhlZOXEcqwhepQ4LAeD2WgUUtz8WyCu5+6qF0RTaUtzAJCyJ2p+wKourbODnmZ/oJcvEKMCiSiJ/X5/noE6D1CtxOBC/AO98cTvFdkSGZTgeWrXLqaICNzibGaimUGbuz+oFY7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865541; c=relaxed/simple;
	bh=t9Ohl5wJ4MnaO4pCN5wLzn7TllSLUtilSZFUKygQRc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq7G/hGl2IjC1E166EM3Ck/QgFbFuZBkfNnJHeqO7++x5dzsTdf13eUdotZlPEj+PHrUy1pKyanJLZnmhKxQ/k9NFq2V0DzTKPFH8r162Bdq9KSaMfpCLcUAL75t44ZQCVIf0nIM2xPC5CbaftwQNSGNieaMxhGFPLZZKCJr+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3rEpGIP7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3rEpGIP7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=osSW8pITCgD4+RMq14591sZtxfXFxKGPBcEYIBgm7KU=; b=3rEpGIP7KPlH1lZ2dfkUwxFsOG
	VmZgwrCcL/YdqjSaHuXaaNBxVRshb8IFJj0gl/tAAI2uxC7ag3aPuDM9kx9fkA98C0iDj1mKAImy5
	m6AnEoBck3zT8OXdH1ALrtc2QQkODAwKbGVNxmrFJ2MmLykdPLjy73xl162SJSxioyj0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrJCe-00G1q5-T6; Tue, 04 Aug 2026 19:45:24 +0200
Date: Tue, 4 Aug 2026 19:45:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, linusw@kernel.org,
	antonio.borneo@foss.st.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] net: stmmac: manage error case during
 stmmac_dvr_probe
Message-ID: <17bdf6d8-a31d-4601-bbc9-4d7b78897272@lunn.ch>
References: <20260804132052.205273-1-christophe.roullier@foss.st.com>
 <20260804132052.205273-5-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804132052.205273-5-christophe.roullier@foss.st.com>

On Tue, Aug 04, 2026 at 03:20:52PM +0200, Christophe Roullier wrote:
> In case of error during stmmac_mdio_register, pm_runtime is not
> cleaning before exit probe.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I don't want to accuse you of anything, but Russell has not been
active for a while, this is v1 of a patchset, so seeing a Reviewed-by:
by Russell jumped out at me. Can you point me at the archived email
from Russell. Just doing my due diligence, trust but verify etc.

     Andrew
