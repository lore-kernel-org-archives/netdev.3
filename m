Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C223A9856
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186434; cv=none; b=djKIoTNCj4KiEat2I/6/MTGuHcItkcGKsd9xQwZALxzGjbjF061HCuiaMKvLJoy15PvDvIRd0TOCMPW8NnMscTGrxdZmKYWv3OrGGhwNREkbQ+8PCe5oF9k0TmI2PdHkHLYbMk8+qVx4ZmOqSkUYpV/hh7i3lxNn4QWByEfXbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186434; c=relaxed/simple;
	bh=Uhvek4oQNaENbSdwaf5voB8aCsOWOqBYVGiLbWSZSf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiyIwwfoQ4mcfJXpMRomaLNm6nwPoAQiunkus/iEqrEfK55y9MQtfyqam6xBdbGOt8m437Hjt4MhGimEBcdx5Nvs+oV0R2xI3kjRM9MGix3UiCMXBMMmq9EIbpzJBjkrG3vdMDwo8MEAhpXRLa2ZyKFOjtVneqtQ5l/3ilIbbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfQOhFpZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfQOhFpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26651F000E9;
	Thu, 16 Jul 2026 07:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784186426;
	bh=BYKIozrY+MvD4zpkHiFzwZKyb8EfmmAuwDcyZ3Cnh2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfQOhFpZFXAsUrbw0NHIlKqI8MEK/5Yrh+L9CIszB/V2XnUU91+39euwCwM5KAXXb
	 etKrOxy9EDqFRt053o+fzUQ6dVZybnVHjBWnXErfFxI+0MswxAUv0SNVE8/hWRq1q7
	 bdB6MdfIasVmPdlh6Trs32B9ZScwIOYenExQbJnDAEMXcnG058BV1Lp5B9gp7gaPjd
	 k3rMRXcnimsRM0bJ+TjI0keezD6V8b1SyZr++ouezhfkY9IMWcUFLHcFuDgRoGI6bE
	 IpaeS5PrtB1g/rA4WlP34PcGqvNiffZHpvjs8QjbiciKlk9dtK1igaGff3P2qN6Vl9
	 N4E7hfBnzY/5Q==
From: Simon Horman <horms@kernel.org>
To: nikhil.rao@amd.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	brett.creeley@amd.com,
	eric.joyner@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH 1/6] pds_core: add support for quiet devcmd failures
Date: Thu, 16 Jul 2026 08:17:38 +0100
Message-ID: <20260716071736.179693-3-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708212222.296202-2-nikhil.rao@amd.com>
References: <20260708212222.296202-2-nikhil.rao@amd.com>
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
--- Patch [1]: [PATCH 1/6] pds_core: add support for quiet devcmd failures ---
commit 2618e77f5d1aae31c9817f09b5056a69e237162a
Author: Brett Creeley <brett.creeley@amd.com>

pds_core: add support for quiet devcmd failures

This commit adds support to allow devcmd failure messages to be suppressed.
This will be used when adding support to negotiate
PDS_CORE_IDENTITY_VERSION_2.

> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
> index bded6b33289ce..dd9989cfe6b3f 100644
> --- a/drivers/net/ethernet/amd/pds_core/dev.c
> +++ b/drivers/net/ethernet/amd/pds_core/dev.c

[ ... ]

> @@ -197,7 +199,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>  
>  	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
>  	pdsc_devcmd_dbell(pdsc);
> -	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
> +	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
>  
>  	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
>  		queue_work(pdsc->wq, &pdsc->health_work);

[Severity: High]
This is a pre-existing issue, but does this error path trigger a
use-after-free during device removal?

During device removal, pdsc_remove() destroys the workqueue without clearing
the pointer before invoking pdsc_teardown():

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

The teardown function issues a hardware reset command via pdsc_devcmd_reset().
If the device is unresponsive and the command times out, the error path here in
__pdsc_devcmd_locked() catches the -ETIMEDOUT error. 

Because pdsc->wq was left as a dangling pointer, the condition evaluates to true
and execution falls through to queue_work(), which will dereference the already
destroyed workqueue pointer.

Could the pdsc->wq pointer be set to NULL immediately after destruction to
prevent this, or should the teardown sequence be reordered?

>  	else
>  		memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>  
>  	if (err != -ETIMEDOUT && err != -EAGAIN)
>  		pdsc_deferred_dma_free(pdsc);
>  
>  	return err;
>  }
