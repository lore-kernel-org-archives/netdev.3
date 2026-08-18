Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10583266B72
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017659; cv=none; b=g+5LtgtgSMp7gWuEcGuqxXsw4lR40haX2KgqDrvbVXbuyuu7SgEbueG+otkhNvM3V1Jsn0Zwne7UCGwyOPHFTbDXEFxPnxVPbgReSPNX0Lg0uEZY4va6SXQ/nteUs+xc32wtrhZ+8AYk4MkJzFISZtVI47FWX2oksWWwgQn94/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017659; c=relaxed/simple;
	bh=f44M/JpNEwX7a45VvSc0eLiP8OAnIp7D2Fj6b2Ntalk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIQ1J5s0gyQIdMlkPR0i8P8WK51pRMysYP5qOqYkqgwEwXJcrXSlX9r2W9gNfC9zFpFsdnE4SJWDAtV4tO0ZWdhhxkidK56hdAc46U1U+dPOinezNK1ubzUlBANEu0u1LDokbI9J2x7RLo0aGIBWPBFZDhtK6OC6wC5WL/3IBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx3kQn3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx3kQn3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EE81F00A3A;
	Tue, 18 Aug 2026 01:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017657;
	bh=VVaUVmUpb6R5CYbhcJ85vT6RMPIxmI+11IqYWOKvGUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xx3kQn3+AWHxPSId3ChNQ8pkuTvgRMtpNhNL0v3enS6grT6IxlFD1ARJSderfxPPT
	 qpXrKWN05SSyL05Q4PYv84sI2yH5//k0QvgfxOGDgbnFMee8gB1hAX0GJWR2/HPvLC
	 N1nlx7JMYBdOY8m+ttWnlTX35W00fG/l30RN4xkxtvw65CW42KWms9oVwXrJeazSPD
	 eWcMJ1LrTMPYcNFelsYf/dGsI3gi/iF25I56tyT9Imu+KCJ3KOBublF0vrUiFcjmp7
	 nAp/fwj6qYDUSx+N3womfhqTjUCeTGxg0M61bIEQRqbN/D/uJ01scC0my6DEd4mHnO
	 4I6siuAB105/Q==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	nnac123@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	davemarq@linux.ibm.com,
	bjking1@linux.ibm.com,
	shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v5 13/15] ibmveth: Expose per-queue buffer pool details via debugfs
Date: Mon, 17 Aug 2026 18:47:36 -0700
Message-ID: <20260818014736.3854433-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814073642.24630-14-mmc@linux.ibm.com>
References: <20260814073642.24630-14-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Expose per-queue buffer pool details via debugfs

This adds a read-only buffer_pools file under
/sys/kernel/debug/ibmveth/<dev_name>/ that dumps size, buff_size, active
and available for every RX queue and buffer pool.  The per-adapter
directory lives under a driver-owned root created lazily from
ibmveth_probe(), and the historical queue-0 poolN sysfs attributes are
left untouched.

