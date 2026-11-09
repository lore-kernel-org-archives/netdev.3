Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264096;
	b=1TnbKzgdQiva48aU8FsepbLAxErT/SLAGxG7WUuKD75XR8DRwuqJIB34WT0PSTZvkGaL
	 vtG4NIPLlK5EGsN78EPOdV7rB2a83DaMDFKAPjy/2ZHenRdkhCElUUJzs36gUhq5xHTCs
	 lV0uKbjrXkqRwmGD0vmHHgpr8phFopoq584cDibI/GD/6A1zunKcq39k0sQqfHTAVlvOs
	 hTuBHr3p0T8bhzuuXd1TOAyKqLTdZsrbPV3y5PQ6Md8FIK1v4N/o9GKhYrDXX3kOZrfWt
	 hCwZwyzygyId9+pu+z9EhpriEmHq+D7XxsWu9iKhydVrv13OCmGHr/oxcWS66t8tUiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264096;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0FmOT40SSGTEJ8nAUd6PHhQJfpkzfaV1DQZc2IL/c4g=;
	b=GM20zFJrHCRezueQJdeCEjfixuEsKubO04bc82CcjKq1yBbWVJGvPJg+r2AB7WUEoiDg
	 avqsdx0GnvtiRF7NfO8N0ydCszfatXmUTB7F87gQMYBhnO8vc8QE6rdMoCSHUPvE0fip2
	 bLD1OA5HQY2IcAx+uxPgROM/T10UCcSE5mPcYvYipgcEcDtkTtC6+Fn/NPDppWTykS5zX
	 8zEaK/dWRiG5cB8jH/B2sq1E/xIFfukIVSbJYuIuibv0EQI+LyOslBkkzfAP4T4bGFVPc
	 6+j+m2s8V0GRdFj9cQF0zvLyNzNcsV4Xmet4Lq+HIXs0cKo8tcs/R0t0FUeof7MmZ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvGAT3WY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A55606A338;
	Mon,  9 Nov 2026 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvGAT3WY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7511F0089F;
	Mon,  9 Nov 2026 22:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264095;
	bh=0FmOT40SSGTEJ8nAUd6PHhQJfpkzfaV1DQZc2IL/c4g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OvGAT3WY2lqJf+x65niUYy5RRXbHypKdImba1ImF2KnOYLPiHNrnuaCU1Ox4OE9nt
	 ld0MqAux4mV9fqrmQronw0F6vz9DHtLAs3FUXvtdQgZm10geCm5KYQ6E72cMmhn5dt
	 GSKeMwuPSCVIQuKY8nUCJipskiYUCyEqlPEQRioKti0PFrC4rdaeFTGTXt40jnxqY9
	 c/IijNAkiNbb92f5XF6Fj1LS0/n24w1jojrxele/eEEp4NC8xHUSu54eKiS2Km6lQU
	 4I1N2HjmBaClR59cLXr38UB3dbNRECiqXVn3dRCVwsm0gTMtvsFczwirw9YBnQJDhL
	 VamZJWECPpoIA==
Subject: Re: [PATCH] wifi: mac80211: use frame link_id when adjusting link_sta
 on reorder release
From: netdev-bot+sashiko@kernel.org
To: NoahWeinberger2003@proton.me
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org,
 kuba@kernel.org
Date: Mon, 09 Nov 2026 22:41:34 +0000
Message-ID: <179426409490.994134.13077118770469155374@kernel.org>
In-Reply-To: <Sq80dyNRnQWE5H_yZYIwxaQiwgvIrIlET6kND66_K0UpnKQZruHroWDq6hlYKDM0y9e2vXW2UBlBmnjw3bCLKk1Acrp7F49_jk883tbCqxk=@proton.me>
References: <Sq80dyNRnQWE5H_yZYIwxaQiwgvIrIlET6kND66_K0UpnKQZruHroWDq6hlYKDM0y9e2vXW2UBlBmnjw3bCLKk1Acrp7F49_jk883tbCqxk=@proton.me>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message names the wrong trigger for the link[-1]
  access.
- [Low] The commit has no Signed-off-by: line.
- [Low] The Fixes: tag is a literal placeholder ('Fixes: [fill in before
  sending - on a full clone run: git log -S ...]').
- [Low] The commit message is a bug report or cover email, not a
  changelog.

--

wifi: mac80211: use frame link_id when adjusting link_sta on reorder release

This patch changes the link-adjust block in ieee80211_rx_handlers(). When
a released frame arrived on a different link, rx->link_sta is now looked
up with the frame's own status->link_id instead of the previous
rx->link_id. This avoids indexing rx->sta->link[] with -1.

> In ieee80211_rx_handlers(), when frames are released from the BA reorder
> buffer on timeout, rx->link_sta is re-fetched using the *previous*
> rx->link_id instead of the frame's own status->link_id. For a legacy
> (non-MLO) client on an MLO access point,
> ieee80211_release_reorder_timeout() passes link_id = -1 and
> ieee80211_rx_data_set_sta() never updates rx->link_id, so the adjust
> block evaluates rcu_dereference(rx->sta->link[-1]).

