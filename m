Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30946A5E4;
	Thu, 24 Sep 2026 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290915; cv=none; b=ImY/OvMZLIhSf4z7aawfiz6sy0u3WmuWDoXAPZhFfh70qa/WVCkQB80ZU/pbhrqwScakJhWl+VwJvzOiPJJM5Cqddj9RWgCJyAmYZ98+sbE0JT6asvaNHKo7f/o3wO5lKRpK3U9zxevfA55RxjmntM8qEP2a+heWMf2H5YOA50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290915; c=relaxed/simple;
	bh=rz7PRKlm+zEsHL+hJ2dCUKcH+Wfym0M2Rzul0+n9OYk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpgewt49BotH7Ogk5pi8TFQYG7NebcFdK5rA1mPc0f2W3WpYFaT7RcdQ3/jIzBLIDnwBWdR3XIwmamz6A474GcUfs4ptPtoBOt/4kYUuMv0sCkKMOPaYufcOskHNShtNgfZKKunAGKLMVqJ/VVebMqeLXUZipBGmoNAhvHgs03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvg0qZPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvg0qZPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30F81F000FF;
	Thu, 24 Sep 2026 23:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290913;
	bh=wFDBfpFYmD9S0ya0uykpPXPLjLYvqkt2LTRKxE3x3uY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kvg0qZPfWH2Zx2ScK5C4X3feF4pMrsY8+qrLEXr+GD8FUKAIsSLRhOXHkpf//nvT5
	 MZNN+46vXzb+SHmQ2hxJY2YUfeHCNQjT7fJ7Fc1SPij/FFNhgMYBNQGwG//u5Xi4kn
	 qwyr3mrt5Vpr/1iTYDDzMSeGBWfo1sWPYYGE/uj3s/IHyLWwSgYI2hvIEqLOz28Ea9
	 7eqlQXj+FP1zzSp7sWipeqRMnacg7IGBkiLFACdMbkb4JZnqbGN5dnPvbLYNdb3uUz
	 J9CAMqRpfrCKZF4WNB9JicviJXEPLnlmelCYY5/kvVsbZtirq2GCTWbCmK+yWyCLpI
	 BmJZbHNCtp3Lg==
Subject: Re: [PATCH net-next 4/6] enic: validate V2 VF configuration replies
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Thu, 24 Sep 2026 23:01:52 +0000
Message-ID: <179029091223.2160803.5733876502057073704@kernel.org>
In-Reply-To:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-4-67a0a6e08d43@cisco.com>
References:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-4-67a0a6e08d43@cisco.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 4 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] enic_mbox_vf_handle_add_del_mac_reply()
  (drivers/net/ethernet/cisco/enic/enic_mbox.c:725-726) unconditionally…
- [Medium] enic_mbox_vf_handle_reply() now ends with `if (recovery !=
  ENIC_MBOX_VF_REPLY_OK) enic_mbox_vf_kick_recovery(enic);`, which fires…
- [Low] ENIC_MBOX_PF_SET_ADMIN_MAC_NOTIF (12) / _ACK (13) are added to
  the message enum and the notification type is listed in…
