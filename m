Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E4283FC9
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925287; cv=none; b=owyFabYyBV0XqhxROG4oDN+nwIsEm0bP+Ofl9PVh4/0EtId0sFQRRL7us539IKMAITH2dsTjKQfjxmMXLrqQ3LvET41VE9BnThvcYM1kZT/MR+N9GDxltStBfSYktiBbVXyVsJr+KcaipEJ9oFoV9gi6tZcGAYq0H5vjlsCGCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925287; c=relaxed/simple;
	bh=UjV+lVT62XoKCNm3uXANF9IwXBOBlVqxQ2pDtUbIBXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Z5Y7FzKY0t5ExqmEhe1o0IMbhHME7q+9lewz3H4gw8a8rN68epyuVzakespB/zFxDxFeummYpcWpIumF9DrzXI7iHophfr6Kc3nXw0LtwLUDzapqqW8DVMWS4jCgys7mjP67o93iVrDDUQTuN1cdkhruSgM3G3TXqMmX8lX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUZpqHl9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUZpqHl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDE2C116D0;
	Tue, 24 Feb 2026 09:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771925287;
	bh=UjV+lVT62XoKCNm3uXANF9IwXBOBlVqxQ2pDtUbIBXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUZpqHl9KOq3NztIgVFQnBX5c8PRe87hioP2HSuqHpab1UHLsBZ1svI4vteAQLBs7
	 OLLP0B1MFP/TXSaItgMk2liCMMbrwVVrCe+rnHoxFAEUmwjVdmFQDavW+rwWOqJ6wT
	 7pDiHJ5lAQmlfqabozb2hCqOok6MNK0d4i2zEO/Bu11+ZHQITQfh5m1iXI/D5QprT8
	 /NIQxW8w1xhBkngwn/+JQoxH43uRqFerkMTn1IqsD6LCH32ro2/JEbLk2R+8O+K3Lw
	 ENg9Hux853QsTM7B6D/Kuz1Ct7LNCm+u4eznPQk+7+1lWUHYhmYn8qwwgBlHh3MKGp
	 NbzsPIp6HJN3Q==
Date: Tue, 24 Feb 2026 09:28:02 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: fix timestamping configuration
 after suspend/resume
Message-ID: <aZ1vImgrq1yxBIyy@horms.kernel.org>
References: <E1vuUu4-0000000Afea-0j9B@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vuUu4-0000000Afea-0j9B@rmk-PC.armlinux.org.uk>

On Mon, Feb 23, 2026 at 12:19:08PM +0000, Russell King (Oracle) wrote:
> When stmmac_init_timestamping() is called, it clears the receive and
> transmit path booleans that allow timestamps to be read. These are
> never re-initialised until after userspace requests timestamping
> features to be enabled.
> 
> However, our copy of the timestamp configuration is not cleared, which
> means we return the old configuration to userspace when requested.
> This is inconsistent. Fix this by clearing the timestamp configuration.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> I'm in two minds whether this should go via net or net-next - no one
> has noticed that getting the timestamp configuration after resume
> doesn't reflect the hardware state. Here's the commit that introduced
> the problem:
> 
> Fixes: d6228b7cdd6e ("net: stmmac: implement the SIOCGHWTSTAMP ioctl")

My feeling is that the bar is not if someone noticed or not.
So I would lean towards a fix for net in this case.

Regardless, feel free to include:

Reviewed-by: Simon Horman <horms@kernel.org>
