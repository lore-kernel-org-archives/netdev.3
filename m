Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F43AC0D8;
	Mon, 17 Aug 2026 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005502; cv=none; b=jBKVxOR9FXC+IT2S7tQXUvI/lEcvFosAZEe5KPG7/lLHQOZ6pYRhhouux6bt0f3pOvKcFz60YTfVk9sP8ZkHL1qpANv929IRHvNfQKl+/CMIj9PDTTU8FBnl4XUqlUilEYSPrT69fTkCQYojzgkrtgzbSkb6MMJOQE2Wmz1ItPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005502; c=relaxed/simple;
	bh=kb4qfkpzBSD7aMsMsfLu86VpVw3owp9YLdkzAYlxgjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkuUIjXloArzWNrr/dW/28ALX/hgl5odYfiUDXp5vQ+T3OZH2n8ekr3VjyI37eEhFC0d9lWd1jgJvD1gnij3lcxMei9hF80oNurVgO/dCTP+7HGsSmJe3p5LHGXahfNyvi8WrIIVi8sJ/obthkBnSoOJa2xnI1UtyG7iU0CrsXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNOFNcDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNOFNcDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF781F00A3A;
	Mon, 17 Aug 2026 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005500;
	bh=lieWkPGliXt65WhOD8leLjcVA3ERKA0je1BnUuoddkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mNOFNcDWGWHzBfycU2b9anarTOrHu0cEK4S3bK2vrljDUswznPND7bR+9/WqOmjgU
	 5CEeNW4xDMLsBVMfZTWRJqwGoA+WNykZ2ir1KOYmJb/ZvGVxIMbIRl6HclCWqU6eaV
	 VssO/3Pw8OmwQ6Qb2dmXr5lRCATt8jdMHBDvC9RAcszKqoxpLgeIwXt2bbODCocF2i
	 dWJ6Bq2ZqvsmW2WzTQe0b4Ah1jeieleM08Blh/gVMC8KHSJJyK2n6zDcHMdQUY/gaw
	 OIof7RRTG36Ht+0YUCDcODw3++EElDdTNVPULamIBTnjcaer1rAFlNsCCofwyeWRrg
	 pw+91VFjjQYMw==
Date: Mon, 17 Aug 2026 15:24:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v7 05/14] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <20260817152459.1714ba66@kernel.org>
In-Reply-To: <20260810-ax88179a-v7-5-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
	<20260810-ax88179a-v7-5-da633191c129@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 14:33:30 +0200 Birger Koblitz wrote:
> This adds bindings and HW support for AX179A-based USB-Ethernet
> controllers. The AX179A-family of chips consists of the
> AX88279 (2.5GBit PHY)
> AX88179A/B (1GBit PHY, B variant has wider temperature range)
> AX772D/E (100Mbit PHY)
> 
> The controllers all have the same vendor and device ID
> (0x0b95, 0x1790) and are distinguished by their BCD device versions,
> which are
> 2.00 AX88179A/B
> 3.00 AX88772D/E
> 4.00 AX88279
> 
> For all chips, the driver calls the same ax88179a_bind() function
> and the chips are then distinguished by the chip version and
> BCD device ID. The AX179A-based chips all provide both a CDC-NCM
> compatible USB interface, and a proprietary vendor interface. By default,
> the proprietary vendor interface is not active and Linux will load the
> CDC-NCM driver to support the devices. If the ax88179_178a module is
> configured by the OS to have precedence over CDC-NCM, then this driver
> will switch the device to use the vendor interface, and the device will
> be controlled by the ax88179_178a driver when the device is probed again
> after an automatic reset by the device.

Two transiently unused functions here:

../drivers/net/usb/ax88179a_devices.c:397:13: warning: unused function 'ax88179a_mac_disable_tx_lpi' [-Wunused-function]
  397 | static void ax88179a_mac_disable_tx_lpi(struct phylink_config *config)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/usb/ax88179a_devices.c:404:12: warning: unused function 'ax88179a_mac_enable_tx_lpi' [-Wunused-function]
  404 | static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~

This blocked more expensive stages of our CI from running on the series,
it needs to be fixed.
-- 
pw-bot: cr
