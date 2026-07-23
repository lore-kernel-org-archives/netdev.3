Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C381B470EA9;
	Thu, 23 Jul 2026 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775973; cv=none; b=MGPurbbnm+yty70g/jPPBmtoz6qQ+lgA80mDKMBU8DSaRxE0pr9F3xU8Y/7jQaornvzhrx+OdHRRMx8R8BT1oJed2TzMxMN5js6F7fojYnBUqSQhDp4TkoOBFqc06pmDIJJhk1UCJjmcCfQsDJKmM7iI5pzJdXWk6C/J57eizLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775973; c=relaxed/simple;
	bh=r8b9l6Ei/KaMuZZkiFdZBh+7ujzJG/BBNXND4OLPBGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RdBlc7vePgcXI4fzcjMe1K6ZRoZVyUP28kEprrLxZYWM5ykQYxL0OvEcwwzdmjfqyh2P5u/k7j0//DaGZPTf1baNifilCq/txnlQTUzl623Kab7JmwKPpZfby3KuYwQXXwGDjKo7flroz8ksEOjCSBr3/uDMy4b6S+kcTf50iLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=eoZHFtgg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="eoZHFtgg"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N35JmzC167378, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784775919;
	bh=UDXOtRSkwR3vjd70Js3z68uAxJe0DoucDjW8mhnqa+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eoZHFtggGyauddNQNaFmmCW/H3L9/gkIkKnEh8epJmjXJkjTtS8ZsDJq14Bb4cnMN
	 6alm8FDy1CxPRO7VKU75wzQkipyXwzjKvs1W//cmV+BtwRsEgcBuq4ptU5s4ib702Z
	 6gKYQoYWTe9sZZeye/9m1TW/nrPOmrVd46HF6SMLsTwim/yekAVVj+q48gJwKA1RYV
	 FokWqaRFczJi2nYwMHcIKYYWbvPitq/jHVFnBQ3GZG4KH3GtYCkNfPetX07qE7WCq5
	 wH8JbD1hSID7P96VQ7t85/9neyUMoqBwIJ1SX2CC9VdnYUalKMZx1d1W2eLlbDsi2/
	 C2N6AxaFOKsUw==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N35JmzC167378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:05:19 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:05:19 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Thu,
 23 Jul 2026 11:05:19 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: RE: [PATCH net-next v7 3/7] r8169: add support for phylink
Thread-Topic: [PATCH net-next v7 3/7] r8169: add support for phylink
Thread-Index: AQHdGYHgTFbpLkMdH0aFiTSnfzDH2rZ5xVaAgAClHYA=
Date: Thu, 23 Jul 2026 03:05:19 +0000
Message-ID: <70b8360675c744ebadb057b55ecf87df@realsil.com.cn>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-4-javen_xu@realsil.com.cn>
 <bb3be7c9-2f7f-4871-9b3c-bc5958cdb6d6@lunn.ch>
In-Reply-To: <bb3be7c9-2f7f-4871-9b3c-bc5958cdb6d6@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>
>> +     if (jumbo_before !=3D jumbo_after) {
>> +             unsigned long caps =3D
>> + tp->phylink_config.mac_capabilities;
>> +
>> +             if (jumbo_after)
>> +                     caps &=3D ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
>> +             else
>> +                     caps |=3D (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
>> +
>> +             phylink_update_mac_pause_capabilities(tp->phylink,
>> + caps);
>
>The name suggests it only changes pause. So i would expect the caps
>parameter passed here to only cover MAC_SYM_PAUSE & MAC_ASYM_PAUSE.
>So i don't see a need to look at tp->phylink_config.mac_capabilities.

In fact, I added a strict check inside phylink_update_mac_pause_capabilitie=
s() to prevent non-pause bits from being modified.

+	if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
+		phylink_err(pl, "Attempted to dynamically change non-pause MAC capabilit=
ies\n");
+		return;
+	}

But I think you are right. I will fix the caller in v2 to only pass the spe=
cific MAC_SYM_PAUSE and MAC_ASYM_PAUSE bits, which perfectly matches the fu=
nction's name and its internal check.

+ if (jumbo_before !=3D jumbo_after) {
+ 	unsigned long mac_pause =3D 0;
+
+	if (!jumbo_after)
+		mac_pause =3D MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+
+	phylink_update_mac_pause_capabilities(tp->phylink, mac_pause);
+ }

>
>        Andrew
