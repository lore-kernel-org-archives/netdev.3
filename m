Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863D1F5842
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803977; cv=none; b=M2RDxKuOyq45AI3qIlt0Y1C/ulWhq12SzhEW+SFmBKgyvnn5ZwxV/h3SJOFvMeZ6P6PFn6zwx6wZzdj3OAaLolte+6cERaDOpTAaYOooPsQ2x+64gUqjvomXNNEQA7arDILlSBthB5P8OmmjVtqYwKdN+4Q3x19tfF5oobYk71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803977; c=relaxed/simple;
	bh=hBrURUYdSvExW4H+R5fGi50ARQU+zVjzHlkBJGQkD+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GwP9qgfOCRV3BH7UCotvtnCG4HqOlnF3n28jkNdhbAnJQLmm+tNHuhELovT95gOtx+wsufBwIgckKuUJGz+4U0XRe8AjPVjJc8o8aJUFAngcQFinS6NWme3/AG9djCJCzxwpb/I6kvcAgUK+BSrmLkMsjzBoISC6mBUH00MDgVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wZSRH7kn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wZSRH7kn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 090AE1A09D6;
	Sat, 19 Sep 2026 07:46:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD89A606CA;
	Sat, 19 Sep 2026 07:46:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 104F21032907B;
	Sat, 19 Sep 2026 09:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789803972; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hBrURUYdSvExW4H+R5fGi50ARQU+zVjzHlkBJGQkD+g=;
	b=wZSRH7knEB6j1Jv5yj9aZBXFT7dUyU+pxX0jNlCh3fIsf488iQ+rIhTLme03tTZzPqwYfa
	Lu97U8j+mwh5mZoyt12Y3CGL2UdnI4PWQKiXP/BYweBhKtV4emN/w/Zc3zFP7jwDdWNLd/
	KFcuE5qQif8HpEvR/KsiWUFRrvhl7zPoftY24ijDppeDNydl+eQ/VhtBMw51RgImiYiasy
	XQxcVBKT6uoCqgVymjLakogILCbdM1jQHiDJkPkqmiaAMbqiM6rcBPRP+D93IR/BKDHEb3
	dpDVoq1wHZN+9jpnCCU8PgtLeOviSHIJ/iLVQFe7tr1XZ8B/qoaRU7zCb/pVaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alex.aring@gmail.com,  andrew+netdev@lunn.ch,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  linux-kernel@vger.kernel.org,
  linux-wpan@vger.kernel.org,  marcel@holtmann.org,
  netdev@vger.kernel.org,  pabeni@redhat.com,  stefan@datenfreihafen.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: atusb: Fix URB reference leak in
 atusb_work_urbs()
In-Reply-To: <20260917114821.2149704-1-vulab@iscas.ac.cn> (Wentao Liang's
	message of "Thu, 17 Sep 2026 11:48:21 +0000")
References: <20260917114821.2149704-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 19 Sep 2026 09:46:06 +0200
Message-ID: <87mrtdela9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


> usb_get_from_anchor() hands over a reference to the URB, which the caller
> has to release. atusb_work_urbs() never does, so every URB collected from
> the idle anchor keeps an extra reference: the reference count grows on
> each retry cycle and the URBs are never freed on disconnect. Drop the
> reference after a successful submission, and after the URB has been put
> back on the idle anchor when submission failed, as the HCD holds its own
> reference while the URB is in flight.
>
> Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
