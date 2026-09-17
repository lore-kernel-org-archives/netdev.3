Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2204B1D1F;
	Thu, 17 Sep 2026 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684517; cv=none; b=pneGaYWNwDISSai7iW40FK+elobZddezvvtCc2LCpZQhEzdv3gyrVAK7fnVTSsc+nA/HHhIoBr6dQpY/o1djToOGnzM9fbJxEWP318sesuhZJYrOkbIfY/UMI6g8P5TaAe5Zkp3HQtWvrcejdjIMhpQGg52btWQ6YU/LR7iFpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684517; c=relaxed/simple;
	bh=zYPN2LPGwi5FNBwRhnCYGLKcCQSAeYzwC/tarPwrGMI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qibZf6lYY+vE79lR+hpMxIVrnibQwvQEPrFH/bINKCMzVLBLbhYEVO5yg5JTdzLI3Y9JH52hctHBg9Ty/rvTgNHQmDkJ8RQo4bSbrbZRr7nqkqCtqrG1D5PrK07OPnXKhUAj3FLXpUmMDqupKmQdU/2dpwMAmy5TaOgYs2WVUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKuEeyw3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKuEeyw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B611F00893;
	Thu, 17 Sep 2026 22:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684514;
	bh=JDN5RTA/Ti0geBVAfEjqoSQX6XQPsLA7wKAHhxTe7zw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AKuEeyw3QGIcM13kJdbYAnc996mHFT2o19YcHbHzI1ltb0FHgBUAfJStfa3+dK2aQ
	 sCy0ren2/hzVfRaH0qIB+35AfJzAwZKOeKaijVE3VhJKuTxLbUiDiOo4MimE8D+JvE
	 ynD03Tt9tsouJv9FcriIyhu2IS8B7kn/vxY9d1kuu12Y+8o1wXCoWpKFWiSd0snNqc
	 RtZ9MAJtkDVy2D+B6yohSEthN45NCHmPh6L8RzHFJ9cGWkQAFld1jx6h5ubAzaCNKN
	 ZfnGGNLIbAfWkX9MSqMwWwVLa/+YwdkpjT/yBVkYuoVOuWnbLizwMa9FK1nbBnbQRv
	 MTGzh0VsXflng==
Subject: Re: [PATCH v28 net-next 10/10] net/nebula-matrix: add common dev
 start/stop operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:13 +0000
Message-ID: <178968451304.22033.8287132696039494938@kernel.org>
In-Reply-To: <20260914123429.56596-11-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-11-illusion.wang@nebula-matrix.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] A non-control PF's nbl_dev_start() (nbl_dev.c:457-492) issues
  three mailbox RPCs to the manager PF (cfg_msix_map at line 467,…
- [Medium] nbl_dev_setup_common_dev() (nbl_dev.c:300-332) calls
  cancel_work_sync(&common_dev->clean_mbx_task) at its err_cleanup label…

--

net/nebula-matrix: add common dev start/stop operation

This adds nbl_dev_start()/nbl_dev_stop() to configure the hardware MSI-X
map, fetch VSI/ETH identity, allocate MSI-X vectors and request/release the
mailbox interrupt.  Thin wrappers nbl_core_start()/nbl_core_stop() are hooked
into nbl_probe() and nbl_remove().

A couple of questions below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 75c0d83663b9c..e9b0576de0f30 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c

[ ... ]

> @@ -77,6 +288,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
>  				      NBL_CHAN_TYPE_MAILBOX);
>  }
>  
> +static void nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	struct nbl_common_info *common = dev_mgt->common;
> +
> +	queue_work(common->wq, &common_dev->clean_mbx_task);
> +}
> +
>  /* ----------  Dev init process  ---------- */
>  static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)

[Severity: Medium]
Now that clean_mbx_task is driven from the mailbox hardirq handler, can we
also take a look at the error path in nbl_dev_setup_common_dev()?  The work
is cancelled there before it is ever initialized:

    common_dev = devm_kzalloc(&adapter->pdev->dev, sizeof(*common_dev),
                              GFP_KERNEL);
    ...
    ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
    if (ret)
            goto err_cleanup;

    INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
    ...
    err_cleanup:
            cancel_work_sync(&common_dev->clean_mbx_task);

