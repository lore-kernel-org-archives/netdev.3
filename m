Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA0358399;
	Fri,  3 Apr 2026 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258242; cv=none; b=aZvf8GU1fUivPsCHVOYq3RQ5EVLOLgAa2YtR7TLZSprRrDJC9AkIH24Kz/yl+et9VMOB5zo4Cy9wjRTVlZssrG63sl5n7Oh9U2LXi6LzjTr14mdPuUp44EuGJW5qdUZbCkMxKfQUNsVnBjTkeqO9vnXMdn19rNqFvrLfXzW+r00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258242; c=relaxed/simple;
	bh=6iwTWs8Jx9YXTAVlHhZFW2wfxcgLXAipLOSIQPlritE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1rz5WfUWF5FM0TovRU8Tjzmgcy/6Z1KLZuMDZ0hh0Ol8S8GF7qmf+YpXx6rqM5spywKFZfNhqvkk+T/yPzC5Se91Osy+qyGDYwl7xbqo0qGxn4xQljqOqiQnYqvU3b8fuevfccZTwGVVpZ6/a1b2k07khJkCTYw6V92lfn2G84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGLdJxAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGLdJxAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BBC4CEF7;
	Fri,  3 Apr 2026 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775258242;
	bh=6iwTWs8Jx9YXTAVlHhZFW2wfxcgLXAipLOSIQPlritE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vGLdJxAqk+YPCa76fqdB5PcTdDLyLhYU2wfsoWU0QbEalPN87poSMS7eJJVolTkMt
	 xQWYAE3/J8wefWAfEGd7/R549yltdHUI+InAxQluzGmUD1mMDP3dlw0ZmXxd0HJKUf
	 T3zzj2+RneA0mKQBxFtkh1PwpQQR3M1S/L7RCinRtlULdU+w0rmIhBvgFBCokhAr2c
	 i41+DWPiZvbBy53WYuiNczZDEWrdS+DcZos9FGV4bAVfisNxYpj7xtF8ql8QXIS/dW
	 3Rw8IfdVh78jTf8ycFlemoL3SzJxfAI0Cb3Mr11jeh3llYOgg7QUHvGDx4odbzAydD
	 xPQi1vJHqHnPQ==
Date: Fri, 3 Apr 2026 16:17:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: lan966x: fix page_pool error handling in
 lan966x_fdma_rx_alloc_page_pool()
Message-ID: <20260403161720.1102898c@kernel.org>
In-Reply-To: <20260403230714.10667-1-devnexen@gmail.com>
References: <20260403230714.10667-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Apr 2026 00:07:12 +0100 David Carlier wrote:
> page_pool_create() can return an ERR_PTR on failure. The return value
> is used unconditionally in the loop that follows, passing the error
> pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
> which dereferences it, causing a kernel oops.
> 
> Add an IS_ERR check after page_pool_create() to return early on failure.

Wow, that was fast, are you generating this patches with AI?
You've written and tested this code in 40min?

Please with at least 24h before sending v3, per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

You're missing a cover letter, if there's more than 2 patches the
series must have a cover letter.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 7b6369e43451..34bbcae2f068 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -92,6 +92,9 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
>  
>  	rx->page_pool = page_pool_create(&pp_params);
>  

no empty lines between call and its error check, fix this in all
checks you're adding

> +	if (unlikely(IS_ERR(rx->page_pool)))
> +		return PTR_ERR(rx->page_pool);
> +
>  	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
>  		struct lan966x_port *port;
>  

