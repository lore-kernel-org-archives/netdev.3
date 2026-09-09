Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36CF54B1C6;
	Wed,  9 Sep 2026 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958169; cv=none; b=SYrD/V7aBZzO1Qh8GNlli/EBGG3P+mIJegpQQJkWuo5tFImwbliYHSc24R2sUSrtHjwLi2Icj1lai6r4/eqn1oZXgIWMMjL9xe8UrHV8PegPnOy7kBEXFp4w9xPV5TSy0IqTsMb6Y9zKPyflZYXSRTpD70xs7JOm3Pjz/9OKuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958169; c=relaxed/simple;
	bh=qqXMqmrd+y5B0eVW3p8EQQHwEKUTrd53gXeIAyFDkhM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+xNjFUYKN/iiiy4EYacS1EwriuCACfTScBH3efNOJbqlSI1JHIIloZWCfM5coW4Vk5Bke/o1nzoz2FgMYXtBDhNQ3zM+X8j/+DLoyMSojCpXYRlDAcKeYggUwskV3mIB5OSIAX6v7MfU3RLa/D3s0hM0JNjaHZrcFiy0DIziFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+wVQ9kP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+wVQ9kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E912B1F00A3A;
	Wed,  9 Sep 2026 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788958167;
	bh=iQcWttfJog+bH0clzuCKIx8cj/FxD4VTfWdVAgxIkYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f+wVQ9kPpJVNAyumRxoJqYdy/BKuBq3raVHaZmZSMY5ji5KV7oJrq2EuEVCeAs0R9
	 b+SvrX0YZZ1W0OR+bTBrQX0hLRL90nJL/hWvmXMvfXQDKdup3nP5qntpie6evCfsQ1
	 zunIrGlP4MTwu7SvIr7e13TcYiwW0UW1HYLl0HCvFrUzqH/t89H7v4ED9QYAxisflN
	 7DK9wUuGKgiIGiUnLSkpLsADb97as3P8Y4wdVXJu+Y9pil9Vg4/aXiEKqQ6d+v2RW4
	 uv+G/OeHBFwDjnWKC2W98VMDjWfRkDzoE95ZwAZcy9xkqU3vMYGT2cVbHFnf46jmXS
	 VbHp38jj1cMDw==
Subject: Re: [PATCH net v5 1/2] net: phylink: unwind the PHY binding when
 bringup fails late
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 12:49:26 +0000
Message-ID: <178895816649.219967.12304467742929163860@kernel.org>
In-Reply-To: <20260906174643.4107607-2-f@lex.la>
References: <20260906174643.4107607-2-f@lex.la>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Commit message misstates the impact of the bug being fixed on
  the SFP path.

--

net: phylink: unwind the PHY binding when bringup fails late

phylink_bringup_phy() stores the PHY in pl->phydev before calling
phy_eee_rx_clock_stop(), which can fail on a MAC implementing LPI, leaving
a stale pl->phydev behind after the callers unwind with phy_detach().  The
patch clears the binding on that failure path and factors the clearing out
of phylink_disconnect_phy() into a new phylink_clear_phydev() helper.

The code change looks right to me; the question below is only about the
description of the bug being fixed.

> What that costs depends on how the caller got here.
> phylink_connect_phy() and the SFP path go through
> phylink_attach_phy(), which refuses to attach while pl->phydev is set
> and turns a transient MDIO error into a permanent -EBUSY.

[Severity: Medium]
Is the -EBUSY description accurate for the SFP path?  On that path the
phy_device is created by sfp_sm_probe_phy() and destroyed when the connect
fails, so the stale pl->phydev looks like it points at freed memory rather
than just blocking a later attach.

phylink_sfp_config_phy() propagates the bringup error:

	ret = phylink_bringup_phy(pl, phy, config.interface);
	if (ret < 0) {
		phy_detach(phy);
		return ret;
	}

That error travels back through sfp_add_phy() (ops->connect_phy) into
sfp_sm_probe_phy():

	err = sfp_add_phy(sfp->sfp_bus, phy);
	if (err) {
		phy_device_remove(phy);
		phy_device_free(phy);
		dev_err(sfp->dev, "sfp_add_phy failed: %pe\n", ERR_PTR(err));
		return err;
	}

phy_detach() drops the reference taken by phy_attach_direct(), then
phy_device_free() -> put_device() drops the last one and
phy_device_release() does kfree(to_phy_device(dev)).  sfp->mod_phy is never
assigned in this path either, so no later disconnect_phy callback would
clear pl->phydev.

Wouldn't pre-patch consumers of pl->phydev then touch freed memory, for
instance phylink_resolve():

	mutex_lock(&pl->phydev_mutex);
	phy = pl->phydev;
	if (phy)
		mutex_lock(&phy->lock);

along with the ethtool ksettings/EEE helpers that test pl->phydev, and a
subsequent phylink_disconnect_phy() -> phy_disconnect()?

If that reading is correct, could the commit message describe the SFP path
as a dangling pl->phydev pointing at a freed phy_device instead of a
permanent -EBUSY, since that affects how the fix is triaged for stable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906174643.4107607-1-f%40lex.la
