Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BA3DC4D8;
	Thu,  6 Aug 2026 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006677; cv=none; b=kpK6Esn8PXBWaUi1ZpJ5oV5nbLx649wrgFAos7QLct8H37Mo1TGRsiFlAFATsmvaMoFRx1CDPqmOhepPvcK9ZAswi5XSsuS0lLGZwoQfa1cmRWjOfBkGZhHMnTaqrsSUKj/msAuVZH+THu8jLB5/Ykgnm5Ual0pOR0FQt6IxIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006677; c=relaxed/simple;
	bh=Dd7STyDqi4l/n4c6PYQ2emDXuHfliNXfSBSm3bN4bMQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=uKNn7TWeLgsdgfV5/xNovRc5sheOGnj7JO7jFuDVajvwrt4xTg+UMk1E0acZtxNrA7eH5Rx3lC9kNzxNJPrQw/i/KRVDH5KRChatC5mftSwcU6UcvBK1K2xCJ8fgEddopHGV+6Q7ZNxieuGb2meQDhZDQnho6PrQNUGgxgGFteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=El7MFSm7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="El7MFSm7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8653C1A13E8;
	Thu,  6 Aug 2026 08:57:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59515602B8;
	Thu,  6 Aug 2026 08:57:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6142811C35CDD;
	Thu,  6 Aug 2026 10:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786006666; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Dd7STyDqi4l/n4c6PYQ2emDXuHfliNXfSBSm3bN4bMQ=;
	b=El7MFSm73YqpmBYgO4Z2587kbFwPA2KApEPJruiZ5rJs8eXpEO95gLrCa0LM6191GFc3Tc
	QioldkhNjS033rXebtxmFlJqSHtEQwcH1ptH6Q8DCZb61Hsly8Qh51CU2OX/m5h96WQgIX
	bzHszUe8YdlMGMNF8qhtPsMv83diOgIVpMVjBU60v/k0gS9qF6R0qgU0HT5WvAhTiS78l3
	NCVbkbR2SxxJkqgE0LOyL/KNhLfgGle2n9ExQpXSrGrVk8zKPadFRwmnssaKWqmjk1nsVA
	DbT+HyCX0L4beX9CVnDBt2VRskydIJVC1CSGvaNi5kkXjId5nQH8Y89NOF0keQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 10:57:42 +0200
Message-Id: <DKHQITXDJJRP.3MD70TXXL2516@bootlin.com>
To: "Polak, Leszek" <LPolak@arri.de>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v2] net: macb: fix stale data returned by MDIO reads
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <PA1PR03MB110596D36E77DA32E1FBD9099C8D22@PA1PR03MB11059.eurprd03.prod.outlook.com>
In-Reply-To: <PA1PR03MB110596D36E77DA32E1FBD9099C8D22@PA1PR03MB11059.eurprd03.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Leszek,

I'm sorry, but I've not read your wall of text. It is far, far too
verbose to be consumed by a human. Have you yourself read it and
understood it fully?

It reminds me strongly of this blog article I read a few days ago:
https://gruhn.me/blog/2026-08-03/

No strong feelings or anger, don't worry.
But please keep human discussions human!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

