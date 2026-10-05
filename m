Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1453E6399;
	Mon,  5 Oct 2026 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234987; cv=none; b=a2MhH3qPKZt9hrrC2YqF+4Da50ykzsCmPjRbrfrSGuNjFONhMBHM7P+mzlxGZ0s6uSYSxI4/PySEh0eA3U6tjiPDWH7uVq8DyxIheRtLnD8FluDh1QwglQpNxIj/PXi6LPRtMYjxGh63mWSoEi7QOcon3lLrhgIdl+bxuuviiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234987; c=relaxed/simple;
	bh=LKqxqP3RUQBG9og/AmS/0Q44GkC2P4kE850DriM2Mg4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ra+LKwrmeWOasBVMTiJ9YGjNTOFa2kAuHpwJTS8NsJa4/ln1bY/itC+YJIHiz0qKcfky3+CMnk45ca7FojVzO1TuiN10WIr4ltHW+xOOEDLf5LdItv2Lf16/8Oge7foiSTplPgmZjqWTrYhZFigEvJB9tMKndCXh40B7OlElpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krbm7OE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krbm7OE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392881F000FF;
	Mon,  5 Oct 2026 21:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234983;
	bh=EXR1qKKMk+np4wJq294kSw3N5QRAYuFcYUXT3Ki3oak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Krbm7OE4xVhk2I8+KrkCybYmL9lUrXCJO9IAZ4nat/qtPdo+klILx1UPcVddyBijy
	 SKFCiu3L4g2uifTc/mfXNoYlvtVDq4GGZmoBgvWLayinX0PKTdL8lJcmvP2KA4OQUc
	 DwxFNXt1Y96wwLuGwwut2Te7B093STE7xBnV69lYVIBbgxwqZEYvSXXrSK9tO+HQ+s
	 2ZY7NBIezH2+TsrVJL/JEKlkzpwoiPqHIkJeEjq7RI9w2mj2DU4FltXHSGxy1IBrVs
	 uUN/Y2SQJT2KrnubHSa/10aHk0LTz4rze8lSpQj1pnRQWME2S8wwUsrA/1D1l/JKjZ
	 4VSfZIazXrkFg==
Subject: Re: [PATCH net-next v2 4/5] net: dsa: motorcomm: Enable ACL on demand
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 21:16:22 +0000
Message-ID: <179123498276.434549.11929737907865657185@kernel.org>
In-Reply-To: <20261001204851.2576101-5-mmyangfl@gmail.com>
References: <20261001204851.2576101-5-mmyangfl@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Memory leak on an error path in yt921x_acl_add()
  (drivers/net/dsa/motorcomm/tc.c).
- [Low] The hardware ACL port-enable register can disagree with the
  software acl_cnt bookkeeping after errors.

--

net: dsa: motorcomm: Enable ACL on demand

This patch stops yt921x_chip_setup_acl() from enabling ACL on all ports.
It adds a per-port acl_cnt counter instead. yt921x_acl_add() sets a
port's YT921X_ACL_PORT bit when the port gets its first rule, and
yt921x_acl_del() refreshes the register once the last rule for that
port is removed.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index 0e5f19a39d0cc..95ed0f245b1fa 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

> @@ -1312,6 +1347,19 @@ yt921x_acl_add(struct yt921x_priv *priv,
>  	else
>  		aclrule->action[0] &= ~YT921X_ACL_ACTa_METER_EN;
>  
> +	/* Activate ACL if needed */
> +	ctrl = 0;
> +	m = FIELD_GET(YT921X_ACL_KEYb_SPORTS_M, ruleext->r.entries[0].key[1]);
> +	for_each_set_bit(o, &m, YT921X_PORT_NUM)
> +		if (!priv->ports[o].acl_cnt)
> +			ctrl |= YT921X_ACL_PORT_PORTn(o);
> +	if (ctrl) {
> +		ctrl |= yt921x_acl_activated_ports(priv);
> +		res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
> +		if (res)
> +			return res;

[Severity: Medium]
Does this early return leak aclrule?

At this point aclrule has already been allocated by kvmemdup(), but it
hasn't been stored in aclblk->rules[binid] yet:

	aclrule = kvmemdup(&ruleext->r,
			   offsetof(struct yt921x_acl_rule, entries[entscnt]),
			   GFP_KERNEL);

The teardown in chip.c only frees rules it can reach through
priv->acl_blks[]->rules[], so nothing would ever free this one.

The return also skips the err: label:

err:
	if (!priv->acl_masks[blkid]) {
		kvfree(aclblk);
		priv->acl_blks[blkid] = NULL;
	}

If aclblk was freshly allocated for this rule, it stays in
priv->acl_blks[blkid] even though the block is empty. That isn't a
permanent leak, since a later add can reuse it and remove frees it.

This happens when a source port has acl_cnt == 0 and the YT921X_ACL_PORT
write fails. Should this path do kvfree(aclrule) and then goto err,
like the yt921x_acl_commit() failure path does?

> +	}
> +
>  	/* Write rules */
>  	aclblk->rules[binid] = aclrule;
>  	res = yt921x_acl_commit(priv, entid, aclrule->mask);

[Severity: Low]
Can YT921X_ACL_PORT end up out of sync with acl_cnt here?

The port bits are set in hardware before yt921x_acl_commit() runs. If
any register write inside yt921x_acl_commit() fails, the existing error
branch only rolls back software state:

	if (res) {
		aclblk->rules[binid] = NULL;
		kvfree(aclrule);
		goto err;
	}

acl_cnt++ only runs after a successful commit. So the port stays
ACL-enabled in hardware while acl_cnt for it is still 0.

yt921x_acl_del() has the same problem in reverse. acl_cnt is decremented
to 0 first, and then the register is refreshed:

	if (refresh_en) {
		ctrl = yt921x_acl_activated_ports(priv);
		res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
		if (res)
			ret = res;
	}

If that write fails, the bit stays set while software counts no rules
on the port.

In both cases the stale bit is only cleared when a later add or del
rewrites the whole register. Unmatched traffic is still permitted
because YT921X_ACL_PERMIT_UNMATCH is set for all ports, but the port
keeps doing ACL lookups when ACL isn't "actually used" on it.

Should the yt921x_acl_add() commit failure path write
yt921x_acl_activated_ports(priv) back to YT921X_ACL_PORT?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001204851.2576101-1-mmyangfl%40gmail.com
