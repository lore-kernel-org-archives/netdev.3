Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2493939C1;
	Wed, 23 Sep 2026 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179376; cv=none; b=PlcJmIBJ66dQs0uXiwH7lqKmvlXw5EMilh2A7U6EuhWXbTD190UYucUz2/OnCJaCUKlAYPS+HyrdNjwYZY5bKY0z2e4tknvJRAC1I+BxdH6Hg4dDNvB0Vk5EnlzKuW1rwpYDZgqaAfh3L92ktMJ5MQLiEwHvJqdPCUq8dyM0oVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179376; c=relaxed/simple;
	bh=62HnkN5UiJ3B8KDTcennJd7n6dqSKdXY+zTsx/I8L7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afSMzjk8Q+eR61IK5xdTNNgDI8lXoeZIDju+7ZHNqp3k+JZJ5F4zfYNX2/Y46jv+uzkyF/OSvQcrIVqW+UApcSeqPGVt3EDNU5BiSBDy67q19AN9hoUSdXgcSDS1fUEwfjb5SQ6AwCW+KyJt77t+dTro+CnUtBEFmjhGgJLVKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h+0x4ElJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h+0x4ElJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PF4cj7VAKZk/IPNi6HoLX9VLHU/vKl9EJ736CrozhOw=; b=h+0x4ElJiVsfd/3G/omMdELnoN
	YMKlIDmKb9kwrBMTq8gMrLCQdFvgYn1CuKnjSG6kOFx0+TVOF3s7k9iQsU0CA1vSN4Z37NGcez7++
	ph6HzBYF75VoCvq9nrKK26MlHMPhdHNu9b7vv4Z2RytAX/rufSN28ojMYHtlDvI7rAyU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9PQi-006q0e-AL; Wed, 23 Sep 2026 18:02:44 +0200
Date: Wed, 23 Sep 2026 18:02:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: aquantia: Add support for 5GbaseR
Message-ID: <9a79f51e-50ec-4df2-b908-71573c81b69e@lunn.ch>
References: <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-aquantia-support-5gbaser-v2-1-4d789dc21418@oss.qualcomm.com>

On Wed, Sep 23, 2026 at 04:24:24PM +0800, Hongmei Xu wrote:
> Add support for 5GbaseR within Aquantia phy driver.
> 
> Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

Did you even read your own patch?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please try to setup an internal review process, get other Qualcomm
developers to point out all the problems with your patches before
posting them for the world to see. Silly errors like this are not good
for Qualcomm's reputation. Not that it is very good anyway within
Mainline networking.

    Andrew
---
pw-bot: cr
