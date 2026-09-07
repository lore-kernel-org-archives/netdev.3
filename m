Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834F29AB1A
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760733; cv=none; b=W3kgN4Yx8fAfbb5oyYwHMuuO0WAPw6vSm1baldQcnsTOS8koZOi8hpVlHjYJroP+5Cm9u6JiB6ZkdUX9+tT1ARHTCuNPjbz+upz35vTnxh1zAbqZLrYGEdwHRLBncfTWztY/3i2MBzAmFiLdeG2ZF9kA9vrw/z1BVb59PVigDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760733; c=relaxed/simple;
	bh=HpLxNuRy1pON1tYtT7afxn9PEwtPdnSS4Gi3Zob98xQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sCkjQzU2+TLaHzeuHTHfdlUQeH2HWZpRDzBEVwf+5p7XpNS43Knc3FNrfe0Aqgo3Zh44G0W+Kl+SIqriAwDTGqct8YkdUxsxt9hrORMgUHReqgBVisxAamNr+X4FhmvFlWDvP0KeMjjP4TxjgvGFBOSn4TqFviuKGfrVgKdkWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFxIP2Fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFxIP2Fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E81F00A3A;
	Mon,  7 Sep 2026 05:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760731;
	bh=x1qgomIFHE0BhGw3VxQcXzWHayHTQ+eiPfEKUkjZit0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TFxIP2FiL9Sfv1gMrZauVaKzwHSy+aASXMms+bFyj8GYk81M2C39+CGOnTFSgxYLo
	 p33vT8BRbNVB/fKlEPBE3oUn/bKQ8c9hjUFOn5967Sg+sRY7YClNaLbOfNPzRvOmj9
	 dud8Nd+bk2SY0fgx3KjWKtUW3zAPF7KYbS8o2MPJOxlUrIJ6q3KmvpnQbBYCTCTL14
	 qkuiZiSf4OH7hJ4QEq/5cjQlCdUvogJFDfLDCVv5jb27Lz7n68gV3alBaIzH3t07/f
	 oprkDWzVuj9GS43MDYV3a8XnRh0QivI9GaE8EoYJKn8GUZJqIePyY+8jkKnz1Oinnl
	 +0PGoV3qWva3Q==
Subject: Re: [net-next PATCH 1/2] fbnic: Don't reject capabilities when BMC is
 present without a MAC
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Mon, 07 Sep 2026 05:58:50 +0000
Message-ID: <178876073051.219967.16317151777131268661@kernel.org>
In-Reply-To:
 <178845827907.2787.3876388161665795031.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178845827907.2787.3876388161665795031.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 2

- [Medium] fbnic_fw_parse_bmc_cap() (fbnic_fw.c:610-642) encodes 'FW says
  BMC present but sent no MAC array' as fw_cap.bmc_present = false and…
- [Medium] fbnic_fw_parse_bmc_cap() reads FBNIC_FW_CAP_RESP_BMC_ALL_MULTI
  only on the success path (fbnic_fw.c:634); the new no_bmc path…
- [Low] Missing Fixes: tag on a real bug fix.
- [Low] Claimed hardware/driver state divergence: the new no_bmc path
  clears fw_cap.bmc_mac_addr[] and reports bmc_present = false without…

--

fbnic: Don't reject capabilities when BMC is present without a MAC

The capability response parser no longer returns -EINVAL when firmware
reports the BMC present without a BMC MAC address array; instead the stored
BMC MAC addresses are cleared and the rest of the message is parsed.  The
BMC handling is moved into a new helper, fbnic_fw_parse_bmc_cap().

A few questions below.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index ff1674eff7ad5..bf8006710f461 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -607,6 +607,40 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
>  	return 0;
>  }
>
> +static int fbnic_fw_parse_bmc_cap(struct fbnic_dev *fbd,
> +				  struct fbnic_tlv_msg **results,
> +				  bool *bmc_present, u32 *all_multi)
> +{
> +	struct fbnic_tlv_msg *attr;
> +	int err;
> +
> +	/* The FW reports the BMC present as soon as its NC-SI channel is
> +	 * enabled, which is before the BMC has been assigned a MAC address.
> +	 * In that window the message carries no MAC array; there is nothing
> +	 * to program, so treat the BMC as absent. On any absence clear the
> +	 * stored BMC MAC addresses and report the BMC as not present.
> +	 */
> +	if (!results[FBNIC_FW_CAP_RESP_BMC_PRESENT])
> +		goto no_bmc;
> +
> +	attr = results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY];
> +	if (!attr)
> +		goto no_bmc;

[Severity: Medium]
Is the comment's claim that "there is nothing to program" accurate when the
MAC array is missing?

fbnic_bmc_rpc_init() programs several things that do not depend on the MAC
array at all: the broadcast MACDA entry tagged FBNIC_MAC_ADDR_T_BMC and the
BMC action rule at FBNIC_RPC_ACT_TBL_BMC_OFFSET.  It bails out up front:

drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:fbnic_bmc_rpc_init() {
	/* Check if BMC is present */
	if (!fbnic_bmc_present(fbd))
		return;
	...
}

fbnic_rss_reinit() also ORs the BMC destination into the multicast and
broadcast RSS actions based on the same flag:

	if (i >= FBNIC_RSS_EN_NUM_UNICAST && fbnic_bmc_present(fbd))
		dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
				   FBNIC_RPC_ACT_TBL0_DEST_BMC);

Two more consumers read the flag as "the NC-SI channel is live", not as "we
have BMC MAC addresses".  fbnic_rss_disable_hw() reprograms
FBNIC_RPC_RMI_CONFIG when the BMC is reported absent, and fbnic_stop()
forwards it straight to phylink as the mac_wol argument:

