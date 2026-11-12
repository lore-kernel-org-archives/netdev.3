Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448948;
	b=CysA651nrsiTlSP7MMyUdeF/T0Np29Z0cQ4FBBiQlF4TgTpNzE3CKfHDX+8xbqtsDvWU
	 +q22WyRtrVzw0t8jRgTeve7gc63s+r7QJ4qE/bsCNNBYcvuEmPFrw3XMaJ9uUb+0NlsoG
	 m24XKtGJO9oMrrkIh12xbV1IBIQRkiy/ldD7Y4gHnmoA/qG5+lb+m7ZPrJRlK0vMzorSE
	 26q2DAChskP3FIThN2Xn7zmYh3CzHShWH1yKh39EGrM4YCCBaUQpoX6rN4dM2MGZ3KhKH
	 NEsGp/T1/3ikI60qpv0D6M5B+k1CkjePPqElh0yqb3jLfw4kfaWU4sj7OwDLiJp0GKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448948;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9IdyrQpxmQGcEQZC1T9QWsfjmpdwPjPqwtgtBfpGwVo=;
	b=AeUKIUzdb3iql2FoQaaPYq7xWopImztCJQPvKaeK5oXqV3Ajs/yA52b+hllFmjVIet69
	 HN38sxVboLTlKiiK8Z77aQ7BtboZ7lt0KGBVkEGc1u2rsJlRqquwuTsspGLfidDX2Mk12
	 eE+MmNRk9dA9ctatFHzGHc1Q+IozWUcvC7ZjImVg3JvFpBRHctpOlDYsXoFd3QlEIQ0Ts
	 cAXwrwuq5/mdBp0KWbiKP8zZmh0VixO9SF7KSEH9pTPO3VWvSXUxFwpoXlcRZ+5qmcrKn
	 xg1gjmoBcc1LeShoyiyyEaztuEHu4Hv09Cw1/8mgmglP4jG6S0rYZlQjtm9strpM32w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgLdAcB3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1E606A33F
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgLdAcB3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9251F00A05;
	Thu, 12 Nov 2026 02:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448947;
	bh=9IdyrQpxmQGcEQZC1T9QWsfjmpdwPjPqwtgtBfpGwVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CgLdAcB3imbbQDyw3gdNmFOFq2QL3p+GnlYOGqIr2feleMICp9Txse3H4kYJw8MnK
	 9BiaGcbGMCDAHy+db9Sh7ZLgWRpEKTOdz61miCcIGid5Ip7GkAimNZEecki4jQRT1C
	 9OPCPWll18Cs9UcqLdsb90VlmUTtjLP7LufxcBqIZv6tFzZOawjp4OrDfMsvVxqjnJ
	 ChfeJ2+p9q87caSNOZRFaqlWrLv8xA0qxolv9k5DuZs+U1EYcKlFSV0O7HeeTxE4wa
	 w7GivX9aZcPouCB4I3JbNg0Kzoa2cuT5cGVwGladM8SLQa5NmeyM29XjbfFeCOvgst
	 e8bcyM8VXjyKA==
Subject: Re: [PATCH net-next v7 2/2] netlink: specs: add ovs datapath and
 vport set operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org
Date: Thu, 12 Nov 2026 02:02:26 +0000
Message-ID: <179444894679.2199510.3381591546922833179@kernel.org>
In-Reply-To: <20261110174751.973464-3-houminxi@gmail.com>
References: <20261110174751.973464-3-houminxi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (3)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds `checks: max: 4096` to `masks-cache-size` in
  Documentation/netlink/specs/ovs_datapath.yaml.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  Documentation/netlink/specs/ovs_vport.yaml still declares the vport…
- [Low] This problem wasn't introduced by this patch, but the vport `get`
  do request in Documentation/netlink/specs/ovs_vport.yaml lists only…
- [Low] The new vport and datapath `set` ops in the specs declare no
  reply and no notification.

--

netlink: specs: add ovs datapath and vport set operations

This commit adds SET operations to the ovs_datapath and ovs_vport netlink
specs and adds more attributes to the NEW request lists. It also marks
new, del and set as uns-admin-perm and changes ifindex to s32 with a
minimum of 0. Finally it puts a maximum of 4096 on masks-cache-size and
marks all ops as dont-validate strict and dump.

> diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
> index f7b3671991e6c..b24dc1e03f46a 100644
> --- a/Documentation/netlink/specs/ovs_datapath.yaml
> +++ b/Documentation/netlink/specs/ovs_datapath.yaml
> @@ -102,13 +102,17 @@ attribute-sets:
>        -
>          name: masks-cache-size
>          type: u32
> +        checks:
> +          max: 4096

[Severity: Medium]
Is 4096 the right bound on every configuration? The commit message says:

  The masks cache size has an upper bound of 4096, which the attribute
  records.

