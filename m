Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923972;
	b=ectRvswyf25eVt2Z2FYJHtmPtuppnhfwYIYm0Vj4rResCiAC6FZfI5d1jTU53h2YmhuM
	 mx+o4w8136VPRdpwR0ZCGIn6InKLi0DHi1dGQ8vc+pe3Rk887SlPbIJqzN1hSU7Phk3hl
	 t8hEi19bYxFdap+rbujxqdTGUcG653zl4wBOjV3JVstH8++mMq5E0bkZZGeYFJFaVEB5/
	 zFod0dNorf8/VCEH8kzCfobpwcrgXryxRRtVPcVVWdw6FuxBbnYWKg5X4g5HnPNaXBefO
	 ISBaWWgmm0WEKxgBeubj+DIHFJbX5W+eIXlh5COyYZatSA7xacQLcwv6+b0MSdA47wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923972;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SGxBcvwVnn68G0KUIWhXj4n7e3+LPqUj3vgSEpFFHd4=;
	b=hbKDTswjFTF4m4/j3/B24yXttElOTL+04+xyKJFzpHTwWHb0OW4q1qdE2kKpF4ceatfn
	 YUG85A4xZPEWNHdWyaxH0aQw8q66BFV/cKviglJ2DzML5bGX2+n7JX9bf41ig5tz6TsdJ
	 B1eQyBZiu+Me075oI3BFq1q3sn7mulIbWBL8V1h37TxMCvknrk+KBXsbpvwNBPsoZuuCV
	 yvswTqDII1Ogg0inulingz+aTD3mXf8R94ujoBHfVqkw44ls5ZBEI0IFswJovvZBYt9Y6
	 C8XRZjJgwkM34p3NlXCmZUgC9JVXJl8UtpR0Abw8xz5pMox/csSYfWPOWgM/zXf2wkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67C606A332
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 00:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D67C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd3310348d2so554468a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923972; x=1794528772;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SGxBcvwVnn68G0KUIWhXj4n7e3+LPqUj3vgSEpFFHd4=;
        b=vVKU9Bt4Ibxubub0S/LVkAaUQqKxpNR2CEaJbSqK45Yp2EnIs/HJn5VzOF6eCu0v9f
         ZaQ6z8o9fBHuj26FhhljMVNJ2j1CauaeZ1/kKUqvoJ6GzhO8ll9lXBMJ8bJfIovAeFAR
         fJ3R7vt8K+e3VZxP7eWCNTt/B+Q6koEvvitDXEqYgpYKzy02Okf466Tch0663MQR7BCZ
         YyT3yeMul1a2W+VBGH0xtq8FY5LO3rmTkGUgw9G0kpVNFTEkMtpmfu94wgCDkNP6O8E/
         LTDEU3DAbiGuIWbTiXth1bQgEVyuD3WD4uJoGJDqZCP2KkHwRJisex4uoGSkQv5AJsBD
         tIJQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5MLkTa6cAkqH2FCtp99mDrjD2daP6XAeiA3IH8sIUTyBzueL0zymcTrfA8VPMi8Hj+9BVtnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KuCfn+JPpMjePuO2JnHZI4SWyBe0rNB19UTgPYZ3cnoiiFlB+
	v0enVv+a6VGXSo3YG8+e2rHpNRru/cXJLCVOowIMmUkYm6uPRjIORgIhYn1cUmrh
