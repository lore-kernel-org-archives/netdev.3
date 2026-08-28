Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB738A71F;
	Fri, 28 Aug 2026 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909118; cv=none; b=o8c1W6OJTgnwfSSZ07ixT5yYOaAvV7A/H04z7Sp8K3Sx9kbTNf9VY7PcDuqTBQJVGMEqg6igQVIpGvhhy6Y9YBDELXHWCYZTjj/12Tsfht3KaTHNwBQhW4a66Rv0BvgUw6c5fsdf1+NfCQkSWiMo/9krZqR/hh2ZotrzGzTS6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909118; c=relaxed/simple;
	bh=HFWIYqbamR9H7JG+SKSGlBKoxUG1LOgShNgbcylqktk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=CDfROyinUXkhm+3XQ7dcqPqNZ/qWIIhyJi/e7LItKri2D5yrAkPDFdUCSOpUMrqNLriMS7/+KAiQSiQsDqP5md+vyKax+z4XXrGcIywY6gkz+DFcmHSynQxFQtREjX+uQXmh0ywqL3Fd02yBiRYN4UCwVexhwroTpLmTUQ+iEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HYRXmWDW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HYRXmWDW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C92241A189B;
	Fri, 28 Aug 2026 09:25:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9BCCC60537;
	Fri, 28 Aug 2026 09:25:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55C5711C78028;
	Fri, 28 Aug 2026 11:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787909109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HFWIYqbamR9H7JG+SKSGlBKoxUG1LOgShNgbcylqktk=;
	b=HYRXmWDWUOZ1zEyHJbQDi/zzqTGz43VaGd25flf+99Ab+gUA+YbP+Sz71zNVxpX/By+ClB
	Ykt4ORz5ydsAa5VV8ANY3gF7NZfOx4tXaXIptfKp82lN6UPZ57Qrgxjxh6LxcnIYgFXyRG
	8D1iPOUo2xCJW79N5YgmulAipTZypbqtKzRkguXIhSjDwGnt7LxNmhPVcxBPygKhXfCQt8
	YpEOAoXoWkbUOxm5dcz/jHnd8q9PJkgjjAL2VYbe2T1VvVoRn4KBtLdIXzglYSbZSmxzCW
	gqp0zLmoXHYqmy1LDU3sehCNVFSmfSsUpPzBf+f/YAuKSNCgst6XGHyQrbuLAg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 11:25:06 +0200
Message-Id: <DL0GVSSI2FQU.24LQFERB8T03X@bootlin.com>
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 2/4] net: macb: Move TC capability and PM
 checks to macb_setup_tc()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
 <20260807095012.640223-3-vineeth.karumanchi@amd.com>
In-Reply-To: <20260807095012.640223-3-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Fri Aug 7, 2026 at 11:50 AM CEST, Vineeth Karumanchi wrote:
> Move the NETIF_F_HW_TC capability check and the runtime PM suspend
> guard from macb_setup_taprio() into the common macb_setup_tc()
> entry point.
>
> These preconditions apply to all hardware TC offload paths routed
> through ndo_setup_tc(), not just TAPRIO. Centralizing them avoids
> duplicating the same checks as new TC qdisc types are added.
>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Makes sense

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

