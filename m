Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912281;
	b=uADiKxQG3k9AhLnAxkqGSTBSrGTOZO3JAirOXEqXvySEAfDD10prMHZMrFOGMR4uTCzu
	 RQfXPa7Wlb0D6rOB+CeMzbyRbnzfSuUqPhb7U5C2/2GrEKN/n5n7k5kzml4hf9dTMmvdN
	 k8aFMC0DAEo9haoT0ZEk1Rn7fgngHnAwewrDzr7FraATJRASVvJ9Iw8RrQmn675Ei2wPR
	 Pg6F5KftXCZBsZm2y7gIJoBK22Prg0F6ZPxLpwZbonL1wtdJpa8R99w9M9MZVOa8AhbGn
	 0l1t7s5dzm/DkgAziW8Oc6TLVFQmV5iQpuCH7RIizpuNZ7+Qr8NYdcEbbWVVa48BDKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912281;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=y3OwD37SrGJresbxUK3F5nIZp/tIcgjb7IQgtuSfY9s=;
	b=gDNYMSEVg8XxhEDcYSqfZ1HWcJIMD9KWwTC+q0vcWJuZ3AAXrD+WoTZa8iSRvVoZKPb6
	 Nz+gC1deJvDi6R1iQwrXjHJ9D/bxc0DfVRJJMr+LVikZCR6QDjVQymH/068gkbLX5ZV8F
	 ddX4K0DPKLUsxeIJG2VSq5wHzbU7VrpFIWDibwLevzRmd2v00Hxnnj0OPBF9uLGj8eOdi
	 5wUopffCVZ3b3IPFZiAVjF6C/sJFb0F3wzLPMlwx0VtC2H7TSXeWapR7q2e+bsJDWvU8o
	 8j8SvED7VaWCpaGo/lTvUnPIEtvyMfZsEzBsnTa/K8FldQqPJSS6A9/h2+gulugtkww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4499606A32C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4499606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1799717a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912280; x=1794517080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y3OwD37SrGJresbxUK3F5nIZp/tIcgjb7IQgtuSfY9s=;
        b=KGTwme0ZLKGkdv0p74C5GUY0mE7UHhC9qfavVe/UXv2DrDcGunkcGt7UqEHpa6z71P
         vbXjqVyLsL2cCQLXU/hJCkWis4zrWeUtOgIRpI8MtfexR/xcmz+dLCLHhgovGwDzpXF6
         b5C+gqshHuDyZdGLLXcnCB2S4TgTazQMWZX8Ggajj0DQCCKKc05CjwJtcezzb/XoOCtN
         PJKDCJgwqW6I5JGWnzwP11dEeTOsqGv8L9WdetWovqGxpH4gok2U95mQU2FYnCbf7810
         PKiy/8gERG9aHOqwXnqDSxpywht0UFk3MhqLXjuCQyWljd94E5bvHxmqz1s1Jq4TwpuP
         /FFg==
X-Forwarded-Encrypted: i=1; AKwUvByRSMz1YVEbV3xBFIq2v6TPpquCLSTgklrUmYBOrBgzP3eKGnv5yjdiuC3FP7WWQTuoMn7XJwE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TsYkY6nXW0yM+HXM3Q1myb5iB38N+xbPzZfMdjirjdQNe/PWi
	c159l2ILr5hksIKocQmnRxvTcATNqszPp4gUvIQQEDeXDJDSijpWtWI+qN0KucRw
