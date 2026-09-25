Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210913BBFC5
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355558; cv=none; b=Qn1Z/5EK7lvfOR5fWsyk0/Z2ZdPKu2JzktU7DwnXMn8ZZftygHDfVlQyFgdNrvyOrEyF02jY4a7IzbVyVmlvJPWk2cqpgGlXX+SW/ajljh1qinVeRzjS/GANY5fF5Bb23Iv5dr/4xcX8PnP209nv7uKMax8Q987/K4y1SCjf2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355558; c=relaxed/simple;
	bh=rwD3o4PuLQTETUsvCDZiu4RG+PcxnR90h6EPRAYkdrk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d9dRGWM++MREHJf23bx0njjTme+RscYSsmEHDBw1izXsWPuD//hkaxlKibZ8K5LOpmOfkdkIcVpdDbPLolstuKwoMQXPjuzA0k6kWqDQNIvlRI4NZL0oIqVoKy+odfNCHmg9jeb24wFFztjTtNpwNK4FUUcpfagPttMLNnjs0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LktR472D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LktR472D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6BD1F000FF;
	Fri, 25 Sep 2026 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790355548;
	bh=24KeRkXrpcWsZ8nHfhWelq++yMSd0As73nQWuG7Krjo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LktR472DP8huK3uhpzjD4aa7CZhhF+v3HaBc9VjGGjXYdhZnmfGoA1hIrCRMiOg72
	 eFq2yI+HTyTYQHo0g9eB0td+fV1rU7IO07cIJy6ZsVLlhqk4Phs8kM5FeTDZ9S8xeK
	 BIWXrqjknbnHuj84EA5v4t1HFO8MM41SOdj6iCOBuEpMzMf1fKt3rdNl3q7B5GjGR9
	 KG/ogtQQQLr1jL8aNyYKifjZovQ9a+Hzo56N9YFK3b3DWnbaAdiw2vEbnuOvzMmcV/
	 Nnoh2rpH1WFD7RWXPwHZZ2X1uYFaYecHAYebAsQFcSaqisLYjJcdlPQShPVSXMnuKp
	 /QXHQPJtxoFwg==
Subject: Re: [PATCH net v2] tipc: reject attaching bearer of different media
 to the same occupied device
From: netdev-bot+sashiko@kernel.org
To: tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, xujiakai24@mails.ucas.ac.cn
Date: Fri, 25 Sep 2026 16:59:07 +0000
Message-ID: <179035554728.2160803.250100372225015350@kernel.org>
In-Reply-To: <20260924162016.1258485-1-tung.quang.nguyen@est.tech>
References: <20260924162016.1258485-1-tung.quang.nguyen@est.tech>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: two bearers can still be attached to one
  net_device, so the dev_refcnt leak the commit claims to fix can still…
- [Low] The new check in tipc_enable_bearer() (net/tipc/bearer.c:300-301)
  detects UDP in two different ways.

--

tipc: reject attaching bearer of different media to the same occupied device

This commit adds a check to tipc_enable_bearer(). The check rejects a new
eth or ib bearer when an existing bearer of a different media type uses
the same interface name. The goal is to stop a dev_refcnt leak where a
second bearer takes another dev_hold() in tipc_enable_l2_media() and
replaces the first one. UDP bearers are exempt from the check.

Closes: http://lore.kernel.org/netdev/20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn/

> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 05dcd2f9e887a..2c0ceee4aa6b9 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c

[ ... ]

> @@ -296,6 +297,21 @@ static int tipc_enable_bearer(struct net *net, const char *name,
>  			goto rejected;
>  		}
>  
> +		if (b->media->type_id == TIPC_MEDIA_TYPE_UDP ||
> +		    !strcmp(b_names.media_name, "udp"))
> +			goto priority;

[Severity: Low]
This isn't a bug, but the new bearer's media is already known at this
point, because earlier in tipc_enable_bearer() it was looked up with:

	m = tipc_media_find(b_names.media_name);

Could this use m->type_id == TIPC_MEDIA_TYPE_UDP instead of comparing
against the "udp" string? That would match the check on the existing
bearer and the other UDP checks in bearer.c.

For the same reason, the media difference test below could be written as
b->media != m.

> +
> +		/* Not allow eth and ib to attach to the same device */
> +		if_name = strchr((const char *)b->name, ':') + 1;
> +		if (!strcmp(if_name, b_names.if_name) &&
> +		    strcmp(b->media->name, b_names.media_name)) {

[Severity: High]
Does this string comparison catch every case where two bearers end up on
the same net_device?

tipc_enable_l2_media() finds the device with dev_get_by_name(). That
lookup also matches altnames, because netdev_name_node_alt_create() adds
them to the same per-netns name hash. Consider this sequence:

  enable bearer "eth:dummy0"
  ip link property add dev dummy0 altname foo
  enable bearer "ib:foo"   (or "eth:foo")

The if_name strings differ, so this check passes. The earlier "already
enabled" check on the full name passes too. This check never looks at the
same-media case ("eth:dummy0" plus "eth:foo"), and that case needs only
the eth media.

The second attach then takes another device reference and overwrites
dev->tipc_ptr without checking it:

net/tipc/bearer.c:tipc_enable_l2_media() {
    ...
	dev = dev_get_by_name(net, dev_name);
    ...
	rcu_assign_pointer(dev->tipc_ptr, b);
	return 0;
}

On NETDEV_UNREGISTER, tipc_l2_device_event() disables only the bearer
found in dev->tipc_ptr. tipc_disable_l2_media() then clears it:

	RCU_INIT_POINTER(dev->tipc_ptr, NULL);

As a result, the NETDEV_UNREGISTER that netdev_wait_allrefs_any()
rebroadcasts gets NOTIFY_DONE. The other bearer's device reference is
never dropped.

Would ip link del dummy0 then loop forever in netdev_wait_allrefs_any()?
Disabling the second bearer first gives the same result, because the
first bearer is then invisible to the notifier.

An altname can also be added after the first bearer already exists. Any
name-based check at enable time would miss that case.

TIPC_NL_BEARER_ENABLE is GENL_UNS_ADMIN_PERM, and adding an altname needs
only CAP_NET_ADMIN in the netns's user namespace. That makes this look
reachable from an unprivileged user namespace.

Would it be more robust to replace this string check with an occupancy
check in tipc_enable_l2_media(), right after dev_get_by_name()? For
example, when rtnl_dereference(dev->tipc_ptr) is non-NULL, call dev_put()
and return -EBUSY. UDP bearers never set dev->tipc_ptr, so the udp
special case above would no longer be needed either.

> +			errstr = "same device for different media";
> +			NL_SET_ERR_MSG(extack,
> +				       "Same device for different media");
> +			goto rejected;
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924162016.1258485-1-tung.quang.nguyen%40est.tech
