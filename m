Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7864D598B;
	Wed, 14 Oct 2026 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968211; cv=none; b=mPtjHDlwvh7bJtNtJ9rKn7RJWoeMaAIK4/Vvlw5RiNlL85cn1sQ0nY0tYkgBsB3DVJ9kDhqfkxXF0FKq7cHCBZ2hbCsGlY3JmdVC5/S52E4MnGP78JVTV6TsQo1iZbCgK55HaZEPcS9ty9Utvnag+3u5QCmDi5UuVym5n5q/dmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968211; c=relaxed/simple;
	bh=h7dCTuxTADoa2X7SkQp+Y9/dmH+Z4w2eIXNY+CpqW7Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1L/M1qSTQ/1yGoS/cCY/Axz8rAsAp3zTzpJe3RVrp1SHiMe1Ly5V0GySO8pwcFuHI5gEIyP4kbQlAkO6C2w/u8gRwDetazdtbxkdCh2ViXByKZK2HDIEfV6sHrDg2/w1FQ2iMuWYhtMnlmgfhvh83luz0Y1EkJLjOSN/mjwfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlIUGQ9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlIUGQ9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CCC1F00893;
	Wed, 14 Oct 2026 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968208;
	bh=pVSFJOnLtTLLxLTcRLyMja2JHdb9/oY00VwBW3b5GOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AlIUGQ9+cfU7Ywfidwob4ebZgm1NBCP15wD2PCvAR2beU9Mr4XgZmyG9ac7p3Sj6e
	 cQ+bkiscsVXjJi9kFGTN8FoRQDeinvqhZSfC7g52R2ziBW/B4phZhNhxW+DUmzP9gL
	 l9C4AK6KZ295PsnYuURO2/11Yu2P1bj5A9wuRYRRyYuMwLXWs+BZHuxne0njw08hI/
	 6Kx2YcYwLJK9xWPW5i6LQ5wc1/yxbTTn1MNcY4Ee3ON+JleIlhezL1CM7HZ2ay48NT
	 FulYAleqRA8tmiTp3+qzD2WW84DeC2i7xUXZEPGKmRo03H/v/mlrxOCcq8pwpmYPVK
	 0l2vKHIh3PCHQ==
Subject: Re: [PATCH net-next v5 9/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:56:47 +0000
Message-ID: <179196820753.434549.9415507328931407333@kernel.org>
In-Reply-To: <ecb73c8a-0bd7-4c82-8fa7-048aae4e335e@yahoo.com>
References: <ecb73c8a-0bd7-4c82-8fa7-048aae4e335e@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The family-D SerDes re-latch work can be queued again after
  the reboot notifier has cancelled it.

--

net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

This patch adds the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the
chip table. It is the first family D chip, so the family D handling added
in the earlier patches becomes reachable. On family D it also caps
priv->num_ports at RTL8365MB_D_MAX_NUM_PORTS.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 238a3fa765e97..352b15bd5508d 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -885,6 +892,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.jam_table = rtl8365mb_init_jam_8365mb_vc,
>  		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
>  	},
> +	{
> +		.name = "RTL8367S-VB",
> +		.chip_id = 0x6642,
> +		.chip_ver = 0x0010,
> +		.family = RTL8365MB_FAMILY_D,

[Severity: Medium]

With this entry, the family D SerDes re-latch work and the reboot notifier
can now run. Can the sds_relatch work be queued again after the reboot
notifier has cancelled it?

The notifier cancels the work once. It sets no state that anything else
checks:

drivers/net/dsa/realtek/rtl8365mb_main.c:rtl8365mb_sds_reboot_notify() {
	/* Runs before device_shutdown() on reboot, halt, power off and kexec.
	 * cancel_delayed_work_sync() waits for a running pass, so the SerDes
	 * is not left parked and the bus is not touched while it is shut down.
	 */
	cancel_delayed_work_sync(&mb->sds_relatch);
    ...
}

rtl8365mb_pcs_config() queues the work for 2500base-x on family D
without any check:

	if (is_d && interface == PHY_INTERFACE_MODE_2500BASEX) {
		WRITE_ONCE(mb->sds_relatch_count, 1);
		schedule_delayed_work(&mb->sds_relatch, 0);
	}

After that, rtl8365mb_sds_relatch_work() re-arms itself every time it
exits:

rearm:
	schedule_delayed_work(&mb->sds_relatch, delay);

pcs_config() could run after the reboot notifier chain in two ways:

- Probe overlaps reboot. rtl8365mb_detect() registers the notifier, and
  dsa_port_setup()->dsa_port_enable()->dsa_port_enable_rt()->
  phylink_start() then configures the HSGMII CPU port.
  kernel_restart_prepare() runs the notifiers before device_shutdown()
  calls wait_for_device_probe().

- A user port on the SerDes is brought up at the same time, through
  dsa_user_open()->phylink_start().

After that, rtl83xx_shutdown()->dsa_switch_shutdown() only closes the
conduits and detaches the user netdevs. It doesn't stop the CPU port
phylink, call rtl8365mb_teardown(), or cancel sds_relatch. The devm action
rtl8365mb_sds_relatch_cancel() doesn't run on shutdown either.

In that case, wouldn't the work keep parking SDS_MISC, sleeping for 20 ms
and doing regmap I/O over SMI/MDIO while the switch, and possibly the host
MDIO/GPIO controller, is being shut down? The notifier comment says this
cannot happen.

Would disable_delayed_work_sync() in the notifier work here? Another
option would be a shutdown flag that rtl8365mb_pcs_config() and the work
check before re-queueing.

> +		.extints = {
> +			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
> +			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
> +				PHY_INTF(RMII) | PHY_INTF(RGMII) },
> +		},
> +		.jam_table = rtl8365mb_init_jam_8365mb_vc,
> +		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
> +	},
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4%40yahoo.com
