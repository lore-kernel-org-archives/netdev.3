Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1737C0FF;
	Fri, 24 Jul 2026 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916404; cv=none; b=WBtEhbMLa3Dlfvt2Xt/YHS5DCY62rnIL6KjhNC+iCuEL2gIeZonTXlHZh2/CRg0cqq191xNd+eLUkoF51GxqF+X8H+Y8t6cCo79zQoyGck0C5mwAcO5VShOX9LlD8ucG5OEuVWxRxLxhU/vIpYfXKFFxI+DVQJqcK6tiAwjhc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916404; c=relaxed/simple;
	bh=awRFZWNycu8fED9XQlY2mBrvcZBHfK/yN6xnf1PLCdE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ReERR+DgSSiwb7WAj/paSCJCpmoq0m7vqvUGUl6VIN0jcSkTHgAM9/Yp5niBmmYXQ/ah9eAG8ttTIXp7an++sZyQZMkjcCJiipLMOWed2pVlJoLj38XE3zKN+5W0zc6YVjRbmsj5fyKOutRF9q6TR7EduZftfMArDX7VFxFzWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WirR4+4Q; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WirR4+4Q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 23A971A11ED;
	Fri, 24 Jul 2026 18:06:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E221160395;
	Fri, 24 Jul 2026 18:06:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 489AB11C12A59;
	Fri, 24 Jul 2026 20:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784916395; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=psl4QSciuxerlyl1H+sN4WIoJ2pLt48rrk/n/dEpuJQ=;
	b=WirR4+4Q2CW3tYiDuzSXp3zRL22pphHCJE322ZYO9FjD6aPshaEACWBr4bC9pDkw7WmcIz
	tbyxPXhPgxRLhM8SA4xTxNlWqSvIqXa8yjY1ng4HLYQ03EnGjJiL/PY8s8SIdYQzkOeyGu
	Jp6n6a0vzdKwXhuF8FAdg5lnqhH2v5sPbfeckcsk0gf3togYqqW2hqcI2gf/xGylI3np2E
	q+rYbiyrB9PSETOVfWhn28ofJqlmfZRG0mtat6Se4u+3rVD0OudGZtYVve+OXPDwBOi3Xz
	Pq388t4XjGhm6oMXkwD2gQV7u5brM3QQFKugVGPqh0WXGBqj299DUNH8oK24pg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 20:06:32 +0200
Message-Id: <DK701YU8OWST.2CDXDR5SUJYJQ@bootlin.com>
Subject: Re: [PATCH net-next 2/2] net: macb: configure ENST registers for
 all queues
Cc: <git@amd.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>,
 <conor.dooley@microchip.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
In-Reply-To: <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vineeth,

On Fri Jul 24, 2026 at 6:32 AM CEST, Vineeth Karumanchi wrote:
> The initial "tc" command was not overwriting the reset value of ENST
> registers if only a subset of queues were configured, leading to an
> invalid setup. To fix this, configure all queues unconditionally.
> Unconfigured queues are zero-initialized via kcalloc(), ensuring a
> complete and consistent configuration.

But if a subset of queues are configured, the remaining queues don't
have their ENST support enabled thanks to ENST_CONTROL and their ENST
per-queue register values aren't read? Or HW is broken and reads ENST
registers anyway? Or something else I misunderstood?

What reset value of ENST regs you observed that caused you trouble?
That info could make it into the commit message.

> The queue_id field in struct macb_queue_enst_config becomes redundant
> once the array is indexed by queue id, so drop it.
>
> Key changes:
> - Drop queue_id from struct macb_queue_enst_config
> - Allocate enst_queue[] based on bp->num_queues instead of
>   conf->num_entries
> - Index enst_queue[] directly with the queue number
> - Program ENST registers for all queues
>
> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

