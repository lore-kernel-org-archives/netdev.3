Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123D4BF945
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586137; cv=none; b=CqvWFuE9q26Znf3vyYLxSgbIrO/I7kVvXnvPsSqNRhoBZhZ4W9J78Kwcosv2+R1C7IcHt08nKy/eJRWWHQu9Cy+I1H1qiUfOzplZyJK3CQ5spF+f5aCJZIbPfBSHHLlABkmg02rEwL7HcGpjyQWddR1qAmkxGjCb8MvJUAVaK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586137; c=relaxed/simple;
	bh=YTHDNSKnYBkvfwORMWnBU8cKebPXB9xdeZmQgb+YTz4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSabUF0Dmz+vpSOAVGl/whty7xwFu309Ma3NHoZfdO83t8ikoKektqz3LPeAaSt5rEMSky9bcdll8zSjx2RHXpoeCBIE35NHhZb3xSELhAkmouitleNI4dG+AHUWHsxESZsj8q9HX+//LOOxdjuV3TslKIiwgCUBtcMFICCOCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiOSEfwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiOSEfwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1651F000FF;
	Wed, 16 Sep 2026 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586119;
	bh=8QDsxfFKv/N21EOXkbtA+TuOzmGrcxcHH56WKdiRD8M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MiOSEfwpNdtQkY44MZLakb3NAWx68A4xXfhmtI4GPawagi4qN11ajkV7MJUyVfi4c
	 bv40G4cxpkLoIaxvIuAYmkJ0O3+pOfV3NxK5jSdel/VxGnAse/OICYWAq8Yu09OLsT
	 sm/N2LqWBesc0gi94n/288xKxq5uDj8/2rDf9woCmjLTHKe5k+L8duoWKyo7dXjktH
	 754rJpQHtpaODWD9cL6o4Yefvge6tcplEt42LbkmO+XgeriRH1XlvnGRLi936uxaTl
	 kRl1+bTqoI1rnauukvhaD7sWr771/pLr0shfq4C6kR4sakC06a1KscsIPRW5Rm3ht6
	 nNG8aHY621PNg==
Subject: Re: [PATCH net-next v2 1/9] devlink: fix the enum behind
 DEVLINK_ATTR_RELOAD_LIMITS
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Wed, 16 Sep 2026 19:15:18 +0000
Message-ID: <178958611873.22033.17037509618791035232@kernel.org>
In-Reply-To: <20260915161341.1053476-2-kuba@kernel.org>
References: <20260915161341.1053476-2-kuba@kernel.org>
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

- [Medium] Commit message mischaracterizes a user-visible netlink
  validation change as "cosmetic", and the patch carries no Fixes: tag.

--

devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS

The devlink YAML spec annotated DEVLINK_ATTR_RELOAD_LIMITS with enum
devlink_reload_action instead of enum devlink_reload_limit, so a new
reload-limit enum is added and the attribute (plus reload-stats-limit) is
pointed at it.  The regenerated policy changes the bitfield32 valid mask
for DEVLINK_ATTR_RELOAD_LIMITS from 6 to 3.

> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 38b1190f3d269..d933b205ee865 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -174,6 +174,18 @@ definitions:
>          value: 1
>        -
>          name: fw-activate
> +  -
> +    type: enum
> +    name: reload-limit
> +    entries:
> +      -
> +        name: unspec
> +        doc: no constraints
> +      -
> +        name: no-reset
> +        doc: >-
> +          No reset allowed, no down time allowed, no link flap and no
> +          configuration is lost.
>    -
>      type: enum
>      name: param-cmode
> @@ -775,7 +787,7 @@ attribute-sets:
>        -
>          name: reload-limits
>          type: bitfield32
> -        enum: reload-action
> +        enum: reload-limit
>          enum-as-flags: true

[ ... ]

> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> index dec00133178d1..30f01901b5877 100644
> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -334,7 +334,7 @@ static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_INDEX + 1]
>  	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>  	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
>  	[DEVLINK_ATTR_RELOAD_ACTION] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
> -	[DEVLINK_ATTR_RELOAD_LIMITS] = NLA_POLICY_BITFIELD32(6),
> +	[DEVLINK_ATTR_RELOAD_LIMITS] = NLA_POLICY_BITFIELD32(3),

[Severity: Medium]
Is this really only cosmetic?  The commit message says:

  AFAICT this is a cosmetic change - both DEVLINK_RELOAD_LIMIT_UNSPEC
  and the out of bounds bit 2 will be rejected either way because drivers
  don't declare them as supported.

That reasoning covers the value bits, since only value bits reach
devlink_reload_limit_is_supported().  But validate_nla_bitfield32() in
lib/nlattr.c checks the selector against the mask on its own:

	/*disallow invalid bit selector */
	if (bf->selector & ~valid_flags_mask)
		return -EINVAL;

and devlink_nl_reload_doit() in net/devlink/dev.c only ever looks at

	limits_selected = limits.value & limits.selector;

so selector-only bits never reach any driver check.  Doesn't that make the
mask change user-visible in both directions?

Going from 6 to 3 accepts selector bit 0 again.  The natural selector for
userspace is the exported DEVLINK_RELOAD_LIMITS_VALID_MASK in
include/uapi/linux/devlink.h:

#define DEVLINK_RELOAD_LIMITS_VALID_MASK (_BITUL(__DEVLINK_RELOAD_LIMIT_MAX) - 1)

which is 3.  With mask 6 that request fails early, since 3 & ~6 == 1, so
DEVLINK_CMD_RELOAD with selector DEVLINK_RELOAD_LIMITS_VALID_MASK and
value BIT(DEVLINK_RELOAD_LIMIT_NO_RESET) returns -EINVAL on current
kernels and starts working again with this patch.  Should this therefore
carry a Fixes tag for f2f9dd164db079 ("netlink: specs: devlink: add the
remaining command to generate complete split_ops"), which is where mask 6
came from (its parent used DEVLINK_RELOAD_LIMITS_VALID_MASK in
net/devlink/netlink.c)?  Without a Fixes tag, and described as cosmetic,
stable backporters will likely skip it and the -EINVAL behaviour stays in
place from v6.7 onwards.

The other direction also changes: a request with selector 6 and value 2
passes policy today, and since limits_selected ends up as
BIT(DEVLINK_RELOAD_LIMIT_NO_RESET) it succeeds on drivers advertising
that limit, for example mlx5:

drivers/net/ethernet/mellanox/mlx5/core/devlink.c:
	.reload_limits = BIT(DEVLINK_RELOAD_LIMIT_NO_RESET),

After this patch such a request is rejected with -EINVAL.  Could the
changelog mention that narrowing as well?

One more user-visible effect worth noting: ynl decodes bitfield32 flags
via _decode_enum(), so with the reload-action annotation it currently
prints and accepts the unrelated names driver-reinit and fw-activate for
reload-limits rather than unspec and no-reset.  That also looks like more
than a documentation-only fix.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915161341.1053476-1-kuba%40kernel.org
