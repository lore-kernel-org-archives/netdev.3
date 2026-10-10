Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B83D348C;
	Sat, 10 Oct 2026 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652469; cv=none; b=nuSAElkR+GzA4NOEDuigbSze09r0q5Ry14Rb+D6+CWuj74u5oh9k2m9l69aBO8/4Y0kC8RSd03B1Nqd5rLGVc9twFZbGbHA1rUUBuoC+93JtbiMCdEKlla5Ct4JeAmC4+gpV23onuU/BFdDwX8c6M75C4iU2sMFb6X+Dd7EU12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652469; c=relaxed/simple;
	bh=RJwUhHKEs5Zjin58okHJDb0berlaXfE/kay/fcoBIkw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6LDyFXtiQEr4gp0nJbcA8UCi7u4Jl7gYJ5QQRfN0T9AL0/TyHa+S/aWRcuR5KL3gSRuHFwQTdsCjcs3ZHpjOE9kxIPHxOJzH988y1ZYX8AXDg61PWDFxJhbKoRwRFWDHUcKYLA7AzrZFL41ULmVY1zHCFTqXdkxhQAG+ltZDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhbk6Ovd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhbk6Ovd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B27A1F00893;
	Sat, 10 Oct 2026 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791652467;
	bh=2N+yeKv6yFhpJKpS1sxzlUBmMYrZgbvPje0Y56MtKco=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nhbk6OvdqAjf7oJ7xCLMBdwEc2YJ6ZVV8ghX4wBELfsaXrqqG0zsZLhpJI0hitgcz
	 sT/m4UibJh0UjCtufCOUoEZ3lqbaD74WNCh0VWxA13TYsyJXiLIJQycB/Ehh69kfV4
	 qZW4GmQq/NMJ4+mGx5D/kTtoBN9rYtLT4i+7DU/UR25E9bWTFvrxdtFn3s1d3PZMme
	 uQNWO/CqP2GHAJYqN8MgJy76MWW7f9YScAE5k9E9rSNO1xMqIVw5f9IEDWxB2xcIUz
	 uzSPKnXIc/5fC0mRmyumYzfUksWTrwSCNNqLq2uUtPdJB7W+6V2ZZz/6/vyh9LCkxl
	 RTDRzts0WptoQ==
Subject: Re: [PATCH net-next v3 4/4] net: dsa: motorcomm: Add TC prio support
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 17:14:26 +0000
Message-ID: <179165246658.434549.13789649791572206324@kernel.org>
In-Reply-To: <20261009165825.359259-5-mmyangfl@gmail.com>
References: <20261009165825.359259-5-mmyangfl@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: dsa: motorcomm: strict TC priority modulo check breaks
  auto-allocation

--

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c
> @@ -1042,6 +1045,36 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* Lower TC priorities take precedence, while larger orders win in
> +	 * hardware. Spread the 512 hardware orders over the TC priority range
> +	 * as evenly as possible, retaining the relative order:
> +	 *
> +	 *   prio 65535 -> ORD 0    catchall filter
> +	 *   prio 65408 -> ORD 1    highest mappable TC priority
> +	 *   ...
> +	 *   prio 49152 -> ORD 128  default value for the first tc flower rule
> +	 *   ...
> +	 *   prio   128 -> ORD 511
> +	 *   prio     0             (invalid TC priority)
> +	 *
> +	 * The catchall filter always comes with priority 65535; pin it to ORD
> +	 * 0, the lowest hardware order, instead of rejecting it.
> +	 *
> +	 * Prefer explicit rejects over implicit behaviour changes: reject
> +	 * the priorities which do not map onto a hardware order instead of
> +	 * silently colliding with a neighbouring one.
> +	 */
> +	if (prio == U16_MAX) {
> +		ord = 0;
> +	} else if (!(prio % scale)) {
> +		ord = YT921X_ACL_ORD_NUM - prio / scale;
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Invalid priority %u, must be a multiple of %u or 65535",
> +				       prio, scale);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
>  	if (res)
>  		return res;

[Severity: Medium]
This rejects every priority that is not a multiple of 128, but the
kernel's own auto-allocation does not produce such values.

When a filter is added without an explicit pref, tcf_auto_prio() in
net/sched/cls_api.c gives the first filter 49152. Each later filter
gets the previous priority minus one, so the second gets 49151, the
third 49150, and so on.

With this patch, the first plain "tc filter add ... flower" on a port
is offloaded at ORD 128. Every following one added without pref then
fails here with -EOPNOTSUPP:

  - With skip_sw this is a hard failure for a very common usage
    pattern.
  - Without skip_sw the rule quietly stays software-only.

Before this patch the same sequence was offloaded, with every rule at
ORD 0. That makes this a behaviour regression for anyone who does not
hand-pick prefs in steps of 128.

Is a fixed linear prio-to-ORD mapping really what we want here? For
example, could yt921x_acl_rule_ext_parse_flow() assign hardware
orders from the relative priority of the rules currently installed?
Or could it at least handle the auto-allocated range below 49152
sensibly? I'd like to understand how you expect users to drive this
in practice.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009165825.359259-1-mmyangfl%40gmail.com
