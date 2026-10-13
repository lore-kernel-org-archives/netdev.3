Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D73AEB2D;
	Tue, 13 Oct 2026 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853717; cv=none; b=jYOIkVwp+zvUJdYfcsl9XJpPyWbJ0qhyU6tUe9d/mQsudzVc8PH44hLkuJ+bbfYrAs0Cu2TFUJQMrpih5LFHvzBn9hMBTw2kDWnU5ufDD2Lk30NkWHJZJY2NdOofmCUUI0vZHpd4Dlc36qzr5Tge3I878BPz5Kv6BIFc86R0Bug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853717; c=relaxed/simple;
	bh=jcAz9gkeBJRGXcTmqUCaTzCA+6cOhJdw4PN09ifhl0o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5abJD2gR6Rva/QK/SwemUGmYr45sZ5mrvAj8fMpCeUGmp52xjAgO8NxXze5dNtgEma441nTTVjnzRXDuWbdsc4nWZN9sUtZTrlYbxYRH2d6ZjLcWb0L4BD2bFp4WRJ253npouvhdtKR+n6qCwwVeK0EAdzDRnE9K7Qkd5BlSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrYFSRD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrYFSRD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D731F0089B;
	Tue, 13 Oct 2026 01:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791853716;
	bh=fC+La5JpAswynVBvTaQA2bwh4HwRIQOw6HR5i29+YLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CrYFSRD8WdGwUaERADoh5/1TI0+BNJQYv49EPZeJsgqhlmA37GB6bLVxSgdFw3WlS
	 R+BULIMIpfzMofjLW8ZQLfQn2LZyybV1cj96LoXNq8DdLo8ZaTg1UhAbd7G6Wvd6NB
	 5td7je7aWvsOP+YB1lnxyELKVr+Be/ByaGi9c9obBS/lxi4LT+F8c8dct2KxRBvvwL
	 4D1hdY7VvddQIC66T/ekbrtzqKVAgVckwq+J7FsFRY/ukeemBlRfjFtF8jVyWn3PEh
	 hY8zqFcVqmqnjhDJ9TuQb+FDDzpp9q4KhklsEQrUH/Iw+gg3iAgJ4O3IcQjYoWrwIB
	 8ByABRUO8XleA==
Subject: Re: [PATCH net-next v4 9/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 01:08:35 +0000
Message-ID: <179185371521.434549.780054895188003280@kernel.org>
In-Reply-To: <ccaab57b-1bab-440d-a4ac-d3e467240695@yahoo.com>
References: <ccaab57b-1bab-440d-a4ac-d3e467240695@yahoo.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In rtl8365mb_sds_relatch_work()
  (drivers/net/dsa/realtek/rtl8365mb_main.c), the only thing that stops…
- [Low] The commit message says the RTL8367S-VB SerDes on external
  interface 0 (port 6) and RGMII on external interface 1 (port 7) are…

--

net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

This adds the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the
rtl8365mb chip table. It is the first family D chip, so it makes the
family D code paths from the preceding patches reachable. It also caps
priv->num_ports at 8 for family D.

> The SGMII/HSGMII SerDes of this chip sits on external interface 0
> (port 6), and the MII/TMII/RMII/RGMII interface on external interface 1
> (port 7), the other way round than on family C chips. The chip reuses the
> existing initialization jam table.

[Severity: Low]
Is "the other way round than on family C chips" accurate here?

The family C RTL8367S entry in rtl8365mb_chip_infos[] has:

    { 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
    { 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
        PHY_INTF(RMII) | PHY_INTF(RGMII) },

The new RTL8367S-VB entry has:

    { 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
    { 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
        PHY_INTF(RMII) | PHY_INTF(RGMII) },

On both families, port 6 is the SerDes and port 7 is xMII. Only the
extint index goes down by one (EXT0/EXT1 instead of EXT1/EXT2). The
comment above RTL8365MB_SDS_EXT_INTERFACE_ID also says "the SerDes port
is 6 on both families".

Could the commit message say that the extint indices are shifted by one
and the port assignments stay the same?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index bef95f91eea50..72f308d9e81d8 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -884,6 +891,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.jam_table = rtl8365mb_init_jam_8365mb_vc,
>  		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
>  	},
> +	{
> +		.name = "RTL8367S-VB",
> +		.chip_id = 0x6642,
> +		.chip_ver = 0x0010,
> +		.family = RTL8365MB_FAMILY_D,

[Severity: Medium]
This entry makes rtl8365mb_sds_relatch_work() reachable. Can that work
still access the switch after rtl83xx_shutdown() has returned?

The only shutdown guard in the work is a lockless check at the top:

drivers/net/dsa/realtek/rtl8365mb_main.c:rtl8365mb_sds_relatch_work() {
    ...
	if (!dev_get_drvdata(priv->dev))
		return;
    ...
	usleep_range(20000, 21000);

	if (rtl8365mb_sds_relatch_restore(mb)) {
    ...
rearm:
	schedule_delayed_work(&mb->sds_relatch, delay);
}

The shutdown path only clears drvdata:

drivers/net/dsa/realtek/rtl83xx.c:rtl83xx_shutdown() {
	...
	dsa_switch_shutdown(ds);

	dev_set_drvdata(priv->dev, NULL);
}

dsa_switch_shutdown() doesn't call ds->ops->teardown, phylink_stop() or
pcs_disable. So none of the cancel_delayed_work_sync(&mb->sds_relatch)
calls in rtl8365mb_pcs_config(), rtl8365mb_pcs_disable() or
rtl8365mb_teardown() runs. The devres cancel action only runs on unbind.

A run might already be past the drvdata check when shutdown clears
drvdata. If so, it can still park SDS_MISC, sleep for 20 ms, do the
restore writes and re-arm itself, all after .shutdown has returned.

device_shutdown() shuts down children before parents. The parent MDIO
bus or Ethernet controller may therefore already be shut down at that
point. If the restore fails, the SerDes stays parked.

To trigger it, you need an RTL8367S-VB with a 2500base-x CPU port, where
rtl8365mb_pcs_config() schedules the work and it re-arms every 1-10 s,
followed by a reboot or kexec.

The drvdata check acts as a flag guarding a code section rather than a
real synchronization point. The plain dev_get_drvdata()/dev_set_drvdata()
pair is also an unannotated data race.

The earlier "re-latch the family D SerDes" commit says the work "does
nothing once the driver data is gone". That only holds for runs that
start after the store.

Would it make sense to call cancel_delayed_work_sync(&mb->sds_relatch)
from a shutdown hook before drvdata is cleared?

> +		.extints = {
> +			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
> +			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
> +				PHY_INTF(RMII) | PHY_INTF(RGMII) },
> +		},

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/38872e6f-1264-4a93-9f81-8212173e909d%40yahoo.com
