Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC32E7F17;
	Sat, 28 Feb 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316992; cv=none; b=OJUPf2aGZ5+wFwi9n73EuTBpXuNyDVkjpVCj+/J+zJ+r53qSQPvj2P5UOoif0figZbpt3IM2sFGz9pL2eAfVXFyfRSVwiq4JiuAIAz7h9sVHy7qftXopXs3m5J//sLmTUrpwbKsFIWQ9NZNdig8lU1nDQuxZmfB05MH8Onb2BwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316992; c=relaxed/simple;
	bh=eHDs5QXBM2BAd2T/91fzs+0kULAnz1vehyYnjSjmnFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSuTQBuzolFiR61Td+atB8JgIXfatZgfB4+CcNb5Oohh1vVM2CDE0mvrogo7cXpMA+HoGI43Plpdhc73SVt84j7owA3llaDSyTu1zntnghsOZr+C5vHN3AAUVL1Y2/3q10ovzz0KvoEDWivrO7d12TN72r2fcxEA+ZgXaVSIGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl1Dj92n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl1Dj92n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49F1C116D0;
	Sat, 28 Feb 2026 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772316991;
	bh=eHDs5QXBM2BAd2T/91fzs+0kULAnz1vehyYnjSjmnFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kl1Dj92nKHJG7/2M8YpAxZlC+bgR9syYwuDOLdkuqTu+lCuHaKcD7s775OLXiHX4n
	 7nBtpix/nmUJlyBks9ojGkP+D4Yp2RDjGINtVk+GnOcYbDURQLTQB7uJnUxOeaFxuc
	 HkrvSqjdbTJKrnlwzdyNvVQNaT++55bk9W77d+ly/3xBIPG7pdccAcLNrMkqc98jB/
	 /wwbFYarQPuqcYoyAgLRHkiNvMD5j6LwkyNQ05z0r7ToGFUvMMZ831n/+IGC/m47m1
	 kEeMmRAPKn0sIdW1anISRcZB/ZVabF4w3deVwVk7qnLeWcWJsRzeak+wYXg+ZoaOzv
	 cfnLd5xe7hptg==
Date: Sat, 28 Feb 2026 14:16:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260228141630.15b4292d@kernel.org>
In-Reply-To: <20260226-ksz8463-ptp-v5-1-1bc24fb9627d@bootlin.com>
References: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
	<20260226-ksz8463-ptp-v5-1-1bc24fb9627d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 17:41:48 +0100 Bastien Curutchet (Schneider
Electric) wrote:
>  	/* Read interrupt status register */
> -	ret = ksz_read8(dev, kirq->reg_status, &data);
> +	ret = ksz_read16(dev, kirq->reg_status, &data);
>  	if (ret)
>  		goto out;

I think you promised to extend this comment to indicate that the
over-read is safe?

https://lore.kernel.org/netdev/c9cb204b-e079-4f5b-b670-dcce14101390@bootlin.com/

Also could you go thru the series and check for cases where the lines
are unnecessarily long? In netdev we still prefer 80 chars.
Not a hard requirement, of course, sometimes wrapping hurts readability.
But plenty of examples in here of this which could be trivially wrapped:

WARNING: line length of 96 exceeds 80 columns
#166: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1138:
+static int ksz8463_ptp_port_irq_setup(struct ksz_irq *ptpirq, struct ksz_port *port, int hw_irq)

WARNING: line length of 82 exceeds 80 columns
#207: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1179:
+	ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);

WARNING: line length of 86 exceeds 80 columns
#218: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1190:
+	ptpirq->domain = irq_domain_create_linear(dev_fwnode(dev->dev), ptpirq->nirqs,

WARNING: line length of 83 exceeds 80 columns
#219: FILE: drivers/net/dsa/microchip/ksz_ptp.c:1191:
+						  &ksz_ptp_irq_domain_ops, ptpirq);

... etc..
-- 
pw-bot: cr
