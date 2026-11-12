Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448947;
	b=1xDAYoadD6RKu9Mh33t7IJDuXllqvqzP/CDO5Tpd8zr31VjpvDucmQYqUoR/tS2iZngP
	 JqoPRP404x2XW4lZlqVcOObE+mljUQT9z1buvXANrflbajU21tLXFzu6M4pRh5sOMgf/v
	 iRXYsTGVxLoMy6P8RFeFcupSyDaf0u6lo4eSpRS+T2iwNn1X148552f82n89V+xLy0GNM
	 YCoA/lbMYWOWXROgMNTtuDdgTakPf/rWf0Xk/Q56aEw8Ouog/CAuLgwTZpnmDam2xy2md
	 RE5yy+XxQNHDbEYv5O4dSfoUuHbJvpMwDun99XGvIzDykgzNFbHCE3LC8WD4bLuG/QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448947;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HriGiWi+UQ8QPL/8QwkOWDz4Mb2kWePdRLKQHkPJXMI=;
	b=FHVkfGc61rFNP0KJ7Ux9n1QKrS1LYS8H78izDy8B6fiXiJI5l2n7p+5sn3/Vo+75eYse
	 pFYaEmxcCvzasrXrbnXtCnIfHlhqxnUbTZupJ+9NuIYodbW8tyDJO6+VqFa8yeORluwhG
	 UYwWES1rEyDVeMeahE/+n4344vQrXfxyOGx3x0Co6LIQCYPfk9btQm+Q5coN3AWnJx5Ty
	 m++awrnwVZkDGHuJvAkIOD+kus3n8fzAsnA0tejce1v9amdfxBQ1s7/uCT7lmJaOeXJK1
	 gnumGtuJCbtTTipHWwVgbFwXyYMT+3d+sz2k5nRUnysoGSJlTbyprLnk+4YAs5NXPiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWhT9UPX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7BD606A337
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWhT9UPX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AA61F00A06;
	Thu, 12 Nov 2026 02:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448946;
	bh=HriGiWi+UQ8QPL/8QwkOWDz4Mb2kWePdRLKQHkPJXMI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WWhT9UPXr0myRopcw5u0oW/MMCb3oOkApSaqHzPxBZxrKs50GY7bhTW8hzQcTcYPl
	 1+Grsajj+fI5uHHWIbqWAQsLem0ChlZVaDI9lKzD3MdgT+HGktCoZLs362xHto7YZz
	 a3SwCdTjCozx8DwBnWUMr5VMCeBiraUbgkraWa9Sjpt8lbohj9eqsY4ANESzgUhShE
	 P0RpRvESMdL1QX6zG5Bl1Cu1zvE/i82CVhQIv3wMhL0WsdC2muikCaFazwtjf7C6s2
	 vJF/W8eaC1HDuTi+WB/ZnfvtkUx18zDukmf2Dn1I7viQx52hKiiG3l+mguS36Qsf3X
	 nAxAaE/njcJjA==
Subject: Re: [PATCH net-next v7 1/2] netlink: specs: add ovs_flow del and set
 operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 dev@openvswitch.org
Date: Thu, 12 Nov 2026 02:02:25 +0000
Message-ID: <179444894546.2199510.2728310247051508293@kernel.org>
In-Reply-To: <20261110174751.973464-2-houminxi@gmail.com>
References: <20261110174751.973464-2-houminxi@gmail.com>
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

- [Low] The new OVS_FLOW_ATTR_UFID doc in
  include/uapi/linux/openvswitch.h (lines 669-671) and in…
- [Low] The patch changes the docs for key, actions, stats, tcp-flags and
  used from 'present in notifications' to 'present in replies and…

--

netlink: specs: add ovs_flow del and set operations

This commit adds the del and set operations to the ovs_flow YNL spec and
gives dump its own request list. It also changes probe to a flag and adds
used and tcp-flags to the get reply. The attribute docs are reworded in
both the spec and include/uapi/linux/openvswitch.h.

> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 951837b72e1d2..d7aeeeb5a3cc5 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml

