Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150372EEE6E;
	Mon, 10 Aug 2026 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398063; cv=none; b=HWjjP9g8oj+a34WLAFUuJQeg7FC0FLFWF0O27rJCXLI3dOnKcdYDYWc3H0ng7gYPq78b+RrOy+VYBqESX/MNZ5XWKXNjGppRUvwgj9rgj7n7PgEalEQyIEMf5IquTrm2iE8haw+9Xxb0p+L+NIhwZf6uEcU06xkZTQMzpaOAhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398063; c=relaxed/simple;
	bh=xDbUs5tGUnEuNXHOFOsC9pGzFMG4rI7nadtaX7YQYig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHuU0ubAmVuLNyymZVwYfylE8k5btjBbQEjZK6XT90rfgsFw3v1qpp4U21FZAEE7E5op+H6y84JpAP+3iOm+P09V0A2w2jT7GJ72szmO0FdjOiq/KwdRY+ji2aSULpoOoXlPklDimW7azpkX+PeedORtBc5/F4s7t1mF30fSRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiSOHH6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiSOHH6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531AF1F000E9;
	Mon, 10 Aug 2026 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786398061;
	bh=+9fEpMCeYAfzYqG4RGed6mv+st63V41ddohElsyF+VM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DiSOHH6dVEGoSMz05RZrzPzU7c8DbYdEcFINowhgU9aQaWirgVlQYvzgb7zWmrGdN
	 Y6WaFPbeluB6cSDxPXavGv6VuVN8UpYlPAWf4V3v0mq5I3m6Rb6TbXMwMe5423SAb1
	 50ArBynAullSWqzNyVKdj+Pcf67WDv6QTDDx2ERzOOWfqLtNUxDgsbCunPaoXfzdKk
	 dsfVckaJ6TXsehBK3Ji8N4jqAy1CFns19NRXSpBboL2+H8j/GDouqMg/z1u32lf392
	 SylELo6dIAPYObHnt4J61wozj/nUsHfiNZg3R9T4jZ0F74ZeiWRhZMqwHhhOOeErjQ
	 sCeJS+2Dkk/eQ==
Date: Mon, 10 Aug 2026 14:41:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v10 7/7] r8169: support setting rx queue
 numbers via ethtool
Message-ID: <20260810144100.58303437@kernel.org>
In-Reply-To: <20260803021305.488-8-javen_xu@realsil.com.cn>
References: <20260803021305.488-1-javen_xu@realsil.com.cn>
	<20260803021305.488-8-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 10:13:05 +0800 javen wrote:
> +static int rtl8169_set_channels(struct net_device *dev,
> +				struct ethtool_channels *ch)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +	bool if_running = netif_running(dev);
> +	enum rx_desc_type old_rx_desc_type;
> +	enum rx_desc_type new_desc_type;
> +	struct rtl8169_rx_ring *new_rx;
> +	int i, ret;

This patch is missing a lot of safeties, AFAICT.
We require that the driver is resilient to memory allocation failures -
if the memory allocations for new rings fails you should restore old
rings. Calling rtl8169_up(tp) and hoping for the best is not going to
fly.

Let's leave the live reconfig to a separate series, in the interest
of making progress. Please return EBUSY if the netif_running() and
you can tackle live reconfig separately?
