Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2C224AFA;
	Tue, 14 Apr 2026 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128214; cv=none; b=qi5U9NEPJSQlIYfiSPciG+2XYzPRDFbl1ruz2lC9TH7lxQX+lSdF5x2bft0b1BvwLzqCQEi4S9aH48++yFkg/3r6IuHp15qRG/LpqslZ++tPoST7U4pnOm1+MiWFLBcgZ/YuygyqaH/HJ4xXvREsPIqQYhzxQCiVihMVsDxQ69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128214; c=relaxed/simple;
	bh=DNLfsvu9KCmf+MBO9XVh5jPegBiClGepZ0kdvYbaXyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7dHQDK3B0KP1pFlfhFow9Be8YYwUOSrwhUTBNRBFteixwBRUHrYY7JV5LZrazd/ooKTVmDYD6DSKWBfEXUw/5gM2I2M0g6Hb3SvEVcPuHVziWi22zQC+nnGiCVgq/Xx4xKV73No5OZ/NuOV7/W6DW54MWUx30V0j3WN4NKIoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz5Zyjfb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz5Zyjfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620E4C2BCAF;
	Tue, 14 Apr 2026 00:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776128214;
	bh=DNLfsvu9KCmf+MBO9XVh5jPegBiClGepZ0kdvYbaXyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz5ZyjfbTsLbJYqe/R6ZnJT8pXLmg2dB/KKuHOucUptteq80caAZ5da7sa0jpd2jb
	 la+GIYTCfTkMJHqEyy01QeYg1tOMGYSZzQ3oGVAby/Jv6Egj40ZwXxDJfhpHFXaLXV
	 BbD1a3IAJr4ppay9x4A0gyB13Xyf7+59FexjE8JfVUXKwp3m91KWizEF46Zgs7hFwR
	 Hny/qy6jCJYa9WS2/jr8tipCHo8O3tGCa2RyblNYdkDXTiSxDuyTbvM8jdlJG19clL
	 /Z9BcOiuhJhb3jQ5jV9a/KwLpwySwgFKqBmDakIZMAPl7G9ECimYMVIAKTfviVRgpK
	 Pl5SzIJQOSRvg==
From: Jakub Kicinski <kuba@kernel.org>
To: theo.lebrun@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	pvalerio@redhat.com,
	conor@kernel.org,
	nb@tipi-net.de,
	vladimir.kondratiev@mobileye.com,
	gregory.clement@bootlin.com,
	benoit.monin@bootlin.com,
	tawfik.bayouk@mobileye.com,
	thomas.petazzoni@bootlin.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/14] net: macb: re-read ISR inside IRQ handler locked section
Date: Mon, 13 Apr 2026 17:52:44 -0700
Message-ID: <20260414005244.3758889-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-macb-context-v2-12-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-12-af39f71d40b6@bootlin.com>
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
net: macb: re-read ISR inside IRQ handler locked section

This commit adds a second read of the ISR register inside the lock in
macb_interrupt() to handle a race condition where the status might have
been updated by concurrent hardware resets.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 2633234012bae..3deab87c565b5 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2190,6 +2190,13 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
>  
>  	spin_lock(&bp->lock);
>  
> +	/* `status` stack variable might be stalled => re-read it */
> +	status = queue_readl(queue, ISR);

Will this second read discard interrupt events on older MACB variants that
use clear-on-read for the ISR?

If the hardware does not have the MACB_CAPS_ISR_CLEAR_ON_WRITE capability,
the first queue_readl call before the lock already cleared the active bits.

Overwriting the local status variable here sets it to 0, which permanently
drops the initially captured Rx/Tx completions and stalls the network
interface.

> +	if (unlikely(!status)) {
> +		spin_unlock(&bp->lock);
> +		return IRQ_NONE;

If the function reaches this point, the initial status read before the lock
was non-zero, meaning the device legitimately asserted the interrupt.

If a concurrent operation cleared the hardware state while this thread
waited for the lock, will returning IRQ_NONE falsely flag this as a
spurious interrupt?

Since the interrupt was actually raised by the device, doing this repeatedly
can cause the core IRQ subsystem to permanently disable the IRQ line.

Could this return IRQ_HANDLED instead?

> +	}
> +
>  	while (status) {
>  		/* close possible race with dev_close */
>  		if (unlikely(!netif_running(netdev))) {
-- 
pw-bot: cr
