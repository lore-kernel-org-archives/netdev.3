Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2841378A;
	Wed, 29 Jul 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323016; cv=none; b=QwQjP0LIs4oVYsoh0ApLpHCpNQ8YGLOhe+Xy+3YNvfVaqQ0Hyktyo86TY9lXFnqMi2MtnPXJEfU/im202bOvJauXIZFx1JZB3h9lFllSN/7v1KxJCvtbA/xN6hm2mcoj8Fks+ygc+rUmvuvcC0Xlo1iGELxZwtIHPfuNsIP4jFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323016; c=relaxed/simple;
	bh=A537bd/0KixpX+7fjlPVBDhsbTsdueLdc0Q+9BWm5qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3RNBcS0y3SmDAAlgt1Osb2iIplwS5G5sJ6Oledo+zVRgb6pZgfIawpCuS8KIi1xOXSpvkYu7DnQ4J4ssDMeUQxBi6laNsoyrT3s6QoM7hwdcs0Dy/8Rtvdqlg8uDjTlrHiAbj1xG2R0iNbopUSWLGTsLYKjWPWZWAum91Z2QNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDrhp9NC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDrhp9NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650A31F00A3A;
	Wed, 29 Jul 2026 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785323015;
	bh=N7RiY82551cvd68hZZYA1yRSe2CYV2J4qaqo0HGIN5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jDrhp9NCXYL7RLKXn53b+3FwH8obdIciv5D6lTlGTbPl3C4BuzCwWIj/Z6uKzjkKX
	 sdZDOCa4PSufo0mNB2rnKs0HCASYHuYe+ikc8Jy8hV5pHP6TVFqIU5mQqPlMH92NzY
	 pAp73/kJUfLwg+Jl1xnO5fKehukLoDs3CW215/6zSGI7WI4UEQYLKc9p5j8R0pjpWw
	 2IqH12b17O8LyxOmSlEakqhusDKp9IHmYeDqFde9g+8KWdJkNH1dWGBA6RVkgIiVMk
	 J/XyQLpNkkpFbVeoOprOaYAroyZDOX1fsjmRmo32T1sqlj7w6eMRsGfNZZxkZhcFk+
	 c2ShY1WA3E79Q==
Date: Wed, 29 Jul 2026 12:03:28 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	yangshuaisong@h-partners.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net] net: hns3: fix speed configuration residue after
 driver reload
Message-ID: <20260729110240.GA76598@horms.kernel.org>
References: <20260724093036.426631-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093036.426631-1-shaojijie@huawei.com>

On Fri, Jul 24, 2026 at 05:30:36PM +0800, Jijie Shao wrote:
> After setting a 100G optical port to 40G via ethtool and reloading
> the driver, the port remains at 40G instead of reverting to the
> firmware default speed of 100G.
> 
> The commit referenced in Fixes: added two overwrites in
> hclge_init_ae_dev() for non-copper media, so that optical ports
> connected to forced-mode remotes inherit the firmware-preset
> autoneg and speed instead of the hardcoded defaults:
> 
>   req_autoneg = mac.autoneg
>   req_speed   = mac.speed         (when autoneg disabled)
> 
> The autoneg overwrite keeps existing behavior:
> hclge_set_autoneg_speed_dup() already uses mac.autoneg (not
> req_autoneg) since it was introduced, so autoneg inheritance from
> firmware was already in place. This part is kept.

The AI-generated review on netdev-ai [1] flags that this isn't strictly
true as req_autoneg does appear to be used in hclge_set_autoneg_speed_dup().
I don't want to nitpick, but perhaps this is worth clarifying.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724093036.426631-1-shaojijie%40huawei.com

> The speed overwrite, however, introduces the residue: mac.speed
> reflects whatever was last programmed into the MAC, and after unload
> firmware does not restore the MAC speed to the flash default. So if
> the user changed speed via ethtool in a prior load, mac.speed still
> carries that value on reload and req_speed inherits it.
> 
> Fix by dropping the req_speed overwrite only. req_speed keeps the
> firmware default value set in hclge_configure() (cfg.default_speed),
> so a reload reverts the speed to default, matching the expectation
> that a driver reload resets link configuration.
> 
> Trade-off: on optical ports whose firmware default speed does not
> match a forced-mode remote, reload now drops the link and the user
> must re-apply ethtool configuration. This is acceptable: a driver
> reload is expected to reset link configuration, not to inherit
> runtime state from before unload. The autoneg inheritance is left
> in place as established behavior; changing it is out of scope for
> this patch and would itself be a user-perceivable behavior change.
> 
> Fixes: d9d349c4e8a0 ("net: hns3: differentiate autoneg default values between copper and fiber")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> v3:
>  - Expand commit message to explain the two overwrites added by the
>    Fixes commit: req_autoneg inheritance is kept because it matches
>    existing behavior of hclge_set_autoneg_speed_dup(); req_speed
>    sync is dropped because it introduces the reported residue.
>  - State explicitly that link loss on forced-mode optical ports after
>    reload is acceptable, since a driver reload is expected to reset
>    link configuration rather than inherit runtime state.
>  - Explain why autoneg inheritance is left unchanged: it is
>    established behavior, and changing it is out of scope and would
>    be user-perceivable.

...