However, datapath_policy in net/openvswitch/datapath.c computes the limit
from the percpu unit size:

	[OVS_DP_ATTR_MASKS_CACHE_SIZE] =  NLA_POLICY_RANGE(NLA_U32, 0,
		PCPU_MIN_UNIT_SIZE / sizeof(struct mask_cache_entry)),

and include/linux/percpu.h has:

#define PCPU_MIN_UNIT_SIZE		PFN_ALIGN(32 << 10)

struct mask_cache_entry is 8 bytes. That gives a limit of 4096 on 4K and
16K page kernels, 8192 with 64K pages (ppc64, arm64 with
CONFIG_ARM64_64K_PAGES) and 32768 with 256K pages. On those
configurations the spec would mark values that the kernel accepts as out
of range.

The spec also leaves out a second rule.
ovs_flow_tbl_masks_cache_resize() in net/openvswitch/flow_table.c rejects
any non-zero size that is not a power of two:

	if ((!is_power_of_2(size) && size != 0) ||
	    (size * sizeof(struct mask_cache_entry)) > PCPU_MIN_UNIT_SIZE)
		return -EINVAL;

Could the max check be dropped? Another option is to document the bound
as PCPU_MIN_UNIT_SIZE / 8, along with the zero-or-power-of-two rule.

[ ... ]

> diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
> index fa975f8821b6c..5a3ac4b03033a 100644
> --- a/Documentation/netlink/specs/ovs_vport.yaml
> +++ b/Documentation/netlink/specs/ovs_vport.yaml
> @@ -111,7 +111,9 @@ attribute-sets:
>          type: unused
>        -
>          name: ifindex
> -        type: u32
> +        type: s32
> +        checks:
> +          min: 0
>        -
>          name: netnsid
>          type: u32

[Severity: Low]
This isn't a bug introduced by this patch. Since ifindex is being matched
to the kernel policy here, should netnsid be fixed the same way? The spec
still declares netnsid as u32, but vport_policy in
net/openvswitch/datapath.c has:

	[OVS_VPORT_ATTR_NETNSID] = { .type = NLA_S32 },

and ovs_vport_cmd_fill_info() sends it with nla_put_s32():

		int id = peernet2id_alloc(net, net_vport, GFP_ATOMIC);

		if (nla_put_s32(skb, OVS_VPORT_ATTR_NETNSID, id))

peernet2id_alloc() can return NETNSA_NSID_NOT_ASSIGNED (-1). A YNL client
that follows the spec would read that as 4294967295.

[ ... ]

> @@ -150,6 +157,7 @@ operations:
>        name: get
>        doc: Get / dump OVS vport configuration and state
>        attribute-set: vport
> +      dont-validate: [strict, dump]
>        do: &vport-get-op
>          request:
>            attributes:

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The get
do request still lists only name. ovs_vport_cmd_get() uses the same
lookup_vport() helper as set and del, and that helper falls back to the
port number when the request has no name:

	} else if (a[OVS_VPORT_ATTR_PORT_NO]) {
		u32 port_no = nla_get_u32(a[OVS_VPORT_ATTR_PORT_NO]);

del and the new set op both list port-no. Should get list it too, so that
clients generated from the spec can look up a vport by port number?

> @@ -165,6 +173,25 @@ operations:
>              - netnsid
>              - upcall-stats
>        dump: *vport-get-op
> +    -
> +      name: set
> +      doc: |
> +        Modify an existing OVS vport. The vport is picked by name, or by
> +        port number when the request carries no name. An ifindex or options
> +        are rejected with -EOPNOTSUPP, and a type that differs from the
> +        vport's type with -EINVAL. The type only has to match; the one
> +        attribute that changes state is upcall-pid.
> +      value: 4
> +      attribute-set: vport
> +      dont-validate: [strict, dump]
> +      flags: [uns-admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - name
> +            - type
> +            - upcall-pid
> +            - port-no

[Severity: Low]
This is a pre-existing gap, and the existing new and del ops have it too.
The new set op here declares no reply or notification, and neither does
the datapath set op in ovs_datapath.yaml.

ovs_vport_cmd_set() builds a full vport message and sends it with
ovs_notify(), which calls genl_notify():

	err = ovs_vport_cmd_fill_info(vport, reply, genl_info_net(info),
				      info->snd_portid, info->snd_seq, 0,
				      OVS_VPORT_CMD_SET, GFP_KERNEL);
	BUG_ON(err < 0);

	ovs_unlock();
	ovs_notify(&dp_vport_genl_family, reply, info);

ovs_dp_cmd_set() does the same with OVS_DP_CMD_SET. These messages go to
the family's multicast group. They also go to the requester when
NLM_F_ECHO is set.

Should the set ops describe these messages, for example with a notify
entry that reuses the get reply, so generated clients can decode them?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110174751.973464-1-houminxi%40gmail.com
