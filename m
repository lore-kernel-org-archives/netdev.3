Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6B3839B4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877099; cv=none; b=m89wMBLD+xCJb3zHsKF5wGQkNgy5VsKKIRIX+SL3W0ilhPRlBeibLz5sJa/QbwPwEM+GS+XWIgx2Pn4d93Vwb9EFVXCRlW7RYNdGZHSs7BGOzS8Y/oEmDUCOoSAJFLRcynkxVPT+BPoiMFLpGuZ4QrOoRPy/yomOngAl/gvPzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877099; c=relaxed/simple;
	bh=RBs0c9UaegdlDSzCXqobrsn9sXHmckULAfeID9dK2nY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFMhwqwsVqDXKOjgttxLGAvtL7vRjJ4v7tCaJtAXJIERFp/xNYAAKb5vhvE5Lp8EnZNAYkHQDKAzesYU1f2FkJlxwYLnCImNj78XPttaxgA2tpwKYblXoQXUHN3p8JsDcjZ9oCr2AL1r+BqjI6wxpAyBXnS3m+0yTVGo192e5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezGWdq/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezGWdq/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB9E1F000FF;
	Tue, 13 Oct 2026 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791877098;
	bh=mWtkvTg40g79UnFBvTYi26nCpxxqKl8u7aLtidrWDeU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ezGWdq/AmeQKXcLS4zbOucKrNC1WaAzSgTB4P9rpwsKZf5rlMKow7KaFxs3d9pfvc
	 a1TMoGJNRsME0a89PnV6Pd5n9Q/vDqefYv9A5xOV2iDaL/QuHHDM01k8pem/caLDAB
	 zKos8Pf3arPIxnLujENUiTpD89WVF/Lout3O0YLIhU214joGz82N6Mn0R9pH2UjCwx
	 3Y4mjw1o9vOHjJEw5/PmeT7amOiatPLcJhpWBwpr3N3Ynnoain9tlI6lbu0hLJGSCw
	 bbdWmP2oRM8Ct6zC0Z/eVk0z5E5QvuOMKHg6Apw+tXDoKRsrfvgepqsSj47HIUfjLI
	 xmN8lZ7Z8vSPw==
Subject: Re: [PATCH net-next v2 1/2] netlink: specs: add ovs_flow del and set
 operations
From: netdev-bot+sashiko@kernel.org
To: houminxi@gmail.com
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 13 Oct 2026 07:38:17 +0000
Message-ID: <179187709747.434549.16040884181450649933@kernel.org>
In-Reply-To: <20261012065552.2426415-2-houminxi@gmail.com>
References: <20261012065552.2426415-2-houminxi@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch changes two existing spec definitions in
  Documentation/netlink/specs/ovs_flow.yaml, and the commit message…

