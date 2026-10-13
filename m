Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FD389104
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877100; cv=none; b=aXZDnyWwc1L3ck2AfRGTxGF26ZfLWE+1DB5dyO3O7vOJgvssRi1DBbOjMo+ySgg1h26gQ6OgMCknSbpUEpQ9ttWscHtK6h0UxWxgv6o6CSiFQ1MoP9z57dhulaYdlJqKAk9la9d0qgOKWOqwXkLp3vskk4dyO3l/I45+fcjN9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877100; c=relaxed/simple;
	bh=ruyKG4VHR2v0OChl1IeIVyGUXcSRWNzumPPNvj+moTc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKQ/dUx9L4eS1ZGLnPR8W4G+ymJ2rLIf3yUZN55Hx7IGF1z8Ip8r5KSA/4vCb6rQnjJ6soH/DBGgTS6SyFusw605Y5bqHQSbtZfEV+kLvmALdArDG33ptEEmWgX5+irB0vNvWBigJBho89PhK+p2QIvi9ci2V3RHAKeVWOBh3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKKLYhhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKKLYhhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC71F00898;
	Tue, 13 Oct 2026 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791877099;
	bh=n3nmHFaTma5B/vTzHvzj0M7bv57NF5xz+ZcepdNNJl4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AKKLYhhT5Pon0evytIafLVAKxmiHfwKz3SS796KOlIMB0dCxrMu0uU4NvVSeTeuXG
	 EBabGOA/ZUYMrWjQvR+OkOlPEVtyV9NC0wBhSoVf5b32ig45E7pxLp3r6N4z+Ym1eI
	 fD3VECFeIXMh7ULOVkHeTs2QJajWmKsPduZibW9YyW7JiY8pfauKOBJXwwLBUgJFiN
	 6f99VcgmWNkME+c/0Hjw5Z/Y+VDzybNxWtENeiIH/2eAEWQtQKopgMXhw4QiynwCFc
	 UMn9AV4RZ7DT//8jWtBgjzpG8mVglP0XtsjV5u10tq4ODxtyTt4Mu2F8LIWPltj+Nz
	 dQRPXPKDxwHTA==
Subject: Re: [PATCH net-next v2 2/2] netlink: specs: add ovs datapath and
 vport set operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 13 Oct 2026 07:38:18 +0000
Message-ID: <179187709857.434549.12932199387917585407@kernel.org>
In-Reply-To: <20261012065552.2426415-3-houminxi@gmail.com>
References: <20261012065552.2426415-3-houminxi@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `set` operation in
  Documentation/netlink/specs/ovs_vport.yaml lists only [name, type,…
- [Low] The new ovs_vport `set` operation lists `options` as a request
  attribute, but ovs_vport_cmd_set() always fails with -EOPNOTSUPP when…
- [Low] The datapath `set` doc in
  Documentation/netlink/specs/ovs_datapath.yaml warns that a missing…

--

netlink: specs: add ovs datapath and vport set operations

This commit adds the missing set operations to the ovs_datapath and
ovs_vport netlink specs. It also marks the new, del and set operations of
both families with the uns-admin-perm flag.

> diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
> index f7b3671991e6c..9c33d6a2f05db 100644
> --- a/Documentation/netlink/specs/ovs_datapath.yaml
> +++ b/Documentation/netlink/specs/ovs_datapath.yaml

[ ... ]

> @@ -149,10 +150,27 @@ operations:
>        doc: Delete existing OVS data path
>        value: 2
>        attribute-set: datapath
> +      flags: [uns-admin-perm]
>        do:
>          request:
>            attributes:
>              - name
> +    -
> +      name: set
> +      doc: |
> +        Modify an existing OVS data path. The kernel treats a missing
> +        user-features attribute as zero and clears the previously set
> +        features.
> +      value: 4
> +      attribute-set: datapath
> +      flags: [uns-admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - name
> +            - user-features
> +            - masks-cache-size
> +            - per-cpu-pids

[Severity: Low]
Should the doc also say that per-cpu-pids depends on user-features in the
same request?

In ovs_dp_change(), the new features are stored first, and the pids are
only applied when the per-CPU dispatch bit is set:

net/openvswitch/datapath.c:ovs_dp_change() {
    ...
	dp->user_features = user_features;

	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
		/* Upcall Netlink Port IDs have been updated */
		err = ovs_dp_set_upcall_portids(dp,
						a[OVS_DP_ATTR_PER_CPU_PIDS]);
    ...
}

Consider a client that sends only name and per-cpu-pids to refresh the
per-CPU upcall pids. Per-CPU dispatch gets turned off, the pids are
ignored, and the request still returns success.

Could the doc state that per-cpu-pids only takes effect when
dispatch-upcall-per-cpu is set in user-features in the same request?

> diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
> index fa975f8821b6c..63a0a41a11997 100644
> --- a/Documentation/netlink/specs/ovs_vport.yaml
> +++ b/Documentation/netlink/specs/ovs_vport.yaml

[ ... ]

> @@ -165,6 +167,19 @@ operations:
>              - netnsid
>              - upcall-stats
>        dump: *vport-get-op
> +    -
> +      name: set
> +      doc: Modify an existing OVS vport
> +      value: 4
> +      attribute-set: vport
> +      flags: [uns-admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - name

[Severity: Medium]
Should port-no be in this request list as well?

ovs_vport_cmd_set() finds the vport with lookup_vport(). That function
accepts either a name, or a port number together with dp_ifindex from the
fixed header:

net/openvswitch/datapath.c:lookup_vport() {
    ...
	} else if (a[OVS_VPORT_ATTR_PORT_NO]) {
		u32 port_no = nla_get_u32(a[OVS_VPORT_ATTR_PORT_NO]);
		...
		dp = get_dp(net, ovs_header->dp_ifindex);
		...
	} else
		return ERR_PTR(-EINVAL);
}

The del operation in this spec goes through the same lookup_vport() and
lists port-no. Without port-no here, the generated YNL request struct for
set has no port_no member.

That means YNL clients can only select the vport by name for set, even
though the kernel also supports lookup by datapath ifindex plus port
number.

> +            - type
> +            - options

[Severity: Low]
Is options meant to be listed here? ovs_vport_cmd_set() rejects it every
time it is present:

net/openvswitch/datapath.c:ovs_vport_cmd_set() {
    ...
	if (a[OVS_VPORT_ATTR_OPTIONS]) {
		/* There are no vport types that support legacy options. */
		err = -EOPNOTSUPP;
		goto exit_unlock_free;
	}
    ...
}

vport_policy also marks OVS_VPORT_ATTR_OPTIONS as unused.

Type can't really be modified either. It is only accepted when it matches
vport->ops->type, and any other value returns -EINVAL.

The commit message says "the kernel rejects a type change and rejects
options", but the spec's doc ("Modify an existing OVS vport") says neither.
Could options be dropped from the list, and the doc say that type has to
match the existing vport type?

> +            - upcall-pid
>  
>  mcast-groups:
>    list:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012065552.2426415-1-houminxi%40gmail.com
