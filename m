Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F293751596D;
	Mon, 21 Sep 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026346; cv=none; b=ksb6vHaZVHfEbKhfDC4K2j3g7iKf9/161VKevSQcwUa6az3QdmxeQjVSMCsvnkml/NoIIOpVWxGsv3oW2YAk9uDHNn3u4kZsu7y5xrLeYxitmER3Cmou/LEcZ0dE0ajTOLiQi1o+2djrerLHgFHKq+g7uv16zg4hBiI1lJ3w7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026346; c=relaxed/simple;
	bh=NmiiPM5bj1AXhlcvKdRAeFk4qSnecvP5GUd4UYJVgf8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COjhdGLuFWKggt3t42w+PmTSbO/iOf2HxvJr+ojUFcMrRPCk6+sj0pndlbSSVqz6P4eFFs2YAUifmPJphCEWWTuSkMrkodh4MT5JjJRW6KR2v5lCcyJqr8xqyyjQAR+aO/Hs7WsbTltZDqxoW2lFHX+ROG+Z8oOudEX42JTzCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYuUe7cV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYuUe7cV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2B71F000FF;
	Mon, 21 Sep 2026 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790026344;
	bh=c/PP3qmHY5ndB18W+iv3W1sPrDnXUtoEtSTPXz4Gfz0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kYuUe7cVncGTfdIdh0cxzyxdaze53XJjAzMh9cQa/SYT+2agjP9PLOCY7hTn6BBZR
	 tTnJyN3elEQymP5q3/yxHJWPyLiWP2sp723A0gQ5JSlxWJDlFiC0AvLog9hS3st5Lx
	 q2aAr2wY3hoTDjaiZgWEVj6dRCEEb3/ShK4ipTMvFe+Fs5bagw4teLvg6NDG5DJB9F
	 1hJCUAe1i/5ThCU7ZQToimP1v8X0BEdCEh+9tz4zDYP8vzTeJACSrGlTxVlFl2LSKx
	 +qIgrT1CkhIgg8eV1fhTR3QZHvAANPzTxajvrmh8qIUAAJGlNIbmVLVaIeIE1jELjq
	 dUHVwJgpI7Gng==
Subject: Re: [PATCH net-next 3/3] i40e: trigger PF reset when re-enabling ATR
 via ethtool
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 mheib@redhat.com, przemyslaw.kitszel@intel.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 21:32:23 +0000
Message-ID: <179002634332.2160803.9163338355195427947@kernel.org>
In-Reply-To: <20260917204541.3072415-4-anthony.l.nguyen@intel.com>
References: <20260917204541.3072415-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The reset request the patch adds is stored in the shared scalar
  `reset_needed`, which a later, unrelated error path zeroes — so the…
- [Medium] The failure mode this commit fixes was introduced two commits
  earlier in the same series by 6f0c883685a0 ("i40e: move ATR sample…
- [Medium] i40e_set_priv_flags() now requests a full PF reset on every
  0->1 transition of the flow-director-atr private flag, with no check…
- [Medium] The new ATR block assigns `reset_needed` with `=` instead of
  combining with the existing request, silently downgrading the stronger…
- [Medium] i40e_atr()'s gate on I40E_FLAG_FD_ATR_ENA is published to the
  lockless Tx fast path before the hardware context is updated, so the…

--

i40e: trigger PF reset when re-enabling ATR via ethtool

This adds a PF reset request in i40e_set_priv_flags() whenever the
flow-director-atr private flag transitions from off to on, so that
tx_ctx.fd_ena is recomputed in i40e_configure_tx_ring(). A few questions
about the new reset request and how it interacts with the rest of
i40e_set_priv_flags() are below.

First, a question about the commit message itself:

>     Toggling flow-director-atr via ethtool private flags does not trigger a
>     ring reset. If ATR was disabled while fd_ena was cleared in the TX queue
>     HW context (e.g. after a ring reset with both ATR and ntuple off),
>     re-enabling ATR causes i40e_atr() to inject FDIR descriptors into a
>     queue where fd_ena is still 0.

[Severity: Medium]
Is this describing a long-standing defect, or one introduced two commits
earlier in this same series by 6f0c883685a0 ("i40e: move ATR sample rate
from ring to PF level")?

Before that commit, i40e_configure_tx_ring() cleared the per-ring sample
rate in exactly the scenario described here:

	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags))
		ring->atr_sample_rate = vsi->back->atr_sample_rate;
	else
		ring->atr_sample_rate = 0;

and i40e_atr() returned early on it:

	if (!tx_ring->atr_sample_rate)
		return;

So a ring configured with both ATR and ntuple off had fd_ena == 0 and
atr_sample_rate == 0, and re-enabling the private flag could not reach the
descriptor-writing code. 6f0c883685a0 removed that gate in favour of
pf->atr_sample_rate, which i40e_sw_init() initialises once to
I40E_DEFAULT_ATR_SAMPLE_RATE and is therefore never zero.

If that reading is right, the tree is broken at 6f0c883685a0 and
41347643da7b and repaired only here, which makes a bisect land in a window
with the described misprogramming. Would it be better to keep the gate (or
program fd_ena unconditionally) in the patch that removes it, and to add a
Fixes: tag here so stable backporters do not pick up a disruptive PF reset
for kernels that never had the regression?

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index ef9d1e78c16a2..79c2cdab0f516 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -5301,6 +5301,13 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
>  	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
>  		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
>  
> +	/* Re-enabling ATR requires a reset to update fd_ena in the
> +	 * TX queue HW context.
> +	 */
> +	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
> +	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags))
> +		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
> +

