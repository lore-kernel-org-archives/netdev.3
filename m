Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705073;
	b=bFt+45xIA78CbFcCAsC91aQoOHTyJQXVJHa0tnSMGSOiK1HyTfergVzfIGp70BXq3g21
	 3SvPJPUll5Ssi/6RkuGGZOPXQIM6u9+D1RYFOmk4BVnglZu/6ZIZ+g34xrfEYFI0FmchI
	 XQMZzwCX/6MBShadNcpby5fR0dfBLoty6QFsgJGNcH1MWxDmrmWZfMYU+h5DMMcOP+JRb
	 gDXdi8od4OG+w1WA9ObyrHJ4vCn1OnBB3RyBJgWMf9iFSiZSnwN60gzdNtgf6Nfgaeniv
	 DHeMrN1fLwEVzwHP1HiFWYOBXo1nYF8OjiushCq8BbekeiUSdWK9ACHozhLgeLygJqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705073;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ebdtLrFU9WDszsLx3PS5gRNZJLuwUU1Xqqj6PvA7Tus=;
	b=GMU/ebQvTJs+twxNUvj6kSifMKLFlCfda1OR3U4RnlKACONw09BAJupqn5yIYkVZsy7c
	 U4cc4vbH+90FCs9kBa8dmVUWQ47X5AvEpeBXU97KvMFMlE8X1aoAnn4lQVn92zAknSQos
	 hqvFC1MKn0Kw5B/APSi5bN1KiMNoL7olurhxBSR6mNOFbRmFjlzXAjU+rjbgP976xzvvw
	 kJTvGKU5lOerE6DZ8GL46GcqFrUMPY0jnI933/5uiSGJ9Z/Gvr30WSNE83XogjtmkjK6O
	 20wJ32YnC2SD9m4AGa9j2ARz/mtQ8XiLtcZ8Fv020F5Rgry3v8Ucb/EFXS04TkJIPvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mv+R2sR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891A606A31A;
	Thu, 22 Oct 2026 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mv+R2sR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D275C1F01825;
	Thu, 22 Oct 2026 21:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705072;
	bh=ebdtLrFU9WDszsLx3PS5gRNZJLuwUU1Xqqj6PvA7Tus=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mv+R2sR0wIr36wlhtOJR8wn7uB71LdWx9j/7QCbnem+mE/wenz7H57CQEZiivl2SZ
	 9r9fcvYtSOTvB/SCgMzdiSWW5JEA199zaAjp+0qjBveulRFoy8++6GKEk3ZayVPu3u
	 raiVu4/PnyOUOSPnP9qd9M8isJzfQsMGEjXsKgfPbvrwBdDRZi43SPwUxrTwCeFk0n
	 ljGNBNjvCkJORvl/2roDkTD0B0VCZT0oHZwJyEjuUNUNtOAH1jk5BqTBK+tsCAlSUW
	 eM04vyYDU/TbPgz7h7IyHRwluQqh4+OH0pcYeXAQcMnGWQNjuFLr1o0hRSzs1ZvJCh
	 MSBK+g1bX4qfA==
Subject: Re: [PATCH v2] ice: Lock TC flower filter list operations
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 21:37:51 +0000
Message-ID: <179270507139.1189532.11460797871093048971@kernel.org>
In-Reply-To: <20261020033457.523151-1-18983559317@163.com>
References: <20261020033457.523151-1-18983559317@163.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In ice_rem_all_chnl_fltrs()
  (drivers/net/ethernet/intel/ice/ice_main.c), the patch adds…
- [Low] The commit message says 'ice_replay_tc_fltrs() replays the same
  list after reset' and lists 'stale filter state after replay' and…

--

ice: Lock TC flower filter list operations

