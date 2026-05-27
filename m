Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7901428495
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892527; cv=none; b=eQ9oMiVWzVan/wbqbhIZfFxZpExUTPK3aWkFbcHFQk32Af46JJohwefizg8C3rYPwZTkS7yDAVQdw2C8appoBLTbkofM/b+EbmxQy/dC+G3wsAujY7mDAe8PGLUbH88lkkIRkyd2K7pgSyWjriTnLFLaVAXKdH37zomocPZTfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892527; c=relaxed/simple;
	bh=rgKCBbfJd666++7v22Y5yTnU+AjG9R2E5aBjXnjEHjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcYvT76O9FmGZ1/uuenr3qDx/INA4+IRg70a+qq+7+znI+k3wXFE+BC/OPZzvmfUKc1ziYVtjhv9EwKfi0cLO9QTl7LpmHmPqXgc55xFPhcek4rtYe/h99GAbtBgnCzf5O0V2h4sOOdUBK5xYZtiyHX40NPwwNYmS1pmgB5iDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RrFcMxpd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RrFcMxpd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E385F1A36ED;
	Wed, 27 May 2026 14:35:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0E9E601A1;
	Wed, 27 May 2026 14:35:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A96910888388;
	Wed, 27 May 2026 16:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779892523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tYkKzyNGregBLEq4wyp8zNlt5DiaUq8yGv509hN3xes=;
	b=RrFcMxpdSQapCOqc5PHQ2JN9f+MasbzNvDNf6/FZoQzXEPSFZ68gs3DhtDtzF3qGCdHNz5
	nncyNF50JvzPPPX2PSTAiMsOzGndCj1qTd0VMM0N0/2MPOjJgl2cJvcCZM3MS8+AVvtqkr
	mg+QYBdKEuuqHBJyEyKzFQaU6RQvyRTyNjxTJpGYMef9IGpZ2UaLtMGnl3VJrW08nSgama
	+7lx/Tko14Ms++bguhzWw3Lu4NeWATncJJObzI0OD2wrqJbjZWKB2lzokcSTde/kAGCkvg
	UMonnbcT4FYpSi33AkKcLHagfW9gBko5v0Gx/czz3SaRm2z/kcWXU64/8kzVMQ==
Date: Wed, 27 May 2026 16:35:18 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 o.rempel@pengutronix.de, maxime.chevallier@bootlin.com,
 haiyangz@microsoft.com, andrew@lunn.ch
Subject: Re: [PATCH net 07/10] ethtool: tsinfo: don't pass ERR_PTR to
 genlmsg_cancel on prepare failure
Message-ID: <20260527163518.00361cda@kmaincent-XPS-13-7390>
In-Reply-To: <20260526153533.2779187-8-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
	<20260526153533.2779187-8-kuba@kernel.org>
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

On Tue, 26 May 2026 08:35:30 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> The goto err label leads to:
>=20
> 	genlmsg_cancel(skb, ehdr);
> 	return ret;
>=20
> If ethnl_tsinfo_prepare_dump() failed, it has not started a genlmsg.
> There's nothing to cancel, and passing an error pointer to
> genlmsg_cancel() would cause a crash.
>=20
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support sev=
eral
> hwtstamp by net topology") Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
