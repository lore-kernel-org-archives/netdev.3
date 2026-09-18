Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3462F691D;
	Fri, 18 Sep 2026 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727644; cv=none; b=RwlaOy6OZ8gyfOAJ22eufaPo3pGw9XH8I0AzpyZyNpz1dFxTKj7fUCdxXYqS7ewLqF+HqXGumI5IurO6pOzv2AWF44ydawcy6DzYUt7Sr6teNMmT8mRDCfGEMnqDosHZHqD/oQasIEsyhH+GScW1cTL6ihoXDMS0zHFmva/LGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727644; c=relaxed/simple;
	bh=yPPiKmEgVPTtLzJ8gL2slYXxyTkBBl+ccym/YTSazeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fMesoz4SJP1VmK8a3qEG5a6CmfuQ4BRJP5V8UmNgyg6G5/aQXrQQwR5IE5Gf1IjQ9jXP1bnX38hduy6EBlzU/FtBmmQKYOAv66EyjseX12Yvo17W39wV7K8lcO0RT+s7N6IaEcbZXj1Sw6qUuGcLauwOVVAPeudQUhjxYE4NbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8DuL/hD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8DuL/hD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DCC1F000FF;
	Fri, 18 Sep 2026 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727642;
	bh=8Q1GCb3DTcT0ZyJdmbfyuteX4hmDxY6lziGNf/oQ+As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=L8DuL/hD8UsIr9NprMVowh+2YjDqlx9+lxT7VWmJ1VUPpcFXdtTtrIDDptiLLRPsh
	 P2CKnzMYK+NWeBx831O4jwtLO006y62NZxQv8M5JCMMca+GSSF1euGi10k3U+bvua6
	 Oxgc/67Y8lmIES+VpgtV4qybi8pE2O+AX4oJ1d+M3CzX1cumDMgD+H0sExSKq27hdg
	 Pqr4dn3YG2hKUwiBE2R3pu5VWVZRgpWzCGFIf20hAvTm+KR4ocdBPU389x5JkOz9vd
	 8lFHS0BlCnpmOeu3gOL5xq4cDB4C1c1UWqUj72F7J3JBQZaZZDlT+VzxOYHNkxmSiZ
	 SIyIf+maNEDeA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 mohsin.bashr@gmail.com, mike.marciniszyn@gmail.com, leitao@debian.org,
 horms@kernel.org, almasrymina@google.com, linux-kernel@vger.kernel.org,
 netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net] eth: fbnic: Keep real queue counts synchronized
In-Reply-To: <178971186222.22033.14149428944925737019@kernel.org>
References: <20260915180859.4157646-1-bjorn@kernel.org>
 <178971186222.22033.14149428944925737019@kernel.org>
