Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4D3D6CC3
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586149; cv=none; b=Oi5QsZ7GRRgvHrlEgszUmEgggLDahUuaT1ooJVLdwolrydUUK5BY3MtcjOj7L4Mw2o6UoB6oEICmq5hwjVy8SBdihBli4LQm2/HBBj118zCrA2PwfszzUqZYoQBEQyOHQdf31KVYt+7BOoF90I7Eek4m3dC7CJOl7/w1548wRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586149; c=relaxed/simple;
	bh=LEebwCTA8iUl0CJFIsTqsro5YxpwEBNblGdsuxuxbjE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgoeqOWjL7/uElJOkKjvb/R1NguOI4pvYIEb82+ytBXVuMOR5sLKAhhaE+/3vRDgQBq/W0gAozkch5QlluBrAjG1r3Ve+kYv7TeV6f62CP48w/gv9K3Ezn52485089xlpJT6swtNVF83ygVa+rR119LqdOPfqgASgF1kmys/2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moOQRca6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moOQRca6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D954C1F00899;
	Wed, 16 Sep 2026 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586123;
	bh=UEKwG4nOZdMUECN3l1DU/s4JT+vIWDFLtqT7pE+LzAg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=moOQRca6xFolYBu10T6mSMoqwLTkJ17uUBECc9kZMRkmE8TzIQzjk+Zg1anuM/EOF
	 Tcj4lzWF2OpooefTDi2oVRYsyRHBHXaToil13ot0UAm8Q4JokxGX1uGo1zRL+RWSoz
	 yM0+Ar8+t/l+CwUFcEobKk/cgEmkHmWPcu00fuxe2ImCJvCH7nUsGOr72Z1cTfSf5s
	 gUcjC2AXM87l6DQ8dhwkkynh0Gp74M+5jd77Bta0dovgVngvnvP1hp+slr0pTN0TpM
	 U/j0jnlDEn6T9ze9YZ1EZbJk5jRnvmU3kcpVsHAjkqZsWDy6MjloQ/gIGWswH0YLbC
	 Qnh2FGm0ncqKA==
Subject: Re: [PATCH net-next v2 6/9] netlink: specs: devlink: populate
 multi-attr attrs for region read and line card
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Wed, 16 Sep 2026 19:15:22 +0000
Message-ID: <178958612241.22033.13388440378905861636@kernel.org>
In-Reply-To: <20260915161341.1053476-7-kuba@kernel.org>
References: <20260915161341.1053476-7-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1 (1)

- [Low] The patch fixes a user-visible decoding defect but carries no
  Fixes: tag.

Pre-existing issues:
- [Medium] DEVLINK_ATTR_INDEX is specified as `type: uint`
  (Documentation/netlink/specs/devlink.yaml:896-901) and the generated…
- [Low] Residual instance of the same spec/codegen defect class in the
  same file: the `dl-fmsg` fractional attribute set…

--

netlink: specs: devlink: populate multi-attr attrs for region read and line card

This adds multi-attr: true to the region-snapshot, region-chunk and
linecard-type entries in their fractional attribute sets, and expands the
region-get and linecard-get request/reply attribute lists so the attributes
the kernel actually emits are visible to the C code generator.

A few questions below.

> netlink: specs: devlink: populate multi-attr attrs for region read and line card
>
> Three attributes are emitted repeatedly inside their nest:
> [ ... ]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[Severity: Low]
Would a Fixes: tag be appropriate here?  The change looks like it repairs
a userspace-visible decoding defect rather than only improving the spec
text.  SpecAttr.is_multi defaults to False in
tools/net/ynl/pyynl/lib/nlspec.py, and _rsp_add() in
tools/net/ynl/pyynl/lib/ynl.py then overwrites earlier values:

    if not is_multi:
        rsp[name] = decoded

So before this patch ynl reported only the last DEVLINK_ATTR_REGION_CHUNK,
the last DEVLINK_ATTR_REGION_SNAPSHOT and the last
DEVLINK_ATTR_LINECARD_TYPE, meaning region reads and linecard
supported-type lists came out truncated.

