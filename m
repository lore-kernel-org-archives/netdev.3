Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263B599A31
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157481; cv=none; b=Zrvah+Yu8M7nYvs5vmriv1wmz9LPjCbR9yRcn3AGzZ9im//qVfal2aDiURgpdoVEbh9OhgMgRIWgI8HD43DDoP5w+risFqOOKDz7A2hsF7S0W8n/RXIbID+YOJjvRO2xcWLE+9QTS5bWscjZoaFtTrwYoaoehPoMq+HX3k7Cgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157481; c=relaxed/simple;
	bh=Uxht5m+2DPyEcX5FdbpGUfvUz6eWkE6J1uVdJ5lUU68=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tB3RPIzwejCxCbLOiWqRHj1wRcYYMbG5KD552LYj+6gRRu4PXE7LGVLLVVK1M8Jx/5Xftb9Few5SstmGWvyFdmi0GMGaJbuOCX/hrrkd9iA7l+1DXkyrhs5i3UicY+2UGs1vRd8aTc16LKpS5OZ8/qJYp4/BlwXOMnlGhBfOlH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbs5BNN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbs5BNN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616271F000FF;
	Fri, 11 Sep 2026 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157480;
	bh=Tm/Lsz5jTmRtgE6laTMAMMLAaEt+ZHMeSYikpieCSgQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cbs5BNN/v05EGXRRczdc3oUEKR+2jmGMynNE6tp0wYLvgrIfVsZepu+SGTWOWfCMe
	 agbE6SNS6nLa5cB1U8aIcP72PuEiHxkErHpGqqIkVKeEM/nn4UqqDgRw403+SnKqHK
	 cBKcVlbTdHQKHjNwks8QgGIwmifFM4IMv3n0X7Hpk4mtbXZ/6fnrJ+RKZ3/CjsWk1M
	 qpSTPuatME7mssGKDuDnVFjNtwj94PkYZDFrgXIiO/T0zpl9xufCyutpr19c5TLMRU
	 aePVzeefQPeTUzo82wHc5KDjXlvTq8Ykxo8J4toPiOBIrUPRpOdcNn4e98GidowRsc
	 ZW7Y8FhkpKS4Q==
Subject: Re: [PATCH net-next 7/8] netlink: specs: devlink: describe the netns
 id in the parent-dev nest
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Fri, 11 Sep 2026 20:11:18 +0000
Message-ID: <178915747894.219967.18233169870499683524@kernel.org>
In-Reply-To: <20260910200312.2665792-8-kuba@kernel.org>
References: <20260910200312.2665792-8-kuba@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1 (1)

- [High] The new `dl-rate-set` subset
  (Documentation/netlink/specs/devlink.yaml:1406-1432), which the patch…
- [Low] This patch makes `netns-id` part of the described contents of the
  `parent-dev` nest (parent-dev now nests `dl-nested-devlink`,…

Pre-existing issues:
- [Low] The purpose of the change is to describe the netns id carried
  inside the `parent-dev` nest emitted by…

--

netlink: specs: devlink: describe the netns id in the parent-dev nest

The patch points the devlink parent-dev nest at the dl-nested-devlink
subset so the netns id emitted by devlink_nl_put_nested_handle() is
described, and adds a new dl-rate-set subset used as the attribute-set of
the rate-set and rate-new operations so their input keeps nesting
dl-parent-dev.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 9d816a0b7da41..54de1eeb22347 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -912,7 +912,7 @@ attribute-sets:
>        -
>          name: parent-dev
>          type: nest
> -        nested-attributes: dl-parent-dev
> +        nested-attributes: dl-nested-devlink

[Severity: Low]
With parent-dev now nesting dl-nested-devlink, netns-id becomes part of
the described nest contents, but the root devlink attribute set types it
as unsigned:

      -
        name: netns-id
        type: u32

The kernel writes it signed in devlink_nl_put_nested_handle():

	int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);

	rcu_read_unlock();
	if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
		return -EMSGSIZE;

and peernet2id_alloc() returns NETNSA_NSID_NOT_ASSIGNED (-1) when
check_net() fails, when maybe_get_net() on the peer fails, or when
alloc_netid() fails.

The width matches so the wire format is unchanged, but should the type be
sint/s32 so spec-driven decoders show the "not assigned" report as -1
rather than 4294967295?

Note the same attribute is consumed as an unsigned input by
devlink_netns_get(), so the output-side typing may need to be expressed
separately from the input.

[Severity: Low]
This is a pre-existing gap rather than something this patch introduces,
but the nest whose netns id is being described here is still not listed in
any reply in the spec. rate-get reuses the request anchor for its reply:

        request:
          value: 74
          attributes: &rate-id-attrs
            - bus-name
            - dev-name
            - index
            - port-index
            - rate-node-name
        reply: &rate-get-reply
          value: 76
          attributes: *rate-id-attrs

