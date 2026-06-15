Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7593C98BF
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512377; cv=none; b=pR6KL4UlCFnYhE/dyB1BmoWI7jsQqT9LnbCbMVDdpf48Mp4nnSv55d71e6j7CM/YKo/Wq6+DWeSzLxfDAltHD93ORGZ0WUrV8MFLxgyPuNuHaXmmSM8wsSlxBjiH5fwKJf4/eWD8MrQxMbVEqT4upXmB0EF5sUoEpeliPAm7yNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512377; c=relaxed/simple;
	bh=l8kZOmjRF3nm/M3yU+1H+7o0l++3zGQDbGNNK8pg1Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfGyp1E1GUCIWxxgXpBpNqjcLqwta//7pSz+kp4eFsfn6kbaqHQnweR+WdIDrkW2ifxLp06yTECSH+HFcm1Ytr/Sq54xfUAqRTCKx8gJEu8R9nKxJJalqo0HUH/+auRGhg3sLoup+JyoH9Qc4nZpLWHtA+CfKobglLrISW047Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPpIFACX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPpIFACX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F4E1F000E9;
	Mon, 15 Jun 2026 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512369;
	bh=l8kZOmjRF3nm/M3yU+1H+7o0l++3zGQDbGNNK8pg1Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPpIFACXQZ95iX1KnmBpaNLqT5r/cZJk6jgXTOvwNIMIeDlzLyD98yeR966OLWcYZ
	 j/O+mhnP9AtkvHFfq3ZaQzdwjDn/aNMCxdtUsrfZJztDJuO/FgZsdLqx5pMKAUDg+c
	 Px/w3SqoUlmUX0VppMm2U5xAfWZ1uchnqZaCQsRuqRhaWAYJlyLFsbJdVcSVUHXNRv
	 1wGjHabsRhJ/ztgedUGARlNZoIYsXIAFQ8hHGrOcb1fJqK2LNl8VNlb7G/LqZwEI4C
	 j2M8ZlzR2jZxK6oZjNWvLjB4YUgvHZ3Qihje/QEy0vJCDSVkGr2PdG7UZx603nmcZ+
	 XWJygWyNHgPXw==
Date: Mon, 15 Jun 2026 09:32:45 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v5 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Message-ID: <20260615083245.GD712698@horms.kernel.org>
References: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org>

On Thu, Jun 11, 2026 at 11:55:50PM +0200, Lorenzo Bianconi wrote:
> Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
> offload is created or destroyed.
> Make dev->qdma an RCU pointer so the TX path can safely dereference it
> without holding RTNL.
> Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

