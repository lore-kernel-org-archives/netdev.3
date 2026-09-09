Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1227603A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919121; cv=none; b=dIc3FW7/RffFv98nIzQCSzDe5JMCvk6nfzcs+YQ/YwRND4Dw5wjOLu4mRtgtsDLiGzLGij4IQOpNjHV+Wc/UbE2SHChwbDDVXEquVNFUfcCzBOtK90KxAOFQQY/4RwZmf3v6xXd5934OiRtlGs2IcFr0dhneYyujflSZ+JRKOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919121; c=relaxed/simple;
	bh=PD921fsliJFuUVBG7MyGhB1xF/4sDR2rVSVAwsCkMfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5r+/LBIy014uz8qiD+VGPYyHdnPoxAdktMaUSgpV5X4hvuKZn7hZlR1H5svynzS7BpsZVhOnLjCNEVrOMAUeN/9Q5oB0SEcdkKRWfjWZ2V678gtLcX/Durqh0+WTvFURBtIAG2g5Ezmv1vTxeP+Oq6b5T8uzupXqe8q66HWAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/pPtW4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/pPtW4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40391F00A3A;
	Wed,  9 Sep 2026 01:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919120;
	bh=NXUbb1Y41/E2/pKPvtIAxR3MMbI/DhdrsDHhqiYI6lA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k/pPtW4WIrX8PJ5Y6Tl+YLx/X70jFispd7MDX2sX0JuWgVRspDYTepD5oLqdrfYF1
	 ESaNJOgeuVi2ZOpKXUVFjz28fiJeIAwIrIRnzaEO/FF1l13W/+KSdL5hzmJ5TA0OFn
	 H2x4W6W6rBpxUjsbgoSWLF+1aRi0UhX6rxiILfbSn6E8/r8MXqNhC4CxhCvQ3EP/fi
	 u4dzeZO6aj6LMuQqhfkKx+tsBV56oe+Me24rMPV7egCmFQUEqZFJzc/UePbzeQHife
	 fZRHPy82hT4CegNzPxtzV/T6yEh1hko5UXENC0yttXIELfTuwPFh+9m+aczpZtPKjL
	 iaxAwKrQTHQQg==
Subject: Re: [PATCH v1 net-next 1/7] ipmr: Call ->dellink() to remove DVMRP
 tunnel device.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Wed, 09 Sep 2026 01:58:39 +0000
Message-ID: <178891911928.219967.7580029616723211694@kernel.org>
In-Reply-To: <20260907225846.3787676-2-kuniyu@google.com>
References: <20260907225846.3787676-2-kuniyu@google.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The commit message of "ipmr: Call ->dellink() to remove DVMRP
  tunnel device." states the rationale inverted: "This is fine because…

--

ipmr: Call ->dellink() to remove DVMRP tunnel device.

The patch converts the two places in net/ipv4/ipmr.c that removed DVMRP
tunnel devices with unregister_netdevice()/unregister_netdevice_queue()
into calls to the device's ->dellink() followed by unregistration, in
preparation for moving ip_tunnel_del() from ip_tunnel_uninit() to
ip_tunnel_dellink().

> ipmr.c uses unregister_netdevice() to remove DVMRP tunnel devices
> created in ipmr_new_tunnel().
>
> This is fine because currently ipip_link_ops.dellink() is no-op
> for non-fallback tunnel devices.

[Severity: Low]
Is this sentence inverted?  ipip_link_ops sets .dellink = ip_tunnel_dellink,
and that function looks like this:

net/ipv4/ip_tunnel.c:ip_tunnel_dellink() {
	itn = net_generic(tunnel->net, tunnel->ip_tnl_net_id);

	if (itn->fb_tunnel_dev != dev) {
		ip_tunnel_del(itn, netdev_priv(dev));
		unregister_netdevice_queue(dev, head);
	}
}

So it does real work (unhash plus queue unregister) for non-fallback
devices, and is a no-op only for the fallback device (itn->fb_tunnel_dev).

The dvmrp%d devices ipmr creates go through tunl0's
ndo_tunnel_ctl(SIOCADDTUNNEL) -> ip_tunnel_create -> ip_tunnel_add, so
they are non-fallback and hashed in itn->tunnels[].

Isn't the reason the current unregister_netdevice() calls in ipmr.c are
harmless instead that ip_tunnel_uninit(), which runs as ndo_uninit from
the unregister path, also calls ip_tunnel_del()?

net/ipv4/ip_tunnel.c:ip_tunnel_uninit() {
	itn = net_generic(net, tunnel->ip_tnl_net_id);
	ip_tunnel_del(itn, netdev_priv(dev));
	...
}

ip_tunnel_del() uses hlist_del_init_rcu(), so calling it from both
->dellink() and ndo_uninit is idempotent and this conversion is
behaviour-preserving today.

Could the message be reworded to cite ip_tunnel_uninit() rather than
describing ->dellink() as a no-op for non-fallback devices?  As written it
suggests this preparatory patch has no interaction with ipmr, which is the
opposite of what the follow-up "ip_tunnel: Centralise ip_tunnel_del() to
ip_tunnel_dellink()." depends on.  The code change itself looks fine, and
dev->rtnl_link_ops is always set for ioctl-created tunnels by
__ip_tunnel_create(), so the new ->dellink() dereferences in
ipmr_new_tunnel() and vif_delete() cannot be NULL.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907225846.3787676-1-kuniyu%40google.com
