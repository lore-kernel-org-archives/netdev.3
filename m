Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B524B8287
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586140; cv=none; b=L7R3pxPGIJe7kroeYVc+HUOz9l8q3U7+q2uJ/zXSP3ZMDb3uWNBRm8ghQgsov5dDokx8Oecjn1TD91DKZeeZam8LyNkwJ6NtLmxmc7oOzSSqGdvdz0sThDetSlydle+V/8TqvXQ/yAq9inwhtiHp1V8YLQQZjNw4EByNrmsFU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586140; c=relaxed/simple;
	bh=e9F3wstsU40Yb30EO75kEURzZyYSyiZ7qKBk4t+6miQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jc+PvU/9vziuOu5sju9kkup/doBtPf3yYMz6l3r+BTFwpJA0CUluXP3nkO6uGo0wxoeWvY8g8bhU6TJpoQNJo/iWnDQyUHgnDeTIJo8qMQWHtqGaQmthxwWfPACyp3o94lQYW5rsygcnpPrX0fcHSoQFYA5p6JFPtjED4NpCmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrYTpJC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrYTpJC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2556B1F0089A;
	Wed, 16 Sep 2026 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586124;
	bh=k2FKuWnNolyZYfMeL0fp2jM10oUItvJvF0+bBYikyME=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GrYTpJC9iS3X/O4Ftfu+16lgg936EL1NTzudxQw4/UZEjJD7O3vYPu4bdkDTrvtFr
	 2avMzRpsjaPNLIjMrC98AQwOFi6GulhnnY6uArUrVtFpc1MRB0KOdNTbNb4mwoJO40
	 nKVqCwsT10QPxF1J0OsEFOftYZ0+jCjZvI+XokPLsMFlJ6wq9zd+tmZarzPMecxgC3
	 hZhVW9W1IPs/SjqDGHPqPBNw+gaUZwOwd3dCAewTgFHuo0M2R9BZzr32NYmqchn/yN
	 VtalOPxMTCAmdPoYGD5DDL+5++4HNLD/r2C9NoRiDE6ojlcW0+Lf+tIqVbhDpzT7f6
	 qCB5ttWu9AxDg==
Subject: Re: [PATCH net-next v2 7/9] netlink: specs: devlink: describe the
 netns id in the parent-dev nest
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Wed, 16 Sep 2026 19:15:23 +0000
Message-ID: <178958612368.22033.8170999467219795147@kernel.org>
In-Reply-To: <20260915161341.1053476-8-kuba@kernel.org>
References: <20260915161341.1053476-8-kuba@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1 (1)

- [Medium] Understated impact and missing Fixes: tag.
- [Medium] Spec/implementation signedness mismatch for the very field
  this patch sets out to describe: devlink.yaml declares `netns-id` as…
- [Low] Baseline decision: FALSE POSITIVE at the end of the series
  (retained only because the concern is flagged requires_validation).

Pre-existing issues:
- [Low] Baseline decision: DISCARDED as a low-severity pre-existing gap
  (retained only because the concern is flagged requires_validation).

--

netlink: specs: devlink: describe the netns id in the parent-dev nest

Points the parent-dev nest at the dl-nested-devlink subset so the netns id
that the kernel emits inside that nest is described, and adds a new
dl-rate-set subset so the rate-set and rate-new request attribute sets keep
using dl-parent-dev, which has no netns id.

> netlink: specs: devlink: describe the netns id in the parent-dev nest
>
> devlink_nl_rate_parent_fill() emits DEVLINK_ATTR_PARENT_DEV via
> devlink_nl_put_nested_handle(), which adds DEVLINK_ATTR_NETNS_ID
> whenever the parent rate node lives on a devlink instance in another
> netns. Now that we defined dl-nested-devlink subset, which unlike
> dl-parent-dev includes netns-id, let's switch to it.

[Severity: Medium]
Is this description understating what the change fixes?  The wording reads
like the switch is descriptive polish ("Now that we defined
dl-nested-devlink subset ... let's switch to it"), but before this patch
python ynl seems to fail decoding real kernel messages, not just describe
them incompletely.

devlink_nl_rate_parent_fill() puts the nest through
devlink_nl_put_nested_handle(), which adds the netns id:

net/devlink/netlink.c:devlink_nl_put_nested_handle() {
	...
		int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);

		rcu_read_unlock();
		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
	...
}

With parent-dev nesting dl-parent-dev (bus-name, dev-name, index only),
YnlFamily._decode() raises when it cannot find the attribute in the nested
space:

tools/net/ynl/pyynl/lib/ynl.py:YnlFamily._decode() {
	...
                if not self.process_unknown:
                    raise YnlException(f"Space '{space}' has no attribute "
                                       f"with value '{attr.type}'") from err
	...
}

so rate-get do/dump and the rate notifications abort for a cross-netns
parent, the same failure class quoted in the sibling patch "netlink: specs:
devlink: complete the port function nest".

Would it make sense to say that in the commit message and add:

Fixes: b5f90fd4580ce7 ("devlink: Add parent dev to devlink API")

