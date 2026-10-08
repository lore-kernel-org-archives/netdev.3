Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080B30F927
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464909; cv=none; b=HR5/pWKPCvEVTCzjbLvMu1GBYFIZtwcerqhETdh96QENV3wreYn8FHMvEarrho6Hsxyd7oNVDQcrwkQFNMgkQk35ouP8rKodrUPepS6NY11ZrLTAYcvyi9WjFlm52sHZ+iE1PiwrU1cqv/VJwkJ64LmsjBFUrEBYRfMWnRo/Yfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464909; c=relaxed/simple;
	bh=FvTTw3c8YnEObnepAFxBPxaSe4Jxqfg7EaIeRDExcu4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nnfFAOSEVffaNM6pbXKSJnr9Tlgs+sWeobP9hNtBQTSAMI1cW8jJNXrvvW3P1DiArUs71LN/P1yPe4wEBTdTBM05yMLI6HcVOzoJgF+AWq1Mr1o3bgL9ukPnmizW/mhVf27j4qcNIkr/3yG5JfTLMLEbh+A1UPS2Fd9i0nOa/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfKa433W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfKa433W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4831F00893;
	Thu,  8 Oct 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791464908;
	bh=MRiRljMudPyKGe4bzGUVNpykzDW7hQs9REq+MjQnx8E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gfKa433W/aEjEwmWPzt03/F3LXP91a+QU1qHW3us5VWVsQg8h36HUKK9NiH5iXUdn
	 KH01uHGydKIAnswFAz6cYU+z8awfpoDLYfOLa+5R413enOWdPtxxsgMbV8b2NlawEk
	 eRMu1GYiDSHRRgm4sk90G5pQ2dJisdukAAZlW1v7C5XaG5y96J5WDsYSVR3NMbdR65
	 HLItHlGRQVWHtUc483wPdtm2eA+fazkRwnq2XlVHqcCs+GRoSwTQ3zZY5IqRjzblkf
	 xrGphyEd5W5OWUGksaKzYLBjNc1Q3/RLadYjkoMKNKSy9EMNxAsj24EHwa0uxLXn3F
	 iNZiW1Uuy324A==
Subject: Re: [PATCH net-next 2/2] netlink: specs: add ovs datapath and vport
 set operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Thu, 08 Oct 2026 13:08:27 +0000
Message-ID: <179146490766.434549.3687648802927081770@kernel.org>
In-Reply-To: <20261006130533.1620706-3-houminxi@gmail.com>
References: <20261006130533.1620706-3-houminxi@gmail.com>
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

- [Medium] The new vport `set` op in
  Documentation/netlink/specs/ovs_vport.yaml lists only name, type,…
- [Low] The new vport `set` op lists `options` as a request attribute,
  but ovs_vport_cmd_set() returns -EOPNOTSUPP whenever…
- [Low] The new datapath `set` doc says only that a missing user-features
  attribute is treated as zero and clears the features.

--

netlink: specs: add ovs datapath and vport set operations

This adds the set operation, which the kernel already registers, to the
ovs_datapath and ovs_vport YNL specs. It also marks new, del and set in
both specs with the uns-admin-perm flag.

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
Should the doc also say how per-cpu-pids depends on user-features?

In ovs_dp_change() the new features are assigned unconditionally. The
pids are applied only when that same request turns on per-cpu dispatch:

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

Take a set request with name and per-cpu-pids where user-features is
missing or lacks OVS_DP_F_DISPATCH_UPCALL_PER_CPU, for example because
per-cpu dispatch was already on. The kernel clears or changes the
features, ignores the pids without an error, and returns success.

The spec lists per-cpu-pids as if it could be set on its own. The doc
covers only the user-features half of this coupling.

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
accepts either the name or the port number plus the datapath ifindex
from the header:

net/openvswitch/datapath.c:lookup_vport() {
    ...
	} else if (a[OVS_VPORT_ATTR_PORT_NO]) {
		u32 port_no = nla_get_u32(a[OVS_VPORT_ATTR_PORT_NO]);
    ...
		dp = get_dp(net, ovs_header->dp_ifindex);
    ...
}

The UAPI comment for enum ovs_vport_attr in
include/uapi/linux/openvswitch.h also says that for requests other than
new, "dp_idx from the &struct ovs_header plus %OVS_VPORT_ATTR_PORT_NO
determine the vport". The del op in this same spec already lists
port-no.

YNL code generation builds the request struct from this list. Without
port-no, a generated client can only modify a vport by name, not by
datapath ifindex plus port number. Does that only partly fix the
problem the commit message describes, that "a YNL client could not
modify an existing datapath or vport"?

> +            - type
> +            - options

[Severity: Low]
Is it useful to list options here? ovs_vport_cmd_set() rejects it every
time:

net/openvswitch/datapath.c:ovs_vport_cmd_set() {
    ...
	if (a[OVS_VPORT_ATTR_OPTIONS]) {
		/* There are no vport types that support legacy options. */
		err = -EOPNOTSUPP;
		goto exit_unlock_free;
	}
    ...
}

The vport_policy entry is also marked "/* Unused. */".

The commit message says the kernel "rejects options", but the op doc
only says "Modify an existing OVS vport". Generated clients therefore
get a setter for an attribute that always fails with -EOPNOTSUPP.

Could options be dropped from the set request? Or could the doc say
that it is always rejected, and that a type different from the
vport's current type gets -EINVAL?

> +            - upcall-pid
>
>  mcast-groups:
>    list:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006130533.1620706-1-houminxi%40gmail.com
