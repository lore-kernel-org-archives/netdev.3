Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8039184F;
	Sat, 10 Oct 2026 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610997; cv=none; b=GyhmNKZnvGL9a2Xk3Splc9LFpj1A4/JpW3EsvC+CYjZl51gJvXINKG3w14HuIZpfW62fPH+Jc43p0fJJaKEvIDnSYhjX+5cLmHnfFeFbOJI3pMhVITduy/zLzbTAvp1qe+5TQSohI2Oh144CXmvJVb37BIU24fFP8Y+qwSSADyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610997; c=relaxed/simple;
	bh=RvUqNIrBRSahgetnQ6A8gnx9q9yFC2SFjBqV+yDfxKQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9tA/lsBwg0vYePnqXVEqTjqVt6WT4J6mdqub7D6wPjcO99jYzQfPV2el2KEcKsxN3UwlmjgqvZiNY1B4lP5lSQDIoUskB9ewZvo5wkNEu4MBIU4nEifTtA8G1H0ra/+lNcQUF91hsZzuyAmKm9ZYP2Aul4RPELCJP9EVDwgkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/vDvlUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/vDvlUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77771F00893;
	Sat, 10 Oct 2026 05:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610996;
	bh=JgIiDGuFMYgQvEdPO0AywyxEDLVxOmf63QDkwhcCpGY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X/vDvlUH9LwgB8eSx4gFw4o6PLTLdTnpI7pXxr6sb5HDTaW/FN7z62jJo1zuszLfY
	 WKchzRqZi7pG28rzqg00EPBWShmNafEaX0uwhPsf7MTnFo4/AWU7HphsO5ert2kcZf
	 X9kptCuYq9QiTVmC9kbXIuNTc7t9Tb9MIt/nZq5ps4aBLmbxRqUVfGOj4uUqtyO1hl
	 zVposVp82n0lCnQDhooZFoxTTAJcFsvzPEhKsl2lm94DE8q1r+TXEa1c8vALymU8uB
	 XYOe6IgnUbNSXDvj57p/RXdxuPhlrByFxeZz+/+ujnn6mMlVHez5pM0FX4ggAE/X0O
	 /a7KDzmhRp3rw==
Subject: Re: [PATCH net v3 2/3] ipv6: remove ifaddr from hash during ifdown
 list cleanup
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:43:15 +0000
Message-ID: <179161099539.434549.2238120015372268173@kernel.org>
In-Reply-To: <20261009054042.272944-3-4ncienth@gmail.com>
References: <20261009054042.272944-3-4ncienth@gmail.com>
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

- [Low] The commit message understates the bug being fixed.

--

ipv6: remove ifaddr from hash during ifdown list cleanup

This commit unhashes each non-kept address in addrconf_ifdown() just
before it is removed from the per-device list. That closes a race where
ipv6_add_addr() publishes an address after the Step 2 hash scan and
before the list snapshot.

Link: https://lore.kernel.org/r/20261004135117.GA206930@shredder

> The ifdown path then removes the address from the device list and drops
> its last reference while it is still linked in the hash. This triggers
> the WARN_ON() in inet6_ifa_finish_destroy().

[Severity: Low]
The code change looks correct. Does the commit message understate what
happens before this patch, though?

The WARN_ON() in inet6_ifa_finish_destroy() does not stop execution. In
this race, addrconf_ifdown() has already set ifa->state to
INET6_IFADDR_STATE_DEAD, so the "Freeing alive" early return is skipped
and the object is freed:

net/ipv6/addrconf.c:inet6_ifa_finish_destroy() {
	WARN_ON(!hlist_unhashed(&ifp->addr_lst));
    ...
	if (ifp->state != INET6_IFADDR_STATE_DEAD) {
		pr_warn("Freeing alive inet6 address %p\n", ifp);
		return;
	}

	kfree_rcu(ifp, rcu);
}

That leaves a freed ifa linked in net->ipv6.inet6_addr_lst. Later walks
of that hash chain would read freed memory. Examples include
ipv6_get_ifaddr() and ipv6_chk_addr() under RCU, ipv6_chk_same_addr()
from ipv6_add_addr_hash(), and the Step 2 scan in the next
addrconf_ifdown().

One way to reach it is ipv6_add_addr() called from RA processing through
addrconf_prefix_rcv_add_addr(), racing with a non-unregister
addrconf_ifdown().

> Unhashing before the list put prevents a stale hash entry.

Could the message say that the stale hash entry points to freed memory,
which makes this a use-after-free and not only a WARN?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009054042.272944-1-4ncienth%40gmail.com
