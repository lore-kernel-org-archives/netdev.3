Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CA3E49FD
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464908; cv=none; b=tQJkC4G/69vGnJlQL70/a83ccOBqrocSqOm0ojExPUJaQoME6qVEuo8GQshOrZwjiOyivNmgmoSyz737QtnE8xmrwhnCshmSbp32ME7dfIo1QqCxjKqYVGZCDYiai8tWOkIsvVl8CRbnmFhR2cyso8lXVyzcHxjU7qHKqypW8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464908; c=relaxed/simple;
	bh=rrCdbGy2HWi77U6J+dFLIXwWOT9FIhvwTJIBF6aMefU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T7xVSUHqIDKNDRP1A5b8fHczQXYmFUduNKCUeZcDUV3cCPuqZqvSyotuD0eLr6yif9N6PsJYXuTiJRaWlUTP4G3xPv9TVV0vASlpVJQZsLACoPHzlyBlC0bbDfpuoZK+f3HWmB4P86a5sotRAOphx0wyc/CcCMgFtl+qkp7cg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT7nG5K0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT7nG5K0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9681F000FF;
	Thu,  8 Oct 2026 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791464907;
	bh=xH17uW5oA5P29CQTXJgT98vWYbSkAQUrujAA7n+afLU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZT7nG5K0DN1O6ukBrDjACM5FqWkMrAj4cuv1Ojhz2CMdvRwTbnitKSV0p7qQVPY0Q
	 Pl8IEg1FNHSqIgTX52KUCv/xApDvZkQULI+Ne0gCFF0HAevIy6eIPAzCKRJGpWXtje
	 c2XwPHQk602dE/Xhru82WxT1UEI4sMZYjPWp9G2Fm7/Cw3Bp00ZV0DBL6z+pepho4/
	 yUCZEtZ7PE5bO2CdwJIJo3CEbITa27Ocns8aFnvTkROcfiCwSC2PIqWlJZXM2sB5FM
	 3rwRUSoj2b+bqZrvNMraMn4qfKzZ9xWJ1UH5XHy64nQCljBg7EDsEDXpkiYdERvres
	 qSvKxTIYEmH+Q==
Subject:
 Re: [PATCH net-next 1/2] netlink: specs: add ovs_flow del and set operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Thu, 08 Oct 2026 13:08:26 +0000
Message-ID: <179146490651.434549.2629505929025835263@kernel.org>
In-Reply-To: <20261006130533.1620706-2-houminxi@gmail.com>
References: <20261006130533.1620706-2-houminxi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `set` op in Documentation/netlink/specs/ovs_flow.yaml
  lists `probe` as a request attribute.
- [Low] The new `del` op in Documentation/netlink/specs/ovs_flow.yaml
  lists only key, ufid and ufid-flags.
- [Low] The new `del` and `set` ops in ovs_flow.yaml declare only
  `do.request`: no `reply`, and no op with `notify: del`/`notify: set`.
- [Low] The `set` op doc says: "The kernel rejects the request with
  -EINVAL when it carries neither a key nor a ufid." Together with the…

--

netlink: specs: add ovs_flow del and set operations

This patch adds del and set operations to the ovs_flow YNL spec. It also
marks new, del and set with uns-admin-perm. It lists the request
attributes each command reads.

> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 951837b72e1d2..87984bf1fac4b 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml

[ ... ]

