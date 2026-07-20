Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94C31A7E2;
	Mon, 20 Jul 2026 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590641; cv=none; b=X+2X+Y8zyoj8agE18jt5Nvr9ebOWqJZ6nzJa5Efq7Fd8WQoksuROgURkL1HAUzFcVyu0p1OKlLLfPmeiGPXYaLck3ALqV3wvKVohU1bu5JE1G3pim9L5KYIYq2jCeRii3leOAWxYL0z/j/as95noV9XWyWbmN7zdUELUk6yz8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590641; c=relaxed/simple;
	bh=FkNzPn2/1f/sq7IXFDh82jR4YnBoz7JQTHYX7xbR4sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuT8puQKkrTsjVIFOLGDUdFxB9NChME6J7mWP3ngNRW00GcZgjLvkA6GMi+oiMOHJ4LMVNgophHnyGk1io5iSzOFib/1smt7cJ+YS3z2r65cJPqQR322WhRECb3RPwsKavrtjbi6uJCYWAXPhKz7pbLdHOCu2ROuqhhZlBmGtSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqL6YIla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqL6YIla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5471F000E9;
	Mon, 20 Jul 2026 23:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590639;
	bh=87W4ZFzEqU7eHTfUQ6JiUaTLsf+FhPjMIt0B6vq8eko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LqL6YIlatkfcn7OFE2HzZg4zwsymZ80B7AVoYm8vZ+MP1Otso+Tgq7ZUkkjUBwovQ
	 xvDektzqOBnG6Vu9ZIP0Of1grqDy/n6ZbnqbSoNFCd09o08MOAADfIfgFU8JPpQNE4
	 vCPMnhPPBXM1RXYo8rBPXqVgKe+E3ZA53Km7l+WvFb2q40yYQLcerxYIev+H0YFIKO
	 wlMR1ZRveR99Pde8O98/sT2D5dg26QdlSDJ2OCzpi1zVeScLS2REz5ctg/iFAbx90e
	 99X7gFXV2psMD7gkBbr902W2glj68JxxN7EF+EL7f8RbUk8jw42qWjwnWmXXcZ9j51
	 /79xuhKwDgnMQ==
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
Subject: Re: [PATCH net-next 01/12] net: dsa: qca8k: Move register access completion into DSA core
Date: Mon, 20 Jul 2026 16:37:12 -0700
Message-ID: <20260720233712.444486-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703-net-next-dsa-rmu-v1-1-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-1-a03febf20bb4@padl.com>
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
net: dsa: qca8k: Move register access completion into DSA core

This patch factors the request/reply completion used by the qca8k
mgmt-Ethernet path into a new dsa_inband helper in the DSA core, moves
the reinit_completion() and msecs_to_jiffies() conversion into the
helper, and switches every qca8k mgmt-eth call site to use it.

> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index 4c928983b862..fe6fb69b6f92 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -332,8 +332,6 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  
>  	skb->dev = priv->mgmt_conduit;
>  
> -	reinit_completion(&mgmt_eth_data->rw_done);
> -
>  	/* Increment seq_num and set it in the mdio pkt */
>  	mgmt_eth_data->seq++;
>  	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
> @@ -341,8 +339,8 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  
>  	dev_queue_xmit(skb);
>  
> -	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
> -					  QCA8K_ETHERNET_TIMEOUT);
> +	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
> +					     QCA8K_ETHERNET_TIMEOUT);

[High]
Could this reorder introduce a race between the sender and the ack
handler?

Before the patch every mgmt-eth call site did:

    reinit_completion(&mgmt_eth_data->rw_done);
    ...
    dev_queue_xmit(skb);
    wait_for_completion_timeout(&mgmt_eth_data->rw_done, ...);

so the completion was armed before the frame could produce a reply.

After the patch each call site does:

    dev_queue_xmit(skb);
    dsa_inband_wait_for_completion(&mgmt_eth_data->inband, ...);

and dsa_inband_wait_for_completion() itself does:

    int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms)
    {
        unsigned long jiffies = msecs_to_jiffies(timeout_ms);

        reinit_completion(&inband->completion);

        return wait_for_completion_timeout(&inband->completion, jiffies);
    }

so reinit_completion() now runs after dev_queue_xmit().

The reply is delivered from the RX softirq path via
qca8k_rw_reg_ack_handler() -> dsa_inband_complete() -> complete(), with
no mutex synchronising it against the sender. If the reply is processed
in the window between dev_queue_xmit() returning and the reinit inside
the helper, done is set to 1 by the ack handler and then cleared back to
0 by reinit_completion(), and wait_for_completion_timeout() then blocks
for the full QCA8K_ETHERNET_TIMEOUT and returns 0.

