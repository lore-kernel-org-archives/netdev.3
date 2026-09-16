Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E7937CD45;
	Wed, 16 Sep 2026 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561926; cv=none; b=JJv2N2Ue9B2TKXRiKkEHNi64o7UY+SDNImrvXmy8iZxeinNgiiYQvwzPK6aqMgPLT67sqhhTk56L/p2RlCJ9Y3fiYbrSCF5Np3HhY8R8+0LZLAD3WLJu2E+VsATueL9nY6OWl4OFmzlSEoMr+E1zT+KQBXRD3hX7owtpP28EbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561926; c=relaxed/simple;
	bh=RPmepblZczLjX0S4EBvmpXRr67SoIo8Dqa1memrMJoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puy0ytmib2vJhEsWhnHfY+fr2ZMjMXiKzpvUXZG5ccb0pybDtF5R1bBoKUychDSSTprsJLlmYZUHi/5no5ihtlhJFy6SV+JCroQ3+hqfJTL2sPVN2yOoD25lMtHk6FPHm01h8z7T404v8qwkey4g8FsJCWsfgmDBXgKMQhB4TXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OP1Zk/PK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OP1Zk/PK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3ETOGWLXEl5n031wWB8dOyh+Ih3Xqi4iPjmdQ0MzwXU=; b=OP1Zk/PKIDGg2lj4CMEvpBRLiY
	1DXu2Fum7V98vSaF6H6S8sJJR4V9D5RxjjqvNqRnF8G4ALiBcdgnzM0aH1xRq27gtbWklmiULy1ON
	YqVW0C8UQnhow09+WGICvsSfYK5mWphW0OEk6oRpL/KNJxZhAq8Jx/SqMNUGXi0hFazk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6onp-005TZb-AG; Wed, 16 Sep 2026 14:31:53 +0200
Date: Wed, 16 Sep 2026 14:31:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/3] net: phy: realtek: add support for
 RTL8261CE_CG
Message-ID: <9b740e29-6bfc-4415-aa4c-a68be9a25723@lunn.ch>
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
 <20260916081444.497-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916081444.497-2-javen_xu@realsil.com.cn>

On Wed, Sep 16, 2026 at 04:14:42PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add support for RTL8261CE_CG, its phy id is 0x001cc899. RTL8261CE_CG
> share the same sub_phy_id and firmware with RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