X-Gm-Gg: AYBFou1lBTb66+EiQTrub1hoCU6lNPX1awyPlDlDaefyWovrhxV09CJMqnnTWEMXIol
	eOZcMarv0gywXfB9HGHM4Az5h2AkuiT/Zt6ieEk5Ba229vX2skUJZL3qvLARJRaZls/MKoEsSHK
	a1tpjjOgaJRzmOWS9VoZjhDGG+ohgj3FAbQSASEm093JcWoXRmMQh+k3N02Ng62WgjfttFYGBe9
	MPsHxiGc8XK0PoVOS1V798a3jeqUFTIA6l5sZTiHnzOlPA1DBZLwMUYBqxyo9f67TE6MIy77BEA
	uNBxuA2KpYl8lBhfTqzNEqBknsNWdE54taBcoW/ZWL3/W7xcirMMFtuKslo39hftyrsG+jG0Icy
	nK8fn2GOm8wQt2YCCuHLdLu2t2uIeolHBJSPo5168wKLec/BYqulZFv+Y6xGm/SVMazM+2LaPzo
	yE+qSs9OOZYGQnGvGe3DvWzURL2EZQdxV4yY6BS05oDKp4iCO5UyxqzuwyBWf30qLXy3CFnhNoH
	x1X6RPGLQeikO2b4FTVJFbE/50VdsRDrMGCMeuD2Y0loxWGxREIEKTPmcoLxddO69iuUlodzlvq
	29YNg4VyApWmPR9Se/vFhluBMrFjPjKI72fBfCi7tGcdveFvDapyHxgTt9PP9bdPihApTN4//Ti
	lkxnYd8/Id5KnnLM9DiWR76GNwgSO2G3V6X8pxlo7xe0=
X-Received: by 2002:a17:90b:5810:b0:3ad:50a2:9abf with SMTP id 98e67ed59e1d1-3b0db6edca5mr223599a91.38.1793912280056;
        Thu, 05 Nov 2026 12:58:00 -0800 (PST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com. [74.125.82.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d78b0a8bsm681973a91.2.2026.11.05.12.57.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 12:57:58 -0800 (PST)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3807123eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:57:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByjblyLyF+l9BuNBVMql7Wfn47CvCDeD+rSkCN8CCpNQYhtFjnhaOlacNpNtHB3azqVF0e+UH8=@vger.kernel.org
X-Received: by 2002:a05:7300:ea91:b0:36a:6d52:e16c with SMTP id
 5a478bee46e88-36f75253924mr438929eec.12.1793912277153; Thu, 05 Nov 2026
 12:57:57 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
 <20261104-sf19a2890-gmac-v1-1-a15965a49574@telaak.dev> <e134193f-ba1b-47c1-9a06-419b1b796ea0@lunn.ch>
 <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com> <ba32cd69-23a3-464f-a74b-68a29e7b8202@lunn.ch>
In-Reply-To: <ba32cd69-23a3-464f-a74b-68a29e7b8202@lunn.ch>
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 5 Nov 2026 15:57:45 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ6mCc5HgQUZd2Mq3C=Tsmwp=-acAV8dsWcpO_J87Pr6rg@mail.gmail.com>
X-Gm-Features: AclHuK9hGSAdRKsJYKbyzOuaSV6hdi58LXaj_oUeX5Eo9bGiXxx_BR0j2WjKwyM
Message-ID: <CAPY4CJ6mCc5HgQUZd2Mq3C=Tsmwp=-acAV8dsWcpO_J87Pr6rg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add Siflower SF19A2890 GMAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Chuanhong Guo <gch981213@gmail.com>, Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> Do you have access to another board which has a PHY connected, not a
> switch?

No. The GL-SFT1200 is the only SF19A2890 board I have, and the only
other one I know of, the vendor's evaluation board in OpenWrt, also has
a fixed-link on this port.

> There are unexplained delays here. Is it the switch, this MAC, or the
> PCB?
>
> We need to understand if tx-internal-delay 0 really means 0, or it
> actually means 1065ps.

I can't tell that from this board. The sweeps measure the sum of the
MAC's delay line, the switch and the PCB, and I have no documentation
of the line's own delay at step 0.

What they do show, in the MAC's steps: the windows repeat every 8 ns,
which puts the start of both eyes about 4 steps (0.2 ns) below 0. TX
ends at step 51 and RX at step 28. So with every delay at 0 the link
works, but right at the early edge of both eyes.

Until that is known, how would you like v2 to describe this board?