git blame points at f2f9dd164db0 for the region-read op attribute list and
68c84289bcc0 for the dl-region-snapshots / dl-region-chunks /
dl-linecard-supported-types sets.  Without Fixes: tags, stable tooling has
no way to work out which releases carry the broken spec.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index f23466fb27f97..5c9c672497d44 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml

[ ... ]

> @@ -1278,6 +1279,7 @@ attribute-sets:
>      attributes:
>        -
>          name: region-chunk
> +        multi-attr: true
>  
>    -
>      name: dl-region-chunk

[Severity: Low]
This isn't a bug introduced by this patch, but is the dl-fmsg set a few
lines further down in the same file affected by the same mismatch?  It
declares fmsg-obj-nest-start, fmsg-pair-nest-start, fmsg-arr-nest-start,
fmsg-nest-end and fmsg-obj-name with no multi-attr, while
devlink_fmsg_prepare_skb() in net/devlink/health.c emits each of those
repeatedly inside one DEVLINK_ATTR_FMSG nest:

    fmsg_nlattr = nla_nest_start_noflag(skb, DEVLINK_ATTR_FMSG);
    ...
    list_for_each_entry(item, &fmsg->item_list, list) {
    ...
            case DEVLINK_ATTR_FMSG_OBJ_NAME:
                    err = nla_put_string(skb, item->attrtype, (char *)&item->value);

dl-fmsg is reachable from the health-reporter-diagnose reply, so the same
last-value-wins decoding applies there.

Note that the fix for fmsg cannot be the same one-line annotation:
TypeMultiAttr._complex_member_type() in tools/net/ynl/pyynl/ynl_gen_c.py
raises

    raise Exception(f"Sub-type {self.attr['type']} not supported yet")

for flag sub-types, so marking the four flag markers multi-attr would break
C code generation.  Is a separate, larger modelling change for fmsg planned,
or is it intentionally left out of scope given the commit message limits
itself to "region read and line card"?

[ ... ]

> @@ -1971,7 +1974,7 @@ operations:
>          post: devlink-nl-post-doit
>          request:
>            value: 42
> -          attributes: &region-id-attrs
> +          attributes:
>              - bus-name
>              - dev-name
>              - index
                 ^^^^^

[Severity: Medium]
This is a pre-existing issue and not something this patch introduces - the
patch only re-enumerates index in the region-get and linecard-get lists -
but while the index attribute is being written out explicitly here, is the
declared width consistent with how the kernel reads it?

The spec declares it as variable width:

      -
        name: index
        type: uint
        doc: Unique devlink instance index.
        checks:
          max: u32-max

and the generated policy is NLA_POLICY_FULL_RANGE(NLA_UINT, ...) for these
ops.  validate_nla() accepts either width for NLA_UINT:

    case NLA_SINT:
    case NLA_UINT:
            if (attrlen != sizeof(u32) && attrlen != sizeof(u64)) {

so an 8-byte payload holding a value <= U32_MAX passes validation, since the
range check itself uses nla_get_uint().

The two readers in net/devlink/netlink.c then disagree.
devlink_nl_filter_alloc() does:

    flt->devlink_index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);

while devlink_get_from_attrs_lock(), the pre_doit resolver used by these
ops, does:

    index = nla_get_u32(attrs[DEVLINK_ATTR_INDEX]);
    devlink = devlinks_xa_lookup_get(net, index);

On a big-endian kernel, wouldn't nla_get_u32() return the high half of an
8-byte payload, i.e. 0 for any in-range value, so the request resolves
devlink index 0 or returns -ENODEV instead of addressing the instance the
caller asked for?

> @@ -1979,7 +1982,15 @@ operations:
>          reply: &region-get-reply
>            value: 42
> -          attributes: *region-id-attrs
> +          attributes:
> +            - bus-name
> +            - dev-name
> +            - index
> +            - port-index
> +            - region-name
> +            - region-size
> +            - region-max-snapshots
> +            - region-snapshots

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915161341.1053476-1-kuba%40kernel.org