Date: Fri, 18 Sep 2026 12:33:58 +0200
Message-ID: <87wlsirgq1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/n=
et/ethernet/meta/fbnic/fbnic_ethtool.c
>> index 0e47088ec44ba..bec6113873338 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>> @@ -1626,6 +1626,13 @@ static int fbnic_set_channels(struct net_device *=
netdev,
>>  		return -EINVAL;
>>=20=20
>>  	if (!netif_running(netdev)) {
>> +		unsigned int rx_count =3D ch->rx_count + ch->combined_count;
>> +		unsigned int tx_count =3D ch->tx_count + ch->combined_count;
>> +
>> +		err =3D netif_set_real_num_queues(netdev, tx_count, rx_count);
>> +		if (err)
>> +			return err;
>> +
>>  		fbnic_set_queues(fbn, ch, max_napis);
>>  		fbnic_reset_indir_tbl(fbn);
>>  		return 0;
>
> [Severity: High]
>
> This isn't a bug introduced by this patch, but while looking at
> fbnic_set_channels() the validation just above this hunk seems to accept a
> configuration that the NAPI allocator cannot build.
>
> The check is:
>
> 	if ((ch->rx_count && ch->tx_count && ch->combined_count) ||
> 	    (standalone && standalone + ch->combined_count > max_napis) ||
>
> so on a host where max_napis =3D=3D 128, ethtool -L eth0 rx 64 tx 64 comb=
ined 0
> passes (128 > 128 is false), and fbnic_set_queues() records
> num_rx_queues=3D64, num_tx_queues=3D64, num_napi=3Dmin(128, 128)=3D128.
>
> On the next open, fbnic_alloc_napi_vectors() skips its dedicated Tx/Rx
> branch because of the strict comparison at num_napi =3D=3D FBNIC_MAX_TXQS:
>
> 	if (num_napi < FBNIC_MAX_TXQS && num_napi =3D=3D num_tx + num_rx) {
>
> The fallback pairing loop then allocates one Tx/Rx pair per vector
> (tqpv =3D DIV_ROUND_UP(64, 128) =3D 1, rqpv =3D 1) and returns 0 after fi=
lling
> only fbn->napi[0..63].
>
> fbnic_alloc_resources() still walks the configured count:
>
> 	for (i =3D 0; i < fbn->num_napi; i++) {
> 		err =3D fbnic_alloc_nv_resources(fbn, fbn->napi[i]);
>
> and fbnic_alloc_nv_resources() dereferences the NULL entry at
> for (i =3D 0; i < nv->txt_count; i++).
>
> Can this oops on open?  fbnic_free_napi_vectors() guards with
> if (fbn->napi[i]), which suggests partially populated arrays are expected,
> while the alloc walk has no such guard.

Ya, this can oops. It is addressed by:
  https://lore.kernel.org/netdev/178942020457.7700.13129750616387075931.stg=
it@ahduyck-xeon-server.home.arpa/
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
The fix includes the 128-vector case in the standalone allocation path.
=20=20=20
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_pci.c
>> index 8b9bc9e8ea56c..4dda566d580f4 100644
>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
>> @@ -510,12 +511,17 @@ static int __fbnic_pm_resume(struct device *dev)
>>=20=20
>>  	fbn =3D netdev_priv(netdev);
>>=20=20
>> -	/* Reset the queues if needed */
>> -	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
>> -
>>  	rtnl_lock();
>>  	netdev_lock(netdev);
>>=20=20
>> +	/* Preserve queue counts, as RX queues may have memory providers bound.
>> +	 * The RSS table indexes RX queues and remains valid. Rebuild only the
>> +	 * NAPI layout, sharing vectors if fewer IRQs are available.
>> +	 */
>> +	max_napis =3D fbd->num_irqs - FBNIC_NON_NAPI_VECTORS;
>> +	max_queues =3D max(fbn->num_tx_queues, fbn->num_rx_queues);
>> +	fbn->num_napi =3D min(max_queues, max_napis);
>
> [Severity: Medium]
>
> The comment says vectors are shared "if fewer IRQs are available", and the
> changelog says "share the remaining NAPI vectors when fewer IRQs are
> available".  Does this code look at the previously configured
> fbn->num_napi at all?
>
> Take a standalone layout configured with ethtool -L eth0 rx 4 tx 4
> combined 0.  fbnic_set_queues() records:
>
> 	fbn->num_rx_queues =3D 4;
> 	fbn->num_tx_queues =3D 4;
> 	fbn->num_napi =3D min(4 + 4 + 0, max_napis) =3D 8;
>
> After a suspend/resume that obtains exactly the same number of IRQs,
> num_napi becomes min(max(4, 4), max_napis) =3D 4, so
> fbnic_alloc_napi_vectors() no longer takes its one queue per vector
> branch:
>
> 	if (num_napi < FBNIC_MAX_TXQS && num_napi =3D=3D num_tx + num_rx) {
>
> and fbnic_get_channels() then reports combined=3D4, rx=3D0, tx=3D0 instea=
d of
> the rx=3D4 / tx=3D4 that was configured, with half the interrupt contexts.
>
> The collapse to max(tx, rx) matches what the removed
> fbnic_reset_queues() call already computed, so the behaviour itself is not
> new here, but the comment and changelog now describe something else.
> Would min(fbn->num_napi, max_napis) implement what they describe?
>
> [Severity: Medium]
>
> Preserving asymmetric queue counts while lowering num_napi also seems to
> make a state reachable that fbnic's own setter rejects.  Before this
> change, fbnic_reset_queues() clamped both queue counts to max_napis and
> then set num_napi =3D max(tx, rx), so num_napi >=3D num_rx_queues always =
held
> after resume.
>
> Now consider rx_count=3D4, combined_count=3D4 set while max_napis >=3D 8,=
 so
> num_rx_queues=3D8, num_tx_queues=3D4, num_napi=3D8.  If resume gets only =
4 NAPI
> IRQs, num_napi =3D min(8, 4) =3D 4, and fbnic_get_channels() takes this
> branch:
>
> 	if (fbn->num_rx_queues > fbn->num_napi ||
> 	    fbn->num_tx_queues > fbn->num_napi)
> 		ch->combined_count =3D min(fbn->num_rx_queues,
> 					 fbn->num_tx_queues);
> 	...
> 	ch->rx_count =3D fbn->num_rx_queues - ch->combined_count;
> 	ch->tx_count =3D fbn->num_tx_queues - ch->combined_count;
>
> reporting combined=3D4, rx=3D4, tx=3D0, i.e. 8 channels while only 4 NAPI
> vectors exist.  Feeding those same values back to fbnic_set_channels()
> hits:
>
> 	    (standalone && standalone + ch->combined_count > max_napis) ||
>
> with 4 + 4 > 4 and returns -EINVAL.  Is it intended that ethtool -l output
> can no longer be replayed through ethtool -L after such a resume, and that
> it describes more channels than there are vectors?
>
> One more observation outside the diff, in fbnic_alloc_qt_page_pools() in
> drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:

Hmm, the resume path does indeed need some more thinking. I'll spin a v2
of this patch!

> [Severity: High]
>
> This is a pre-existing issue and not something this patch changes, but for
> an Rx queue with an unreadable memory provider bound, the header pool is
> stored in qt->sub0.page_pool and the local pp is then reused for the
> payload pool.  When the second page_pool_create() fails, the error label
> is reached with pp holding the ERR_PTR:
>
> 	err_destroy_sub0:
> 		page_pool_destroy(pp);
> 		return PTR_ERR(pp);
>
> page_pool_destroy() only checks for NULL:
>
> 	void page_pool_destroy(struct page_pool *pool)
> 	{
> 		if (!pool)
> 			return;
>
> 		if (!page_pool_put(pool))
> 			return;
>
> so does this dereference the error pointer in page_pool_put()?  And does
> the label also leak the header pool in qt->sub0.page_pool, which is never
> destroyed here?  Should the label destroy qt->sub0.page_pool while still
> returning PTR_ERR(pp)?

Yes. This has been fixed by:
  https://lore.kernel.org/netdev/20260915104917.3978113-1-bjorn@kernel.org/


Bj=C3=B6rn
