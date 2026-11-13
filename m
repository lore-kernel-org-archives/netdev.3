Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530220;
	b=LPgD88AhvIJGA1BoFVR8eC7OEHRzlE/4vDGxyn4HMNydjs3ZfDfWSNtViYCx93Dz/XKj
	 4T/Ye07QGx/LwiUtMPfjKv21GN9CGJjhk4iOnqQL5U1NauhwlDtgcN4yrwFAyRRlhl/7+
	 7VknRwxSItx4vgXEZhBAq8oV5n9NYHThhJInCZc1Ag7DVaTD3l80dc9EyiSBvqWoWCAZd
	 f1JJJvQtrbazlP5XmTHXG2YlL/o21UTLkLRdmmB7UzkWXQLBkyTvfKCOHbpDVK63ogwTi
	 kpYea61YWNH8DJJDNQzy9cIO05tmN68BWFyx+NBnE5vLcjrJUcm4tB7zpaOTlx16O3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vd1pmQ/tTy1ka0SKsEViEHEk399ztjWfzFlh1vxTWRM=;
	b=aVaNCog3NDAKprhOKzK3C6IdNUmQQMHOI5N+LGEGv1xqUQTlBq1M2cyIuKb8TdO74X4V
	 7qvl8TlLLsEe7nQ1qFJ9UqzCz89FricWyEAmNd+5M90nAghsh3Unc2GwoH89QxWPYiQcW
	 XuzG0OCdhPDOQw++Rgqn7+REyz8JflDZfLY3Jmw8/beeRszcieRNNFpz1ZNV+9ZCIpURU
	 EVNKPMXPR0qRyCWTiLhtHPjW405dofMohOos5ieddDBKSgExbaPFXzCmVdCh7s/23FnVJ
	 qT0PHgzj8BoP8U4egUrfFireNy9mQ3WTm/UdVK/P7L2MBe6QUCj/2Hxqb3hCE2iC1Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaNisiNU;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14844606A88D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14844606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NaNisiNU
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so2528875e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530218; x=1795135018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vd1pmQ/tTy1ka0SKsEViEHEk399ztjWfzFlh1vxTWRM=;
        b=NaNisiNU77N77V4vCcQ1icKa7OMJCiXO6trRwus913Lif1keluGkym1ogzwsMSBsbx
         VZt8mIoNREjgHU/QyR0cQrLmt4QUJ7gicuX6EPPtgtcTIyskbUH3a2lOjZRPeA0vbaJv
         +qo0y/1wi+HqUvpWIOAi7x5/Wside0GHORLIwjZ7VZX0sYzIitZION6/x1HcAAJJqC/2
         c9gCWNOaabza14N2lPuQUP/C44QAwEvrU7v4iba+a9FHz8WhsRoupeNjF0YeNRpnW5VD
         hU5QsuCcj26v3XfuR1fVlYyMf8f/KVYRh8iuemaFXzx7WWMj3rf0bYtb8r6jiZaAOHfm
         b+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530218; x=1795135018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vd1pmQ/tTy1ka0SKsEViEHEk399ztjWfzFlh1vxTWRM=;
        b=pkXHg/a9dnfM/09yHGSt5ujmzSOxwEzwtHfPPGK7vymEvx7Jt161A1ZlT6lTYVbBcj
         mS7hc9RnNiTr0oVtzzSuINm+NX/mCW+CYx1RsON7JNud2WetDgvKJ/0s3v1CzOw6XKdw
         RjSRAAMaFvhwcRGaZaWy5J71O5VbpufK9U/T+hJgCTJN84015yl9n/d6PWHk6kTdp1UJ
         1TC77rp9jJ1xjP8XtNggyt2I6LuRvR6mH/xFNKcc/Ms4Ee1tv6EEzjBiamvraMKCrdNe
         rQ63z95VRCFSCNmt6Pad0Q7iKPS8Jtmlj6+Gqz1wfgo82a7TSgXFRYd8D2+w8Jq4jXkL
         ieEQ==
X-Forwarded-Encrypted: i=1; AL+hErFHJhGQP2CAIwMcL0oYL+gAzUXCkzBrgKo6m9nWEqc0t0JMEI2HZcXLcHFANTG48kAddytJr48=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ir9YFqXaWByWGxcjh9EDeyYyqGTPokc8RkOx2Bt7Oo887uA4K
	hCBdmoYuqUNngPcqi6g8TFCao3oFit5A0zpzg4xrl97MOwAHrI1/NLpr
