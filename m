Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9F442B10
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157477; cv=none; b=anP6ThDecIdGDO9pA0Y1dNkvW9lEyg4NCLNGoikrZOELPkndnXDjEzjZn5nzp1JloXIDjD+8SDTfYOsz8n2xdKostpSHF3Ba+1Apfuj1VFPhsay20Hm16k/3wd5Ee2fpId0KWF6+x4d14bX9sznwGeukkys86/2sAU8ee5KiAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157477; c=relaxed/simple;
	bh=BqyfYgkwDCqoMjr6dxl1GuT8mu+3qcIOomWDngGqQ6U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D58R7671KUHog5DQo8QC7omUd1dz2x3GEBOHQVjK2LNt3SKTi0DeGITqoIwy+OMx7bA7aKN3Qf0EswKBoRKi3oRghX/rWI6hG2U/XGVTJ7aUCgEzRtZFgqRg+/JLGF3XHmIMymgii0GKApIMQrJFKQCHOSB3PykmsMsRIsVO3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8Hya3KH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8Hya3KH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B861F00893;
	Fri, 11 Sep 2026 20:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157476;
	bh=p1KGxWlHYQ0fOpX3ChpREXs14J4Pc9JauJPq83pGnDw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S8Hya3KHG6Jlc70EI6I+ATzZekAQo2/YhfioPY5SkGLsPSsKB6xRE1fzdrW/WZmgD
	 AtbdDCkywTjkjPuGbGZKOnrrw2FwXcr4MQt4IJB3IYU9Fgc5Z7VCg7XOL9/3OuNDXn
	 9x5iqxHXSjgiELIA/D1IHmZO7q7Tz06o/7sHod4hpchrhVDcNVZM9+30h4B2DF9fgN
	 APUi1ukkXGnJUh3uNPM1qfntymwdRYO+8PfGUAaZBRQN1MCrN+dGNGxhMFZgCyKem0
	 nUtgTTqIH/WinOb7vFDwSP83EwRBW21EKc4MoV91R3S8onWmyh2TeU9KDWKyk6kmIX
	 oO7BzgMn4jGGw==
Subject: Re: [PATCH net-next 3/8] netlink: specs: devlink: describe
 DEVLINK_ATTR_NESTED_DEVLINK
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Fri, 11 Sep 2026 20:11:15 +0000
Message-ID: <178915747530.219967.10076568533385778223@kernel.org>
In-Reply-To: <20260910200312.2665792-4-kuba@kernel.org>
References: <20260910200312.2665792-4-kuba@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Documentation/netlink/specs/devlink.yaml: the new `dl-nested-
  devlink` subset (added by this patch) lists `netns-id` as a member of…

--

netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK

This fills in the single attribute (DEVLINK_ATTR_NESTED_DEVLINK, 175) that
was hidden behind the "# TODO: fill in the attributes in between" gap, adds
a dl-nested-devlink subset for the nest contents, and lists the new
attribute in the dev-get reply.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 0e0791d4e2c74..7ec52f81c3230 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -858,13 +858,14 @@ attribute-sets:
>          name: linecard-supported-types
>          type: nest
>          nested-attributes: dl-linecard-supported-types
> -
> -      # TODO: fill in the attributes in between
> -
> +      -
> +        name: nested-devlink
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: dl-nested-devlink
>        -
>          name: selftests
>          type: nest
> -        value: 176
>          nested-attributes: dl-selftest-id

[ ... ]

> @@ -1351,6 +1352,19 @@ attribute-sets:
>        -
>          name: index
>  
> +  -
> +    name: dl-nested-devlink
> +    subset-of: devlink
> +    attributes:
> +      -
> +        name: bus-name
> +      -
> +        name: dev-name
> +      -
> +        name: index
> +      -
> +        name: netns-id

[Severity: Low]
Now that netns-id is described as part of a reply nest, does its declared
type match what the kernel puts on the wire?  In the main devlink
attribute set it is declared as:

      -
        name: netns-id
        type: u32

but devlink_nl_put_nested_handle() in net/devlink/netlink.c emits it as a
signed value:

	int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);

	rcu_read_unlock();
	if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
		return -EMSGSIZE;

and peernet2id_alloc() in net/core/net_namespace.c can return
NETNSA_NSID_NOT_ASSIGNED (-1) when !check_net(net), when maybe_get_net()
on the peer netns fails, or when alloc_netid() fails under GFP_ATOMIC.

Would a spec-driven decoder (ynl or generated C) then print that -1
sentinel as 4294967295 for devlink dev-get when the nested instance
(mlx5 SF, ice) lives in another netns?

Every other spec in the tree that carries a netns id uses s32:
netdev.yaml (netns-id), psp.yaml (nsid), rt-link.yaml (link-netnsid,
new-netnsid, target-netnsid).

Should the devlink declaration be s32 (or sint) as well?  The request side
parse in devlink_netns_get() uses nla_get_u32(), which is byte-compatible
with an NLA_S32 policy, so the wire format would not change.

I checked the end of the series and netns-id is still declared u32 there,
so this does not look like something a later patch adjusts.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910200312.2665792-1-kuba%40kernel.org
