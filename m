Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425240242B;
	Thu,  9 Jul 2026 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588848; cv=none; b=D1gMKGrXpNRCG7aavZP3+rYTCdxt64VVCYj5KnDmKTMGq2hF2IdkKS7qxVhIIt1nJm8aZSbVHiUKbki/BogjlehCrmdCmWueRAM6y7Hf+OobHcagEXUfuSOY9Sn6KZ84SN0G/HewMOSwVMJOn/ccdsQdYE0HRviU8SkXVVGtCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588848; c=relaxed/simple;
	bh=XOS9SWzdNhOR+qVEsGZ34Nd9EotkFmJ6YiS8xu6q8ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KcV4qmCDe4Zq73Qrx9FYzDgCBkdE3GjT8vAHSEnHqDE4l6/t+/DrEGXv4dHlFfMPRUS7Yqzbs49VdS90Mc9X4JOwZ1yBJQ0c1qWIrqLgpEkOuUspeKXmkiR15ETqQ8KCHNglgqL73Qoh50hhgjI0ZqUYPsfiiET+4RiaMe8hb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhV+Hkg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhV+Hkg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC70C1F000E9;
	Thu,  9 Jul 2026 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588847;
	bh=bjUxEVmvjUCSt1uiQXxhR9MAK5xCL97Y/ZayRGqElFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DhV+Hkg6rJEoRgZoPCAkZUZ/plsCcYXdaF/9ri5O45f5m/t03MeqbKH1jLuzPwYMS
	 SES6suNHz9HBA3QTG3OqtVSUNKz2N1ghn0EpxetRdJ0mcomPFGEFeHSASS4d2Jafaw
	 dwI8VWeN5voIJLelyN1A+sG9eA5v1o6ag35reGyC4fe4kWM0TgwszYz0n3uJxEi2CC
	 kwO2MegKkYMxr9V01G7m4c0hRY6PDxCtl6VgopisZLESk8Z1vZ0QW41FJQiv0DGpip
	 kMHGC0b06nWSFLChfWn14KFRxhtUCB3t47NAATqIucTuegY3wayEz1Z8GfL+K1q/Dc
	 LrSw2nM3+i3yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C8F393A564;
	Thu,  9 Jul 2026 09:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358882538.3359576.3896028235103596799.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:20:25 +0000
References: 
 <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
In-Reply-To: 
 <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29_=3Cu=2Ekleine-koenig?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?=40baylibre=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  6 Jul 2026 11:29:19 +0200 you wrote:
> <linux/mdio.h> itself doesn't use any of the device id structures. The
> files #including <linux/mdio.h> use a variety of them:
> 
> 	$ git grep -l '<linux/mdio.h>' | xargs grep --color  -E '\<(acpi_device_id|amba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|ccw_device_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|dmi_(device|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_device_id|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|input_device_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_id|mdio_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_device_id|parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|platform_device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_device_id|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_device_id|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typec_device_id|ulpi_device_id|usb_device_id|vchiq_device_id|virtio_device_id|wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>'
> 	...
> 
> but none of them relies on <linux/mdio.h>'s #include.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: phy: Drop #inclusion of <linux/mod_devicetable.h> from <linux/mdio.h>
    https://git.kernel.org/netdev/net-next/c/6d86ce0da0d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