Pre-existing issues:
- [Medium] The 'new' operation's request list in
  Documentation/netlink/specs/ovs_flow.yaml is still [key, ufid, mask,…
- [Low] The flow-attrs 'key' attribute doc in
  Documentation/netlink/specs/ovs_flow.yaml (lines 386-387) says key is…
- [Low] The 'get' operation in Documentation/netlink/specs/ovs_flow.yaml
  shares one request list between do and dump (&flow-get-op = [key,…

--

netlink: specs: add ovs_flow del and set operations

This commit adds del and set operations to the ovs_flow YNL spec. Each one
gets a request attribute list and the uns-admin-perm flag. The patch also
changes the probe attribute type from binary to flag, and adds
uns-admin-perm to the existing new operation.

> diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
> index 951837b72e1d2..b1c884b4115df 100644
> --- a/Documentation/netlink/specs/ovs_flow.yaml
> +++ b/Documentation/netlink/specs/ovs_flow.yaml
> @@ -438,7 +438,7 @@ attribute-sets:
>            are exact match bits.
>        -
>          name: probe
> -        type: binary
> +        type: flag

[Severity: Low]

This isn't a bug, but the commit message doesn't mention this change. Every
op that uses flow-attrs shares the probe attribute. It has been binary since
commit 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow").

The new type matches the kernel policy in net/openvswitch/datapath.c:

    [OVS_FLOW_ATTR_PROBE] = { .type = NLA_FLAG },

It does change how existing YNL clients encode probe, though. In
YnlFamily._add_attr() in tools/net/ynl/pyynl/lib/ynl.py, a binary attribute
with a None or b'' value is sent as a zero-length attribute. A flag with a
falsy value is left out entirely.

The existing new operation also gains flags: [uns-admin-perm] further down.
The commit message only says:

    del and set need CAP_NET_ADMIN.

That flag does match the GENL_UNS_ADMIN_PERM set on OVS_FLOW_CMD_NEW in the
kernel.

Could both changes be described in the commit message? Alternatively, the
probe type fix could go in its own patch with a
Fixes: 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow") tag.

>          doc: |
>            Flow operation is a feature probe, error logging should be suppressed.
>        -
> @@ -988,6 +988,36 @@ operations:

[Severity: Low]

This is a pre-existing issue, but the get operation just above this hunk
uses one request list for both do and dump:

      do: &flow-get-op
        request:
          attributes:
            - key
            - ufid
            - ufid-flags
      ...
      dump: *flow-get-op

ovs_flow_cmd_get() also reads probe, but probe is not in the list:

    bool log = !a[OVS_FLOW_ATTR_PROBE];

ovs_flow_cmd_dump() only reads OVS_FLOW_ATTR_UFID_FLAGS:

    ufid_flags = ovs_nla_get_ufid_flags(a[OVS_FLOW_ATTR_UFID_FLAGS]);

So the kernel ignores the key and ufid listed in the dump request.

Should probe be added to the get do request? Should dump get its own request
list with only ufid-flags?

>        doc: Create OVS flow configuration in a data path
>        value: 1
>        attribute-set: flow-attrs
> +      flags: [uns-admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - key
> +            - ufid
> +            - mask
> +            - actions

[Severity: Medium]

This is a pre-existing issue, but the new request list still leaves out
ufid-flags and probe. ovs_flow_cmd_new() reads both:

    u32 ufid_flags = ovs_nla_get_ufid_flags(a[OVS_FLOW_ATTR_UFID_FLAGS]);
    ...
    bool log = !a[OVS_FLOW_ATTR_PROBE];

The del and set lists in this patch include them. Without them here, a YNL C
client generated from this spec can't send probe or ufid-flags on a NEW
request.

This patch already edits the new operation. Could these two attributes be
added to its request list too?

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
> +            - probe
> +    -
> +      name: set
> +      doc: |
> +        Modify an existing flow. The kernel rejects the request with
> +        -EINVAL when it carries neither a key nor a ufid. Replacing the
> +        actions also needs a key: a ufid on its own is not enough.

[Severity: Low]

This is a pre-existing issue, but the key attribute doc in flow-attrs
contradicts these new del and set docs:

        name: key
        ...
        doc: |
          Nested attributes specifying the flow key. Always present in
          notifications. Required for all requests (except dumps).

The kernel-doc for OVS_FLOW_ATTR_KEY in include/uapi/linux/openvswitch.h has
the same wording.

The kernel accepts requests without a key. ovs_flow_cmd_del() flushes the
table when there is neither a key nor a ufid:

    if (unlikely(!a[OVS_FLOW_ATTR_KEY] && !ufid_present)) {
        err = ovs_flow_tbl_flush(&dp->table);

ovs_flow_cmd_set() and ovs_flow_cmd_get() also accept a ufid on its own:

    if (!a[OVS_FLOW_ATTR_KEY] && !ufid_present) {

Should the key doc be updated along with the new del and set docs?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012065552.2426415-1-houminxi%40gmail.com
