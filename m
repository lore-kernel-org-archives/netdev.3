Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC42459C5;
	Mon, 23 Feb 2026 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838748; cv=none; b=gjwijIDgWCU0c1qwqzmbJeKb1KfAzTH5BmK1foBWOqXR8+reyVcqlpoUvztyya8pabsNDdjld9DpBU6eAKVoCxseHH/TkXiUgp76zlXNFQLccUlftTIUR9HQJcRCjnuw1Y4ztABiEqPLOOik5oR2E+3wOE2ESy8Gbw8s8T3ptQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838748; c=relaxed/simple;
	bh=5QIF4M53izuNtsmGswVWqyvCsRe0tA47V+jCPS605bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZ7+WGNF4aaWm2mD26b1OHTmnAPTNQ53QLZjO6OojQ9FiFRDHVB9xEhzm4lyM4DnwyT72HgENsyl7+1u7mE0SC5ANNGuIfYbP+9zhFcLkKi/+tdxqg/Pl+1tjqNotZGk3u5FING+Fk7rdfh1NSh5dB5EGLV5B17Pt1xS2w+kvTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AcRaMYXo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AcRaMYXo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 35894C143C1;
	Mon, 23 Feb 2026 09:25:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 190EA5FD43;
	Mon, 23 Feb 2026 09:25:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19415103686FA;
	Mon, 23 Feb 2026 10:25:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771838743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5QIF4M53izuNtsmGswVWqyvCsRe0tA47V+jCPS605bs=;
	b=AcRaMYXo+S1r7u+Fc8nNxzkEuvY3eLKn0agBAwXR+fTOMpzu/hYsmspVCGsHBAFuymFuWb
	pz6wCq7c/Pa8IWxpk/qIa+cxYOZpFQDHR6GS9hL7Kb7hK0uYd5U/Dh5BrjN0ov1GRUiMxn
	3ejzl81Bq1B8DLsKawpqFDhCU0S76e1ezBlCpK+CO6A1xbNk6Tux0of/1OQSLn8QG/SMfI
	ngvFVTKNq8NtZk0+uaxqD9ivVV8+kE4mfD2qsdVaWAskZd5Ff1SrDDO058xNoq6oywRGRk
	W81YqS/s9PtzTEMTGaYz91HfsudQLb12JcbaphXPwsV6afQy2xrIbje+RmTjhw==
Date: Mon, 23 Feb 2026 10:25:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Gal Pressman <gal@nvidia.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 haiyangz@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH net-next] net: ethtool: add COALESCE_RX_CQE_FRAMES/NSECS
 parameters
Message-ID: <20260223102534.0a87ed4c@kmaincent-XPS-13-7390>
In-Reply-To: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
References: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 22 Feb 2026 13:23:17 -0800
Haiyang Zhang <haiyangz@linux.microsoft.com> wrote:

> From: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Add two parameters for drivers supporting Rx CQE Coalescing.
>=20
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE.
>=20
> ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> Time out value in nanoseconds after the first packet arrival in a
> coalesced CQE to be sent.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

You send this patch one day before the official reopening of net-next.
Not sure if this will be taken into account by patchwork.
Else:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
