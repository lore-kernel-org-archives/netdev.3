Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B24446EE;
	Fri,  4 Sep 2026 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560734; cv=none; b=ZoMA8ZdXufDFO002KwCY6D0sqioDUPr9mnru+NzktD1wRwVh6TsfO+my9JCpxH1eCYkGzngc4dzSigglF0M7K/Aun64+CA0bsKqqyHf6UAk3pzcj48pCjEU52IwJ/V3F0l50uyhF8z5kfi/SNFh9MTsOWBxN1qp/UB5aL2amCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560734; c=relaxed/simple;
	bh=plt0jf4XaOxklAwzllfneZHovTR6Yt/bH3VJHEeKdX8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UsHBcuWpZcLCZ3Qu/4XpQqS01PwEmjtu0A4Ns50i3C9U2/HsaBLDo69ef6Y0ZtcsUAuFw2trezIVngD/gEo7I7m+r8zL1Vm9V2sRKpcwWnAlMJt/5QgzX1ELT2uBbw2hEUdshm+7ZJ4kq9Yg+36W5QcRrxZal04nf551SodyFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsWtfwMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsWtfwMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4EB1F00A3E;
	Fri,  4 Sep 2026 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560730;
	bh=A3vjSlAs0WBHdXPrKIdEU45RVIMErm6MTbTPGAeH5Mg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AsWtfwMZAsOhd/EHu1R6YT6uEIPQ1zf7gnP8JMWV6E+byb2+AB3I9Ycb0TgfVgFPh
	 u4AW5djx9sTysx9quDjX0XjMXMYtx4YPkuzSUga3kHAmoilTGCrYlcFLYRrDwrKwDX
	 a4kiAAsVLFBbLL5+NkC3hFTuMJzx1PS+JXGSUml40EAMPMzMQretVQfLhB7zeMTHPz
	 l1VMgd/3Fn3hlbILorbORD49XdKDj/sDB/wLYOe5L7/jhA6O2RmL8gXGKyxnBBDX9K
	 df4PtdREgHZjYSUYHZpgxGKdxieuVjsk+Q1CEAknz42n8qxamkhJfiUHEPicc6eGiv
	 Es/F0A4OywG7Q==
Subject: Re: [PATCH v3 net-next 4/8] net: dsa: netc: use entry ID instead of
 pointer to track host flood rule
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 04 Sep 2026 22:25:29 +0000
Message-ID: <178856072932.219967.8769401886867777305@kernel.org>
In-Reply-To: <20260831082335.1184605-5-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-5-wei.fang@oss.nxp.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2 (1)