drivers/net/ethernet/meta/fbnic/fbnic_netdev.c:fbnic_stop() {
	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
	...
}

So for a message with BMC_PRESENT set and no MAC array, the RPC block can be
disabled and the MAC/PCS link dropped while firmware has told the host the
NC-SI channel is enabled.

Also, before this patch such a message left the previously recorded BMC
state alone (the function returned -EINVAL before touching it).  Now a
"present, MACs programmed" -> "present, no MAC array" transition clears the
state, and with the follow-up commit "fbnic: Remove BMC routing rules when
the BMC channel is disabled" the programmed BMC MACDA entries, action rule
and DEST_BMC copies are actively removed from hardware.

Would it be better to track MAC-address availability separately from
BMC/NC-SI channel presence rather than overloading fw_cap.bmc_present?

> +
> +	err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr, attr, 4);
> +	if (err)
> +		return err;
> +
> +	*all_multi = fta_get_uint(results, FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
> +	*bmc_present = true;
> +	return 0;
> +
> +no_bmc:
> +	memset(fbd->fw_cap.bmc_mac_addr, 0, sizeof(fbd->fw_cap.bmc_mac_addr));
> +	*bmc_present = false;
> +	return 0;
> +}

[Severity: Medium]
Can this path lose a BMC all-multi request that firmware actually sent?

FBNIC_FW_CAP_RESP_BMC_ALL_MULTI is only read on the success path, so the
no_bmc path returns 0 with *all_multi still at the caller's initializer of
0.  Because *bmc_present is forced false, the retention guard in
fbnic_fw_parse_cap_resp() commits that 0:

	if (results[FBNIC_FW_CAP_RESP_BMC_ALL_MULTI] || !bmc_present)
		fbd->fw_cap.all_multi = all_multi;

That guard appears to exist so a message omitting the attribute keeps the
previously recorded value, but the !bmc_present half now fires even for a
message that carried BMC_ALL_MULTI=1, since fta_get_uint() was never called
on it.

The sequence would be:

  msg0 {PRESENT, MAC_ARRAY, ALL_MULTI=1} -> fw_cap.all_multi = 1
  msg1 {PRESENT, ALL_MULTI=1, no MAC array} -> fw_cap.all_multi = 0
  msg2 {PRESENT, MAC_ARRAY, no ALL_MULTI attr} -> guard false, 0 retained

and fbnic_bmc_rpc_all_multi_config() then tears down or never installs the
BMC all-multi entry:

drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:fbnic_bmc_rpc_all_multi_config() {
	if (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi || enable_host) {
		if (act_tcam->state == FBNIC_TCAM_S_VALID)
			act_tcam->state = FBNIC_TCAM_S_DELETE;
		return;
	}
	...
}

Pre-patch the -EINVAL return left fw_cap.all_multi untouched, so this looks
introduced here.  Would parsing BMC_ALL_MULTI unconditionally, or leaving
*all_multi untouched and letting the caller's guard do its job, be closer to
the intent?

On a related note, the fbnic_fw_parse_bmc_addrs() error path returns without
ever writing *bmc_present.  It works today only because the caller returns
immediately on error.  Would setting it there be worth doing?

[Severity: Low]
One more observation on this path, which resolves itself later in the
series.  Clearing fw_cap.bmc_mac_addr[] and reporting bmc_present = false
does not release the already programmed BMC filters (the MACDA entries from
FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX, the BMC-tagged broadcast entry, the act
TCAM rule at FBNIC_RPC_ACT_TBL_BMC_OFFSET and the TCE TCAM BMC
destinations), while fbnic_bmc_rpc_init() early-returns on
!fbnic_bmc_present() so the need_bmc_tcam_reinit pass cannot clean them up,
and fbnic_clear_macda() only warns and re-marks such entries:

drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:fbnic_clear_macda() {
	if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam)) {
		if (fbnic_bmc_present(fbd))
			continue;
		dev_warn_once(fbd->dev,
			      "Found BMC MAC address w/ BMC not present\n");
	...
}

The follow-up commit "fbnic: Remove BMC routing rules when the BMC channel
is disabled" adds fbnic_bmc_rules_present() and fbnic_bmc_rpc_disable() to
fbnic_bmc_rpc_check() and pushes the removals into hardware, so the shadow
state and hardware are back in sync by the end of the series.  Is the
intermediate state between the two commits worth avoiding, or is bisecting
into this window not a concern here?

> +
>  static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
>  {
>  	u32 all_multi = 0, version = 0;

[ ... ]

> @@ -671,25 +705,9 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
>  	fbd->fw_cap.link_fec =
>  		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_FEC);
>
> -	bmc_present = !!results[FBNIC_FW_CAP_RESP_BMC_PRESENT];
> -	if (bmc_present) {
> -		struct fbnic_tlv_msg *attr;
> -
> -		attr = results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY];
> -		if (!attr)
> -			return -EINVAL;

[Severity: Low]
Should this patch carry a Fixes: tag?  git blame attributes the -EINVAL
rejection being removed here to 20d2e88cc7461b, which has been in released
kernels for a couple of years.

The commit message describes a user-visible defect on those kernels: a
well-formed capabilities message is rejected, fw_cap.bmc_present,
fw_cap.all_multi and fw_cap.anti_rollback_version are not recorded,
need_bmc_tcam_reinit stays unset, and fbnic_mbx_process_rx_msgs() logs
"Unable to process message" with a hex dump.

Without a Fixes: tag (or a note that the fix is intentionally not
backportable) stable tooling will not pick this up.

>  	fbd->fw_cap.bmc_present = bmc_present;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178845766796.2787.6001399537275460493.stgit%40ahduyck-xeon-server.home.arpa
