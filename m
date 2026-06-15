Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6A405C52
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537703; cv=none; b=WvnS/nVDs0r+0tW/CYHZWA2Bye1TpxYrT/RSO/knuJbs3GCwHBvqAzsEdj4GH1MZhS45Jxkz8da2qm0YoHR4ssSYg5LAdf8PmnLaT2XKjtikYxXtQrpIU/CdLLrJkXUeQZe4PIx4bepwATLh042xr60a4Jts07G58HYmwuvAEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537703; c=relaxed/simple;
	bh=d98kcthOM0gMZdNWf68Lz6H91/isa754lxZq2ugkS5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnR/g54T3itO3tniL7RZ+q0MVZW4vfUUlNrcrgnTPxsYn0mNzb8QnJUdQiSPFv8Vfm1MRRrTnQ9ZuEomUNWeH2SAld2MEPKy8BbMfIFs/YcOKUa6q6QWEVYZDL/1LuTHDkokH0BVWiLQH1Cd83tQW7wot1WUsDP4llxZkiQ0wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBzk29dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBzk29dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8321F000E9;
	Mon, 15 Jun 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781537702;
	bh=KrIaSO/ZO6K1FnrFLw8wD6DuseJBE+Qqfiz9rZBR01Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBzk29dZNVaLC3Y10iyTWg1g+gDobi84bFPH4oDa+rrI23ZDp0/jvq0hAh1KcOwDA
	 KLS/+mn2ogtdV+p08olD86Rjucvtzgd2v0KnBAFW6poWCEH6RNCrtrxekK9vn1jZ9G
	 5secdHvLjEtVXaw8pGjZK6fWGvhqfPGxKWIATuWyibx9muKgS0pHgtBZtcSYgUAiWS
	 k2hbsScgz5W4u7L3ygGTKmr8wHUazudPtiZrk9Kbg/Hgl8f7INOAs5xlO1qZHWsHsC
	 O3knsWtQ3Ci2c2Nwr84Pf20JgkrR/6GqG3oeD1jC12Fg+GPv0TE13LVbb0SG4SfYQ+
	 VS2towlwaoBhg==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric.joyner@amd.com
Subject: Re: [PATCH v4 1/6] pds_core: add support for quiet devcmd failures
Date: Mon, 15 Jun 2026 16:34:02 +0100
Message-ID: <20260615153400.772876-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614050052.1048328-2-nikhil.rao@amd.com>
References: <20260614050052.1048328-2-nikhil.rao@amd.com>
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
pds_core: add support for quiet devcmd failures

This commit introduces support for suppressing error messages during device
commands by adding a boolean parameter to wait and lock functions. It changes
pdsc_devcmd_wait and pdsc_devcmd_locked into internal __pdsc_devcmd_wait and
__pdsc_devcmd_locked variants that handle the new messaging flag. This
functionality is intended for negotiating the PDS_CORE_IDENTITY_VERSION_2.

> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
> index bded6b33289ce..dd9989cfe6b3f 100644
> --- a/drivers/net/ethernet/amd/pds_core/dev.c
> +++ b/drivers/net/ethernet/amd/pds_core/dev.c

[ ... ]

> -int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
> -		       union pds_core_dev_comp *comp, int max_seconds)
> +static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
> +				union pds_core_dev_comp *comp, int max_seconds,
> +				const bool do_msg)
>  {
>  	int err;
>  
> @@ -197,7 +199,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>  
>  	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
>  	pdsc_devcmd_dbell(pdsc);
> -	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
> +	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
>  
>  	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
>  		queue_work(pdsc->wq, &pdsc->health_work);

[Severity: Critical]
This isn't a bug introduced by this patch, but it occurs in the function
modified here.

Can this queue_work() call trigger a use-after-free during driver removal?

Looking at pdsc_remove() in drivers/net/ethernet/amd/pds_core/main.c,
destroy_workqueue() is called but the pdsc->wq pointer is not cleared:

pdsc_remove() {
    ...
    if (pdsc->wq)
        destroy_workqueue(pdsc->wq);
    
    mutex_lock(&pdsc->config_lock);
    set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
    
    pdsc_stop(pdsc);
    pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
    ...
}

Subsequently, pdsc_teardown() issues a RESET command to the firmware.
If the firmware is unresponsive and the command times out, we reach this
error path in __pdsc_devcmd_locked(). Since the pdsc->wq pointer was never
set to NULL, the check here succeeds, and it attempts to queue work to a
destroyed workqueue.

Should pdsc->wq be explicitly set to NULL immediately after being destroyed
in pdsc_remove() to prevent this?

>  	else
>  		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>
