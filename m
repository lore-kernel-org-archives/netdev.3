Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607828;
	b=0F7qWApbkjOI0Lm8sLoQIkCS/+7yPbjhvTmBLlvMU7uLT/b62o1Y8dR76BAoxWtGfB7e
	 QgvByers5/bc3EIyUsyNBdjkS5sdCXh+CGeo4VbiKfd6ObTIPpcFYJYTW1md/B6e+qT0j
	 BvoDpRDlKxUAhNLza+7Psld7ffQZv0UvvOC0954e0FDBTmxEJ/VWTvC52fgkJy+FggE+W
	 rlCyOBGYeIMxr3kUY369AMM6dEJF8b2Ewd+k5CUMkIMCT6b25XX7uJzI6rKOxI+UTJInd
	 y+jb09VEDn1B34uNUt1nrVnsNgFpFz7cxfizQfO8J9uMgCOF97UEhpoW+2FFQ7dUcVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607828;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=cEyN7X0zp2+0JdttZ7TpyT+KfHeqvxl19fVkd42ChWk=;
	b=ZvZmZbv1AIlR9GKeJ1EJq216th197UkgNBVpM0awvopfHl52u/lV5AoPVrxxj3LuoJ4n
	 wXieMWmWOKld7o7tE2nyd7FIaVS531FbcYlXMC09HmfJUIkCDMJtpuWGzU9N+T7ldaW3+
	 l81RkQNyYgZaB/IiiPE/08fD5WOHysYxIxnWi7I0tGjIXfyveSdvTTcDD4BkzOscmBU1E
	 M+5V9A0XU2SgWyQfePPagAS2MreEHK6NQMmKur18t2hWsoT+Q3VUhkVs7Lr3jm34jgO5b
	 zHBsTi005ktZO13w29A9rjMKMIo7k1nu7maMBWLHwTzpjaBiHWMKBrw6ICR7N7eqMHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=EUMZdeVA;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2DC70606A319;
	Wed, 21 Oct 2026 18:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC70606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=EUMZdeVA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1792607818;
	bh=cEyN7X0zp2+0JdttZ7TpyT+KfHeqvxl19fVkd42ChWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUMZdeVA1gFJfNLWqbQT25dFPmL/MMbhL6IbDykKMiy5J0oveadXClkaYNVimLH+s
	 Fqoi0cvB0u5fmfo1ktKhovFRd2x/L4JbCQg1CdGR2IylnsJHvHh/as3ITf1PZbkPAP
	 NDdBZ9Jfojsoq8BQ6ausnswY9Mo7oQRjRHQZY1KBwpCPS75atf6AQqCMfDuqLcqymb
	 AVQk7c6NjVSdBT65I0r5F4grJ+q5cVJoxH1jaTOYo6Zhehi6ZfuO5HF6+NRdY1T6li
	 y6ATV5BcTCXty0zVd0LGu9rDK6Yt8aOmDo0GyTqnH3UsO+yRzAOh2nfyOJnikEAkTy
	 AacOfsNe+q/ag==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 837AE60055;
	Wed, 21 Oct 2026 20:36:58 +0200 (CEST)
Date: Wed, 21 Oct 2026 20:36:55 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mark Brown <broonie@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Liu Chao <liuc63@xiaopeng.com>, Networking <netdev@vger.kernel.org>,
	Piotr Kubik <piotr@kubik.pl>
Subject: Re: linux-next: manual merge of the bluetooth-fixes tree with the
 net tree
Message-ID: <atkGR7UxW4kAeUdE@chamomile>
References: <atiblfL12VddJgjU@sirena.co.uk>
 <atioPA8ofnC-PCGi@chamomile>
 <d6f50e2e-adcc-4d85-9be3-ff24cb8f8cc2@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6f50e2e-adcc-4d85-9be3-ff24cb8f8cc2@redhat.com>

On Wed, Oct 21, 2026 at 03:00:56PM +0200, Paolo Abeni wrote:
> On 10/21/26 13:55, Pablo Neira Ayuso wrote:
> > @netdev maintainers: Please, see below.
> > 
> > On Wed, Oct 21, 2026 at 12:01:41PM +0100, Mark Brown wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the bluetooth-fixes tree got a conflict in:
> > > 
> > >    net/netfilter/nf_conntrack_netlink.c
> > > 
> > > between commit:
> > > 
> > >    cd37ab22a74e0 ("netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter")
> > > 
> > > from the net tree and commit:
> > > 
> > >    1ae2d094b0200 ("netfilter: ctnetlink: fix inverted IPv6 address match in dump filter")
> > > 
> > > from the bluetooth-fixes tree.
> > > 
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> > 
> > Sorry for this: This patch is duplicated, one variant went into
> > net.git and another into net-next.git.
> > 
> > Two possibilities:
> > 
> > - Revert 1ae2d094b020 ("netfilter: ctnetlink: fix inverted IPv6
> >    address match in dump filter") in net-next.git
> > 
> > or
> > 
> > - Revert cd37ab22a74e ("netfilter: nf_conntrack_netlink: fix inverted
> >    IPv6 tuple filter")
> > 
> > before net-next.git gets merged into net.git, because these two
> > patches address the same issue.
>
> The 2 patches are equivalent, right? We pull net into net-next before
> sending the net-next PR; I think the easier solution would
> be manually solving the conflict at that time. I understand that accepting
> either 'net' or 'net-next' variant would be ok.

Yes, either variant should be fine.

Thanks
