Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEC377A94;
	Sat, 10 Oct 2026 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652467; cv=none; b=Q0BQBytdVkqx9XpInSlXJXV1Zr7INBh7EGRwa5qFUGSzVIKg3bcSuOwnB4qrZ5kTZnxI7/Gw74Ab0BKjA36QIRkEglM/LnDC/E8QN9EqZpQqsfiCYFvvfv0ap15f2sLN0aoZ/YIx0J0ixJKvK6ypDVA+BkIk1fX/x9w1g+Y2Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652467; c=relaxed/simple;
	bh=CJJoicskXSGYp/KsD+J6ib+jSiU28q6zpPQVxpeXS3w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fsb8GnVRyVPPSFg4d2Ki94LXFld6DmcL4t9Y0V4Y9zxQYx89xd00kZEiSScum3Jw2KicEAxRjpmjEg8MTIT2cd3uS3oUqOCkQVPFJJ97Kd6qtdY/PhS4A/K4KR950NVDnVp6hxsYEHZg/YXJu17NiTLv6NFC0jkBaUSq7xUiHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/quJQor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/quJQor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D500D1F000FF;
	Sat, 10 Oct 2026 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791652466;
	bh=HKa4JiqF0+/2LRJ+8/pMo/reGY7PgjtM2k74Lj8/bOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P/quJQornjcb2kxVa13kdrsiFqccdB8WcEVN9WKqhtIJRPTO7WzyoQR5AFngw82DF
	 gipc7zUUHO7gt0w/mlqNEwoRynQ8R1nP+qHFbOtQdRMkBMMyarm307y60B6HrVBxGk
	 p1y9pKIfL1pN+D6QTOQ2er7XDwWk/yRrjHQp2cH/7pgjRkDQvzmM3nChPqcxFqq7J6
	 v4OLVfxXDnBl95NM61PhDCzrqUi+svoQeH8kXfKAnEaBYTFIlmBbiRDnIWuMBieMX5
	 VuBI84eLLyv/QB3/39nKeKur26/Yft1FvIQaoQqiTSIycIl1bkyMtj0TeiHJTyrsM0
	 ss7bCc3pYGfVA==
Subject: Re: [PATCH net-next v3 3/4] net: dsa: motorcomm: Enable ACL on demand
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 17:14:25 +0000
Message-ID: <179165246530.434549.12778326998429626605@kernel.org>
In-Reply-To: <20261009165825.359259-4-mmyangfl@gmail.com>
References: <20261009165825.359259-4-mmyangfl@gmail.com>
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

- [Low] yt921x_acl_add() in drivers/net/dsa/motorcomm/tc.c writes
  YT921X_ACL_PORT before the rule is programmed.

--

net: dsa: motorcomm: Enable ACL on demand

This commit adds a per-port acl_cnt to struct yt921x_port. It now writes
YT921X_ACL_PORT only for ports that have ACL rules, instead of enabling
ACL on all ports at setup time. The register is updated from
yt921x_acl_add() and yt921x_acl_del() when a port's rule count goes from
zero to non-zero or back.

> diff --git a/drivers/net/dsa/motorcomm/tc.c b/drivers/net/dsa/motorcomm/tc.c
> index be3321df88683..a302016912b5f 100644
> --- a/drivers/net/dsa/motorcomm/tc.c
> +++ b/drivers/net/dsa/motorcomm/tc.c

[ ... ]

> @@ -1312,21 +1349,39 @@ yt921x_acl_add(struct yt921x_priv *priv,
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
> +			goto err;
> +	}
> +
>  	/* Write rules */
>  	aclblk->rules[binid] = aclrule;
>  	res = yt921x_acl_commit(priv, entid, aclrule->mask);
>  	if (res) {
>  		aclblk->rules[binid] = NULL;
> -		kvfree(aclrule);
>  		goto err;
>  	}
>  
> +	/* Bookkeeping */
> +	m = FIELD_GET(YT921X_ACL_KEYb_SPORTS_M, ruleext->r.entries[0].key[1]);
> +	for_each_set_bit(o, &m, YT921X_PORT_NUM)
> +		priv->ports[o].acl_cnt++;
> +
>  	if (meterid < YT921X_METER_NUM)
>  		set_bit(meterid, priv->meters_map);
>  	priv->acl_masks[blkid] |= aclrule->mask;
>  	return 0;
>  
>  err:
> +	kvfree(aclrule);
>  	if (!priv->acl_masks[blkid]) {
>  		kvfree(aclblk);
>  		priv->acl_blks[blkid] = NULL;

[Severity: Low]
If yt921x_acl_commit() fails here, should YT921X_ACL_PORT be restored
before returning?

The enable bits for the new rule's source ports have already been written
by then. The err path frees aclrule (and aclblk if it is now empty), but
it doesn't write YT921X_ACL_PORT back to yt921x_acl_activated_ports(priv).

acl_cnt++ only runs on success, so the driver counts zero rules on those
ports while the hardware still has ACL lookup enabled on them.
yt921x_acl_find() can no longer find the rejected rule, so it can't be
deleted to clean this up.

yt921x_acl_commit() writes several registers in sequence (ACT, BLK_CMD
modify, KEY/MASK, BLK_KEEP, ACLn_ENTRY, BLK_CMD commit), and any of those
writes can fail.

yt921x_acl_del() can end up in the same state:

	if (refresh_en) {
		ctrl = yt921x_acl_activated_ports(priv);
		res = yt921x_reg_write(priv, YT921X_ACL_PORT, ctrl);
		if (res)
			ret = res;
	}

If this write fails after the last rule on a port took acl_cnt to 0, the
rule is still freed. The enable bit stays set, and a second delete
returns -ENOENT.

After either failure, YT921X_ACL_PORT stays wider than
yt921x_acl_activated_ports() until some later add or delete happens to
rewrite it. If that never happens, those ports keep the extra ACL lookup
latency that this patch is meant to remove.

These paths are also unchanged later in the series. "net: dsa:
motorcomm: Add TC prio support" doesn't touch them.

Would it make sense to rewrite YT921X_ACL_PORT from
yt921x_acl_activated_ports() on the add error path?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009165825.359259-1-mmyangfl%40gmail.com
