Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096944;
	b=2vUkE9nSO38RazyjqM95IAiFC+9cIJ2WwlgcBCF1mXWUexHMGIkcPSZk1Ktjm0lEy3RU
	 cDL0t5BDW3R5U/sEijSsYqxvGE4oLxa9b3IBa8m/Mm0bWL5WreFNQVE/XphZSxBG2rfPQ
	 UnY9h10JQU5Ke5pncAs6dv3yCBvGwTU/LPoGSd5meX9KrdlpYhygPSJ+wLbvzeM822wFq
	 +4apvaW7IARmhZAnW80isA8UQ77aLW1ub1L81IU7GKtE8Q9Id7NBTT/O/BY6ljwe6M5XV
	 L4A6yvUJ1IR0oJKI8xRgLkXcAJm7QWdeSFxkg1pq1CdhfScWjAIwiG/KdEwNqe4YLhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096944;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=O3eLYnrWtMcmLl8Fja5SDTOgJdL1YtWaGoPr0zyCNCA=;
	b=wkqgXwAVKpvF+KRySCFWNk6PBNicxtPIUzerHntP3vMvS0jWOPenu/QVykN62DKCaDTZ
	 u6JFEIH2TnKBWJzu5KGSN0PxFhFFDQy7X7FWZvRAHg/LaWjpeoFGTvc2ecWBwSmjkkTeC
	 2Ee9cGpQVfIYMl0nvgWGcpq1aqXGE3vhn9NGB8A3liyXCX/N4ukGx1J3i3gcFuYRJAH9F
	 lsQpZpo0X0kW1xXZ5otF6hhfhH4+79oPR+388o4Jo1tvakPbENft1Vg7d505pZjq0Hlpk
	 lx4z8ahMEnpugMrC88Wp6BTs6CBVC3ZPP8zldA1Yw6J8fqJjrN2mFQO1FUSJTWL/PfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDMAlAW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDDC606D804;
	Sun,  8 Nov 2026 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDMAlAW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE11A1F008BC;
	Sun,  8 Nov 2026 00:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096943;
	bh=O3eLYnrWtMcmLl8Fja5SDTOgJdL1YtWaGoPr0zyCNCA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lDMAlAW+Nzj+5QkDUpUE0S+1oJC9fDaLnP7dX1cI2qwyi25TEOIuQkeo7CTdg0jhN
	 kYXYZusFtvOjiZsej7rgREdi4dDFnvS4nEtFWFDFak/qPGeDRLZAJzvR3L2JrnRMEI
	 ppa1pEX2EJw44G9Y7E1/zITVI/LPhtch5zmm5r0tQJEaoEGoUUd1daFlmhtEsAImNf
	 51Cmqyb04zQ4UhP2KqBoPkFca8/pf3XbHi+rm6chWq79MetVruesY58BnY97vOa7sh
	 8n/F2gofoBk8c5P6+MQdU4NNYBDzABAWmOlAcMcFyC1+a9K4ZZpyjrVcWE5gLXgdCI
	 jIQLjo52tsY/g==
