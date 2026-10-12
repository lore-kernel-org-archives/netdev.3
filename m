Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8745C6E6;
	Mon, 12 Oct 2026 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794458; cv=none; b=h83jilmrCRCDcqDkzG2ecuuI/wSxvxMOVe0eneFq6p9aL3Y27yclOLCR1dZ0P6M125LNKd6m/9mz25j8u7rs3M9TYIA0pzm1Aifa2ZKFTWZ82K5m8gbj0IsJiksNnfI9siAUyzPOprwW431zFRMYm1yGaIvzjxJPuwPvt56WHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794458; c=relaxed/simple;
	bh=mpvdjSjG6yKlGSAbffcGXjSwVQRMw+hHYg5VMZur0QU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVPYwM/ZA6ul3cihEcL+/+SUxJtGGIiB0kyvkCZRlFz4y6zjWt4afksKt/2W+dQ+R5rYU3jxzXqVuESz8PmG497JYyLE0f8C1r3OlafMGg2fhuhXaNasfj8Bx9DazAmv6Bl7hI1V0Z7Lghtt4ArmnIdVJycuQAvWszCD9p7tMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI99TSF0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI99TSF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC141F0089C;
	Mon, 12 Oct 2026 08:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791794456;
	bh=egYXV60732DYc0+bH0RPt7he1vgoVrW8edxdByobZDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PI99TSF0iYNzndubYyDTZ+03YppPeNcizePvAPTNFy3IVTg5zwBSx0BT9vJuAZS8m
	 FOZNnzV5f7VV6Ga9hT3RDc1ouCrfFG8SwuJHiq3iWA6rwhPfGoWeR76fJSBEo/Laun
	 d8B4zLo0vD6PtOupUwBgbhJZsZEiUSaNWmGXBCWjEPAduEipcQXf7p/29z1mTV2dCk
	 chLLo8O9vuveoXYrYeop7nK6fl8gZ5jW3msYRPmEPJ96hfV++E6GxuAYt8H4iFRax8
	 QRU44RDyUAw5iXXvC1AEx3wz8/KkoYeA6sNxW4JM3Y2H9sBLOLtpQCoXK8T5FYP6V3
	 kO9BnCM22M7Mw==
Subject: Re: [PATCH net-next V2] net/dcb: Validate bandwidth for non-ETS
 traffic classes
From: netdev-bot+sashiko@kernel.org
To: tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, alazar@nvidia.com,
 cjubran@nvidia.com, gal@nvidia.com, kees@kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@corigine.com, horms@kernel.org
Date: Mon, 12 Oct 2026 08:40:55 +0000
Message-ID: <179179445567.434549.13418460679554314301@kernel.org>
In-Reply-To: <20261011083929.739261-1-tariqt@nvidia.com>
References: <20261011083929.739261-1-tariqt@nvidia.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Round-trip mismatch: the kernel now rejects an ETS config that
  ice itself reports.

Pre-existing issues:
- [Medium] This problem was not introduced by this patch, but NFP's ETS
  path uses unchecked user-supplied prio_tc values as indexes into the…

--

net/dcb: Validate bandwidth for non-ETS traffic classes

This commit moves the check that rejects non-zero tc_tx_bw for non-ETS
traffic classes from the NFP driver into dcbnl_ieee_set(). Every driver
now gets this check. NFP's ETS bandwidth-sum check is left as it is.

> diff --git a/drivers/net/ethernet/netronome/nfp/nic/dcb.c b/drivers/net/ethernet/netronome/nfp/nic/dcb.c
> index bb498ac6bd7d6..91fbfa3708fc8 100644
> --- a/drivers/net/ethernet/netronome/nfp/nic/dcb.c
> +++ b/drivers/net/ethernet/netronome/nfp/nic/dcb.c
> @@ -218,9 +218,6 @@ static int dcb_ets_check(struct net_device *dev, struct ieee_ets *ets)
>  		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_ETS) {
>  			ets_exists = true;
>  			sum += ets->tc_tx_bw[i];
> -		} else if (ets->tc_tx_bw[i]) {
> -			nfp_warn(app->cpp, "ETS BW for strict/vendor TC must be 0.");
> -			return -EINVAL;
>  		}
>  	}

[Severity: Medium]
This problem was not introduced by this patch, but NFP's ETS path still
does not check the user-supplied prio_tc values. Can they index past the
end of the 8-entry dcb->tc2idx[] array?

