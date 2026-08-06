Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23833515DB
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041438; cv=none; b=QqVRkVMDz3CfmU8KfVlLZnt1NwOQnDaDyPGs4je4KwUUryA34uskRikY5bSsDA3rqYHS+P5NylV3TEO5ONah0tqZ4eUAsjB81lLcT8TcQCA225PzOwwIxkDh5H+mT/xpx8+sS0Gaf40L8FYokeoSpf/d7PAFYFfurNvqs7VeyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041438; c=relaxed/simple;
	bh=hmzfqHA/5kxJYR6KXAapoOm5nPO64sSNJ3LGTFoKPZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjvqpdnN+uZJlO3kuv2cLmWNA5jL2+MgiCTq+xVpU7PqCtNogOrTPp3ds9sUw5dp24lNyiYOSJSRJ3P8oVbfR6MyvDELoQL0/mPA/OqXXTVSEnTviMiKzJjpT6jPV/YeaHU7OiveD5QrBgqPUTLDBZTuRcjJt7Q+Tzbp42tH6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYyNy6g/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYyNy6g/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC241F00A3F;
	Thu,  6 Aug 2026 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041431;
	bh=vrnW8xdKOW/hhiBr97d5RmlyHFSHG2wySPLHv+SNioU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYyNy6g/aCJn4hIoA95gJVAM8Co0TeaOEItLF3u47w2ZW9bkGahS1sTBmgE0PTa7b
	 UAa2+m41NiDXW7jM2PoeztlyFStTy4mo1aE04+RUrkmkW/UbfTWfp6+Xb6hyQrR2m5
	 gWRGZO9xGPcoB8MArVbPql8Rv6/XvnNzEqKEp+mfv3TYdw4Yeb7KrlPYi/iqWiTr1I
	 9qcFCDV093tOZNi30TAvka092HBK6OmKWXDyw5lNkzi1w0Un2lUp0y7h98qziAcUse
	 c9+I5xzfVnCLXnwvDvYCUDsxRa9ShwWiUwb0pqPkg5umoqKY2IqUxP6TLs+ZA3b5ba
	 NQwOB/M8f2IcQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	simon.horman@corigine.com,
	shaik.abdulla1@ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v4 11/14] ibmveth: Expose per-queue buffer pool details via debugfs
Date: Thu,  6 Aug 2026 11:37:10 -0700
Message-ID: <20260806183710.3175754-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <fa6f1b5f19acd2b54f6b2c19d27bd79f4ff60599.1785457143.git.mmc@linux.ibm.com>
References: <fa6f1b5f19acd2b54f6b2c19d27bd79f4ff60599.1785457143.git.mmc@linux.ibm.com>
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
ibmveth: Expose per-queue buffer pool details via debugfs

This adds a read-only buffer_pools debugfs file that dumps size,
buff_size, active and available for every RX queue and buffer pool, and
wires creation into ibmveth_probe() and teardown into ibmveth_remove().
The existing queue-0 poolN sysfs files are left unchanged.

