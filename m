Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406E37F8DA;
	Thu, 20 Aug 2026 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787196807; cv=none; b=jqvXxIdOrCiWEAK/ZBrhyI/k15yAATpyUx/2042TXyynrip58FxPZ6qtlPWrMdvjGquHmy2d4C66HMlhHMuwvgo4y+OzdLJSd5iAny6tJsoRmi9W0M2d+YkyZTjVtK1B5x7UohaIMVVeIhnT8/Vfxb9SEVnH5FoWCu2aUT3rUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787196807; c=relaxed/simple;
	bh=17iH47ZVHXTRVBqve7ISOqLsaKPDW7MsqW1yDqJ3630=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5UmQr2K91fl5wA+zQdu3FfgmOcgFlkPPEkMyLS5fEs2DOVbE/L7wxmvJA0TflMvVhHZ94ImEUu02KEN26Jum4nrJRPTg+duodr/Zi2LbQuT2mUOL3HvQ5jV7SuYxGaJ5Z+csys5XvgQugzbNg4wS3Jm0haUEgOH123qRoxOSEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1787196734tca429f98
X-QQ-Originating-IP: o03SO3XYq9VArfdtU0lF8jdoe9tINhtZt0Eph5MrNOQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Aug 2026 11:32:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15744208924050253270
EX-QQ-RecipientCnt: 11
Date: Thu, 20 Aug 2026 11:32:12 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v9 4/4] net: rnpgbe: Add link status handling
 support
Message-ID: <0B1894BBE93DB8F9+20260820033212.GD2730731@nic-Precision-5820-Tower>
References: <20260814111317.1741087-1-dong100@mucse.com>
 <20260814111317.1741087-5-dong100@mucse.com>
 <20260818120418.GD265046@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818120418.GD265046@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MdKdA9ays6RQ+18RMBgiEvZCdyr9UYNDlp7P4ipNXcjDuX0zvLe0Vrwl
	H4IO1v0dybtLkEtfcvssOYMHOI3JJcZlJDTrcbnurSejfQy9HkQ52VCae51BoG+QdVlBB5X
	jB998Sp3SQraL5MZVUt1epCDfS/rLYbrl4Rcw4M2I8I6Cjp1coMllkVrMGGvdJiOrG9tdY3
	2+qWfYCguJv2eGmCqjHuA+lBJAb/Oz7HOWB6wvqQL3/6DG3R+zvI/5Rm3IXfINg0bCtHVeM
	ui0+V7RJuNcBRPksGe1Gag8n0X3w24pAZxbJgmc07r/Beb0T+8VlKs329gCdAoEDdz/1bne
	sj1U9h6Fv3IN5S6wgI4noEZ9BbCvQilmW7SmY/uLhSbWDZClYAIj0wb1U/WipOmv9P3rxl9
	uuFmFJrEWcezxSXHX7FOnigm9uETrdMOycNtt1VaSjCbMpauvhRXMJywk3t9Ad0ovg6kucy
	EvTeWKlRS+ItJFtTXYIiHjUQpTwHzj5UHYDPwlBMY1gJ4iM+6Uy4FNiZk0qWRXkjxZe0k+e
	ljyycoRFCWhkx6SnVHhBdXlcD76zYeuNCdj4HvFof3wgYeCWSDp9RwI3l/4E2W9zt71Ifpr
	ZRIpIVK4/frYjG7rXnP32zdRVzcB5OJC/r1/IY3yrMoM+akZzZ9TSOLlnUFn2Yj8UZ8bIZK
	re7IKU28AvAiNRKg6V5K8A+kUv8p5/IyoWwv1h4yjBeadjSSezrp0wlKw5Ayr8kk5KG0fHb
	W6C2zNxNljiCssGnDNQhiLyiwnrSyJWva27tGg2U9LnFw+2W/RqoXleOgLWrEWv3u77daYV
	z1EFgzzAwN5Ka2bR+KpMi043HsR6iWmyCd+DJLdfIPokj7Eb4FeKJhxE1Ij5qGUfbbKJ9Uq
	Xe5r225nzGAKvRW7IljVZLDEXw7ERMzhbF8V8CvewMgzRUzFio7FreQ3iF0Mx2VmIBEw9kG
	0aV6ejv8KbybCA61+ifZFVjPJXcPIQUIcdfggF+o4GsHDuVOceTSf99C8bkPkdDDBb+9ttD
	KqnaOjSsRo3cqS1dCXzyo1dCP/RidLs0Q+J2OlfFE6duynHFZ6N7jD7V0fksxLUDn8CXDKq
	p5AOTYcw3pLQToLdYWgTaNSOEs3lu+QsopF0ieVk2UZF7oT+6srVVk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Tue, Aug 18, 2026 at 01:04:18PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814111317.1741087-2-dong100@mucse.com?part=4
