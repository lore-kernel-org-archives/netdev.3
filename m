Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4639E164
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851587; cv=none; b=CQwRhVyd8T6qJbYobG4M1JbbR2QAITOOhU8njPT7KciHirKxG43Z73u3X/UZNmrDCozJO5yrJhCd6YXuxiDCyrBWlzPUAEJoQLA9t27yP7QOe0b01sIJq0u12HSvIeTR7ylyf+55wV6YlCwHMEAPbz6jhL2bYQa7Lh1nqhFh2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851587; c=relaxed/simple;
	bh=sW376UFZIfbNfo+e1wOakpqsWZ2cbLmU9Ogp+F0SS2Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIClGEgkPgAYH0YZoH0dGHvxsZWp/9j/SZgFkTw0/JffUDGkbTJHkOHXNM+lAYLomR2ARYBLwPuJCHER3uyCdc5BBCaylOXjtFgkHTg82+OsHqkd6Li/ZLWdY81/rUAnzDQ9xNj0SqVzsyd8JSPxVEd03o6tNNkRlRbkpLrYC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8337lWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8337lWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02331F00A3D;
	Tue,  8 Sep 2026 07:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851585;
	bh=dFPATcg2STmyE//8L1owFlsyz2DYjSwRmfZGCGv29O8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j8337lWC3LCNaaudQ2HW1GnBBXoRN+Cq1AYfRGt0dKV3pVbhKqT5+3fjjnPlEBjAE
	 4s0MEIvNtCoq+xUEmrwUjFQ1DVBhhOvvC9wv8+TGUzGDNMychg2t1pQGgZPCRmzH+V
	 m19KIPFVozH9gU4YBsfYHADxv/jVQlP2Cp4D2o3bQtkzOMyA4KrAxK+Z4UP09Z/i60
	 ZP2OdQuUAoShE09wG+e5i97/KEngEkIMD0oPjqbPbnFK1C71sAc+/7o+z0R+wDNobk
	 q8SXoH3FTpkbBwsChswwFF95ZkortIw4twWpbItjpbgfAWEDJztYb8zJdR9ZG4mdZP
	 tQ9+Xa/Cf6ing==
Subject:
 Re: [PATCH net-next 3/4] netlink: specs: dpll: pin-get has no dump filter
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, ivecera@redhat.com,
 jiri@resnulli.us, donald.hunter@gmail.com
Date: Tue, 08 Sep 2026 07:13:04 +0000
Message-ID: <178885158424.219967.5917321422649028592@kernel.org>
In-Reply-To: <20260904191023.3869690-4-kuba@kernel.org>
References: <20260904191023.3869690-4-kuba@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] Dropping the dump policy for DPLL_CMD_PIN_GET turns a
  previously accepted (and silently ignored) attribute into a hard…

Pre-existing issues:
- [Low] After this patch the two in-tree descriptions of the
  DPLL_CMD_PIN_GET dump disagree.

--

netlink: specs: dpll: pin-get has no dump filter

The pin-get op doc claimed a dump could be filtered by a target dpll and
that a do request takes a target dpll plus a target pin, neither of which
exists in the implementation. The patch drops the id attribute from the
pin-get dump request and rewords the doc, which also regenerates
drivers/dpll/dpll_nl.c so the dump op has no policy and no maxattr.

> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 93e546ba1f56d..e2ca4df5699ae 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -701,11 +701,9 @@ operations:
>        doc: |
>          Get list of pins and its attributes.
>  
> -        - dump request without any attributes given - list all the pins in the
> -          system
> -        - dump request with target dpll - list all the pins registered with
> -          a given dpll device
> -        - do request with target dpll and target pin - single pin attributes
> +        - dump request - list all the registered, available pins in the
> +          system, the request takes no attributes
> +        - do request with target pin - single pin attributes

[Severity: Low]
This isn't a bug introduced by this patch, but with the YAML wording now
saying "registered, available pins", does the prose in
Documentation/driver-api/dpll.rst end up contradicting it?

In the "Pin object" section it still says:

  It is also possible to list all the pins that were registered in the
  system with `dump` request of ``DPLL_CMD_PIN_GET`` command.

and in the "Netlink dump requests" section:

  The ``DPLL_CMD_DEVICE_GET`` and ``DPLL_CMD_PIN_GET`` commands are
  capable of dump type netlink requests, in which case the response is in
  the same format as for their ``do`` request, but every device or pin
  registered in the system is returned.