[ ... ]

> nan_sched and the driver-private area that follow deflink. At minimum
> this is a remotely triggered crash on MLO APs serving legacy clients;
> worse outcomes are layout-dependent.

[Severity: Medium]
Is this the right trigger for the link[-1] access? For stations added
through nl80211 on an MLD interface, nl80211_new_station() requires a
link ID:

net/wireless/nl80211.c:nl80211_new_station() {
    ...
	if (wdev->valid_links) {
		if (params.link_sta_params.link_id < 0)
			return -EINVAL;
    ...
}

ieee80211_add_station() then goes through sta_info_alloc_with_link().
__sta_info_alloc() sets valid_links for non-MLO stations as well:

	if (link_id >= 0) {
		sta_info_add_link(sta, link_id, &sta->deflink,
				  &sta->sta.deflink);
		sta->sta.valid_links = BIT(link_id);

So ieee80211_release_reorder_timeout() picks a real link:

	if (sta->sta.valid_links)
		link_id = ffs(sta->sta.valid_links) - 1;

ieee80211_rx_data_set_sta()->ieee80211_rx_data_set_link() then sets
rx->link_id to the station's own link. That matches status->link_id, so on
this path a legacy client never enters the adjust block.

Before this patch, the caller that does reach rx->sta->link[-1] seems to
be ieee80211_mark_rx_ba_filtered_frames(), which always passes -1:

	if (!ieee80211_rx_data_set_sta(&rx, sta, -1))
		return;

On an MLD vif with a station that has valid_links set (MLD or legacy),
this leaves rx->link_id at -1. status->link_id is an unsigned 4-bit field,
so the first released frame always takes the mismatch branch.

In-tree, only iwlwifi mvm calls ieee80211_mark_rx_ba_filtered_frames().
MLO-capable mvm hardware sets SUPPORTS_REORDERING_BUFFER, so
___ieee80211_start_rx_ba_session() never assigns tid_rx and the function
returns early.

The reorder timeout path could only hit link[-1] if an MLD vif held a
station with valid_links == 0. nl80211 doesn't appear to create such a
station.

The code change looks correct for all of these paths. It also fixes the
MLD peer case, where stats go to the previous frame's link.

Could the changelog describe the actual trigger and its driver dependence,
instead of "a remotely triggered crash on MLO APs serving legacy clients"?
As written, it may mislead severity triage and stable backport decisions.

> Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), net/mac80211/rx.c:4243-4255 (adjust block), rx.c:4375-4404 (ieee80211_rx_data_set_sta), rx.c:4410-4426 (ieee80211_release_reorder_timeout).
> Introduced in the v7.4 merge window (regression vs v7.3).
>
> This was found during an assisted (AI-supported) static source review of
> mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the
> reporter against that tree. The patch below has NOT been compiled and has
> NOT been runtime tested, and no reproducer was produced - the triggering
> conditions are described above instead. Please treat this as a report for
> verification rather than a battle-tested fix.

[Severity: Low]
This isn't a bug, but the changelog reads like a cover email rather than
a commit message. It opens with "Hello,", refers to "The one-word fix
below" and "every code path cited below", and includes tree-specific rx.c
line ranges that will go stale once the patch is applied.

Could the greeting, the rx.c line references and the review and testing
notes move below the --- separator? The note that the patch is untested
is still needed, but it doesn't belong in the permanent changelog.

> Fixes: [fill in before sending - on a full clone run:
>   git log -S 'rcu_dereference(rx->sta->link[rx->link_id])' --oneline -- net/mac80211/rx.c]

[Severity: Low]
The Fixes: tag is still a placeholder. git blame on the adjust block in
ieee80211_rx_handlers(), including the rx->sta->link[rx->link_id] line,
points to:

Fixes: 4db13371e217 ("wifi: mac80211: refactor RX link_id and station handling")

That commit also removed status->link_valid, started deriving
status->link_id from rx->link_id in ieee80211_prepare_and_rx_handle() and
ieee80211_invoke_fast_rx(), and left callers such as
ieee80211_mark_rx_ba_filtered_frames() passing link_id = -1.

> Reported-by: [your name and email]

[Severity: Low]
The trailers have no Signed-off-by:, and the Reported-by: is a
placeholder. Documentation/process/coding-assistants.rst says that when
an AI assistant was used, the human submitter must add their own
Signed-off-by to certify the DCO. submitting-patches.rst also requires
one.

Could a Signed-off-by be added, and the placeholder Reported-by: either
filled in or dropped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/Sq80dyNRnQWE5H_yZYIwxaQiwgvIrIlET6kND66_K0UpnKQZruHroWDq6hlYKDM0y9e2vXW2UBlBmnjw3bCLKk1Acrp7F49_jk883tbCqxk%3D%40proton.me
