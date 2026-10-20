Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527884;
	b=3uk2WtrbCCLngawVjkDHAOeN0boekXEP/Zr5iSOILaKTKse3nHhpaMOqScQkNPJ+7KIA
	 //RuMI6IVCokg/pQjszgJ9DlhxAybuNJiT168gNlje1wcYIJZqi7Tqwb38t2wmjU99Onc
	 FjPJPQhS61NkRlazlyfnNoQfOS2Vs+qi6XU/gdkZi/WzqF/HLyxER5B5Cd6nNGIwoWyBQ
	 /PzA97L70MpNNfJcyu+xM7idXuizjIidIjsKyhXB0baEwQ4kZoWocD+ZH4UN4sjW23kHd
	 1MnNWB0Qwvkun/8hS+rfNRBw5l1dG5nsDevXwHjLehZt4nxpEfSNH3IVbM388iV/wMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s3oS6tKV9PMu84CKn1ldvKSagsp1saZxNsRcHfBGkEs=;
	b=uzQUjsSzy/z6Cjb8/BQoXZYHSIZ0oEaXI8yxcPRt6QpYAbuGDeljDSGLj7PgAbxAEArc
	 xdEvTFYWq8YAqrJyjxyF3PDNzcAydoFTqNIf3FduzZadiMc1Gfj9fXqbQJPfzMpiTr6wo
	 BS6Ssq5NnGBm1ar8RJyXQbpfJ6O0Uf2k5X1FhUSAjDmqnKNLC6nS5x7t1PZ2BjTPXoFd/
	 LZKMg0RddWunZCjnwvQ/F+rGh1kcysB4e3ZgfsyXlDFTvPtocUzLRcNcFCRpl8MT2VLd4
	 xFMRhGOMzsGGURmHQ907M/QmfGpkBLNSUjjSbppWi81U2cLvv5M27PMbfecJJCD5RxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tq/JhqMM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8F606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tq/JhqMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9551F000CA;
	Tue, 20 Oct 2026 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527883;
	bh=s3oS6tKV9PMu84CKn1ldvKSagsp1saZxNsRcHfBGkEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tq/JhqMMcI0abETR/oX6p6phzzCXLTgWsSkfmbLFIVRQsAK7zyqX4iHXIWcZw6ZUn
	 vvpDxpBvICrd/2z3omBNHg2PKjNBc5YuDHzOgX7hbp4f0WlKHBtSGWoMPhjGaGlazK
	 lmHPPLPfyOh48DGPRSqqeaRw00e1EoRRVNzgCmJi+AjOtpgKK4vUhHnkqZhLMqJhj6
	 NhJtxpmUEST/devTTsxeMO4yIe+4YhL2LIQJTs+zOhb7erzzCxW3DUD5k36smeG3W0
	 2pQDwkYvjoqgH2soio+QDCrKqweR0vtZPp1aizTxG+MwPCRjckjLZRgM8UouiZtYGv
	 LkxcAHZ4XdHyg==
From: Jakub Kicinski <kuba@kernel.org>
To: houminxi@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v3 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Tue, 20 Oct 2026 13:24:42 -0700
Message-ID: <20261020202442.1012753-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015024132.698658-3-houminxi@gmail.com>
References: <20261015024132.698658-3-houminxi@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
netlink: specs: add ovs datapath and vport set operations

This adds the SET operation (cmd value 4) to the ovs_datapath and
ovs_vport YNL specs, so YNL clients can modify an existing datapath or
vport. It also adds the uns-admin-perm flag to the new, del and set
operations of both families, matching GENL_UNS_ADMIN_PERM in the kernel.

> diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
> index f7b3671991e6..9c33d6a2f05d 100644
> --- a/Documentation/netlink/specs/ovs_datapath.yaml
> +++ b/Documentation/netlink/specs/ovs_datapath.yaml

[ ... ]

> @@ -149,10 +150,27 @@ operations:

