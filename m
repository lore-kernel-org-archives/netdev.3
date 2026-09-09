Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9D2580F2;
	Wed,  9 Sep 2026 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927202; cv=none; b=Dd5u6b1CaAJlujK4nV5fRRyhhgN2qrlWmx2vrlP4G0yGHXF92JwayD06kmWQfdKkKtu0q9li/qXeh0Dha4e3waojcxvH7PRsQ+iJhMP8c+JiKFgW4aivMDPssvUUXjkQBLjIy3klyeEOXa0HFsDhDQbvgvHajJ5UGNs59cluvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927202; c=relaxed/simple;
	bh=+QMfpW4vIHU+Qc4b+LixIgGuhPlbPjnx0N8/U1HzLAY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrJr2zwDydCrsAIm6aDvEDCb5it8lldsPOlXbo8QcABucPrr3sD7zRkW+dWlatxPtu3J0GXqetAeLawV4WblI4Uwa/M5e/AVE5i6LF9UqmxqvduYhUXUkOCSC8J8+dZoCPzoyjoe1YpArMDcV0vdppvMjn0SOXSD9hFZ7lZ4niE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e638hRF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e638hRF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C7C1F00A3A;
	Wed,  9 Sep 2026 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927200;
	bh=EZm7Zc51oA/0TCvfz+1edTY1ztiFSao+Uz2FzV+69GA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e638hRF5s8euzFr7iGDpBtm3vmwwhzJ2kLLRB78Zytl+VsDXvBc0L8sQaTSPpmb+C
	 U4DfxvE0rTk9nztUovqWgIW6B8vxyPuc3RqG3X5MrSTLhIKGvoZfifaYMGr6eDXdjJ
	 kV05hzuKCXeqTKhCjY1Le+33waLEoSsgVuCNX9PhwLld9KG2Vk85mkG9mZAvOGv5L5
	 8tbyCRcLwBp/1cjhrtPNAL5vfH9rP3UzU735RIk6ka8Gde8ZK+K8ot2iZ/CBNbpI25
	 OWpDNoi4HF02miQ3xgbJ94HTa398AFCOcbKs69imBw+fK6kLE+bkacsDeN2L48XvGa
	 1JQdoPYb6J0tA==
Subject: Re: [PATCH net] octeontx2-pf: Fix autoneg reporting in ethtool
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hkelam@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 cjacob@marvell.com, jbrandeb@kernel.org
Date: Wed, 09 Sep 2026 04:13:19 +0000
Message-ID: <178892719904.219967.11170576570328933912@kernel.org>
In-Reply-To: <20260903161117.2856633-1-nshettyj@marvell.com>
References: <20260903161117.2856633-1-nshettyj@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

- [High] Newly added Autoneg bits leak into the firmware link-mode
  request and corrupt it.
- [Medium] otx2_get_link_ksettings() (otx2_ethtool.c:1225) now reads
  rsp->fwdata.advertised_an unconditionally, without gating it on…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  adds one more read inside the unsafe window: otx2_get_fwdata()…

--

octeontx2-pf: Fix autoneg reporting in ethtool

