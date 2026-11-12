Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527829;
	b=qCSijf45/iXrpWISlJCLgrUZXr52hkIuV/Yk6kcopYZzMStS88nMfjgg6IxYiyKRKRkK
	 8RYwOCWK7H+LI4j+Q0rRxeS1sDbWRMSanBFQSe/IUeyHa7/9ulx1GBHPXnrtBEi9ak/sb
	 YvgF8SBdHRltw4BZZ4CiiyDHo8PJ6DGmLGcWto7/uj3o59/Kzc8tun0CWruJroVAoLNmj
	 dpp5h7NjyCAbhXVhyCe051kSfC/Y/0j6b9lR+qlzPd2PtHy1uklfYyz+Wpg//E2qBQCLc
	 lyizcnm5Z0SXoo9BwMJsvWsiVzQp26h2HKFEtfNCJ019Jt7zC/+KCNd4AQaifZKknWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527829;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0NS2CJ7BkC75vko+7B/WkqWP1lQ3iTvoy9WpBl3NUPY=;
	b=2Aop8xOm9fmdT/Kmr5k/uAwWEqkS7LjINuuXaecJnYUMsdBPZsObXyKeln77BXbF2qvR
	 X5T/nSw7/wzitJhptrFum5ZLdd64nVxWXsfZxJ/9TnuT50x1CkYRIUnG3fUvs9i9y7q3/
	 b0fvKm6f1BJUXczEa0Si0zs58oSxnILC9vNS7XUlaiwKG5H6Rr8BJrd1r3CLvxa6LKspw
	 Mu0PBRStBos8qLRMufMboPTUl9SzluTS4yj5curCoyf+brlYpvCQy30he29d4Tpd8eCpp
	 Aeu+vWtINXuzN8i4rHwX6uQ8dx9wsNvvVAEsIv5EPLBL+wkPS0LyKADLEVL31dysvvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VoC3cO/8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE37606A8B1
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoC3cO/8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565351F000C5;
	Thu, 12 Nov 2026 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527829;
	bh=0NS2CJ7BkC75vko+7B/WkqWP1lQ3iTvoy9WpBl3NUPY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VoC3cO/8ii0AJO8CxU68emtq4y71XBqBMTZW7hNkSsAkm8q8dd6oOIfD1VkaXaakb
	 iaSwl6o/9OpwfOHjW3W2Od/UiZ4wMhxpqHC1qd4e5O7SORoA8fCoflyqbfIkurRGmo
	 7AOCIAqdLQSrckibsGZeAtLVG3VoPkHdu8gOIVmaiO6OWy6bUSEIeCo2QXiU+1cb17
	 kdJYLvqPOZeDk0ISf2EbaD36Htix0Iaawpw7VwGrO4Z47orZFwlJigp7AmEaDDs70Z
	 Nl32c7NDEF/+QUbmWN6ZlH6r9UZ9Sy7LFb2v6099T90uiDc56+vvUyf1838wsz8PTR
	 Uuna5espby2qQ==
Subject: Re: [PATCH net-next v8 09/15] ibmveth: Split RX poll into per-slot
 helpers for MQ
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:07 +0000
Message-ID: <179452782793.2199510.9499516372041344011@kernel.org>
In-Reply-To: <20261109235556.60604-10-mmc@linux.ibm.com>
References: <20261109235556.60604-10-mmc@linux.ibm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch moves the RX frame-bound drop into a new helper,
  ibmveth_poll_drop_oversize(), and changes its log text.

--

ibmveth: Split RX poll into per-slot helpers for MQ

This commit splits the ibmveth_poll() loop body into per-slot helpers
(stopping, recycle_invalid, skip_bad_correlator, drop_oversize,
deliver_frame, bump_invalid), so the NAPI callback becomes a thin budget
loop. It also adds checks that stop polling once the device is down or a
napi_disable() is pending, and a WARN for a NAPI index past the queue
count, in preparation for multi-queue RX.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index a1f286b37effa..b12bfa1e485eb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> +static void ibmveth_poll_drop_oversize(struct net_device *netdev,
> +				       struct ibmveth_adapter *adapter,
> +				       int queue_index, unsigned int off,
> +				       unsigned int len, unsigned int room,
> +				       u64 correlator)
> +{
> +	if (net_ratelimit())
> +		netdev_err(netdev,
> +			   "RX frame %u+%u exceeds buffer %u on queue %d, dropping\n",
> +			   off, len, room, queue_index);
> +	netdev->stats.rx_dropped++;
> +	ibmveth_rxq_harvest_correlator(adapter, queue_index, true, correlator);
> +}

[ ... ]

> +	pool = correlator >> 32;
> +	bpool = &adapter->rx_buff_pool[queue_index][pool];
> +	room = min_t(unsigned int, skb_tailroom(skb),
> +		     bpool->buff_size);
> +	off = offset;
> +	len = length;
> +	if (unlikely(len < ETH_HLEN || off >= room ||
> +		     len > room - off)) {
> +		ibmveth_poll_drop_oversize(netdev, adapter, queue_index,
> +					   off, len, room, correlator);
> +		return 0;
> +	}

[Severity: Low]
Does the new message in ibmveth_poll_drop_oversize() describe the runt
case correctly?

The guard in ibmveth_poll_deliver_frame() sends all three conditions to
the same helper, including len < ETH_HLEN. A 10-byte frame at offset 0
in a 2048-byte buffer would be logged as:

  RX frame 0+10 exceeds buffer 2048 on queue 0, dropping

That frame was too short, not too large.

The old text this replaces was neutral and matched every condition:

-						   "bad RX frame offset %u length %u (buffer %u), dropping\n",

This is the only log line on this path, so it is what someone looking
into PHYP descriptor problems from dmesg would see.

The commit message calls this moving existing checks into helpers, and
only says "a PHYP offset+length beyond min(skb_tailroom,
pool->buff_size) is dropped". It doesn't mention that the message
changed or that runt frames now go through the oversize helper. The
wording is the same at the end of the series.

Could the neutral wording be kept, the log say which check failed, or
the len < ETH_HLEN case be handled on its own?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com
