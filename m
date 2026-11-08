Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141570;
	b=fbDV/3EevdMt/CN/+OoObp//MjhFaeU03znKgOh5HpJsUGaLlWUL3fviuGhiA9hIiTqh
	 6o0/DKWfo5mHnFT3ITDpd3DEjz/RLfQs8Ex5cxAECwyEnTkDC2EZBfs1L1dolLZf3Skhi
	 vhZ8BWenYJg9NCMXhyPB3kFVUhhvtCzcM1Ej0GUu6YYKtL8AF116lIJqUtz/t+OyZuZbD
	 IHb3naY26Hyk1SdmlqGznc4ah1hyQpZCw1keq8NHMCNyqb3H+JlFEyYpqtexxEjjeFnGA
	 TZ3ioRG1y5iD+BZEurtacEq42hG9zCAK5MG2mXM99yaFlUrADwy9qlA7BE//ceuOVwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141570;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mM6DVwCqDOpbkvQNO2LJaVej93mzjTfWGXqKWxW9Pm0=;
	b=D582krLR9ypkRZjunufjVGNLrIFHZRt1PIcPkVKkbcYNwTbrPU6eTM00QwsxgRzJxKtF
	 fGi3c4WM7sJe34w2jbSha1f7t7H4AdtQjLNMBJsHQ5geueZh3nX2O5QUI9cAoEyG39CBs
	 qd+42uSlRq4LPKQhqOyGEDEzPiL0WhQaD2Bqyvs5s4/fuZ/XWyZr1kncUpymhMhPoyefR
	 Y6NKQ3w+QV17ktYCZ+zF0vGUlE8Rt1OzjAPcnGhjhWAzCFvfJHDVfc1JMjDFlecMn3qLu
	 2kaO/wTgbYDs4tpcXtACWE9IwjWPaPeDu4SZiD3Px2fjT3V/RemIaRfY0TI/ERiHjqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVW39Mlx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A53606A32A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVW39Mlx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDF21F008A1;
	Sun,  8 Nov 2026 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141569;
	bh=mM6DVwCqDOpbkvQNO2LJaVej93mzjTfWGXqKWxW9Pm0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FVW39MlxmAMUesAyTlkebNAGtN445AhGLpKmXc05PH6EgprzfmAEqcgRHHkLEj+EN
	 qTpaAFKcIl+jR9TN8V6VNtgZpAcSj1DefM7jb9kW/Twukpvp5z5oPc1RClwkEJuk1o
	 sfLNN0ej5qTazrvj4E8VFb+mHfKAtNLw5zh8YBwH/q7n/qn+54hMlM9SI54X7FDF3P
	 O8ltkkVr6CUaaZRP+eL7wVOONEgaqNK6sMPw/u2kAGEipgPxtbCHk2+zGIPmbXkoRj
	 Lnd+gqvElfS5/sJdaU++nZTT9HgE7Ap6sSYfQK8ATgkqO4TZVhCOB+gcE3GNfCe6nr
	 QhbbLvvJ5C/BQ==
Subject: Re: [PATCH net-next v6 2/2] netlink: specs: add ovs datapath and
 vport set operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dev@openvswitch.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org
Date: Sun, 08 Nov 2026 12:39:28 +0000
Message-ID: <179414156884.994134.5015506800657224516@kernel.org>
In-Reply-To: <20261107120647.874906-3-houminxi@gmail.com>
References: <20261107120647.874906-3-houminxi@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new vport `set` operation in
  Documentation/netlink/specs/ovs_vport.yaml lists `options` and…
- [Low] The commit message says ifindex is declared as s32 with `checks:
  min: 0` because 'A generated client would otherwise offer a setter for…

--

netlink: specs: add ovs datapath and vport set operations

This adds the SET operation to the ovs_datapath and ovs_vport netlink
specs. It also adds attributes to the datapath NEW request, marks
new/del/set as uns-admin-perm and marks the ops as dont-validate strict
and dump. The ifindex attribute moves from u32 to s32 with a min: 0 check
in both families.

> diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
> index fa975f8821b6c..16b21c42cac8c 100644
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

[Severity: Low]
The commit message says:

  The ifindex attribute is signed in both policies, which read it with
  nla_get_s32_default() and reject anything below zero, so declare it as
  s32 with a minimum of 0 rather than u32. A generated client would
  otherwise offer a setter for values the kernel rejects with -ERANGE.

Does the min: 0 check change anything a generated client offers? In
tools/net/ynl/pyynl/ynl_gen_c.py, checks are only used to build kernel
policies:

        # Classic families have some funny enums, don't bother
        # computing checks, since we only need them for kernel policies

The OVS kernel policies are not generated from these specs. They are
hand-written in net/openvswitch/datapath.c and already contain:

	[OVS_DP_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),
	...
	[OVS_VPORT_ATTR_IFINDEX] = NLA_POLICY_MIN(NLA_S32, 0),

So min: 0 has no effect anywhere. The generated s32 setter still accepts
every negative value. Those are the same 32-bit patterns (0x80000000 to
0xffffffff) that the old u32 setter could send, so a generated client
still offers the same rejected values as before.

There is also a side effect the message doesn't mention. The vport ifindex
attribute is part of the GET reply, and ovs_vport_cmd_fill_info() still
sends it as unsigned:

	    nla_put_u32(skb, OVS_VPORT_ATTR_IFINDEX, vport->dev->ifindex))

With this change, the ifindex member of the generated ovs_vport_get_rsp
struct changes from __u32 to __s32. Nothing changes on the wire, since
both types are 4 bytes and dev->ifindex is always positive.

Could the commit message give the actual benefit, which is matching
NLA_S32 and nla_get_s32_default() in the request path? Could it also
mention the type change in the reply? The same rationale also appears for
the ovs_datapath.yaml change.

[ ... ]

> @@ -165,6 +172,27 @@ operations:
>              - netnsid
>              - upcall-stats
>        dump: *vport-get-op
> +    -
> +      name: set
> +      doc: |
> +        Modify an existing OVS vport. The vport is picked by name or by
> +        port number. The kernel rejects an ifindex with -EOPNOTSUPP, before
> +        it looks at the type or the options. It rejects a type that differs
> +        from the vport's type with -EINVAL, and rejects options with
> +        -EOPNOTSUPP. The only attribute that changes state is upcall-pid.
> +      value: 4
> +      attribute-set: vport
> +      dont-validate: [strict, dump]
> +      flags: [uns-admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - name
> +            - type
> +            - options
> +            - upcall-pid
> +            - port-no
> +            - ifindex

[Severity: Low]
Should options and ifindex be in the set request list? The kernel always
rejects both of them:

net/openvswitch/datapath.c:lookup_vport() {
	if (a[OVS_VPORT_ATTR_IFINDEX])
		return ERR_PTR(-EOPNOTSUPP);
    ...
}

net/openvswitch/datapath.c:ovs_vport_cmd_set() {
    ...
	if (a[OVS_VPORT_ATTR_OPTIONS]) {
		/* There are no vport types that support legacy options. */
		err = -EOPNOTSUPP;
		goto exit_unlock_free;
    ...
}

The vport family is code-generated (tools/net/ynl/Makefile.deps has
CFLAGS_ovs_vport). That means ynl_gen_c.py will emit set request setters
for ifindex and for the options nest. Any request that uses them can only
fail with -EOPNOTSUPP.

This seems to go against the reason the commit message gives for retyping
ifindex: "A generated client would otherwise offer a setter for values the
kernel rejects". The get and del ops go through the same lookup_vport(),
and this patch leaves ifindex out of them.

Would a request list of name, port-no, type (used as a match check) and
upcall-pid better describe what the kernel accepts?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107120647.874906-1-houminxi%40gmail.com
