Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210583;
	b=jOdlTxeV1w1S06M3aTMzaBURQiJH4UBElpZnrwvVDpbbztAzwFFeaeHBnUStdto1+LBq
	 06PYfuWz5i8WY0MuEpYYPFL3p1Y2eDUbl0vruL0YfqwgA9cUzAnHdvU/Nv9SHAR9GP0za
	 Dnyev0/8wl72HDPWYVVRMfjqnTX6ibBAPvCIOa4ILSWUZT8fGD6uCexaPy9HRWIMS70K9
	 05GpoJ/4GL3JZfMj4l6WAUqsm+/PKfCrbHC7Ue6Kxmk3v+8Q+q1h5eivT52prMGb/FTGd
	 fSd2/NnjQLAA3e804PuT6n2XVaHlnIGj58pwz7uiyB3OVNKGx1wdlecSUECtVCnBoMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210583;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WyCMBCcX2kRnjqHFY43Gu0I0yjxEkgsugICLXCwNlrI=;
	b=0ss7fN1OrEQpCYaXZ5hHgMYqry5Ptmt14QAl4afbKKTRVKJLff3DlQLNVPlqDoi6F8rc
	 1KGnAGpZoMvQ5wcEh7c1+0SK5wbiFFsegN2IHSZi5VGrqeuH0fpkzn2TlE6rUYxjHsuHX
	 9/MWvcqJ03M662zfEG9jXrAEivElGOIS5X3cOs4QKWRWgD8SmQVl+KyTL0fU4m6j1yqiJ
	 9Oib+4584wC3b8KdbN0bZmwTEKFmX22Xxx0Eo3n4sQmIdTV8GSfy2/8ztMgm2Va9GIEd3
	 7umTGycq4BSvEJkIrhkZD+7zyP9gNx7TJP9R0Fm/WasuAnQzXd6iiLnjW2Lj6XBT4SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZOYvjqO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B27606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZOYvjqO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092FF1F008A1;
	Mon,  9 Nov 2026 07:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794210582;
	bh=WyCMBCcX2kRnjqHFY43Gu0I0yjxEkgsugICLXCwNlrI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cZOYvjqOOVQf4T/5TWUbPfBl63laUHi/g/ywqFtL1kq/RNZdQf8EeRFL12NmTwgN8
	 F1L/O/7swkjBvbBr+bsw6u6W0xnN5N0drUmhsWN/cqWCSbUq7otSk8rca14+/5QA8d
	 zcrcdIQduGuwzT6murCA5QnzIbpuErn2I826ersWI3SsMcdX2AlHJclNa2LHAXx5px
	 E7bHL7NDNXR5AvN1ObwNh8GYthzgp3Z22WAX9WftJYgiCTyvM93ldUlFMBfkqLGG0s
	 FpDn1xEZzTBekr/uqe8RZrW8q0eVV8rx1TkkylLjQi45PPPoJ9GeuAymsUq/K3aCCb
	 A4/pYYWn3mEKA==
Subject: Re: [PATCH net 2/4] tg3: Select PLL clock when preparing for shutdown
From: netdev-bot+sashiko@kernel.org
To: pavan.chebbi@broadcom.com
Cc: michael.chan@broadcom.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 andrew.gospodarek@broadcom.com, davem@davemloft.net, edumazet@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shravya.k-n@broadcom.com,
 vishvambar.panth-s@broadcom.com
Date: Mon, 09 Nov 2026 07:49:41 +0000
Message-ID: <179421058149.994134.13195419627896454196@kernel.org>
In-Reply-To: <20261108065526.710152-3-pavan.chebbi@broadcom.com>
References: <20261108065526.710152-3-pavan.chebbi@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tg3_power_down_prepare()
  (drivers/net/ethernet/broadcom/tg3.c, around lines 4130-4136), the new…
- [Medium] The patch does an unlocked read-modify-write of
  TG3_CPMU_PLL_CTRL_STAT (0x3638) that sets…

--

tg3: Select PLL clock when preparing for shutdown

The patch works around a 5720 hardware issue where the chip may fail to
wake on a single magic packet after being linked at 1G. When WoL is
enabled and active_speed is SPEED_1000, tg3_power_down_prepare() sets
CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL in the new TG3_CPMU_PLL_CTRL_STAT register.
tg3_chip_reset() clears the bit on every 5720 reset.

> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 2cf9d2ea069b5..e9b48e58fdd45 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -4127,6 +4127,14 @@ static void tg3_power_down_prepare(struct tg3 *tp)
>  	if (device_should_wake) {
>  		u32 mac_mode;
>  
> +		if (tg3_asic_rev(tp) == ASIC_REV_5720 &&
> +		    tp->link_config.active_speed == SPEED_1000) {

[Severity: Medium]
Does active_speed here describe the link the chip will be using while it
waits for the magic packet?

The 5720 does not use phylib. Earlier in tg3_power_down_prepare() the
driver sets TG3_PHYFLG_IS_LOW_POWER and calls tg3_setup_phy(tp, false).
In tg3_setup_copper_phy(), active_speed is only written when the link is
currently up:

    tp->link_config.active_speed = current_speed;

That write is inside the BMSR_LSTATUS branch. At relink,
tg3_phy_copper_begin() then writes a new WoL advertisement and restarts
autoneg, unless KEEP_LINK_ON_PWRDN is set:

    if ((tp->phy_flags & TG3_PHYFLG_IS_LOW_POWER) &&
        !(tp->phy_flags & TG3_PHYFLG_KEEP_LINK_ON_PWRDN)) {
        adv = ADVERTISED_10baseT_Half |
              ADVERTISED_10baseT_Full;
        ...
        if (tp->phy_flags & TG3_PHYFLG_1G_ON_VAUX_OK) {
            ...
            adv |= ADVERTISED_1000baseT_Full;
        }

Nothing updates active_speed after that, so this check reads the speed
from before the WoL renegotiation, or a stale value. A few cases look
possible:

  - 1G_ON_VAUX_OK is set, and the link was at 100M before shutdown (for
    example, limited with ethtool) or was down. The PHY renegotiates to
    1G on Vaux, but the PLL bit is never set.

  - KEEP_LINK_ON_PWRDN is set, the cable was unplugged at shutdown, and a
    1G link comes up later during WoL. active_speed is stale, so the bit
    is not set.

  - Neither flag is set, so the WoL link drops to 10/100. The bit is set
    anyway because active_speed is still 1000 from earlier.

The existing active_speed check further down this block, for GMII vs
MII, is guarded by KEEP_LINK_ON_PWRDN, where the link is kept as is. This
new check has no such guard and does not look at tp->link_up.

The commit message says "When the 5720 was linked up at 1G". Does that
mean the link before shutdown or the link during WoL? If it means the WoL
link, could the first two cases still hit the reported wake failure?

> +			u32 val = tr32(TG3_CPMU_PLL_CTRL_STAT);
> +
> +			tw32(TG3_CPMU_PLL_CTRL_STAT,
> +			     val | CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL);
> +		}
> +

[ ... ]

> @@ -9394,6 +9402,12 @@ static int tg3_chip_reset(struct tg3 *tp)
>  
>  	tg3_restore_clk(tp);
>  
> +	if (tg3_asic_rev(tp) == ASIC_REV_5720) {
> +		val = tr32(TG3_CPMU_PLL_CTRL_STAT);
> +		tw32(TG3_CPMU_PLL_CTRL_STAT,
> +		     val & ~CPMU_PLL_TLP_CLCK_SRC_NCSI_PLL);
> +	}

[Severity: Medium]
Is TG3_CPMU_PLL_CTRL_STAT per-function, or is it shared between the two
functions of the 5720?

The 5720 is a dual-function device, and this bit selects the clock for
the PCIe transaction layer. The driver already treats parts of the 5720
CPMU block as chip-wide. For example, tg3_set_function_status() keeps
per-function fields in TG3_CPMU_DRV_STATUS, serialized by the APE GPIO
lock:

    status = tr32(TG3_CPMU_DRV_STATUS);

    shift = TG3_APE_GPIO_MSG_SHIFT + 4 * tp->pci_fn;

If 0x3638 is shared, a chip reset of the other port would clear the bit
that this port set in tg3_power_down_prepare(). That reset could come
from tg3_open(), reset_task, an MTU change, an ethtool self-test, or that
port's own tg3_close()->tg3_halt() during shutdown.

As an example, say port 0 has WoL at 1G and port 1 has WoL disabled. Both
are closed during shutdown, and port 1's halt clears the bit. Would port
0 then be back in the failing state?

Each function's read-modify-write also runs under its own tp->lock only,
so concurrent updates from the two functions could lose an update.

If the register is per-function, none of this applies. Could the scope of
this register be documented? If it is shared, could access be coordinated
across functions, as the driver does for other shared power-management
state on this ASIC?

> +
>  	/* Increase the core clock speed to fix tx timeout issue for 5762
>  	 * with 100Mbps link speed.
>  	 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108065526.710152-1-pavan.chebbi%40broadcom.com
