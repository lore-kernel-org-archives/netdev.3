Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284660;
	b=0Avdz4QdQt86NTS8blQapj9ykcG/W0CcTDsFdzQ9/Duo6kquRqehMs61caJwjWR9NCnR
	 gWn8xlJ4BbyRcSBQ2FYWtJLtwCdxPuFbacBCak+nOK3DyST2zH8XwDgcmU2QnsX8Wyho3
	 ErmJ7Y796gY0di0Cvy1+7AOZ/Xax7ZwCOcxMqAiZj9QSFR00jTEWHXaySTKDIrdqT6eAR
	 Dnas7zQQCLktAVJe9wk7yE4gxbG53IjdHZ+QaQ4c3PdxeX8l2UxRVQoiDtHnNul839au2
	 Y+dlzoWLgzIGsf7pffK2pphCHvKI3//zsIIxns6MzpWHQoWBXCfeZbyb0AefMU8c5EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NozN7LQPNlgO67WnfUnOBfVCkgTueMz1l5T7tv+iGy4=;
	b=D73wwXscUS1WPBAsI4qvndmLBRKBVQiJSmokWVUp3slgOueBCnWKOhGzm98tAyy5K9ec
	 RJl2kqVST2n5Ky156hrotAKUor33ZsDcRNTZ8KInTBAg4oSJLgcAZt6I8rG6MYGHZ2IJt
	 bsQXIXVzDxCMawSzQg4cCgtC7waujWSu1LgRmKnEkstOcbpYndrBeRIhk1lCmTHgaopcX
	 bF0ppQHENzPQ6w/EpDYYWD32AzWalWlk4c2KGANZqMs7O0RxAsHfZicwOyJRhvPVRv8tt
	 lUaStVNKSXo1K7dczWfRAF3wkvBUeuxL/U5ajcEbHGFiRqUPvOLzg0Ig/eAWz612NNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="XwyaI6/X";
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B60606BB00
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B60606BB00
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XwyaI6/X
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2464869c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1794284659; x=1794889459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NozN7LQPNlgO67WnfUnOBfVCkgTueMz1l5T7tv+iGy4=;
        b=XwyaI6/XFrQ0gxZ3AcLBiIeumVvHSl6ZcTQBvQ+Le3dpOLxS3w18WPNfSHoSmpSIxI
         HLlkGJIw2LDqnhg+BV5kWw5dO0l3X/+D5//sxJoHUe3cRT3aZbOFcp8JawPqxrAiHBFO
         qwvXrkqkkmDCxOt8re+pWIzt3NYonY/hVFzOKsChEcQLXlrdJSQZeJPN3PEghcAr3aJV
         D5L/ghNBnSP2h5e81vwZhc0RuQniSJMzKXjBdT67NJYcY2Bz41DpNTj2CXLEGep5c1YQ
         396c0VROmq0JifqdHPilzDXiW1i2aKldr06eC33FE5uvQn0oOyAQYblhH727OPKTT6Zl
         8tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284659; x=1794889459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NozN7LQPNlgO67WnfUnOBfVCkgTueMz1l5T7tv+iGy4=;
        b=rK/nIdG4M6ejGl2aLvWQo9ijy5Y/cRyGBTRZ+VGLbFW44lmsxwKDwaD0HMSfirZbol
         tDhnq6vXa7CamebqqZc7VH/Z5w1K0I4wHYHV96S8QydUKK/7aqX6GZX1dpz2vbKEgmOE
         CB806K4ShHecWhuYL2ct4YrfwzMJxgHTWS8PRttU7HxrvsI9XoQlXBMhmAKP8Rh65Act
         gph6PPjEyfhnQNQJ1YGaXN86vjEfX9R6bhjhhVPD1KSjI7zgEgDoUZYAMKl0LN5vROCR
         2M0nT2QtULo3NXayfz0UHK9o5Q8zKCF9Rl/Mg77k3w7f4C5dWZWsbguLlWVw75VWI6ff
         yy3g==