[ ... ]

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
Should this doc also say that per-cpu-pids only takes effect when the
same request sets OVS_DP_F_DISPATCH_UPCALL_PER_CPU in user-features?

From ovs_dp_change() in net/openvswitch/datapath.c:

	u32 user_features = 0, old_features = dp->user_features;
	...
	dp->user_features = user_features;

	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU &&
	    a[OVS_DP_ATTR_PER_CPU_PIDS]) {
		/* Upcall Netlink Port IDs have been updated */
		err = ovs_dp_set_upcall_portids(dp,
						a[OVS_DP_ATTR_PER_CPU_PIDS]);

A SET request with only name and per-cpu-pids, or with user-features that
lack that flag, still succeeds. The pids are dropped without an error, and
per-CPU upcall dispatch is turned off too.

The kernel behaves this way without this patch. The new op doc describes
the related user-features quirk but not this one.

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. Neither
of the new set ops describes the notification the kernel sends.

ovs_dp_cmd_set() and ovs_vport_cmd_set() both build a full object message
with cmd OVS_DP_CMD_SET / OVS_VPORT_CMD_SET and multicast it:

net/openvswitch/datapath.c:ovs_vport_cmd_set() {
    ...
	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
				      info->snd_portid, info->snd_seq, 0,
				      OVS_VPORT_CMD_SET, GFP_KERNEL);
	BUG_ON(err < 0);

	ovs_unlock();
	ovs_notify(&dp_vport_genl_family, reply, info);
    ...
}

The set ops in the specs have only a do request, with no reply and no
notify. C codegen therefore generates no parser for these cmd 4 messages.
The existing new and del ops in both specs have the same gap, although
their handlers also send notifications.

The patch does help Python YNL here. handle_ntf() looks up the op with
rsp_by_value[cmd], so cmd 4 notifications can now be decoded with the op's
attribute set.

Could these notifications be described in the specs, either here or in a
follow-up?

> diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
> index fa975f8821b6..63a0a41a1199 100644
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

[Severity: Low]
Should port-no be listed here too?

ovs_vport_cmd_set() finds its target with lookup_vport(). That function
accepts either OVS_VPORT_ATTR_NAME or OVS_VPORT_ATTR_PORT_NO, using the
dp_ifindex from the fixed header:

net/openvswitch/datapath.c:lookup_vport() {
    ...
	} else if (a[OVS_VPORT_ATTR_PORT_NO]) {
		u32 port_no = nla_get_u32(a[OVS_VPORT_ATTR_PORT_NO]);
		...
		dp = get_dp(net, ovs_header->dp_ifindex);
		...
		vport = ovs_vport_ovsl_rcu(dp, port_no);
    ...
}

The del op in this spec already lists port-no. YNL C codegen only
generates setters for the attributes an op lists. So the generated
ovs_vport_set_req has no port_no setter, and a C client can only pick the
vport by name. Python YNL is not affected because it encodes from the
whole attribute set.

> +            - type
> +            - options

[Severity: Low]
Is options meant to be listed for set? ovs_vport_cmd_set() rejects every
request that carries it:

	if (a[OVS_VPORT_ATTR_OPTIONS]) {
		/* There are no vport types that support legacy options. */
		err = -EOPNOTSUPP;
		goto exit_unlock_free;
	}

vport_policy also marks OVS_VPORT_ATTR_OPTIONS as "/* Unused. */". Any
request built with the generated options setters for this op will fail
with EOPNOTSUPP.

type is similar. The kernel only checks it for equality and cannot change
it:

	if (a[OVS_VPORT_ATTR_TYPE] &&
	    nla_get_u32(a[OVS_VPORT_ATTR_TYPE]) != vport->ops->type) {
		err = -EINVAL;

The commit message says "The kernel rejects a type change and rejects
options". The spec, with its doc "Modify an existing OVS vport", says
neither.

Could options be dropped from this request, or could the doc mention
these limits?
