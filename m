Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D70F3C1F;
	Fri, 27 Feb 2026 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232423; cv=none; b=dpaeaW0LPPU6l7xWKWg8ZIyWEHtNs0fPXEgD0+Prfj7X5J0ZezDnJMCKKk7gHEYluLRK1yysjqYD8m12qFMEKYkA/MlFk2J7/PevAN7tekTT8omHvr0zIkyazEotbV9O5tlmIN/jy6i1F6+Ovb7A5X2UGzrAqlg4eZTirLvkY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232423; c=relaxed/simple;
	bh=Lc++7WMZqJ2Ap4iOAoocmq8d6z5gnBrMo9EK6dOER7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dafxcW/PaIpvWkuKqxPQ1Co44iOQTwfNfCKA2qjOnmG9IWjnJijtirQvYUMi7aUu+IoHDbIitYYNw4Pnqz+r/iJWvigiE8uxBNEjA9PaqCbb4YelnyNHPEWjIMT80866KnrrVzhIvbxC+WPRZbkoG+gpznt4agrrB0Ol58tEG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M0XjuSp+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M0XjuSp+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kLjBPoX0Dn/JhPe1pmNzCrL85v0iyaJO4t7UL2w3Ilk=; b=M0XjuSp+0el3lP4q+/uCLPMi3L
	JL0FiWbWnIULOTWdT+zGerxTgCZHZwzCkRQdUG6GTHV6oUWsyEIlwxIRyDq0BjE/8MelbS6mDJVOI
	LVBCjc7oX5khdiltXN7NLhQJw4RY9IQJXPALeKAQUj1zOJxjXK2tup+bMB96ttU5j0rY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vw6be-0097uR-9f; Fri, 27 Feb 2026 23:46:46 +0100
Date: Fri, 27 Feb 2026 23:46:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
	linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 net-next 02/11] net/nebula-matrix: add our driver
 architecture
Message-ID: <b9cd1827-ba68-4e5c-ba17-773372f75407@lunn.ch>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
 <20260226073840.3222-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226073840.3222-3-illusion.wang@nebula-matrix.com>

> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + * Author:
> + */
> +
> +#include "nbl_hw_leonis.h"
> +
> +static struct nbl_hw_ops hw_ops = {
> +	if (param->caps.has_ctrl) {
> +		hw_mgt->hw_addr =
> +			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
> +				pci_resource_len(pdev, NBL_MEMORY_BAR) -
> +					NBL_RDMA_NOTIFY_OFF);

Where is the include of linux/io.h needed for this?

> +	spin_lock_init(&hw_mgt->reg_lock);

linux/spinlock.h?

> +static inline u32 rd32(u8 __iomem *addr, u64 reg)
> +{
> +	return readl(addr + (reg));
> +}

Why () around reg?

> +
> +static inline void wr32(u8 __iomem *addr, u64 reg, u32 value)
> +{
> +	writel((value), (addr + (reg)));
> +}

Why () around value? These are functions, not macros, so there cannot
be any side effects.


    Andrew

---
pw-bot: cr
