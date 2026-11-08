Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141569;
	b=x1/XbA1vnVDgrVSQ5sAOp1vTjGAcv7n+uOIhJoxfyUuL+Qb2T5JR1KPtQrq10tMIE9Tw
	 ZI1NlfGhUw7VGwWOhhJm6J+m9mjqE8lpvqhv11xhD5055blmFrq0HPVwKa7qKHa3Fen5X
	 SSX4uSI/7Vyb1HS8Cf/wJckm1K4/FUGyC0VRvjysYGeABEq+JwQglEzZbbRIy6NG8tiwW
	 cz5IR/mfefQv/Sx1nqgKI6z2rEIYn9sjFSm62sfP2vLIhXBt/fTD7V1F+QaSGjJvV4ZZ/
	 4kwHW8XVXSHo3yERrdjijlhA6/VkSWMmpYa/YNv79TxSOTuX00o67Yaf/6ilwnRUveg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141569;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eREda5YYJE2S3LBGhMtfKgJaJUwdP06PFNJ7xCwW/JQ=;
	b=1E4cQVLK0u+CdWoqs+1RtsZJPZLICVudj/WhafmA8QrBwiF0hhLXnvUfa64AuduhxF9u
	 nwphIBO5JmzV9nPTRm1/GSpP2NBvU4t/PnSDwYBrj7FBAx5mHqjo3jnIPijCo01EEEVpr
	 LvFHCVOtThXacKdZKXhk/76aecqIMtPB+Yxi6YzX3mgG2CwKhY92CDXj6uiGBneiHHUKj
	 6jX1yFK+j7sBxwtr50rb0YDctPjUe5xUy4g+zxiH7k93e1CtVYcpTHlUM6I+wPuAEFEKd
	 acczBc/jMLiO9CZ9nLWZszZuy40YEniLOyTd5c+ZE7842CRzl7uBOUHC5C6qZIcXC6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvL82ojH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E1606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvL82ojH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D91F0089F;
	Sun,  8 Nov 2026 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141568;
	bh=eREda5YYJE2S3LBGhMtfKgJaJUwdP06PFNJ7xCwW/JQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QvL82ojHkxl75mLFGUNQpFZDyMG6YJGO7dAMitN645AW4D8i/CFgAIyaPKTNBFqOQ
	 xgGdKw1j35HpuI607tYXmF8PCxbW2tDwJ1ryTs7V9jukUSmuwUgnGLpEvaTfk4EYLb
	 MBtLT0nFWb9KxY8/W1j1VDf+aFvz3ZK2CFbRrb9IErBxrpupMj9mZXDIlb/u1A4HMK
	 7jy8qAjhqMNTb5c12DwyzMyv0bFP9iUrs8wAqjx0FPBISyy+pOWFXjvdwU/XxWPCkz
	 2koZqu2eTcJ7IlZHrO1k7pXHbJDNmZ0kd2xekV/A1wobZPhIq5sHpKbi7G/bzhXxne
	 SgStZWEoI0D1Q==
Subject: Re: [PATCH net-next v6 1/2] netlink: specs: add ovs_flow del and set
 operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dev@openvswitch.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org
Date: Sun, 08 Nov 2026 12:39:27 +0000
Message-ID: <179414156764.994134.5410552449080338660@kernel.org>
In-Reply-To: <20261107120647.874906-2-houminxi@gmail.com>
References: <20261107120647.874906-2-houminxi@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new ufid text in Documentation/netlink/specs/ovs_flow.yaml
  (flow-attrs/ufid) and in include/uapi/linux/openvswitch.h…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the get
  reply list, now anchored as &flow-get-reply and reused for the dump…

--

netlink: specs: add ovs_flow del and set operations

This adds the del and set operations to the ovs_flow YNL spec. It also
gives the dump its own request list, changes probe to a flag, and marks
the ops dont-validate and admin-only. The key, actions and ufid docs are
rewritten in both the spec and include/uapi/linux/openvswitch.h.

> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 951837b72e1d2..bfdbf55bc219b 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml

[ ... ]