which is the commit that added both parent-dev and the dl-parent-dev
subset?  Without it this looks cosmetic and stable trees keep the spec that
breaks decoding.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 5c9c672497d44..5535247faf14f 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -912,7 +912,7 @@ attribute-sets:
>        -
>          name: parent-dev
>          type: nest
> -        nested-attributes: dl-parent-dev
> +        nested-attributes: dl-nested-devlink

[Severity: Medium]
Now that the netns id is described in this nest, is its declared type
right?  In the devlink attribute set netns-id is declared unsigned:

        name: netns-id
        type: u32

but the emitter uses the signed helper on a value that can be negative:

net/devlink/netlink.c:devlink_nl_put_nested_handle() {
	...
		int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);

		rcu_read_unlock();
		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
			return -EMSGSIZE;
	...
}

peernet2id_alloc() returns NETNSA_NSID_NOT_ASSIGNED (-1) in several cases:

net/core/net_namespace.c:peernet2id_alloc() {
	...
	if (!check_net(net))
		return NETNSA_NSID_NOT_ASSIGNED;
	...
	if (!maybe_get_net(peer)) {
		spin_unlock(&net->nsid_lock);
		return NETNSA_NSID_NOT_ASSIGNED;
	}
	...
}

So when the peer netns is going away, or no nsid can be allocated, does a
ynl based tool render the not-assigned marker as 4294967295 for this nest?
Should netns-id be sint/s32 instead?  Note the same declaration is reused
by the reload input path in net/devlink/dev.c, and the uAPI header comment
repeats it:

include/uapi/linux/devlink.h:
	DEVLINK_ATTR_NETNS_ID,			/* u32 */

so separating the input and output descriptions may be needed.

>          doc: |
>            Identifies the devlink instance which owns the parent rate node.
>            Used with rate-set and rate-new to parent a rate object to a node on

[ ... ]

> @@ -1398,6 +1402,37 @@ attribute-sets:
>        -
>          name: index
>  
> +  -
> +    name: dl-rate-set
> +    subset-of: devlink
> +    doc: Attributes accepted by the rate-set and rate-new requests.

[Severity: Low]
This isn't a bug, but is the doc line accurate for rate-new?  The subset
lists port-index, while rate-new's do: request: attributes: omits it, and
devlink_nl_rate_new_doit() never looks at DEVLINK_ATTR_PORT_INDEX
(devlink_rate_node_get_from_attrs() resolves the node by name), so
port-index is silently ignored there.  Could the doc say that port-index
applies to rate-set only?

For the record, the related concern about DEVLINK_ATTR_PORT_INDEX having
no policy entry in devlink_rate_set_nl_policy, which let
devlink_port_get_from_attrs() run nla_get_u32() on a short attribute under
dont-validate: [strict], is resolved later in this same series by
"devlink: validate the port index in the rate set request", which adds
port-index to the rate-set request list and regenerates the NLA_U32 policy
entry.  So there is nothing left here beyond the doc wording.

> +    attributes:
> +      -
> +        name: bus-name
> +      -
> +        name: dev-name
> +      -
> +        name: index
> +      -
> +        name: port-index
> +      -
> +        name: rate-node-name

[ ... ]

> +      -
> +        name: parent-dev
> +        nested-attributes: dl-parent-dev
> +
>    -
>      name: dl-nested-devlink
>      subset-of: devlink
> @@ -2387,7 +2422,7 @@ operations:
>      -
>        name: rate-set
>        doc: Set rate instances.
> -      attribute-set: devlink
> +      attribute-set: dl-rate-set
>        dont-validate: [strict]
>        flags: [admin-perm]
>        do:

[ ... ]

> @@ -2410,7 +2445,7 @@ operations:
>      -
>        name: rate-new
>        doc: Create rate instances.
> -      attribute-set: devlink
> +      attribute-set: dl-rate-set
>        dont-validate: [strict]
>        flags: [admin-perm]
>        do:

[Severity: Low]
This is a pre-existing gap and not something this patch introduces, but
while the output side of parent-dev is being described here, parent-dev
still does not appear in any reply or notification attribute list.

The rate-get reply anchor (&rate-get-reply) lists only *rate-id-attrs
(bus-name, dev-name, index, port-index, rate-node-name), and that same
anchor is reused by the rate dump and by the rate-new/rate-del
notifications, while devlink_nl_rate_fill() emits more than that:

net/devlink/rate.c:devlink_nl_rate_fill() {
	...
	if (nla_put_u16(msg, DEVLINK_ATTR_RATE_TYPE, devlink_rate->type))
	...
	if (devlink_rate->parent &&
	    devlink_nl_rate_parent_fill(msg, devlink_rate))
	...
	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
	...
}

and the nest itself comes from:

net/devlink/rate.c:devlink_nl_rate_parent_fill() {
	...
	if (devlink != devlink_rate->devlink &&
	    devlink_nl_put_nested_handle(msg,
					 devlink_net(devlink_rate->devlink),
					 devlink, DEVLINK_ATTR_PARENT_DEV))
	...
}

Does this mean generated C ynl reply structures for rate-get still have no
parent_dev (and no rate tx share/max/priority/weight or tc-bws) member, so
C consumers cannot see the netns id this patch documents?  Would adding the
emitted attributes to the rate-get reply be a reasonable follow-up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915161341.1053476-1-kuba%40kernel.org
