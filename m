Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AE49B456;
	Mon, 19 Oct 2026 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399873; cv=none; b=OT3t81gqkg3whVPZnbmwnmnMeXvPMbR4pbYElBELkfHQOyrEUBXrwSBzxanjdTK6td7JevZKFSHIk26UQzWfSOrpxKrFFSoLRiOGS7/Org+pLrC24ITXZ3l/rgxsqTSylS9ux1Pyr1TN0sYXxcSiODAxWSnaEMZYzsxkGdxd4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399873; c=relaxed/simple;
	bh=Fi01WHNqoV/1h5bUGA4B6J1XVsUJVKVGizvKyil5C+w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oNVMYGiAGllM8Z/on3mz1FaIc+mhfYvp2ueGXqHFiFY+chiRXhNzUL+k0MlqiFGDGvXvEpCqDtugI2l/fjXi67a+sBxB9CTVicikW7yIzhqiO7cHaIb043/JI0bkq2e+icH7pmAzkPNfJCY48YtZvKFUphcbBayg8KlfNjRISPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km5g/Lz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km5g/Lz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BF41F000C4;
	Mon, 19 Oct 2026 08:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399871;
	bh=JjDsyiSq61fxlzHtdfeDMyg6sTFpEeaG4+KOHuzM24E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Km5g/Lz0GHRamXVV0yMHiHgCM8vbroh/qtDsp87nAiKAq13xliPYFkKNc6gXU4ysm
	 5HRaAMZiiz0HKN3E1qKlHRZSY64TGUqRwYTCow7i1ClRMvRnehAeDWc7TW1p+6FYeM
	 P5OwsvgQiHfiZCBpquRJ3HpfcXRivHvOu9n7kO2Qyni4eKLnhcWr589gb9QeY6dSW8
	 Ja6tevLaCs3vF+aVaC9kMlFLBCW0IZ7MA1OpEFUB/FY79rQRlvgJQkAAJCCrRjcaZi
	 GElHVDewtSnbeQR6QYNZC7R2+h0buVAUHKe0hb6lKTvPfSnPv6ojR+x2Vf0rIqNjFT
	 j3tuFiuTLI40A==
Subject: Re: [PATCH net 02/10] net: pse-pd: fix module refcount leak in
 pse_control_get_internal()
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 piotr.kubik@adtran.com, saikrishnag@marvell.com, horms@kernel.org,
 kyle.swenson@est.tech, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:51:10 +0000
Message-ID: <179239987068.3135.2768821007598612150@kernel.org>
In-Reply-To: <20261018082314.48950-3-github@szelinsky.de>
References: <20261018082314.48950-3-github@szelinsky.de>
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

- [Low] The commit message names two leaking error paths in
  pse_control_get_internal() (drivers/net/pse-pd/pse_core.c): a…

--

net: pse-pd: fix module refcount leak in pse_control_get_internal()

This patch changes two error paths in pse_control_get_internal() to jump
to put_module instead of free_psec. Without it, the module reference
taken by try_module_get() is not dropped. One path is a controller
without pi_get_admin_state(). The other is a failing
pse_pi_is_hw_enabled().

> pse_control_get_internal() takes a module reference and then has two
> error paths that skip module_put(): a controller without
> pi_get_admin_state(), and a failing pse_pi_is_hw_enabled(). The second
> one happens on any I2C or UART error. Each time, one more reference
> leaks, and the PSE driver can no longer be unloaded.

[Severity: Low]
The code change looks correct. Is the first path in this description
actually reachable, though?

pse_controller_register() rejects a controller that has no
pi_get_admin_state(), and it does so before the controller is added to
pse_controller_list:

drivers/net/pse-pd/pse_core.c:pse_controller_register() {
    ...
	if (!pcdev->ops->pi_get_admin_state ||
	    !pcdev->ops->pi_get_pw_status) {
		dev_err(pcdev->dev,
			"Mandatory status report callbacks are missing");
		return -EINVAL;
	}
    ...
	mutex_lock(&pse_list_mutex);
	list_add(&pcdev->list, &pse_controller_list);
	mutex_unlock(&pse_list_mutex);
    ...
}

The only caller of pse_control_get_internal() is of_pse_control_get().
It takes pcdev from that list:

	list_for_each_entry(r, &pse_controller_list, list) {

So every pcdev that reaches pse_control_get_internal() has
pi_get_admin_state set. That means this check cannot fire:

	if (!pcdev->ops->pi_get_admin_state) {
		ret = -EOPNOTSUPP;
		goto put_module;
	}

Changing its goto keeps the unwind consistent, but it does not fix a
leak that can be hit. The leak that can be hit is the
pse_pi_is_hw_enabled() failure path. It returns the driver's
pi_get_admin_state() error, for example an I2C or UART failure.

Could the commit message say that the first branch is a defensive check
and cannot be reached today? Then anyone judging the fix for stable
would see that only the pse_pi_is_hw_enabled() path really leaks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018082314.48950-1-github%40szelinsky.de