This patch adds a per-PF mutex, tc_flower_fltr_lock, to serialize access
to pf->tc_flower_fltr_list. The lock is taken in the TC flower add and
delete paths and in ice_replay_tc_fltrs(), and a mutex_lock() is added to
ice_rem_all_chnl_fltrs().

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..90031ba17b06 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -8882,6 +8884,7 @@ static void ice_rem_all_chnl_fltrs(struct ice_pf *pf)
>  		hlist_del(&fltr->tc_flower_node);
>  		kfree(fltr);
>  	}
> +	mutex_lock(&pf->tc_flower_fltr_lock);
>  }

[Severity: High]
Was this meant to be a mutex_unlock(), with a matching mutex_lock() before
the hlist_for_each_entry_safe() loop?

As written, none of this work holds tc_flower_fltr_lock:

  - the list walk
  - the ice_rem_adv_rule_by_id() calls
  - the num_chnl_fltr and num_dmac_chnl_fltrs decrements
  - the hlist_del() and kfree(fltr)

The function then returns with the mutex held, and nothing releases it.

Can the race described in the commit message still happen?
ice_del_cls_flower() can take the mutex, find fltr and send the firmware
delete. Meanwhile the service task can run this on the same node without
the lock:

ice_prepare_for_reset()
  ice_remove_q_channels(vsi, true)
    ice_rem_all_chnl_fltrs()
      hlist_del(&fltr->tc_flower_node);
      kfree(fltr);

ice_del_cls_flower() would then call hlist_del() and kfree() on memory
that is already freed. Both paths could also decrement the filter counters
for the same rule.

The ice_is_reset_in_progress() check in ice_add_cls_flower() still runs
before the lock is taken.

Also, once any call to ice_rem_all_chnl_fltrs() returns (even with an
empty list), won't every later ice_add_cls_flower() and
ice_del_cls_flower() block forever in
mutex_lock(&pf->tc_flower_fltr_lock)? The next ice_rem_all_chnl_fltrs()
call would block as well.

This looks reachable from ice_prepare_for_reset() in the service task, on
a non-PF reset with ICE_FLAG_TC_MQPRIO set. It is also reachable from
ice_setup_tc_mqprio_qdisc() on mqprio channel teardown, which returns to
user space with the lock held:

	if (!hw && !test_bit(ICE_FLAG_TC_MQPRIO, pf->flags))
		ice_remove_q_channels(vsi, true);

The channel-setup cleanup path that calls ice_remove_q_channels() is
affected the same way. ice_deinit_pf() would then call mutex_destroy() on
a mutex that is still locked, which CONFIG_DEBUG_MUTEXES warns about.

Changing only this trailing mutex_lock() to mutex_unlock() would not close
the race. The lock needs to cover the whole loop.

> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index d20357c04127..955ad3cc5417 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c

[ ... ]

> @@ -2340,10 +2356,12 @@ void ice_replay_tc_fltrs(struct ice_pf *pf)
>  	struct ice_tc_flower_fltr *fltr;
>  	struct hlist_node *node;
>  
> +	mutex_lock(&pf->tc_flower_fltr_lock);
>  	hlist_for_each_entry_safe(fltr, node,
>  				  &pf->tc_flower_fltr_list,
>  				  tc_flower_node) {
>  		fltr->extack = NULL;
>  		ice_add_switch_fltr(fltr->src_vsi, fltr);
>  	}
> +	mutex_unlock(&pf->tc_flower_fltr_lock);
>  }

[Severity: Low]
Does anything call ice_replay_tc_fltrs()? The commit message says:

  and ice_replay_tc_fltrs() replays the same list after reset.

It also lists these as consequences:

  stale filter state after replay

  or reset/replay can traverse a list concurrently modified by flower
  control operations.

A search of drivers/net/ethernet/intel/ only finds the kernel-doc and
definition in ice_tc_lib.c, plus the prototype in ice_tc_lib.h. The reset
and rebuild paths don't appear to call it, so the locking added here has
no runtime effect.

Could the commit message describe only the paths that actually walk the
list: ice_add_cls_flower(), ice_del_cls_flower() and
ice_rem_all_chnl_fltrs()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020033457.523151-1-18983559317%40163.com