X-Forwarded-Encrypted: i=1; AL+hErHSkObq0d5oxomlBaAeYKZaACnjG9D2lh4PU8SlwO119TYE3Q74o/iodLH3E/4tJsnGU+YWFq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zbRgI+UsPedsuteY/V11IlDGvPCUMQs0vUvLDoV3IV2E7SaLx
	l5cTuWn8/C2s5nUuFFuEe6CDLCGqWD4n1tZvvhyqCYeDyQkOz+AjusQBfpov7xmInA==
X-Gm-Gg: AYBFou2y7XPF55gawoxogFHQa+pl9OxFIA5NfvJP/xTp3sHCUwMafJ7II7IYuMfuDlK
	7eWVq30/WJlFcbyoFkqADq9zpitxjj3JIh+K7pLRwjY7ASyY1HBroGJaB02mRKfj0N5bSqimFH5
	5PuvO8wKSOH3hcz8X9m2wuU+MtO0GKgbkBsJOYqp+R/n0SZyFi2ADu6wSgK/PSLl/zKZjtGR9x9
	6sFioHZzhuHtBn0fIv8pmM+T9W/Q8FG4Vhwae5BZyMvW7UMeZLhhtpzcf4B4ak5ciGfaCDIR+ZX
	WX2DZw+iyDhTDhcezZYT1xlk07/joiNIyMGn8QbYFwWQgMIFVROFKQM5VGNgY0IQvHjT3jB+Lf0
	1gHItyDIogg4aLigx3sFWn3hxZTQpQURQs3uakc9ovdw2N7z6sWeXIxXCwFT+yBXx2PG3VgnhT9
	vlgCJBTX+yCGa/xY0ivcFZcRLSl0yCDys8oesFghvtz5fQy1NQhevK9rd+kG4ZrRFWkS+h+Q9nJ
	Q8TCIYdlWALiYOZepCpN2PTR0oLgxSNjxPw4WC7JlZPYtFHi1+GN1S8W2mwTQqXABNDXSf2Qvpt
	3jB6JMwR1I7DMiyKPPqvnp+iNdnQWKtt7syZBDrzdQn0wrJdy45ApWorUiruTEU3wHx5wiaGblP
	IUEG09SLIIcr2+IIP
X-Received: by 2002:a05:7022:1505:b0:1b3:ac53:da84 with SMTP id a92af1059eb24-1b3b603ea3cmr2230611c88.32.1794284658677;
        Mon, 09 Nov 2026 20:24:18 -0800 (PST)
Received: from cantal.lan ([58.136.75.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe32276sm3116950eec.8.2026.11.09.20.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:24:18 -0800 (PST)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Rahul Sharma <r-sharma3@ti.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Chintan Vankar <c-vankar@ti.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 1/3] dt-bindings: mfd: syscon: add ti,am654-gtc
Date: Tue, 10 Nov 2026 11:24:01 +0700
Message-ID: <42bbc4a03679958f2ed4e195acea99fb57c68fd6.1794284248.git.jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794284248.git.jjc@jclark.com>
References: <cover.1794284248.git.jjc@jclark.com>
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

Add a compatible for the CFG0 register frame of the Global Timebase
Counter (GTC) on TI K3 SoCs. The GTC is the system counter that the Arm
cores read as the architected counter. CFG0 holds GTC_CFG0_PUSHEVT,
which selects the counter bit that the GTC exports as its push event
output; the CPTS driver writes to that register to provide hardware
cross-timestamps.

Signed-off-by: James Clark <jjc@jclark.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 80ff0e1caca2..b1030f11b2db 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -131,6 +131,7 @@ properties:
               - ti,am625-dss-oldi-io-ctrl
               - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl
+              - ti,am654-gtc
               - ti,j784s4-acspcie-proxy-ctrl
               - ti,j784s4-pcie-ctrl
               - ti,keystone-pllctrl
-- 
2.56.0

