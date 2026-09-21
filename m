Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355694E021B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016946; cv=none; b=fqtfq7Meg+xcLwvoNB3hGTxZRpIExAz0BKEguDBxl0vyXfn/PXb1T5N2Mg1ZbIT9ntE1QeCQ7sdfOi3ACuI+Jemt9ZH/FjUDO0LvTHlTtTKRCsZOx3EK5On1IgrBU5jSR1nqOpd0nVLKBB0rQbr3epaG2OmNOO5spl0mxwzlg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016946; c=relaxed/simple;
	bh=KGdnhW4+7cPtfj/RIEL3f4Cr2iziJk4pvMxI10Wu670=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJ3vhnVe0Ont/YVeyIw+8qkbATgx6DOIw/8nR0G4gVZuLxtLkuvkqjnjkbiYHgAI5kWg9fG9AuhKlMub3Cc8WBBQ0b93SBZ17uu7pZK7bQ9QOkFvkDZ2TCyNU159Os7G/kiO58NOejIEcj+gKVNmdwCH6W7ZVLkgaXtuogFa3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2UCXwrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2UCXwrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440301F00893;
	Mon, 21 Sep 2026 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790016944;
	bh=lwg4z5VU5cBHJ5zBaSm51R1+fhnhGfJMW93mSI7TmLg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2UCXwrnwRWbTNzOgBYnziHn3/aKGljteB4i5YS/HgAAJ5ixRMkbmoEFej/nCYjza
	 b6S5qxYgd9D8Gv75bu0B2PfXj1udDL5VkK7ACIq2BTauNQ/kNWwRXmfoaz/Dx7x3cn
	 I1ENOE1c2kQrSedk824q61Wcv/GLSmxuxHouq0plg4sJHlqpgV6iqX1j+/h6Totv4E
	 qOTj//deEfJGaaUloOwuDEc2CreAJXnzTsPO/AkLHvd7ZTwjnWCs+LL/g4rD38I1HS
	 LM4ARuBIWvHECQvxA0syRMRcUGPJYIXTTR9Bq+Dqn70DF0wbZlJeIDLAXe0z83rBUk
	 1W8ptd2c2SXXQ==
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: check the port when
 deleting a policy rule
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, olteanv@gmail.com,
 andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@gmail.com
Date: Mon, 21 Sep 2026 18:55:43 +0000
Message-ID: <179001694385.2160803.5943748264874534397@kernel.org>
In-Reply-To: <20260918185326.3940857-3-kuba@kernel.org>
References: <20260918185326.3940857-3-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Missing `Fixes:` tag.

Pre-existing issues:
- [Medium] In the ETHTOOL_SRXCLSRLDEL path of mv88e6xxx_set_rxnfc() the
  policy object is unlinked from chip->policies (idr_remove(),…

--

net: dsa: mv88e6xxx: check the port when deleting a policy rule

This changes the ETHTOOL_SRXCLSRLDEL path in mv88e6xxx_set_rxnfc() to look
the policy up with idr_find() and only remove it when policy->port matches
the port the request arrived on, so one port can no longer be used as a
handle to delete another port's rule.

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 461167199a71..70411d147677 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -2503,8 +2503,9 @@ static int mv88e6xxx_set_rxnfc(struct dsa_switch *ds, int port,
>  		break;
>  	case ETHTOOL_SRXCLSRLDEL:
>  		err = -ENOENT;
> -		policy = idr_remove(&chip->policies, fs->location);
> -		if (policy) {
> +		policy = idr_find(&chip->policies, fs->location);
> +		if (policy && policy->port == port) {
> +			idr_remove(&chip->policies, fs->location);

[Severity: Medium]
Should this carry a Fixes: tag?

git blame of the pre-image of this hunk attributes the whole delete
sequence to da7dc87553046 ("net: dsa: mv88e6xxx: add RXNFC support"),
which went in for v5.4, so the broken cross-port delete exists in every
stable tree since then.  Without the trailer the stable tooling won't pick
this up:

	Fixes: da7dc87553046 ("net: dsa: mv88e6xxx: add RXNFC support")

>  			policy->action = MV88E6XXX_POLICY_ACTION_NORMAL;
>  			err = mv88e6xxx_policy_apply(chip, port, policy);
>  			devm_kfree(chip->dev, policy);

[Severity: Medium]
This is a pre-existing issue and not something this patch introduces, but
while the delete path is being touched: should the idr_remove() and
devm_kfree() be conditional on mv88e6xxx_policy_apply() succeeding?

mv88e6xxx_policy_apply() can fail on a register/bus error, both in the ATU
rewrite and in the policy register write:

drivers/net/dsa/mv88e6xxx/chip.c:mv88e6xxx_policy_apply() {
	...
		err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
						   state);
		if (err)
			return err;
	...
	return chip->info->ops->port_set_policy(chip, port, mapping, action);
}

In that case the switch still has the ATU entry in
MV88E6XXX_G1_ATU_DATA_STATE_{UC,MC}_STATIC_POLICY and/or still has the
port's policy register mapping DA/SA to DISCARD, but the software object
and its IDR location are already gone.

Does that leave the rule unaddressable from userspace?  ETHTOOL_GRXCLSRLALL
no longer lists it, a retried ETHTOOL_SRXCLSRLDEL now returns -ENOENT
because idr_find() returns NULL, and the still-programmed mapping is
invisible to the in-use scan at the end of mv88e6xxx_policy_apply():

	if (action == MV88E6XXX_POLICY_ACTION_NORMAL)
		idr_for_each_entry(&chip->policies, policy, id)
			if (policy->port == port &&
			    policy->mapping == mapping &&
			    policy->action != action)
				return 0;

The freed id can also be handed out again by a later ETHTOOL_SRXCLSRLINS,
so a new location would describe hardware programmed for a different MAC.

Doing the idr_remove()/devm_kfree() only after mv88e6xxx_policy_apply()
returns 0 would avoid this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918185326.3940857-1-kuba%40kernel.org
