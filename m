Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B993FC5CA;
	Wed, 10 Jun 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108764; cv=none; b=ENPcZHnaK0mHqoW4vtaXkdtAEX/47HtdfGX63sE4qKcdPJViym8DJh6rDWfKjjR4PLmfjSXxxUDNAIrwHqAVR1glXxOXEiBzISzo55HJlm3ck256GCmRDnu0lr0eLs+QG/cSlx6oKsQeXVyXMBSGQ/pZbzbGN+6ohdtGBowLvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108764; c=relaxed/simple;
	bh=2DOTKNJnDVnsfeNX/FCjaolykeK3YuuXrtIO+/n8Cgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhOiU3aGvnliyU9WDdxYsmw4Uu7tSeOwD/O5bVk88LgbwSoSmttWQJcyQsswU4BDaOn3QOQet0WV8OK7NZebwCbvme8DTljq8LUaYE1V64NWfBiLQ4Cny/OKkBThBCd6s7UfSd4CG8tcVGKlaBoloACIVmoXusZMRihY9btIpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgIkZGGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgIkZGGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EA61F00893;
	Wed, 10 Jun 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781108763;
	bh=YtleLhSJP0qj1IzeJ7RS2y2dZG/etW1NrBaI1biUUlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RgIkZGGPzrZq8WAtfkQmBGtJUpmY0hZLUzOCWnSFBdn6q69/zqJRMux/Za2bAAYKR
	 yYk6SYXgrhpzlyeaa3bI5vQ5XaRhrl3E0fW+BAy9ZeHmJgdz0okU0fcAy1nesy0eoV
	 aX6lrjXTY0aTydN4pxUBpFwp5nLP+/Nt1s8RLLjbxqsKAXhgS0iVQSmAlk/7M67BEB
	 l2aC8LhZL74G914Nsi0Ejy72WoqxO4KrbbFgvXHbuVfswTwzP6y+vMzapC9R6XL2kU
	 USm4lkf18kx2wft6TQUANerDCxnqhe4JvegG+Ds6nqiRNEbCnya1eDo4IokH2pcjXJ
	 7Tk61X0i3CzUg==
From: Simon Horman <horms@kernel.org>
To: thangaraj.s@microchip.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: lan743x: add RMII strap status detection for PCI11x1x
Date: Wed, 10 Jun 2026 17:25:08 +0100
Message-ID: <20260610162507.466793-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608100435.11214-2-thangaraj.s@microchip.com>
References: <20260608100435.11214-2-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Subject: net: lan743x: add RMII strap status detection for PCI11x1x

This patch extends pci11x1x_strap_get_status() to read RMII strap bits
from STRAP_READ and initialise a new is_rmii_en flag on the adapter,
updating the netif_dbg() to print the selected interface as SGMII, RMII
or RGMII.

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 1cdce35e1423..0798f3f1f435 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -73,8 +74,15 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>  			adapter->is_sgmii_en = false;
>  		}
>  	}
> -	netif_dbg(adapter, drv, adapter->netdev,
> -		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
> +
> +	if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
> +		if (strap & STRAP_READ_RMII_EN_)
> +			adapter->is_rmii_en = true;
> +	}
> +
> +	netif_dbg(adapter, drv, adapter->netdev, "Selected I/F: %s\n",
> +		  adapter->is_sgmii_en ? "SGMII" :
> +		  adapter->is_rmii_en  ? "RMII"  : "RGMII");
>  }

[Low]
This isn't a bug, but does the new "Selected I/F: %s" debug print stay
consistent with the rest of the driver when is_rmii_en is true?

In lan743x_mdiobus_init() the non-SGMII branch still prints unconditionally:

	} else {
		dev_dbg(&adapter->pdev->dev, "RGMII operation\n");
		// Only C22 support when RGMII I/F
		adapter->mdiobus->read = lan743x_mdiobus_read_c22;
		adapter->mdiobus->write = lan743x_mdiobus_write_c22;
		adapter->mdiobus->name = "lan743x-mdiobus";

So an RMII-strapped board will report "Selected I/F: RMII" from
pci11x1x_strap_get_status() and then "RGMII operation" from
lan743x_mdiobus_init() in the same boot. The C22-only setup is correct
for both RGMII and RMII, so the only effect is the contradictory dmesg
line. Should this dev_dbg() also be updated to reflect the RMII case,
either in this patch or in the follow-up "net: lan743x: add support for
RMII interface"?
