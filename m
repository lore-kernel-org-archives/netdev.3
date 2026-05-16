Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E622D7A1;
	Sat, 16 May 2026 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894251; cv=none; b=SNDYeNvhu1qSttwrhNsGwQF+RJ0Ugy2Tjees7Fihw0d5sdMHKeCcj5wNoXvnrXBZJ8/mAniNTGBikHaS2aYhMNvk5VNt58JaZ4GzObxx3PtJo9IFsbvw1euRwG0wYiNHuzY4Lqw0h7uEErL7UIYnBTNNmyImNfQ3U9O9vEJuNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894251; c=relaxed/simple;
	bh=vqb4ZaYQMmZhkOs6tnUeA/Kf3Oyzbjn5GJjDqFFFshs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iT9n4+0YLaURSXfYOp1/v3xUjg9FXIbmJSaH2umKSl7hetOOV7B31WT4kGe4R1OD8/fSobLT/RByGq5Q50dEahDAMlZ57S43BhJIfx1400lx2YTzW0mMTjNQAltXPw9v0XYwnJ/Rh8H286xTfJC9tBT1qaIrnRnpC/fyX3PEwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktroCvJU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktroCvJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A252C2BCB0;
	Sat, 16 May 2026 01:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894246;
	bh=vqb4ZaYQMmZhkOs6tnUeA/Kf3Oyzbjn5GJjDqFFFshs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktroCvJU6D57PDwDQLq18RTS9++FjObYgRd4TF3y5homw34kztyJtZyUG1L36wfBQ
	 qXPjhXoI15exDOyy587dV1+aKFnSCRFbjeFHJUSekbghRXTMoXsC6Zz2Ee1pJ5wLH3
	 T2ORYFvE9EWUDAA1gCpHYtTX8cGqoBjJWGNbQpD5zDSX9NAjp0bMSlKSPTCyqeS10v
	 LECKguAZUbzU3cQ0HlppYpi7rezFxnCmw8JQyTSlNO7EwwMKwGLN108QHtD5+R2xAd
	 5vGGX4khDry5X0qeoheaFRAcPxcAdO9Ndx4GoMZ2BJmtaPo/rbb3vE/557ujsn34nM
	 g2bVkC6Xo8TrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 net-next 11/11] net/nebula-matrix: add common dev start/stop operation
Date: Fri, 15 May 2026 18:17:25 -0700
Message-ID: <20260516011725.1864115-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513011649.4404-12-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-12-illusion.wang@nebula-matrix.com>
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
net/nebula-matrix: add common dev start/stop operation

This patch sets up common device start and stop operations. It configures the
MSI-X map table, allocates and enables MSI-X vectors, and registers the
mailbox ISR.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 9b7f4598fccc3..c7e632a16b40c 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
[ ... ]
> @@ -79,6 +259,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
>  				      NBL_CHAN_TYPE_MAILBOX);
>  }
>  
> +static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +
> +	nbl_common_queue_work(&common_dev->clean_mbx_task);
> +	return 0;
> +}
> +
>  /* ----------  Dev init process  ---------- */
>  static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
>  {

Looking at nbl_dev_setup_common_dev() in the same file:

nbl_dev_setup_common_dev() {
        ...
        ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
        if (ret)
                return ret;

        INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
        common->vsi_id = disp_ops->get_vsi_id(priv, NBL_VSI_DATA);
        if (common->vsi_id == U32_MAX)
                return -ENOENT;
        ...
}

If operations like disp_ops->get_vsi_id() or disp_ops->get_eth_id() fail,
the function returns the error directly. Could this leak the mailbox queue
resources allocated by nbl_dev_setup_chan_queue() on these initialization
error paths? 

Since dev_mgt->common_dev is only assigned at the end of the setup function,
it appears the caller nbl_dev_init() cannot clean this up either.

[ ... ]
> @@ -220,9 +408,41 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
>  /* ----------  Dev start process  ---------- */
>  int nbl_dev_start(struct nbl_adapter *adapter)
>  {
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	int ret;
> +
> +	ret = nbl_dev_configure_msix_map(dev_mgt);
> +	if (ret)
> +		goto config_msix_map_err;
> +
> +	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
> +	if (ret)
> +		goto init_interrupt_scheme_err;
> +	ret = nbl_dev_request_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto mailbox_request_irq_err;
> +	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
> +	if (ret)
> +		goto enable_mailbox_irq_err;
> +
>  	return 0;
> +enable_mailbox_irq_err:
> +	nbl_dev_disable_mailbox_irq(dev_mgt);
> +	nbl_dev_free_mailbox_irq(dev_mgt);
> +mailbox_request_irq_err:
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);
> +init_interrupt_scheme_err:
> +	nbl_dev_destroy_msix_map(dev_mgt);
> +config_msix_map_err:
> +	return ret;
>  }
>  
>  void nbl_dev_stop(struct nbl_adapter *adapter)
>  {
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +
> +	nbl_dev_disable_mailbox_irq(dev_mgt);
> +	nbl_dev_free_mailbox_irq(dev_mgt);
> +	nbl_dev_clear_interrupt_scheme(dev_mgt);
> +	nbl_dev_destroy_msix_map(dev_mgt);
>  }

When nbl_dev_stop() is called, or when nbl_dev_start() takes the error path
after enabling the mailbox IRQ, the driver disables and frees the interrupt,
but does not cancel clean_mbx_task.

If an interrupt fires just before the IRQ is disabled, the work remains
queued on wq_mgt->ctrl_dev_wq and will execute asynchronously.

Could this lead to a memory access issue if devres frees the common_dev
memory when the device unbinds? Is it necessary to call cancel_work_sync()
here to ensure any pending work is flushed or cancelled before the structure
is destroyed?
