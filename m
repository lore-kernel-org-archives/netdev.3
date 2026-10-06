Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E73563F6;
	Tue,  6 Oct 2026 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324708; cv=none; b=cvRbsZ9ypPFbfLZBBpbj9R60cKwO/O1HYZOuECfSc+BG5FrjJG/+4IacqqyQ87cCSc5ggtRZ2XyXuD5+Qqse57+6QK4mbBoBl68xzwQ3pr2dYRky2+LVsv5jhqNbdpxNyGx4hdX241LNBqjMcCdJOg9PL0WIefstZyhk/zjpErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324708; c=relaxed/simple;
	bh=PF/6rsWjsWeSOgI3iEe1n6J/zoSDVP9wFA2bdAYdTE4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p/FBKcJx5CFH2ls0+pmCD4kCH76LwBas4FBDVMcl7UDL3TPiBeZrAZRtpHdmhtZflfxc4JCOj9oXnXMVshFNXWgeWOF3W9O9Dgxn1Q6do3D7FlAOejlEhgUoYtAqTM2kqZcrIUr40d6fcdzu0shRRML3BshprxnGKHPDaVVgRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YV9FIN5i; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YV9FIN5i"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1E92A0F62;
	Wed,  7 Oct 2026 00:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791324696; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TINJvfi+w1Dn/tkBlwCk9cUaKMPh76yUWPggzDlrv+k=;
	b=YV9FIN5izh5LrdM/k4F+25mHY/dLJTGAYCAicxUI2d3By7f9HYy9YudHQDEv9jdmwzJ+8i
	u0B16BU7cXeXxehUzWjxqHmOAMJU+BXJXP9V5GFHF7AflUDAYAsIGVRPzhkP5eF0J3dN2S
	9/ymPM8J5/pk8ChfEitJ6gxY4hl7ano3B0lx9dEEO8BoQvjU1xhT9n+7IyQjaSdcs7gSnx
	LuJAz3Oc6Jgdp2D07iOalCoyEoSr69MYUywHXODEBk7iXqq9KtJHiyhvPYvyTZ0BAQq2zG
	HOrb4Ju26sXixVYIIOAwuqFM5qmpWxXci21RZtiACN0gm7mbaMeeldympbSHCQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 00:11:32 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Clark <jjc@jclark.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Miroslav Lichvar <mlichvar@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: ptp: switch to gettimex64()
 interface
In-Reply-To: <20261006103610.98277-1-jjc@jclark.com>
References: <20261006103610.98277-1-jjc@jclark.com>
Message-ID: <d1f539343b3f3b495253f9043b899875@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 6.10.2026 12:36, James Clark wrote:
> The stmmac PTP support currently implements the gettime64 callback to
> retrieve the hardware clock time. Update the implementation to provide
> the gettimex64 callback instead, adding support for the
> PTP_SYS_OFFSET_EXTENDED ioctl.
> 
> The system clock readings are taken around the read of the nanoseconds
> register in get_systime(), so get_systime() gains a 
> ptp_system_timestamp
> argument. rmb() is used to ensure proper ordering on weakly ordered
> architectures.
> 
> Assisted-by: LLM
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
> Tested on a Radxa ZERO 3E (RK3566, DWMAC 4/5) running net-next.
> Width of the interval between the two system clock readings
> bracketing each PHC read (2000 calls of 25 samples each):
> 
>                                          min      median
> Before patch (PTP_SYS_OFFSET):           875 ns   1167 ns
> After patch (PTP_SYS_OFFSET_EXTENDED):   291 ns    584 ns
> 
> On this board the 24 MHz arch timer counter advances in steps of 7
> (~292 ns), so all intervals are multiples of that.

> [...]

(for the other patches you have prepared I will have a look later this 
week)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
