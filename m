Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7B329C71
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319241; cv=none; b=qT0hr6I7BpU8Btnzd0AYxFys4ADM149l6ZU+Bzn1fYObOub1yPVjvcGBqGcWrCN+FUguv8S5+lKRXQGKsOSShhlxtrz5IH//zr0E/G0p+AWNdx5FdFAd+6GWI37fz/r+vLqwo7SdkmjsPMlzRcQP4tQmtMX8laL+kRuJM9jdIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319241; c=relaxed/simple;
	bh=ERgO9fR+JNxq7Wf7Mihb00HfnEaaOROeM3Vj1Fmqhnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BD3aALWiElljSXdeNjB2x1up+hit59DxlROOd2+0EubYSIdEbm1p8/DnoWsbzEuvfBjbVR7QQ1BQO72Gh+XObUD6Qcnwrq4/8HxzxDMXFV01+MqNXUwJ64lR8FgsRF5eT3MxKMSpzswiAL7mM8sKFYH7CeNC3ynmVRzIszPW5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKXSriNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKXSriNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1401D1F00A3A;
	Wed, 24 Jun 2026 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782319240;
	bh=Vn4fFZoy5PlSeydUMxpIJV+IuqKhUGEhHOXrG3ACH98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YKXSriNJ2iEGZzOocLfUXXQEv0axYK9sWp7ILG6hS3ZRG9dkoH/OqQLvQ/2oWSQfg
	 NyNiIGXaczJ2H/5073TQJ7IaHIvYUTgSpfAxJFOXN656nAqWpLw/hJHKZtyW8hQUW1
	 EhCJ3s+bbTpATKV+Yy20Etj0zAm89cYf1T0jtFYWitIHCN7jmWW28E1aEokea2+dzH
	 iDYaBnp+phUcbiF/pzivdX6oN7Adi/OFt6gN+TphZKQOuThfOudQQrbWKKsap8QKdT
	 bs1U4u7HsnpPCXWXsEeIAR3iJsp5KHt3aV8yxY/gZAj7Ok+MmBa93iMndgR4FHhriH
	 85uoMQq+pGAiw==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v7 3/4] iavf: send MAC change request synchronously
Date: Wed, 24 Jun 2026 17:31:49 +0100
Message-ID: <20260624163148.1146093-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623101800.991293-4-jtornosm@redhat.com>
References: <20260623101800.991293-4-jtornosm@redhat.com>
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
iavf: send MAC change request synchronously

This commit fixes a deadlock in iavf_set_mac() by making the MAC
address change synchronous. It introduces iavf_poll_virtchnl_response()
to directly poll the admin queue instead of waiting on the watchdog task.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 630388e9d28cb..3fa288e3798ae 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
[ ... ]
> @@ -1049,25 +1103,23 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  		return -EADDRNOTAVAIL;
>  
>  	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
> -					       iavf_is_mac_set_handled(netdev, addr->sa_data),
> -					       msecs_to_jiffies(2500));
> -
> -	/* If ret < 0 then it means wait was interrupted.
> -	 * If ret == 0 then it means we got a timeout.
> -	 * else it means we got response for set MAC from PF,
> -	 * check if netdev MAC was updated to requested MAC,
> -	 * if yes then set MAC succeeded otherwise it failed return -EACCES
> -	 */
> -	if (ret < 0)
> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret) {
> +		/* Rollback only if send failed (message never reached PF).
> +		 * Don't rollback on timeout (-EAGAIN) because the message was
> +		 * sent and PF will eventually respond. When the response arrives,
> +		 * iavf_virtchnl_completion() will handle rollback (on PF error)
> +		 * or acceptance (on PF success) automatically.
> +		 */
> +		if (ret != -EAGAIN) {
> +			iavf_mac_add_reject(adapter);
> +			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
> +		}
>  		return ret;
> -
> -	if (!ret)
> -		return -EAGAIN;
>  
>  	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
>  		return -EACCES;

[Severity: High]
Will this cause a persistent state mismatch if a timeout is followed by a
retry?

If iavf_set_mac_sync() times out, it returns -EAGAIN and bypasses this
rollback, leaving adapter->hw.mac.addr updated but netdev->dev_addr at the
old MAC.

If the user then retries before the PF asynchronously completes the original
request, iavf_add_ether_addrs() returns -EBUSY. Since -EBUSY != -EAGAIN,
the rollback runs, forcibly reverting adapter->hw.mac.addr to the old MAC.

When the PF's delayed success response finally arrives,
iavf_virtchnl_completion() sees the old MAC in both hw.mac.addr and
netdev->dev_addr, bypassing the netdev MAC update. The PF hardware is now
programmed with the new MAC, but the kernel retains the old MAC, dropping
traffic.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index ec234cc8bd9db..e6b7e8f82c7c1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
[ ... ]
> @@ -555,20 +556,23 @@ iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
>   * @adapter: adapter structure
>   *
>   * Request that the PF add one or more addresses to our filters.
> - **/
> -void iavf_add_ether_addrs(struct iavf_adapter *adapter)
> + *
> + * Return: 0 on success, negative on failure
> + */
> +int iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  {
>  	struct virtchnl_ether_addr_list *veal;
>  	struct iavf_mac_filter *f;
>  	int i = 0, count = 0;
>  	bool more = false;
>  	size_t len;
> +	int ret;
>  
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
>  		/* bail because we already have a command pending */
>  		dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
>  			adapter->current_op);
> -		return;
> +		return -EBUSY;
>  	}

[Severity: High]
Could routine background tasks cause MAC changes to frequently fail?

The watchdog task routinely sets adapter->current_op for background commands
like VIRTCHNL_OP_GET_STATS. If iavf_set_mac() is called during this window,
iavf_set_mac_sync() will hit this check and immediately fail the MAC change
with -EBUSY.

Because there is no retry logic in iavf_set_mac(), this error propagates
directly to userspace, making MAC address configuration randomly fail based
on watchdog timing.

[ ... ]
> @@ -712,8 +724,8 @@ static void iavf_mac_add_ok(struct iavf_adapter *adapter)
>   * @adapter: adapter structure
>   *
>   * Remove filters from list based on PF response.
> - **/
> -static void iavf_mac_add_reject(struct iavf_adapter *adapter)
> + */
> +void iavf_mac_add_reject(struct iavf_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
>  	struct iavf_mac_filter *f, *ftmp;

[Severity: Medium]
Does exporting and reusing iavf_mac_add_reject() for local rollback cause
unintended background MAC changes?

When the user requests a MAC address that is already in the filter list
(e.g., a secondary MAC), iavf_add_filter() sets f->is_new_mac = false and
f->add = true, and flags IAVF_FLAG_AQ_ADD_MAC_FILTER.

If the synchronous operation fails locally (like the -EBUSY return above),
iavf_set_mac() calls this function. However, iavf_mac_add_reject() only
clears the pending state and removes the filter if f->is_new_mac is true:

    if (f->is_new_mac) {
        list_del(&f->list);
        kfree(f);
    }

Reused filters are ignored, leaving f->add = true and the
IAVF_FLAG_AQ_ADD_MAC_FILTER flag active. The background watchdog task will
eventually process this flag and blindly send the MAC configuration to the
PF, even though the VF already aborted the operation locally.
