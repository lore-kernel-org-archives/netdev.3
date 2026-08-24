Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6ED17BCA;
	Mon, 24 Aug 2026 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787615774; cv=none; b=P+Tcdgevim5ITH3gFspbA3R43KUbEVM4d8kttpGd97CQnwxvzbASAsvCBBEpAOfh+U/OlidyyX4L6LoESvtU4rwRjeuui4BH4E45xPkPF53IXPbrPnJR+xbIaOScfPqEJzNnYneDXnRollImRlMiNzZLihUzrxPGWjpoBNIqDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787615774; c=relaxed/simple;
	bh=vpNWdBmWhwnoen0u7mEaI/O8fm7BxMOMGNAS8ALygPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaPmBwGvBhNl5pADqZzudQDqUPVTr8xZYKSfTklGk2A6pvpX9mfhbe66K/x2AvqGQaxENrHRKj3kw5PMX2If3N1/k/WZp791jIG39G2Ad0EioojGanBhoGyOBVEDFq1Uh8wDV1Z9TvsEoZSTBTUbpSVJU7s1vCPgTS1iEaO7JPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SBt5Ogfs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SBt5Ogfs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RLSrPO7js7yca+GtOaViRinhKEqyichU5wWuP/MLi4M=; b=SBt5OgfsREYQ8HLPaBrZeP6FPO
	+MjwyXZhWZ7QHiGyHRvwow+3Yu+R9EFwT7htZpMw7LPLwNAMUAztY5dbO/bIZchNB+gGJ/CuxLEsv
	ooRIY2zaNXbLzm7b+QqhBN1OqxhrZtsVdpl+98ZuWQ+psDij2gwl7Je/EKl5/S/rm6IY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyeW0-001JMg-Rl; Tue, 25 Aug 2026 01:55:44 +0200
Date: Tue, 25 Aug 2026 01:55:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v1 2/3] dinghai: add MSI-X interrupt pools
Message-ID: <ac2a9538-8464-461d-b320-e7f295f4b28c@lunn.ch>
References: <20260824033249934VsArgTPOU_qew94PPABbD@zte.com.cn>
 <20260824033752114y7ecQBMlUK_K6MxQNt7gu@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824033752114y7ecQBMlUK_K6MxQNt7gu@zte.com.cn>

> + * Device vectors are managed in per-purpose pools. An IRQ carries a
> + * refcount so that several event queues can share one vector; on
> + * raise, the interrupt is fanned out through an atomic notifier chain
> + * attached to the IRQ.


> +static int zxdh_irq_get_locked(struct zxdh_irq *irq)
> +{
> +	lockdep_assert_held(&irq->pool->lock);
> +	if (WARN_ON_ONCE(!irq->refcount))
> +		return 0;
> +
> +	irq->refcount++;

Why not use kref?

    Andrew
