Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317A2BE03C;
	Sat, 11 Jul 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788464; cv=none; b=a1ATc2BJ4dqoF05ENkLljzs1lth10n3UeQlWrH43NrLTA/+sOw/SWgvH/vnZcAkE0g2SQj7Q3OYjApp/WM4Zgv6FdTCxMGBWsBfoVYmshcOuwYsZfMAmAkvJscdAlw3ADMW52VkuIvRHWhfasCSsQe/LXpIILSLjf0uNwfJSGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788464; c=relaxed/simple;
	bh=Jl/y8K1+Mt4m4VJQkO9CGmL6sz8PFaHr3Rg5wGBRGA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdwqsWet+QjpQ7jAnpT60jM1sblUo2vPpEdhF+I5dFb5WelCgS4OacA544pZcH/aC9iRImSknLizFcg/fICB3bC4B5Zpn5FdfPYlCbcXFWypOrPFoohkRzCBQnrMZX5v1MmWAgR1mfJYDc/edGyLY6jbnxCpqigVYIH9EINgwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQJy1oSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQJy1oSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F261F000E9;
	Sat, 11 Jul 2026 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783788463;
	bh=fT/3EzXb5qelJfHBExhNcIKM7khT9jc2uM/1+HwY06I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BQJy1oSNlAQE85Vdq1JZZd4VhbrrShW0YCXZdn4YBtD47E7sNcneDxe1hi5MOOSWx
	 MzO1L65kcFsV41yUDvktPQI+RR/m2rcKp06PIrQXRwbgKJ3vLz9f2ISzbvJwDTKDXY
	 y77w7VKyfD5AEw/S/Y1J5OFVRh15n42vf8C58SM3UmFDOqG7gZ4FrxTD68lUsNilc0
	 6vJsVf5JLheYooKE1V8XIXLAaPy+DHhsp77rYNM3uJSM7nNAp0ja8TxsPYpVu7X/uL
	 WSN6vCIKlCoE5QFRGRzorOQw//L5r2aAjqLqNhq378L+N/kyeGCAWUpD/knTEJ0wwA
	 uZaYxG0xQ3JrQ==
From: Simon Horman <horms@kernel.org>
To: marco.crivellari@suse.com
Cc: Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tj@kernel.org,
	jiangshanlai@gmail.com,
	frederic@kernel.org,
	bigeasy@linutronix.de,
	mhocko@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	enelsonmoore@gmail.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq
Date: Sat, 11 Jul 2026 17:46:47 +0100
Message-ID: <20260711164646.1693826-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706134033.244295-3-marco.crivellari@suse.com>
References: <20260706134033.244295-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: ti: icssg-stats: Move long delayed work on system_dfl_long_wq

This commit changes the workqueue used for hardware statistics from the
per-CPU system_long_wq to the unbound system_dfl_long_wq. The goal is to
benefit from scheduler task placement since the work doesn't rely on
per-CPU variables.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 7159baa0155cf..7d6d6692d8192 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -69,7 +69,7 @@ void icssg_stats_work_handler(struct work_struct *work)
>  						stats_work.work);
>  	emac_update_hardware_stats(emac);
>  
> -	queue_delayed_work(system_long_wq, &emac->stats_work,
> +	queue_delayed_work(system_dfl_long_wq, &emac->stats_work,

[Severity: Low]
This refactoring appears incomplete. While this changes the delayed work
re-queuing, shouldn't the initial queue_work() calls also use
system_dfl_long_wq?

For example, in drivers/net/ethernet/ti/icssg/icssg_prueth.c:emac_ndo_open():

	queue_work(system_long_wq, &emac->stats_work.work);

And similarly in drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:emac_ndo_open():

	queue_work(system_long_wq, &emac->stats_work.work);

>  			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
>  }
>  EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
