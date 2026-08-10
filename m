Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F2D42AF9F;
	Mon, 10 Aug 2026 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380341; cv=none; b=JohgbOq0CjySTSCK63FZ4D5e2APg844fLlvFcqOlIpxi2DpL32yT5gqmljHugYUE/XjO+R4xFVX/X1Ef7f0gyVnzOeyOlDd3qtEO16iAJSHTls9iIWo+b1rHxbzj3g+gFXQhM0zLCD9neok8AeCoVUYcI9YCen+YfTbanlhpjDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380341; c=relaxed/simple;
	bh=Ked08SEd5HCF8pHaMMb7nArbgDQEUQ5QnXuHQCIZSrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkA/BGV+z3OZLl/aQeET0bHFmKHzpRJuQmtpX7G6w8qQZd3vdABZJsImKQB6wE8qStu18vEYb5PbmD414btiw/GefW/KACzxUwQgsKogee03+pd467c35V6pY7ksXalqrym2ZzZ2crwjcbKpjs38QvJEZOoHjwV0uSp4ZaRBo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbahQ26Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbahQ26Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C01F000E9;
	Mon, 10 Aug 2026 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786380340;
	bh=z4/4l486FyWKaQhcDEH7vHkDkGy0D8VOiDgcLV6FgDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DbahQ26Zrgpj0MKciyWndDnjwNseKWphjBQTiRlt1UVJPpjistH4k3oFlVBBUpjKB
	 i75ZAIsUE+20gkLwJEKxunaUubNEQVXMvVjqSSGLZNc/cESaQFvqdt0U3srImw0rOM
	 2SsMh2Co32Esxtdbb4ZkVY2Tv7KPwjyHQW4DhM+yQoxpe3FU9GV5m3PzZLv+k79uEX
	 Bavwvjx0Q5995ia1EMHpRCSdfnr9oCArHWhwUMjDnBsDTja/Sxrk2iyaox2+FWL08q
	 DJTFJzkVuz4br+UYotmak4djvfgW2FVywWn4ugBH/95YEfuFmDE5npTsetOIakiVGb
	 DEGHdbRssh3eA==
Date: Mon, 10 Aug 2026 17:45:36 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	yangshuaisong@h-partners.com, ningwei15@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/3] net: hns3: use txqueue parameter
 directly in ndo_tx_timeout
Message-ID: <20260810164536.GU51943@horms.kernel.org>
References: <20260807095435.2959246-1-shaojijie@huawei.com>
 <20260807095435.2959246-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807095435.2959246-4-shaojijie@huawei.com>

On Fri, Aug 07, 2026 at 05:54:35PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> The ndo_tx_timeout callback already provides the timed out txqueue
> index. Use it directly instead of iterating all tx queues to find
> the timed out one.
> 
> Use h->kinfo.num_tqps for the bounds check instead of
> ndev->num_tx_queues, as the ring array is allocated with num_tqps
> entries and num_tx_queues may be larger.  This issue has not been
> encountered in practice, so it is folded into this cleanup rather
> than tracked as a separate bugfix.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> Changes in v2:
> - Use h->kinfo.num_tqps for bounds check instead of
>   ndev->num_tx_queues
> - Restore the netif_xmit_timeout_ms() check by making
>   hns3_dump_timeout_queue() return bool and gating on
>   its return value, so a cleared stall does not trigger
>   a reset
> - Fold the bounds fix into this patch rather than tracking
>   it as a separate bugfix, as the OOB has not been
>   encountered in practice
> 
> v1: https://lore.kernel.org/all/20260804130933.880552-1-shaojijie@huawei.com/

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

