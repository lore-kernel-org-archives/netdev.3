Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD6846A
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501008; cv=none; b=DvBePYHVQbDuw8aNQAHMTyKyX9xhD2gEpMv1OtgcXdcovWQmpzuhilygg6Dqk69eoRJMqWBOpRq7dEzhkUS++EE7ZGNq21RgkTaoKtBUaJS0Rs7z89/xGAU6LD7CqHJpJnA/WxOK+ajZizRYy0v4iRPuK35RXIB/JtgM4XrPG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501008; c=relaxed/simple;
	bh=hoOyAQC3/dy3DWNeb8vAGyXp79BAxaTy3iJq0EEGQD0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jb9qRmUd2RavI9lk0ZrT1rZ0ySQwpX7xzvEujWHmX/MVLy4y7szGAiRftXdLAzDHTGBu49Ux9wmTSrr9biVlM3MCalcwZ9SO6pM7KKctRHbE57Jta6hW1BycfOTo67AIuPME7ig8XkAusIq3O4wXHXfLnD/iqNjAqACIGUV+q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnQwealZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnQwealZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD341F000FF;
	Sun, 27 Sep 2026 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790501007;
	bh=QGcUuY5nFcLRyVrESUWxEWprsmV9XzoM5Slz0Qlx8dA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AnQwealZ49B8LL3raOE/egVtBp1iIqo8HQfZ2xxO6K+fkuU4ihiBPi0C0gj6I2MI2
	 UVPUYHc+J8VkZKjt/ooHhXkzqVgVKqpcVFtW53/def59c27HXwNv0QpQ0BVZ3miI4L
	 lOyyyWz41mWKu4KQ9q18ttRVu/Cf7H4DyAZJMA/LQ93Ita+SdbCTj7PUaVHFcekxg4
	 7auP1c2l7wTiJ79du7SPfip1REmkKkcY4Rh6CcrFjjyemVg+dLHSrhC4/ffnfQAI/7
	 6LMcAGqScZEcKw6FlVvNHSnxgW3xfUs0RcEEkaYhi//62jdY1zHvjZnHxaUJyf9Xel
	 BQb4n/SW1qJhg==
Subject: Re: [PATCH net] tipc: reject attaching bearer of different media to
 the same occupied device
From: netdev-bot+sashiko@kernel.org
To: tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, xujiakai24@mails.ucas.ac.cn
Date: Sun, 27 Sep 2026 09:23:25 +0000
Message-ID: <179050100597.2160803.8636292955044535357@kernel.org>
In-Reply-To: <20260923091057.375981-1-tung.quang.nguyen@est.tech>
References: <20260923091057.375981-1-tung.quang.nguyen@est.tech>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] The new check runs for every media type, but for UDP media the
  text after ':' is not a device name.

--

tipc: reject attaching bearer of different media to the same occupied device

This patch adds a check to tipc_enable_bearer(). A new bearer is rejected
when an existing bearer has the same interface-name suffix but a different
media type. The goal is to fix a dev_refcnt leak: two L2 bearers such as
"eth:eth0" and "ib:eth0" attach to the same net_device, and the second one
overwrites dev->tipc_ptr.

Closes: http://lore.kernel.org/netdev/20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn/

> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 05dcd2f9e887a..1fb54a588c8df 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c

[ ... ]

> @@ -296,6 +297,15 @@ static int tipc_enable_bearer(struct net *net, const char *name,
>  			goto rejected;
>  		}
>  
> +		if_name = strchr((const char *)b->name, ':') + 1;
> +		if (!strcmp(if_name, b_names.if_name) &&
> +		    strcmp(b->media->name, b_names.media_name)) {

[Severity: High]
Can a string comparison reliably tell whether two bearers share a device?

tipc_enable_l2_media() does not use the raw suffix as-is. It resolves it
with dev_get_by_name():

net/tipc/bearer.c:tipc_enable_l2_media() {
    char *dev_name = strchr((const char *)b->name, ':') + 1;
    ...
    dev = dev_get_by_name(net, dev_name);
    ...
    rcu_assign_pointer(dev->tipc_ptr, b);
}

The lookup goes through
dev_get_by_name()->dev_get_by_name_rcu()->netdev_name_node_lookup_rcu().
It also matches altnames, because netdev_name_node_alt_create() adds them
to the same per-netns name hash.

Say eth0 has the altname "myalt". Enabling "eth:eth0" and then "ib:myalt"
(or "eth:myalt") passes both the full-name check and this new strcmp().
Both bearers then attach to the same net_device.

Each enable takes a device reference through dev_get_by_name() and calls
dev_add_pack(). The second enable then overwrites dev->tipc_ptr without
checking whether it is already set.

On NETDEV_UNREGISTER, tipc_l2_device_event() only acts on the bearer
stored in dev->tipc_ptr:

    b = rtnl_dereference(dev->tipc_ptr);
    ...
    case NETDEV_UNREGISTER:
    case NETDEV_CHANGENAME:
        bearer_disable(net, b);

tipc_disable_l2_media() then clears dev->tipc_ptr. The first bearer keeps
its device reference and its packet_type, and later NETDEV_UNREGISTER
rebroadcasts cannot find it.

Would unregister_netdevice() then hang waiting for the device to become
free? That is the same dev_refcnt leak the commit message describes.

TIPC_NL_BEARER_ENABLE uses GENL_UNS_ADMIN_PERM, and adding an altname
only needs CAP_NET_ADMIN in the netns. An unprivileged user could
therefore do this from inside their own user and network namespace.

Would it be more robust to check device identity instead of names? For
example, tipc_enable_l2_media() could call dev_put() and return -EBUSY
when rtnl_dereference(dev->tipc_ptr) is already non-NULL. That would
replace the name comparison in tipc_enable_bearer().

> +			errstr = "same device for different media";
> +			NL_SET_ERR_MSG(extack,
> +				       "Same device for different media");
> +			goto rejected;
> +		}

[Severity: Medium]
Does this check also reject valid UDP bearers?

For UDP media, the text after ':' is not a device name, only a label.
tipc_udp_enable() never reads the suffix of b->name, and it never sets
dev->tipc_ptr. It picks its device from TIPC_NLA_UDP_LOCAL through
__ip_dev_find(), or through __dev_get_by_index() and ipv6_dev_find() for
IPv6.

With this patch, enabling "udp:eth0" while "eth:eth0" exists (or the
other way round) fails with -EINVAL and "Same device for different
media". The two bearers don't share an L2 device reference or
dev->tipc_ptr, and this combination worked before the patch.

Would a device-occupancy check inside tipc_enable_l2_media() avoid this
false rejection?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923091057.375981-1-tung.quang.nguyen%40est.tech