> @@ -995,6 +996,36 @@ operations:
>              - ufid
>              - mask
>              - actions
> +    -
> +      name: del
> +      doc: Delete one flow, or every flow in the data path
> +      value: 2
> +      attribute-set: flow-attrs
> +      flags: [uns-admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - key
> +            - ufid
> +            - ufid-flags

[Severity: Low]
Should probe be listed here too? ovs_flow_cmd_del() reads it:

net/openvswitch/datapath.c:ovs_flow_cmd_del() {
	...
	bool log = !a[OVS_FLOW_ATTR_PROBE];
	bool ufid_present;

	ufid_present = ovs_nla_get_ufid(&ufid, a[OVS_FLOW_ATTR_UFID], log);
	...
}

log is then passed to ovs_nla_get_ufid() and ovs_nla_get_match().

The commit message says "Name the attributes each command reads", and the
set op in this patch does list probe.

C YNL only generates setters for request attributes that are listed. As a
result, a C client cannot mark a delete as a feature probe to suppress
the kernel's error logging.

[Severity: Low]
Neither del nor set describes a reply or a notification. Does the kernel
send messages for these commands that the spec doesn't cover?

ovs_flow_cmd_del() uses ovs_flow_cmd_fill_info() to build an
OVS_FLOW_CMD_DEL message. It carries the deleted flow's key, ufid, mask,
stats, actions, used and tcp-flags.

ovs_flow_cmd_set() builds an OVS_FLOW_CMD_SET message with
ovs_flow_cmd_build_info(). Both handlers send through ovs_notify(), gated
by ovs_must_notify():

net/openvswitch/datapath.c:ovs_must_notify() {
	return info->nlhdr->nlmsg_flags & NLM_F_ECHO ||
	       genl_has_listeners(family, genl_info_net(info), group);
}

A client may set NLM_F_ECHO to get the final stats of a deleted flow, or
subscribe to the ovs_flow mcast group. In both cases the spec gives it
nothing to decode these messages with.

The existing new op and the ovs_datapath and ovs_vport specs have the
same gap, so this follows existing practice in the OVS specs. Still, the
new ops describe less than the kernel sends. Could a reply or notify
description be added for del and set?

> +    -
> +      name: set
> +      doc: |
> +        Modify an existing flow. The kernel rejects the request with
> +        -EINVAL when it carries neither a key nor a ufid.

[Severity: Low]
Is this doc complete? The request list below includes both ufid and
actions, so the doc reads as though a ufid alone is enough for any set.

After the key/ufid check, ovs_flow_cmd_set() calls
ovs_nla_init_match_and_action(). That function rejects actions without a
key, even when a ufid is present:

net/openvswitch/datapath.c:ovs_nla_init_match_and_action() {
	...
	if (a[OVS_FLOW_ATTR_ACTIONS]) {
		if (!a[OVS_FLOW_ATTR_KEY]) {
			OVS_NLERR(log,
				  "Flow key attribute not present in set flow.");
			error = -EINVAL;
			goto error;
		}
	...
}

A set that carries only a ufid works for stats or clear updates. One that
replaces actions always gets -EINVAL. Could the doc say that a key is
required when actions are supplied?

> +      value: 4
> +      attribute-set: flow-attrs
> +      flags: [uns-admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - key
> +            - ufid
> +            - mask
> +            - actions
> +            - ufid-flags
> +            - clear
> +            - probe

[Severity: Medium]
Should probe be declared as type: flag in flow-attrs? The attribute set
currently has:

        name: probe
        type: binary

The kernel policy treats it as a flag:

net/openvswitch/datapath.c:flow_policy[] = {
	...
	[OVS_FLOW_ATTR_CLEAR] = { .type = NLA_FLAG },
	[OVS_FLOW_ATTR_PROBE] = { .type = NLA_FLAG },
	...
}

validate_nla() in lib/nlattr.c rejects an NLA_FLAG attribute that carries
any payload:

	case NLA_FLAG:
		if (attrlen > 0)
			goto out_err;

Before this patch no op listed probe in a request, so the mismatch was not
visible. Now that set lists it, C YNL codegen will emit a pointer plus
length binary setter for probe. Any non-empty payload makes the whole
OVS_FLOW_CMD_SET fail policy validation with -EINVAL.

In Python YNL, passing "probe": true goes to the binary branch of
_add_attr() in tools/net/ynl/pyynl/lib/ynl.py. That branch raises
YnlException('Unknown type for binary attribute ...'), while the flag
branch would accept the value.

Could probe be changed to type: flag, the same as clear?

>  
>  mcast-groups:
>    list:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006130533.1620706-1-houminxi%40gmail.com
