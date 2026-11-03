Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692527;
	b=HsiM7SUcz5uLz/oniriHwLO9qffwXRBLeeN6T1fht6BxciGU79bjszmWt1ElUPemdLIM
	 ocFHRhNdhhb6L/0tRI6GSMHWG1nvIOe10wAtf+cHaiJ6llQFC9KR7TfsYXOhTfTXzaBKM
	 pSZcgajlb7ozUmrS3DoG8URQQsLShZq9+EkwAXeLwGybcJQf1k2FMS8RfVi7WH9x6FWfm
	 ebZcf0+kdhL0mQI59bj5hwSkZBh+C4rdGvHv6jpujStsP/IUAyKbVvXsHxEXAXMNtnpTa
	 WXe5OYIGvPzcNnJwL9d2wK8mv/xYrB5gPI1Tm+Akhlnfywt4OccEAkiwdYlxPp1rNyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692527;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=J3EqXJWGjkAsAvw07eKHIe6sQJcMLriSAeBSrcYRCYU=;
	b=DNEnAl6YBTlCKOui4P9yLWDG7veNfBgqHeP1AlVpdUT3vHiZi4QFP1ufdzBKS/iVCgAF
	 3wNW8pV3Zq9cVm11oBmLXDuSPG9isNECYNOIBYIErNKSnUz+GYh1UwOJ6u/Wol9spWH1g
	 MSKw5r5CPb26M4klDXuScHSWp9qvI3ztlkCph6x1lnsmY2aOlFjaj1ywrtrJ7UdB6E3nN
	 jOEgEV24CpVGWQpXc1Q0bKFDQli0XQcJQajtoKXAStFpNHRrIh8Kj94NE+x+5pTQJE8X/
	 4o8ztS+sEolQJJCadg5NXWbYyZV1ggpd2IFLn+AU/6Ntf2JIL6BrFH8wL1BPXrNi55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQXjsPky;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F373606A324;
	Tue,  3 Nov 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQXjsPky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926031F000C1;
	Tue,  3 Nov 2026 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692527;
	bh=J3EqXJWGjkAsAvw07eKHIe6sQJcMLriSAeBSrcYRCYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dQXjsPkyUMa/rDVks3sqceLKoQds1TXQ0p+y3QXng1BfoH9kaMje3lD6UCzIw/oDG
	 atdIwWK5KrpXfBnQe6ZBNxx3j7T6F2uDN6Eyvo1c9d61nL/zuSEbJ3kJnkc1BMFN8c
	 bL1suTkIUyXcfbbxAXlmFVXET2Snfrc6yCH7xDbR57Au9/DaJ35wVW0yqdeaM+YFZA
	 5vcWlPeKvTvxIRWlexsZROpS5ArsHxw2yRXUpIbDrTt2YURIl3HlrvU5RiioYwOn14
	 RlNj9oViNRPqpjiLZn5j0NBVzvcjcPwoLpleJuMtUDpqm3QhfNzeL3ryd+9Op1zwV8
	 gZzFVB51s6PHw==
Subject: Re: [PATCH net 3/4] net: dsa: motorcomm: Stop at the first terminal
 flower action
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 07:55:26 +0000
Message-ID: <179369252617.488856.6718577731969033249@kernel.org>
In-Reply-To: <20261102071119.3435180-4-mmyangfl@gmail.com>
References: <20261102071119.3435180-4-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In yt921x_acl_rule_ext_parse_flow_action()
  (drivers/net/dsa/motorcomm/tc.c), the patch now treats every…

--

net: dsa: motorcomm: Stop at the first terminal flower action

This commit changes yt921x_acl_rule_ext_parse_flow_action() so that it
stops at the first terminal action in the flower action list (accept,
drop, redirect or trap). A later action can then no longer override the
hardware verdict of an earlier one.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 5a4459507582d..87c04f0dd7365 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c
> @@ -1038,55 +1038,43 @@ yt921x_acl_rule_ext_parse_flow_action(struct yt921x_acl_rule_ext *ruleext,

[ ... ]

> +		case FLOW_ACTION_REDIRECT: {
> +			struct dsa_port *to_dp;
> +
> +			to_dp = dsa_port_from_netdev(act->dev);
> +			if (IS_ERR(to_dp) || to_dp->ds != &priv->ds) {
> +				reason = "Redirect to non-local port";
>  				goto fallback;
>  			}

[ ... ]

> +			action[2] |= YT921X_ACL_ACTc_FWD_EN |
> +				     YT921X_ACL_ACTc_FWD_REDIR |
> +				     YT921X_ACL_ACTc_FWD_REDIR_DPORTn(to_dp->index);
> +			terminal = true;
>  			break;
> +		}

[Severity: Medium]
Is it safe to treat every FLOW_ACTION_REDIRECT as terminal here?

The flow_action_entry does not carry the mirred control verdict. For any
egress redirect, tcf_mirred_offload_act_setup() emits FLOW_ACTION_REDIRECT
and does not look at m->tcf_action:

net/sched/act_mirred.c:tcf_mirred_offload_act_setup() {
    ...
		if (is_tcf_mirred_egress_redirect(act)) {
			entry->id = FLOW_ACTION_REDIRECT;
			tcf_offload_mirred_get_dev(entry, act);
    ...
}

A redirect with the pipe control is not terminal in software.
tcf_mirred_init() accepts TC_ACT_PIPE through tcf_action_check_ctrlact().
In tcf_mirred_to_dev(), tcf_mirred_can_reinsert(TC_ACT_PIPE) returns
false, so the skb is cloned and the clone is sent. TC_ACT_PIPE is then
returned and the remaining actions run.

For example:

  tc filter add dev swp0 ingress flower skip_sw \
    action mirred egress redirect dev swp1 pipe \
    action mirred egress redirect dev swp2

In software this delivers to both swp1 and swp2. Before this patch the
hardware ORed both DPORTn bits, which matched software. With this patch
the loop exits at the if (terminal) break after the first redirect. Only
swp1 gets programmed, and the rule is accepted with no error and no
extack warning.

The same applies to "redirect dev swp1 pipe action trap". In software
that sends a copy to swp1 and also traps to the CPU. In hardware it would
now only redirect to swp1.

The driver cannot tell stolen apart from pipe. Could a redirect followed
by more actions be rejected under skip_sw, and fall back to trap
otherwise, instead of programming only part of the list? That would
match the "Prefer explicit rejects over implicit behaviour changes"
policy in yt921x_acl_rule_ext_parse_flow(). In the default stolen case
the actions after the redirect never run in software anyway, so
rejecting them loses nothing.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102071119.3435180-1-mmyangfl%40gmail.com
