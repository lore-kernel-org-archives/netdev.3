Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD43373C00;
	Wed, 30 Sep 2026 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738381; cv=none; b=RfyfEPcVsUCRwePBt/9US+jt8vCPwGBFYD6cqrrl3Md2rNns8Qm1IDBabFjRe7R4Q+lqISV8HJ0iWvLMMYSRllSZ2c8zMijM/roVge+zeAdDRhiSAIF4poGbh81hbPegeC/lIpq94x/DqYM6kMvtMP0NQQCKd/UUVnOy2168Brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738381; c=relaxed/simple;
	bh=w2tciQRLjrSSH6dVlp0heKb2b7Hs4V2niXWzk4kRIQk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHMrZPHRaYc0aVxwnd5lwvzAGJRRRo0zCLTnKmx1n9oVrx4ps4smXWhJHv++iefxq9Ew/P1pS7GWuMwi6UgEhv2CW4Qb9gbZb4pEp9xi4Q5mmCfjY/ZxDu5GpLv38JY32Cl//ERkHhGb1xu/N1078nl0llleUC1TzeqU2FC95pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdVKQHCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdVKQHCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AA01F00898;
	Wed, 30 Sep 2026 03:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790738380;
	bh=svEgjxFMZxxqSZCzCKNg72dlRINSbLGcGTsgvfAwLPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IdVKQHCOSu0cjxKOHRTIvIDxOG42FkQ56Uip01LQfVaivp9Y2JwH8/dMrexw5fQTs
	 X7kzeSBKvVsLsjsEquvSXZ1rdyi8IrUuhYNxXUgJhOS2ZiEACyyUwQs9BFihLbH/4B
	 8kzPFzxqYzeL3datQDVbXv4SiB+pYOLuB/Ft+nB7vIPmWqNL10mFxuKp1nUv6dP5Y9
	 SSt20oIx9kOqBJWJwfpTBfCfqUmrov4gK1xvCBJQH83aRd4467q8dUkrHirSlkTybM
	 Z9tfKyln5YvNQjXYxjnmVupyGvv3jsr0rQNoZ1T0I+sXD+dz9657ZjrTGCZ5tIsMgg
	 i0adQYQdoquAQ==
Subject: Re: [PATCH net-next 4/6] net: dsa: motorcomm: Add TC prio support
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 03:19:39 +0000
Message-ID: <179073837912.434549.8278513953634370840@kernel.org>
In-Reply-To: <20260926211813.935723-5-mmyangfl@gmail.com>
References: <20260926211813.935723-5-mmyangfl@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] yt921x_acl_rule_ext_parse_flow() in
  drivers/net/dsa/motorcomm/tc.c now accepts only priorities that are…
- [Low] In yt921x_acl_rule_ext_parse_flow()
  (drivers/net/dsa/motorcomm/tc.c), the extack error reads 'Invalid…

--

net: dsa: motorcomm: Add TC prio support

This commit maps the TC flower priority onto the 512 hardware ACL
priorities. It scales the TC prio by 128, treats 65535 as the catch-all
and rejects any prio that doesn't map onto a hardware priority. It also
renames the ACL key field from ORD to PRIO.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 0f6d7a4675fcd..d919743d89c17 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

> @@ -1032,7 +1032,9 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
>  			       const struct flow_cls_offload *cls, bool ingress,
>  			       struct yt921x_priv *priv)
>  {
> +	const unsigned int scale = (U16_MAX + 1) / YT921X_ACL_PRIO_NUM;
>  	struct netlink_ext_ack *extack = cls->common.extack;
> +	u32 prio = cls->common.prio;
>  	int res;
>  
>  	if (!ingress) {
> @@ -1045,6 +1047,15 @@ yt921x_acl_rule_ext_parse_flow(struct yt921x_acl_rule_ext *ruleext, int port,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (prio == U16_MAX) {
> +		prio++;
> +	} else if (prio % scale) {

[Severity: High]
Does this reject most flower filters that are added without an explicit
pref?

When no prio is given, tc_new_tfilter() sets prio_allocate and picks a
value with tcf_auto_prio():

net/sched/cls_api.c:tcf_auto_prio() {
	u32 first = TC_H_MAKE(0xC0000000U, 0U);

	if (tp)
		first = tp->prio - 1;

	return TC_H_MAJ(first);
}

The first auto-prio filter gets 49152. Each later one gets a new
tcf_proto with the next lower value: 49151, then 49150, and so on.
tc_cls_common_offload_init() passes that value to the driver unchanged,
as cls->common.prio = tp->prio >> 16.

With scale = 65536 / 512 = 128, only the first of those values passes
the prio % scale check. The second one fails with "Invalid priority
49151, must be a multiple of 128".

Before this patch, all of these filters were offloaded with
yt921x_acl_rule_set_ports(&ruleext->r, 0, BIT(port)).

So with a sequence like this:

  tc filter add dev lan1 ingress flower ... skip_sw action drop
  tc filter add dev lan1 ingress flower ... skip_sw action drop

the second command now fails. Without skip_sw, the second filter quietly
stays software-only. Its drop, redirect and police actions then no
longer apply to traffic the switch forwards in hardware on that port.

This check runs before yt921x_acl_rule_ext_parse_flow_action(), so
police-only storm control rules with an auto-allocated prio are rejected
as well.

The commit message says:

  "Notice the default priority for flower is 49152"

That seems to hold only for the first auto-allocated filter in a chain.
Would some kind of relative ordering work better here than a fixed
scale-and-reject mapping?

As far as I can tell, the later patches in the series leave this code
unchanged.

> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Invalid priority %u, must be a multiple of %u",
> +				       prio, scale);

[Severity: Low]
This isn't a bug, but the message says the priority must be a multiple
of 128, while the prio == U16_MAX branch above also accepts 65535. Could
the message mention 65535 too?

> +		return -EOPNOTSUPP;
> +	}
> +
>  	res = yt921x_acl_rule_ext_parse_flow_action(ruleext, cls, priv, port);
>  	if (res)
>  		return res;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926211813.935723-1-mmyangfl%40gmail.com
