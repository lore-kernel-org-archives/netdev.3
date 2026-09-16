Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142D4E50C2
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586126; cv=none; b=f2Uj17em4Mm8+Sflm3hJRy9cMHZfxWkf31XWWvzFwSY8Fg5K/9+AbrIQpkh16YEUXBqYtDLbCKRCYAb0tXKA1cgNjE1J3mNgyAedQIZENOy6+yVMpXMZHi8PMUnkvYCe/ti4mE/+vjUPB4jWUgSNikZmHpQrZw+gNa7kzTYZYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586126; c=relaxed/simple;
	bh=59wiTuaAyp8zU3H7+BKsWVWzTT3nAgGLw8Qn58d8Ouo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJy3MntbGJvsN6F5CbrwWFgKEKj4Obut63z3v25RzFnfR2sXveaX+564NmJEX5T356sjwJPKblSlv/PJbRxZ4S1SS3TncxOFWnk6Vbf5QQ4KjVVYeCVOudUILXcqCSQHgZTdtsqURMZnsBMbDvLweI4RZwpurqwbXZG3Y8wx91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOrNPS0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOrNPS0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521B11F00893;
	Wed, 16 Sep 2026 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586120;
	bh=9V8AuP0exLhzxb1aQU3ZULhcqYMtF5fci1RwKvCTKXM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KOrNPS0v6LAcYYFnpRisiyDK9x3f1rjyKz/ICagSkynuqU+z/t8evgncHgJf6gA05
	 +Jjk2Vr7J1OInAwEUvH/EmNlvjcCnEMP1Gf8XlKqa3mhwnczntxqEEfRCvglkb9BRT
	 wHbDa5ETY9rhrLkijxBRLKbPeWQgETArOtpv8IAzEbK0Q1yYRIdh/VMpfxENcd81yc
	 pv8oes3jJF2w1b1STdMK16Gyj1WazJEDWB77mm+GyXIldIajzW0fxkg4qorigUfRrb
	 B3QOCKxBxjr2l2GKr/24Ew4Ud1X7LktbSn1RbzJp5lt6UpS70cye2zrmUlZ98Q2tc+
	 Kap/0HlZhlh7A==
Subject: Re: [PATCH net-next v2 3/9] netlink: specs: devlink: describe
 DEVLINK_ATTR_NESTED_DEVLINK
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Wed, 16 Sep 2026 19:15:19 +0000
Message-ID: <178958611988.22033.2838182170584631797@kernel.org>
In-Reply-To: <20260915161341.1053476-4-kuba@kernel.org>
References: <20260915161341.1053476-4-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The new `dl-nested-devlink` fractional set added by "netlink:
  specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK"…

--

netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK

This fills in the single attribute hidden by the "# TODO: fill in the
attributes in between" gap before selftests (176), adding nested-devlink
(175) as a multi-attr nest, plus a new dl-nested-devlink fractional set
and the attribute in the dev-get reply.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 0e0791d4e2c74..7ec52f81c3230 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml

[ ... ]

> @@ -1351,6 +1352,19 @@ attribute-sets:
>        -
>          name: index
>  
> +  -
> +    name: dl-nested-devlink
> +    subset-of: devlink
> +    attributes:
> +      -
> +        name: bus-name
> +      -
> +        name: dev-name
> +      -
> +        name: index
> +      -
> +        name: netns-id
                ^^^^^^^^^

[Severity: Medium]
Is the inherited type right for netns-id here?  Since this is a
subset-of set, it picks up the main devlink set declaration:

      -
        name: netns-id
        type: u32

But the kernel emits this attribute signed, in
devlink_nl_put_nested_handle() (net/devlink/netlink.c), which is the
function reached by devlink_nl_fill() -> devlink_nl_nested_fill() for
each nested_rels entry:

	if (!net_eq(net, devl_net)) {
		int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);

		rcu_read_unlock();
		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
			return -EMSGSIZE;

peernet2id_alloc() in net/core/net_namespace.c returns the negative
sentinel NETNSA_NSID_NOT_ASSIGNED (-1, include/uapi/linux/net_namespace.h)
in three cases:

	if (!check_net(net))
		return NETNSA_NSID_NOT_ASSIGNED;
	...
	if (!maybe_get_net(peer)) {
		spin_unlock(&net->nsid_lock);
		return NETNSA_NSID_NOT_ASSIGNED;
	}
	...
	if (id < 0)
		return NETNSA_NSID_NOT_ASSIGNED;

The wire width is 4 bytes either way, so nothing breaks in the kernel,
but would ynl-generated decoders and C structs now render the "nsid not
assigned" case as 4294967295, with no way to tell it apart from a valid
id?

The request side does read the attribute unsigned, in devlink_netns_get()
(net/devlink/dev.c):

	} else if (netns_id_attr) {
		net = get_net_ns_by_id(sock_net(skb->sk),
				       nla_get_u32(netns_id_attr));

so flipping the shared declaration would change the request typing too.
Would it be better to declare the reply-side attribute as s32, or
otherwise narrow the type per-use, so the documented type matches
nla_put_s32()?

One more note on scope: a later patch in this series, "netlink: specs:
devlink: describe the netns id in the parent-dev nest", reuses this same
subset for DEVLINK_ATTR_PARENT_DEV replies, and at 0fe71b34ba2e
("devlink: validate the port index in the rate set request") netns-id is
still type: u32 while the emitter still uses nla_put_s32(), so the
mismatch persists through the end of the series.

> +
>  operations:
>    enum-model: directional
>    list:
> @@ -1376,6 +1390,7 @@ operations:
>              - index
>              - reload-failed
>              - dev-stats
> +            - nested-devlink
>        dump:
>          reply: *get-reply
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915161341.1053476-1-kuba%40kernel.org