[ ... ]

> @@ -438,18 +447,22 @@ attribute-sets:

[ ... ]

>        -
>          name: ufid
>          type: binary
> +        checks:
> +          min-len: 1
>          doc: |
>            A value between 1-16 octets specifying a unique identifier for the
>            flow. Causes the flow to be indexed by this value rather than the
> -          value of the OVS_FLOW_ATTR_KEY attribute. Optional for all
> -          requests. Present in notifications if the flow was created with this
> -          attribute.
> +          value of the OVS_FLOW_ATTR_KEY attribute. A value longer than 16
> +          octets is treated as if the attribute were absent, so a new flow is
> +          indexed by its key. A zero-length value is rejected with -ERANGE.
> +          Optional for all requests. Present in notifications if the flow was
> +          created with this attribute. A dump does not read it.

[Severity: Low]
Is "A dump does not read it" accurate when it sits next to the -ERANGE
sentence? The commit message goes further:

  "A dump does not read the attribute at all."

ovs_flow_cmd_dump() still parses every attribute against flow_policy:

net/openvswitch/datapath.c:ovs_flow_cmd_dump() {
    ...
	err = genlmsg_parse_deprecated(cb->nlh, &dp_flow_genl_family, a,
				       OVS_FLOW_ATTR_MAX, flow_policy, NULL);
	if (err)
		return err;
    ...
}

and flow_policy has:

	[OVS_FLOW_ATTR_UFID] = { .type = NLA_UNSPEC, .len = 1 },

In validate_nla(), the NLA_UNSPEC length check fails with -ERANGE, so a dump
request that carries a zero-length OVS_FLOW_ATTR_UFID is rejected the same
way a do request is. The dump never uses the ufid value, but it does
validate the attribute.

Could the wording say that a dump ignores the value but still rejects a
zero-length ufid? The same sentence is in the OVS_FLOW_ATTR_UFID kernel-doc
in include/uapi/linux/openvswitch.h.

[ ... ]

> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index 440825e658371..3f18f59e91dc2 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h

[ ... ]

> @@ -655,9 +664,11 @@ struct ovs_nsh_key_md1 {
>   * should be suppressed.
>   * @OVS_FLOW_ATTR_UFID: A value between 1-16 octets specifying a unique
>   * identifier for the flow. Causes the flow to be indexed by this value rather
> - * than the value of the %OVS_FLOW_ATTR_KEY attribute. Optional for all
> + * than the value of the %OVS_FLOW_ATTR_KEY attribute. A value longer than 16
> + * octets is treated as if the attribute were absent, so a new flow is indexed
> + * by its key. A zero-length value is rejected with -ERANGE. Optional for all
>   * requests. Present in notifications if the flow was created with this
> - * attribute.
> + * attribute. A dump does not read it.

[Severity: Low]
This patch changes key, actions, stats, tcp-flags and used from "present in
notifications" to "present in replies and notifications". This paragraph is
edited too, but it keeps "Present in notifications if the flow was created
with this attribute". Should it also say replies?

ovs_flow_cmd_fill_info() calls ovs_nla_put_identifier() unconditionally:

net/openvswitch/datapath.c:ovs_flow_cmd_fill_info() {
    ...
	err = ovs_nla_put_identifier(flow, skb);
	if (err)
		goto error;
    ...
}

and for a flow identified by a ufid, that emits OVS_FLOW_ATTR_UFID:

net/openvswitch/flow_netlink.c:ovs_nla_put_identifier() {
	if (ovs_identifier_is_ufid(&flow->id))
		return nla_put(skb, OVS_FLOW_ATTR_UFID, flow->id.ufid_len,
			       flow->id.ufid);
    ...
}

fill_info() builds get replies and every dump entry, so the ufid shows up in
those replies as well as in notifications.

The spec now also disagrees with itself: the &flow-get-reply list includes
ufid, but the ufid doc in ovs_flow.yaml has the same notification-only
sentence.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110174751.973464-1-houminxi%40gmail.com