Subject: Re: [PATCH net-next v10 08/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sun, 08 Nov 2026 00:15:41 +0000
Message-ID: <179409694139.994134.9808308167935611990@kernel.org>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-8-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-8-31b5a69b85b7@onsemi.com>
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

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds Frame-Drop (FD) footer handling to the shared
  OA TC6 RX path in oa_tc6_prcs_rx_chunk_payload()…
- [Medium] s2500_ptp_get_time64() (s2500_ptp.c:9-31) reads PTP_SEC (MMS12
  0x1010) and PTPNSEC (0x1011) in one 2-register control burst and…
- [Medium] net: s2500: ethtool -S rx_mismatch_drops duplicates
  rtnl_link_stats64
- [Medium] net: oa_tc6: NULL dereference on capability read failure in
  oa_tc6_init()
- [Low] oa_tc6_rx_cut_through_enable() is exported with
  EXPORT_SYMBOL_GPL, declared in include/linux/oa_tc6.h, and documented…
- [Low] The commit message body leaves out several functional changes.
- [Low] Documentation/networking/oa-tc6-framework.rst (lines 510-515)
  says oa_tc6_tx_credit_threshold_set(tc6, u8 thresh) "Sets the minimum…
- [Low] oa_tc6_init() ignores the return value of the new
  oa_tc6_rx_cut_through_enable() call (oa_tc6_main.c:1826-1827).
- [Low] In the specific multicast-list branch of
  s2500_set_multicast_mode() (s2500_main.c ~lines 254-289), each slot's…
- [Low] s2500_update_stats() (s2500_ethtool.c:141-187) adds every
  hardware MAC counter into software totals with '+=' (lines 171, 175,…

--

onsemi: s2500: Add driver support for S2500 MAC-PHY

This adds a driver for the onsemi S2500 10BASE-T1S MAC-PHY on top of the
OPEN Alliance TC6 framework. It includes PTP, ethtool statistics and
multicast filtering. It also extends the shared oa_tc6 library with RX
cut-through enable, a TX credit threshold helper and frame drop footer
handling.

> diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
> index 3cfe8cb7cf75f..4859f39b11712 100644
> --- a/Documentation/networking/oa-tc6-framework.rst
> +++ b/Documentation/networking/oa-tc6-framework.rst
> @@ -501,6 +501,19 @@ Zero align receive frame feature can be enabled to align all receive ethernet
>  frames data to start at the beginning of any receive data chunk payload with a
>  start word offset (SWO) of zero.
>  
> +.. c:function:: int oa_tc6_rx_cut_through_enable(struct oa_tc6 *tc6);
> +
> +Receive cut-through mode can be enabled, when supported by the MAC-PHY, to
> +start transferring a received frame to the SPI host before the whole frame has
> +been received from the network.

[Severity: Low]
Can a MAC-PHY driver actually use this helper the way it is documented
here?

The comment added to oa_tc6_init() says:

	/* Cut through bits must be configured before SYNC bit is set
	 * in CONFIG0 register.
	 */

But oa_tc6_init() sets SYNC itself before it returns the handle:

oa_tc6_init()
    oa_tc6_enable_data_transfer()
        value |= OA_TC6_CONFIG0_SYNC;

A driver only gets a tc6 pointer after oa_tc6_init() returns. So any
external call to oa_tc6_rx_cut_through_enable() would set RXCTE after
SYNC. The only working path seems to be the OA_TC6_CONFIG_RXCTE quirk,
and this section doesn't mention it.

Should the helper stay internal, with the documentation describing the
quirk instead?

There is a related gap. oa_tc6_tx_credit_threshold_set() changes another
CONFIG0 field from s2500_init(), after SYNC. lan865x also calls
oa_tc6_zero_align_receive_frame_enable() after oa_tc6_init(). Could the
documentation say which CONFIG0 fields can be changed after SYNC?

> +
> +.. c:function:: int oa_tc6_tx_credit_threshold_set(struct oa_tc6 *tc6, \
> +                                                   u8 thresh);
> +
> +Sets the minimum number of free transmit credits that must be available
> +before the MAC-PHY asserts the interrupt. The default is one credit
> +according to OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface specification.

[Severity: Low]
This reads as though thresh is a credit count. The implementation actually
takes the raw 2-bit TXCTHRESH field code:

	regval |= FIELD_PREP(OA_TC6_CONFIG0_TXCTHRESH_MASK, thresh);

thresh is a runtime argument of an exported function, so FIELD_PREP won't
catch out-of-range values at compile time. A caller following this text
and passing 8 gets (8 << 10) & GENMASK(11, 10) == 0. That silently
programs the 1-credit threshold. Passing 4 or 16 also ends up as 0.

include/linux/oa_tc6.h only defines OA_TC6_CONFIG0_TXCTHRESH_8. Could the
documentation describe the encoding? Defines for the other thresholds and
a range check on thresh would also help.

[ ... ]

> diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
> index 5b2454b759740..8231ba0da1586 100644
> --- a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
> +++ b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c

[ ... ]

> @@ -1176,6 +1179,25 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
>  	if (tc6->wait_until_start_valid)
>  		return 0;
>  
> +	/* Drop the frame, if footer sets FD bit. Checking FD bit
> +	 * becomes important, when cut through operation is enabled.
> +	 */
> +	if (end_valid && frame_drop) {
> +		oa_tc6_cleanup_ongoing_rx_skb(tc6);

[Severity: Medium]
Nothing here checks tc6->quirk_flags & OA_TC6_CONFIG_RXCTE or
tc6->ctc_capable. Doesn't this change RX behaviour for every OA TC6
driver?

lan865x_probe() calls oa_tc6_init(spi, netdev, NULL), and the adin1140
probe doesn't enable cut-through either. On those devices, frames with
EV=1 and FD=1 used to be delivered. They are now dropped and counted in
rx_dropped.

The commit message ties this to the s2500 quirk:

    RX cut through is enabled through the quirk flags. Due to
    this feature:
    1) RXCTE bit is set before SYNC bit is set.
    2) Frame is dropped when Frame drop bit in footer is set.

Per the OA TC6 spec, dropping FD frames is probably right for all devices.

Would this be better as a separate oa_tc6 patch, with a commit message
saying it affects all framework users? That way the lan865x and adin1140
maintainers see it, and it can be bisected or backported on its own. The
new exported helpers, quirk flag and capability bit could go in that
series too.

> +
> +		/* Full frame in this chunk. Nothing to free. Move on to
> +		 * next chunk.
> +		 */

[ ... ]

> @@ -1746,6 +1820,12 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>  		goto phy_exit;
>  	}
>  
> +	/* Cut through bits must be configured before SYNC bit is set
> +	 * in CONFIG0 register.
> +	 */
> +	if (tc6->quirk_flags & OA_TC6_CONFIG_RXCTE)
> +		oa_tc6_rx_cut_through_enable(tc6);