dpll_nl_pin_get_dumpit() does not emit every registered pin:

	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
				 ctx->idx) {
		if (!dpll_pin_available(pin))
			continue;

The same file is already inconsistent with itself elsewhere, where it
describes the command as "command to get pin info or dump list of
available pins". Would it make sense to fix the availability wording in
dpll.rst here too, since this series is about doc accuracy?

>        attribute-set: pin
>        flags: [admin-perm]
>  
> @@ -742,9 +740,6 @@ operations:
>              - measured-frequency
>  
>        dump:
> -        request:
> -          attributes:
> -            - id
>          reply: *pin-attrs
>  
>      -
> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
> index 3bdabbf2b9319..fa09b524a4a0f 100644
> --- a/drivers/dpll/dpll_nl.c
> +++ b/drivers/dpll/dpll_nl.c
> @@ -65,12 +65,7 @@ static const struct nla_policy dpll_pin_id_get_nl_policy[DPLL_A_PIN_TYPE + 1] =
>  };
>  
>  /* DPLL_CMD_PIN_GET - do */
> -static const struct nla_policy dpll_pin_get_do_nl_policy[DPLL_A_PIN_ID + 1] = {
> -	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
> -};
> -
> -/* DPLL_CMD_PIN_GET - dump */
> -static const struct nla_policy dpll_pin_get_dump_nl_policy[DPLL_A_PIN_ID + 1] = {
> +static const struct nla_policy dpll_pin_get_nl_policy[DPLL_A_PIN_ID + 1] = {
>  	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
>  };
>  

[ ... ]

> @@ -133,16 +128,14 @@ static const struct genl_split_ops dpll_nl_ops[] = {
>  		.pre_doit	= dpll_pin_pre_doit,
>  		.doit		= dpll_nl_pin_get_doit,
>  		.post_doit	= dpll_pin_post_doit,
> -		.policy		= dpll_pin_get_do_nl_policy,
> +		.policy		= dpll_pin_get_nl_policy,
>  		.maxattr	= DPLL_A_PIN_ID,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> -		.cmd		= DPLL_CMD_PIN_GET,
> -		.dumpit		= dpll_nl_pin_get_dumpit,
> -		.policy		= dpll_pin_get_dump_nl_policy,
> -		.maxattr	= DPLL_A_PIN_ID,
> -		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> +		.cmd	= DPLL_CMD_PIN_GET,
> +		.dumpit	= dpll_nl_pin_get_dumpit,
> +		.flags	= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>  	},

[Severity: Medium]
Is this a uAPI regression for callers generated from the previously
published spec?

With no .policy and no .maxattr on this dump entry of dpll_nl_ops[],
genl_get_cmd_split() -> genl_op_fill_in_reject_policy_split() substitutes
the reject-all policy:

net/netlink/genetlink.c:genl_op_fill_in_reject_policy_split() {
	if (op->policy)
		return;

	op->policy = genl_policy_reject_all;
}

and genl_start() -> genl_family_rcv_msg_attrs_parse() then takes the
maxattr == 0 path:

	} else {
		/* Reject all policy, __nlmsg_parse() will just validate */
		attrbuf = NULL;
	}

	err = __nlmsg_parse(nlh, hdrlen, attrbuf, ops->maxattr, ops->policy,
			    validate, extack);

dpll's generated ops do not set GENL_DONT_VALIDATE_DUMP_STRICT, so any
attribute present in a pin-get dump request is now rejected with -EINVAL.
Before this patch the dump op carried dpll_pin_get_dump_nl_policy with
maxattr DPLL_A_PIN_ID, so a request carrying DPLL_A_PIN_ID parsed fine and
dpll_nl_pin_get_dumpit() returned the whole pin list.

The commit message acknowledges this:

  Same caveat as for pin-set: sending DPLL_A_PIN_ID in a pin-get dump now
  fails validation instead of being ignored.

Any existing binary built from the earlier dpll.yaml that fills in the id
field of the pin-get dump request stops working after a kernel upgrade.
Would keeping the dump policy (so the attribute stays accepted and
ignored) while dropping it from the published spec avoid breaking those
callers? The command does require CAP_NET_ADMIN, so the exposure is
limited to privileged callers issuing a dump that never filtered anything.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904191023.3869690-1-kuba%40kernel.org
