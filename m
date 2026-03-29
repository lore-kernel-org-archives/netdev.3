Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E72274B2B
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774792996; cv=none; b=eHEJ6VpGX4yJVaSqhU1Te08urOq16/zk2HpB1VdIsaIvsQURR2KRyG2EupKkh1FEz05luW+suxCLe9hQVkBxfjUr8jMDFDUOUDM+Du2tAvR/LnbhoyhNs74AzB1/QwqcFrEjh7/ac5ZQDEk9UYgNA4xP55aVANUBIljSLqlRQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774792996; c=relaxed/simple;
	bh=TRydJL98KLqGdZpbRlZtjFCWOpXXuWxDLxDgxPY0anU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+T6vCcNtCjS65Ws/7EI2tXycMYlwEXjC+YgjqVywi2CzOqT7JyA3HbZJxAkeWei+BdnsjvoaUxwaOystu2d8aOugVfSCRE9Yi7U/J8SvBk1iC2q2f5Yc7zlbjDOII8eYqYfj2FyJ6Krivh1zkWgWq2GZj38t/4mzQ7HiAk1MRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Us/+mpYg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Us/+mpYg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bRgCbss9okgtwE/2HXiSyI8ABM3ZDM2tNsJxq7osZa8=; b=Us/+mpYgv6eUGjYc1vS/hNrfmz
	kPeWCFn3DBHz25QHgHPOpiPcNxOvOp0Pmy1T4K+cR8VSpkEiUW5qH1tuyLtO9Lrz8/Z8uXAgdBhEr
	UrYZWz52uqkDWibfDwXrXTlHZgUa7+7xojnCWT8fl6VSz/QWXF0yvMcqWEssWi7ipZuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w6qjI-00Dtwh-8A; Sun, 29 Mar 2026 16:03:04 +0200
Date: Sun, 29 Mar 2026 16:03:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/10] net: stmmac: fix TSO support when some
 channels have TBS available
Message-ID: <33c656fa-9286-48ef-83de-287b88f88bc7@lunn.ch>
References: <achJ1dfeT6Q8rBuX@shell.armlinux.org.uk>
 <E1w6bKj-0000000ELtf-3md9@rmk-PC.armlinux.org.uk>
 <acjzmxY9xmBInSwm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acjzmxY9xmBInSwm@shell.armlinux.org.uk>

>          * Packets that won't trigger the COE e.g. most DSA-tagged packets will
>          * also have to be checksummed in software.
>          */

I doubt DSA will work with TSO, it would have to include the DSA
header into the replicated header when doing segmentation.

I thought we had some code in DSA to turn off features which are
likely to cause issues. But i don't see it.

Hardware checksumming has been an issue in the past with DSA. Some MAC
hardware from switch vendors, Marvell, Broadcom etc, understand the
DSA header and so can do the checksum correctly when the DSA tag is
present. MAC hardware from other vendors often get confused so
software checksumming is needed.

	 Andrew