- [Low] The three new externally visible VF entry points
  (enic_mbox_vf_add_del_macs(), enic_mbox_vf_add_del_mac(),…
- [Low] enic_mbox_vf_malformed_msg() turns any single mis-framed admin-
  channel message attributed to the PF into a full protocol fault…
- [Low] enic_mbox_vf_reply_claim()
  (drivers/net/ethernet/cisco/enic/enic_mbox.c:381) returns with…

Pre-existing issues:
- [Low] The VF now emits ENIC_MBOX_VF_ADD_DEL_MAC_REQUEST (10) and
  ENIC_MBOX_VF_SET_PKT_FILTER_REQUEST (14), but…

--

enic: validate V2 VF configuration replies

This adds the V2 mailbox operations for MAC filters, administrative-MAC
notifications and packet-filter settings on the VF side, and keeps the
request buffer alive so per-entry reply results can be validated. On a
malformed or contradictory reply, or when the PF reports the VF is no longer
registered, the VF forces a new registration before accepting traffic again.

A few questions about the new recovery escalation and the lock handoff
between the claim and completion helpers.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index 2d77d41577a3a..3f73072170b91 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c

[ ... ]

> @@ -376,6 +377,82 @@ static void enic_mbox_vf_request_finish(struct enic *enic)
>  	mutex_unlock(&enic->vf_mbox_request_lock);
>  }
>  
> +/* Return with mbox_state_lock held when this handler owns the reply. */
> +static bool enic_mbox_vf_reply_claim(struct enic *enic, u8 reply_type,
> +				     u64 msg_num, u8 *expected)
> +{
> +	spin_lock_bh(&enic->mbox_state_lock);
> +	*expected = enic->mbox_expected_reply;
> +	if (*expected == reply_type &&
> +	    enic->mbox_expected_msg_num == msg_num)
> +		return true;
> +	spin_unlock_bh(&enic->mbox_state_lock);
> +
> +	return false;
> +}
> +
> +enum enic_mbox_vf_reply_recovery {
> +	ENIC_MBOX_VF_REPLY_OK,
> +	ENIC_MBOX_VF_REPLY_RECONNECT,
> +	ENIC_MBOX_VF_REPLY_REGISTRATION_LOST,
> +};
> +
> +static int
> +enic_mbox_vf_classify_reply(bool malformed, u16 ret_major,
> +			    enum enic_mbox_vf_reply_recovery *recovery)
> +{
> +	*recovery = ENIC_MBOX_VF_REPLY_OK;
> +	if (malformed) {
> +		*recovery = ENIC_MBOX_VF_REPLY_RECONNECT;
> +		return -EIO;
> +	}
> +	/* Some deployed peers return a negative errno in this 16-bit field.
> +	 * Interpret protocol bits only when no unknown bits are present; otherwise
> +	 * an errno such as -EINVAL could accidentally look like registration loss.
> +	 */
> +	if (!(ret_major & ~ENIC_MBOX_ERR_MASK) &&
> +	    (ret_major & ENIC_MBOX_ERR_VF_NOT_REGISTERED)) {
> +		*recovery = ENIC_MBOX_VF_REPLY_REGISTRATION_LOST;
> +		return -ENODEV;
> +	}
> +	if (!(ret_major & ~ENIC_MBOX_ERR_MASK) &&
> +	    (ret_major & ENIC_MBOX_ERR_MSG_NOT_SUPPORTED))
> +		return -EOPNOTSUPP;
> +	if (ret_major)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static void
> +enic_mbox_vf_recover_reply_locked(struct enic *enic,
> +				  enum enic_mbox_vf_reply_recovery recovery)
> +{
> +	bool registration_lost;
> +
> +	lockdep_assert_held(&enic->mbox_state_lock);
> +
> +	if (recovery != ENIC_MBOX_VF_REPLY_OK) {
> +		registration_lost =
> +			recovery == ENIC_MBOX_VF_REPLY_REGISTRATION_LOST;
> +		enic_mbox_vf_mark_reconnect_locked(enic, registration_lost);
> +	}
> +}
> +
> +static void enic_mbox_vf_reply_complete(struct enic *enic)
> +{
> +	lockdep_assert_held(&enic->mbox_state_lock);
> +	enic->mbox_expected_reply = 0;
> +	enic->mbox_expected_msg_num = 0;
> +	/* Publish completion before releasing the state lock.  A waiter that
> +	 * hit the timeout boundary may otherwise see the claimed state, finish the
> +	 * request, and let a new request reinitialize this completion before the
> +	 * old handler signals it.
> +	 */
> +	complete(&enic->mbox_comp);
> +	spin_unlock_bh(&enic->mbox_state_lock);
> +}

[Severity: Low]
Should this conditional acquire be annotated?  enic_mbox_vf_reply_claim()
returns with enic->mbox_state_lock held on the true path and unlocked on
the false path, and the matching release happens in a different function,
enic_mbox_vf_reply_complete().

Neither helper carries __cond_acquires()/__acquires()/__releases(), and
spin_lock_bh() is annotated __acquires(lock) in this tree, so sparse and
clang context analysis cannot pair the acquire with the release for the
claim helper or for its callers (enic_mbox_vf_handle_reply,
enic_mbox_vf_handle_add_del_mac_reply,
enic_mbox_vf_handle_set_pkt_filter_reply, enic_mbox_vf_malformed_msg).

I traced all four callers and every true-branch path does reach
enic_mbox_vf_reply_complete(), so this is balanced at runtime today.  Would
__cond_acquires(true, &enic->mbox_state_lock) on the claim helper and
__releases(&enic->mbox_state_lock) on the completion helper be preferable,
or could the lock be taken and dropped inside a single function?  The
longest region between claim and complete walks up to
ENIC_MBOX_MAX_MAC_OPS (130) entries under spin_lock_bh, so any future early
return added there would leak the lock with BHs disabled.

> @@ -551,23 +628,21 @@ static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
>  				      void *payload, u64 msg_num)
>  {
>  	struct enic_mbox_generic_reply *reply = payload;
> +	enum enic_mbox_vf_reply_recovery recovery;
>  	u16 ret_major = le16_to_cpu(reply->ret_major);
> -	u64 expected_msg_num;
> -	u8 expected_type;
> +	u8 expected;
> +	int status;
>  
> +	status = enic_mbox_vf_classify_reply(false, ret_major, &recovery);
> +	if (!enic_mbox_vf_reply_claim(enic, reply_type, msg_num, &expected)) {

[ ... ]

> @@ -584,16 +659,168 @@ static void enic_mbox_vf_handle_reply(struct enic *enic, u8 reply_type,
>  			break;
>  		}
>  	}
> -	enic->mbox_expected_reply = 0;
> -	enic->mbox_expected_msg_num = 0;
> -	complete(&enic->mbox_comp);
> -	spin_unlock_bh(&enic->mbox_state_lock);
> +	enic_mbox_vf_recover_reply_locked(enic, recovery);
> +	WRITE_ONCE(enic->mbox_reply_status, status);
> +	enic_mbox_vf_reply_complete(enic);
>  
>  	if (ret_major)
>  		netdev_warn(enic->netdev,
>  			    "MBOX: PF rejected reply type %u: %u/%u\n",
>  			    reply_type, ret_major,
>  			    le16_to_cpu(reply->ret_minor));
> +	if (recovery != ENIC_MBOX_VF_REPLY_OK)
> +		enic_mbox_vf_kick_recovery(enic);
> +}