while devlink_nl_rate_fill() also emits RATE_TYPE, RATE_TX_SHARE,
RATE_TX_MAX, RATE_TX_PRIORITY, RATE_TX_WEIGHT, RATE_TC_BWS and, through
devlink_nl_rate_parent_fill(), RATE_PARENT_NODE_NAME and PARENT_DEV.

Since parent-dev appears only in the root attribute set, in dl-rate-set
and in the rate-set/rate-new request lists, does the netns id described
here remain unreachable for ynl-gen-c generated consumers, which build the
reply struct from the listed reply attributes?

>          doc: |
>            Identifies the devlink instance which owns the parent rate node.
>            Used with rate-set and rate-new to parent a rate object to a node on

[ ... ]

> @@ -1390,6 +1390,22 @@ attribute-sets:
>    -
>      name: dl-parent-dev
>      subset-of: devlink
> +    doc: |
> +      Devlink handle accepted as the parent-dev input; the netns id the
> +      kernel reports back is not accepted, the parent is always resolved
> +      in the caller's netns.
> +    attributes:
> +      -
> +        name: bus-name
> +      -
> +        name: dev-name
> +      -
> +        name: index
> +
> +  -
> +    name: dl-rate-set
> +    subset-of: devlink
> +    doc: Attributes accepted by the rate-set and rate-new requests.
>      attributes:
>        -
>          name: bus-name
> @@ -1397,6 +1413,23 @@ attribute-sets:
>          name: dev-name
>        -
>          name: index
> +      -
> +        name: rate-node-name
> +      -
> +        name: rate-tx-share
> +      -
> +        name: rate-tx-max
> +      -
> +        name: rate-tx-priority
> +      -
> +        name: rate-tx-weight
> +      -
> +        name: rate-parent-node-name
> +      -
> +        name: rate-tc-bws
> +      -
> +        name: parent-dev
> +        nested-attributes: dl-parent-dev

[Severity: High]
Is port-index missing from dl-rate-set?  It is the only way to address a
leaf (port) rate object, per devlink_rate_get_from_info() in
net/devlink/rate.c:

	if (attrs[DEVLINK_ATTR_PORT_INDEX])
		return devlink_rate_leaf_get_from_info(devlink, info);
	else if (attrs[DEVLINK_ATTR_RATE_NODE_NAME])
		return devlink_rate_node_get_from_info(rate_devlink, devlink, info);
	else
		return ERR_PTR(-EINVAL);

Before this change the two ops used attribute-set: devlink, so pyynl could
encode port-index.  _encode_message() encodes request fields out of the
op's attribute set and _add_attr() raises on an unknown name:

        try:
            attr = self.attr_sets[space][name]
        except KeyError as err:
            raise YnlException(f"Space '{space}' has no attribute '{name}'") from err

Does every leaf rate-set/rate-new now fail client side with "Space
'dl-rate-set' has no attribute 'port-index'" before a message is built?

Two in-tree selftests pass port-index to devnl.rate_set():
tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py
(rate_set_leaf, rate_set_leaf_parent, rate_clear_leaf_parent) and
tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
(setup_devlink_rate).

The same narrowing also affects extack decoding, which resolves the
offending attribute through op.attr_set via attrs_by_val[attr.type], so a
bad-attr extack naming any devlink attribute outside these eleven members
would now raise a decode exception instead of resolving a name.

Related to this, the doc string says "Attributes accepted by the rate-set
and rate-new requests", but the kernel accepts DEVLINK_ATTR_PORT_INDEX for
these commands, and rate-get's request list does include port-index, so the
two spots describing the same object selector disagree.  Adding port-index
to dl-rate-set (and to the rate-set/rate-new request lists, which also omit
it today and only work because of dont-validate: [strict]) would keep them
consistent.

Checked at the tip of the series (59624e85e9fb): the last patch, "netlink:
specs: devlink: add pad to the subsets carrying padded u64s", only adds pad
members and does not add port-index to dl-rate-set.

>  
>    -
>      name: dl-nested-devlink
> @@ -2379,7 +2412,7 @@ operations:
>      -
>        name: rate-set
>        doc: Set rate instances.
> -      attribute-set: devlink
> +      attribute-set: dl-rate-set
>        dont-validate: [strict]
>        flags: [admin-perm]
>        do:
> @@ -2402,7 +2435,7 @@ operations:
>      -
>        name: rate-new
>        doc: Create rate instances.
> -      attribute-set: devlink
> +      attribute-set: dl-rate-set
>        dont-validate: [strict]
>        flags: [admin-perm]
>        do:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910200312.2665792-1-kuba%40kernel.org
