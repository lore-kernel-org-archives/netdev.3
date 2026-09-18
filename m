Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DA5C613;
	Fri, 18 Sep 2026 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711865; cv=none; b=peGo6ALd3rrpjU50nSUz8V8jP9vb5F+tYMDmO3qXFaiN/ousMymsQzEoNdQuo9C0wmQSrhmL+78BSPeV2ojUH59lMBVde//+X+stc4OQSGl2w0BRgOFRc7L/cihJHxXx8/DEi+WhLx3gHCgz0FI3hmRvHIkbggvi8zxoQC/56os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711865; c=relaxed/simple;
	bh=oOLwityMH5uePFglWNH9YcdbM8icNybmU0ycSiZckT0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NodMHCEWypvpBU9jbw+RZ1RFeDUgtIIpKwjxnqRKC7AoRt9BN8rqothL70MBxiGq2he4h/QHMTh6D4Hy5qYDk7/OixjuEDa6B4FMCKXVbN4ve4OPXrC+n3fZDbd11FHqemF4wZiBNgq2QgcnHYSXqNj1lIEBtsLEXSVLHH2OH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8P0g8Lw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8P0g8Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0F81F000FF;
	Fri, 18 Sep 2026 06:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789711863;
	bh=AQ9gdXJBc3uhyb3QTeXMIRSoXEAyu9HsvJeDL5xa9vE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l8P0g8LwgAt0Uyf8xnVsVHBc4H1jLZbFFKiTVL6Y2cxgCgSBrqGtm+o2W9K1NrUTA
	 ujY7i3B5e9+ztgTrut7E7iHrc8kIMzdW59Y+pw9LEWzvunrDAKj5HIF7TlbhtNX6VB
	 cgC4D+PPdMmmzFhzftBsoo2fDwgEXxkVdDgfFFibfyhBQuFd79Dpy8IXeDz4qVmq1f
	 QpcINLY8dfuI2SInoLhzBVYC2mOH3fDALQ1154j+5BU4StzzFkM/hLNAXyy4BK+JBS
	 okTG4sdEvFrAu0QC22urPQnv+KLrk8+33gZMmMCX8v3ihAyONnrBLM5QKAp8w9eOne
	 3r+RFEMvXuZKw==
Subject: Re: [PATCH net] eth: fbnic: Keep real queue counts synchronized
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 mohsin.bashr@gmail.com, mike.marciniszyn@gmail.com, leitao@debian.org,
 horms@kernel.org, almasrymina@google.com, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
Date: Fri, 18 Sep 2026 06:11:02 +0000
Message-ID: <178971186222.22033.14149428944925737019@kernel.org>
In-Reply-To: <20260915180859.4157646-1-bjorn@kernel.org>
References: <20260915180859.4157646-1-bjorn@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 0

- [Medium] Comment and changelog do not match the code:
  `__fbnic_pm_resume()`…
- [Medium] The new resume path makes a channel state reachable that
  fbnic's own ethtool setter rejects.

Pre-existing issues:
- [High] NULL pointer dereference on interface open for a fully split
  channel configuration at the 128-vector boundary.
- [High] Error pointer passed to `page_pool_destroy()` plus leak of the
  header page pool in `fbnic_alloc_qt_page_pools()`…

--

eth: fbnic: Keep real queue counts synchronized

The patch publishes the driver's private queue counts to the netdev real
queue counts as soon as they change (defaults at alloc time and channel
changes while the device is down), and stops clamping the private queue
counts on resume so that memory-provider bindings on Rx queues are
preserved. Only the NAPI layout is recomputed on resume.

Link: https://lore.kernel.org/netdev/178915061000.219967.7726187707862333281@kernel.org/

