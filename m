Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830592;
	b=Vp6/wSuu7qOY4vNP/UoVkuJDL4mY3o8e1UtWKtWZ593W+NxzISkRDGKiG+QGaljwvWQK
	 5XXCJomeTCO05TdJUXOKfRL7fvSwEUeUkrIR4zqsijqbuKeWoZ/Lq6PrsIqL9z+uTfC4L
	 sSpbogRjqFgdFxutG7VaIoUjIThCH9FGpihGAMNMnYBPZ27ppvJc2FOkF0fkNGMeepqUH
	 8ftRFRG14wNkKfAesCfgCfAcACIFB7jVlJjAMtKFTzChOlMMX7LuUOsI7Hz+XsQ7oKXVR
	 9+oPqx36ZLgWbTSU2vv9Gca5JYucSIfTb3bg18C6Vaogii3la3y4syDGwRywNp+go1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830592;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=4dUj7qtlv87aoaokSVHZlryaRSMAw8BaqO13OeSv3d8=;
	b=Mq3uf2CEov02h+iZ6ff8NkG/FCexQkBL6o5qLSzEv19OgWfAOzknnmQG9zwZb40SDNtW
	 efIzaUtp+lzYBZNbzO1EuwmYTariA6msUJ+8yb6Q4Tz/W80qOknjOXGtQras5O103H1pS
	 u5Zb9QePszqnGSSLDPqqGg2zpHC0gSmVUF6UH0B4zp/rj0GOGmr8XRk4ghbOiFOAlFWsN
	 briAKKrOuK5KE/LBZw2z+aStT3Ed6kIvCJ874DgaUGcS0l6WRpBq9ImwAJOv1vsZyLOS7
	 v8pa/Dd1FiQK4Xo7MwA0xUwr1Wr7Gmkc+NvZFzVKoha5cpmvSbBzFefuECV1yru440w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF4606D83F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 22:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3CF4606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so38093b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830591; x=1794435391;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dUj7qtlv87aoaokSVHZlryaRSMAw8BaqO13OeSv3d8=;
        b=Qp0GvLkmzqRQVJe2++/I8JMIC6HcWolS3Jo3IHT+ARjaNlHS7y2m3Y2b7fWiN3iePW
         r2Nz3cvza5WCl3KtPJtUbJdYF/MrXvfXEdlJFfS6t8lZ7MUo0GdsSF6jMxRfenbzZfI4
         3OR1uoq3/aanDKzvASoQR7YQIPaZSx6ClsF+76MHrT0lSvtORt9W6KTzqcextKcLgN7y
         vooUr1WZqYxXqA4IBNNhvyK+N3XRLvXpcOVAbQ3+RkLYXqszEYAkInvrhCaNe5bzSK9D
         ePn2yjCaOvCiJcrCHdEgrkxO/molfxbIsnQJ22PU4udlTdVUSruzjtgkJw7itnakV1AX
         VY2g==
X-Forwarded-Encrypted: i=1; AKwUvBxgEAu70UA+7EY2WjbJtREdckH4vIkQICxR4WSEq0PbXkfqut4oQnKhwkPIWOj8OeOm6herV6I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yFn6qPXHR1aBeVsjy6/bGBD21iyo5dQjDaovXYqgLCA6bqH1W
	nnFTORDqmeIV2aT3tq48OJeqGfT1NPi4PfwTBzLvB+4PPoffj0eGkxur85hlLiJ/
X-Gm-Gg: AYBFou1sklWHCaTMFyS7oaOWgVAgcwdnaJGLJhC5CfVQUrxBFQFuMjeuwLrk5Fb259H
	TVknjPdML7XMZ4YJNkG0qh+Lau8foyJMnZr+bEIs2kpDXsRxF+VpQoFlvQQhCynbtQ/doTVvDXt
	Z/BWWGpw3dwMlJIrYpYhNoiT8trMCxVfDnzZclTK3PpTPqf//izSmmbHR8qQMYUsEi6ZnXaUEyF
	ZzRpwrych0cYbyV3P0Z/blIbRJALAcU9nBD/7IlUPDv80iXo26htuDW6wb488DXl8/QkZjWp9gQ
	MmyCfRBss0pgfiiFIrqXeChKIehQ4PRRtGcTKKojc3XXv3GkZ5NkqtQj9zdJ+F49jYAhTbs3LkR
	HAfxBkWiMdTKoldgTBhFUTgeBryAD41oydQzLSOH5/Xuu7YhVzuaJl+hXFsPZJC0rhmIRSVMqad
	wU1wAQg41PINf/R42PNELKoxJ0AznzkBWekjDf5+enStJ9J8LY7ZomyFgX9ChciGrXXpOOA52ka
	iXOg4q1Tn/P6PR/KA+rG4vSBWqi/tQIiOr+NYx1g1/t8IS71Ar62x9es9hdN9Om5yCMoepLic0n
	j67RM4UhRaJadzHR5hucCC1nRYQhLnO/gULZKfFsKpB9vJHHitEgE//A0wa4GYW5PdXg0DvjZqN
	2eCA8Ecx/d7GTXcHvD7B+zlqoXoHwyV/ZegmIiJc9IDM=
X-Received: by 2002:a05:6a00:929b:b0:8a0:67e7:1004 with SMTP id d2e1a72fcca58-8b1e519d1camr483994b3a.11.1793830588206;
        Wed, 04 Nov 2026 14:16:28 -0800 (PST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com. [74.125.82.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b567137sm1346094b3a.33.2026.11.04.14.16.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:16:26 -0800 (PST)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a315ed211so81690eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 14:16:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzoQbmq3VHAbwfyUpYiYa4kIYAXXMiEMHWXkQUmBINrIojPeGaP1erBSrOmtUgIRRsdhxZm7+k=@vger.kernel.org
X-Received: by 2002:a05:693c:80da:b0:368:2c6d:ddfe with SMTP id
 5a478bee46e88-36de5f6f030mr1017112eec.9.1793830585474; Wed, 04 Nov 2026
 14:16:25 -0800 (PST)
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
In-Reply-To: <e134193f-ba1b-47c1-9a06-419b1b796ea0@lunn.ch>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 17:16:14 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com>
X-Gm-Features: AclHuK9-UnITn3qNlxFDVEt7-zpIej_-hzEuMRZnZQ7mZri5SrN5fWqpIt5XJGI
Message-ID: <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com>
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

> Please add minimum, and multipleOf.
>
> I've not looked at the code yet, but default: 0 would also be good.

Will do: minimum 0, multipleOf 55 and default 0.

> These values are odd. The RGMII standard says 2ns is required. Where
> is the rest coming from.

They are the values the vendor bootloader programs, and I checked them
against the hardware. Sweeping each delay over its 256 steps at
1000 Mb/s, TX works from 0 to about 2.8 ns and RX from 0 to about
1.5 ns; 935 and 550 ps sit inside both windows, and a 2 ns RX delay in
the MAC fails.

The rest of the skew is not programmed anywhere: the switch's PCDU
register for this port reads back 0, and with the MAC's delays at 0 as
well the link still passes traffic. So it comes from the board routing
or the chips themselves, which I can't separate from software.

If you'd rather see this described another way in the DT, I'm happy to
change it for v2.

> Does this mean there is a switch on the other end? Maybe look at what
> the switch is doing for RGMII delays.

Yes, a MaxLinear GSW150 on its CPU port, with phy-mode "rgmii-id" and no
*-internal-delay-ps. As above, its delays read back as 0.
