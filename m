Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCB3321B1;
	Tue,  3 Mar 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545453; cv=none; b=OqiBFqTba8Yh26bh4k5l3LZLcJ3Qx+VfuBMjg0HEyLpF5luqMAtsa+j/6N9VZSm+IzhHKq6yopFOkHqIH9fNVtKmnOr+0tBZeixV2kQ5Ji4NKjlvqel7nCtJbVNWrCgcH8fuhbZ4dvvTCS93FtvfVhIgci25XK6+oaBA7gSK7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545453; c=relaxed/simple;
	bh=qEXhrQjxImQ+8/E6jZ8Yk9Ac05jcBIefPZUM61lrVOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYRef/FMRCLpFtARVXC2Jy6cgTU6LqtR61MGnqx8ljU6/6fwZxJLkVLQ0HNNbbvU0o9ufl/nKRxDqtuPFFFjuqsyZBHiFJQPlqflcpmG2IKIO05hvB6bghc3cpAe3unF0oAUDYGdgAVdiKfrYvolkqlbw/a3/Ihz/Lu9ycGuMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KCJgU33g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KCJgU33g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k7jDEeOlzOKiXO77tDNga/PJhfBu6MRmu9mtzITyrOA=; b=KCJgU33gikf3MMp+qIip/hmCVJ
	oGtEHt7Q0av1/3W6+ER+XtNi1MAAaOELRH3tofN2dQldTNh5k8qCFJe8aq3lAPyKSL+NGb+2AihOT
	p/p+UJ4lMST/66OkVHRfabO3tniB0O2RWs/vTsbMBCTgJx5EF+ITQ+8OpR8L757+x3aI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxQ2U-009rVA-B9; Tue, 03 Mar 2026 14:43:54 +0100
Date: Tue, 3 Mar 2026 14:43:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mxl862xx: rename MDIO op arguments
Message-ID: <4478e547-1222-4624-a350-6ec966444e4c@lunn.ch>
References: <e1f4cb3bcffc7df9af0f2c9b673b14c7e1201c9a.1772507674.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f4cb3bcffc7df9af0f2c9b673b14c7e1201c9a.1772507674.git.daniel@makrotopia.org>

On Tue, Mar 03, 2026 at 03:17:43AM +0000, Daniel Golle wrote:
> The use of the 'port' argument name for functions implementing the MDIO
> bus operations is misleading as the port address isn't equal to the
> PHY address.
> 
> Rename the MDIO operation argument name to match the prototypes of
> mdiobus_write, mdiobus_read, mdiobus_c45_read and mdiobus_c45_write.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
