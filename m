Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE341C6A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787090642; cv=pass; b=FY2VpMVpyD2JXIy+jgxxTOSCnQHqNbjW+MbkETPX6JECJro1Qcg8CJvHRndjHqydGk3rq3LvYaUTY6yENNZrPqX0Z7phIcJWST2qYDS+TBLMiGf0Ssu3aciUGCGXtmEpPzfF2vl1ZNUOq8rII2b91rZvZu6VUPxefo38nf18A2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787090642; c=relaxed/simple;
	bh=a+LiPHyveXG5Ai3SAwRPkSoqAmjzFFyHNah1m6k/Do4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kO9KkiS1yLpEonKWg3tg8FJBbJ+rDf6GZ0jv91pKByTgnweE1XTbvdUnv7vv3IkmGaoI0YpCnWXGNVj4xBtzL9S4XGKx2MYZXiOa+dvBk3YxPXCloOwcjUAHOaG4asnKkQIWCE7tBbvWueD8p7Z6hM4qPCVs7ajjdm41pJTJxGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=G/9N0BYN; arc=pass smtp.client-ip=165.173.182.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="G/9N0BYN"
ARC-Seal: i=1; a=rsa-sha256; t=1787090620; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dBsoCIcmYUZ29/d9QU+pZAulST+3XVl8mV6GsqlKHwJOKgTawVMiq1UvCG1OBmqPhqE8V7E7v3+dEMBpjHM6CZWWXNi8Z2L4koV/pfqxCYfh0fAH9srAddn3q08YYaEk0Y6FU8g+V2FihHktTtgPXJi9uIGTrV2m1+biEVLVBHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787090620; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CWNhkWi+eY4vficK/gwQkZg9atuXrdKboMgQskytjq8=; 
	b=A5D1JqRAhfTcpRWN5+KxpUWM81BrDYrASTB+ZUFKUxcwdN9OqxpwW59hG0CJi4ZIK2uR6VH2gkRsDbXhzTve8mtA7XD7ycxaWPZI9EphMDClQe9WFOtEcW3YpDjssj2/jStRR4o3XaS5Y14AgzpZJXi/ZoRTv9U+uwAC/aV2RCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787090620;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CWNhkWi+eY4vficK/gwQkZg9atuXrdKboMgQskytjq8=;
	b=G/9N0BYND5vf/XUcQGp/d1JrCxikk6w73FT8fy8PWASLBwvRah7m6apkmuof5ast
	0kH2P1l6cx/wKS9+2i7nQxpIhayDYpT89XzLgyD/2/fFUcOmkhvgBTOrkm7Lq6yKKM1
	wPlX0VDSAVpQNB8E7tHcZajqt+DyR0mCTWj0AXUB6VHGvrGmtxWYOEPlD/AOCqbCeOn
	BqKYaWVuUp4B0L7vUvpYF5aB5PE1kWljyg9jPxUblk3bS8YCjjWSu4j8GK2P5lrDrYW
	Yx/diBQinNpY82XO+fv/c0hNZo3t6rwGx8MhfyFry6i3Oq13wgP4OZvX+itFeQn3XR6
	UnyZbh2wyA==
Received: by mx.zohomail.com with SMTPS id 1787090615794273.55269160490775;
	Tue, 18 Aug 2026 15:03:35 -0700 (PDT)
Message-ID: <9b17f19d-9d6f-4301-b6a5-871cec042211@machnikowski.net>
Date: Wed, 19 Aug 2026 00:03:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev
References: <20260815063148.2952-3-maciek@machnikowski.net>
 <20260818135800.629288-1-horms@kernel.org>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20260818135800.629288-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 18/08/2026 15:58, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260815063148.2952-1-maciek@machnikowski.net?part=2
