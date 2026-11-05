Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883348;
	b=45VAZbV/ozpnZcUY/3oxHoBOIYfOhGsW5LL5De54Tzvs025ZlhEAgk7NMubNMV1VrKYL
	 1twmx7mMU8dyqKhDjXiHMtGkijl3+8ZxBRdLPBnZcFs1Jsnq5VDkXHAosCxAN3bqVGsP8
	 xlLjIw1ssRvNpDwPiKm0H1zCI4o8Yla3BsJAcpHYZO/a03VchxEDLVzuZo4PAw0Q5pvsj
	 uXjK7LRfEkfBGOwP45kzieCeqpI/5GhVxrdiU3jnFDl+H7dsUmmeXh6VXDdw9u/jX3WJL
	 BnAFMFW4SvwqFSO7bCRor++ex0B4UWrGHdw5+p5fCwG95di+CgWeLrUArt8r6WPbQYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883348;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JS5ZQnmESf8ejrit4kpZwlKBJ6iIvHO90kMG7h+R+LA=;
	b=NS1Mh6rmZvw9WN5oEWniJACIHvIiYoqILbtuiZoWSeey3NpFJf5xqhkPwVqRy1t0DS7q
	 yowsjbxmqCfDmwWONReixeIL5uT5xl9Is93l++p5j6f142D5QLT5C/dBNm5WJ0xwcDfxF
	 6Weakn53QfKodYaTXXNnRayhzEISgBIDkGINMtx8D3VjKu1EsbNPQa6tQEsaGGqnzXAgR
	 9tv7wXJY5dq9+VPXRyUc0sY1nzTbZEi/oBtE3I/AYn8/ro90W5tWbd6GexvbPZtY4RPGM
	 npGaobxEhzEzekGp5BXTLVxY9zoocagydDvil2lZbEVPal3WJPQiaQv03VSMZmsiFjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTCFgjvw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6D606A31B;
	Thu,  5 Nov 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTCFgjvw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57361F000C1;
	Thu,  5 Nov 2026 12:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883348;
	bh=JS5ZQnmESf8ejrit4kpZwlKBJ6iIvHO90kMG7h+R+LA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jTCFgjvw9bQot0SfzH4ZrjEsWIzphlgvPYgb7ckm2PXyvD1VGuOQXL2/ktOaB32sx
	 PQEnxdk/5ZaWX8rsyXbUYUNtxBbU3B34PdpBOZN2d8eKCDikP8jaeNGKk8zAprSkTP
	 pUdqqPek1lN72dTmFu/n2aBF3PeNK9cSjGGZBWJCSyOEv3QAOLdW5DQoZd7SbFVc26
	 QF8GDKvwzH33FXkIdbnO+J1NORmx0Sngf0XqzQ0urYMgs49/pJK7TPmryllBEI2AKY
	 WC1TW48r7CpXhuMNGkShWy1Ry5DVTKqleJz3MxQIRrmtN6gzuP6+HqnUKMeAw3ye6k
	 WK6D4h7WpGWMg==
Subject: Re: [PATCH net v2 2/3] net: dsa: motorcomm: Resolve the flower action
 list to one ACL verdict
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 12:55:47 +0000
Message-ID: <179388334724.488856.1648713655214284192@kernel.org>
In-Reply-To: <20261103095514.338700-3-mmyangfl@gmail.com>
References: <20261103095514.338700-3-mmyangfl@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch says it makes the ACL use one verdict, the first
  terminal action.

--

net: dsa: motorcomm: Resolve the flower action list to one ACL verdict

This commit changes yt921x_acl_rule_ext_parse_flow_action() to resolve
the flower action list against its first terminal action, so a later
action no longer overrides an earlier verdict. Consecutive redirects are
still merged into the destination port mask. Other actions that follow a
redirect are rejected under skip_sw, or trapped to the CPU otherwise.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 8835907366bf7..5d2db04f3385d 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

>  	memset(action, 0, 3 * sizeof(*action));
> -	flow_action_for_each(i, act, flow_action)
> +	flow_action_for_each(i, act, flow_action) {
> +		/* Only another redirect, or a drop, can follow a redirect: a
> +		 * drop is an empty destination set, so the software verdict is
> +		 * the same whichever control the redirect carries.
> +		 */
> +		if (redir && act->id != FLOW_ACTION_REDIRECT &&
> +		    act->id != FLOW_ACTION_DROP) {
> +			reason = "Action after redirect";
> +			goto fallback;
> +		}
> +

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
> +			redir = true;
>  			break;
> +		}

[Severity: High]
Can a later redirect still widen the verdict of an earlier one here?

The guard at the top of the loop lets a second FLOW_ACTION_REDIRECT
through after a redirect. This case then ORs another DPORTn bit into
action[2] and does not set terminal.

The comment on the guard only explains why a drop gives the same result
whatever the redirect's control is. That does not hold for a second
redirect: with STOLEN only the first port gets the packet, and with PIPE
both ports do.

Take a filter like:

  tc filter add dev swp0 ingress flower skip_sw ... \
    action mirred egress redirect dev swp1 \
    action mirred egress redirect dev swp2

iproute2 sets the redirect control to TC_ACT_STOLEN by default. In
software at ingress, tcf_mirred_can_reinsert(TC_ACT_STOLEN) is true. So
tcf_mirred_to_dev() sends the skb itself to swp1 without cloning it and
returns TC_ACT_CONSUMED. tcf_action_exec() then stops:

net/sched/act_api.c:tcf_action_exec() {
    ...
		if (ret != TC_ACT_PIPE)
			break;
    ...
}

The second redirect never runs.

The driver still accepts this rule, even with skip_sw. It programs the
hardware with FWD_REDIR and DPORTS = {swp1, swp2}, so matched frames are
also sent to swp2.

Dropping skip_sw gives the same result. A hardware redirect never reaches
the CPU, so software has no chance to correct it.

The commit message says:

    Consecutive redirects merge into the destination port mask, since a flow
    action entry carries no mirred control verdict to tell whether software
    would have continued; an action asking for a second decision is rejected
    when skip_sw is set and left to the software path otherwise.

tcf_mirred_offload_act_setup() only fills in entry->id and entry->dev, so
the driver cannot tell which case it has. Merging the ports picks the
PIPE behaviour.

Would it be better to send a second FLOW_ACTION_REDIRECT through the same
fallback path as other actions after a redirect? It would then be
rejected under skip_sw and trapped to the CPU otherwise.

The later patch in this series, "net: dsa: motorcomm: Delete the ACL rule
of the port being unbound", only changes yt921x_acl_find() and
yt921x_acl_del(). The merge is still in place at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103095514.338700-1-mmyangfl%40gmail.com
