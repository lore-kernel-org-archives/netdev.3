Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AB3271F9
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044020; cv=none; b=PsW1cFAoSStvhftHe4jR8CA/ku26dgkc2/Qhw1Swqc5Y6Opp3SCGssT7HoabPF+/qa/CM0bPWPD2prRGpaRA4QZBp8JgJqjNFrdccZrfu1vKIvGGL/xSVMyW3vo7vbhvDfxISajZPssMX4KS+5ROchwSRkqZ7L+OBubBL9qJsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044020; c=relaxed/simple;
	bh=z/sE6acMIuXc8Jd/CnJox/I8+H9Rod623sHQ+AEeC7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0uSNNa1fAFXxB8sBiI9z0OYksgGaiWs7Y7WmwilUKM6d6efz54fVtJrd9KuD0hYX1mYSZqTPKkLuoAqGGA9B6hJVzZ3fqUTpt0jYa0teRgh4AMwq9l3xdTvR4og2vPTI64bmw4rkqNG1iIi3rGD/0YDHZenxZ3+pQP4FDG8Ppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m20vhSi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m20vhSi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F79C4CEF1;
	Thu, 22 Jan 2026 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769044019;
	bh=z/sE6acMIuXc8Jd/CnJox/I8+H9Rod623sHQ+AEeC7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m20vhSi+G2OFUk5/619Ve5zbcPjre/MxWV+J+UGqO2BJ726WTnsqyerbZgH+mFbRH
	 OSOGyd9so19s3b3YBmsQN7XEGV3A2K0x70teDAIVZ4qCOtDxA2XAm7UlJfQtebRqcZ
	 TN2+qHeGbwEw9xnQL7uwHASmKwhMqfJKjX91Kh3n4t+dTZQkX+YNERdiGAdc3dAK6R
	 8Xp50TnQoz0a0C0GH/7RRXFKGnzfhvxW9dL5F7eVDKyMObX/7nHmACWG2ebk7lgn4V
	 zsOj3Uhfw9UJvaVZbM2xU+uLUjSRKlBIG88vsFBB2hjXWpmlzG8QhDzCT85xSd9pOg
	 ZjlA/QZu8IvsA==
Date: Wed, 21 Jan 2026 17:06:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v21 4/6] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20260121170658.371e0e63@kernel.org>
In-Reply-To: <20260121082413.130681-5-xuanzhuo@linux.alibaba.com>
References: <20260121082413.130681-1-xuanzhuo@linux.alibaba.com>
	<20260121082413.130681-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 16:24:11 +0800 Xuan Zhuo wrote:
> +	napi_consume_skb(meta->skb, in_napi);

Please see cd18e8ac030e646. I was hoping AI code review would flag 
the issue in this patch with that kdoc in place but doesn't look like 
it worked :( Oh well, guessing machines..

> +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	struct eea_net *enet = netdev_priv(netdev);
> +	int qnum = skb_get_queue_mapping(skb);
> +	struct eea_net_tx *tx = &enet->tx[qnum];
> +	struct netdev_queue *txq;
> +	int err, n;
> +
> +	txq = netdev_get_tx_queue(netdev, qnum);
> +
> +	n = shinfo->nr_frags + 1;
> +
> +	if (!netif_txq_maybe_stop(txq, tx->ering->num_free, n, n)) {
> +		/* maybe the previous skbs was xmitted without kick. */
> +		eea_tx_kick(tx);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	skb_tx_timestamp(skb);
> +
> +	err = eea_tx_post_skb(tx, skb);
> +	if (unlikely(err))
> +		dev_kfree_skb_any(skb);

You should try to stop the queue after submitting the skb if another
worst case packet won't fit on the ring. NETDEV_TX_BUSY is expensive
and bad for AQM.

> +	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
> +		eea_tx_kick(tx);
> +
> +	return NETDEV_TX_OK;
> +}
-- 
pw-bot: cr
