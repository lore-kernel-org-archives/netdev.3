Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CB3C07A;
	Tue, 13 Oct 2026 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870674; cv=none; b=iM4iSR4NdgMUc9zx75YkNGFrc4xBbUejrHAK06ehAH0PMG5jOKRXoT8kzlC7wbIG1IEHyhrVQ3YZdZAvxUa28VfW1R6SE8QJH12FVBzBnScuivGRvdLKzxqv2EqyuDgNZ9Yg380KgAphsFAFwMINV/hcnTIS+bRPUACXoFmVRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870674; c=relaxed/simple;
	bh=x9ISsWJDYSdrJlQBgIFEfpnMVeoeolT5hfXXYfrtiKQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kfKrfAI7orQ+jyrCj0gT2MAOxT5vCoMin8ofyUK7/jh4Ee+W/PrZmkczwm8RAzLGq40C7VrRQcm90gy7b8Wq5gh2IZHacWXJfQpVAy+U5KYPe9/cxJRTJ1STetlFHiIHc2kkXkLDqsUclcrYu+0C8ULBwqRqqlC+IlPhVxcWVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TONUKNqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TONUKNqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E729C1F000FF;
	Tue, 13 Oct 2026 05:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870673;
	bh=pfXpZTSz9pQuEWqJtKTk77hfqQ1QdEAuKZTUwRLZlFI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TONUKNqNJwXZaTc6VPaaPCN3Kw5wP8PItYXTZPa9g7ZQGgzITOiemw2TSAtZC8TqF
	 RjJpupctEzS3S4WjtnTdsnTHRC63iaJX1uwpQsGAEwvoZuJYVTjtkXyuTH3QO/tNd6
	 Bbcisms9KGOG/xtoqec8AhqSd/cJl+x2CdI5LSRwNiBL372dWrWB2DRhEwiZBs5yGE
	 NvhBh25nktUXeoLfnUctH4O50wdLhixIKO5jbutoW/pNV+JnY3pTxpI96gb7yQRWF5
	 KIMcT2tYp0FY5AHQF1qn5OXuThcvPpPXQc2F8YbLx2qvGa0fgD/lGbq/Q5rGKsX3uN
	 xy5vJNorvgIFA==
Subject: Re: [PATCH net-next v4 4/9] ibmveth: step past bad RX correlators
 instead of spinning or oopsing
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, brking@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, jmaxwell37@gmail.com, zdai@us.ibm.com,
 marcelo.leitner@gmail.com, ksiva@linux.vnet.ibm.com
Date: Tue, 13 Oct 2026 05:51:11 +0000
Message-ID: <179187067143.434549.5132413235745240934@kernel.org>
In-Reply-To: <20261012050518.88858-5-mmc@linux.ibm.com>
References: <20261012050518.88858-5-mmc@linux.ibm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds a frame-bound check to ibmveth_poll()
  (drivers/net/ethernet/ibm/ibmveth.c, line 1555).

--

ibmveth: step past bad RX correlators instead of spinning or oopsing

This patch changes ibmveth_poll() to advance the RX ring past a bad
correlator, so it no longer spins on the same slot or dereferences the
NULL skbuff array of an inactive pool. It also drops frames whose
offset + length does not fit the pool buffer, or which are shorter than
an Ethernet header. Correlator validation moves into one helper that
logs a ratelimited netdev_err() and schedules a reset.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index cee0e9783b2ab..919b5831d875c 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1469,31 +1510,60 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)

[ ... ]

> +			pool = correlator >> 32;
> +			room = min_t(unsigned int, skb_tailroom(skb),
> +				     adapter->rx_buff_pool[pool].buff_size);
> +			off = offset;
> +			len = length;
> +			if (unlikely(len < ETH_HLEN || off >= room ||
> +				     len > room - off)) {
> +				if (net_ratelimit())
> +					netdev_err(netdev,
> +						   "bad RX frame offset %u length %u (buffer %u), dropping\n",
> +						   off, len, room);
> +				ibmveth_rxq_harvest_buffer(adapter, correlator,
> +							   true);
> +				netdev->stats.rx_dropped++;
                                ^^^^

[Severity: Low]
Should these frames be counted in rx_length_errors and rx_errors rather
than rx_dropped?

The struct rtnl_link_stats64 documentation in
include/uapi/linux/if_link.h describes rx_length_errors as:

    @rx_length_errors: Number of packets dropped due to invalid length.

and says rx_errors "must include events counted by @rx_length_errors".

rx_dropped is documented for packets "received but not processed, e.g.
due to lack of resources or unsupported protocol".

With this branch in ibmveth_poll(), a runt frame (len < ETH_HLEN) or a
frame whose offset/length overruns the pool buffer shows up in ip -s link
and /proc/net/dev as a drop, not as a length error. Each frame is still
counted once, just under a different counter.

The driver doesn't update rx_length_errors or rx_errors anywhere else in
the series either.

Would something like this work instead?

    netdev->stats.rx_length_errors++;
    netdev->stats.rx_errors++;

> +				frames_processed++;
> +				continue;
> +			}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012050518.88858-1-mmc%40linux.ibm.com
