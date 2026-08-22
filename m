Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E0313277;
	Sat, 22 Aug 2026 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431990; cv=none; b=miDhNZbk2Lyb2KRGbFBqDP0wlGDmmZTuAsHI52QRa3bdgADZhnBKZPUPEu/dKKpdwVd60hroP+S4Z55GoJB/VrPtbRc4/WXg2snS79IrygCma8ChxsTDamc7u0AWBkWDRjlecPGn06O6EaGaf0+UbkI5W4Vssw56dKAOkE11yCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431990; c=relaxed/simple;
	bh=U6U9gP8Ifd0Kl3wu+0o5Xy+P6SrljYK+l46pLI96kdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbs2Xrml1wiqfXbuI6j4Aanf1OzSy/S4JxAV73qrNVLPZi4aXYJd08SORmzcZ9C/IUQPhcXL4PnIFzjl8fWnQyZF2mQ+ruxb+d5LHrhDN1DJFT6J5tzA+GqK/god9G/urNUndq7slWNnY4Vq4FRZdFOeMZGJswJF1e6TbEm3doI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYWBmPIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYWBmPIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C531F000E9;
	Sat, 22 Aug 2026 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787431989;
	bh=oOeYbJnQB1MQgdJ9gLKmyLoiKOiKaffgZhn+LlhZ1Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BYWBmPIRCKC1WhAVqFfNi/8BRj/dgphGCH62a+rFuf/9plQENHrOsNVWSQvU8EUpm
	 3X1CpgqzMQ/uWBTHFxMlJRVJh51OfWZrckrLNdxqLu6KTB633p4nrPO7aeAglZBDi7
	 xGkcSkkkT2MumEzsRnK7K/7R/HbwRR1gqa4fOqVeyeqf6C3jW/s/C7yviKxUGEy+Kw
	 lwQb8xW71W95VYkKPfMi81zhG628Z5uHczhxMIgnf51QgkgLIM7s5d+XjgrjtGtRUu
	 wts5wNoavpDncaXLN3pFQ2TpBzUyrv6/oQZyZisJPdHy8uSWd8DkGHyizuIDkP0/w5
	 eFUzP/b+g+lqg==
From: Jakub Kicinski <kuba@kernel.org>
To: nshettyj@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rfranz@marvell.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	rkannoth@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org
Subject: Re: [PATCH net] octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors
Date: Sat, 22 Aug 2026 13:53:07 -0700
Message-ID: <20260822205307.2257643-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820172253.2010182-1-nshettyj@marvell.com>
References: <20260820172253.2010182-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors

The patch makes otx2_get_ts_info() fall back to
ethtool_op_get_ts_info() for SDP representors, so ethtool -T reports
software timestamping only and phc_index = -1 for those interfaces.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index a0340f3422bf9..f7a2202c4a3e0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -978,7 +978,7 @@ static int otx2_get_ts_info(struct net_device *netdev,
>  {
>  	struct otx2_nic *pfvf = netdev_priv(netdev);
>  
> -	if (!pfvf->ptp)
> +	if (!pfvf->ptp || is_otx2_sdp_rep(pfvf->pdev))
>  		return ethtool_op_get_ts_info(netdev, info);

[Severity: Medium]
Accepting hardware timestamping on SDP representors isn't a bug
introduced by this patch, but should the configuration path be closed
too, so the advertised capabilities and the set path agree?

otx2_config_hwtstamp_set() in otx2_pf.c is registered as
.ndo_hwtstamp_set in otx2vf_netdev_ops, which SDP representors use
(PCI_DEVID_OCTEONTX2_SDP_REP is in otx2_vf_id_table), and its only
guard is the pointer check:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_config_hwtstamp_set() {
	struct otx2_nic *pfvf = netdev_priv(netdev);

	if (!pfvf->ptp)
		return -ENODEV;

	switch (config->tx_type) {
	...
}

pfvf->ptp is non-NULL for SDP representors, since otx2vf_probe() calls
otx2_ptp_init(vf) unconditionally and otx2_ptp_init() only clears the
pointer for LBK VFs:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c:otx2_ptp_init() {
	if (is_otx2_lbkvf(pfvf->pdev)) {
		pfvf->ptp = NULL;
		return 0;
	}
	...
}

The SIOCSHWTSTAMP path only range-checks the request in
net_hwtstamp_validate() and never consults get_ts_info, so
HWTSTAMP_TX_ON / HWTSTAMP_FILTER_ALL is still accepted on an interface
that ethtool -T now reports as software-only, and
otx2_config_hwtstamp_get() reports that hardware mode back from
pfvf->tstamp.

On the TX side, does anything actually get programmed? The AF handler
rvu_mbox_handler_nix_lf_ptp_tx_enable() -> rvu_nix_lf_ptp_tx_cfg()
returns success without writing NIX_AF_LFX_TX_CFG_PTP_EN for a
non-CGX-mapped (SDP) PF:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:rvu_nix_lf_ptp_tx_cfg() {
	if (!is_mac_feature_supported(rvu, pf, RVU_LMAC_FEAT_PTP))
		return 0;
	...
}

So OTX2_FLAG_TX_TSTAMP_ENABLED gets set and otx2_set_txtstamp() starts
marking skbs SKBTX_IN_PROGRESS and appending the
NIX_SENDMEMALG_E_SETTSTMP MEM subdesc while the LF was never enabled
for PTP.

The RX half does not appear to be affected: rvu_mbox_handler_cgx_ptp_rx_enable()
returns -EPERM for a non-CGX-mapped PF, so OTX2_FLAG_RX_TSTAMP_ENABLED
stays clear.

Would it be simpler to mirror the existing LBK handling in
otx2_ptp_init() and also set pfvf->ptp = NULL for is_otx2_sdp_rep()?
That covers otx2_get_ts_info(), otx2_config_hwtstamp_set() and avoids
registering a PHC that the patch now hides with phc_index = -1 while it
remains reachable as /dev/ptpN.

Cross-instance finding from sashiko-gemini (5b35a8e8292d6d592200e0103dea956967dd21185968d0440290af6d0ae99293):
[Severity: Medium]
Incomplete fix for SDP representor hardware timestamping allows ioctl configuration and useless PTP clock registration.
-- 
pw-bot: cr