The patch moves the supported autoneg link mode bit so that it is set after
otx2_get_link_mode_info() has done its linkmode_copy() into the supported
mask, and adds the advertised autoneg bit when firmware reports
advertised_an.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 9bee1b91eeaa..612fefc41a17 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -1218,19 +1218,23 @@ static int otx2_get_link_ksettings(struct net_device *netdev,
>  	if (IS_ERR(rsp))
>  		return PTR_ERR(rsp);

[Severity: Medium]
This isn't a problem introduced by this patch, but the patch adds two more
reads inside an existing unlocked window.  otx2_get_fwdata() returns a raw
pointer into the shared mailbox response region after dropping the mailbox
mutex:

	err = otx2_sync_mbox_msg(&pfvf->mbox);
	if (!err) {
		rsp = (struct cgx_fw_data *)
			otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
	} else {
		rsp = ERR_PTR(err);
	}

	mutex_unlock(&pfvf->mbox.lock);
	return rsp;

So every rsp->fwdata read in otx2_get_link_ksettings(), including the newly
added advertised_an and supported_an checks, runs with no mailbox lock held.

There is a concurrent mailbox writer that does not take rtnl,
otx2_rx_mode_wrk_handler() -> otx2_do_set_rx_mode(), which serializes only
on the same mbox.lock and issues otx2_sync_mbox_msg().  If it runs between
the unlock and the reads, can ethtool decode link modes, FEC and autoneg
out of an unrelated mailbox reply?

The same file already shows the other pattern in otx2_set_fecparam(), where
the response is consumed while mbox->lock is still held:

	rsp = (struct fec_mode *)otx2_mbox_get_rsp(&pfvf->mbox.mbox,
						   0, &req->hdr);
	...
	if (rsp->fec >= 0)
		pfvf->linfo.fec = rsp->fec;
	...
end:
	mutex_unlock(&mbox->lock);

Would copying fwdata into a local under the lock be preferable here?

>  
> -	if (rsp->fwdata.supported_an)
> -		ethtool_link_ksettings_add_link_mode(cmd,
> -						     supported,
> -						     Autoneg);
> -
>  	otx2_get_link_mode_info(rsp->fwdata.advertised_link_modes,
>  				OTX2_MODE_ADVERTISED, cmd);
>  	otx2_get_fec_info(rsp->fwdata.advertised_fec,
>  			  OTX2_MODE_ADVERTISED, cmd);
> +	if (rsp->fwdata.advertised_an)
> +		ethtool_link_ksettings_add_link_mode(cmd,
> +						     advertising,
> +						     Autoneg);

[Severity: Medium]
Should this advertising bit be gated on rsp->fwdata.supported_an as well?

The firmware-owned struct cgx_lmac_fwdata_s in af/mbox.h carries this
comment over the advertised group:

	u64 supported_an;
	u64 supported_link_modes;
	/* only applicable if AN is supported */
	u64 advertised_fec;
	...
	u64 advertised_an:1;

and rvu_mbox_handler_cgx_get_aux_link_info() just memcpy()s the firmware
shared-memory image into the response, so the kernel never validates these
fields:

		memcpy(&rsp->fwdata,
		       &rvu->fwdata->cgx_fw_data[cgx_id][lmac_id],
		       sizeof(struct cgx_lmac_fwdata_s));

If an LMAC reports advertised_an while supported_an is zero, the advertising
mask ends up not being a subset of the supported mask.  Besides being an
inconsistent report, does that then make otx2_set_link_ksettings() reject
every later ethtool -s on that port, given the netlink set path re-feeds the
get advertising mask back into the driver?

	if (!linkmode_subset(cmd->link_modes.advertising,
			     cur_ks.link_modes.supported))
		return -EINVAL;

> +
>  	otx2_get_link_mode_info(rsp->fwdata.supported_link_modes,
>  				OTX2_MODE_SUPPORTED, cmd);
>  	otx2_get_fec_info(rsp->fwdata.supported_fec,
>  			  OTX2_MODE_SUPPORTED, cmd);
> +	if (rsp->fwdata.supported_an)
> +		ethtool_link_ksettings_add_link_mode(cmd,
> +						     supported,
> +						     Autoneg);

[Severity: High]
Now that ETHTOOL_LINK_MODE_Autoneg_BIT survives in both masks, can it leak
into the firmware link mode request?

The netlink set path seeds the request from the driver's get result,
ethnl_set_linkmodes() -> netif_get_link_ksettings() ->
otx2_get_link_ksettings(), and ethnl_auto_linkmodes() skips entries whose
link_mode_params speed is SPEED_UNKNOWN, which is the case for Autoneg, so
the bit is never cleared on the way back down.

In otx2_set_link_ksettings() the subset check now passes because the
supported mask contains Autoneg too, and the strip mask only covers the FEC
pseudo bits:

	linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT, mask);
	linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_BASER_BIT, mask);
	linkmode_set_bit(ETHTOOL_LINK_MODE_FEC_RS_BIT, mask);

	linkmode_copy(req->args.advertising,
		      cmd->link_modes.advertising);
	linkmode_andnot(req->args.advertising,
			req->args.advertising, mask);

so bit 6 reaches req->args.advertising.  It is also counted here, which can
misclassify a single mode request as multimode:

	if (bitmap_weight(req->args.advertising,
			  __ETHTOOL_LINK_MODE_MASK_NBITS) >= 2)
		req->args.multimode = true;

On the AF side, rvu_mbox_handler_cgx_set_link_mode() forwards the bitmap
unvalidated and cgx_set_link_mode() parses every bit as a link mode:

	for_each_set_bit(bit, args.advertising,
			 __ETHTOOL_LINK_MODE_MASK_NBITS)
		otx2_map_ethtool_link_modes(bit, &args);

Bit 6 matches no case in otx2_map_ethtool_link_modes() and lands in the
default arm:

	default:
		set_mod_args(args, 0, 1, 0, BIT_ULL(CGX_MODE_MAX));
		break;

With CGX_MODE_MAX being 53, does this end up OR-ing BIT_ULL(53) into the
mask written to the firmware shared advertised_link_modes when multimode is
set?  And when Autoneg is the only remaining bit, does set_mod_args() turn
it into an unrelated mode group 1 request?

	cgx_mode = find_first_bit((unsigned long *)&mode, CGX_MODE_MAX);
	args->mode = mode;
	mode_baseidx = cgx_mode - 41;
	if (mode_baseidx > 0) {
		args->mode_baseidx = 1;
		args->mode = BIT_ULL(mode_baseidx);
	}

Before this patch the Autoneg bit could not survive the linkmode_copy() in
otx2_get_link_mode_info(), so requests carrying it were rejected by the
subset check.  Would it make sense to also add
ETHTOOL_LINK_MODE_Autoneg_BIT to the strip mask in
otx2_set_link_ksettings(), and exclude it from the multimode weight, in the
same patch?

>  	return 0;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903161117.2856633-1-nshettyj%40marvell.com
