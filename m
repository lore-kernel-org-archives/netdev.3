Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71381175A8B;
	Fri, 12 Jun 2026 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251031; cv=none; b=A8fvcVJyqZdBi7Q8IgwfW8G9rTDdhTU5zu2FAk/DMLcyNo5RHitY/JhPHJ6nIfXJbE9/0opwbnXCCfcFXXoJIEYxLjrrlSRS0vEdz9MIMha35b6bg2AQz2lB9WtM+5pcagw8v9wV44DPOg/k1WsasGChmcjSyZPdIGnMR+bz5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251031; c=relaxed/simple;
	bh=IExqj3AlBha4DwK4ZpHmpFko6xZPrhdbxVJsbfLB1Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGDXGjqX3wNrzBKGwqdngH/CZz8x5JzqqtrRWxv6p+EhmiH53U5aTrmqj53iYLmbgnPXeX8UcKsAaTNvgrzZBipI37wHVhPbxXpx2rVhRUQ9HDWSjgtadr+Z9f72OiNyPMNlBV4fn77AwtxX5XkK/OgPbWOlK9yLyW7zG4KyEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wUw6lQzX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wUw6lQzX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15C9DC51469;
	Fri, 12 Jun 2026 07:57:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FAC860012;
	Fri, 12 Jun 2026 07:57:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0FDE106C85A3;
	Fri, 12 Jun 2026 09:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781251021; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IExqj3AlBha4DwK4ZpHmpFko6xZPrhdbxVJsbfLB1Hs=;
	b=wUw6lQzXu+j9NabaFNmnj8BQqDMjM38WTyiDCZHgHEz0yZ0EugXsvTOI3eivzfdrJ8CAkB
	xjotDlNHi8AfmtHivdf0ARIbt3iOOr/X03QM9iwWEPQgpOcmQyqwYlEdjchYFJHLo7X7kK
	cAeDC8tU/3iIgM2qSofp9Um/JdIWz4t/Jb2QFRMU9y/4HA7Lmfc2i1h0UpM+0rQaG1Rekv
	ukZMycnyefrRmr14PbpZAQBQdoOCXxrsRuuWk88Ndjc8DT+/Egy6Hc+pNcBtqUJawKxPLo
	et7CQLwBhIxl+Xievy97MycyzsyAlQeyl0/zO/6xWqXie82I8OcFHgyILE7MdA==
Date: Fri, 12 Jun 2026 09:56:57 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr
Subject: Re: [PATCH net-next] net: pse-pd: set user byte command SUB2 field
Message-ID: <20260612095657.76e76af4@kmaincent-XPS-13-7390>
In-Reply-To: <20260611102517.445549-1-robert.marko@sartura.hr>
References: <20260611102517.445549-1-robert.marko@sartura.hr>
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

On Thu, 11 Jun 2026 12:24:49 +0200
Robert Marko <robert.marko@sartura.hr> wrote:

> The Set User Byte to Save command has three subject bytes.
> The PD692x0 protocol guides defines SUB2 with value 0x4e, while SUB1
> carries the NVM user byte.
>=20
> Template only initialized SUB and SUB1.
> Fill SUB2 explicitly so the command matches the documented layout.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
