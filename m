Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460493;
	b=zisp7KTZ68pvmRSMEMkaW04uwNHEfkny6g9pxQP+qwYw1SEjbu5cs37zpuVk/l8o+6Ou
	 cxwKsDIlpyPWc2Ip72ZUX3cbcVIVbcljJPFKAXWpnRO9MUE8r3JGU/zepj1Q3oL7LoIai
	 zO/dPUiLvi/+7xbkR+oMzP0iEGJW1Un5n+a0Xlb7hfSpHSDwtHDVA2lgiTPuObxZ0TBjD
	 JuoaQYGCmrZe1U3uk3mtvas2VxzX+jJrLxeR5WvPzB7vOd6EbJdhnzygiDGoajfyI2HVf
	 FJ75uQais3HFhbBr90tTklh/AxU300eILLl5eNg6F+RmGf4poZWcGjodWN53FPvJTWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460493;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HvVJzPWPUEM58t9yooUaZfZPELpu4qP6cxiB+4b2lgk=;
	b=hwVMKJWz2B/woJCp5rG7pVTvn2dU46PQ/B4F/MuFsaTG5LC428dxBTigw6C7/HOZgLGe
	 EGNa3G9AGuoehcNarlK7UXdF/3JIIV1yDchxDQCxhTZLaBbiN/Oc9/g35Jd93NfIBNn6g
	 epTDTQ1BxYUtIiLTD5ZHLMCja8Db/beHy044rzzrZyCfSZt1nMDinXlkvb/iCYqKJsRS4
	 i75XkBS9TvJu4BAAElVkso0GeAj3osIyT6xtATEF74GvbEdsW0oxqVmgS3fekv+uMdKPT
	 +LetgiGnOGRjk3ThsDAXTDPvhe+K11H5DHgmZhFpG2P86emT6sCzQ4U8BWoW2S52ZHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXuJJxL7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6B606A31F;
	Tue, 20 Oct 2026 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXuJJxL7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267861F000C5;
	Tue, 20 Oct 2026 01:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460492;
	bh=HvVJzPWPUEM58t9yooUaZfZPELpu4qP6cxiB+4b2lgk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OXuJJxL76KDT/uDwrfpYpyIcTX4Btsj5zoMip5lMe4RvjCirwM/mYVgM3aLDagteD
	 meJRG5LBPChCXU6JkQ6YH81jXCuN5LU00wSsEOJMVHkOPjyHt/7To69U71/j8N3kMh
	 YElF849DgmGaQqXC92wTa0HmivgRpqQ6Ea5HXsIsdi3mLw9QA3jNhKAGoi36iAmIeR
	 s1jH5QngvAv5c8zaNQvetLGdsP3SqKMg/sUJc5h/s1MvSdmjvCQzGfG9n0QI4F0kJg
	 mD443FFIZSHAp67QFYMkbOnyws79cFkd3IxUMvQvha1LSu8JjvJdJqAPRNqFeOLE/v
	 vRnGUHMymabhw==
Subject: Re: [PATCH net-next v6 9/9] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 01:41:31 +0000
Message-ID: <179246049169.3135.1273829069390436722@kernel.org>
In-Reply-To: <3cb754f2-dc21-4de3-b245-b970719925fd@yahoo.com>
References: <3cb754f2-dc21-4de3-b245-b970719925fd@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rtl8365mb_conduit_state_change() in
  drivers/net/dsa/realtek/rtl8365mb_main.c (lines 1819-1835) ignores its…
- [Low] After this patch the rtl8365mb driver detects and supports
  RTL8367S-VB (chip ID 0x6642, version 0x0010) through the new…

--

net: dsa: realtek: rtl8365mb: add support for RTL8367S-VB

This adds the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the
rtl8365mb chip table. It is the first family D chip, with the SerDes on
port 6 and the RGMII interface on port 7. It also caps priv->num_ports at
8 for family D.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index a1155a75356da..dbf21a634e3f0 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -887,6 +894,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
>  		.jam_table = rtl8365mb_init_jam_8365mb_vc,
>  		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
>  	},
> +	{
> +		.name = "RTL8367S-VB",
> +		.chip_id = 0x6642,
> +		.chip_ver = 0x0010,

[Severity: Low]
This isn't a bug, but should the NET_DSA_REALTEK_RTL8365MB help text in
drivers/net/dsa/realtek/Kconfig mention this chip? It still reads:

	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.

The DT binding already lists RTL8367S-VB under realtek,rtl8365mb. The help
text also leaves out RTL8367SB and RTL8367RB-VB.

> +		.family = RTL8365MB_FAMILY_D,
> +		.extints = {
> +			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
> +			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
> +				PHY_INTF(RMII) | PHY_INTF(RGMII) },
> +		},

[Severity: Medium]
This entry makes the family D path reachable. It also lets port 6
(SGMII/HSGMII) and port 7 (RGMII) both be CPU ports.

Does rtl8365mb_conduit_state_change() handle that case? It ignores its
conduit argument:

static void rtl8365mb_conduit_state_change(struct dsa_switch *ds,
					   const struct net_device *conduit,
					   bool operational)
{
	...
	guard(mutex)(&mb->sds_cfg_lock);

	WRITE_ONCE(mb->sds_conduit_up, operational);
	cancel_delayed_work_sync(&mb->sds_relatch);
	if (operational && READ_ONCE(mb->sds_relatch_armed))
		rtl8365mb_sds_relatch_start(mb);
}

DSA sends this notification for every CPU-port conduit, with no filtering
along the way:

dsa_tree_conduit_{admin,oper}_state_change()
  -> dsa_tree_conduit_state_change()
    -> dsa_tree_notify()
      -> dsa_switch_conduit_state_change()
        -> ds->ops->conduit_state_change(ds, info->conduit, ...)

dsa_tree_setup_conduit() also replays the admin and oper state for every
CPU port. rtl8365mb_setup() accepts more than one CPU port through
dsa_switch_for_each_cpu_port().

Suppose both ports are CPU ports and the port 7 conduit goes down while the
port 6 HSGMII conduit is still up. Then sds_conduit_up becomes false, the
sds_relatch work is cancelled, and the 10 s health check for port 6 stops.
If the latch is lost after that, the trunk can show 2.5Gbps/Full and still
pass no frames. That is the failure the re-latch work exists to recover
from.

Now take the reverse case: the port 6 conduit is down and the port 7
conduit comes up. Would the work then start, park SDS_MISC every interval
on a link with no far end, and log "SerDes did not latch" warnings? The
re-latch commit says it avoids this:

  When the conduit goes down the work is stopped, so a link without a far
  end is not reported as lost and not parked every 10 s

The same mismatch looks possible when port 6 runs 2500base-x as a user
port and port 7 is the only CPU port. The RGMII conduit's state would then
start and stop SerDes recovery for the user port.

Could the callback check that conduit belongs to the SerDes CPU port (for
example conduit->dsa_ptr->index == 6) before it updates sds_conduit_up or
touches the work?

The handler was added in "net: dsa: realtek: rtl8365mb: re-latch the
family D SerDes". This patch is the one that makes it reachable.

> +		.jam_table = rtl8365mb_init_jam_8365mb_vc,
> +		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
> +	},
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/5a4715dd-89e0-4868-9ffb-c8fb73b18d04%40yahoo.com
