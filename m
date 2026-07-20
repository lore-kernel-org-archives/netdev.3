Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F33F8243;
	Mon, 20 Jul 2026 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590643; cv=none; b=HnEBGs3RpapQy7zLe4YwnxrXLynO2fQf6Oey3KLzaSSXlTB2r3UStKqRDC4ppc9Sx5ZuwofmQ0XBSqTCEf+u2cf7mk9gbGxIUvHZTyqn5uAltmoD+NRlSfWBEsQkoBzIN8+CKHQFME+bW7sNhA4KVEj9o33qPZ1mPLSHTwYYxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590643; c=relaxed/simple;
	bh=Y4KdYSrTQFONCfiGoV4UBlp2mIDf8ApzI+uAY/rY+Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT4QNjisCvYxyq7c2YLTD/ZKbQmj1Y3uerh71GAnrPhCYMjQEv9Zble9HWKPn3xIwvtEZq5PDZqrqe2uGRwiaQ52tCDurHe4rNVUET5V+mvLxovRCEuPN1h2MZEocdMXq3bSaX6kp9pQQ4eCbExW3Dt2hKMhqUxpPXXiOyOV1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYuDALkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYuDALkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026BF1F00A3A;
	Mon, 20 Jul 2026 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590642;
	bh=Cm3ZKC4MgRylEWlmJ26UGCn2NzOZNbAQKM/GAkDkCb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cYuDALkvWB3wTKozrqUXGwrM0v3NCzm5XxGVXH0oA7ZAJaVX56CbnQRVTXbg3yZr0
	 KVZSo/Lflh58UQIsKyZBkeCPQePXEULeKuSI1Pzr3UcwbndR3vZ9XpMnWlowyIjG7k
	 Os0l5XeplULjXu7k4zX5o8BzWR8hNqIU2JJdkFvG2BaRGS1Zaw9cDdtH5RwWlJUGtt
	 +C9Ki2/o5PHRs8hR+Q/6Ba/IfjL/ILdOK/bDJFYil23Kg6Q3uAzBbBjZFUSU0xZEDQ
	 QIa+B5WQhUNuJLI8WQs4HrqUs29WjUhxLIBY9dXkErjFmBGuebc4wxZOSRTZyWbblH
	 kkGNj8LAexBdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: lukeh@padl.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	gregory.clement@bootlin.com,
	andrew@lunn.ch,
	horms@kernel.org,
	f.fainelli@gmail.com,
	tobias@waldekranz.com,
	cedric.jehasse@gmail.com,
	kieran@sienda.com,
	mh@rme-audio.de,
	max@huntershome.org,
	christoph.mellauner@joyned.at,
	simon.gapp@gapp-audio.com,
	Ryan.Wilkins@telosalliance.com,
	mattias.forsblad@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] net: dsa: qca8K: Move queuing for request frame into the core
Date: Mon, 20 Jul 2026 16:37:19 -0700
Message-ID: <20260720233719.444550-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703-net-next-dsa-rmu-v1-2-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-2-a03febf20bb4@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: qca8K: Move queuing for request frame into the core

This patch introduces dsa_inband_request() in the DSA core which
reinitialises the completion, transmits the skb via dev_queue_xmit(),
and waits for a reply. The qca8k driver is converted to use this new
helper in place of the open-coded dev_queue_xmit() plus
dsa_inband_wait_for_completion() sequence.

[Low]
The subject line uses qca8K with a capital K, which is inconsistent
with qca8k as used everywhere else in the driver and in the rest of
the series.

The commit body refers to functions that do not exist:

    Combine the queuing of the request and waiting for the completion into
    one core helper. Add the function dsa_rmu_request() to perform this.

    Access to statistics is not a strict request/reply, so the
    dsa_rmu_wait_for_completion needs to be kept.

    It is also no possible to combine dsa_rmu_request() and
    dsa_rmu_wait_for_completion() since we need to avoid the race of
    sending the request, receiving a reply, and the completion has not
    been reinitialised because the schedule at decided to do other things.

The introduced symbol is dsa_inband_request(), and the preserved
symbol is dsa_inband_wait_for_completion(); should the message refer
to those names so that git log --grep for dsa_inband_request finds
this commit?

There are also a couple of small grammar issues in the same paragraph
("It is also no possible" and "the schedule at decided to do other
things").

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index fe6fb69b6f92..4da6094552f1 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c

[ ... ]

> @@ -757,8 +747,6 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	qca8k_mdio_header_fill_seq_num(clear_skb, mgmt_eth_data->seq);
>  	mgmt_eth_data->ack = false;
>  
> -	dev_queue_xmit(clear_skb);
> -
>  	dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
>  				       QCA8K_ETHERNET_TIMEOUT);

[High]
The other five hunks replace dev_queue_xmit() plus
dsa_inband_wait_for_completion() with a single dsa_inband_request()
call. This hunk deletes dev_queue_xmit(clear_skb) but leaves the bare
dsa_inband_wait_for_completion() in place, so no packet is ever sent
for the clear step.

A few consequences follow from that:

Does this leak clear_skb on every path through qca8k_phy_eth_command()
that reaches the exit: label? The skb is allocated by
qca8k_alloc_mdio_header() and, after this change, nothing ever hands
it to dev_queue_xmit() or frees it.

Does every PHY read/write through this driver now stall for
QCA8K_ETHERNET_TIMEOUT (200ms) at the exit: label, since the
completion is reinitialised but no request is ever queued for the
switch to reply to?

Does this also skip resetting the switch's MDIO master, which was the
purpose of the clear_skb step?

The next patch in the series, 68baa3a653c1 ("net: dsa: qca8k:
dsa_inband_request: More normal return values"), replaces the
dsa_inband_wait_for_completion() call with

    dsa_inband_request(&mgmt_eth_data->inband, clear_skb,
                       QCA8K_ETHERNET_TIMEOUT);

Would it be worth squashing or reordering so that bisection landing
on this commit does not see hangs and skb leaks on every management
frame PHY access?

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 9b0c109b3058..6b5aeb99ec3b 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1357,6 +1357,8 @@ struct dsa_inband {
>  
>  void dsa_inband_init(struct dsa_inband *inband);
>  void dsa_inband_complete(struct dsa_inband *inband);
> +int dsa_inband_request(struct dsa_inband *inband, struct sk_buff *skb,
> +		       int timeout_ms);
>  int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms);

[ ... ]