- [Low] struct netc_port is devm_kzalloc()'d, so the new `u32
  ipft_hf_eid` starts at 0, but the patch only writes the…
- [Low] Removing netc_free_host_flood_rules() also removes the only in-
  tree documentation of a deliberate design decision: 'No need to clear…

Pre-existing issues:
- [Low] netc_port_remove_host_flood() discards the return status of
  ntmp_ipft_delete_entry() (drivers/net/dsa/netc/netc_main.c:1776) and…

--

net: dsa: netc: use entry ID instead of pointer to track host flood rule

This replaces the struct ipft_entry_data pointer in struct netc_port with a
u32 entry ID using NTMP_NULL_ENTRY_ID as the sentinel, frees the
ipft_entry_data allocation inside netc_port_add_host_flood_rule() once the
hardware entry is committed, and drops netc_free_host_flood_rules().

A few questions below.

> diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
> index 77077352c1a57..d326a00104e1d 100644
> --- a/drivers/net/dsa/netc/netc_main.c
> +++ b/drivers/net/dsa/netc/netc_main.c
> @@ -286,6 +286,12 @@ static int netc_init_all_ports(struct netc_switch *priv)
>  				dev_err(dev, "Failed to create MDIO bus\n");
>  				return err;
>  			}
> +
> +			/* The ipft_hf_eid is initialized to an invalid entry
> +			 * ID because the host flood rule (IPFT entry) has not
> +			 * been created.
> +			 */
> +			np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
>  		}
>  	}

[Severity: Low]
Should the sentinel be written for every port rather than only inside the
dsa_port_is_user(dp) branch?

Each netc_port is devm_kzalloc()'d in the earlier loop of
netc_init_all_ports(), so ipft_hf_eid starts at 0, which is a legal
hardware IPFT entry ID rather than "no rule".  The old field was a pointer,
where the zeroed value (NULL) was inherently the safe "no rule" marker.

netc_port_remove_host_flood() only recognizes the 0xffffffff sentinel:

	if (entry_id == NTMP_NULL_ENTRY_ID)
		return;
	...
	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);

so a port that never got the assignment would pass that guard and delete
hardware entry ID 0, which may belong to another port.

I could not find a path that reaches netc_port_remove_host_flood() or
netc_port_bridge_join() with a non-user port today - dsa_port_set_host_flood()
comes only from dsa_user_manage_host_flood(), and the bridge join/leave
callers all operate on user ports - so this looks latent rather than
reachable.  Would moving the assignment into the devm_kzalloc() loop that
sets np->switch_priv and np->iobase make the representation fail-safe for
all ports?

> @@ -938,30 +944,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
>  	mutex_destroy(&priv->vft_lock);
>  }
>  
> -static void netc_free_host_flood_rules(struct netc_switch *priv)
> -{
> -	struct dsa_port *dp;
> -
> -	dsa_switch_for_each_user_port(dp, priv->ds) {
> -		struct netc_port *np = priv->ports[dp->index];
> -
> -		/* No need to clear the hardware IPFT entry. Because PCIe
> -		 * FLR will be performed when the switch is re-registered,
> -		 * it will reset hardware state. So only need to free the
> -		 * memory to avoid memory leak.
> -		 */
> -		kfree(np->host_flood);
> -		np->host_flood = NULL;
> -	}
> -}
> -
>  static void netc_teardown(struct dsa_switch *ds)
>  {
>  	struct netc_switch *priv = ds->priv;
>  
>  	disable_delayed_work_sync(&priv->fdbt_ageing_work);
>  	netc_destroy_all_lists(priv);
> -	netc_free_host_flood_rules(priv);
>  	netc_free_ntmp_user(priv);
>  }

[Severity: Low]
Could the deleted rationale be preserved somewhere?  Behaviour is unchanged
(netc_teardown() still leaves the host flood IPFT entries programmed in
hardware), but this hunk removes the only in-tree record of why that is
intentional:

	/* No need to clear the hardware IPFT entry. Because PCIe
	 * FLR will be performed when the switch is re-registered,
	 * it will reset hardware state. ...
	 */

Note that the FLR assumption holds for a PCI re-probe, where
netc_switch_pci_probe() calls pcie_flr(pdev), but a DSA teardown/setup cycle
on the same pci_dev does not perform FLR.  Would it help to keep the comment
in netc_teardown() or next to the ipft_hf_eid field so the assumption can be
re-checked later?

> @@ -1759,37 +1747,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,

[ ... ]

> -static void netc_port_remove_host_flood(struct netc_port *np,
> -					struct ipft_entry_data *host_flood)
> +static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
>  {
>  	struct netc_switch *priv = np->switch_priv;
>  	bool disable_host_flood = false;
>  
> -	if (!host_flood)
> +	if (entry_id == NTMP_NULL_ENTRY_ID)
>  		return;
>  
> -	if (np->host_flood == host_flood)
> +	if (np->ipft_hf_eid == entry_id)
>  		disable_host_flood = true;
>  
> -	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
> -	kfree(host_flood);
> +	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
>  
>  	if (disable_host_flood) {
> -		np->host_flood = NULL;
> +		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
>  		np->uc = false;
>  		np->mc = false;
>  		netc_port_wr(np, NETC_PIPFCR, 0);

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but can the
IPFT entry become unremovable here?

ntmp_ipft_delete_entry() can fail (DMA buffer allocation or command BD
error), and its status is discarded before np->ipft_hf_eid is reset to
NTMP_NULL_ENTRY_ID, so the armed entry (FLTFA=REDIRECT, HR=NETC_HR_HOST_FLOOD)
stays in hardware with no software handle left.

This appears to be addressed by the following patch in the series, which
makes netc_port_remove_host_flood() return int, checks the delete status
before clearing np->ipft_hf_eid/uc/mc, and handles the error at all call
sites.

> @@ -1818,20 +1805,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
>  
>  	/* IPFT does not support in-place updates to the KEYE element,
>  	 * we need to add a new entry and then delete the old one. So
> -	 * save the old entry first.
> +	 * save the old entry ID first.
>  	 */
> -	old_host_flood = np->host_flood;
> -	np->host_flood = NULL;
> +	old_entry_id = np->ipft_hf_eid;
>  
>  	if (netc_port_add_host_flood_rule(np, uc, mc)) {
> -		np->host_flood = old_host_flood;
>  		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
>  			port);
>  		return;
>  	}
>  
>  	/* Remove the old host flood entry */
> -	netc_port_remove_host_flood(np, old_host_flood);
> +	netc_port_remove_host_flood(np, old_entry_id);
>  }

[Severity: Low]
Same pre-existing concern in this key-update flow, which this patch does not
change: because the new entry is added before the old one is deleted, a
failed delete leaves two live IPFT entries matching the same source port with
PIPFCR still enabled.  The subsequent patch in the series inverts the order to
delete-then-add, which closes that window.

> diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
> index 305f2a92e2f9a..020e3661b8667 100644
> --- a/drivers/net/dsa/netc/netc_switch.h
> +++ b/drivers/net/dsa/netc/netc_switch.h
> @@ -84,7 +84,11 @@ struct netc_port {
>  	u16 uc:1;
>  	u16 mc:1;
>  	u16 pvid;
> -	struct ipft_entry_data *host_flood;
> +	/* ipft_hf_eid applies only to user ports and should be initialized
> +	 * to NTMP_NULL_ENTRY_ID. Other ports (such as CPU ports) do not
> +	 * require initialization.
> +	 */
> +	u32 ipft_hf_eid;
>  };

[Severity: Low]
This comment records the partial initialization discussed above as an
invariant.  Since 0 is a valid IPFT entry ID, would it be safer to
initialize ipft_hf_eid for all ports and drop the "other ports ... do not
require initialization" wording?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831082335.1184605-1-wei.fang%40oss.nxp.com
