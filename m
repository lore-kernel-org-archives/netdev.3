Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AB1DF748;
	Fri, 12 Jun 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258433; cv=none; b=YIcR+kl5TDiC+tPcshvtJngbdh0VR8UideshT9Jy6UPyDdMWbGyuq2X5BI4Kmy+T6J4pQFxw4bpIi+xnB5Ch6ASga8EOfpJvEh6NkxNuA6DJD2cm5Ce6kIHPox0J7nLIDNEyxJVfChQPKhFKvObaWIHvv19EZYlpnUnFfoCD5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258433; c=relaxed/simple;
	bh=tF/vP+WYOK9P9urz3A6JtTcCTWb+qjzpMiSJxzo9+S8=;
	h=Message-ID:MIME-Version:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=C2AtCgL4YsrQ2t1yBKWETMkE+cQqn2kscPAF11H3+maDpo32w/qn3JuglQvwMpHnaB8eWnXXxv94fjYn7H/38L8ccVS9/UuSrsYAFUMqgJP2gQIlKzwJCo3I5pdS41eCLUrtN2OVPNcBthBjhCfRMdeEhlffutMTWeSzMdnoeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ZeBrpYI6; arc=none smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ZeBrpYI6"
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 19D7C7219BE;
	Fri, 12 Jun 2026 07:36:42 +0000 (UTC)
Received: from fr-int-smtpout19.hostinger.io (100-116-180-119.trex-nlb.outbound.svc.cluster.local [100.116.180.119])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3CAC8721857;
	Fri, 12 Jun 2026 07:36:39 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Arithmetic-Fearful: 63c5ece7276c157b_1781249802002_3456694983
X-MC-Loop-Signature: 1781249802002:29651468
X-MC-Ingress-Time: 1781249802001
Received: from fr-int-smtpout19.hostinger.io (fr-int-smtpout19.hostinger.io
 [148.222.54.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.180.119 (trex/7.1.5);
	Fri, 12 Jun 2026 07:36:42 +0000
Received: from [10.10.10.3] (unknown [46.1.111.82])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4gcBCl1z9Fz1y7P;
	Fri, 12 Jun 2026 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1781249797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXtlwR+cKWGeAXn3H+Lf5Yv1kL7XUbUsrMYC6J2rcVc=;
	b=ZeBrpYI6Dd/19gzwezL9s6dEWcEwXVPhMzaTBGzKwS8TIWcBSU3yoD7QKoZ3yBGWR+nrqg
	eInFGcClna9n7prMx+FJ6b33Zm5w33wIlPL5Od2HPMHlfENdEtHhdA9Iub80OstE3yDSBX
	UutJgFHpeovEWcFS5UQ4mqnuK9jPNPSPpEdvjU5Y+GVvL6WBRS/MGcW4H9eZ9dP/3zlI7J
	Yt5+qrOfHH9GMLKCfCTXqVR5Zxn2FthdUHqQhQhB3CsF26zCWxvHk4CCa7ir13RtDoYNFY
	lYAx1OuXCkt0u9l6a8Njq5H1YKm9zyPNNEijODSUqkXgsjGtusNAsoRm8S+awA==
Message-ID: <02ad5de0-ea6a-4267-8686-72e3f98fce4e@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] net: dsa: mt7530: implement
 port_change_conduit op
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <cover.1781119435.git.daniel@makrotopia.org>
 <91ae0f87a6ca2cce3d072dba548545e02347bf13.1781119435.git.daniel@makrotopia.org>
Content-Language: en-GB
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <91ae0f87a6ca2cce3d072dba548545e02347bf13.1781119435.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jun 2026 07:36:35 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=Gq4Q+V1C c=1 sm=1 tr=0 ts=6a2bb705 a=EYFf6tZZuEx+mizzmxfcTQ==:117 a=EYFf6tZZuEx+mizzmxfcTQ==:17 a=IkcTkHD0fZMA:10 a=VT4XjZGOAAAA:8 a=GvHEsTVZAAAA:8 a=FvUSNmnTzPuJ0QD-RBkA:9 a=QEXdDO2ut3YA:10 a=6CpsfURP9XNmmWg3j1mJ:22 a=aajZ2D0djhd3YR65f-bR:22
X-CM-Envelope: MS4xfPf9YvhCURV0HNIRHewhsgeJ9lEsWOVHOYoe2NIE2lxkmBW207FzjH+NqiB3byQJ0bAloPoh1NCmG2PgAFdt/QN7hkNG2SGyAMV4XomqSKlxpCttMUy5 s+QzPUrh17I0tW90nKrdo+RS3RYeD862Ks9jmvbyoaOY/jWi8O8vrClb6WmkCVwf1j9fnM2H1XmeyqkDfAG/6iAAON8+3kZAADIG92oUX9eOrEMe5AhBOp6f fOE1xNV66pSaBNW6YjWW9aFU9Bry5FQqphNAL2qC0aQz6DpUHP2AhI66bTwRSyQFTK1m+QJBCDCKZeNdzddGf8rQiFGiyomFmTKmTeSTMdqI9eKMvR9T2G+i 2Mu/cLS28ncEvQDD3vD5K3BS33LCxkOIPqw/XLG4d6mwXRZYtg9ibcZxDgXRuDkGSFtkwJ7h6FiPPRh78EXqnQFg74I+FJ53x30cX9m818PhBvRthI9W/Fyj urnwTraN9Cex6mcdm/Z4LjaJZgE4slbLiKBKFeqpJdcgQOrYK8taV2bqkOyBLNJh50N/iUSbucRzQmNv4XjdeFkRPh4uEVB/g46MCHu6c//OIis5e5indrdj dO1vybENR3J0C4iyL7jcmsyDD7d8kF8ajC9cUWQAXcAwUmFCPrdEa2+hOr+4GDKMGcRzXSb/X8bvu1BVjZpCXXio
X-AuthUser: chester.a.unal@arinc9.com

On 10/06/2026 20:56, Daniel Golle wrote:
> Allow changing the CPU port affinity of user ports at runtime via
> the IFLA_DSA_CONDUIT netlink attribute. This updates the port matrix
> to forward to the new CPU port instead of the old one.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Fabulous!

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>

> ---
>   drivers/net/dsa/mt7530.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index c96420c291d5..2f3e734b9f53 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -3206,6 +3206,34 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
>   	return 0;
>   }
>   
> +static int
> +mt753x_port_change_conduit(struct dsa_switch *ds, int port,
> +			   struct net_device *conduit,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct dsa_port *new_cpu_dp = conduit->dsa_ptr;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct mt7530_priv *priv = ds->priv;
> +
> +	if (priv->id != ID_MT7531)
> +		return -EOPNOTSUPP;

Why do we limit this to MT7531 only?

Chester A.
