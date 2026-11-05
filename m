Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838899;
	b=TaoMyw/dul5tWYC/AZdxL3NkEu28lS1B1CN/duI+Po842r2aRM/1NyzzAF1+eMwQFxRM
	 t6OBrSvuUBPQsR5mHArHyZi9D92xgWQgsQuYn4PRQOtYLy1XVEze8NgZL0fiJVBvHaeJw
	 3jEFLDYQ4rvgWZsRP7/+FNKbi1HlEpKaK9cusZ2VgTn08rgRCBa1eCr2T/zyGH0dhS/ZP
	 bPye3hisE1M40MviROOGube9qL0sX8SjdA7msvIU3h8dFtrljqycvbltIE9CaN1ekLQt9
	 +Qvu8GEo6OXiBvXElbzGSdGXhyGA17AeSGGQsf9jiUd07edpkGu00pEd7j3KUdW9RFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838899;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=B55JhhT59YGsjYWJgV+XXad7EG0ayDNShVoZf8DxBWQ=;
	b=2Ne8/hINTJ+ceQgROYr7OxNBGFrsY6GQY9fV8XxbWgo/FQrgs/6E6eNMmFuQscK6Tyr/
	 VmX1PBdRCh0pNGE0vwTscUOUShPWLi3uVIuwJXwDY5ObKzPkcVKtuMEx9yjUUwaqzE62S
	 ENy2dM2oSYbJZk8USAq1dbSO51qgwe1Z1ihD0wYYrGLB7yBKoMxUjIJcQfrGT2AK4Y+Ri
	 QOFiDvNhrZDv9YKKy2pLnJp1Ldt74qscCG/FY0u4zi3wJa9bWfj288FdfST+ijoZyQGeG
	 qfVfMoNI2vu9n58yAhs+k1Z/CJeC3A7pe6H874u+hKBiVmshyVwRJgvZIsMkQ75gWow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B76606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 00:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B76606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e987a2ba0cso7405015ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 16:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793838898; x=1794443698;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B55JhhT59YGsjYWJgV+XXad7EG0ayDNShVoZf8DxBWQ=;
        b=bwDNWAMSwHNXtSZcoyzSVXaq6FV2qRh0D2T8aDeaPZNjzLJmDOI3w05ND7pdmpq3vZ
         ZLSqSLPn+uJeUD2nMhkCowJ6q1nC3DNp8tIf0LHenZVb/bAQA4nTpCwngbIcRvaEzylE
         KGemmyHzRED1xkjlqVs9aMV3DykVOYlH0Qeth3am2tYuLRGyFymDIode/0aVkA8FnXwa
         YPzLOjSn/W2HIDGEoWPsiMFYpA9NZv4qyNmKS6/FB4wF4HWAV8XEdaFzf7OpH2SXtJoR
         JL9dQEp19dGNaVfj1NXAX9Sqv3cEHMDXbiXP1oHhkkK8o9ht+NGcAvFO8DFXWSHDiXBP
         glAw==
X-Forwarded-Encrypted: i=1; AKwUvBzqvGLyGr2+Aev2Z815mJco8Y6oRtktNYwkwKzLBKaC6DkD9ma+ktRqtExypTaoOlhAaxfO4X0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SL4zfxGGamJXYCntfTaQ/OsayNTl7eZwhvffixpKXYJ4D1Cs6
	/CwDDzj8PH7B6BE2UpQERyMop5N6q0rRdndbFN327pikl662rHwyuHtL/+PuK18k
X-Gm-Gg: AYBFou0KVqNPWvLrvcVOwYXh6ZbfiTVbxLqOEjUf45C1pWZ65cs2YJi4qMcj+PbyUGf
	OjzzsfNI9ZzNLKUwgcgCf61ROiZ2AeR6QtAxcsd6ycA4HJngSqpnRNDIEs4CIrOfPX23jdYfL7T
	G6SF/4JQT7mO8Bpfc/O+ZRlpeh6mkkKPTv7Dc5281d4RDyjdTiD7AmVUSXJ4GZuzUEtR8U+ti+Q
	lRUS6oViEGQtgl79kl6Tpi+z2p5+zcd9ew4rfozZ/2TCEXoeSaWzr6/XsKjKp2tRv90su1tKYJo
	CmFgVXYnm1yAAUAl3xkxlTt9kdrsl0p2X+OSAO8DTOGsKvwJR8SFDVDkubNeIx5XUjBGjJMs+xs
	upDEbqI7S8mDXabrtLT+qdh7u/dX//Nfh8enSaojxgYN6K148DUBXo9yH2nwqEEBHg4hO0ui+qk
	hQTN93/zfFlzATIlNeiCXa2zJ/xTK9ygee4Y0jDwcXnSyc1pgUM5DJD8mvr+D2aVzeCdwnu3H6R
	ha7NN4IC6/P+3ZM0b3HQBG4+5DHOwfurj2DTCi++jCFNbLJI7dRPEbtK9fYXf25a/ZtKPJDNtuP
	li41PruG0KZRmp5XWGbxzeja64FKO3ZxASeHXFie2mOr5t8dKbEjD1q2jyK3MehgdhBWQEYxJVv
	9dv0Jl6pmstuK6zaogQHj6j8G1RHjyKutXAJ07qczpw0=
X-Received: by 2002:a17:903:1ac7:b0:2e9:5714:608e with SMTP id d9443c01a7336-2eb364e54e5mr172453605ad.49.1793838898236;
        Wed, 04 Nov 2026 16:34:58 -0800 (PST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com. [74.125.82.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0906c514sm12042535ad.29.2026.11.04.16.34.56
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 16:34:57 -0800 (PST)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535a54bed9so1741828eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 16:34:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzhIwXDOdHLQ3WzGbgd+COsp7SX6Q+gap/5pyJyqIai5fMoeLsdAh+KHgd9ROeUDo2lPVLP0Io=@vger.kernel.org
X-Received: by 2002:a05:693c:42d3:b0:36a:1452:8dad with SMTP id
 5a478bee46e88-36a4244dbfcmr25290212eec.20.1793838896251; Wed, 04 Nov 2026
 16:34:56 -0800 (PST)
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
 <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com>
In-Reply-To: <CAPY4CJ74O1tFVCpcN9seoeWDF0VR9GNfKuE+rWODQamN2sjL3g@mail.gmail.com>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 19:34:44 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ4RRuZcsObkF5r_bDacR3d0yjP4e6GWESksDPKHxK2u2g@mail.gmail.com>
X-Gm-Features: AclHuK-1vO168WRWmJd07mz7tA0jKpT7PGyfi_yQuj1AayEjOBkR4gYRSMoaS_A
Message-ID: <CAPY4CJ4RRuZcsObkF5r_bDacR3d0yjP4e6GWESksDPKHxK2u2g@mail.gmail.com>
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

> They are the values the vendor bootloader programs, and I checked them
> against the hardware.

Correction: they are the board's factory calibration, stored in its
factory partition as 17 and 10 steps; the vendor bootloader leaves 23
steps in both, also inside the measured windows. The rest stands.