A few questions on the resume path and on some surrounding code below.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 0e47088ec44ba..bec6113873338 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -1626,6 +1626,13 @@ static int fbnic_set_channels(struct net_device *netdev,
>  		return -EINVAL;
>  
>  	if (!netif_running(netdev)) {
> +		unsigned int rx_count = ch->rx_count + ch->combined_count;
> +		unsigned int tx_count = ch->tx_count + ch->combined_count;
> +
> +		err = netif_set_real_num_queues(netdev, tx_count, rx_count);
> +		if (err)
> +			return err;
> +
>  		fbnic_set_queues(fbn, ch, max_napis);
>  		fbnic_reset_indir_tbl(fbn);
>  		return 0;

[Severity: High]

This isn't a bug introduced by this patch, but while looking at
fbnic_set_channels() the validation just above this hunk seems to accept a
configuration that the NAPI allocator cannot build.

The check is:

	if ((ch->rx_count && ch->tx_count && ch->combined_count) ||
	    (standalone && standalone + ch->combined_count > max_napis) ||

so on a host where max_napis == 128, ethtool -L eth0 rx 64 tx 64 combined 0
passes (128 > 128 is false), and fbnic_set_queues() records
num_rx_queues=64, num_tx_queues=64, num_napi=min(128, 128)=128.

On the next open, fbnic_alloc_napi_vectors() skips its dedicated Tx/Rx
branch because of the strict comparison at num_napi == FBNIC_MAX_TXQS:

	if (num_napi < FBNIC_MAX_TXQS && num_napi == num_tx + num_rx) {

The fallback pairing loop then allocates one Tx/Rx pair per vector
(tqpv = DIV_ROUND_UP(64, 128) = 1, rqpv = 1) and returns 0 after filling
only fbn->napi[0..63].

fbnic_alloc_resources() still walks the configured count:

	for (i = 0; i < fbn->num_napi; i++) {
		err = fbnic_alloc_nv_resources(fbn, fbn->napi[i]);

and fbnic_alloc_nv_resources() dereferences the NULL entry at
for (i = 0; i < nv->txt_count; i++).

Can this oops on open?  fbnic_free_napi_vectors() guards with
if (fbn->napi[i]), which suggests partially populated arrays are expected,
while the alloc walk has no such guard.

[ ... ]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index 8b9bc9e8ea56c..4dda566d580f4 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -510,12 +511,17 @@ static int __fbnic_pm_resume(struct device *dev)
>  
>  	fbn = netdev_priv(netdev);
>  
> -	/* Reset the queues if needed */
> -	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
> -
>  	rtnl_lock();
>  	netdev_lock(netdev);
>  
> +	/* Preserve queue counts, as RX queues may have memory providers bound.
> +	 * The RSS table indexes RX queues and remains valid. Rebuild only the
> +	 * NAPI layout, sharing vectors if fewer IRQs are available.
> +	 */
> +	max_napis = fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
> +	max_queues = max(fbn->num_tx_queues, fbn->num_rx_queues);
> +	fbn->num_napi = min(max_queues, max_napis);

[Severity: Medium]

The comment says vectors are shared "if fewer IRQs are available", and the
changelog says "share the remaining NAPI vectors when fewer IRQs are
available".  Does this code look at the previously configured
fbn->num_napi at all?

Take a standalone layout configured with ethtool -L eth0 rx 4 tx 4
combined 0.  fbnic_set_queues() records:

	fbn->num_rx_queues = 4;
	fbn->num_tx_queues = 4;
	fbn->num_napi = min(4 + 4 + 0, max_napis) = 8;

After a suspend/resume that obtains exactly the same number of IRQs,
num_napi becomes min(max(4, 4), max_napis) = 4, so
fbnic_alloc_napi_vectors() no longer takes its one queue per vector
branch:

	if (num_napi < FBNIC_MAX_TXQS && num_napi == num_tx + num_rx) {

and fbnic_get_channels() then reports combined=4, rx=0, tx=0 instead of
the rx=4 / tx=4 that was configured, with half the interrupt contexts.

The collapse to max(tx, rx) matches what the removed
fbnic_reset_queues() call already computed, so the behaviour itself is not
new here, but the comment and changelog now describe something else.
Would min(fbn->num_napi, max_napis) implement what they describe?

[Severity: Medium]

Preserving asymmetric queue counts while lowering num_napi also seems to
make a state reachable that fbnic's own setter rejects.  Before this
change, fbnic_reset_queues() clamped both queue counts to max_napis and
then set num_napi = max(tx, rx), so num_napi >= num_rx_queues always held
after resume.

Now consider rx_count=4, combined_count=4 set while max_napis >= 8, so
num_rx_queues=8, num_tx_queues=4, num_napi=8.  If resume gets only 4 NAPI
IRQs, num_napi = min(8, 4) = 4, and fbnic_get_channels() takes this
branch:

	if (fbn->num_rx_queues > fbn->num_napi ||
	    fbn->num_tx_queues > fbn->num_napi)
		ch->combined_count = min(fbn->num_rx_queues,
					 fbn->num_tx_queues);
	...
	ch->rx_count = fbn->num_rx_queues - ch->combined_count;
	ch->tx_count = fbn->num_tx_queues - ch->combined_count;

reporting combined=4, rx=4, tx=0, i.e. 8 channels while only 4 NAPI
vectors exist.  Feeding those same values back to fbnic_set_channels()
hits:

	    (standalone && standalone + ch->combined_count > max_napis) ||

with 4 + 4 > 4 and returns -EINVAL.  Is it intended that ethtool -l output
can no longer be replayed through ethtool -L after such a resume, and that
it describes more channels than there are vectors?

One more observation outside the diff, in fbnic_alloc_qt_page_pools() in
drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:

[Severity: High]

This is a pre-existing issue and not something this patch changes, but for
an Rx queue with an unreadable memory provider bound, the header pool is
stored in qt->sub0.page_pool and the local pp is then reused for the
payload pool.  When the second page_pool_create() fails, the error label
is reached with pp holding the ERR_PTR:

	err_destroy_sub0:
		page_pool_destroy(pp);
		return PTR_ERR(pp);

page_pool_destroy() only checks for NULL:

	void page_pool_destroy(struct page_pool *pool)
	{
		if (!pool)
			return;

		if (!page_pool_put(pool))
			return;

so does this dereference the error pointer in page_pool_put()?  And does
the label also leak the header pool in qt->sub0.page_pool, which is never
destroyed here?  Should the label destroy qt->sub0.page_pool while still
returning PTR_ERR(pp)?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915180859.4157646-1-bjorn%40kernel.org
