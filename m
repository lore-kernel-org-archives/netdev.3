Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645ED345734
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889634; cv=none; b=m0wbYo61+W53wrHtSbMkIibaeDe6yAvyh+y4tBpAbx/1aflTOve4by0KsEO9PcScir8I2L5UXO07eor+UKg+R4H/6Sl4oQSTtecFvpQA7XQXQYEfrOdOE3ysHhJ20DKIZ9G7/CZsx1Be7j5x3gF5Ej/dcYsXoNrCouyZOwrh5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889634; c=relaxed/simple;
	bh=XuMZ8+mFbgR9j8LA7OKE+uxnbtH8pM4ZCfuc4rtF80I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEKux6HVLJaWakFLBp56XQTcn+cF+ixwvBRASbgEfZgqvo16qDvtaz2gZ9akmOosnZuGQQBbvNJBdsrpTmEHmoZFUkNhFCtwR2dk8BYxiDcUBc5DP8KumUvZEHr+CPjJMmTXne1VMUqaXBl8nrzd8Fendu/bnP2H5NJXY7AWhMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KNJmXBzA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KNJmXBzA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 666D1C79AB6;
	Wed,  1 Jul 2026 07:07:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B368860288;
	Wed,  1 Jul 2026 07:07:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50DE3104C9988;
	Wed,  1 Jul 2026 09:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782889619; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=U7DRiFuAOAPDhfStcuT1pgWpZEWoqx8/JuiW2Ab02S8=;
	b=KNJmXBzAV5oMriNpY7tRZVFbdkSTntSE8dAGH82Vc7aQasX7rPbs3F7S/sN4dJgZNorKnw
	Pu9XHEz3DHU70wRTjFTcZxTmi5IyQIEWz/j7deRIWMPyiPSycneu4lurtXshpUOTI/snQm
	FRt36V4f8m5oNYu4gmNfa/mF2jLy1kZqXYV/mI03wWM4QlX4h32WG7B6DNM0n94Q9/riwn
	DdLu3kp/hRjNn3D8j2N3h/4co7R7Qm0Vfq+JX0jBEEqHtC9btntQdC0qmoWm1CW9YlDU0H
	6p+gJXSBxDz/TFjcw7rFoEc89BdfJ2boBZGfj1H7E/XtrXvNl+Ae+lLlRuFrqw==
Message-ID: <7a861f08-6bfc-4ed8-b8ca-9f4317dde630@bootlin.com>
Date: Wed, 1 Jul 2026 09:06:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net: stmmac: L3/L4 filter bug fixes
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/30/26 13:56, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> This series fixes three bugs in the stmmac L3/L4 TC flower filter
> implementation for the XGMAC2 core. All three patches target net.

A quick note on that, I noticed all your recent series on stmmac are
missing the tree tag in the subject line. It should be something like

 [PATCH net v3 0/3] net: stmmac: L3/L4 filter bug fixes

you can add it when generating patches with :

git format-patch --subject-prefix='PATCH net-next' start..finish

cf https://docs.kernel.org/process/maintainer-netdev.html#indicating-target-tree

You can also use b4 for this.

Thanks,

Maxime

