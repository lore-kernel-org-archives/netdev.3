Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D24BF952
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586149; cv=none; b=Mg0dVSiNXm3wvzY5TMnm7quEEVGv5YNW1miRf7ilCZAC129KoQJfSiErvakVWaK/eO1qOs07OWuXruaSZQa2AEY/QHhNqRVUPTZWdRQpI8MLqbzt7ulAz5FSaiJWZk66apuz0WyU8Y7jCRMVY0/KTsW7lUep32VbUEbUXBQpS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586149; c=relaxed/simple;
	bh=1ZxUiBnE1l5KQU6PoL3/8TvS0ltfVeafJkmwmcLaWoY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EEHs3RTq3KlJEcjTIO2B/Ud7h7p5C76FdZqU+7ZHY2xajOJn4DcRd4KA5AuUZqhv/bopeG8f7q7Bpw5b3lKmvGDKlphkf608gFvYN3Q9IJAOK30drdVxPhrRV3K4SqNJ3iQ1q8Lm2PKP4jIKMEQBsJl1LX1xVv9Pk7AyzyepykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HffiUD+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HffiUD+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD791F00898;
	Wed, 16 Sep 2026 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586122;
	bh=5H+QD7ikhP7UVYMkPN8E2wI6SPz4V9UfPgrZQuUccJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HffiUD+/KKPgCTPTaWTqgxqpXcgIpP3ewfwRyuYy4PwJmM7KY3RyS16+pctiRktC9
	 OpM3RTcarD4J16woCyiTivSeCG3Ukdv1NTC7zHTvVTLEfkLmUwN7YoGXkdZxDC4ILb
	 bWpVllqf89YFFKzgKDCm3q3cLkuZG5/epHwvTbF1/gn8kierJ2IyYEaLbStFogyOzq
	 QtjKUKSmVbI1/gLowkSrZuOLnCpkQ8vQbEBAXcRrOatd3nXeIhgvfdUreVrLPmUndR
	 No/jRcao3NzeoI45PTn3sWiJtFB+L6QtbjrZ68oShio+sTxdNB7ACcVShxLCPzw0Dm
	 7+M6E+MT6RkmQ==
Subject: Re: [PATCH net-next v2 4/9] netlink: specs: devlink: complete the
 port function nest
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Wed, 16 Sep 2026 19:15:21 +0000
Message-ID: <178958612108.22033.8567015919160539222@kernel.org>
In-Reply-To: <20260915161341.1053476-5-kuba@kernel.org>
References: <20260915161341.1053476-5-kuba@kernel.org>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2 (1)

- [Low] Missing `Fixes:` tag on a user-visible uAPI-description fix.
- [Low] The newly added `max-io-eqs` attribute in the `dl-port-function`
  attribute set (Documentation/netlink/specs/devlink.yaml) carries no…

Pre-existing issues:
- [Low] Concern (assessed as pre-existing and low impact): the `dl-
  nested-devlink` nest now referenced by the new port-function `devlink`…

--

netlink: specs: devlink: complete the port function nest

The devlink spec's dl-port-function nest stopped at caps even though the
kernel also emits DEVLINK_PORT_FN_ATTR_DEVLINK and
DEVLINK_PORT_FN_ATTR_MAX_IO_EQS, so ynl could not decode port replies on
mlx5 SFs and VFs.  This adds the two missing attributes to the spec and
regenerates the devlink netlink policy.

A couple of questions below.

The commit message says:

  Commit 5af3e3876d56 ("devlink: Support setting max_io_eqs") added the
  uAPI value and the hand written policy but never touched the spec.

[Severity: Low]
Since the offending commit is already identified, and the symptom is a hard
decode failure in userspace rather than a cosmetic gap, would a Fixes: tag
be appropriate here?

  Fixes: 5af3e3876d56 ("devlink: Support setting max_io_eqs")

devlink_nl_port_function_attrs_put() puts DEVLINK_PORT_FN_ATTR_MAX_IO_EQS
on every port-get do and dump for affected hardware:

net/devlink/port.c:devlink_port_fn_max_io_eqs_fill() {
	...
	err = nla_put_u32(msg, DEVLINK_PORT_FN_ATTR_MAX_IO_EQS, max_io_eqs);
	...
}

so ynl-based tooling aborts with the quoted "Space 'dl-port-function' has
no attribute with value '6'" until this spec change lands.  Without a tag,
backport tooling has nothing structured to key off.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 7ec52f81c3230..962789dfbfacf 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -992,6 +992,14 @@ attribute-sets:
>          type: bitfield32
>          enum: port-fn-attr-cap
>          enum-as-flags: true
> +      -
> +        name: devlink
> +        type: nest
> +        nested-attributes: dl-nested-devlink
> +        doc: Handle of the peer devlink instance instantiated for this function.
> +      -
> +        name: max-io-eqs
> +        type: u32

[Severity: Low]
This isn't a bug, but the sibling devlink attribute added in the same hunk
carries a doc: while max-io-eqs does not.  Could a doc: line be added
stating what the value means, e.g. the maximum number of IO event queues
configurable for the function?

>  
>    -
>      name: dl-dpipe-tables
> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> index 30f01901b5877..17d1edcdb935e 100644
> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -46,17 +46,26 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
>  }
>  
>  /* Common nested types */
> +const struct nla_policy devlink_dl_nested_devlink_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
> +	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
> +	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> +	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
> +	[DEVLINK_ATTR_NETNS_ID] = { .type = NLA_U32, },
> +};

[Severity: Low]
This is a pre-existing typing mismatch and not something this patch
introduces, but pulling dl-nested-devlink into the port function nest makes
it visible to more spec-driven decoders.

The spec declares netns-id as u32 in the root devlink attribute set:

      -
        name: netns-id
        type: u32

while the kernel emits it signed:

net/devlink/netlink.c:devlink_nl_put_nested_handle() {
	...
		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
	...
}

and the value can be the negative sentinel:

net/core/net_namespace.c:peernet2id_alloc() {
	...
	if (!check_net(net))
		return NETNSA_NSID_NOT_ASSIGNED;
	...
}

Would ynl then render an unassigned namespace as 4294967295 rather than -1?
Wire width and kernel-side length validation are identical for NLA_U32 and
NLA_S32, so this looks like a display-only difference, but should the spec
(and hence the generated policy) say sint/s32 here?

>  const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
>  	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
>  };

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915161341.1053476-1-kuba%40kernel.org