> ---
> --- Patch [4]: [PATCH net-next v9 4/4] net: rnpgbe: Add link status handling support ---
> commit b6af113d772d4dd7e20d76a3f509b4e2063a20db
> Author: Dong Yibo <dong100@mucse.com>
> 
> net: rnpgbe: Add link status handling support
> 
> This adds firmware-driven link status handling to the rnpgbe driver: link
> state fields in struct mucse_hw, LINK_CHANGE_EVT parsing over the mailbox,
> and a 500 ms delayed service task that flips the carrier.  It also notifies
> firmware of port up/down, makes rnpgbe_up_complete() return an error so
> ndo_open can fail, and enables the GMAC receiver in receive-all mode.
> 
> A few questions below.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 291e77d573fe6..55b4abed82bd7 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> 
> [ ... ]
> 
> > @@ -149,3 +155,32 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> >  
> >  	return 0;
> >  }
> > +
> > +/**
> > + * rnpgbe_set_link - Set the hardware link state
> > + * @hw: hw information structure
> > + * @linkup: link on or not
> > + *
> > + * rnpgbe_set_link setup link status
> > + *
> > + **/
> > +void rnpgbe_set_link(struct mucse_hw *hw, bool linkup)
> > +{
> > +	u32 value = mucse_hw_rd32(hw, GMAC_CONTROL);
> > +
> > +	if (linkup)
> > +		value |= GMAC_CONTROL_RE;
> > +	else
> > +		value &= ~GMAC_CONTROL_RE;
> > +
> > +	mucse_hw_wr32(hw, GMAC_CONTROL, value);
> 
> [Severity: Low]
> [Finding: main-7-40]
> [Sources: opus-5]
> The enable path sets GMAC_CONTROL_RE here and only programs
> GMAC_FRAME_FILTER afterwards, while the disable path does the two writes in
> the opposite order.
> 
> Between these two writes the receiver is running with the frame filter
> value left behind by the previous link-down path:
> 
> 	mucse_hw_wr32(hw, GMAC_FRAME_FILTER, 0);
> 
> which is exact-address matching, and no GMAC unicast address register is
> ever programmed by this driver.
> 
> Are frames arriving in that window matched against reset address
> registers?  Would writing the filter before enabling the receiver be
> more consistent with the disable path?
> 
I see, I will program GMAC_FRAME_FILTER before setting
GMAC_CONTROL_RE on link-up, and link-down path will continue to disable the
receiver before clearing the filter.
> > +
> > +	/* Keep the GMAC in receive-all mode while the link is up. The
> > +	 * chip-level filter does the actual address filtering, but there
> > +	 * is no ndo_set_rx_mode yet to configure it.
> > +	 */
> > +	if (linkup)
> > +		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, GMAC_RX_ALL);
> > +	else
> > +		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, 0);
> > +}
> 
> [Severity: Medium]
> [Finding: main-1-0]
> [Sources: opus-5, old-prompts, opus-4-7]
> GMAC_RX_ALL is defined as BIT(31) | BIT(0), which on this DesignWare-style
> GMAC is receive-all plus promiscuous.  Every link-up therefore leaves the
> MAC accepting every frame on the wire for the lifetime of the link, and
> dev->promiscuity / IFF_PROMISC are never updated, so userspace still sees a
> non-promiscuous interface.
> 
> The comment and the commit message both say the filtering happens
> elsewhere:
> 
>     Enable the GMAC receiver in receive-all mode because packet filtering
>     is done by the chip-level filter
> 
> A grep over drivers/net/ethernet/mucse/ shows the GMAC_CONTROL and
> GMAC_FRAME_FILTER writes in rnpgbe_set_link() are the only MAC or filter
> register writes in the whole driver, and rnpgbe_netdev_ops has no
> ndo_set_rx_mode:
> 
> static const struct net_device_ops rnpgbe_netdev_ops = {
> 	.ndo_open       = rnpgbe_open,
> 	.ndo_stop       = rnpgbe_close,
> 	.ndo_start_xmit = rnpgbe_xmit_frame,
> 	.ndo_get_stats64 = rnpgbe_get_stats64,
> };
> 
> Which code programs that chip-level filter?  As it stands, foreign unicast
> and all multicast frames are DMA'd into the rx rings and discarded in
> software, and local taps observe other hosts' traffic while ip link
> reports the interface as non-promiscuous.
> 
The chip-level filter programming is not present in the current
series, so the current receive-all configuration does not provide the
expected netdev receive-mode semantics.
I will add a separate patch before the link-status patch to implement the
chip-level RX filter and ndo_set_rx_mode(), including the unicast and
multicast address lists and the IFF_PROMISC/IFF_ALLMULTI modes. The
link-status patch will then enable the GMAC receiver only after that filter
has been configured.
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > index 1d87edfba3d75..9e640e8d67036 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> > @@ -21,8 +21,27 @@
> >  #define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
> >  #define RNPGBE_DMA_RX_STATUS           GENMASK_U32(21, 20)
> >  #define RX_AXI_RW_EN                   0x03
> > +/* RNPGBE_LINK_ST is a driver-owned link-state snapshot consumed by firmware.
> > + * M_DEFAULT_ST replaces the complete snapshot, causing firmware
> > + * to report the current link state again when it differs from this default.
> > + */
> > +#define M_ST_MASK                      (GENMASK_U32(31, 24) | \
> > +					GENMASK_U32(11, 8) | BIT(6) | \
> > +					BIT(4) | BIT(0))
> > +/* Set the driver-state marker; all other driver status fields start clear. */
> > +#define M_DEFAULT_ST                   0xa0000000
> 
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5, old-prompts]
> Who owns the bits of RNPGBE_LINK_ST outside M_ST_MASK, that is bits 23:12,
> 7, 5 and 3:1?
> 
> mucse_update_link_status_reg() treats them as state that must be preserved:
> 
> 	value = mucse_hw_rd32(hw, RNPGBE_LINK_ST);
> 	value &= ~M_ST_MASK;
> 	value |= M_DEFAULT_ST;
> 
> while rnpgbe_up_complete() and the invalid-magic path in
> mucse_mbx_fw_req_handler() blind-write the whole word:
> 
> 	mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
> 
> so exactly the bits the read-modify-write takes care to keep are zeroed.
> Note the register sits at 0x000c, between RNPGBE_DMA_STATUS and
> RNPGBE_DMA_AXI_EN.
> 
> If the whole word is driver-owned, is the masked read-modify-write reading
> anything meaningful?  If it is not, do the two full-word writes destroy
> state the driver cannot restore?
> 
RNPGBE_LINK_ST is wholly driver-owned; firmware only consumes the
driver-written snapshot. Bits outside the defined driver fields are
reserved; they are not firmware-owned state.
I will remove read-modify-write.
> > +/* Driver-reported fields: 25:24 pause, 11:8 speed, 6 LLDP, 4 duplex,
> > + * and 0 link up/down. M_DEFAULT_ST resets these fields so firmware reports
> > + * the current hardware state again.
> > + */
> > +#define RNPGBE_LINK_ST                 0x000c
> >  #define RNPGBE_DMA_AXI_EN              0x0010
> >  #define RNPGBE_TX_MIN_PKT_LEN          33
> >  
> > +#define MUCSE_GMAC_OFF(_n)             (0x20000 + (_n))
> > +#define GMAC_CONTROL_RE                0x00000004
> > +#define GMAC_CONTROL                   MUCSE_GMAC_OFF(0)
> > +#define GMAC_RX_ALL                    (BIT(31) | BIT(0))
> > +#define GMAC_FRAME_FILTER              MUCSE_GMAC_OFF(0x4)
> >  #define RNPGBE_MAX_QUEUES 8
> >  #endif /* _RNPGBE_HW_H */
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > index 9199a48e75d42..fa5ea4dd7a1c6 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> 
> [ ... ]
> 
> > @@ -1414,11 +1447,50 @@ void rnpgbe_up_complete(struct mucse *mucse)
> >  		rnpgbe_configure_msi(mucse);
> >  
> >  	rnpgbe_napi_enable_all(mucse);
> > +	/* Clear stale link state and tell firmware the driver hasn't
> > +	 * seen any link yet. Firmware will re-assert LINK_CHANGE_EVT
> > +	 * when link_report_en is sent below since RNPGBE_LINK_ST
> > +	 * no longer matches the actual (possibly up) link state.
> > +	 */
> > +	spin_lock_irqsave(&mucse->link_lock, flags);
> > +	WRITE_ONCE(hw->link, false);
> > +	WRITE_ONCE(hw->speed, 0);
> > +	WRITE_ONCE(hw->duplex, 0);
> > +	atomic_set(&mucse->link_pending, 0);
> > +	/* echo fw driver now in default state */
> > +	mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
> 
> [ ... ]
> 
> > +	queue_delayed_work(system_percpu_wq, &mucse->serv_task,
> > +			   msecs_to_jiffies(500));
> > +
> > +	return 0;
> >  }
> 
> [ ... ]
> 
> > +/**
> > + * rnpgbe_service_task - Manages and runs subtasks
> > + * @work: pointer to work_struct containing our data
> > + **/
> > +void rnpgbe_service_task(struct work_struct *work)
> > +{
> > +	struct mucse *mucse = container_of(work, struct mucse, serv_task.work);
> > +
> > +	if (test_bit(__MUCSE_DOWN, &mucse->state))
> > +		return;
> > +
> > +	rnpgbe_process_link_subtask(mucse);
> > +
> > +	if (!test_bit(__MUCSE_DOWN, &mucse->state))
> > +		queue_delayed_work(system_percpu_wq, &mucse->serv_task,
> > +				   msecs_to_jiffies(500));
> > +}
> 
> [Severity: Low]
> [Finding: main-1-4]
> [Sources: opus-5, old-prompts]
> Could the carrier update be done directly from the mailbox work item
> instead of being polled?
> 
> The link event is already parsed in sleepable process context:
> 
> rnpgbe_msix_other()
>   queue_work(system_percpu_wq, &mucse->mbx_work)
>     rnpgbe_mbx_work()
>       mucse_fw_irq_handler()
>         mucse_mbx_fw_req_handler()
>           atomic_set_release(&mucse->link_pending, 1);
> 
> but the handler only sets link_pending, and this delayed work polls the
> flag every 500 ms.  That adds up to 500 ms of carrier-update latency per
> event, including the first link report since rnpgbe_up_complete() arms the
> task with msecs_to_jiffies(500), plus two workqueue wakeups per second for
> as long as the interface is up.
> 
> Queueing serv_task with zero delay from mucse_mbx_fw_req_handler() would
> avoid both.
> 
I plan to keep the periodic service task for future statistics and
health-check work, but make link changes event-driven.
After caching a valid firmware link event, the mailbox worker would use
mod_delayed_work(..., 0) to run the service task immediately. The task
would still re-arm itself periodically after it runs.
This should avoid using the periodic interval as link-update latency while
retaining the periodic service path. Would this approach be acceptable?
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > index 754016f6b4f00..441724f8603eb 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> > @@ -3,6 +3,7 @@
> >  
> >  #include <linux/if_ether.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/ethtool.h>
> >  
> >  #include "rnpgbe.h"
> >  #include "rnpgbe_mbx.h"
> > @@ -27,10 +28,14 @@ static int mucse_fw_send_cmd_wait_resp(struct mucse_hw *hw,
> >  	int retry_cnt = 3;
> >  	int err;
> >  
> > +	BUILD_BUG_ON(sizeof(struct mbx_fw_cmd_reply) != 56);
> > +
> >  	mutex_lock(&hw->mbx.lock);
> > +
> >  	err = mucse_write_and_wait_ack_mbx(hw, req->dwords, len);
> >  	if (err)
> >  		goto out;
> > +
> 
> [Severity: Low]
> [Finding: main-1-3]
> [Sources: opus-5, old-prompts]
> These changes are not described by the commit message and are unrelated to
> link handling: the BUILD_BUG_ON plus blank-line churn inside the
> pre-existing mucse_fw_send_cmd_wait_resp(), and a whitespace-only hunk in
> rnpgbe_add_adapter().
> 
> The new #include <linux/ethtool.h> also has no user in this file: grep
> finds no ethtool symbol here, DUPLEX_BIT is driver-local, and the speeds
> are plain literals.
> 
> The new FLAGS_REPLY and FLAGS_ERR macros and the reply arm of
> union mbx_fw_cmd_u have no consumer either; mucse_fw_handle_event()
> demultiplexes on the opcode field alone and never checks the
> reply/error discriminator.  Could these be dropped or moved to the patch
> that uses them?
> 
Agreed. I will remove those.
> >  	do {
> >  		err = mucse_poll_and_read_mbx(hw, reply->dwords,
> >  					      sizeof(reply->r));
> 
> [ ... ]
> 
> > +static void mucse_update_link_status_reg(struct mucse_hw *hw,
> > +					 struct mbx_fw_cmd_req *req)
> > +{
> > +	u16 status = le16_to_cpu(req->link_stat.st.status);
> > +	u16 speed = le16_to_cpu(req->link_stat.st.speed);
> > +	u32 value;
> > +
> > +	value = mucse_hw_rd32(hw, RNPGBE_LINK_ST);
> > +	value &= ~M_ST_MASK;
> > +	value |= M_DEFAULT_ST;
> > +
> > +	if (le16_to_cpu(req->link_stat.port_status)) {
> > +		value |= BIT(0);
> > +		switch (speed) {
> > +		case 10:
> > +			value |= (mucse_speed_10 << 8);
> > +			break;
> > +		case 100:
> > +			value |= (mucse_speed_100 << 8);
> > +			break;
> > +		case 1000:
> > +			value |= (mucse_speed_1000 << 8);
> > +			break;
> > +		default:
> > +			break;
> > +		}
> 
> [Severity: Medium]
> [Finding: gpt-5-6-sol-1-6]
> [Sources: gpt-5-6-sol, opus-5, old-prompts]
> What happens for a speed that is not 10, 100 or 1000?
> 
> The default arm leaves bits 11:8 at 0, and mucse_speed_10 is also 0:
> 
> enum mucse_speed {
> 	mucse_speed_10 = 0,
> 	mucse_speed_100 = 1,
> 	mucse_speed_1000 = 2,
> };
> 
> so an unsupported speed is encoded as 10 Mbps in the snapshot, while
> mucse_mbx_fw_req_handler() caches the raw value:
> 
> 	WRITE_ONCE(hw->speed, le16_to_cpu(req->link_stat.st.speed));
> 
> and rnpgbe_link_is_up() prints it and enables carrier plus the GMAC
> receiver.
> 
> The commit message says:
> 
>     Validate firmware link events before updating the cached link state.
> 
> but the only check applied is port_magic against ST_VALID_MAGIC; speed is
> not range checked.  Should an out-of-range speed be rejected instead, given
> that the snapshot then reports a state the hardware never has and firmware
> can keep re-asserting LINK_CHANGE_EVT?
> 
I will validate link-up speeds before updating the cached state. An invalid
value will be handled conservatively as link down, rather than
being encoded as 10 Mbps, and and the driver snapshot will be reset so that
firmware can re-assert LINK_CHANGE_EVT. 
> > +
> > +		value |= FIELD_PREP(BIT(4),
> > +				    !!(req->link_stat.st.flags & DUPLEX_BIT));
> > +		value |= FIELD_PREP(GENMASK_U32(25, 24),
> > +				    status & GENMASK(1, 0));
> > +	} else {
> > +		value &= ~BIT(0);
> > +	}
> > +
> > +	if (status & ST_STATUS_LLDP_STATUS_MASK)
> > +		value |= BIT(6);
> > +	else
> > +		value &= ~BIT(6);
> > +
> > +	mucse_hw_wr32(hw, RNPGBE_LINK_ST, value);
> > +}
> 
> [ ... ]
> 
> > +static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
> > +				     struct mbx_fw_cmd_req *req)
> > +{
> > +	struct mucse *mucse = container_of(hw, struct mucse, hw);
> > +	u32 magic = le32_to_cpu(req->link_stat.port_magic);
> > +	unsigned long flags;
> > +
> > +	if (le16_to_cpu(req->opcode) == LINK_CHANGE_EVT) {
> > +		spin_lock_irqsave(&mucse->link_lock, flags);
> > +		if (magic != ST_VALID_MAGIC) {
> > +			/* Do not let an invalid event change the cached link state.
> > +			 * Reset the driver snapshot so firmware reports it again.
> > +			 */
> > +			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
> > +			spin_unlock_irqrestore(&mucse->link_lock, flags);
> > +			return;
> > +		}
> 
> [Severity: Medium]
> [Finding: gpt-5-6-sol-3-22]
> [Sources: gpt-5-6-sol]
> Can this path leave the carrier reported as up after the link is gone?
> 
> If an invalid-magic event arrives while the link is going down, the cached
> state is kept and the snapshot is reset to M_DEFAULT_ST.  But a legitimate
> link-down snapshot with LLDP clear resolves to exactly M_DEFAULT_ST too:
> mucse_update_link_status_reg() clears BIT(0), encodes no speed, duplex or
> pause, and clears bit 6.
> 
> After the reset the snapshot already matches the real down state, so per
> the handshake documented in this patch firmware has no mismatch left to
> re-report from.  link_pending is never set, rnpgbe_process_link_subtask()
> never calls rnpgbe_link_is_down(), and the interface keeps carrier on with
> GMAC_CONTROL_RE set until it is cycled by hand.
> 
Yes, M_DEFAULT_ST can match a valid link-down snapshot, so it does not
guarantee that firmware will re-assert LINK_CHANGE_EVT after an event with
an invalid port_magic.
I will instead write a driver snapshot containing an invalid speed encoding.
Firmware only produces the 10, 100, and 1000 Mbps encodings and compares the
complete snapshot directly, so this value cannot match either a valid
link-up or link-down state. Firmware will therefore re-assert
LINK_CHANGE_EVT after its rate limit, without changing the cached link state
based on the malformed event.
> > +
> > +		if (test_bit(__MUCSE_DOWN, &mucse->state)) {
> > +			mucse_update_link_status_reg(hw, req);
> > +			spin_unlock_irqrestore(&mucse->link_lock, flags);
> > +			return;
> > +		}
> > +
> > +		if (le16_to_cpu(req->link_stat.port_status))
> > +			WRITE_ONCE(hw->link, true);
> > +		else
> > +			WRITE_ONCE(hw->link, false);
> 
> [Severity: Medium]
> [Finding: main-7-37]
> [Sources: opus-5, old-prompts]
> Should port_status be tested with BIT(hw->port) rather than for plain
> non-zero?
> 
> Every other port field in this mailbox protocol is a per-port bitmask.  The
> requests added by this patch encode:
> 
> 	.port_mask = cpu_to_le32(BIT(hw->port)),
> 
> and the GET_MAC_ADDRESS reply is decoded in mucse_mbx_get_macaddr() as:
> 
> 	if (le32_to_cpu(reply.r.mac_addr.ports) & BIT(port))
> 
> If port_status is likewise a bitmap of ports whose link is up, which its
> pairing with changed_lanes suggests, then on multi-port parts such as
> RNPGBE_DEVICE_ID_N500_QUAD_PORT a link-up on another port would make this
> port declare carrier up, set GMAC_CONTROL_RE plus receive-all filtering,
> and advertise link up in the firmware snapshot while its own PHY is down.
> The same unmasked test is used in mucse_update_link_status_reg().
> 
The currently supported devices have one port per PF, so
port_status being non-zero is equivalent to the state of this port.
However, port_status is a per-port bitmap and this assumption would not
hold for multi-port perf PF devices.
I will test port_status with BIT(hw->port) when updating both the cached
link state and the driver link-state snapshot.
> > +
> > +		WRITE_ONCE(hw->speed, le16_to_cpu(req->link_stat.st.speed));
> > +		WRITE_ONCE(hw->duplex, req->link_stat.st.flags & DUPLEX_BIT);
> > +		/* update regs to notify link info is received */
> > +		mucse_update_link_status_reg(hw, req);
> > +		atomic_set_release(&mucse->link_pending, 1);
> > +		spin_unlock_irqrestore(&mucse->link_lock, flags);
> > +	}
> > +}
> > +
> > +/**
> > + * mucse_fw_handle_event - Handle one pending firmware event
> > + * @hw: pointer to the hardware structure
> > + *
> > + * Return: true if an event was handled, false otherwise
> > + **/
> > +static bool mucse_fw_handle_event(struct mucse_hw *hw)
> > +{
> > +	union mbx_fw_cmd_u msg = {};
> > +	int err;
> > +
> > +	/* try to check and read fw req */
> > +	mutex_lock(&hw->mbx.lock);
> > +	err = mucse_check_and_read_mbx(hw, msg.dwords, sizeof(msg));
> > +	mutex_unlock(&hw->mbx.lock);
> > +	if (err)
> > +		return false;
> > +
> > +	mucse_mbx_fw_req_handler(hw, &msg.req);
> > +
> > +	return true;
> > +}
> > +
> > +/**
> > + * mucse_fw_irq_handler - Drain pending firmware mailbox events
> >   * @hw: pointer to the HW structure
> > + *
> > + * The only asynchronous event currently handled is LINK_CHANGE_EVT.
> > + * Firmware rate-limits link-change notifications to a minimum interval
> > + * of 500 ms.
> >   **/
> >  void mucse_fw_irq_handler(struct mucse_hw *hw)
> >  {
> > +	/* Drain events coalesced while the mailbox work item was pending. */
> > +	while (mucse_fw_handle_event(hw))
> > +		continue;
> >  }
> 
> [Severity: Medium]
> [Finding: gpt-5-6-sol-6-34]
> [Sources: gpt-5-6-sol, opus-5, old-prompts]
> Is this loop bounded by anything other than firmware behaviour?
> 
> The exit condition is entirely device controlled.  mucse_check_for_msg_pf()
> succeeds whenever the firmware-written counter differs from the cached
> copy:
> 
> 	if (fw_req == 0 || fw_req == hw->mbx.fw_req)
> 		return -EIO;
> 
> and mucse_read_mbx_pf() re-caches it from the same register, so as long as
> firmware keeps advancing the counter the work item never returns.
> mucse_fw_handle_event() also returns true for any successful read,
> including messages with an unrecognised opcode.
> 
> That blocks the teardown path, which waits for this work:
> 
> rnpgbe_free_mbx_irq()
> 	free_irq(pci_irq_vector(pdev, 0), mucse);
> 	cancel_work_sync(&mucse->mbx_work);
> 
> so a device that keeps posting messages would hang rmmod or PCI remove and
> keep one workqueue worker spinning on the mailbox lock.  The reply path
> bounds itself with retry_cnt = 3; should this drain get a similar budget?
> The 500 ms firmware rate limit is only stated in the comment, not enforced
> by the driver.
> 
I will remove the unbounded drain loop and handle at most one mailbox
request in each work-item invocation.
For the dedicated mailbox MSI-X vector, the hard IRQ handler will increment
an event sequence counter before queueing the mailbox work. The worker will
compare this counter before and after handling one request; if another
dedicated mailbox interrupt arrived while it was running, it will requeue
itself and return, rather than continuing to drain in the same invocation.
For MSI and single-vector MSI-X operation, mailbox and data interrupts share
a vector and cannot be distinguished in the hard IRQ handler. Those
interrupts will only queue the worker; the worker verifies the firmware
request counter before reading the mailbox, so data-only interrupts result
in a coalesced empty check. They do not increment the mailbox event sequence
counter.
This bounds each work invocation while preserving mailbox events that arrive
during processing.
And cancel_work_sync() waits for at most one mailbox check rather than an
unbounded drain loop. The worker does not requeue itself once the device is
down.
Would this approach be acceptable?

Thanks for your feedback.
