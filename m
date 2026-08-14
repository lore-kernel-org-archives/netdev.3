Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA501F9C0;
	Fri, 14 Aug 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786667497; cv=none; b=BkRLCREwc92702wK76R0CWh7YbWX4nGHT1A/upPd5tXMOtiq24tQb5s3AyT2HfTxHrF5v1FvOXSyTcAqZ6/Gn/4neLu2OBNd5oHJfKaAZ4vBdoDWipZCewlJKgsMlczjVjokeAHKDn0dCTA1exfX5hqiZ1qlBBng3hTibtqIMUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786667497; c=relaxed/simple;
	bh=ePt9FIxzsKiy+/S/AiBxIasEfraMp66B4kzTIJ+Bthk=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=LmCrT3mmd4J5ywWu7WT9iMUUbWLxPs2r+6ioIVimLGdkos3X0NhUmqsFWha0Gf5ktQaMeGtZPOrDjbgaMnyubGI/yWW9H8HykRuANA7EEUjM10QHdniqQoj0gs2M66XIrnI63C6uM9sFq46tcP0ax7u6faWTKKiXQVHrW826usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Ls3nZRv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BCBTXOIo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Ls3nZRv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BCBTXOIo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04B811400139;
	Thu, 13 Aug 2026 20:31:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 20:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1786667494; x=1786753894; bh=YW95wxb2gasWrxs0AjrAJ
	qxSGnka00SgQI7gCddwfXo=; b=Ls3nZRv7xrCcKX8YUWwEF2pFoQGPRrLz8YdHH
	djbZEjIhNVc0CJ8IyO78erEMA7whuiXrnmFtrg96rYIdLBA+eWRVlcSHihiHpK2u
	4c0n48xk6myQMCGECA7oF6PyzO2p71U5CKWE2wlQmvQ6AtiuC+ZxYkDZIa1XhHRw
	jEP4ZPf9J699APf61Xwq4EhamI8NkYXZrMsFs+PpGJLA6UqY52eVzfaLi96wH7y0
	iZPo/kQpySpxMszeZ3ImbeEEAKmSeyclL7NFyYWQjLkIMPoSYNnu2Wf/AgjoDcIJ
	k29qCmJUCbEI0TzEe1JEKun58UHXR6gmJVwVJ7UccaOCvDkYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786667494; x=1786753894; bh=YW95wxb2gasWrxs0AjrAJqxSGnka00SgQI7
	gCddwfXo=; b=BCBTXOIoGJGpDzh8uR/3+UtoVKyi4c06Zl4tvGbMzkwFwuIixkQ
	28rEFu1hgCcYLra14rIPI0+0tt5Lk209jWvIX/RXYsYcxPEa1dKg7K4l7KcJkLF0
	R0RCzkDusKcATgzpThs9y4mDy+SAmTYes5R8BVH1Q1l7poaduJOLORo/uq0pxQxx
	jyycnipClYzg9pcA0d/eoYQmnecYQMzDzEO2cxUQrbjta+pKuwLAu8X2BQROduFv
	PQqr6+/+AA/x2LQQMlSlV6W3439NfcBNHhw7IMChypUdwBYhSQ4YOsvH5qvYynS9
	3xoG+gcniTeAekMrxwpcDVEr+tTTPNvyalg==
X-ME-Sender: <xms:5WF-aipSoeuVugz7kl9zL7r2aWXtAS-Hh3RFi0tFH0N_xJy0ctEl7A>
    <xme:5WF-alltxntd2N-JotUHqeQgz8keaK4eOgGhGEiPBkJ6XTzdwfDVPcyb2eBtDKtQP
    AAOgUKL-5W1ODZ9LDCqyn1nLdLV1lDG94y-n_hgimRb_FVrPXtYvGFT>
