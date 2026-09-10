Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B92C0296;
	Thu, 10 Sep 2026 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002181; cv=none; b=PuaEGBQx7jL/4pBxpDwz00cYrFAKCTNZCcfl7GBsQvlrcz2IZbpBgrIf1MLkpHw8aPJ3u7NL7YfslogqzDO68zGfza4wrvOwIEmBLr004Obxmg9F1mTsdzuVgqCHlElGfk79jW8kL93fHsUVPKZz9HvshScGntBOFgovAPu4WN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002181; c=relaxed/simple;
	bh=EImQn2M/ruRtPTeI8E8bTcdUxMvP88SpDU4RhRpfxqc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlxDusS646m7OK9WDRpzBW0S9Xj5P5Z3rbs25pcirHPDUgsBH/PBlQWmqJlvzRWchFyhIkJ7URVQNuVsGAYBVaSqRFktDqjeKv3eHJ2xnInC8H+bdm0k3UnNus6DXM42y7ZS7Op+bYRxmDC6Yjae9us5//OZkQ2ms9em9hsimNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On0NLd6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On0NLd6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEBF1F000FF;
	Thu, 10 Sep 2026 01:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002180;
	bh=QpHgtCi7m1N2CVICFr9WF9LZLdTyvksnq3SP3JzlSQM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=On0NLd6zsLXYHRHso17LB1VIT8XMTZD6VjsXuIb3UEiFFeGoRpIuic1fBWlwB+nHm
	 psS4p01mhqRx24G/MF0Uz+zdKiB3PExb0xiSxV5E/htGr0bnVUyRGssh2TW+GOGNsV
	 JL90jjMmme3MeoUDYZFotS1TYiM3OfBG31eRmTswLD2tdq5SfSJhT8nH2n1hLevg0h
	 jgd8hRWLK+OzBM1NLiWUmaDQHBJLvRUDIh+S1yonVa5MjTwVHJSjh3Hy3qK5P4qOrZ
	 GEp70hiCPtXGuf/ZuUux3elPzsY/+iQQkDzFl2DAUe4Ju3/EQwg6Yw9r/KcLl8yNH3
	 kQvF97UIlI7ZQ==
Subject: Re: [PATCH 1/1] bonding: crypto offload enabled, non-offload slave
 failover, rekey failed
From: netdev-bot+sashiko@kernel.org
To: zdai@linux.ibm.com
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pradeeps@linux.ibm.com
Date: Thu, 10 Sep 2026 01:02:59 +0000
Message-ID: <178900217942.219967.7472232136755764721@kernel.org>
In-Reply-To: <20260903220123.475685-1-zdai@linux.ibm.com>
References: <20260903220123.475685-1-zdai@linux.ibm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Incomplete error-code mapping in `bond_ipsec_add_sa()`: the
  sibling failure path that fires when the bond has no current active…
- [Low] Missing `Fixes:` tag / unclear target tree for a user-visible
  behaviour fix.
- [Low] No in-tree test covers the behaviour this patch introduces.

--

bonding: crypto offload enabled, non-offload slave failover, rekey failed

This changes bond_ipsec_add_sa() to return -EOPNOTSUPP instead of -EINVAL
when the current active slave has no xdo_dev_state_add, so that xfrm falls
back to a software SA instead of failing the SA add outright.  The reported
symptom is a child SA rekey failing after failover from an offload capable
slave to a non-offload capable one.

No Link: tags were present in the commit header.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index a9bff7663eeca..de2489c3d9bf2 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -490,7 +490,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
>  	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
>  	    netif_is_bond_master(real_dev)) {
>  		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
> -		err = -EINVAL;
> +		err = -EOPNOTSUPP;
>  		goto out;
>  	}

[Severity: Low]
Should this carry a Fixes: tag, and which tree does it target?

The change fixes a user visible failure (child SA rekey is rejected while a
non-offload slave is active), so it reads like a net fix rather than a
net-next cleanup, but neither a Fixes: tag nor a [PATCH net] /
[PATCH net-next] marker is present.

git blame on the changed line at the baseline points at 2aeeef906d5a52
("bonding: change ipsec_lock from spin lock to mutex"), which only moved the
line.  The enclosing capability check goes back to 18cb261afd7bf5
("bonding: support hardware crypto offload") by way of 907ed83a7583e8.  Would
one of those be the right anchor for stable backports?

Also, the Tested-by: line names the same person as the Signed-off-by:.  Is
that intentional?

[Severity: Medium]
Should the sibling "no active slave" path in the same function be converted
too?  Just above this hunk, bond_ipsec_add_sa() still returns a fatal errno
when there is no current active slave:

drivers/net/bonding/bond_main.c:bond_ipsec_add_sa() {
	slave = rcu_dereference(bond->curr_active_slave);
	real_dev = slave ? slave->dev : NULL;
	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
	rcu_read_unlock();
	if (!real_dev) {
		err = -ENODEV;
		goto out;
	}
	...
}

The consumer only whitelists -EOPNOTSUPP for the silent software fallback:

net/xfrm/xfrm_device.c:xfrm_dev_state_add() {
	...
	if ((err != -EOPNOTSUPP && !is_packet_offload) || is_packet_offload) {
		NL_SET_ERR_MSG_WEAK(extack, "Device failed to offload this state");
		return err;
	}
	...
}

and xfrm_state_construct() then kills the freshly allocated state:

net/xfrm/xfrm_user.c:xfrm_state_construct() {
	...
	err = xfrm_dev_state_add(net, x, nla_data(attrs[XFRMA_OFFLOAD_DEV]), extack);
	if (err)
		goto error;
	...
error:
	x->km.state = XFRM_STATE_DEAD;
	xfrm_state_put(x);
}

So with crypto offload requested and -ENODEV returned, the NEWSA still fails
hard and no software SA is created.  That is reachable when every slave is
down, in the window where bond_select_active_slave() has installed a NULL
curr_active_slave, or trivially with a bond that has no slaves yet:

	ip link add bond0 type bond
	ip xfrm state add ... offload dev bond0 dir out

Given the commit message says "network traffic is never interrupted, always
keeps going", does the -ENODEV case leave the same failure mode reachable in
a narrower window?

[Severity: Low]
Is there a plan to extend the existing selftest to cover the new fallback?

tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh enslaves
two netdevsim ports in setup_bond():

	echo "0 2" | ip netns exec "$ns" tee /sys/bus/netdevsim/new_device >/dev/null

Both provide xdo_dev_state_add, and the failover leg only moves the active
slave between those two before re-running test_offload().  No leg enslaves a
veth or dummy device, fails over to it, and then adds a new SA to check that
it is accepted with software fallback.

As it stands the script passes identically before and after this change, and
would keep passing if the fallback later regressed back to a hard error.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903220123.475685-1-zdai%40linux.ibm.com