X-Gm-Gg: AYBFou1Dp7aqsQjW0+xL846RoP0i1arA2liUR+j38FueZRUxmP27Y3BBGZxm/YeYpVJ
	5TvEWl/KUQAZV/z8ScuzXVeWMvlcnaFeFpDDeAuipLgQGiIh3VHl2ocH3DnzM1NUcZZOPaZE85G
	hDJKmzJVMBGgWMn9jIwEDBbaN4jdvPdFxm9e5AxlYMuJOJUVM07APGOGDDj1ZZ0vftbU7qnthPc
	tpiMY6fTZgcvS3pcHJS9D+UUAuJcdWnMwDchGCUzJT42FuJUujklYWQiWnHXxB+oLVBVDMcGxhQ
	dHQDabXC19rc4eJPKGxoj8FELTWtnxUe8DGm14RfGC9VaICfWIDZGORYHVTOlRwn4DzexSPZazh
	4IPCtlqL9WOHhUSXsCTk0FjbA/MXGUOXOKwzxov539WC3m/CGmYlq25ygRZ5vTxjLRknH0Tunsw
	lC0Cwmsr3u2Z36s+04MJadB/pmtPqJOlCps6ARlhTzi7bloloKNQ9V4lzSyJ88uOUZb+fppdsah
	RdMvgeqOvkveCqkcHZRwTcP1U5M/sC09RmCejJMVH9DM5Jw/SZMdnCawD1FxOvHEeidOnmcq5EO
	9KiIrZPOS/LmzrUBEUr8KpwontAovldRgrb4bCt0+DgM6gwXwXVNLYjOFYr6S1L8k/9YcMHotun
	+FbbQdMz8kxsC1WtitI/IalDLBm9ojX0nDUcI/ZK/v+eIYQCMFSnnhxbmx+Ez67++5Pg=
X-Received: by 2002:a17:90b:164e:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3b0db6b6e58mr421580a91.8.1793923971830;
        Thu, 05 Nov 2026 16:12:51 -0800 (PST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com. [74.125.82.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3287a60sm6057837a91.13.2026.11.05.16.12.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 16:12:51 -0800 (PST)
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e795af1d4so95660eec.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:12:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByboNfTgyna2YT013R1mLhTuZAFJngLwjAR6IIoQDH/qKCVZWT1cx1knmTHj72kRVRWlKBy1Wk=@vger.kernel.org
X-Received: by 2002:a05:7301:90d:b0:36d:6a77:960a with SMTP id
 5a478bee46e88-36f73893ca9mr1104956eec.1.1793923970093; Thu, 05 Nov 2026
 16:12:50 -0800 (PST)
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
 <ba32cd69-23a3-464f-a74b-68a29e7b8202@lunn.ch> <CAPY4CJ6mCc5HgQUZd2Mq3C=Tsmwp=-acAV8dsWcpO_J87Pr6rg@mail.gmail.com>
 <7b4ab738-85c9-4747-bf89-1a5532af6901@lunn.ch>
In-Reply-To: <7b4ab738-85c9-4747-bf89-1a5532af6901@lunn.ch>
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 5 Nov 2026 19:12:37 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ6Pa1T4v6=3K+qN-sJeRivJqGbUeR2svJNcrLHtA=Th+g@mail.gmail.com>
X-Gm-Features: AclHuK9z-s31k9cdXUmtbrS436ZgZs9Mvql6VWlVAJgIq_YcqPSSmicfRgm0TQE
Message-ID: <CAPY4CJ6Pa1T4v6=3K+qN-sJeRivJqGbUeR2svJNcrLHtA=Th+g@mail.gmail.com>
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

> So i think we need a get out from backwards compatibility. We need to
> be able to break running boards with old DT blobs, in the future when
> we fix whatever is broken. Maybe the best way to do that it make the
> MAC glue driver and the DSA driver depend on BROKEN.

Before that, I measured from the switch's side. The switch driver sets
its RGMII delays on the CPU port in nominal 500 ps steps, so with the
MAC's delays at 0:

- Switch to MAC, with the MAC's RX delay line bypassed: the link works
  with the switch adding 0 to 1.5 ns, and fails from 2 ns.
- The same with the RX delay line on at step 0: at 1.5 ns from the
  switch, 4 more steps of the line still work, so step 0 adds at most
  about 0.25 ns over the bypass.
- MAC to switch, with the MAC's TX delay at 0: the link works with the
  switch adding 0 to 2 ns, and fails from 2.5 ns. The TX delay line has
  no bypass, so I can't check its step 0 the same way.

Measured against the MAC's delay lines, the switch's nominal 2 ns comes
out at about 2.4 ns in one direction and its 1.5 ns at about 1.3 ns in
the other, so its steps are only roughly 500 ps.

So on RX, 0 does mean about 0, and the receive direction still fails at
the standard 2 ns. That extra skew is outside the MAC's delay line: in
the switch's output, the board, or the MAC's input, which I can't tell
apart.

The DSA driver, mxl-gsw1xx, is already in mainline for the whole GSW1xx
family, so BROKEN there would also cover boards with other MACs. Would
BROKEN on the new glue alone do?
