Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489762;
	b=i2HZ5yl5OeJ9xDFXXkZm0Q/2YVbE94lp94+iLr3FtGEVY0GhoWW4v12b/DOfTlxek+l8
	 Ub5QnQ4UlJn3+fTamcX6ad9oSthNcMq1ejewQdgHY99zOXwxuD+VHm6t/Q2HlxhFnRSSg
	 pKjSE8dAmTqC4U8/EvvFAcv2CpvgSY14l9PWnLVn2TnC/LRHEgWHy+oAg+ozOe03qDhei
	 bYA1oaqEWEzf9OeEPx1P1o8nxRHT2MILiGO6qM8azhi9JvALWX5jUmBgxs8EEhapK1daS
	 BS9Og4AJdyfdTVRSGRc7efzMQ24JtOZJ+KF5drm5CwJCJjMxhOP0kMrt2BzDlZZ8P3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ccSTKtpjKTVtHkCbDQpEVUXvzo8BHn21vQfhlDPvWNM=;
	b=qedST5NlZmctu5Ei87X3q8KgdLmoTAUzJw09pnS7sBKK2pnsV3UY18KrD5hOA5cQtb+5
	 V8iXLLALNWMEzlrq1fqwpGwGUh8J2mFBLhA3RxIjn9tahjNRUUviUhKW7dHSRtYve/zFq
	 gk4Vp3F9g6+7btS7Z+kKuskR0qEqGyhrWFgMV6PkrIb5btoIU3z8ZTMJDzmFQOheSaTfC
	 hyjf1XZ6MpQ6JfIg8e+queZDi5Tok77Ri32+XffSz6zHJshDzpXN/3bD0cRsCgN0acHvm
	 XnKi5VAY20mdk3/+w9cAa1f9joSJXTj30nAOGaOpxMF99WjPjBM5SGni2Vaff38D9Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbErw5PA;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498B606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7498B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbErw5PA
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c247f6687dcso699695666b.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489761; x=1795094561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccSTKtpjKTVtHkCbDQpEVUXvzo8BHn21vQfhlDPvWNM=;
        b=fbErw5PA4On6cMTc6udCzm/omXr3aSgfT+CqQZEoErw2vBXWAt6ioofBLt7a76KOPw
         YLZmNktd6KTgdyc8FPQJft+TFWssmC5hXLbG4d2/CPAL+gD0zT3vXBEUF5hSKSvXXnru
         HkaiO4qF0/tWRR4HD/SsgqwEld4bYqu1GT7VObDFDTRtLDh7/dkIF26wOp054Ws7X94O
         XOHlVrWtwFhARnL0u7wWZVDg42YuNd9TzRsbbGXJLbk94Kn04bvI1XthKBjvFLSR/NuI
         beEb3/bfJ5BaN10FXKKKtuqk6OAmRjsKfppSoYyriZvHloJ3CIUHOEcfOeuEgtIUqYAL
         UwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489761; x=1795094561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccSTKtpjKTVtHkCbDQpEVUXvzo8BHn21vQfhlDPvWNM=;
        b=rs9+PLH5o2cpPfHzxlxKPqkv8+2SNpmLkzsNPeJiIM5PsSH4rszn4H7+gRIroLpTWo
         IQFBXplTJorYdXXDFRWO7Oa8fw1hTaFDgMqgBeZ1cNrbwdsfyTnwU2j6ptpR4HFiVFv9
         goobTUvk505w643yqYRBW93+HzdQ/Pqouz6nXRngHBLibrJv0rR2ciRzKmNmL/6hFNKu
         cvXjs+I/DzqNSVO8XzXb59ShQT3M+VU5GYxJwFQ6qX26+PZHrbcTqox+0s5ftBlyVs4I
         HJHFhdaywF5yKOYZjIQahpFzMIj3te/VuXhPrFTobka3FVh4OYgW4il3uWWP9d9zJwsy
         HKgQ==
X-Gm-Message-State: APuU4Z9mSKRBoNaAw4WgCRSW8686TtUF4sBvjzAjPt4k5vQ/knx3iHFI
	W7pzvJQZd9r2w6PNIDGTU39Heg0Hmnqpg4Gdiv4Bf1tUcM91jihxwi5eSBC9tCLk
X-Gm-Gg: AYBFou3HgWqjPVLrb6jUvmHacxYg3YPlDC8FEq6czAd4++txrT99x+fO+cDbeGnznTz
	2eJxF3hhvsUmpiK6Gb7653DXkyu++jRpt7PRkGFoPVvAOQ0ij8Bfd+d1cx5jxOY2mN8kin3Qg6E
	/16yKAjGcVjCgCWss86gC/h24aUpBo1fymt1rIethLRVC1fU6I9p8ipdnFmJhV1nIYYXHsrJ+Q3
	+nlHgXYUGl3zfFyIh7ed63rgK41yCQN+AJKJnBYf/SXNQzH1OwuJX81jW8VczgoUw1Z61yoQAhn
	YhMfiEF+YlUUI83gwA+2u4ydHRh4NWpAO0qmX090kesPNLEwoJGRMB46CxbHDUWDXYpErDJZ8u9
	zn92GJ7A/E7jy6bueN30oO8KhsML2IERhusZV84J8rKBh84zE4zSWQVbKl5JZO2Ri4+yrHXY9KA
	8j8owhO405G8NL/DU4Wqlr6NuVmdZkWK9LQvWCZg3N1GLfoO1Q27UdlET5S1yCQc7BsYIGnPNUZ
	MeOgnrAiyCuZ/D1xAAVGZOe9uiF5EvNfCSOONBhO5HjqQQJvQo0eC4EM3QzBcFcVq0U8hFtjQQU
	aneUxpvfRV60GcJpdj0MlVVxgDJG4OnTgSO/gNr9B68xkPLYjT456WI=
X-Received: by 2002:a17:907:962a:b0:c4c:f85f:aa12 with SMTP id a640c23a62f3a-c5066b494e1mr547325666b.31.1794489760692;
        Thu, 12 Nov 2026 05:22:40 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::31a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a621csm344076866b.12.2026.11.12.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:22:40 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: BCM4908 Ethernet and 2.5G WAN: upstreaming plan and two questions
Date: Thu, 12 Nov 2026 14:22:29 +0100
Message-ID: <20261112132229.340114-1-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109231739.2561930-1-kudzo51@gmail.com>
References: <20261109231739.2561930-1-kudzo51@gmail.com>
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

Three corrections to my mail above and my later correction.

The AX11000 has three BCM43684 radios, not two; I mixed it up with the
AX6000.

I should not have written that the SoC SerDes gives the BCM54991E a
50 MHz clock. I took the 50 MHz from a comment in Broadcom's SerDes
setup code, read it as the PHY's clock and did not test it. I have
tested it now: with the SerDes held in IDDQ, PWRDWN and RESETPLL, the
PHY answers MDIO right after its enable GPIO goes high, takes its
firmware over MDIO and starts its CPU, and a running PHY keeps its
link. So MDIO needs the enable GPIO, not the SerDes. The SerDes status
still showed PLL lock, so I can't say the PLL itself stopped.

And, unlike what I wrote in my earlier correction, the BCM54991E does
not set MDIO_READ_FAIL on good Clause 45 reads: with a counter on the
bit, 11640 reads, none with it set. My note was older than the fix that
made the PHY answer at all.

Kordian