[Severity: Medium]
Can this new kick re-queue the reset work from inside the reset work?

The CAPABILITY and REGISTER requests are issued from
enic_admin_chan_reopen(), which runs in the enic_reset() work item, and
enic_reset() only returns early when !netif_running(), which stays true
across an internal reset.  If the reply carries
ENIC_MBOX_ERR_VF_NOT_REGISTERED, enic_mbox_vf_classify_reply() reports
ENIC_MBOX_VF_REPLY_REGISTRATION_LOST, so:

enic_reset()				/* holds rtnl_lock */
  enic_admin_chan_reopen()
    enic_mbox_vf_capability_check()
      enic_mbox_vf_handle_reply()
        enic_mbox_vf_kick_recovery()
          schedule_work(&enic->reset);	/* re-queues the running work */

The work bit is cleared before the callback runs, so this re-queues rather
than being a no-op.  With a PF that keeps answering the handshake with
VF_NOT_REGISTERED, does the device then cycle reset -> soft reset -> reopen
-> handshake failure -> reset with no fault budget or back-off, where the
baseline simply left the device down?  Each iteration also holds rtnl_lock
across up to two 3000 ms mailbox waits.

This one depends on peer behaviour I could not confirm against real PF
firmware, so it may not be reachable in practice, but there is no
structural termination for the loop in the code.

> +
> +static bool enic_mbox_vf_mac_reply_matches(const struct enic_mac_addr *request,
> +					   const struct enic_mac_addr *reply)
> +{

[ ... ]

> +static void enic_mbox_vf_handle_add_del_mac_reply(struct enic *enic,
> +						  void *payload, u16 msg_len,
> +						  u64 msg_num)
> +{
> +	struct enic_mbox_vf_add_del_mac_reply_msg *reply = payload;
> +	enum enic_mbox_vf_reply_recovery recovery;

[ ... ]

> +	if (msg_len < sizeof(*reply)) {
> +		status = enic_mbox_vf_classify_reply(true, 0, &recovery);
> +	} else {
> +		ret_major = le16_to_cpu(reply->reply.ret_major);
> +		ret_minor = le16_to_cpu(reply->reply.ret_minor);
> +		status = enic_mbox_vf_classify_reply(false, ret_major,
> +						     &recovery);
> +		if (status == -EIO)
> +			recovery = ENIC_MBOX_VF_REPLY_RECONNECT;
> +	}

[Severity: Medium]
Does this override also escalate an ordinary policy rejection?

For a well-formed reply whose ret_major carries only
ENIC_MBOX_ERR_GENERIC, enic_mbox_vf_classify_reply() takes its last arm:

	if (ret_major)
		return -EIO;

leaving *recovery == ENIC_MBOX_VF_REPLY_OK.  The unconditional
"if (status == -EIO)" above then rewrites that to
ENIC_MBOX_VF_REPLY_RECONNECT, so enic_mbox_vf_recover_reply_locked() ->
enic_mbox_vf_mark_reconnect_locked() sets mbox_send_disabled and
vf_rx_quarantined, bumps vf_mbox_fault_generation, and
enic_mbox_vf_kick_recovery() schedules enic->reset.

That appears to contradict the comment further down in this same function:

	/* After a malformed reply, the VF cannot trust that its state matches the
	 * PF. VF_NOT_REGISTERED means the PF removed all VF state. Both require a
	 * new registration; an ordinary policy rejection does not.
	 */

and the commit message, which says "Return stable policy errors to callers
while retaining retry semantics for operations that made no state change."

The sibling handler added by this same patch escalates only for ret_major
bits outside the protocol mask:

		if (status && (ret_major & ~ENIC_MBOX_ERR_MASK))
			recovery = ENIC_MBOX_VF_REPLY_RECONNECT;

Should the MAC handler use the same narrower rule?  Later in the series the
station-address install (enic_vf_station_addr_replace()) re-issues this
request on every open/reopen, so a PF that stably answers ERR_GENERIC would
keep re-arming the soft reset under rtnl_lock with RX quarantined.

[ ... ]

> +static void enic_mbox_vf_handle_set_pkt_filter_reply(struct enic *enic,
> +						     void *payload, u16 msg_len,
> +						     u64 msg_num)
> +{

[ ... ]

> +	if (msg_len < sizeof(*reply)) {
> +		status = enic_mbox_vf_classify_reply(true, 0, &recovery);
> +	} else {
> +		ret_major = le16_to_cpu(reply->reply.ret_major);
> +		status = enic_mbox_vf_classify_reply(false, ret_major,
> +						     &recovery);
> +		if (status && (ret_major & ~ENIC_MBOX_ERR_MASK))
> +			recovery = ENIC_MBOX_VF_REPLY_RECONNECT;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43%40cisco.com