X-Gm-Gg: AYBFou1YmMtraHHJp5zk05/cUAWhVqrA02ZdnwUANMR42B6mh8I3x81int6eKkC9Elc
	ZeX0TQ2LoJ9kRaCMYRZna7JxZSQKPRr/PwWdpCVEEs06yqQeqxMNWLw9fKazEiTRPfI2lOvh76B
	MEaXMOLn7cZefSbK95StFTsMzphkslTIsNKLB+ihV4tY+8ad5MCJGdJy7DZZaSV9oZFelVfywwZ
	mPJ/N/GxjoI4uDPNU/e/grt4zai+kvaQ3Bep8syGmGEAK1sJEGRlatwFoZotGgGLTMm+Mwylr9F
	kLa6UQAGmqb/mHAcH/oFl5foGCLRtgDFlGVAnIYsyuMhOShThvlS/Ol2goVe5nmBu4kwCaV9jhJ
	dUTZHuXNtDb9PgSYEpdCY5Q0TkalNDNvLVPLVXuza9gJ1SpByLfTYK+z7kgMxk/5OWRr3MJCLuF
	VrzDt2btAS32w0JqMMyDbbT25kI4P/CQzFNJK7uchix+FV7w2ZgvPSRSr3cWJ/wVcgBZMcUwhYL
	wXXUjR5eTOZe7a5lA+tpsYVwsAEvtrcvb66KOT01EOduvo0M1Hr1fc2hbmTMDQ52tP/wSqA2lxz
	apFJOf8Se7V9IGIh1aYwRSiphKWBAnKbyfYkxoIvPqRxANupZD2Uz5xl5ajuv8/UyOIB1pQkymD
	JVnfqp7xGlzVKQQUR4Hvf1zsRV2bAjIC0XyJPMyvSKYhzhy4NQ/ns2tta6mkvoYNrVoRpe/NH4Q
	ct5LCQN03cllhE0Zj6dOOqV83U5BaBc/8dYF+0tmg=
X-Received: by 2002:a05:600c:8b56:b0:4a6:44b:2593 with SMTP id 5b1f17b1804b1-4bb55ad0711mr16815645e9.29.1794530218377;
        Thu, 12 Nov 2026 16:36:58 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm106506085e9.15.2026.11.12.16.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:36:57 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 16/24] net: phy: Add Sanechips ZX5201 PHY support
Date: Fri, 13 Nov 2026 00:36:55 +0000
Message-ID: <20261113003655.3665572-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <788c9b01-473e-4c45-b6f0-b2ba054da8e9@lunn.ch>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-17-ghahramani.navid@gmail.com> <788c9b01-473e-4c45-b6f0-b2ba054da8e9@lunn.ch>
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

Hi Andrew,

Andrew Lunn wrote:
> What do you get when you read registers 2 and 3 of the SERDES? Is
> there an ID in them?
>
> If the mdio bus is scanned, and there is an ID, phylib will try to
> probe a PHY driver on the SERDES.

I read them on the board. Registers 0 to 3 at address 9 all read
0x0000, while addresses with nothing on them like 7, 20 and 30 read
0xffff. Something does answer at address 9 though, since registers 22
and 27 there hold the values the driver writes.

So there is no ID, and no PHY driver would match ID 0. But phylib only
treats an ID with all of its low 29 bits set as no device, so a bus
scan would still register a PHY device at address 9. On this board the
MDIO node lists its PHYs, so of_mdiobus_register() does not scan and no
device shows up at address 9.

> I would suggest adding a probe, and validate phydev->mdio.addr is not
> 31. ENODEV, or EINVAL, to indicate the setup is invalid.

Done in my tree, the probe returns -EINVAL for address 31.

> It would be nice to reverse engineer what these bits do. And then add
> proper LED controls. However, that can be later.

OK, I will look at the LEDs later.

> This says it is an RGMII PHY. Why does it have a SERDES? That suggests
> SGMII?
>
> We need to understand this, because if it is an RGMII PHY, we need to
> address the RGMII delays, which that page says it can controller.

That part I still have to find out. My driver has always told phylib
gmii and the WAN port runs at 1 Gbs, but I have not worked out yet
what the link between the SoC and the ZX5201 really is. SerDes was just
the name I gave the registers at the second address, and there is no
public documentation for them. I will find out what the interface is,
and how the delays are set if it is RGMII, before I send the networking
patches again.

Best regards,
Navid