X-ME-Received: <xmr:5WF-are0Rnc1epL6O4gZdWW3aC3ym7OmIiscM1Ixw2AxkVyy0eYwOJWWhhd2ylhe3s6xEw>
X-ME-Proxy-Cause: dmFkZTEYkLz5gKQpUmAUbevK5DIgmTW2FxsP0412JkTTBeOSW99+dfzhi8l1X5+cY95owo
    F3RQoVI9xXD3o7+h3Zgjs3ihCMOeDTTm7NHMVJVi7K5tOsuwxrl/lSTRZ0oRURf9Ho5Enm
    SmmFLjd0s/bBoyxq3GbGrtkPj8XDdEKcE6761vjVm4x9rVZceMlIV9+N26JepeIwSzoBLQ
    +hfL72WV3/R1M/RPAKOON4pv9bTH2UOI67zGdEcaNhFaDrXv76krBszhDhtlBD8Vl+7YlU
    etez2IRIRDhF/I+nVXUna9IvNjLXFEx4bz2jzKF9EKFJ21l/84NZLO3s9SIJ1sC21eF9UK
    Df0HMihm4UN238mHttug7smvdpN8NvF4rAwZzBreNTW0u1RBU2TUnO2TE8uKh9lxls12Mx
    7wiLSmw6cdvJ56FwEvxDZy6ruj1SaxGrAcT9SlOaSpdr3AgEnUmS1bqL0kQaL9sDS1C5oH
    ZiTTWBhfeAtpVbU73WTXkVACZoEvK1S6VgzZ0/elQQrHQalnoeYSZ/REn9evp+S49nzFtR
    0XIyWkb9sKgsWscLgZpAUB9K9+j/hp+7Coho42etcvmAZ6WA0aDasLkuVjR9AwRSroqKGS
    VCqKfElyWklMWYulEc//RCyQvqwPhseOoImpBbwkmqan8X9O+RBuizz3ucgQ
X-ME-Proxy: <xmx:5WF-ahoSzaswSppC_wvmoWCkL7QGoliYdZFRQqBqmLy5dqNG3dMZ5Q>
    <xmx:5WF-alMNk2kZAwNnre_jx0WnI59meEDk94xg9EbK7h4m6nKyVPVLDg>
    <xmx:5WF-akgl5cuG8DdlAURe2gu4wUpfB0E2ldBklNGATsiVHSJuUo16sA>
    <xmx:5WF-aovIFfKZgMuTkdO6QYovzvQkYpceqacZcagGbWwokjBwG9HzrA>
    <xmx:5mF-atxLqgeorlCNJlHSj1NHac2a_mUjb_SCnUn8jNf79jVmcWS0rIYW>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 20:31:33 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 07BB19FC6D; Thu, 13 Aug 2026 17:31:32 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 046479FB9E;
	Thu, 13 Aug 2026 17:31:32 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Ruoyu Wang <ruoyuw560@gmail.com>
cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
    linux-kernel@vger.kernel.org,
    Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
In-reply-to: <20260813153126.3952893-1-ruoyuw560@gmail.com>
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
Comments: In-reply-to Ruoyu Wang <ruoyuw560@gmail.com>
   message dated "Thu, 13 Aug 2026 23:31:26 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3995446.1786667491.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:31:31 -0700
Message-ID: <3995447.1786667491@famine>

Ruoyu Wang <ruoyuw560@gmail.com> wrote:

>Empty NLA_NESTED attributes are valid, and bonding uses them to clear
>the ARP and NS target lists. When either target attribute is empty,
>nla_for_each_nested() does not execute, so err retains an uninitialized
>value before it is tested. The request can consequently return an
>unpredictable error after clearing the targets.
>
>Initialize err to zero so an empty target list completes successfully.
>Non-empty lists still propagate errors from __bond_opt_set() unchanged.
>
>This issue was found by a static analysis checker and confirmed by manual
>source review.
>
>Fixes: 4fb0ef585eb2 ("bonding: convert arp_ip_target to use the new optio=
n API")
>Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
> drivers/net/bonding/bond_netlink.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bon=
d_netlink.c
>index 4a11572f663d31..87d92d3cce4a88 100644
>--- a/drivers/net/bonding/bond_netlink.c
>+++ b/drivers/net/bonding/bond_netlink.c
>@@ -220,7 +220,7 @@ static int bond_changelink(struct net_device *bond_de=
v, struct nlattr *tb[],
> 	struct bonding *bond =3D netdev_priv(bond_dev);
> 	struct bond_opt_value newval;
> 	int miimon =3D 0;
>-	int err;
>+	int err =3D 0;
> =

> 	if (!data)
> 		return 0;
>-- =

>2.51.0
>