Neither dcbnl_ieee_set() nor the DCB_ATTR_IEEE_ETS policy checks prio_tc.
After this patch, dcb_ets_check() only checks the bandwidth sum. An
all-strict config with all tc_tx_bw set to 0 and prio_tc[0] = 255 passes
both checks. nfp_nic_dcbnl_ieee_setets() then stores the value as is:

drivers/net/ethernet/netronome/nfp/nic/dcb.c:nfp_nic_dcbnl_ieee_setets() {
    ...
		dcb->prio2tc[i] = ets->prio_tc[i];
    ...
}

nfp_nic_fill_ets() later uses it as an index:

drivers/net/ethernet/netronome/nfp/nic/dcb.c:nfp_nic_fill_ets() {
    ...
		writeb(dcb->tc2idx[dcb->prio2tc[i]],
		       dcb->dcbcfg_tbl + dcb->cfg_offset + NFP_DCB_DATA_OFF_PCP2IDX + i);
    ...
}

This reads tc2idx[255], which is well past the end of the kzalloc'd
nfp_app_nic_private. The byte read goes into the device's PCP2IDX table.
update_dscp_maxrate() has the same index pattern:

		writeb(dcb->tc2idx[dcb->prio2tc[dcb->dscp2prio[i]]],

So does the setapp path, which looks up dcb->tc2idx[dcb->prio2tc[prio]].
Should prio_tc[i] < IEEE_8021QAZ_MAX_TCS be enforced somewhere on this
path?

> diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
> index 35164bfa563d1..ab71f53128760 100644
> --- a/net/dcb/dcbnl.c
> +++ b/net/dcb/dcbnl.c
> @@ -1578,6 +1578,15 @@ static int dcbnl_ieee_set(struct net_device *netdev, struct nlmsghdr *nlh,
>  
>  	if (ieee[DCB_ATTR_IEEE_ETS] && ops->ieee_setets) {
>  		struct ieee_ets *ets = nla_data(ieee[DCB_ATTR_IEEE_ETS]);
> +
> +		/* IEEE 802.1Qaz: BW allocation applies only to ETS TCs */
> +		for (int i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
> +			if (ets->tc_tsa[i] != IEEE_8021QAZ_TSA_ETS &&
> +			    ets->tc_tx_bw[i]) {
> +				err = -EINVAL;
> +				goto err;
> +			}
> +		}

[Severity: Medium]
Can this reject an ETS object that a driver itself reported back to user
space?

On ice in host-managed IEEE mode, take an all-strict config with all
tc_tx_bw set to 0, or one with every priority mapped to a strict TC0.
That config passes this new check. ice_dcbnl_setets() then gives TC0 100%
bandwidth without looking at tsatable[0]:

drivers/net/ethernet/intel/ice/ice_dcb_nl.c:ice_dcbnl_setets() {
    ...
	if (!bwcfg)
		new_cfg->etscfg.tcbwtable[0] = 100;
    ...
}

ice_dcb_bwchk() does the same when num_tc == 1 or total_bw == 0:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_dcb_bwchk() {
    ...
	if (num_tc == 1) {
		etscfg->tcbwtable[0] = ICE_TC_MAX_BW;
		return 0;
	}
    ...
	if (!total_bw) {
		etscfg->tcbwtable[0] = ICE_TC_MAX_BW;
    ...
}

ice_pf_dcb_cfg() copies new_cfg into local_dcbx_cfg. ice_dcbnl_getets()
then copies tcbwtable and tsatable into struct ieee_ets as they are. So
both GET replies and the RTM_SETDCB notification from dcbnl_ieee_notify()
report tc_tsa[0] = STRICT and tc_tx_bw[0] = 100.

If that object is sent back to DCB_CMD_IEEE_SET, it now fails here with
-EINVAL. Before this patch the same round trip worked on ice.

Read-modify-write users such as iproute2's dcb ets set read the current
ETS object before applying a change. Wouldn't a change to an unrelated
field like prio-tc or willing now fail, unless the user also clears the
strict TC's bandwidth each time? Save and restore of the reported object
would fail the same way.

Should drivers like ice be changed to stop reporting bandwidth for
non-ETS TCs before the core enforces this rule?

>  		err = ops->ieee_setets(netdev, ets);
>  		if (err)
>  			goto err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011083929.739261-1-tariqt%40nvidia.com