A few questions about the new code below.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index dbb47a42b4cb5..db13747466025 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -2985,6 +2986,44 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>  #endif
>  };
>  
> +static int ibmveth_buffer_pools_show(struct seq_file *m, void *v)
> +{
> +	struct ibmveth_adapter *adapter = m->private;
> +	int i, j;
> +
> +	seq_puts(m, "Queue  Pool  Size  BuffSize  Active  Available\n");
> +	seq_puts(m, "-----  ----  ----  --------  ------  ---------\n");
> +
> +	for (i = 0; i < adapter->num_rx_queues; i++) {
> +		for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
> +			struct ibmveth_buff_pool *pool =
> +				&adapter->rx_buff_pool[i][j];

[Severity: Low]
Should this dump be taken under rtnl_lock()?

ibmveth_buffer_pools_show() reads adapter->num_rx_queues plus
pool->size, pool->buff_size, pool->active and pool->available with no
lock held, but every writer of those fields runs under RTNL:

veth_pool_store() {
	...
	rtnl_lock();
	...
	pool->active = newactive;
	pool->buff_size = newbuff_size;
	pool->size = newsize;
	...
	/* on ibmveth_open() failure, the same three fields are
	 * written back with the old values */
			pool->active = oldactive;
			pool->buff_size = oldbuff_size;
			pool->size = oldsize;
	...
}

ibmveth_alloc_buffer_pools() likewise copies the queue-0 geometry into
queues 1..N-1 field by field under RTNL from ibmveth_open(), and the
reset path goes through dev_close()/dev_open() under rtnl_lock().

Can a concurrent read of buffer_pools therefore print a torn snapshot,
for example active=1 paired with the previous size/buff_size, or a
half-copied per-queue template, or the transient rollback state that was
never an actual configuration?

There does not appear to be a memory-safety consequence here, since
rx_buff_pool[] is a fixed-size array embedded in struct ibmveth_adapter
and only scalar members are read, so the concern is limited to the
values printed.

> +
> +			seq_printf(m, "%5d  %4d  %4u  %8u  %6d  %9d\n",
> +				   i, j, pool->size, pool->buff_size,
> +				   pool->active,
> +				   atomic_read(&pool->available));

[Severity: Low]
Are Active and Available meaningful while the interface is down?

ibmveth_free_buffer_pool() frees free_map, unmaps and frees all
skbuffs, and frees dma_addr/skbuff, but leaves pool->active set and
never decrements pool->available:

	kfree(pool->free_map);
	pool->free_map = NULL;
	...
	if (pool->skbuff) {
		kfree(pool->skbuff);
		pool->skbuff = NULL;
	}
	/* pool->active and pool->available untouched */

available is only cleared later, in ibmveth_alloc_buffer_pool() via
atomic_set(&pool->available, 0) on the next open.

So a read after ibmveth_close() -> ibmveth_free_buffer_pools() ->
ibmveth_free_queue_buffer_pools() -> ibmveth_free_buffer_pool() reports
every configured pool as Active=1 with the last non-zero Available,
even though the skbuffs and DMA mappings are gone.

Related: for queues 1..N-1 the table prints all-zero rows before the
first open, because the queue-0 template is only copied into those
queues inside ibmveth_alloc_buffer_pools() during open.

The commit message says "Per-queue runtime pressure is what debugfs
shows" - could the down/uninitialized cases be either reflected in the
output or documented?

> +		}
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ibmveth_buffer_pools);
> +
> +static void ibmveth_debugfs_init(struct ibmveth_adapter *adapter)
> +{
> +	adapter->debugfs_dir = debugfs_create_dir(adapter->netdev->name,
> +						  NULL);
> +	debugfs_create_file("buffer_pools", 0400, adapter->debugfs_dir,
> +			    adapter, &ibmveth_buffer_pools_fops);
> +}

[Severity: Medium]
Is the mutable interface name a safe key for a directory created
directly in the debugfs root?

Three separate things follow from passing NULL as the parent and
netdev->name as the name.

First, the name goes stale. The directory is created once, as the last
statement of ibmveth_probe(), and the driver installs no netdev
notifier and never calls debugfs_rename(). After the udev/systemd
predictable-name rename that happens right after register_netdev(), or
after any later ip link set dev ethN name foo, does the debugfs
directory keep the obsolete name for the lifetime of the device?

Second, with the debugfs root as parent the name has to be globally
unique there. Consider the sequence: first adapter probes as eth0, udev
renames it to enP1p1s0, a second ibmveth adapter probes and
alloc_etherdev_mqs() names it eth0 again because eth0 is free in the
netdev namespace. debugfs_create_dir("eth0", NULL) then collides with
the first adapter's stale directory:

fs/debugfs/inode.c:debugfs_start_creating() {
	...
	dentry = simple_start_creating(parent, name);
	if (IS_ERR(dentry)) {
		if (dentry == ERR_PTR(-EEXIST))
			pr_err("'%s' already exists in '%pd'\n", name, parent);
	...
}

The ERR_PTR is stored in adapter->debugfs_dir and handed to
debugfs_create_file() as the parent, which returns immediately:

fs/debugfs/inode.c:debugfs_start_creating() {
	...
	if (IS_ERR(parent))
		return parent;
	...
}

Does the second and every subsequent adapter then end up with no
buffer_pools file at all, with only that debugfs pr_err as an
indication?

Third, netdev->name is read here after register_netdev() has published
the device, without rtnl_lock(), while dev_change_name() rewrites
net_device->name under RTNL. Can the string handed to
debugfs_create_dir() be a partially updated name?

Would a driver-owned parent directory plus a stable identifier such as
dev_name(&dev->dev) avoid all three?

> +
> +static void ibmveth_debugfs_exit(struct ibmveth_adapter *adapter)
> +{
> +	debugfs_remove_recursive(adapter->debugfs_dir);
> +	adapter->debugfs_dir = NULL;
> +}
> +
>  static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter,
>  				  int pools_ready)
>  {
> @@ -3182,6 +3221,8 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	netdev_dbg(netdev, "registered\n");
>  
> +	ibmveth_debugfs_init(adapter);
> +
>  	return 0;
>  }

[ ... ]

Cross-instance finding from sashiko-gemini (b6bfc50872782421f7178a42615ea39fe861918e607d995ed830a5a2db8a4460):
[Severity: Medium]
Addition of driver-private ethtool -S strings for standard queue statistics.
