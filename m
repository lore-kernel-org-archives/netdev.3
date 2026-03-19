Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689B1E89C
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910640; cv=none; b=tTqmdR0Hi3dBY083rKe3lEkX1tc7gU8kCfU3a4zo5AHphUH+EpFsJUpsONcYTM9YR9ae9H9Q0Bq6KKAUgcxSHCmmaI7sjXhA69JuTeOBo9ogG1FwP1tUWtIZK0lvr7j8xAGw54Okexk//dNy9ifF7EK+4wJeAv/HfTZdEb38QAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910640; c=relaxed/simple;
	bh=GgkHPpxm3E1ijmbyKtqj1kcTP9ncqNTEyMGgttiWZvY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KYQm1ugGlydqNHARxdv41f7nfYVQpYqjiQHfxGmvyrTIwZ72pQ6bzoxlnBCfYD8+WwnWsIYLJLlCAi5mxgL82+8J95TjpMFZDrSC77Hm3YdZfO64LDm1BBw9dLU01y/7kxAjGEpCq+ZddsOqe5xvwFWZd/sk73y6DACJFOOZ8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=uEvIby9B; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="uEvIby9B"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62J8uxCH33428350, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1773910619;
	bh=+wDgL4FYbv0KQNHEnDZQxb6blQZVZtpCUK073fjOdgI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=uEvIby9ByaT4mYeYoqA6mt+MLr4jAjEX0YJnUvybpZVaO7PjwuUIngdFaifyxTBgN
	 eHXHcG0fhBanILPY+AtQvOkVMvMINm5bqKI3QHTY6HMMNGTi2nSR1yy990NgN2xEP7
	 WRod0xRLz8Ta9hNSiDLwUIXgMcLElJbTkYqu8oRmyYya88cTvaeEz7tggzo03N/1V+
	 CKhJwTS40xZhy00Hynm7KsZpug1L/Uyfi8NzcpTvdiGU9SmtV2bKQ01+7ypt1AeVb+
	 L0uhb6fw3UM6pBrDcXRrpIUMAVY9uTSnCOZXGfVmrNSuzEDiBOz+FeqJTSrO4cWMA5
	 YSLZIwSUld6Rg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62J8uxCH33428350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Mar 2026 16:56:59 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 19 Mar 2026 16:56:59 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Thu,
 19 Mar 2026 16:56:59 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Heiner Kallweit <hkallweit1@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: r8169: Discussion on implementing RSS support for r8169
Thread-Topic: r8169: Discussion on implementing RSS support for r8169
Thread-Index: Ady3flT6SLXoIWu3RPmeYPmtdnYmcQ==
Date: Thu, 19 Mar 2026 08:56:58 +0000
Message-ID: <1ce3478d571f4d26a45e792c4c84c429@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, Heiner

We are now planning to implement RSS support on r8169 driver. This will req=
uire significant changes to the existing driver architecture, so we want to=
 discuss it with you.

Based on our vendor driver which can be fetched from Realtek, the key modif=
ications will include:

	1. Enable msix and updating the irq allocation mechanism
	2. Support multiple rx/tx queues
	3. Register multiple napi and update new interrupt mapping(isr/imr) for mu=
lti-queue
	4. Implement rx msix poll and rx interrupt function
	5. Implement ethtool callbacks for rss configuration

Should we submit the changes above separately or submit them all at once? O=
r do you have any other suggestions?

We want to align with you on the development and submission approach.=20

Best regards,

Javen Xu
