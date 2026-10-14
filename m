Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6A4FE2D7;
	Wed, 14 Oct 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982415; cv=pass; b=eNP0NeSkUvtBNNAL8eIxyvxndLB8FoFZnswoxM3TOFUi3+30dvDKIBwgF2Nzf62FBNZnyPUqkaxz4XWYLO5TPQHbsI3EThqqrX3tJeIUftfBfK6IQAe1/BI+JhLbGHIrvPYnookUlI/teB2W6ESKggcvHcluox95r/aIqhoCaeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982415; c=relaxed/simple;
	bh=YIUEwg0LfHRU4qIhNbdQ7StK+jrwHy/fObd1Wb39lUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbUHusmLpAxnUrkJHB0GxbVU5fzU2MyxTeYnFR4377Cy0Jvqwv/Y3KwdUXY8HIAXdP8WF+0ERH8QWHIU34ZGqf2hE0MFLdFg8FsDwtIOUJjT0OXuAgtlz0vqFwFX7wd7Ha0Z4lrDvUW+8DfOB2v21eyljNOl/jdVIwdif5v2NRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=X9TXWe81; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="X9TXWe81"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6187E2005A6;
	Wed, 14 Oct 2026 14:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791982379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiq+9YbCCdkjIQ8InedN0qq7G7ZSn6XKK7xqYCmUMbc=;
	b=X9TXWe81AUrlWFm94RGS7oFYaQCygxYPcTV1FqngvTw4QRVb1/pUA54vJEkdwMH9lmJCFk
	+tpQ7uM2ugIjXNGSLv/j5mSfd/Pv6e0RIo2ce6Ftq/N0Ob4oP3eCnABNBo2/G/c1w/ZVXu
	2rN/p3Ckj9Raww62+tHyPJDMDFZLOCyKr6+zm1nRBxTXjielJwq7kXGpLeyFqOkhw7G4tT
	VK3rQBIZ3FUjqubUIVcmbgzenjSL09RFla+GcLf1Uo6wq0V1/kM2VTH5LjJu8Y57QAX5ss
	K2T20LLh8z7dsdha1YmSoWuhWfNztB6V0mhS3odQzgvPhrG5YNbDzCSybg1n/Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791982379; a=rsa-sha256;
	cv=none;
	b=S9DfYVup2X/tHScytLcW5dDPe7NQTrP7VimkWltWMNisSELWUqM1XG37owmmlOcpUWmSi9
	Wxds1uDDQ1lFyR0mffJ58DgE6BGz20LTygtYaKU2KV03HQTQHNFmCT2MrhnLVLFnI8mVQY
	lYR0/gPzmewXwmHO0j4O5ym6jQcFHH0ljnWKYuWVkXflzev+1YdPNS4fzDChLA3R+R5jpn
	P6vtYsUwrSg84CwNill5cy3FV8ySkTjw8lCZ9VKMsQg8D938kcOpoJ/7WTSrIqLGzcQJy1
	zzWefmklvVA8lXCqKA6P5FDzdxzfrRL2iSwhYgYiYE5Zt6IJVUSxSLgKPKpjtQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791982379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fiq+9YbCCdkjIQ8InedN0qq7G7ZSn6XKK7xqYCmUMbc=;
	b=ZjfTpYaLt4tKTwBuBQdngu4ucLvPmz3egtA++O2phitYd2xdxAjWWxRKE+fWl1Fa3G0n6Z
	MPnJgPcQTLLgcTGrkumaG232ZGZON2pOvLP90kU/sO0CdmdU+a/DVX6O1GPSqmd3Qf8xcp
	asT19aURa2Ket32L1h4taJtxBsGolNHoNKXPKYF1PEfBfl7HLYUd0j7M+fwHZ7G5dwtB2y
	bFcnfYjkjhxxhEfRchkZbCE54Xc8VHh3rBQsLKYVuaUMSgNHmiv2AXceLv3e4ZMf4NQkry
	IbAdqE7NqnwzXV4+/TPcuNvpACp2/G76UR0OQ744kmwZKVd3hXh4zdD/t12XOQ==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xGyTb-005rCz-0z;
	Wed, 14 Oct 2026 14:52:59 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xGyTb-00000004j2e-0lbG;
	Wed, 14 Oct 2026 14:52:59 +0200
Date: Wed, 14 Oct 2026 14:52:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 0/8] net: dsa: realtek: rtl8365mb: DCB
 ingress QoS offload
Message-ID: <as97KxCL7RjkvIJT@pengutronix.de>
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
 <CAD++jLn_H40-37QOmNVKfkr3UP2X3AJ6NM31uSvj3gXrzY07KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD++jLn_H40-37QOmNVKfkr3UP2X3AJ6NM31uSvj3gXrzY07KQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Mon, Oct 05, 2026 at 05:03:55PM +0200, Linus Walleij wrote:
> Hi Oleksij,

....

> Both chip setups should expose their queue count through the
> existing ds->num_tx_queues, and set ds->dscp_prio_mapping_is_global
> when registering DSCP offload. There is no need to duplicate those
> properties in another common structure.
> 
> Does this make sense?

Ack, refactoring.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
