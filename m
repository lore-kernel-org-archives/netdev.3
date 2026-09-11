Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF657EDA3
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157476; cv=none; b=DX19vZ9v1Po8lOLWVfIVsIpKUy+6lBT0+UF7JhFqmhwULYb3RBY8SFJrOK7WcXibmJtCqpB40FYKrKBY+R5XW92lf0Qf1uAuSbKNAbhiOXxSeVAKMoRrQRqtUi0X4Jz6Of1M7fZ35ps+TC1jJnfKIZPkvB3YkdAho4UH4Hpk/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157476; c=relaxed/simple;
	bh=cSI3hxNH/yDv1Ku5+WcMjpmEsk4RdyElWfAq44srmeQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOY78Cw+q9JM9WKnTqPm4iEBSgglNgv5quD/po0jpYRcqP1FAGc9A9wiLSnJLnJvLc0jc6aRQk2LeQ7pEyA9DEB0BlpU7cWY5ZHguYCfbUADyIlnUIY3Qc4FWynPxczQmQeTDhrUg8J8DMENeiyfoTlgJqFvfHjpYpNo7TNVNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb6qzDPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb6qzDPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8592C1F000FF;
	Fri, 11 Sep 2026 20:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789157475;
	bh=F3Z0Zyj7x+tWK7x+AyQSVAGvlvDEwHJ0wPLJqCmLBMM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yb6qzDPJP5Kv54L9GYPrO0XtbKPtjLU0W85ok+NWvbo/Fvvb+hOLo+YhpItb7uCvk
	 XQA/2IVVsO3JjEsVu0OIE2qtiLxAeo30m2DCK/CzDOH9zml6n3aDGr4UUpPVS06DmY
	 KPTKPwnMlMsqDr2hsDByNgUYdSgNn9SgTUt+cpCAPDafKXKb6SyajCWJa/tUDOse2j
	 IxLK6Mg5oyZffj9VHM8tt+YvJki9UU3s/ePDwkr/aWhXQG9CEB5jxwhuJw4wBuFezm
	 MO1FrvTKhhowu4+5VxHvdCdnY4VY0W5xzuiqRcdZQeGGFeyhvnRAdcwaZ9KUrWTIOs
	 5zQpgtG1gQEpQ==
Subject: Re: [PATCH net-next 1/8] devlink: fix the enum behind
 DEVLINK_ATTR_RELOAD_LIMITS
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com
Date: Fri, 11 Sep 2026 20:11:14 +0000
Message-ID: <178915747406.219967.256851610035093217@kernel.org>
In-Reply-To: <20260910200312.2665792-2-kuba@kernel.org>
References: <20260910200312.2665792-2-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Commit message does not describe one of the three spec hunks it
  carries.

--

devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS

The devlink spec described DEVLINK_ATTR_RELOAD_LIMITS as carrying enum
devlink_reload_action, while the kernel actually puts enum
devlink_reload_limit there.  A new reload-limit enum is added and the
generated policy mask changes from 6 to 3.

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

> @@ -793,6 +805,7 @@ attribute-sets:
>        -
>          name: reload-stats-limit
>          type: u8
> +        enum: reload-limit

[Severity: Low]
This isn't a bug, but should the commit message also mention this hunk?
The subject and body only talk about DEVLINK_ATTR_RELOAD_LIMITS, and the
word "stats" doesn't appear anywhere in the log, yet reload-stats-limit
(DEVLINK_ATTR_RELOAD_STATS_LIMIT) gets annotated here too.

The annotation itself looks correct - devlink_reload_stat_put() does:

	if (nla_put_u8(msg, DEVLINK_ATTR_RELOAD_STATS_LIMIT, limit) ||

with limit iterated over the devlink_reload_limit range, and the attribute
only appears in the dl-reload-stats-entry reply subset, so net/devlink/
netlink_gen.c is untouched for it.

It does change what spec-generated userspace prints, though.  ynl's
_decode_enum() renders any attribute carrying an "enum" key symbolically,
so "devlink dev get" replies now show reload-stats-limit as unspec/no-reset
rather than a plain integer.

Similarly, for reload-limits the symbolic name that generated clients
accept and emit for bit 1 changes from driver-reinit to no-reset via
_encode_enum().

The statement "AFAICT this is a cosmetic change" holds for the kernel side,
but would it be worth spelling out these two tooling-visible output changes
so backporters know what to expect?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910200312.2665792-1-kuba%40kernel.org