> @@ -438,18 +446,22 @@ attribute-sets:

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
> +          value of the OVS_FLOW_ATTR_KEY attribute. A request that carries a
> +          value outside that range is treated as if it carried no ufid, so a
> +          new flow is indexed by its key. Optional for all requests. Present
> +          in notifications if the flow was created with this attribute.
> +          Ignored in a dump.

[Severity: Medium]
Is this accurate for a zero-length ufid? flow_policy in
net/openvswitch/datapath.c has:

    [OVS_FLOW_ATTR_UFID] = { .type = NLA_UNSPEC, .len = 1 },

and validate_nla() in lib/nlattr.c checks the minimum length even when
strict validation is skipped:

    case NLA_UNSPEC:
        if (validate & NL_VALIDATE_UNSPEC) {
            ...
        }
        if (attrlen < pt->len)
            goto out_err;

So for new, del, set and get, the genl core returns -ERANGE for a 0-byte
ufid before any handler runs. A del with a 0-byte ufid and no key then
gets -ERANGE and does not flush the data path.

For dumps the core skips validation. However, ovs_flow_cmd_dump() parses
with the same policy and returns the error:

    err = genlmsg_parse_deprecated(cb->nlh, &dp_flow_genl_family, a,
                                   OVS_FLOW_ATTR_MAX, flow_policy, NULL);
    if (err)
        return err;

So a 0-byte ufid makes the whole dump fail. It is not ignored.

The treated-as-absent path in get_ufid_len() in
net/openvswitch/flow_netlink.c is:

    if (len < 1 || len > MAX_UFID_LENGTH) {

After policy validation, only the len > 16 case can reach it.

The min-len: 1 check added just above also says 0 octets is rejected,
which contradicts the doc text under it. The commit message has the same
contradiction:

  "Anything outside 1-16 octets is read as if the attribute were absent,
  so a del with such a ufid and no key flushes the data path"

next to "record the minimum length the policy enforces in the attribute".

The same claim also appears in these places:

  - the del op doc ("A request that carries no key and no valid ufid
    flushes the data path")
  - the new key doc
  - @OVS_FLOW_ATTR_UFID and @OVS_FLOW_ATTR_KEY in
    include/uapi/linux/openvswitch.h

The later patch in the series ("netlink: specs: add ovs datapath and
vport set operations") does not touch ovs_flow.yaml or openvswitch.h, so
this text is still there at the end of the series.

Could the docs say that a value longer than 16 octets is treated as
absent, and that a zero-length value is rejected with -ERANGE?

>          display-hint: uuid

[ ... ]

> @@ -969,25 +981,33 @@ operations:
>        doc: Get / dump OVS flow configuration and state
>        value: 3
>        attribute-set: flow-attrs
> -      do: &flow-get-op
> +      dont-validate: [strict, dump]
> +      do:
>          request:
>            attributes:
>              - key
>              - ufid
>              - ufid-flags
> -        reply:
> +            - probe
> +        reply: &flow-get-reply
>            attributes:
>              - key
>              - ufid
>              - mask
>              - stats
>              - actions
> -      dump: *flow-get-op
> +      dump:
> +        request:
> +          attributes:
> +            - ufid-flags
> +        reply: *flow-get-reply

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. This
reply list is now anchored and reused for the dump, so should it also
list used and tcp-flags?

ovs_flow_cmd_fill_info() always calls ovs_flow_cmd_fill_stats(). That
function puts both attributes in get replies and dump entries:

    if (used &&
        nla_put_u64_64bit(skb, OVS_FLOW_ATTR_USED, ovs_flow_used_time(used),
                          OVS_FLOW_ATTR_PAD))
        return -EMSGSIZE;
    ...
    if ((u8)ntohs(tcp_flags) &&
         nla_put_u8(skb, OVS_FLOW_ATTR_TCP_FLAGS, (u8)ntohs(tcp_flags)))
        return -EMSGSIZE;

Because they are not in the reply list, YNL-generated clients do not
parse the last-used time or the TCP flags. The dump already shared this
reply list through *flow-get-op before this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107120647.874906-1-houminxi%40gmail.com
