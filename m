Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DD4137BF;
	Mon, 17 Aug 2026 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787010191; cv=none; b=EQCaLfgEGtbDwlSpFOZmqB5YGiGCh8QB5t9aWDTmOsDbvKNC24mu3DtqnJc2pkp3qd/oqNGBNp3VtNSttB/dCPZNIF5WX8t6fvQYwRbjowPsk0Y2OC/fyi6L2+ojTLVckXO29qzVzvl0XNnRNg1y2ACbOJolR2USzAg98ubiaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787010191; c=relaxed/simple;
	bh=EqpoLhfgKOMY3CMDUfyTXXbloAOVzBAOzhrGigpUCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4pOONRxxejvCO5U94hUhmtvCYlz1ES5tTuSD3BZFLrw1HQHvShti0EMQ9AiLwnZ9EKi1uOO2vJfLSG7SkAYhXlZ8g8pr6PYN/cUdpLqBKWOXfZgwDMMAmUiB44aRPknZkdPAXjExCv6LPxegRTeP6du1okeqXLNllntyjStCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFYPYAff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFYPYAff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B051F000E9;
	Mon, 17 Aug 2026 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787010189;
	bh=e430kTuvXnUaGiIBaX/CrBcZEpq9l/g+Tm53CLiCmsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kFYPYAffrEEXmiAVLqQ7LlnoddKZhZAsGrlMx2OaDYybvHHM6nsxpKb7MeZgPUpP9
	 uhy+Oo+66F+lZUhvc0Y4UkmeV6E3omzCmu7xcj5NeB69I7o/QLXcRuGWnkYXQWjQ5T
	 5ndtbJCjwae9yB+qd69yFGl5B/NQ4oKjUJeSOC2EXkgwubRKe69FGvldmYxp6ivK8L
	 KdtDMZ0B1+8oy1JNND4wrcf0a94UHUJDAFsJCRN0+xSQe/r3LwKlyMC2GWI2XLaFax
	 ppQFd7JPexfuu3TRWbAGaOtIy9Yfr5gMcHUQ9oBclGyfnWhHZDeMcaSC2tb5WTUyNe
	 NYhKPGNXl5TUw==
Date: Mon, 17 Aug 2026 16:43:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] ixgbe: implement get_queue_stats_rx
Message-ID: <20260817164308.5bf8bc87@kernel.org>
In-Reply-To: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
References: <20260814141446.90544-1-kshitiz.bartariya@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 19:44:36 +0530 Kshitiz Bartariya wrote:
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[idx]);
> +	u64 bytes, packets, alloc_rx_page_failed, alloc_rx_buff_failed,
> +		csum_err;
> +	unsigned int start;
> +
> +	if (ring) {
> +		do {
> +			start = u64_stats_fetch_begin(&ring->syncp);
> +			bytes = ring->stats.bytes;
> +			packets = ring->stats.packets;
> +			alloc_rx_page_failed =
> +				ring->rx_stats.alloc_rx_page_failed;
> +			alloc_rx_buff_failed =
> +				ring->rx_stats.alloc_rx_buff_failed;
> +			csum_err = ring->rx_stats.csum_err;
> +		} while (u64_stats_fetch_retry(&ring->syncp, start));
> +	}
> +
> +	stats->bytes = bytes;

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:9772:6: warning: variable 'bytes' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
-- 
pw-not: cr
