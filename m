Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE92989B5;
	Wed, 12 Aug 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498726; cv=none; b=VzWRlwp8MDJBORVJ2jnYK8B+qZS9VX/UfW38oyE091cqjZBXtSkZv1OJb+Mh1vZTiR+ebRNNgc47X78omU8s2eIEJyP3ZaAs1uCOJ3sMmXLaYmd1IW9v3dEwt6EsrvcqxI7TzVMPHTcNKUtROdcoAhfs5XzzSi9NdKTXK3XLf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498726; c=relaxed/simple;
	bh=fQpjhdmWwJUlpZ5q5jtmk1QlTCFVj9P7x6ov8KAmCS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cczzpbDbUgYBq8QhQKIzpzde/BSRu2mi5hfCxFYC0T6jsYO5BWw3YtKuTFzPeG7UFBeX1ICaUg1WrCCslFDc/vITv5xt5iuWTxXedadzmv4NrFlaQzSLe6bQA9z63/gAGzyf9EukSFMMzHrRgG9i6eIOkQNeq1O/vSxXcnaO214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihbtb1tB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihbtb1tB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41791F000E9;
	Wed, 12 Aug 2026 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498725;
	bh=JxWiKAIies8F+3LnLRQ3d21jloS1jkjTWQjD0d0fpl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ihbtb1tBoD3b9MGCQbhbGBDrUX6GZZba2pPdyZ21FDXFZGqe0VblT/xC+dSynDwZ0
	 V3TGxul1O9Joz4BS4nrBPvKPAzq43+G+pRqQu98kfmVli57SSBCao8xqW4ntcG5hYe
	 5aWyeLoHpMbGTA477j6O3CyrvgmDDSnzMtjKQJPhN/GhRgyh3TmPRptVVCmOO/CdUJ
	 oGdDWEqiJSe3rBcST24el/wgYr/pC1VZUSNurISRGX4lGKYZHYyk+qh1MciwD6iIti
	 eWcjPviFtF9BgAYDuT2jNa+hLq6kWxpEv5q23GhW8Ht4NbKorBkHDBJKjrVV0yBJHH
	 4tE98iH9mq97Q==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ayal@nvidia.com,
	gal@nvidia.com,
	jiri@nvidia.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	osidi@nvidia.com,
	horms@kernel.org
Subject: Re: [PATCH net-next] devlink: prevent function configuration when port is active
Date: Tue, 11 Aug 2026 18:38:43 -0700
Message-ID: <20260812013843.1678838-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810103245.3162004-1-tariqt@nvidia.com>
References: <20260810103245.3162004-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
devlink: prevent function configuration when port is active

This adds a check in devlink_port_function_validate() that queries the
port function state for PCI_SF flavour ports and rejects the request with
-EINVAL when the function is active.  A few questions about the scope and
the enforcement of the new rule below.

> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 1528f2d148dfc..6a9857bf79da1 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -708,7 +708,10 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
>  					  struct netlink_ext_ack *extack)
>  {
>  	const struct devlink_port_ops *ops = devlink_port->ops;
> +	enum devlink_port_fn_opstate opstate;
> +	enum devlink_port_fn_state state;
>  	struct nlattr *attr;
> +	int err;
>  
>  	if (tb[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] &&
>  	    !ops->port_fn_hw_addr_set) {
> @@ -721,6 +724,20 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
>  				    "Function does not support state setting");
>  		return -EOPNOTSUPP;
>  	}
> +	if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_SF &&
> +	    ops->port_fn_state_get && !tb[DEVLINK_PORT_FN_ATTR_STATE]) {

[Severity: Medium]
Can the new restriction be bypassed by including a state attribute in the
same request?  The condition skips the state query whenever
tb[DEVLINK_PORT_FN_ATTR_STATE] is present, regardless of the value being
requested or of the port's current state.

devlink_port_function_set() then applies the parameters before the state,
by design:

	attr = tb[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR];
	if (attr) {
		err = devlink_port_function_hw_addr_set(port, attr, extack);
	...
	/* Keep this as the last function attribute set, so that when
	 * multiple port function attributes are set along with state,
	 * Those can be applied first before activating the state.
	 */
	attr = tb[DEVLINK_PORT_FN_ATTR_STATE];

So for an already active mlx5 SF, a request such as

	devlink port function set <sf> hw_addr XX:.. state active

would run mlx5_devlink_port_fn_hw_addr_set() ->
mlx5_eswitch_set_vport_mac() against the live function, and the state set
afterwards is a no-op:

drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c:mlx5_sf_state_set() {
	...
	if (state == mlx5_sf_to_devlink_state(sf->hw_state))
		goto out;
	...
}

The same applies to caps and max_io_eqs combined with state active, and to
state inactive where the parameter is programmed while the function is
still active.  Is the intent to also cover the "parameters plus state" case,
for instance by checking the current state whenever any settable parameter
attribute is present?

[Severity: Low]
Does this also change the result of a request that sets nothing at all?
devlink_port_function_set() calls nla_parse_nested() and then
devlink_port_function_validate() before it looks at whether any of
tb[HW_ADDR], tb[CAPS], tb[MAX_IO_EQS] or tb[STATE] is present.

For a zero-length DEVLINK_ATTR_PORT_FUNCTION nest every tb[] entry is NULL,
so the new condition is true, ops->port_fn_state_get() is called (taking
mlx5's sf_state_lock), and an active SF now returns -EINVAL.  Previously
the function fell through every "if (attr)" block, sent the
DEVLINK_CMD_PORT_NEW notification and returned 0.  Would keying the check
on the presence of a settable attribute avoid that?

[Severity: Low]
The subject and the body say "prevent function configuration when port is
active" and "Reject port function parameter changes when the port is
active", but the check only applies to DEVLINK_PORT_FLAVOUR_PCI_SF.

VF and PF function ports also expose a function admin state, for example
mlx5_esw_pf_vf_dl_port_ops in
drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c:

	.port_fn_state_get = mlx5_devlink_pf_port_fn_state_get,
	.port_fn_state_set = mlx5_devlink_pf_port_fn_state_set,

and those keep the old behaviour.  Could the commit message (or a comment
here) say that the rule is limited to subfunctions and why?

> +		err = ops->port_fn_state_get(devlink_port, &state,
> +					     &opstate, extack);
> +		if (err)
> +			return err;
> +
> +		if (state == DEVLINK_PORT_FN_STATE_ACTIVE) {

[Severity: Medium]
This turns requests that used to succeed into -EINVAL for every PCI_SF
port.  Before this patch, hw_addr, roce and max_io_eqs could be set on an
active SF: mlx5_devlink_port_fn_hw_addr_set() calls
mlx5_eswitch_set_vport_mac() and mlx5_devlink_port_fn_max_io_eqs_set()
has no active-state rejection of its own.

Documentation/networking/devlink/devlink-port.rst still only recommends the
ordering:

	For subfunctions, this means user should configure port function
	attribute before activating the port function.

and documents max_io_eqs as settable for subfunctions without qualification.
Should the documentation be updated to say the ordering is now mandatory and
enforced with -EINVAL, and should the behaviour change be called out in the
commit message?

Since the policy lives in devlink core rather than in the driver, it also
becomes the rule for every current and future driver registering
DEVLINK_PORT_FLAVOUR_PCI_SF ports, including hardware that can change a
parameter while the function is active.  Was that intended?

> +			NL_SET_ERR_MSG(extack,
> +				       "port function parameters can't be configured when port is up");
> +			return -EINVAL;

[Severity: Low]
This isn't a bug, but the wording says "port is up" while the condition
tests the function state DEVLINK_PORT_FN_STATE_ACTIVE, which user space
and the documentation call active/inactive ("devlink port show" prints
"state active").  Would "function state is active" map better onto what
users can observe?

Also, the sibling rejections in the same function are capitalised and use
NL_SET_ERR_MSG_ATTR to point at the offending attribute:

	NL_SET_ERR_MSG_ATTR(extack, tb[DEVLINK_PORT_FN_ATTR_STATE],
			    "Function does not support state setting");

The offending attribute (hw_addr, caps or max_io_eqs) is known here too,
so could NL_SET_ERR_MSG_ATTR be used for consistency?

> +		}
> +	}
> +
>  	attr = tb[DEVLINK_PORT_FN_ATTR_CAPS];
>  	if (attr) {
>  		struct nla_bitfield32 caps;

[ ... ]
-- 
pw-bot: cr