A few questions below about the dumped values and about the lazy creation
of the driver root.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 5d4ca4b3d3d07..1b58a3c6ce77a 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -3421,6 +3422,68 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>  #endif
>  };
>  
> +static int ibmveth_buffer_pools_show(struct seq_file *m, void *v)
> +{
> +	struct ibmveth_adapter *adapter = m->private;
> +	int i, j;
> +
> +	/*
> +	 * Writers (veth_pool_store, open template copy, reset close/open)
> +	 * update these fields under RTNL. Take the same lock so the dump
> +	 * is not a torn scalar snapshot. Not required for
> +	 * memory safety — embedded arrays only.
> +	 */
> +	rtnl_lock();

[Severity: Low]

Is this comment accurate for all of the dumped fields?  It says the
writers of "these fields" run under RTNL, but pool->available is also
printed here and is updated from the NAPI/softirq RX path:

ibmveth_replenish_buffer_pool()
	atomic_add(buffers_added, &(pool->available));

ibmveth_remove_buffer_from_pool()
	atomic_dec(&adapter->rx_buff_pool[queue_index][pool].available);

The second one runs under the per-queue replenish_lock, as its own
kernel-doc describes, and neither takes RTNL.

So rtnl_lock() does not serialize the Available column against the
geometry columns; only atomic_read() keeps that value from tearing.

Could the comment scope the RTNL claim to the geometry/active fields and
say that available is merely read atomically?  As written, a later change
that adds a non-atomic read of a NAPI-updated pool field under this
rtnl_lock() would look safe when it is not.

> +
> +	seq_puts(m, "Queue  Pool  Size  BuffSize  Active  Available\n");
> +	seq_puts(m, "-----  ----  ----  --------  ------  ---------\n");

[Severity: Low]

This isn't a bug, but does the "Size" column name collide with the
existing poolN sysfs naming, with the opposite meaning?

The debugfs table prints pool->size (a buffer count) under "Size" and
pool->buff_size (bytes per buffer) under "BuffSize", while veth_pool_show()
maps the attributes the other way around:

	else if (attr == &veth_num_attr)
		return sprintf(buf, "%d\n", pool->size);
	else if (attr == &veth_size_attr)
		return sprintf(buf, "%d\n", pool->buff_size);

veth_pool_store() confirms this by range checking the size attribute
against IBMVETH_MAX_BUF_SIZE and num against IBMVETH_MAX_POOL_COUNT.

So "size" means a count in debugfs and a byte length in sysfs for the same
pool objects.  Would naming the column "Count" or "Num" avoid that?

> +	if (!adapter->opened)
> +		seq_puts(m, "# down: Active/Available 0 unless allocated\n");
> +
> +	for (i = 0; i < ibmveth_get_num_rx_queues(adapter); i++) {
> +		for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
> +			struct ibmveth_buff_pool *pool =
> +				&adapter->rx_buff_pool[i][j];

[Severity: Low]

Can the Size/BuffSize columns print zero or stale values for queues
1..N here?

ibmveth_probe() publishes the queue count up front:

	ibmveth_publish_num_rx_queues(adapter,
				      min(num_online_cpus(),
					  IBMVETH_DEFAULT_QUEUES));

but only initializes the queue-0 pools with
ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], ...).  The copy to
the other queues happens later, in ibmveth_alloc_buffer_pools():

	/* Initialize pool metadata for queues 1..N from queue 0 settings */
	for (q = 1; q < ibmveth_get_num_rx_queues(adapter); q++) {

Reading buffer_pools before the first open therefore prints rows with
i > 0 showing Size 0 and BuffSize 0.

After an open/close cycle there is a second case: veth_pool_store() while
the device is down updates only the queue-0 pool and skips the reopen:

		pool->active = newactive;
		pool->buff_size = newbuff_size;
		pool->size = newsize;

		if (netif_running(netdev)) {
			rc = ibmveth_open(netdev);

so queues 1..N keep the old geometry and the dump disagrees with queue 0.

The only hint emitted is "# down: Active/Available 0 unless allocated",
which covers just those two columns.  Should the note also cover
Size/BuffSize for not-yet-templated queues, or should untemplated rows be
skipped?

> +			bool live = pool->skbuff && pool->free_map;
> +			int active = live ? pool->active : 0;

[Severity: Low]

Does the "Active" column here report something different from the
identically named sysfs attribute and ethtool statistic?

ibmveth_free_buffer_pool() deliberately keeps pool->active set when the
allocation goes away:

	 * Keep probe/sysfs geometry (active, size, buff_size, threshold).
	 * Clearing active here was a v3 ifdown/up regression: open skips
	 * !active pools, so reopen posted no RX buffers

while both existing surfaces print the raw flag:

veth_pool_show()
	if (attr == &veth_active_attr)
		return sprintf(buf, "%d\n", pool->active);

ibmveth_get_ethtool_stats()
	data[i++] = adapter->rx_buff_pool[0][j].active;

With the interface down, .../pool0/active and poolN_active read 1 while
buffer_pools shows Active 0 for the same pool.  Would a separate column
name such as "Alloc" or "Live" avoid overloading the existing meaning of
"active"?

The commit message says the file "lists size, buff_size, active, and
available for every RX queue and buffer pool" without mentioning that the
Active column is really an allocation indicator; only the stripped v5
changelog notes it.  Could the commit message state that?

> +			int available = live ? atomic_read(&pool->available)
> +					     : 0;
> +
> +			seq_printf(m, "%5d  %4d  %4u  %8u  %6d  %9d\n",
> +				   i, j, pool->size, pool->buff_size,
> +				   active, available);
> +		}
> +	}
> +
> +	rtnl_unlock();
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ibmveth_buffer_pools);
> +
> +/* Driver-owned root so per-adapter dirs use a stable vio name, not the
> + * mutable netdev->name (avoids stale names / eth0 collisions after rename).
> + */
> +static struct dentry *ibmveth_dbg_root;
> +
> +static void ibmveth_debugfs_init(struct ibmveth_adapter *adapter)
> +{
> +	if (!ibmveth_dbg_root)
> +		ibmveth_dbg_root =
> +			debugfs_create_dir(ibmveth_driver_name, NULL);
> +
> +	adapter->debugfs_dir =
> +		debugfs_create_dir(dev_name(&adapter->vdev->dev),
> +				   ibmveth_dbg_root);
> +	debugfs_create_file("buffer_pools", 0400, adapter->debugfs_dir,
> +			    adapter, &ibmveth_buffer_pools_fops);
> +}