[Severity: Medium]
This goto was added earlier in the series, not here, but the new
cut-through code sits right after it. Doesn't this oops if the STDCAP
read fails?

oa_tc6_phy_init() hasn't run yet at this point. So tc6->phydev and
tc6->mdiobus are still NULL from devm_kzalloc(). s2500_probe() doesn't
set OA_TC6_BROKEN_PHY, so the error path does:

oa_tc6_phy_exit()
    phy_disconnect(tc6->phydev)          <- NULL
    oa_tc6_mdiobus_unregister(tc6)
        mdiobus_unregister(tc6->mdiobus) <- NULL

A single SPI error while reading OA_TC6_REG_STDCAP during probe then
becomes a NULL pointer dereference instead of a failed probe.

The other steps before oa_tc6_phy_init(), such as
oa_tc6_unmask_macphy_error_interrupts(), simply return ERR_PTR(ret).
Should this one do the same? The fix probably belongs in the patch
that added oa_tc6_update_standard_capability().

The oa_tc6_rx_cut_through_enable() call also runs before
oa_tc6_phy_init(). If its return value gets checked, that error path
will need a direct return as well, not goto phy_exit.

[Severity: Low]
Should the return value be checked here? Every other control register
step in oa_tc6_init() fails the init on error.

oa_tc6_rx_cut_through_enable() can fail on the CONFIG0 read or write, for
example on an SPI error or a control reply check mismatch. Init then
continues, and oa_tc6_enable_data_transfer() sets SYNC with RXCTE clear.

>From then on the device runs store-and-forward for as long as the driver
is bound, and nothing is logged. Could this at least warn, or return an
error?

> +
>  	ret = oa_tc6_unmask_macphy_error_interrupts(tc6);

[ ... ]

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c
> new file mode 100644
> index 0000000000000..062cab9460dcf
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c

[ ... ]