If nbl_dev_setup_chan_queue() fails (its ring allocations can return
-ENOMEM), clean_mbx_task is still the all-zero devm_kzalloc content, so
work->func is NULL when cancel_work_sync() runs:

    kernel/workqueue.c:__flush_work() {
        ...
        if (WARN_ON(!work->func))
                return false;
        ...
    }

Does this produce a workqueue warning backtrace on that path?  The zeroed
work->data also decodes to pool_id 0 rather than WORK_OFFQ_POOL_NONE, so
start_flush_work() would look at an unrelated worker pool.  Would moving
INIT_WORK() up to right after the devm_kzalloc(), or dropping the cancel
from a path where the work was never initialized, be preferable?

[ ... ]

> @@ -233,3 +452,120 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
>  	if (common->has_ctrl)
>  		nbl_dev_remove_ctrl_dev(adapter);
>  }
> +
> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
> +	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> +	struct nbl_dispatch_mgt *priv = dev_mgt->disp_ops_tbl->priv;
> +	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
> +	struct nbl_common_info *common = dev_mgt->common;
> +	int cleanup_ret;
> +	int ret;
> +
> +	ret = nbl_dev_cfg_msix_map(dev_mgt);
> +	if (ret)
> +		goto err_destroy_map;
> +
> +	/* Fetch VSI/ETH identity after cfg_msix_map */
> +	ret = disp_ops->get_vsi_id(priv, NBL_VSI_DATA, &common->vsi_id);
> +	if (ret)
> +		goto err_destroy_map;
> +	ret = disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_num,
> +				   &common->eth_id, &common->logic_eth_id);
> +	if (ret)
> +		goto err_destroy_map;

[Severity: Medium]
On a non-control PF, all three of these calls are mailbox RPCs to the
manager PF, since nbl_disp_refresh_ctrl_ops() installs the
NBL_DISP_CTRL_LVL_NET request variants:

    nbl_dispatch.c:nbl_disp_refresh_ctrl_ops() {
        ...
        } else if (test_bit(NBL_DISP_CTRL_LVL_NET, disp_mgt->ctrl_lvl)) {
                disp_ops->cfg_msix_map =
        ...
    }

What happens if PF0 has not finished its own init/start yet?  The send goes
through the polling path and comes back as a bounded failure:

    nbl_channel.c:nbl_chan_send_msg() {
        ...
        dev_err_ratelimited(dev,
                            "Channel polling ack failed, message type: %d msg id: %u\n",
                            chan_send->msg_type, msgid);
        ret = -ETIMEDOUT;
        ...
    }

nbl_dev_start() then returns -ETIMEDOUT to nbl_probe(), which turns it into
a plain probe failure rather than -EPROBE_DEFER, so the PF stays unbound
with no retry once PF0 does come up.

This looks reachable with asynchronous probing enabled
(driver_async_probe=nbl or nbl.async_probe=1), where PF1..PF3 can run these
RPCs before PF0 has programmed the mailbox QINFO routing and registered the
responders, and also when an administrator binds a non-control PF via
/sys/bus/pci/drivers/nbl/bind while PF0 is unbound.

The commit message notes the dependency:

    Non-control PFs rely on the control PF's mailbox responder
    being fully operational when this RPC runs.

Should the code enforce that, either by checking control-PF readiness or by
returning -EPROBE_DEFER so the bind is retried?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 9896c1b49be2b..02cb35d32012f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> @@ -127,7 +137,13 @@ static int nbl_probe(struct pci_dev *pdev,
>  		goto adapter_init_err;
>  	}
>  	pci_set_drvdata(pdev, adapter);
> +	err = nbl_core_start(adapter);
> +	if (err)
> +		goto core_start_err;
> +
>  	return 0;
> +core_start_err:
> +	nbl_core_remove(adapter);
>  adapter_init_err:
>  	pci_clear_master(pdev);
>  	return err;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