Callers then report -ETIMEDOUT even though the reply arrived. Every
mgmt-eth caller looks affected: qca8k_read_eth(), qca8k_write_eth(),
qca8k_phy_eth_busy_wait() and both branches plus the exit path of
qca8k_phy_eth_command().

The next patch in the series ("net: dsa: qca8K: Move queuing for request
frame into the core", 98b48914b271) introduces dsa_inband_request() and
its comment/commit message state that reinit_completion() must precede
dev_queue_xmit() to avoid this race. Should the reinit be moved back
before dev_queue_xmit() in this patch, or should this patch be squashed
with the follow-up, to avoid a bisect window where mgmt-eth reads and
writes can spuriously fail?

> @@ -384,8 +382,6 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  
>  	skb->dev = priv->mgmt_conduit;
>  
> -	reinit_completion(&mgmt_eth_data->rw_done);
> -
>  	/* Increment seq_num and set it in the mdio pkt */
>  	mgmt_eth_data->seq++;
>  	qca8k_mdio_header_fill_seq_num(skb, mgmt_eth_data->seq);
> @@ -393,8 +389,8 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  
>  	dev_queue_xmit(skb);
>  
> -	ret = wait_for_completion_timeout(&mgmt_eth_data->rw_done,
> -					  QCA8K_ETHERNET_TIMEOUT);
> +	ret = dsa_inband_wait_for_completion(&mgmt_eth_data->inband,
> +					     QCA8K_ETHERNET_TIMEOUT);

[ ... ]

> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 8c16ef23cc10..9b0c109b3058 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1347,6 +1348,17 @@ int dsa_port_simple_hsr_join(struct dsa_switch *ds, int port,
>  int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
>  			      struct net_device *hsr);
>  
> +/* Perform operations on a switch by sending it request in Ethernet
> + * frames and expecting a response in a frame.
> + */
> +struct dsa_inband {
> +	struct completion completion;
> +};
> +
> +void dsa_inband_init(struct dsa_inband *inband);
> +void dsa_inband_complete(struct dsa_inband *inband);
> +int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms);

[Low]
Should the return type of dsa_inband_wait_for_completion() be
unsigned long to match wait_for_completion_timeout(), and should
timeout_ms be unsigned int?

The current declaration narrows the wait_for_completion_timeout() return
(unsigned long jiffies remaining) to int, and a negative timeout_ms
would be interpreted by msecs_to_jiffies() as MAX_JIFFY_OFFSET. qca8k
callers only check ret <= 0 at a 5 ms timeout so the truncation is
invisible today, but this helper is EXPORT_SYMBOL_GPL and intended as a
pattern for further DSA drivers, so fixing the signature later would be
an uAPI-ish change to a core API. Would a documented bool "timed_out"
return also work, since callers only care about zero vs non-zero?

> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index 9cb732f6b1e3..dc4e5cdb2f5b 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -1834,6 +1834,28 @@ int dsa_port_simple_hsr_leave(struct dsa_switch *ds, int port,
>  }
>  EXPORT_SYMBOL_GPL(dsa_port_simple_hsr_leave);
>  
> +void dsa_inband_init(struct dsa_inband *inband)
> +{
> +	init_completion(&inband->completion);
> +}
> +EXPORT_SYMBOL_GPL(dsa_inband_init);
> +
> +void dsa_inband_complete(struct dsa_inband *inband)
> +{
> +	complete(&inband->completion);
> +}
> +EXPORT_SYMBOL_GPL(dsa_inband_complete);
> +
> +int dsa_inband_wait_for_completion(struct dsa_inband *inband, int timeout_ms)
> +{
> +	unsigned long jiffies = msecs_to_jiffies(timeout_ms);
> +
> +	reinit_completion(&inband->completion);
> +
> +	return wait_for_completion_timeout(&inband->completion, jiffies);
> +}
> +EXPORT_SYMBOL_GPL(dsa_inband_wait_for_completion);

[Low]
The local variable is named jiffies, which shadows the global kernel
symbol jiffies from <linux/jiffies.h>. There is no runtime effect today
since the function does not reference the global, but any later addition
to this function that types "jiffies" would silently bind to the local
timeout value. Would renaming to timeout_j or timeout_jiffies be
preferable, especially given the helper is exported and likely to be
copied by other DSA drivers?
