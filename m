Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708459;
	b=ZcGky1oHOaYC6nKUOUb+8U/efgN/+Cff2F0KgQwZrPDQ3zlipW8sl/oMes8TXrJCoOG0
	 5pEu4XPcbM9/ZmfPf0pZpE6Fy8rWVGl6xFTqpM5rAzlLrknaVaTM+pw1b2yWnyT/7mQZw
	 I5zkWSuye5UwJs8n/zfsAeMNqLbbbeZjI21Yzad4LG2zHMqglspFXBaG/4JRNFMSMIYk0
	 nEZ5DzXr4xxWWUINTHoPCUFcDjeEKcm6Ip5ufu7La8ChcWkwBDC0Tt/fGoEXq+YODY+od
	 ih6spDSYVaQUuJ+DGlEOrWUw6IUSzCkUwp/IN4jgIFqDGsTjXlyTTVNOajQXhMgCdTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708459;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=v62cGI3jYUFtDjrh3US7O3jgv8Y5qCW8eixbpRtpTfE=;
	b=JuZEK6O202iGZ4b8pn/eQdOWtBTLvsJYwKLdTRYCa6IyY6gDBMo6z4Mp4MBapoKZJiOo
	 r3eT25RXc+ulHjwOrejeHWWaMr4S7IBHeSGFe6rvDhj4kBUDQUdDVYkkLrfvIzcsBuu1U
	 9176T9OBPuJd4iypz6W8i4wr3u0tvN5Up0uRcoE3cPi6ozXYgF/oS3wbYpm+Lo0ZsYV1A
	 LDHuPOUgwr4Ye1kIfAPxPLzpeDpe3s+SxrNkFI0J3jeuoYtjN5jYDBb2aXnBdQYU85H0e
	 +IUwL47j0d+vct4akfr8Fcxw4P/zJBSp4ddzC2QKreCvossdm7pF2Xj9BqI0leeVDxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNp+0Nne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955BB606A31A;
	Thu, 22 Oct 2026 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNp+0Nne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898191F01825;
	Thu, 22 Oct 2026 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792708459;
	bh=v62cGI3jYUFtDjrh3US7O3jgv8Y5qCW8eixbpRtpTfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNp+0NneIUOnpM+U6b+I78kKFEaqLPWC2dC5BvPX+b58bimcG1UTVviUMkO1bBLDv
	 B+uoJd8foBJDgpGHyLy6KNgNYdCTZQZ/vcNJGgXZ5F+JRsam0Xnh4lBKAp3fMZ1KyE
	 KGLk87Kf/410zMl+Od8zRS0egLg1+gkNf+rGqQ6TDFMub1XBA0Gx8Ubje+72GFcxF6
	 shIAq84feEoxkOSr0gEaMRGNAeG91qVTCZ7lbQAZFLHmrfwWIk+Qq7VGBu9kDtagVa
	 tIoR6Vr/3Bpz23GT1WBMUKZeczYuQOQcjAaBoS+pCbSv2cqw+SUIGcE9BkSsPdJEH7
	 H/M2IvA83EtIw==
Subject: Re: [PATCH v1] ice: Lock TC flower filter list operations
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 22:34:18 +0000
Message-ID: <179270845801.1189532.16470999684480194016@kernel.org>
In-Reply-To: <20261020033248.522973-1-18983559317@163.com>
References: <20261020033248.522973-1-18983559317@163.com>
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

- [High] The patch puts the new lock in the wrong place in
  ice_rem_all_chnl_fltrs() (drivers/net/ethernet/intel/ice/ice_main.c).
- [Low] The commit message describes ice_replay_tc_fltrs() as an active
  reader that "replays the same list after reset", and lists "stale…

--

ice: Lock TC flower filter list operations

This commit adds a per-PF mutex, tc_flower_fltr_lock, to serialize access
to pf->tc_flower_fltr_list. The mutex is taken in ice_add_cls_flower(),
ice_del_cls_flower() and ice_replay_tc_fltrs(). A lock call is also added
to ice_rem_all_chnl_fltrs() on the queue-channel teardown path.

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
Was this meant to be a mutex_lock() before the hlist_for_each_entry_safe()
loop, with a matching mutex_unlock() after it?

As written, the lock is taken only after the walk has finished, and nothing
releases it. So ice_rem_all_chnl_fltrs() always returns with
tc_flower_fltr_lock held, even when the list is empty.

ice_remove_q_channels(vsi, true) reaches this function from these paths:

  ice_prepare_for_reset()
    (non-PFR reset with ICE_FLAG_TC_MQPRIO set, in the service task)
  ice_setup_tc_mqprio_qdisc()
    (mqprio qdisc removal, under RTNL and tc_mutex)
  ice_rebuild_channels()
    (cleanup error path, with rem_adv_fltr)

After the first call, every later ice_add_cls_flower() and
ice_del_cls_flower() blocks forever in mutex_lock().

A second ice_rem_all_chnl_fltrs() call deadlocks on itself. One way to hit
this is to add an mqprio channel qdisc, delete it, add it again and delete
it again. The second delete then hangs while holding RTNL. If the second
call comes from ice_prepare_for_reset() instead, the reset never finishes.

ice_deinit_pf() would also end up calling mutex_destroy() on a mutex that
is still locked.

The race described in the commit message also looks like it is still
open. The walk, the ice_rem_adv_rule_by_id() calls, the num_chnl_fltr and
num_dmac_chnl_fltrs updates, hlist_del() and kfree() all still run without
the lock.

ice_del_cls_flower() can find a filter under the mutex while this loop
frees it:

  ice_del_cls_flower()
    fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
    ...
    fltr->extack = cls_flower->common.extack;
    err = ice_del_tc_fltr(vsi, fltr);

Could that write freed memory, or lead to a double hlist_del() and
kfree() of the same fltr?

The reverse also seems possible. The locked delete path can free the node
this unlocked safe iterator has already cached in node. A concurrent
hlist_add_head() in ice_add_cls_flower() can also corrupt the list during
the walk.

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
Does anything call ice_replay_tc_fltrs()?

The commit message says:

  "and ice_replay_tc_fltrs() replays the same list after reset."

and lists among the consequences:

  "stale filter state after replay"

The only references to ice_replay_tc_fltrs() in drivers/net/ethernet/intel/ice
are its definition and kernel-doc in ice_tc_lib.c and its prototype in
ice_tc_lib.h. Since nothing calls it, it does not run after reset and
cannot race with flower add or delete. The locking added here has no
effect.

Could the commit message be updated so it does not list
ice_replay_tc_fltrs() as a race participant or replay as a consequence?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020033248.522973-1-18983559317%40163.com
