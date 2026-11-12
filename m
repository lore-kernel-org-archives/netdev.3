Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527826;
	b=PZtK2geZxezMKuzr2ZdH7B1m2mdp1kyg1AiYUD0ofIhhKD9/VqZ7cRUbK5Fn4auMoGW/
	 MtxwdDUJKXec+B/8uoTd9i//ZsCxeAVVGG/XcqKVPTmn5+XXgf5qo4JFd1S9DLH/ej1dj
	 FAJzcpc+3v0DuiSxKv5aPJFOgy34Bd38Gxne33zJdux2BWUThTRlNJ/vYrNa7nJPBJu3O
	 BJ9Xrd3/ux9G+MNu8rFPkJfeRs5Lo5e+8vUW8DGgtmlWAL31rd7BasZT7f8xm8RCUaOT6
	 3NOHqz9dUrR3tYtgdUEmWOqJtpzHATC0us7U95GjbeKIa1eDRRUIPUl4TLy0MuvdBkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527826;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fwYFJEU3UzEa1aJ7yISbbu1qTMSdxI2yoZ1REmgZap4=;
	b=FfgQ4xCR6503PhXFobUldUGX8/lF8hP/Cp2tsxwSIUkF9us7J2mdWFnrw4c5EAQ5f3By
	 S7+MQvbIuidNjq8dUh8LCU5Q08fxvMgPpQIcdSLLKoywVMaAvnpxE6EPdMIfIeXDRdl1u
	 2mQA+jgibl2ZuyT58lcvlpVynRg1A+sAXmuYjCWGZE7mQyzCIelzZRLNaSRMEPFupOjKG
	 Srsoy4jix+mhJuBn9pCrOKqvobt2vBl9Fg61sbL3EOourTeXUo43rnIZwUzGTDKQUlXcJ
	 WBmjFLsbf4ANCWi8z2D5C5L9JJ+d6CnfFsieSj495i51JRKo0vSjMfCGgQ9df5MRVpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fY9JYmd7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A6606A891
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fY9JYmd7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAF71F000C6;
	Thu, 12 Nov 2026 23:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527826;
	bh=fwYFJEU3UzEa1aJ7yISbbu1qTMSdxI2yoZ1REmgZap4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fY9JYmd7XnAhdwW3mlJs6PW5QbwioFdugMBDEDaOqWN3Jxs5933L0ZmD6H0FKCIDp
	 zFMBWRBFWxkNKbmEs7GajPBi2q8mFzoJo9u31QsUk7WvEjWAbg402F10vKPQKof85j
	 PAWdipG2Pc1ESQS6CBIU1DloeqKM1KCDtwCQUvDME9OxSlVUyQzdYg8QcRiHZOMfTM
	 SpWMM/SU4qDCqAVtyiBrq/F2Jlbp3IgRo6B8CO1zD7a+ST/PoZQlJN7/PF6ziPO+Tp
	 MA2KyjC+IJWaL4+Fux3/jAZgrLugvrTotwn1L9294UygMR6eWSwcDjN5PvY5r89NDh
	 BsdGtmUTBHJCg==
Subject:
 Re: [PATCH net-next v8 07/15] ibmveth: Add RX queue register helpers for MQ
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
Date: Thu, 12 Nov 2026 23:57:04 +0000
Message-ID: <179452782438.2199510.12943082355356211419@kernel.org>
In-Reply-To: <20261109235556.60604-8-mmc@linux.ibm.com>
References: <20261109235556.60604-8-mmc@linux.ibm.com>
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

- [Low] The patch's version notes do not match the code.
- [Low] The v8 notes say ibmveth_register_logical_lan() was changed to
  return `long`, 'the hypercall status type', but the callers convert…

--

ibmveth: Add RX queue register helpers for MQ

This commit moves queue 0 logical LAN registration and teardown out of
ibmveth_open() and ibmveth_close() into ibmveth_register_logical_lan(),
ibmveth_register_rx_queues() and ibmveth_free_all_queues(), and adds a
queue_registered[] flag next to queue_handle[]. It also moves buffer pool
allocation in open() ahead of PHYP registration and calls
netif_set_real_num_rx_queues() after registration.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index cab895cc970c5..e2aa108655676 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1335,10 +1335,31 @@ static void ibmveth_free_tx_resources(struct ibmveth_adapter *adapter)

[ ... ]

> +static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
> +					 union ibmveth_buf_desc rxq_desc,
> +					 u64 mac_address)
> +{
> +	long rc;

[ ... ]

> @@ -1362,14 +1398,97 @@ static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,

[ ... ]

> +static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
> +{
> +	unsigned long lpar_rc;
> +	int i;
> +
> +	netdev_dbg(adapter->netdev, "freeing all RX queues at once\n");
> +
> +	do {
> +		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> +	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> +
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(adapter->netdev,
> +			   "h_free_logical_lan failed: %ld\n", lpar_rc);
> +	}

[ ... ]

> +static int
> +ibmveth_register_rx_queues(struct ibmveth_adapter *adapter, u64 mac_address)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	union ibmveth_buf_desc rxq_desc;
> +	unsigned long lpar_rc;
> +	int rc;

[ ... ]

> +	lpar_rc = ibmveth_register_logical_lan(adapter, rxq_desc, mac_address);
> +	if (lpar_rc != H_SUCCESS) {
> +		netdev_err(netdev,
> +			   "h_register_logical_lan failed: %ld\n", lpar_rc);

[Severity: Low]
This isn't a bug, but the v8 changelog says:

  - ibmveth_register_logical_lan() returns long, the hypercall status
    type

ibmveth_register_rx_queues() stores that long return value in an
unsigned long lpar_rc and prints it with %ld.

ibmveth_free_all_queues() does the same with the return value of
h_free_logical_lan(). The close() code it replaces declared that local
as long lpar_rc.

PAPR H_* error codes are negative (H_PARAMETER is -4, for example). The
printed value only comes out right because varargs pass the same bits,
and the default -Wformat does not check signedness.

Should both locals be declared long so the status stays signed?

[ ... ]

> @@ -1480,15 +1597,7 @@ static int ibmveth_close(struct net_device *netdev)
>  
>  	ibmveth_cleanup_rx_interrupts(adapter);
>  
> -	/* Full LAN teardown (subordinates arrive with register helpers). */
> -	do {
> -		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
> -	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
> -	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(adapter->netdev,
> -			   "h_free_logical_lan failed with %lx, continuing\n",
> -			   lpar_rc);
> -	}
> +	ibmveth_free_all_queues(adapter);
>  	ibmveth_update_rx_no_buffer(adapter);

[Severity: Low]
This isn't a bug, but the per-version notes don't match the code here.
The v5 notes say:

  - Call out close() update_rx_no_buffer() before free_lan as intentional
    last-glimpse accounting while the LAN is still registered (order
    already in v4; v4 step list omitted it)

In ibmveth_close(), ibmveth_free_all_queues() issues H_FREE_LOGICAL_LAN
first, and ibmveth_update_rx_no_buffer() runs after it. So the
no-buffer counter is read after the LAN has been freed, not while it is
still registered.

The pre-patch close() used the same order, so behaviour is unchanged.
The note just describes an ordering the code does not follow.

The v6 notes also say:

  This patch no longer touches ibmveth.h

However, v8 adds queue_registered[] to struct ibmveth_adapter in
drivers/net/ethernet/ibm/ibmveth.h.

Could these notes be updated to match the code?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235556.60604-1-mmc%40linux.ibm.com
