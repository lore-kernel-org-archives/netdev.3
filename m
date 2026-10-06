Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AD35CBD7;
	Tue,  6 Oct 2026 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267838; cv=none; b=f/YTr4nVqgF7TqBmZG955pNx/RkRDpQD580uZwbvcwCxYJ8fP6ZVqxpsaV2ChWwxo9bMzjpOcGYrpQVa1LVGxgSgTHeQXCMR7v2xapqDdR3+SweuIB6WOhzdiaQiFtxmvGevAvGl8pKbeHnD4kw3srWjfmcHN7HgKyfz4WUL2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267838; c=relaxed/simple;
	bh=UgTYKoBVDAU3z4YfM+HxksJg+qAUHHCUSEz8KefzTO8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZuluK49GxYYu1E2JAh0qCw/ezZQ3X/XfcG7eYo4wtAlYcLc07Ces9No+4hS5uYZkk3kTmkZ6HUMC+MWysk5VaRKLbIxez65tvDYzk2MEyo8Kx1uqghIM+j32K8BwPFanuu/ueHaToLFO4B+vz+qLYmVb1QBJin3H0c4w99eoFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=qqBP1BQV; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="qqBP1BQV"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B066A0572;
	Tue,  6 Oct 2026 08:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791267834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YHZgo3sn5Xx8vFkJv9zQzlxXblhckwZQx4petbN8ulM=;
	b=qqBP1BQVcPP5COwO+K7Z/jJx1NW64LtDbsISWQRo4vPSX2tuQnWjIaV8U3GA7B/Qtp8Mma
	7SKtJaaTyI9N7SVeBnN+b+U3pOB8xL4oXu0TS+n8YlvzRyZux7xn2ndsOKzIKrmaLVhDgr
	PSoDYS4F0MHxXkzYyyUnK3aZZfV/XVVHQ0DM8Yk+R3RlZyZ/Erp5CC4Dng3fmbto08Cf0z
	Q2ZjCLyt8y/5EvSk2av6YTiLgIhANJ+WJyjsMLANXO0NQFwVLXjVVT/Vl/1HO4CgXJoY6M
	wnZdLQAFE6ZxnPwlhI4CrwmkXxgUSyYqZ6TfrnRwQ394qLHK6fwM3/Su1Dl2UQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 08:23:52 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
In-Reply-To: <20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com>
References: <20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com>
Message-ID: <22a4dbf4a758adf10237dbf7681a57cf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 1.10.2026 06:31, James Hilliard wrote:
> The safety IRQ is requested after the MAC and optional WoL IRQs. If its
> request fails, stmmac_free_irq() frees the unregistered safety IRQ and
> leaks the WoL handler. This can warn about an already-free IRQ and make
> the next open fail.
> 
> Move the safety and WoL cleanup labels into reverse acquisition order.
> This also fixes unwind after later per-queue IRQ request failures.

Does it? AFAIU those cases already fell through both the WoL and safety
free_irq() calls before? Only the free order changes, which makes
REQ_IRQ_ERR_SFTY the only broken case?

> [...]

With that sentence above dropped or reworded:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
