Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F364194A6C;
	Thu, 30 Apr 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777511929; cv=none; b=rS/G3a9aFvdQmVFbcuSoCoT2rYEN535HW06nIRGPoL3PEFGxmW/qnNewelWn5JJZMSFLJP4vPR/i6gATDq7vL9cPc8LFJV08F6FGYilP5Q3N+Mv1UWXCuKJq7UYM3Z3bKG1+x1IH0NW1EiUgn8mrrTKDc5BsQtjhE4JhbQ7zu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777511929; c=relaxed/simple;
	bh=8I/TGIeJpKZJ99tALKbqpZFfrLAguMqYMRot9pDDjFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nm5Zax7NBDsFx9GbB3yho0kl6jcV0UQwwby8Sz6BcTM7MeDNlV0eZW4KL0NH6E1Mi/VOIAHcuo+Euvn6aGBZqfRWJ7m0bhkYhQANwws7b+BmMbaIueqa5HsF86vdmaKXu3IqrbztdWGIdKskF6MLWAyxsPrUSZ+DWhRK6LADzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEdr9kD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEdr9kD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F0C19425;
	Thu, 30 Apr 2026 01:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777511928;
	bh=8I/TGIeJpKZJ99tALKbqpZFfrLAguMqYMRot9pDDjFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEdr9kD2r1ZVsI0g0c7GJRNC+Pq09jt6y+7cDDBpYMJV/41JimIDZMSiNyXoQZ2Us
	 iimqk9jWtUXNca7Ne9Gu5y8BpvEmXd1V5r+jNM/Lmwt+8ZWz14yFq4elltN2VJq7Co
	 NKi45Q8L8SFdopY/EYrAqunqvI5qXIFRpHYsVIaUdkKjgrnl8SsnnZ8e4vMfuzeiqK
	 Qs0cXPCi7GXPgKNpD+wLoVKxvD8gPPKNM/1fBsydCt9FTDYfkaBvYGGel3//uYg2GE
	 3Cq7Au9wcuVc9IGPDaNzL02+h7BmRU7lJC2ESobGzAwBcCT12rTLTFL/525SDiejCz
	 JLNd6LSa3MUdA==
From: Jakub Kicinski <kuba@kernel.org>
To: maoyixie.tju@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH net 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
Date: Wed, 29 Apr 2026 18:18:47 -0700
Message-ID: <20260430011847.2344915-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428110713.2550315-2-maoyixie.tju@gmail.com>
References: <20260428110713.2550315-2-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ip6: vti: Use ip6_tnl.net in vti6_changelink().

After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
rtnl_link_ops"), vti6_newlink() correctly resolves the per-netns vti6
hash via link_net. vti6_changelink() and vti6_update() were not
converted in that series and still read dev_net(dev) /
dev_net(t->dev), which diverge from the device's creation netns
after IFLA_NET_NS_FD migration. The result is a stale per-netns hash
entry; cleanup_net() of the original netns then walks freed memory.

> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index ad5290be4dd6..dcb257411d6e 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -722,10 +722,11 @@ vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p,
>  static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
>  		       bool keep_mtu)
>  {
> -	struct net *net = dev_net(t->dev);
> -	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
> +	struct net *net = t->net;
> +	struct vti6_net *ip6n;
>  	int err;

Does this fix introduce a regression by leaving a loophole in
vti6_siocdevprivate()?

While vti6_changelink() and vti6_update() now correctly use t->net,
vti6_siocdevprivate() still uses dev_net(dev) to locate the tunnel during
a tunnel modification ioctl:

net/ipv6/ip6_vti.c:vti6_siocdevprivate() {
	...
	struct net *net = dev_net(dev);
	...
	case SIOCCHGTUNNEL:
		...
		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
			if (t) {
				if (t->dev != dev) {
					err = -EEXIST;
					break;
				}
			} else
				t = netdev_priv(dev);

			err = vti6_update(t, &p1, false);
		}
	...
}

Because the collision check occurs in the new namespace (dev_net(dev)), but
vti6_update() now modifies the original namespace's hash table (t->net),
could an attacker in the new namespace configure their tunnel to perfectly
match the parameters of an existing victim tunnel in the original namespace?

Since the check in the new namespace finds no collision, it seems it bypasses
the error check. Then vti6_update() prepends the attacker's tunnel
into the original namespace's hash table, which might allow intercepting or
hijacking traffic destined for the victim tunnel.

Should vti6_siocdevprivate() also be updated to use t->net for collision
checks to prevent cross-namespace traffic hijacking?
-- 
pw-bot: cr
