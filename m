Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379824;
	b=zWwVfo4Rli9i+h9BnYnK3MhW7b3bBFV5wkvS0Eq2TbGJrFir94B/h4Bf0esWI1Mrh663
	 Ej4fAeoHxzFH+fTyg1Em9DyvejpCddLFxWAeToWLJOH2sUsKsT24IQr0Il67w+rIEIVOD
	 V6yakzHVesLB7X9nJnWbs7T/qPXfv6xavz5jHAhHeGcGG2eBymZhsGdzNNEeK3BaAM505
	 bFx1QfUVSJy8jr4uY7BHOGB6vwQUuKaqo+mVjhFVTK1swkkV760eYVofYQmvIz/lQ3mz8
	 qeg8epZe30lyAuUYmWodsWgP98cRnj0dyvDWZxUJOZ438bNv3LheW8payflXR4dDkzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379824;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=IE/0/wHsXzW+zXG7ICg4OVEoH7lwX4Q6eNKHPFTJTL4=;
	b=eIktcgkjj8A4R3BBnjoh0/VEQsU24/vZqOpGsLLocPZza8vHq1/K0Ld7Q3SNx1NnJFoD
	 PWAsXShi5UI+ptS+/nRnVU4zJG/X947cv4yWzIhgIzZPNM55pLCNrn6LJMVFxboEj/Ae+
	 WUmE0Kzwojl9PW6YqCgVDDzeVAf1+b1km5ZoE6YaZ7nnXk01wTO3TDaNUYwzCRMqxO0Ge
	 R6W0po8OFiMBW7yqg3OIX5FQwaV08imRLC9GJr7E2ybwYgS3pXQLGg0XyMEZmpBwNtXjl
	 zONIkGXY7olg+dFv78z43vFaKUOHKAbPi/lAJVsehEPil3SwWpdaIcCOkKiIaZ9Vthw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jmu.edu.cn;
	spf=pass smtp.mailfrom=jmu.edu.cn;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A581606A321;
	Wed, 11 Nov 2026 06:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A581606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from Vostro-3710.. (unknown [14.220.232.40])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54450fead;
	Wed, 11 Nov 2026 14:50:16 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: andrew@lunn.ch
Cc: Frank.Sae@motor-comm.com,
	amadeus@jmu.edu.cn,
	davem@davemloft.net,
	edumazet@kernel.org,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: phy: motorcomm: add led_brightness_set for YT8521
Date: Wed, 11 Nov 2026 14:50:10 +0800
Message-Id: <20261111065010.2040437-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <598009be-95f3-4091-b3bc-98815c65216e@lunn.ch>
References: <598009be-95f3-4091-b3bc-98815c65216e@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c95f1ebf03a2kunm23cf89e217c0bb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkNOVkIaTUMYT0JMHxhNTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVU9LWVdZFhoPEhUdFFlBWU9LSFVCQklOS1
	VKS0tVSkJLQlkG

Hi,

> Has this been tested on real hardware?

I tested yt8531 on some SBCs and will add this to the commit message.

> Have you had it blinking the heartbeat? Shift-lock etc.

Only supports forced LED on/off. Forced blink is disabled by default.
Do I need to implement heartbeat?

> I _think_ this is the wrong place to insert these.
>
> The sorting of registers is a bit messed up in this driver, but i
> think you need to insert before:
>
> #define YTPHY_PAD_DRIVE_STRENGTH_REG		0xA010

Indeed, I will correct this.

Thanks,
Chukun
