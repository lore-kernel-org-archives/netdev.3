Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156B3C768E;
	Sat, 17 Oct 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264097; cv=none; b=kC9vnJYaRXVU8HlJQF3Lb81Wv2DHy3l0bNSJrykgAwNiOujbM4iOA35MPh0cJs2OMGHDpOO8vehbk9xTS1lLsBVnxXLl0HMgx9+5bkLuMoHnZ5scuy2/uiz44n1qGSa56qXBwqGKiF7Le5z1H87aNQHw0oph9czdRIv6r1nXDJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264097; c=relaxed/simple;
	bh=MHufg2o2vE24k/APqbB86dLhqQh5nSL5BI2wZvREWnM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHYPQ8+KmGfukI1rnPH//FXGZQSlfppQSWTqROnBNDyAL2YDNXqcCiaVo7h5XPbN5K+V3LY4fYd/HI92lr0OTVUy9sanOFGPiF7nsn7v4dogJgvyvd44DuOqBF+LndHBrSijLhxxl/GZy7lA8jzDBFq9fRhnTpS6jm4hfwWzzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkN60NM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkN60NM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535B61F000C5;
	Sat, 17 Oct 2026 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264096;
	bh=G/mOIqQ3KkbcwE/6BIg7vmmDag5v4XqH8R1sc966Lps=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kkN60NM6LHUl0O+kDpN1UewsNK9q3AInYj1j6nMVzSrMU4G3OBgoFh0teHGAdNgsG
	 9C30Vf9HUOmz+sca9zzsxt0y/UchJd7ozda1rHshj5nYOOumJLTgK5waT6W9/ZNt/Z
	 Y6zezo0yKxHLorhKxwhCPPYCl/UeL5pgoBFP6agMngS0xQguYae9LDQ6AH1wzqvzka
	 92IGqVf3N/xgwL+Zn0Vz34kYRSTLlrKyBpkDcFN3m4IGLzpgVp6M+uxyKYe+i6Gt4v
	 nn7eNVySPYJjOtTfetuGf1i5d+jFGfuPTOxWV66eNwAepBkQ6i3PVjIQkIeea2zYd6
	 Mqqlvzw6aJqfA==
Subject: Re: [PATCH net-next v5 5/9] ibmveth: release the pool kobjects when
 probe fails
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, tlfalcon@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, zdai@us.ibm.com, pradeeps@linux.vnet.ibm.com,
 ksiva@linux.vnet.ibm.com
Date: Sat, 17 Oct 2026 19:08:14 +0000
Message-ID: <179226409492.3135.9899803798328301877@kernel.org>
In-Reply-To: <20261013182926.30417-6-mmc@linux.ibm.com>
References: <20261013182926.30417-6-mmc@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] kobject: module unload race causing execution-after-free

--

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1890,6 +1890,40 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>  	.ndo_features_check	= ibmveth_features_check,
>  };
>  
> +/**
> + * ibmveth_pool_kobj_release - Mark a pool kobject finished
> + * @kobj: kobject embedded in the pool
> + *
> + * The pool kobjects live in netdev_priv(), so the last put must wait
> + * for this before free_netdev().
> + */
> +static void ibmveth_pool_kobj_release(struct kobject *kobj)
> +{
> +	struct ibmveth_buff_pool *pool = container_of(kobj,
> +						      struct ibmveth_buff_pool,
> +						      kobj);
> +
> +	complete(&pool->released);
> +}
> +
> +/**
> + * ibmveth_put_pool_kobjs - Drop the pool kobjects and wait for release
> + * @adapter: ibmveth adapter
> + *
> + * With CONFIG_DEBUG_KOBJECT_RELEASE the cleanup, including removing the
> + * sysfs files, runs later from a work item in the kobject; wait for it
> + * so free_netdev() cannot free the pools first.
> + */
> +static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter)
> +{
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> +		kobject_put(&adapter->rx_buff_pool[i].kobj);
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> +		wait_for_completion(&adapter->rx_buff_pool[i].released);
> +}
> +
>  static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  {
>  	int rc, i, mac_len;

[Severity: High]
With CONFIG_DEBUG_KOBJECT_RELEASE, ibmveth_pool_kobj_release() runs
from the kobject's delayed release work, not from kobject_put(). The
complete(&pool->released) here wakes ibmveth_put_pool_kobjs() in
ibmveth_remove(). Remove can then return and let
vio_unregister_driver() and the module unload finish while the worker
is still inside ibmveth_pool_kobj_release(), on its way back from
complete(). That CPU then executes freed module text. So rmmod can
oops in exactly the configuration this v2 was meant to make safe.

Signalling a completion from module code does not by itself prove the
signaller has left the module; that is why kthread_complete_and_exit()
exists.

Waiting in remove() for the final put is also not how kobject lifetime
is meant to work. release() should free the containing object rather
than hand it back to someone blocked on it.

Would it be simpler to drop the separate pool kobjects and create the
pool%d directories as named attribute groups on dev->dev.kobj? Then
nothing with its own refcount lives in netdev_priv(). The trade-off is
that veth_pool_show() and veth_pool_store() would need another way to
find the pool than container_of() on the kobject. How do you want to
handle this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013182926.30417-1-mmc%40linux.ibm.com