[Severity: Medium]

Is this test-then-assign of ibmveth_dbg_root safe against concurrent
probes?  ibmveth_debugfs_init() is called once per device from
ibmveth_probe(), and probe of two different vio devices is serialized only
by the per-device device_lock, so a DLPAR IO add racing with another add
(or with driver_attach during module load) can have both threads observe
NULL:

CPU0                             CPU1
if (!ibmveth_dbg_root)           if (!ibmveth_dbg_root)
   debugfs_create_dir("ibmveth")    debugfs_create_dir("ibmveth")
   -> valid dentry                  -> ERR_PTR(-EEXIST)
ibmveth_dbg_root = dentry
                                 ibmveth_dbg_root = ERR_PTR(-EEXIST)

fs/debugfs/inode.c returns ERR_PTR(-EEXIST) for the duplicate name
(debugfs_start_creating() -> simple_start_creating() with LOOKUP_EXCL,
then the dentry == ERR_PTR(-EEXIST) branch), and an ERR_PTR parent is
passed straight back out:

	if (IS_ERR(parent))
		return parent;

So after the race, every later per-adapter directory and buffer_pools file
is created with an ERR_PTR parent and silently fails, and the handle to the
real "ibmveth" directory is gone.

Would creating the root once in ibmveth_module_init(), before any probe can
run, avoid this?

> +
> +static void ibmveth_debugfs_exit(struct ibmveth_adapter *adapter)
> +{
> +	debugfs_remove_recursive(adapter->debugfs_dir);
> +	adapter->debugfs_dir = NULL;
> +}
> +
>  static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>  				   int pools_ready)
>  {
> @@ -3647,6 +3710,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	netdev_dbg(netdev, "registered\n");
>  
> +	ibmveth_debugfs_init(adapter);
> +
>  	return 0;
>  }
>  

[ ... ]

> @@ -3891,6 +3958,8 @@ static int __init ibmveth_module_init(void)
>  static void __exit ibmveth_module_exit(void)
>  {
>  	vio_unregister_driver(&ibmveth_driver);
> +	debugfs_remove_recursive(ibmveth_dbg_root);
> +	ibmveth_dbg_root = NULL;
>  }

[Severity: Medium]

Following on from the probe race above, does this leak the "ibmveth"
directory?  If ibmveth_dbg_root holds ERR_PTR(-EEXIST),
debugfs_remove_recursive() returns immediately for IS_ERR_OR_NULL, so the
real directory and the simple_pin_fs reference it holds survive module
unload, and a later module load hits -EEXIST for the root every time.
