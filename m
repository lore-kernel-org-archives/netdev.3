Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4ED3F23B7
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169568; cv=none; b=b8oknriLwL40xTcthNg/Y2NeBpW3j9a2x5D3IwkXW8Ml2gy9i4vrAVW6Z6h2s50ej7moKUSeJLuSJQbC9dxk/4Au9NICRuXH8JTm69qbp5aoMXLKkcxLS5v0yLahndk0DoGrCl7btioK+q1pfdrWoJ4HHVhMardkJvki7j0Be9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169568; c=relaxed/simple;
	bh=Cqq1ulybOatcnQMsBQMsXkfLDTs7l10YZ9ZqKHf/bxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2e21U71Hb8b7F82T388kJlUcSzN4IcsGG2FCejbdFZdN4DTfzPJFpPZvffyM1LnpHrgQf3zSDg5O2fkmEMWfOxw04YmKdGiG4QeggqvIYU88AA8IWsgeqkinTv6AKC55q+5l9G9onclj5Qg58dmM8Uq3EhqaLgu/KnHgnulzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6aNjOFV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6aNjOFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C29C2BCB2;
	Thu,  7 May 2026 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169568;
	bh=Cqq1ulybOatcnQMsBQMsXkfLDTs7l10YZ9ZqKHf/bxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6aNjOFVQWBkH9dki5JyutsDSH5IH0hA91pfGlh36lLsseJJOLWPyjyKJi17KSdau
	 qj4a6KkOvKimiGRqujnIaRIDRfqkhS2tkz6UVpEoTOjieD4378cMUqH3IgnL6coqyA
	 j0eIrelMgsxeosQwgxOPPqXSZTK7AzGBe4KsBBkp9f1lRAf6uA7Zf5aisFnPxQ3aN6
	 nk2h5bBzSrQfm1jTs+hM3df4mzW0Uo8kYBg4GiLkEa+FMGISRrjqp8V4XnqCoFXWrS
	 B8qHhfm8kaC9WzrvsHM3LoogMV5Zo34zMaayg7GvkRL14AatkvGAvX3dJcUkUvRJmn
	 c3ZHpmsrPDeqA==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	prabu.ponrajthayalan@amd.com
Subject: Re: [PATCH net v2 3/5] ionic: Fix unexpected dev_cmd failures
Date: Thu,  7 May 2026 08:59:26 -0700
Message-ID: <20260507155926.2537908-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506035706.12373-4-eric.joyner@amd.com>
References: <20260506035706.12373-4-eric.joyner@amd.com>
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
ionic: Fix unexpected dev_cmd failures

This commit adds a final check of the done bit after exiting the dev_cmd
poll loop. It attempts to prevent timing out commands that have actually
completed.

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> @@ -541,6 +541,10 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
>  	}
>  	duration = jiffies - start_time;
>  
> +	/* one final check to prevent unexpected timeout */
> +	if (!done)
> +		done = ionic_dev_cmd_done(idev);

If the polling loop exits early because the firmware crashed or the device
was hot-removed, fw_up evaluates to false. Will this final check then read
from a dead device?

On a disconnected device, MMIO reads typically return all 1s (0xffffffff).
Looking at ionic_dev_cmd_done():

drivers/net/ethernet/pensando/ionic/ionic_dev.c:ionic_dev_cmd_done() {
        ...
        return ioread32(&idev->dev_cmd_regs->done) & IONIC_DEV_CMD_DONE;
}

Since IONIC_DEV_CMD_DONE is 0x1, the bitwise AND with 0xffffffff evaluates
to true, making done = true.

If done becomes true on a dead device, does it bypass the firmware down
error path further down in this function?

__ionic_dev_cmd_wait() {
        ...
        if (!done && !fw_up) {
                ionic_dev_cmd_clean(ionic);
                dev_warn(ionic->dev, "DEVCMD %s (%d) interrupted - FW is down\n",
                         ionic_opcode_to_str(opcode), opcode);
                return -ENXIO;
        }
        ...
}

It appears the driver will instead proceed to ionic_dev_cmd_status(), read
0xff from the status register, log an unknown error, and return -EIO rather
than correctly handling the device removal with -ENXIO.
