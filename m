Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B461420490;
	Fri,  4 Sep 2026 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558853; cv=none; b=ucHbvEwLiTcC23LjjuZDiUZf8BYj+iryXeA/uh5+uiyRF7A5XCl+7Atl8R9m8c1VhGdTRCgcW2FukvjH9O9TsKnGcIuzsurDbMR21uKpQwI/QKQmHzw361XOwzoBq1rWioRyydjDROns5dGtzXsURy0EypZ/IUcHfpl6jXI2f68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558853; c=relaxed/simple;
	bh=rdl1w6KnQ3zWNEFtA9I/sG3vqG666nShicAXatlafgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pm/KKxxN5eT6ht/K+98khpIYh2sCg/x9RiirH2XBDBE6yTPzSfuj0Lx2YCsox5afqK3YCjZj6BhaTvKO44iTR/mNJ+AhZA9GGuPPRMYtSx3ixjoJ4Wv3Q8bIWz4gtGv1hXoalbj17EMRSwQJZQYxbtcCl1PlQUlsQ3dbgt5umYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ7ycxtr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ7ycxtr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6C41F00A3D;
	Fri,  4 Sep 2026 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558851;
	bh=XCeNYHWq9Iq7nfe0geCoSMUdz6QXeYSe8PW1enyixEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oZ7ycxtr7TnBcDCHDPB591V9koZPvDVmXEyeNiCUMhsrNQprZrg9mqFwo+kapsMio
	 UE4M+IFmxGF2WJQIQIphSEo+jXY6YjQIH0CzYx0e931bdIc6vQpg5A/EfvzJ6LdTfG
	 j5NLwHIrIYN2hVkpOFOLm4ioHnaWjp5CxViWY4Mbre4t3KM8H9MXqgdya0k7PzqY7K
	 j8HMHJV3M4o6PmWJcSQ/Sm/ib1MG+kXT91utggGQbKRUBhNad5qdpAgzfdmtuLnGKO
	 HoPzlaUn+WzHbd3OO6+j1rQRLA2kU+T+wMhMaUTQfi971+n94tdcOvVjqRrL0lyAuh
	 GDNss00m8XU+A==
Date: Fri, 4 Sep 2026 14:54:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, u.kleine-koenig@baylibre.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v10 1/5] net: rnpgbe: Add interrupt handling
Message-ID: <20260904145410.67b6877f@kernel.org>
In-Reply-To: <F44E6669E6C9E7C4+20260831073608.401988-2-dong100@mucse.com>
References: <20260831073608.401988-1-dong100@mucse.com>
	<F44E6669E6C9E7C4+20260831073608.401988-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 15:36:04 +0800 Dong Yibo wrote:
> +/**
> + * rnpgbe_int_single - MSI-X single-vector/MSI interrupt handler
> + * @irq: interrupt number
> + * @data: private data
> + *
> + * Return: IRQ_HANDLED
> + **/
> +static irqreturn_t rnpgbe_int_single(int irq, void *data)
> +{
> +	struct mucse *mucse = (struct mucse *)data;
> +	struct mucse_q_vector *q_vector;
> +
> +	queue_work(system_percpu_wq, &mucse->mbx_work);
> +
> +	if (test_bit(__MUCSE_DOWN, &mucse->state))
> +		return IRQ_HANDLED;
> +
> +	q_vector = mucse->q_vector[0];
> +	rnpgbe_irq_disable_queues(q_vector);
> +	napi_schedule_irqoff(&q_vector->napi);
> +
> +	return IRQ_HANDLED;
> +}

It's not reasonable to have a single IRQ handle datapath and also
unconditionally queue a mbox work item. Just require at least 2 IRQs.
