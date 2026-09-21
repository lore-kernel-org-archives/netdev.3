Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90B4FDA57
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016945; cv=none; b=up9Cr9pbI7INAZiJNIKydBfGIrAWCoUSQLb1hxepIW0DDEhoiz8esHBADOCrRLNuZlIZE3SjK4pS5UHnRufnl+TwjeLk2yjnd4U+0Mfjfos7OmdfhC/bk8R4U7UaNhbyy1Ukr9mBpUUI8aIqrLOsDEXZidtx8OPTEcc5PeuA1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016945; c=relaxed/simple;
	bh=efVWYgIjl3iCadL7kQR6FSdI3gwDaztITVsfcs0HPfU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AF0uIxKi2ZQwcHzEm10fdzdrcX1hUMKjvHuRMp709uwZf6WWbZdRrZsMGoxm+zAJma/Ex+KPXyWFXrvbyflRPxNosocAqa19FeMcqx3HohGE62RC90YRGLqibJ8zc8TAVDFePTTF/CcBrJMn8KHJCeHwhyc/INxwmkBVYSI1Nlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX9ebfTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX9ebfTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188DA1F000FF;
	Mon, 21 Sep 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790016943;
	bh=m7g0dwHnMzToYSN2TrpN1WvxECMSYHYWnPdaKAxCW+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MX9ebfTZVLaAAMQPEkQpm9XfNJFZfyXza8+RAMaAY2KS4xt/LloBUan11g89HgFmD
	 GIkcPJ1GsueoRh+/IpjYqj6vfc8r8mFa/EYfYQ1YU5ua9ARHnw2O3+dYcHvQ+ZYr24
	 e4yj/oubHVRhsA94VQJjjn21b8EerS1zEPl+XsokCT6zZzzRQnJ4wpLaxTHksySMaI
	 nt9CetespxKw1bICidK+eMGQK2a+xozFtDmfgi/OSYt/8Cyy/InaS4UfxSF0RotvB+
	 kCkDr5YBa75yAXSrKz6u3DXZdWFu49czoz1N+IAkynLtVmjQKwEFZ3KvM0jzW44xyc
	 M1eNxy2ret6qg==
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: check the port when
 reading back a policy rule
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, olteanv@gmail.com,
 andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@gmail.com
Date: Mon, 21 Sep 2026 18:55:42 +0000
Message-ID: <179001694253.2160803.16390239637008123615@kernel.org>
In-Reply-To: <20260918185326.3940857-2-kuba@kernel.org>
References: <20260918185326.3940857-2-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Missing `Fixes:` tag.

Pre-existing issues:
- [Low] SRXCLSRLDEL cross-port delete: mv88e6xxx_set_rxnfc()'s
  ETHTOOL_SRXCLSRLDEL arm looks up fs->location in the switch-wide…

--

net: dsa: mv88e6xxx: check the port when reading back a policy rule

This adds a policy->port == port test to the ETHTOOL_GRXCLSRULE arm of
mv88e6xxx_get_rxnfc(), so a location belonging to another user port is no
longer copied back to the caller.  The GRXCLSRLCNT and GRXCLSRLALL arms of
the same switch already filter on policy->port.

> net: dsa: mv88e6xxx: check the port when reading back a policy rule
>
> chip->policies is one IDR for the whole switch, so the location an
> ETHTOOL_GRXCLSRULE caller supplies can name a rule belonging to any port.
> mv88e6xxx_get_rxnfc() copies it out without looking at policy->port, which
> lets a user on one user port read the MAC address and VID of a policy an
> admin installed on another.  ETHTOOL_GRXCLSRULE needs no CAP_NET_ADMIN.
[ ... ]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[Severity: Medium]
Should this carry a Fixes: tag?

git blame on the pre-patch GRXCLSRULE arm in mv88e6xxx_get_rxnfc():

	policy = idr_find(&chip->policies, fs->location);
	if (policy) {
		memcpy(fs, &policy->fs, sizeof(*fs));

attributes those lines to da7dc87553046 ("net: dsa: mv88e6xxx: add RXNFC
support").

The earlier fix to the same function, b1fffc273112e ("net: dsa: mv88e6xxx:
bound the policy rule dump by the caller's buffer size"), already uses:

	Fixes: da7dc8755304 ("net: dsa: mv88e6xxx: add RXNFC support")

Without that trailer, stable tooling has nothing to key on for the
unprivileged cross-port read described above.

The commit message says "changing this does carry some regression risk" --
is that hedge the reason the trailer was left out, and could that be stated
explicitly?

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 8cf5681f5806..461167199a71 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -2457,7 +2457,7 @@ static int mv88e6xxx_get_rxnfc(struct dsa_switch *ds, int port,
>  	case ETHTOOL_GRXCLSRULE:
>  		err = -ENOENT;
>  		policy = idr_find(&chip->policies, fs->location);
> -		if (policy) {
> +		if (policy && policy->port == port) {
>  			memcpy(fs, &policy->fs, sizeof(*fs));
>  			err = 0;
>  		}

[Severity: Low]
This isn't a bug introduced by this patch, but the delete side of the same
IDR has the identical missing check.  In mv88e6xxx_set_rxnfc():

	case ETHTOOL_SRXCLSRLDEL:
		err = -ENOENT;
		policy = idr_remove(&chip->policies, fs->location);
		if (policy) {
			policy->action = MV88E6XXX_POLICY_ACTION_NORMAL;
			err = mv88e6xxx_policy_apply(chip, port, policy);
			devm_kfree(chip->dev, policy);
		}

A location owned by port A can be removed and freed while
mv88e6xxx_policy_apply() is called with the caller's port B, so the
hardware side effects (mv88e6xxx_port_db_load_purge() and
port_set_policy()) are applied to the wrong port, and the "mapping still in
use" loop filters on policy->port == port:

	if (action == MV88E6XXX_POLICY_ACTION_NORMAL)
		idr_for_each_entry(&chip->policies, policy, id)
			if (policy->port == port && policy->mapping == mapping &&
			    policy->action != action)
				return 0;

This arm sits in the privileged default of dev_ethtool(), so CAP_NET_ADMIN
is required to reach it.

This one is already handled inside the same series -- the following patch,
"net: dsa: mv88e6xxx: check the port when deleting a policy rule", adds the
same policy->port == port test to the delete arm, so nothing remains at the
end of the range.  Noting it here only for completeness.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918185326.3940857-1-kuba%40kernel.org
