Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AA405F7;
	Sun, 11 Oct 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731981; cv=none; b=WNPkOS9Ix3ODiL5JGkRChUOelb6nVCSTspWOVph9MANKBoICaVvy+TEEx3eqpWO4M6tfdiB7Lhm9wVJ22erEvsfMiCyenr02OwqUCpgzNaG414/oOKGozC/rVoCCJDEEDn0GYL57NgQwBkkBVG4jOkAZELWXsgBf/bKhNPYyXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731981; c=relaxed/simple;
	bh=LtCyh9nnBrjqkIbbIwLiupRPV+TFwFkyJ6gs9wxDGhU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHHohwGy3nqZXKaz34FL4XV3cZnu9Gm4i1+k3X0PQkUgiIu3zVJSS81tDa3DkECGdgKufj5ESdCGRo4NKPAu8fPvVII5yc8t/4N9YwLrq4i/g+OKlqH+Br3WgvKomhvIyno/SoJ37vsafQ6E0XzNvYk+crEYQwzgZPX7vKjRR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL4bhu1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL4bhu1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3081F0089B;
	Sun, 11 Oct 2026 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791731979;
	bh=mUCf4nSzDUXsV7PZq3Gz76x5gHcSeE+bODEKH+oBdV0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AL4bhu1LyToQDNaPaazv5jrGEIREIo2aa5pzBLdnLCPz1NP1mapNZ/IzhX9iYkBVw
	 MjrKMbTn65jjC6IqVQ1bi0rpFEgHeFXOWoiciouJ3cVF8XMWXSXlp+uajgixtRNRFh
	 3m4dHhHjRXIjcl+JUCRKNY2NkyywRddYkUiOi4g0mv5cqp3xJbUKFGq7WOAuqDo9yY
	 YmwigJbGiZQO8oWGfy6g5CEC8jDz3Q8AzYYeUTZk7mwhJZ+vKxdMGKUtugf7TjJ87O
	 3T7HyDXoEhh1fXPzXWy81oFpCJwUhdWBL6PuhNWhB6U+DVdHyqfpXT6v8YsErfUsde
	 tQT2Xo1ZLsZNw==
Subject: Re: [PATCH net] net: sparx5: free the matchall entry on destroy
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kees@kernel.org
Date: Sun, 11 Oct 2026 15:19:38 +0000
Message-ID: <179173197837.434549.9373931425008737442@kernel.org>
In-Reply-To:
 <20261007-sparx5-matchall-kfree-net-v1-1-c8918685b337@microchip.com>
References:
 <20261007-sparx5-matchall-kfree-net-v1-1-c8918685b337@microchip.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: `struct sparx5_mall_entry` still leaks on
  every error return in `sparx5_tc_matchall_replace()`.

Pre-existing issues:
- [High] `sparx5_tc_matchall_parse_mirror_action()` sets
  `entry->mirror.port = netdev_priv(action->dev)` without checking that…

--

net: sparx5: free the matchall entry on destroy

This patch adds a kfree() of the struct sparx5_mall_entry in
sparx5_tc_matchall_destroy(), after the entry is removed from
sparx5->mall_entries. Without it, every deleted mirror and goto matchall
filter leaked its entry.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
> index 702257979462d..146d7f28e8f3d 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_matchall.c
> @@ -160,6 +160,7 @@ static int sparx5_tc_matchall_destroy(struct net_device *ndev,
>  	}
>  
>  	list_del(&entry->list);
> +	kfree(entry);
>  
>  	return err;
>  }

[Severity: High]
Does sparx5_tc_matchall_replace() still leak mall_entry on its error
paths?

The entry is allocated before the action is checked or the hardware is
programmed. It is only added to the list at the very end:

sparx5_tc_matchall_replace() {
    ...
	mall_entry = kzalloc_obj(*mall_entry);
	if (!mall_entry)
		return -ENOMEM;
    ...
	list_add_tail(&mall_entry->list, &sparx5->mall_entries);

	return 0;
}

Each return between those two points loses the only pointer to the entry
without freeing it:

- the sparx5_mirror_add() failure in the FLOW_ACTION_MIRRED case, which
  returns err (-EEXIST, -EINVAL, -ENOENT)

- the four vcap_enable_lookups() failure returns in the FLOW_ACTION_GOTO
  case (-EFAULT, -EADDRINUSE, -EADDRNOTAVAIL, and other errors)

- the default case:

	default:
		NL_SET_ERR_MSG_MOD(tmo->common.extack, "Unsupported action");
		return -EOPNOTSUPP;

These entries never reach sparx5->mall_entries. That means
sparx5_tc_matchall_destroy() can never find them, and the new kfree()
does not cover them.

A failed offload is easy to repeat. Examples are a matchall filter with
an action like drop, which hits the default case, a second mirror on a
port that is already mirrored, or a goto to an unsupported chain.
Without skip_sw the software filter is still installed, so this can run
in a loop.

Since this is the same object the commit message says is leaked, could
the fix also free mall_entry on these paths? A shared error label in
sparx5_tc_matchall_replace() would work, or the action could be checked
before the allocation.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Is
the mirred target device checked before it is used as a sparx5 port?

sparx5_tc_matchall_parse_mirror_action() {
	entry->mirror.port = netdev_priv(action->dev);
}

Nothing checks that action->dev is a sparx5 port, or even that it is
non-NULL. The driver already has a helper that checks both:

sparx5_netdevice_check() {
	return dev && (dev->netdev_ops == &sparx5_port_netdev_ops);
}

The lan966x driver does a similar check in lan966x_mirror_port_add().

If the mirred target is a foreign netdev such as dummy, veth or a
bridge, sparx5_mirror_add() reads mport->portno from that driver's
private area. It then writes the value to hardware:

sparx5_mirror_add() {
    ...
	if (sport->portno == mport->portno)
		return -EINVAL;
    ...
	sparx5_mirror_monitor_set(sparx5, mirror_idx, mport->portno);
    ...
}

As a result, mirrored traffic could be sent to an arbitrary switch port.

action->dev can also be NULL. In net/sched/act_mirred.c,
tcf_offload_mirred_get_dev() leaves entry->dev NULL when the action has
no device:

tcf_offload_mirred_get_dev() {
	entry->dev = act->ops->get_dev(act, &entry->destructor);
	if (!entry->dev)
		return;
    ...
}

This happens with mirred blockid actions, where tcf_mirred_init() calls
tcf_mirred_replace_dev(m, NULL). It also happens when the target device
has been unregistered. In both cases entry->id is still set to
FLOW_ACTION_MIRRED.

netdev_priv(NULL) then returns a small non-NULL pointer, and the
mport->portno read in sparx5_mirror_add() would oops.

Would calling sparx5_netdevice_check() on action->dev before it is
used fix both cases?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007-sparx5-matchall-kfree-net-v1-1-c8918685b337%40microchip.com
