Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F858E2DA
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157479; cv=none; b=q+ERNVYxe7JSlzw+qIyq/2omlu6NnjZ2AlwpWRhzbnrwK3QRmD6d9n37nVIIKgGbY/PGiVOtpxqYfTIDrN2gCuqsb6TiERxof8m5oulg2OPXz8jjtw+ecNa9X+SFQIxt5SduYu4mZss9Xg3i510OOfVVUcBV59+qJcvPcKolEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157479; c=relaxed/simple;
	bh=bEj6LRHH/iYBAItO5ClIVGe9flUu9CcILYvzjdrAmPk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G4r2hFv3/ZT7wq0YcOKiYxvgNJeEKXUXrlytA3cJQ+sMx6XyLembdBkzso9PqMI9dnM3OqJzQQXa8TaqWX4nytJwQDKWKk158hlgKWWs4csw4fVjNvxebniINk5SZgFTlpPbRsWAdoGSOETT/GO8SgoVw1dw/jGngCNWVQpECvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flbYajC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flbYajC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14931F000FF;
	Fri, 11 Sep 2026 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157477;
	bh=7z4m9dwWKRpuOxjsIiyqwaDadFI1Xk2Qxcgzy+rxtGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=flbYajC42vzY53+Oz7QF7H82IYzpMwLrlzxPcI8OaTpmXelLeNoxNiF5/0TYlea6u
	 r2vXEOxAQvBiD4mVSspJ80SMvVMFyf7RHBX2ACDMFtfIgYSoZFQ8+WBbSAOtJC4j6O
	 dSd0sM1SIl4M2YTr4cEW+IIqlGghr3HINdQbfiVOffHltR1OL0+STWc0F9W9qfROh3
	 lZcVLLkAa5ekFfof6FjaPQhDwgvrA/wxcc6mEqxmwnRoqgE+fFm6VC3+AI9VXeXt7U
	 p5Eyv3k0vdNr+cobn+G/Ibzd9Gi4J9PhIWRd9nFwbKYSZWvAWHeQznwxHgz1crxwW1
	 TGbJgo18GBGNw==
Subject: Re: [PATCH net-next 4/8] netlink: specs: devlink: complete the port
 function nest
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Fri, 11 Sep 2026 20:11:16 +0000
Message-ID: <178915747642.219967.2565421837062696358@kernel.org>
In-Reply-To: <20260910200312.2665792-5-kuba@kernel.org>
References: <20260910200312.2665792-5-kuba@kernel.org>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1 (1)

- [Low] The patch fixes a user-visible tooling breakage (any ynl/spec-
  driven decoder aborts on a devlink port-get do/dump reply with "Space…

Pre-existing issues:
- [Low] The nest newly referenced by the added `devlink` attribute (`dl-
  nested-devlink`, subset-of devlink) declares `netns-id` as `type: u32`…

--

netlink: specs: devlink: complete the port function nest

The dl-port-function attribute set in the devlink spec stopped at caps,
while the kernel also emits DEVLINK_PORT_FN_ATTR_DEVLINK and
DEVLINK_PORT_FN_ATTR_MAX_IO_EQS on port-get do and dump.  The patch adds
both attributes to the spec and regenerates the netlink policy.

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
Two attributes are added here, but the commit message attributes the spec
gap to a single commit:

  Commit 5af3e3876d56 ("devlink: Support setting max_io_eqs") added the
  uAPI value and the hand written policy but never touched the spec.

git blame on enum devlink_port_function_attr in
include/uapi/linux/devlink.h shows the two values come from different
commits:

  0b7a2721e36c11 (Jiri Pirko   2023-09-13) DEVLINK_PORT_FN_ATTR_DEVLINK,  /* nested */
  5af3e3876d567f (Parav Pandit 2024-04-06) DEVLINK_PORT_FN_ATTR_MAX_IO_EQS, /* u32 */

Should the message also mention 0b7a2721e36c1 as the origin of the
missing devlink nest attribute?

Since devlink_nl_port_function_attrs_put() emits both attributes on every
port fill:

  net/devlink/port.c:devlink_nl_port_function_attrs_put() {
	err = devlink_port_fn_max_io_eqs_fill(port, msg, extack, &msg_updated);
	if (err)
		goto out;
	err = devlink_rel_devlink_handle_put(msg, port->devlink,
					     port->rel_index,
					     DEVLINK_PORT_FN_ATTR_DEVLINK,
					     &msg_updated);
  }

any spec-driven decoder fails on such a reply.  Would Fixes: tags for both
commits be appropriate so this gets picked up for the affected stable
trees?

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
This is a pre-existing issue and not introduced by this patch, but the new
devlink attribute points at dl-nested-devlink, which makes the netns-id
member reachable from the port-function reply, and the spec declares it
unsigned:

  Documentation/netlink/specs/devlink.yaml:
      -
        name: netns-id
        type: u32

The kernel writes that member as signed, and the value can be the
negative sentinel:

  net/devlink/netlink.c:devlink_nl_put_nested_handle() {
	int id = peernet2id_alloc(net, devl_net, GFP_ATOMIC);

	rcu_read_unlock();
	if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
		return -EMSGSIZE;
  }

  net/core/net_namespace.c:peernet2id_alloc() {
	if (!check_net(net))
		return NETNSA_NSID_NOT_ASSIGNED;
  }

So for a peer devlink instance in another namespace whose nsid is not
assigned, a spec-driven decoder prints 4294967295 instead of -1 and cannot
recognise the not-assigned sentinel.  Length validation is the same for
NLA_U32 and NLA_S32, so kernel side behaviour is unaffected.

Documentation/netlink/specs/netdev.yaml declares the equivalent attribute
as s32:

      -
        name: netns-id
        doc: The network namespace id of the netdev.
        type: s32

Would it make sense to change netns-id in devlink.yaml to s32 (or sint)
here as well?  It is still type: u32 at the end of this series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910200312.2665792-1-kuba%40kernel.org
