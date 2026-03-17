Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C391D9A54;
	Tue, 17 Mar 2026 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714370; cv=none; b=Fmwa5kVVdttWqCwUEVPRPvTBE1nafPdXInBb/R+xvv2h0a0nxK8jp4iizC8IFYMbtv0YRWp/EO/A6a2Id82XLzwbW9lgVmlUKQ8acIHU68ZZmS5t074oFWe7e6yFpFMhj4cfFQTTGjkHz7B7X+Y7H8GYOxgMiclZnkJ54vAKf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714370; c=relaxed/simple;
	bh=bPjlaIAl8/efXO+jI9QmVTtxqTbPQ/MDcbFpfoLki3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecz51QfAUTcbHPCv63fvG9dECFTCV0w/LPmYOfpUmWPrhU+gsbDA6IN3ke3Ha7ZQ000Z43SH+TUCwF3zRd1yyUhWyROFRpTHHNAUqf0ERpjploQJDG5LB8TXuk3fbVXmFZYZFW+cF8QOr5l8iTpb0QVCLv32N0oM0Aa4fmq1uVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEzsQKx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEzsQKx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1C2C19421;
	Tue, 17 Mar 2026 02:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773714370;
	bh=bPjlaIAl8/efXO+jI9QmVTtxqTbPQ/MDcbFpfoLki3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rEzsQKx+AfLbOa4zm+dxcOxc8ZZqAQdv+C5qKJZiUVUsuCfQ30UPKyf/z58bDkiaW
	 5H4GLOlTG3staJkV4KAnw/A7kFGbKSni7PW4Qdmgpi1XXxMuk70tYJzH4Udik+11xQ
	 V2VQViL5oUbL+AAF7X6m0BzBF1Lgafh+Bf4XAHNPKGurcVgxTvvEkTa0SWmHQO8/9+
	 6SPc1O54qTErpHS37m2tnXiehpIGUIjaw9FVWDl47HJ/1ie/2PZ44IUciDS6ShnK/8
	 z2GgvMpDlIQzyb9+fZUen1YUiP2q48zWvPlBDFN1InY8P1M4eYDVd/Y3yq0sFDCesp
	 nqSQ2rrdoab/A==
Date: Mon, 16 Mar 2026 19:26:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Cc: carl.lee@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzk@kernel.org, peter.shen@amd.com, colin.huang2@amd.com
Subject: Re: [PATCH v2] nfc: nxp-nci: i2c: restore IRQ trigger fallback
Message-ID: <20260316192609.3e001253@kernel.org>
In-Reply-To: <20260312-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v2-1-362348f7fa30@amd.com>
References: <20260312-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v2-1-362348f7fa30@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 10:51:35 +0800 Carl Lee via B4 Relay wrote:
> From: Carl Lee <carl.lee@amd.com>
> 
> The driver previously relied on IRQF_TRIGGER_RISING when requesting
> the interrupt. This was removed to rely on the trigger type provided
> by firmware.
> 
> However, some platforms do not propagate the interrupt trigger type
> to the IRQ descriptor, resulting in interrupts not being triggered.
> 
> Use the trigger type provided by firmware when available and fall
> back to the historically used rising-edge trigger otherwise.

Sounds like a regression, if you can please mention which platform you
hit the issue on, and please repost with a Fixes tag, presumably:

Fixes: 57be33f85e36 ("nfc: nxp-nci: remove interrupt trigger type")


> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> index 6a5ce8ff91f0..7aaab92c616c 100644
> --- a/drivers/nfc/nxp-nci/i2c.c
> +++ b/drivers/nfc/nxp-nci/i2c.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/module.h>
>  #include <linux/nfc.h>
>  #include <linux/gpio/consumer.h>
> @@ -268,6 +269,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct nxp_nci_i2c_phy *phy;
>  	int r;
> +	unsigned long irqflags;

nit: when you repost please order the variable lines longest to shortest

 	struct device *dev = &client->dev;
 	struct nxp_nci_i2c_phy *phy;
+	unsigned long irqflags;
 	int r;
-- 
pw-bot: cr

