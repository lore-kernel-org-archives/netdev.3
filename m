Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1544078EB;
	Thu, 24 Sep 2026 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290912; cv=none; b=NiSJf61e8kPO6MBzSWKkzMncplsPRekRvh6s1JWi1sqGCrOdNlbZfpR1Q+F4gaq26TRNRZS74US3uivJfpmCw9KyJsFV9g77YT0LtoKjPlqEjnvIUFLm1SQjIAGB92PwhcNbghcfOwOH+Uhuvnhr8dE30+Guhsszi94Q/WPUd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290912; c=relaxed/simple;
	bh=RDwdM3kzCbwyI5a0OwNZnmboWllfBh8S/o8SxzHXXEo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGeU7Lfd8IrWW4qFhCYWYstHCw9mT/D4IYINC3Pb5i+4AqOpljrsfNqlvLUonNoyvv6ayE9YNKUVwRHzfizwNHr8HLyirvqWB+oI6VGZQKgIHCs80U388yZkREq/aR/v6rrAW3WR0iSOvurxq6uvo9TxysX1iueGoRM96r626I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+JF6yLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+JF6yLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEC71F00893;
	Thu, 24 Sep 2026 23:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290910;
	bh=I65he5ful/Kx63cSu1Nt3LIrmFw5zO0NelklTUvzf14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O+JF6yLm+1BYRDet6aHbCQ5+U+zW1dX2Uju7FmntCffWV8fGow/npVbGOSObOalLK
	 ct+DSgaKDWAJ4rFr9GKDfotgDExcUKD0xRlgu0C2rAmqfCaKi83TMF+/D/1vN9LN4w
	 s0+F4ghq3LlwHcA2g1sO8iibU2KGuX4har1SfAOB60xyWE592iDlBmPX1PRwIg+MMJ
	 GhptAfKnRCya8/dAwd1cXgEYpcpGGJuk1NvumSadwbvdWoeQLWo3mVWQuutN0QBCWu
	 hpoCznVsZqVekJYAJQGFMf9OJePwVPh4CKd6NTBulxUaV64H50ph/YD8KF2lBZZRNN
	 dSQ9l7HxhZZpg==
Subject: Re: [PATCH net-next 2/6] enic: serialize V2 VF mailbox requests
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Thu, 24 Sep 2026 23:01:49 +0000
Message-ID: <179029090986.2160803.4845062802664097619@kernel.org>
In-Reply-To:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-2-67a0a6e08d43@cisco.com>
References:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-2-67a0a6e08d43@cisco.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch repairs merged code — the VF single-outstanding-reply
  mailbox state (`enic->mbox_expected_reply`,…

--

enic: serialize V2 VF mailbox requests

This adds a VF-only mutex (vf_mbox_request_lock) that is held across the
lifetime of a V2 VF mailbox request, from arming the expected reply until
the reply or the timeout has been consumed. The three VF request helpers
enic_mbox_vf_capability_check(), enic_mbox_vf_register() and
enic_mbox_vf_unregister() are converted to the new start/abort/finish
helpers.

One question below about the changelog.

>     enic: serialize V2 VF mailbox requests
>
>     The VF stores one expected reply and uses one completion for mailbox
>     requests. If two VF control paths issue requests at the same time, the
>     second request can replace the reply state for the first.

[Severity: Low]
Should this carry a Fixes: tag, and is the described trigger reachable at
this point in the series?

The state being protected (enic->mbox_expected_reply,
enic->mbox_expected_msg_num, enic->mbox_comp) and all three request
helpers already exist in the baseline tree; they came in with commit
72b65c94058e ("enic: add MBOX VF handlers for capability, register and
link state"), whose changelog relies on a single-outstanding-reply
invariant that nothing in the code enforces. Since this changelog
describes a live defect ("the second request can replace the reply state
for the first"), a Fixes: tag pointing at that commit would let
backporters and stable tooling find the affected releases.

On reachability, the VF request issuers present at this commit look
mutually exclusive:

- enic_probe() runs single threaded, before register_netdev().

- enic_admin_chan_reopen() is called from enic_reset() and
  enic_tx_hang_reset(), both of which run under rtnl_lock and return
  early on !netif_running().

- enic_remove() disables and syncs the reset work items before it issues
  the unregister:

    disable_work_sync(&enic->reset);
    disable_work_sync(&enic->tx_hang_reset);
    disable_work_sync(&enic->change_mtu_work);
    ...
    if (enic_is_sriov_vf_v2(enic)) {
            if (READ_ONCE(enic->vf_registered)) {
                    int unreg_err = enic_mbox_vf_unregister(enic);

The additional request sites that could actually overlap (the delayed VF
admin MAC work and the mailbox receive-mode path) appear only in later
patches of this series.

Would it be more accurate to either name the commit being fixed with a
Fixes: tag, or state that this is preparatory serialization for the
request sites added later in the series?

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index 5c93ca49552ac..b8a18d9682b2f 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> @@ -218,6 +218,32 @@ static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
>  	return err;
>  }
>  
> +static void enic_mbox_vf_request_start(struct enic *enic)
> +{
> +	mutex_lock(&enic->vf_mbox_request_lock);
> +	reinit_completion(&enic->mbox_comp);
> +	spin_lock_bh(&enic->mbox_state_lock);
> +	enic->mbox_expected_msg_num = 0;
> +	enic->mbox_expected_reply = 0;
> +	spin_unlock_bh(&enic->mbox_state_lock);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43%40cisco.com