> +static void s2500_update_stats(struct s2500_info *priv)
> +{
> +	u64 *data = priv->stats_data;
> +	u32 *regs, *rptr, addr;
> +	int ret;
> +
> +	if (time_is_after_jiffies(priv->stats_read_at +
> +				  S2500_STATS_CACHE_PERIOD))
> +		return;
> +
> +	regs = kmalloc_array(S2500_NUM_STAT_REGS, sizeof(u32), GFP_KERNEL);
> +	if (!regs)
> +		return;
> +
> +	addr = FIELD_PREP(S2500_REG_MMS_MASK, OA_TC6_MAC_MMS1) |
> +			  S2500_REG_MAC_STOCTECTSTXL;
> +	ret = oa_tc6_read_registers(priv->tc6, addr, regs,
> +				    S2500_NUM_STAT_REGS);
> +	if (ret)
> +		goto out;

[ ... ]

> +	/* Rest are 32-bit values until RX bytes register. */
> +	for (rptr += 2; (rptr - regs) < STAT_REG_OFFSET(OCTECTSRXL); ++rptr)
> +		*(data++) += *rptr;

[Severity: Low]
The += accumulation only works if the S2500 MAC counters clear on read.
Do they? Neither the code nor the commit message says so.

If they do clear on read, counts can get lost in two ways.

First, the counters are only read when userspace asks for ethtool stats,
and nothing collects them periodically. At 10 Mb/s with minimum-size
frames, a 32-bit frame counter fills in about 80 hours.

Second, oa_tc6_read_registers() can return an error after the SPI
transfer has completed, for example when oa_tc6_check_ctrl_read_reply()
fails. By then the hardware has already cleared the counters, but the
goto out path throws regs[] away.

If the counters are free-running instead, wouldn't += count them twice on
every read?

[ ... ]

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_main.c b/drivers/net/ethernet/onsemi/s2500/s2500_main.c
> new file mode 100644
> index 0000000000000..03495fedac98c
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_main.c

[ ... ]

> +static int s2500_init(struct s2500_info *priv)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* Configure MAC-PHY's behavior */
> +	ret = oa_tc6_tx_credit_threshold_set(priv->tc6,
> +					     OA_TC6_CONFIG0_TXCTHRESH_8);

[Severity: Low]
This isn't a bug, but the commit message body doesn't mention that this
raises the TX credit threshold from the default of 1 credit to 8. That
changes when the MAC-PHY raises its interrupt. The change is only noted
in the v10 changelog below the --- line, which is dropped when the patch
is applied.

The body also doesn't mention:

- the new exported oa_tc6 APIs, oa_tc6_tx_credit_threshold_set() and
  oa_tc6_rx_cut_through_enable()
- the OA_TC6_CONFIG_RXCTE quirk
- the ctc_capable bit
- the new CONFIG0 and STDCAP definitions

Could these be described in the commit message?

> +	if (ret)
> +		return ret;

[ ... ]

> +	} else {
> +		u32 addrh, addrl;

[ ... ]

> +		/* Slot 0 holds the unicast MAC, multicast starts at 1 */
> +		i = 1;
> +		netdev_hw_addr_list_for_each(ha, mc) {
> +			const u8 *mac = ha->addr;
> +			int slot = i++;
> +
> +			addrh = S2500_MAC_ADDRFILT_ENABLE |
> +				get_unaligned_be16(mac);
> +			addrl = get_unaligned_be32(&mac[2]);
> +
> +			addr = S2500_REG_MAC_ADDRFILTH(slot);
> +			ret = oa_tc6_write_register_mms(priv->tc6,
> +							mms, addr,
> +							addrh);

[Severity: Low]
This enables the slot before its ADDRFILTL and mask registers are
written. Was that intended?

When coming from the allmulti or overflow branch, slot 1 still has
ADDRMASKL=0 and ADDRMASKH=0x100. So between this write and the mask
writes below, the slot matches all multicast. If a later write fails, the
slot is left enabled with a mix of old and new values.

The allmulti branch and s2500_set_mac_filter() write the masks first,
then ADDRFILTL, and ADDRFILTH with the enable bit last. Could this branch
use the same order?

> +			if (ret)
> +				return ret;
> +
> +			addr = S2500_REG_MAC_ADDRFILTL(slot);

[ ... ]

> diff --git a/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
> new file mode 100644
> index 0000000000000..07db928dd732a
> --- /dev/null
> +++ b/drivers/net/ethernet/onsemi/s2500/s2500_ptp.c
> @@ -0,0 +1,163 @@

[ ... ]

> +	ptp_read_system_prets(ptp_sts);
> +	addr = FIELD_PREP(S2500_REG_MMS_MASK,
> +			  OA_TC6_PHY_C45_VS_MMS12) |
> +			  S2500_REG_VS_PTP_SEC;
> +	ret = oa_tc6_read_registers(priv->tc6, addr, &data[0], 2);
> +	ptp_read_system_postts(ptp_sts);
> +
> +	if (!ret) {
> +		ts->tv_sec = data[0];
> +		ts->tv_nsec = data[1];

[Severity: Medium]
Does the S2500 latch PTPNSEC when PTP_SEC is read? The octet statistics
registers have a comment describing this kind of latching, but the PTP
time registers have nothing similar.

Without such a latch, a read near a seconds rollover could pair the old
second with a wrapped nanosecond value, and be off by almost a second.
That value goes back through gettimex64. It is also used by the
read-modify-write in s2500_ptp_step_time() for adjtime, which would then
write a wrong time to the clock.

Also, tv_nsec is assigned without masking. SETNSEC uses bit 31 as an
execute bit. If PTPNSEC has status bits above the nanosecond field,
couldn't tv_nsec come back >= NSEC_PER_SEC?

> +	}

[ ... ]

> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2026 Semiconductor Components Industries, LLC ("onsemi").
> + * onsemi's S2500 10BASE-T1S MAC-PHY driver
> + */
> +
> +#include <linux/ethtool.h>
> +#include <linux/phy.h>
> +
> +#include "s2500_hw_def.h"
> +
> +#define S2500_NUM_REGS			38
> +#define S2500_REGDUMP_LEN		(sizeof(u32) * (S2500_NUM_REGS * 2))
> +
> +#define S2500_NUM_MAC_STATS		1
> +#define S2500_NUM_RMON_STATS		12
> +
> +struct s2500_reg_map {
> +	u16 reg;
> +	u8 mms;
> +};
> +
> +static const struct s2500_reg_map s2500_reg_map[S2500_NUM_REGS] = {
> +	{ S2500_REG_VS_ONIPVER,      OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_TWEAKS1,      OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_PLCAEXT,      OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_PMATUNE0,     OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_PMATUNE1,     OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_T1SWUPTUNE,   OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_HDD,          OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_DCQ_TOID,     OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_DCQ_SQI,      OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_DCQ_SQI_PLUS, OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_HDD_TUNE1,    OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_HDD_TUNE2,    OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_HDD_TUNE3,    OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_WS_STATUS_0,  OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_WS_CTRL_0,    OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_WS_STATUS_1,  OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_WS_CTRL_1,    OA_TC6_PHY_C45_VS_PLCA_MMS4 },
> +	{ S2500_REG_VS_MIIMIRQE,     OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_MIIMIRQS,     OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_DIOCFG0,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CHIPID,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_TWEAKS2,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_MACID0,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_MACID1,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_NVM_HEALTH,   OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_PTP_SEC,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_PTPNSEC,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_PTP_SETSEC,   OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_SETNSEC,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_PTP_ADJ,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CMPCTL,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CMPSEC,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CMPNSEC,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CMPPER,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CAPCTL,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CAPSEC,       OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_CAPNSEC,      OA_TC6_PHY_C45_VS_MMS12 },
> +	{ S2500_REG_VS_BCNCNT,       OA_TC6_PHY_C45_VS_MMS12 },
> +};
> +
> +enum s2500_stat_idx {
> +	S2500_MSTOCTECTSTX_IDX = 0,
> +	S2500_MSTFRAMESTXOK_IDX,
> +	S2500_MSTBCASTTXOK_IDX,
> +	S2500_MSTMCASTTXOK_IDX,
> +	S2500_MSTFRAMESTX64_IDX,
> +	S2500_MSTFRAMESTX65_IDX,
> +	S2500_MSTFRAMESTX128_IDX,
> +	S2500_MSTFRAMESTX256_IDX,
> +	S2500_MSTFRAMESTX512_IDX,
> +	S2500_MSTFRAMESTX1024_IDX,
> +	S2500_MSTTXUNDEFLOW_IDX,
> +	S2500_MSTSINGLECOL_IDX,
> +	S2500_MSTMULTICOL_IDX,
> +	S2500_MSTEXCESSCOL_IDX,
> +	S2500_MSTDEFERREDTX_IDX,
> +	S2500_MSTCRSERR_IDX,
> +	S2500_MSTOCTECTSRX_IDX,
> +	S2500_MSTFRAMESRXOK_IDX,
> +	S2500_MSTBCASTRXOK_IDX,
> +	S2500_MSTMCASTRXOK_IDX,
> +	S2500_MSTFRAMESRX64_IDX,
> +	S2500_MSTFRAMESRX65_IDX,
> +	S2500_MSTFRAMESRX128_IDX,
> +	S2500_MSTFRAMESRX256_IDX,
> +	S2500_MSTFRAMESRX512_IDX,
> +	S2500_MSTFRAMESRX1024_IDX,
> +	S2500_MSTRUNTSERR_IDX,
> +	S2500_MSTRXTOOLONG_IDX,
> +	S2500_MSTFCSERRS_IDX,
> +	S2500_MSTSYMBOLERRS_IDX,
> +	S2500_MSTALIGNERRS_IDX,
> +	S2500_MSTRXOVERFLOW_IDX,
> +	S2500_MSTRXDROPPED_IDX,
> +};
> +
> +static const char s2500_mac_stat_strings[][ETH_GSTRING_LEN] = {
> +	"rx_mismatch_drops",
> +};
> +
> +static const u8 s2500_mac_stat_map[S2500_NUM_MAC_STATS] = {
> +	S2500_MSTRXDROPPED_IDX,
> +};
> +
> +static const u8 s2500_rmon_stat_map[S2500_NUM_RMON_STATS] = {
> +	S2500_MSTFRAMESTX64_IDX,
> +	S2500_MSTFRAMESTX65_IDX,
> +	S2500_MSTFRAMESTX128_IDX,
> +	S2500_MSTFRAMESTX256_IDX,
> +	S2500_MSTFRAMESTX512_IDX,
> +	S2500_MSTFRAMESTX1024_IDX,
> +	S2500_MSTFRAMESRX64_IDX,
> +	S2500_MSTFRAMESRX65_IDX,
> +	S2500_MSTFRAMESRX128_IDX,
> +	S2500_MSTFRAMESRX256_IDX,
> +	S2500_MSTFRAMESRX512_IDX,
> +	S2500_MSTFRAMESRX1024_IDX,
> +};
> +
> +static const struct ethtool_rmon_hist_range s2500_rmon_hist_ranges[] = {
> +	{ 64, 64 },
> +	{ 65, 127 },
> +	{ 128, 255 },
> +	{ 256, 511 },
> +	{ 512, 1023 },
> +	{ 1024, 2000 },
> +	{ },
> +};
> +
> +#define S2500_MAC_STATS_LEN ARRAY_SIZE(s2500_mac_stat_strings)
> +static_assert(S2500_MAC_STATS_LEN == S2500_NUM_MAC_STATS);
> +static_assert(ARRAY_SIZE(s2500_mac_stat_map) == S2500_NUM_MAC_STATS);
> +static_assert(ARRAY_SIZE(s2500_rmon_stat_map) == S2500_NUM_RMON_STATS);
> +
> +#define STAT_REG_OFFSET(x) ((S2500_REG_MAC_ST##x) - \
> +			   S2500_REG_MAC_FIRST_STAT)
> +
> +static void s2500_update_stats(struct s2500_info *priv)
> +{
> +	u64 *data = priv->stats_data;
> +	u32 *regs, *rptr, addr;
> +	int ret;
> +
> +	if (time_is_after_jiffies(priv->stats_read_at +
> +				  S2500_STATS_CACHE_PERIOD))
> +		return;
> +
> +	regs = kmalloc_array(S2500_NUM_STAT_REGS, sizeof(u32), GFP_KERNEL);
> +	if (!regs)
> +		return;
> +
> +	addr = FIELD_PREP(S2500_REG_MMS_MASK, OA_TC6_MAC_MMS1) |
> +			  S2500_REG_MAC_STOCTECTSTXL;
> +	ret = oa_tc6_read_registers(priv->tc6, addr, regs,
> +				    S2500_NUM_STAT_REGS);
> +	if (ret)
> +		goto out;
> +
> +	priv->stats_read_at = jiffies;
> +	rptr = regs;
> +
> +	/* TX bytes is a 64-bit value that is stored in two regs.
> +	 * When lower 32 bits are read from OCTETS-L register,
> +	 * upper bits are sampled and stored in OCTETS-H register.
> +	 * Request to read multiple registers reads OCTETS-L first.
> +	 * This way, counter value is read in an atomic manner.
> +	 */
> +	*(data++) += ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
> +
> +	/* Rest are 32-bit values until RX bytes register. */
> +	for (rptr += 2; (rptr - regs) < STAT_REG_OFFSET(OCTECTSRXL); ++rptr)
> +		*(data++) += *rptr;
> +
> +	/* RX bytes is a 64-bit value that is stored in two regs.
> +	 * Like TX bytes counter, value is read atomically from
> +	 * registers.
> +	 */
> +	*(data++) += ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
> +
> +	for (rptr += 2; (rptr - regs) < S2500_NUM_STAT_REGS; ++rptr)
> +		*(data++) += *rptr;
> +out:
> +	kfree(regs);
> +}
> +
> +static void s2500_get_drvinfo(struct net_device *ndev,
> +			      struct ethtool_drvinfo *info)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +
> +	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
> +	strscpy(info->bus_info, dev_name(&priv->spi->dev),
> +		sizeof(info->bus_info));
> +}
> +
> +static int s2500_get_sset_count(struct net_device *ndev, int sset)
> +{
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return S2500_MAC_STATS_LEN;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void s2500_get_strings(struct net_device *ndev, u32 stringset,
> +			      u8 *buf)
> +{
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		memcpy(buf, s2500_mac_stat_strings,
> +		       S2500_MAC_STATS_LEN * ETH_GSTRING_LEN);
> +		break;
> +	}
> +}
> +
> +static void s2500_get_ethtool_stats(struct net_device *ndev,
> +				    struct ethtool_stats *stats, u64 *data)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	int i;
> +
> +	s2500_update_stats(priv);
> +	for (i = 0; i < S2500_NUM_MAC_STATS; i++)
> +		data[i] = priv->stats_data[s2500_mac_stat_map[i]];
> +}
> +
> +static void s2500_get_eth_mac_stats(struct net_device *ndev,
> +				    struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	const u64 *st;
> +
> +	if (mac_stats->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
> +	s2500_update_stats(priv);
> +	st = priv->stats_data;
> +
> +	mac_stats->OctetsTransmittedOK = st[S2500_MSTOCTECTSTX_IDX];
> +	mac_stats->FramesTransmittedOK = st[S2500_MSTFRAMESTXOK_IDX];
> +	mac_stats->BroadcastFramesXmittedOK = st[S2500_MSTBCASTTXOK_IDX];
> +	mac_stats->MulticastFramesXmittedOK = st[S2500_MSTMCASTTXOK_IDX];
> +	mac_stats->SingleCollisionFrames = st[S2500_MSTSINGLECOL_IDX];
> +	mac_stats->MultipleCollisionFrames = st[S2500_MSTMULTICOL_IDX];
> +	mac_stats->FramesAbortedDueToXSColls = st[S2500_MSTEXCESSCOL_IDX];
> +	mac_stats->FramesWithDeferredXmissions = st[S2500_MSTDEFERREDTX_IDX];
> +	mac_stats->CarrierSenseErrors = st[S2500_MSTCRSERR_IDX];
> +	mac_stats->FramesLostDueToIntMACXmitError =
> +		st[S2500_MSTTXUNDEFLOW_IDX];
> +	mac_stats->OctetsReceivedOK = st[S2500_MSTOCTECTSRX_IDX];
> +	mac_stats->FramesReceivedOK = st[S2500_MSTFRAMESRXOK_IDX];
> +	mac_stats->BroadcastFramesReceivedOK = st[S2500_MSTBCASTRXOK_IDX];
> +	mac_stats->MulticastFramesReceivedOK = st[S2500_MSTMCASTRXOK_IDX];
> +	mac_stats->FrameTooLongErrors = st[S2500_MSTRXTOOLONG_IDX];
> +	mac_stats->FrameCheckSequenceErrors = st[S2500_MSTFCSERRS_IDX];
> +	mac_stats->AlignmentErrors = st[S2500_MSTALIGNERRS_IDX];
> +	mac_stats->FramesLostDueToIntMACRcvError =
> +		st[S2500_MSTRXOVERFLOW_IDX];
> +}
> +
> +static void s2500_get_eth_phy_stats(struct net_device *ndev,
> +				    struct ethtool_eth_phy_stats *phy_stats)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +
> +	if (phy_stats->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
> +	s2500_update_stats(priv);
> +	phy_stats->SymbolErrorDuringCarrier =
> +		priv->stats_data[S2500_MSTSYMBOLERRS_IDX];
> +}
> +
> +static void s2500_rmon_stats(struct net_device *ndev,
> +			     struct ethtool_rmon_stats *rmon_stats,
> +			     const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	u8 offset;
> +	int i;
> +
> +	if (rmon_stats->src != ETHTOOL_MAC_STATS_SRC_AGGREGATE)
> +		return;
> +
> +	s2500_update_stats(priv);
> +
> +	rmon_stats->undersize_pkts = priv->stats_data[S2500_MSTRUNTSERR_IDX];
> +	rmon_stats->oversize_pkts = priv->stats_data[S2500_MSTRXTOOLONG_IDX];
> +
> +	for (i = 0; i < 6; i++) {
> +		offset = s2500_rmon_stat_map[i];
> +		rmon_stats->hist_tx[i] = priv->stats_data[offset];
> +	}
> +
> +	for (i = 0; i < 6; i++) {
> +		offset = s2500_rmon_stat_map[i + 6];
> +		rmon_stats->hist[i] = priv->stats_data[offset];
> +	}
> +
> +	*ranges = s2500_rmon_hist_ranges;
> +}
> +
> +static int s2500_get_ts_info(struct net_device *ndev,
> +			     struct kernel_ethtool_ts_info *ts_info)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +
> +	return oa_tc6_get_ts_info(priv->tc6, ts_info);
> +}
> +
> +static int s2500_get_regs_len(struct net_device *dev)
> +{
> +	return S2500_REGDUMP_LEN;
> +}
> +
> +static void s2500_get_regs(struct net_device *ndev,
> +			   struct ethtool_regs *regs, void *p)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +	__be32 *pbuff = p;
> +	int ret = 0;
> +	u32 val;
> +	u16 reg;
> +	u8 mms;
> +	int i;
> +
> +	regs->version = 0;
> +	memset(p, 0, S2500_REGDUMP_LEN);
> +
> +	if (!netif_running(ndev))
> +		return;
> +
> +	for (i = 0; i < S2500_NUM_REGS; i++) {
> +		val = 0;
> +		reg = s2500_reg_map[i].reg;
> +		mms = s2500_reg_map[i].mms;
> +		ret = oa_tc6_read_register_mms(priv->tc6, mms, reg,
> +					       &val);
> +
> +		/* Write a pattern to indicate failure */
> +		if (ret)
> +			val = 0xDEADC0DE;
> +		*pbuff++ = cpu_to_be32(((u32)mms << 16) | reg);
> +		*pbuff++ = cpu_to_be32(val);
> +	}
> +}
> +
> +static void s2500_get_ts_stats(struct net_device *ndev,
> +			       struct ethtool_ts_stats *ts_stats)
> +{
> +	struct s2500_info *priv = netdev_priv(ndev);
> +
> +	oa_tc6_get_ts_stats(priv->tc6, ts_stats);
> +}
> +
> +const struct ethtool_ops s2500_ethtool_ops = {
> +	.get_drvinfo = s2500_get_drvinfo,
> +	.get_link = ethtool_op_get_link,
> +	.get_link_ksettings = phy_ethtool_get_link_ksettings,
> +	.set_link_ksettings = phy_ethtool_set_link_ksettings,
> +	.get_ts_stats = s2500_get_ts_stats,
> +	.get_sset_count = s2500_get_sset_count,
> +	.get_strings = s2500_get_strings,
> +	.get_ethtool_stats = s2500_get_ethtool_stats,
> +	.get_eth_mac_stats = s2500_get_eth_mac_stats,
> +	.get_eth_phy_stats = s2500_get_eth_phy_stats,
> +	.get_rmon_stats = s2500_rmon_stats,
> +	.get_ts_info = s2500_get_ts_info,
> +	.get_regs_len = s2500_get_regs_len,
> +	.get_regs = s2500_get_regs,
> +};
> +

[Severity: Medium]
Isn't this counter already covered by the standard netdev stats?

S2500_REG_MAC_STRXDROPPED counts frames dropped because the
destination MAC address didn't match the filter. struct
rtnl_link_stats64 already has rx_otherhost_dropped for exactly that
case. Documentation/networking/statistics.rst says counters with a
standard uAPI should not be duplicated in ethtool -S.

With this patch, ip -s link and other rtnetlink users never see these
drops. rx_mismatch_drops also becomes a private string that has to be
kept forever once it ships.

The v9 discussion seemed to agree that this vendor counter could be
reported through the existing kernel statistics, but it is still here
in v10. Moving it would leave s2500_get_sset_count(),
s2500_get_strings() and s2500_get_ethtool_stats() with nothing to
report, so they could be dropped.

The move isn't free, though. ndo_get_stats64 can be called in atomic
context, so it can't do the SPI reads that s2500_update_stats() does.
That probably means caching the value, for example from a periodic
work item, and reporting the cached value as rx_otherhost_dropped.
How would you like to handle that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7%40onsemi.com
