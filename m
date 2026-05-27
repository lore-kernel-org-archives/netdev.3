Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3F3E6386;
	Wed, 27 May 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883124; cv=none; b=FK756K0v5LekUR1raW0AnRaCgaAZJQB3vpA9xQSjSBW65ngRupb9HgpeJ6OfKkTllaVYbrmVuCdwitZwZDj/ob6WCIHdP0xPIkfHZaf/nKeDx+pdRth2kmhfYXqzLgaY1w8lmHFHFa0DhqDimb+mg8pNvCfo6/vxj8SLT0asJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883124; c=relaxed/simple;
	bh=9YYa628aLbjIs/EGgESPtLNxXxMcW785lrtWIPqTjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U35MjFMyzktFQ4PXNM9qYN7dxl/Wb9XjNvRoqj9qjFrJ1ItL8g0oUAM7kKpOeDJMuwge6fWe3cLaOkpF5CMM+VcrcLlG7XENf/W66owjan7nI2ZMWQdUAFvKBKtzu3paR2xU7/Ds+Tt3BnAa36+FFBrzHtVcErGGoQlQp/6RZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+Jss9j9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+Jss9j9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508DA1F000E9;
	Wed, 27 May 2026 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883122;
	bh=HrN4Efw4Y/a6bQTK/fsG1WgQ1Bf8x3DscanOsqzoDcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K+Jss9j9WpJRdqCNFMwLay4V8QoWwC+I/if9dLJI+5M1CZVFdTRlB15a0B3SWXxLx
	 tHGIyKD7ElIQlKyKa1X7nukGQeTyCKOz/c3qmVFyITQWgYmSH0BT0rLSc0JYfDhHbT
	 7FBn7JQ9rI3M7xDInUWrJ8gk7pHJyTOJdkzcx5686mQ0jlTBssekeR04ReZ0YKKiyR
	 ULE8ffQumIHvw65o3WNvBeuoHtCXK9N+yqVc6x7Uhqdx99QPyqqifrRJNZ3ZTgRuf1
	 DgWJlB6+A4oYEykF9nlLCtZcpzF/clOAmbanaHWCMSqDIxI/rZGUzU42LXzpM8xnaV
	 DLyif9JfSuI7w==
Date: Wed, 27 May 2026 12:57:55 +0100
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: liuhangbin@gmail.com, h-mittal1@ti.com, haokexin@gmail.com,
	vadim.fedorenko@linux.dev, devnexen@gmail.com,
	jacob.e.keller@intel.com, arnd@arndb.de, afd@ti.com,
	basharath@couthit.com, parvathi@couthit.com,
	vladimir.oltean@nxp.com, rogerq@kernel.org, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v6 0/2] Add Frame Preemption MAC Merge support
 for ICSSG
Message-ID: <20260527115755.GK2256768@horms.kernel.org>
References: <20260525182700.3135858-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525182700.3135858-1-m-malladi@ti.com>

On Mon, May 25, 2026 at 11:56:58PM +0530, Meghana Malladi wrote:
> This patch series adds QoS support to the ICSSG PRUETH driver.
> The first patch implements mqprio qdisc handling and TC offload hooks
> so userspace can request TC mappings and queue counts.
> 
> It also integrates a driver-side mechanism to program the firmware
> with the IET/FPE preemption mask and to kick the firmware verify state
> machine when frame preemption is enabled. The second patch adds ethtool
> perations for the MAC Merge (Frame Preemption) sublayer, exposing .get_mm,
> .set_mm and .get_mm_stats so admins can view and change MAC Merge
> parameters and retrieve preemption statistics.
> 
> v5: https://lore.kernel.org/all/20260430111723.497113-1-m-malladi@ti.com/
> 
> MD Danish Anwar (2):
>   net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
>   net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge

Hi Meghana and MD,

There is another round of AI-generated reviews for this patch-set available at
https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/

I would appreciate it if you could look over them and address any
issues that are either introduced by this patch-set, or directly
impact it.

I would not suggest expanding this patchset to address any other
pre-existing issues, but rather address them separately as appropriate.
