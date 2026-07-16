Received: from shout02.mail.de (shout02.mail.de [62.201.172.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283EA34751B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784233209; cv=none; b=DGve+wGuQMXEI8sM6l9QeIjPmE3GfHrqNhjoIe44xjC/IWt3/8dsF2vVZkJZfsknhcW2cyM0mwhI3zCzIrDowgMPpYdIuccLNl7q586vNOhVmXUFOqpq4l/QUKt7Ypc0EUSphrxz6ofHsQ9doYy8f17KK4Ybsy9M5eFi7zQ5ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784233209; c=relaxed/simple;
	bh=yqKHlv9fWd4h17KQD4PutewV/S2KDnnvLqVuks27CXk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qd+2lfiEmiih82Cc1kLqXVebhJX1Ed8MTQ4GPA2bX1MLHOlyVjAp1qfLi/kAOPdihfEXA2VC/VWVOtbpkR3GKxw6IPJJGI4M7EfMN2urmmyXw3zWAxetNQN0e/g16CFfJukprUYoBIFI2pNKyP4Wb/XUmI09OewRZmvQ3AcNAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=h4VYYG5/; arc=none smtp.client-ip=62.201.172.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="h4VYYG5/"
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout02.mail.de (Postfix) with ESMTP id 123B9240650;
	Thu, 16 Jul 2026 22:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784232627;
	bh=yqKHlv9fWd4h17KQD4PutewV/S2KDnnvLqVuks27CXk=;
	h=Message-ID:Date:From:Subject:To:Cc:From:To:CC:Subject:Reply-To;
	b=h4VYYG5/hKlCU4Db7Fv59zRusGtyqOI7jFKVKSQKwA8wcObhpQx7AUxGkqkpd22GF
	 2JJOA+7VJl89XQj5snSxYJ89rY4Cj1VzIebUvAQNHryUWaPrhEM1RlSkIQlL0hOmck
	 1f/ntbuuHMhDR6P6RhjVxfKg6qz1uH0seTMRkh/P2k4UyWeBV8FT0Dh52OYk6yOGQu
	 tVfhf41jlrPdO6ZJs/ik+NwZw/pB6MmJEVN12vnZjgz/do6+RIPlHretd++rb9rtKH
	 pOdHpiTrebDH7b4Q4Ycc1VJTy9CHKRHnMpCF/HUNAHmQTQqdi8C6QDV4wem+9hWH58
	 XGaf0fl1E2PXA==
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix02.mail.de (Postfix) with ESMTP id E76E62400E1;
	Thu, 16 Jul 2026 22:10:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id ED0B5240608;
	Thu, 16 Jul 2026 22:10:25 +0200 (CEST)
Message-ID: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
Date: Thu, 16 Jul 2026 22:10:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: tresonic <tresonic@mail.de>
Subject: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
To: netdev@vger.kernel.org
Content-Language: en-US
Cc: regressions@lists.linux.dev, rmk+kernel@armlinux.org.uk, kuba@kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1058
X-purgate-ID: 154282::1784232626-D8A428A6-53B54ED8/0/0

Hello,
Please bear with me, this is my first time writing to a mailing list...

Since commit 1b9707e6f1a9, suspend (systemctl suspend) causes a full system freeze on my laptop. Fans and keyboard backlight stay powered; the machine is completely unresponsive and requires a hard power-off (holding the power button) to recover. I could not get any kernel output from the hang.

- Reproduces on current master
- git revert 1b9707e6f1a9... on top of master fixes the issue
- Workaround: sudo ip link set eno1 down before suspend avoids the hang entirely; with the interface down, suspend/resume works normally even on the bad commit

Hardware:

64:00.0 Ethernet controller: Motorcomm Microelectronics. YT6801 Gigabit Ethernet Controller (rev 01)
Kernel driver in use: dwmac-motorcomm

[    5.672548] YT8531S Gigabit Ethernet stmmac-6400:00: attached PHY driver (mii_bus:phy_addr=stmmac-6400:00, irq=POLL)
[    5.890940] dwmac-motorcomm 0000:64:00.0 eno1: PHY [stmmac-6400:00] driver [YT8531S Gigabit Ethernet] (irq=POLL)

Thank you,
tresonic