> ---
> --- Patch [2]: [PATCH v10 net-next 2/3] netdevsim: Implement basic ptp support ---
> commit ef2b7171af287d8c3a8f5064008830a7dd8f4db3
> Author: Maciek Machnikowski <maciek@machnikowski.net>
> 
> netdevsim: Implement basic ptp support
> 
> Adds virtual hardware timestamping to netdevsim by reading the mock PHC
> attached to the transmitting netdevsim and to its peer, reporting a TX
> timestamp to the socket and stamping the forwarded skb for the RX side.
> Also wires up ndo_hwtstamp_get / ndo_hwtstamp_set and extends
> nsim_get_ts_info().
> 
> A few questions on the timestamping path below.
> 
>> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
>> index 025ea79879f3a..24e7d5592e799 100644
>> --- a/drivers/net/netdevsim/ethtool.c
>> +++ b/drivers/net/netdevsim/ethtool.c
>> @@ -200,7 +200,22 @@ static int nsim_get_ts_info(struct net_device *dev,
>>  {
>>  	struct netdevsim *ns = netdev_priv(dev);
>>  
>> +	ethtool_op_get_ts_info(dev, info);
>> +	if (!ns->phc) {
>> +		info->phc_index = -1;
>> +		return 0;
>> +	}
>> +
> 
> [Severity: High]
> [Finding: main-1-1]
> [Sources: opus-5]
> This isn't a bug introduced by this patch, but the new !ns->phc guard looks
> like it silently fixes a NULL pointer dereference that exists today, without
> a mention in the changelog or a Fixes: tag.
> 
> Before this patch nsim_get_ts_info() did:
> 
> 	info->phc_index = mock_phc_index(ns->phc);
> 
> and nsim_ethtool_init() installs the shared nsim_ethtool_ops (including
> .get_ts_info = nsim_get_ts_info) on every netdevsim netdev, while only
> nsim_init_netdevsim() calls mock_phc_create().  nsim_init_netdevsim_vf()
> just assigns nsim_vf_netdev_ops and registers the netdev, so ns->phc stays
> NULL for VF netdevs.
> 
> With CONFIG_PTP_1588_CLOCK_MOCK=y, mock_phc_index() is the real function:
> 
> drivers/ptp/ptp_mock.c:mock_phc_index() {
> 	return ptp_clock_index(phc->clock);
> }
> 
> so ethtool -T on a netdevsim VF netdev dereferences NULL.  Would it make
> sense to split this guard into its own patch with a Fixes: tag so that
> stable tooling can pick it up?
> 
> Also, adding ethtool_op_get_ts_info() here changes ethtool -T output for all
> netdevsim devices by advertising SOF_TIMESTAMPING_TX_SOFTWARE,
> SOF_TIMESTAMPING_RX_SOFTWARE and SOF_TIMESTAMPING_SOFTWARE.  Could the
> changelog mention that behaviour change?
This patchset introduces this connection - not sure what would it fix?


> 
>>  	info->phc_index = mock_phc_index(ns->phc);
>> +	if (info->phc_index < 0)
>> +		return 0;
>> +
>> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
>> +				 SOF_TIMESTAMPING_RX_HARDWARE |
>> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
>> +
>> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
>> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index 4e9d7e10b527e..e586fd8f3bc37 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
> 
> [ ... ]
> 
>> @@ -164,6 +171,44 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  		skb_linearize(skb);
>>  
>>  	skb_tx_timestamp(skb);
>> +
>> +	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
>> +		     HWTSTAMP_FILTER_NONE))
>> +		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
>> +
>> +	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>> +	    READ_ONCE(ns->tstamp_config.tx_type) == HWTSTAMP_TX_ON)
>> +		ptp_info_tx = mock_phc_get_ptp_info(ns->phc);
>> +
>> +	if (unlikely(ptp_info_tx || ptp_info_rx)) {
>> +		/* Capture both timestamps closely */
>> +		if (ptp_info_tx)
>> +			ptp_info_tx->gettime64(ptp_info_tx, &tx_ts);
>> +		if (ptp_info_rx)
>> +			ptp_info_rx->gettime64(ptp_info_rx, &rx_ts);
>> +
>> +		/* If TX hardware timestamping is enabled report TX timestamp */
>> +		if (ptp_info_tx) {
>> +			shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
>> +			skb_tstamp_tx(skb_orig, &shhwtstamps);
>> +		}
> 
> [Severity: Medium]
> [Finding: gpt-5-6-sol-3-10]
> [Sources: gpt-5-6-sol, opus-5]
> Can a socket receive two SCM_TSTAMP_SND reports for the same packet here?
> 
> The hardware report is emitted after skb_tx_timestamp(), which already
> delivered the software one:
> 
> include/linux/skbuff.h:skb_tx_timestamp() {
> 	skb_clone_tx_timestamp(skb);
> 	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
> 		skb_tstamp_tx(skb, NULL);
> }
> 
> The only suppression of the software report lives in __skb_tstamp_tx():
> 
> net/core/skbuff.c:__skb_tstamp_tx() {
> 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
> 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
> 		return;
> 
> netdevsim never sets SKBTX_IN_PROGRESS anywhere - the new code only tests
> SKBTX_HW_TSTAMP - so for a socket that enabled both
> SOF_TIMESTAMPING_TX_SOFTWARE and SOF_TIMESTAMPING_TX_HARDWARE without
> SOF_TIMESTAMPING_OPT_TX_SWHW both reports are delivered.
> 
> Would following the usual driver sequence work here, i.e. test
> SKBTX_HW_TSTAMP and set SKBTX_IN_PROGRESS before calling
> skb_tx_timestamp()?
> 
That protection is needed for the code that delays tstamp completion
into some "worker" that handles the timestamp returned by HW once the
packet was transmitted out. For a netdevsim we return the tx tstamp
immediately.
>> +
>> +		/* Unshare the skb, stamping it must not corrupt cloned copies
>> +		 * and prevents returning single tstamp for Tx and Rx
>> +		 */
>> +		skb = skb_unshare(skb_orig, GFP_ATOMIC);
>> +		if (unlikely(!skb)) {
>> +			if (psp_ext)
>> +				__skb_ext_put(psp_ext);
>> +			goto out_drop_cnt;
>> +		}
> 
> [Severity: Low]
> [Finding: main-3-8]
> [Sources: opus-5]
> Should this skb_unshare() be gated on ptp_info_rx?
> 
> The enclosing condition is ptp_info_tx || ptp_info_rx, but the only write
> into the skb below is guarded by if (ptp_info_rx).  On the TX-only path
> (peer rx_filter == HWTSTAMP_FILTER_NONE) every timestamped frame gets copied
> by skb_copy() for nothing, which also linearizes the buffer that the
> hds_config logic just above deliberately left non-linear, and does not carry
> queue_mapping.
> 
> If the GFP_ATOMIC copy then fails, the frame is dropped via out_drop_cnt
> even though nothing needed to be written into it, and after the TX
> timestamp was already handed to the socket by skb_tstamp_tx(skb_orig, ...).
> 
No - both paths requires skb_unshare. TX one needs it to unshare from
the stack for example - for TCP retransmittion and PSP

> [Severity: Low]
> [Finding: main-5-12]
> [Sources: opus-5]
> Does skb_unshare() cover the case this comment describes?
> 
> include/linux/skbuff.h:skb_unshare() {
> 	might_sleep_if(gfpflags_allow_blocking(pri));
> 	if (skb_cloned(skb)) {
> 	...
> }
> 
> The copy is made only for clones, so an skb with skb->users > 1 and
> cloned == 0 is returned unchanged.  pktgen does
> refcount_add(burst, &pkt_dev->skb->users) and resubmits the same skb, so the
> skb_hwtstamps(skb) write below touches skb_shared_info that the other
> reference holder still owns, and that the peer's NAPI path may read
> concurrently after nsim_forward_skb() -> nsim_napi_rx() queues it on
> rq->skb_queue.  Should the driver check skb_shared() as well, or stamp a
> private copy?
> 
??

>> +
>> +		/* If RX hardware timestamping is enabled report RX timestamp */
>> +		if (ptp_info_rx)
>> +			skb_hwtstamps(skb)->hwtstamp =
>> +				timespec64_to_ktime(rx_ts);
>> +	}
>> +
> 
> [Severity: Critical]
> [Finding: main-6-13]
> [Sources: opus-5]
> Can this write corrupt kernel memory for AF_XDP TX skbs?
> 
> skb_hwtstamps() returns a pointer into a union in skb_shared_info:
> 
> include/linux/skbuff.h:struct skb_shared_info {
> 	union {
> 		struct skb_shared_hwtstamps hwtstamps;
> 		struct xsk_tx_metadata_compl xsk_meta;
> 	};
> 
> struct xsk_tx_metadata_compl has a single member, u64 *tx_timestamp, and the
> AF_XDP destructor dereferences it with only a NULL check:
> 
> net/xdp/xsk.c:xsk_destruct_skb() {
> 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> 
> 	if (compl->tx_timestamp) {
> 		/* sw completion timestamp, not a real one */
> 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
> 	}
> 
> Every generic-xmit AF_XDP skb carries that destructor
> (xsk_skb_init_misc() sets skb->destructor = xsk_destruct_skb), and it is
> freshly allocated and not cloned, so skb_unshare() above returns the same
> skb with the destructor and the overwritten shinfo intact.
> __dev_forward_skb() -> skb_scrub_packet() does not orphan the skb or reset
> skb_shinfo(), so the value survives to the destructor.
> 
> The RX branch is gated only on the peer's setting:
> 
> 	if (unlikely(READ_ONCE(peer_ns->tstamp_config.rx_filter) !=
> 		     HWTSTAMP_FILTER_NONE))
> 		ptp_info_rx = mock_phc_get_ptp_info(peer_ns->phc);
> 
> so any AF_XDP frame forwarded while the peer has RX timestamping enabled
> gets a non-NULL, PHC-derived value in xsk_meta.tx_timestamp, and the
> destructor performs an 8-byte write to that address.  The mock PHC value is
> settable from userspace through clock_settime() on /dev/ptpN via
> mock_phc_settime64().
> 
> Real NICs avoid this because they only stamp skbs they allocated for RX.
> Since netdevsim reuses the TX skb as the RX skb, should it orphan the skb
> (clearing skb->destructor) or stamp a private copy before touching
> skb_shinfo()->hwtstamps?
> 
Sounds like this should be addressed in the generic skb_scrub_packet in
the __dev_forward_skb path?

>>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>>  				      skb, rq, psp_ext) == NET_RX_DROP))
>>  		goto out_drop_cnt;
>> @@ -185,6 +230,63 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	return NETDEV_TX_OK;
>>  }
>>  
>> +static int nsim_set_ts_config(struct net_device *netdev,
>> +			      struct kernel_hwtstamp_config *config,
>> +			      struct netlink_ext_ack *extack)
>> +{
>> +	struct netdevsim *ns = netdev_priv(netdev);
>> +	int rx_filter;
>> +
>> +	if (!ns->phc)
>> +		return -EOPNOTSUPP;
>> +
> 
> [ ... ]
> 
>> +static int nsim_get_ts_config(struct net_device *netdev,
>> +			      struct kernel_hwtstamp_config *config)
>> +{
>> +	struct netdevsim *ns = netdev_priv(netdev);
>> +
>> +	*config = ns->tstamp_config;
>> +	return 0;
>> +}
> 
> [Severity: Low]
> [Finding: gpt-5-6-sol-2-6]
> [Sources: gpt-5-6-sol, opus-5]
> Should nsim_get_ts_config() carry the same !ns->phc check as
> nsim_set_ts_config()?
> 
> drivers/net/Kconfig allows netdevsim without the mock clock:
> 
> 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=n
> 
> and with CONFIG_PTP_1588_CLOCK_MOCK=n the stub is used:
> 
> include/linux/ptp_mock.h {
> static inline struct mock_phc *mock_phc_create(struct device *dev)
> {
> 	return NULL;
> }
> 
> nsim_init_netdevsim() only rejects IS_ERR(), so ns->phc stays NULL.  In that
> configuration SIOCGHWTSTAMP succeeds and reports tx_type =
> HWTSTAMP_TX_OFF / rx_filter = HWTSTAMP_FILTER_NONE, i.e. "hardware
> timestamping present but disabled", while nsim_get_ts_info() reports
> phc_index = -1 with no hardware so_timestamping and every set attempt is
> rejected with -EOPNOTSUPP.  Other converted drivers keep the get/set pair
> symmetric here.
> 
> [ ... ]
We don't support setting, getting is always available - not sure what's
the hypothetical bug there
