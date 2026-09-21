Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F7459AF8;
	Mon, 21 Sep 2026 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981147; cv=none; b=Ay/xRYiOa0aExY0YKrmfUqDISqYPjHpmQUpF7i9sligIscPieO2mNeALRX8ZO2XQuXW4ykFYPWUQbq/D3OgCHilD1nsDBaBpokIPqtY0bqH8e53IfNQ1VGA/GOTKx0h9zG4KrcdQalstRgI70KA/kV1PS1x/1dm20fhtyqVFXxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981147; c=relaxed/simple;
	bh=UZzv0K4n1WDBJWfSx0u1BXd1p+AbJCyVqoJ5O/aGa1Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=k07L8DsJdDtxl7jHQoHKa6Q7LTR1e4tfxtyJqfY+5vR+WMzuWH2hb7k9haiC1Vk3qV7QbGZHGW+54KPhw6Cjpri4zAFjXCWB5RIkUd6pBgQfrQXvvCuRGdCzwjSXEIEZY8FJmL0loKc/GGImhukBn1+v68buc+PBbpUVtUVLANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ikwI4FiX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ikwI4FiX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B7D86C24603;
	Mon, 21 Sep 2026 08:59:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CD6A6074E;
	Mon, 21 Sep 2026 08:58:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17A8A10329150;
	Mon, 21 Sep 2026 10:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789981131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UZzv0K4n1WDBJWfSx0u1BXd1p+AbJCyVqoJ5O/aGa1Y=;
	b=ikwI4FiXF6VQApbvhF1SnRTRExBOv2CkJFEHzrn6q+j5Bz2nEmi1QXac5duHCoKgpx10J5
	YD6wwQSRL/6mxp1rzjXmtPaN2FEjJxe12peOT3WKAwEc549Ywy/WxjBKZvJz/k0m8h3x/p
	nptKXtbQL862ZpNiD3y9m74hrEQHS5OkO+5PbjI62lMV7zFG7ID925eMIBfkpIl5/0w7LR
	27nO6rw3sQtXIgJCpX3bbgqAtBADOUCEVTPMKOOQig1c6exZWfmvH8o+9OnqBwhaP4/DiV
	ohaQxHODLI5PEpxTd7Y8pxGYSaPYYk8ch66zICw3N0+omvTvRbmdqN7r3JZ6WA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 10:58:45 +0200
Message-Id: <DLKVCOXTNGVZ.3CC6KFXDIFJ3X@bootlin.com>
Cc: <linux-kernel@vger.kernel.org>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
To: "Zijin Tao" <taozj888@163.com>, <maintainer@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: rate limit netdev error info print in the
 data path
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260920095839.62852-1-taozj888@163.com>
In-Reply-To: <20260920095839.62852-1-taozj888@163.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Zijin,

You sent the same patch 3 times?
Message-ID: <20260920095839.62852-1-taozj888@163.com>
Message-ID: <20260920100658.65087-1-taozj888@163.com>
Message-ID: <20260920100920.65773-1-taozj888@163.com>

Also you are missing the prefix [PATCH net] or [PATCH net-next].
Read up about this here (and read the full page):
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

On Sun Sep 20, 2026 at 11:58 AM CEST, Zijin Tao wrote:
> Now the MACB ethernet driver print the netdev error information
> directly by netdev_err(), which would lead to a large number of
> error information print if there was a significant number of
> error or just jumbo packets received when booting.
> For example, it would print a large number of:
>
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> ...

This whole patch is LLM generated? I don't think this "PHYT0036:00"
device name could ever exist. Please don't hallucinate kernel logs.

In both cases, I prefer the commit message to either indicate whether it
is a theoretical bugfix or a bug hit in practice. I know I've faced
such a log spam on MACB in the past, but I don't remember which log
line it was.

> in gem_rx() by received a large number of packets without
> RX_SOF or RX_EOF flag set.
>
> The unlimited print here would greatly bother and delay
> the system booting process unless the source stop sending
> packets.

I don't understand the relation to the booting process here.

> So rate limit the netdev error information print in the receive
> and transmit data path.
>
> Signed-off-by: Zijin Tao <taozj888@163.com>

Thanks Zijin,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

