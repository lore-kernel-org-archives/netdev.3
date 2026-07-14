Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D75445ACE
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034112; cv=none; b=k5824K++4dQCi60CpJKnZ6OdCFhQU8e2BzsFYZFEc+cc03+Zrad50XysZbZ0atp9JhCa2xKiB0S6snZkFhJf1I/E91JEBAg8POP57Q+tJfui6z18zmO7ZoY/y8Hpdl+qEITnlnCzw24u4JqS8Ozu1vly9YoM3m/CtCRmFsjOpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034112; c=relaxed/simple;
	bh=XVK4wpFI0o2wfF2WagOX0ZVMVCeCmxfL2BsKKQzCfz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfyuUOi4nknXjiNPUnBg5CZMPHubgtmHajk+TRCq6XFSbc4QmDM/S0ofQxfVklxwn+We8kIdOLFHg00LI2U4EPNsvGC/tEt//0KLUqUCHOSkDrOUIxFC7IYztK7rpotNaZLYRtUVsnp8P1OnPlIMNDlzhU690z2Af4g8B+PaMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVBpMtSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVBpMtSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415DA1F00A3A;
	Tue, 14 Jul 2026 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034111;
	bh=PpTc1tqm/ZkWGVvlR4jp+OG8RxeNyx3F423/n9iys6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NVBpMtSu1vnKRKSwNtd8UALzvMUIB9fIS5OfRv2TRQBbHJPO4m9WGHvmaOyNbrbBo
	 XIc6e6Hy6TBiNeyTiAyWGTn+t+x+ylfokhOn+Y69ZJpGNEppAJ//XgYeMIDS5Y6uQr
	 UM8ZWfputmnuHWHoqeHNNwIYJMz5wcp/ru6tPOFqT7A9TVhjzBdRpWE7nTI4/Ou+Pm
	 goREmc5DK37o/46f5TSip4pU/A5xwDca43YJSv/2pvmBhSJ6Eu3mP44J7LxO+2seJL
	 KuZvg8hYUXuA2ITEewO1xm/7LOqUBOq2bo/3QVdZ/AuQ08pZu3d/dbeCu3MavUhurG
	 /1kQezOF9z98A==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 12/15] ibmveth: Expose per-queue buffer pool details via sysfs
Date: Tue, 14 Jul 2026 14:01:42 +0100
Message-ID: <20260714130142.1841365-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-13-mmc@linux.ibm.com>
References: <20260706193603.8039-13-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Expose per-queue buffer pool details via sysfs

This commit adds a read-only sysfs attribute buffer_pools to the VIO device
to expose per-queue buffer pool details dynamically. It outputs runtime per-queue
buffer pressure metrics like size, active, and available buffers.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 4e3f49b6346fd..ecc472ee8f71f 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -2896,6 +2896,52 @@ static const struct net_device_ops ibmveth_netdev_ops = {
[ ... ]
> +static ssize_t buffer_pools_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct net_device *netdev = dev_get_drvdata(dev);
> +	struct ibmveth_adapter *adapter = netdev_priv(netdev);
> +	int len = 0;
> +	int i, j;
> +
> +	len += scnprintf(buf + len, PAGE_SIZE - len,
> +			 "Queue  Pool  Size  BuffSize  Active  Available\n");
> +	len += scnprintf(buf + len, PAGE_SIZE - len,
> +			 "-----  ----  ----  --------  ------  ---------\n");

[Severity: Medium]
Does this buffer_pools_show() implementation violate the sysfs "one value
per file" design rule? 

The attribute appears to dump a complex, multi-line ASCII table with headers
and columns rather than exposing a single value per sysfs file.

[ ... ]
> @@ -3056,6 +3102,14 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  
>  	netdev_dbg(netdev, "registered\n");
>  
> +	rc = sysfs_create_group(&dev->dev.kobj, &ibmveth_attr_group);
> +	if (rc) {
> +		netdev_err(netdev, "failed to create sysfs attributes rc=%d\n", rc);
> +		unregister_netdev(netdev);
> +		free_netdev(netdev);
> +		return rc;
> +	}

[Severity: High]
If userspace brings up the interface immediately after register_netdev()
succeeds, could adapter->work be scheduled before sysfs_create_group() fails?

If this race occurs, unregister_netdev() does not synchronously cancel the
work. 

Could the global workqueue execute the pending adapter->work item on freed
memory after free_netdev() is called in this ibmveth_probe() error path?

[Severity: High]
This is a pre-existing issue in older error paths of ibmveth_probe(), but it
is duplicated here: does this error path leak the adapter->rx_buff_pool
kobjects?

Since kobject_put() is not called on the pool kobjects before free_netdev()
is executed, the kobjects remain attached to the VIO device with dangling
pointers to the freed adapter memory. 

Could subsequent sysfs accesses to those pool kobjects trigger a
use-after-free?