[Severity: Medium]
Can this assignment discard the stronger reset type requested a few lines
above in the same function?

i40e_set_priv_flags() has already run:

	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;

and the new block overwrites reset_needed with BIT(__I40E_PF_RESET_REQUESTED)
using plain assignment, so a single ethtool write that changes
disable-fw-lldp and flow-director-atr together ends up with the weaker
selector.

i40e_do_reset() then tests the two in an else-if chain, with the PF reset
branch first:

	} else if (reset_flags & I40E_PF_RESET_FLAG) {
		i40e_handle_reset_warning(pf, lock_acquired);

	} else if (reset_flags & I40E_PF_RESET_AND_REBUILD_FLAG) {
		i40e_prep_for_reset(pf);
		i40e_reset_and_rebuild(pf, true, lock_acquired);

so reinit is false and i40e_setup_pf_switch() skips the main VSI
re-initialisation that the FW LLDP change asked for:

	else if (reinit)
		main_vsi = i40e_vsi_reinit_setup(main_vsi);

The "FW LLDP is enabled/disabled" dev_info() in the rebuild branch is lost
as well. Note that changing = to |= would not be sufficient here, since
i40e_do_reset() prefers I40E_PF_RESET_FLAG over
I40E_PF_RESET_AND_REBUILD_FLAG; does the selection logic need reworking so
the stronger request wins?

[Severity: High]
Can the reset this patch depends on be dropped later in the same call while
the ATR flag is still committed?

Further down in i40e_set_priv_flags(), the FW LLDP re-enable path clears
reset_needed on a non-fatal admin queue status:

	status = i40e_aq_start_lldp(&pf->hw, false, NULL);
	if (status) {
		adq_err = pf->hw.aq.asq_last_status;
		switch (adq_err) {
		case LIBIE_AQ_RC_EEXIST:
			dev_warn(&pf->pdev->dev,
				 "FW LLDP agent is already running\n");
			reset_needed = 0;
			break;

and the flag publication is unconditional while the reset is not:

	bitmap_copy(pf->flags, new_flags, I40E_PF_FLAGS_NBITS);

	if (reset_needed)
		i40e_do_reset(pf, reset_needed, true);

Since tx_ctx.fd_ena is only recomputed when the Tx queue context is
rewritten:

i40e_configure_tx_ring()
	if (test_bit(I40E_FLAG_FD_SB_ENA, vsi->back->flags) ||
	    test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags))
		tx_ctx.fd_ena = 1;

does this leave I40E_FLAG_FD_ATR_ENA set in pf->flags with fd_ena still 0,
which is the state the commit message says it is closing? The private-flags
ioctl carries the whole bitmap, so disable-fw-lldp off and
flow-director-atr on can be changed in one command while the FW agent is
already running.

[Severity: Medium]
Is there a window between publishing the flag and quiescing Tx where
i40e_atr() can still post descriptors to a ring with fd_ena == 0?

The flag becomes visible to the lockless Tx path at bitmap_copy(pf->flags,
new_flags, ...), and only the subsequent i40e_do_reset() reaches
i40e_prep_for_reset() -> i40e_pf_quiesce_all_vsi(). Meanwhile i40e_atr(),
called from i40e_xmit_frame_ring() in softirq context on another CPU, gates
only on software state:

	/* make sure ATR is enabled */
	if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
		return;

	if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
		return;

	sample_rate = READ_ONCE(pf->atr_sample_rate);
	if (!sample_rate)
		return;

__I40E_FD_ATR_AUTO_DISABLED does not appear to cover the window either, as
it is cleared asynchronously in i40e_fdir_flush_and_replay():

		if (!disable_atr && !pf->fd_tcp4_filter_cnt)
			clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);

as well as in i40e_reenable_fdir_atr() and i40e_set_ntuple(). Would keeping
ATR suppressed until after the rebuild (for example holding
__I40E_FD_ATR_AUTO_DISABLED across the re-enable and clearing it once the Tx
context has been reprogrammed, or publishing the flag after the reset) close
this ordering gap?

[Severity: Medium]
Should the reset be conditional on the HW context actually being stale?

i40e_configure_tx_ring() sets tx_ctx.fd_ena = 1 when either
I40E_FLAG_FD_SB_ENA or I40E_FLAG_FD_ATR_ENA is set, so on a system with
ntuple/side-band filtering enabled, fd_ena is already 1 and nothing needs to
change. With this patch, the sequence

	ethtool --set-priv-flags ethX flow-director-atr off
	ethtool --set-priv-flags ethX flow-director-atr on

always runs i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true) ->
i40e_handle_reset_warning() -> i40e_prep_for_reset(), which quiesces all
VSIs, calls i40e_vc_notify_reset() for VFs and shuts down the admin queue
and HMC, turning a previously non-disruptive flag write into a traffic stop,
link flap and VF reset.

Could the condition also test that FD_SB is off (so fd_ena can really be 0),
or alternatively could i40e_configure_tx_ring() program fd_ena from the FD
capability rather than the current flag state so no reset is needed at all?
The commit message says a reset is triggered but does not mention that it
happens unconditionally, including when fd_ena cannot be stale.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204541.3072415-1-anthony.l.nguyen%40intel.com
