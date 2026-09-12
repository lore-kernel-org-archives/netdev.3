Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278041A508
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245201; cv=pass; b=QLXNiE/xtNcBzyKqNLNHDQRAZHdgc41RuQ07SW6UDMfU7O7MctEjeABEo0YPl7yKVjaEdPrmz4g4WCvlSCn7FbJxhDtSVJ8TwikmJIDxMppC5THzrTudFN6okPhqDm0F1dgQYjPJsFffX/dz3XdzvqTtobCtTaqpXYojfAtmfFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245201; c=relaxed/simple;
	bh=rqyBuqSHWVw61RfLl33rH8YgPC33rT4HhMMfaGZOUmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPRVNC2DLsvn//WSozaTJHdeb2vKweMKfDeV/pSmc2XH3RdoQJv8VQz1h1m8Cavs/mlOJhUFG2vIZkkh7RGSaxKv3tmi2SYT/3y4sElxSZHOL+lC5tblu0NGaqat9K+XjyFO+LEQJufotOQFv3WrlqDL582R7lVUOtYPzAQA2mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbjo574P; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbjo574P"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c294938a983so107226166b.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:33:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789245197; cv=none;
        d=google.com; s=arc-20260327;
        b=WubAzL1rQ2terVtAsHYvSx47Dpb9cujU4HbC9w8kwN3/uzb/pDQA97WJVQQu8yCqd8
         dfOlg6G0iWXC8xixYyffUPvOs0okKIBFuBBt59ductQ+6FVwWyuoTwZEcm0Kjk2nZhhe
         4t/xlskJBerkR7lSitLUj6S8dI1ViWZ3iiQVYMaaZnAMjXGXvH8P04GxHg+eTqjHx3OT
         tEaKkJ5vBAR6Vovg+mqgeS/f/EEgyzyUaIfHXgzCT3VnbRxTfXfIU/5HCh72slbEHcIR
         sgqhefFgZvqiWsF4D3psLpUt0M8xzH0FfC4dJ7etgCkdUsOZSHQm0sgmXRPUMu90w8Q2
         AKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXb2RdQOVdFeimkTuBnAC0nV21XWeOYpcj6vU3s52nc=;
        fh=JfzavG7y8e9FHJTy87C1U7Qi9s3HhP5W/FXq58J+5cc=;
        b=dBTjmOxXSZkxAD+aR8uQ1JbaYrwA8/NyxmC6/0OiRa/bZFfPLaDrFm3sWTTfwuVNMp
         fnICeh3tdbR9KtNO6CFRQOm2qv11b5ENyNL2VfT/q4d33jAgEIxHtFdrl//lRTdK7Pdv
         fpLxTA9AynXGFLFpZgd5gM+qCqdnu/pGb2mAs4mh6ogkSABQcmlNj0YPOySunvZ3JFcC
         UnTFYkEkh+f38yCB7uq1AzCNXEfobjcjMKQVv4zVZDoJzFWQdsueLJl+e0cJ+DMDMB59
         BExHpFCMpAZmT8BfrC/0xr9V9nmbRCZblaDs8vX9N+8o3jnDGPS4TWt1n8KiFjKkwRoJ
         72lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789245197; x=1789849997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fXb2RdQOVdFeimkTuBnAC0nV21XWeOYpcj6vU3s52nc=;
        b=Jbjo574PeTwU3+ByMmD0BDF3eHeS+YkszMRg9Bo7/IIlHtfBp7jgOLCGKQ7+5+1raM
         fUqdKA0UE/3fwUTp4r/6j/yU3C7O24396HMzfdE9XC65WsHanQkgjirPppgsGFkcdgvl
         bhlgEUqawkFA1HR0vwDkl8c8DbnKmwbzmX/U6dh9095SCPvDa+NcGEzbC0cuf/Ah13XL
         AUTfaAd8hqJbArhLA9GWAX7vPXVAPRsC5K4PRaphHqNMD5424cAQlEE889b1JNP8+8r1
         mg1+L92vDMS1CO3hlBJoqQp6rUsEWQ83E0ya+3hFyICO5HQb9w2EK5ey1CSwrfvq9CJm
         U6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789245197; x=1789849997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXb2RdQOVdFeimkTuBnAC0nV21XWeOYpcj6vU3s52nc=;
        b=B4WJgSG2CdBl51WamXdY0+V1AWlnfaaeDiLK4yz7MNL/pOpfGwKAVVsWBN68m2iX2T
         3weS/vTnBtxJyvxokyGJ7sDB/opnLQfhfq6qAaGHmuIMHrS78d79J2xd092msqgk1oGI
         R4PhAE+7NAjS2aIX8+QVoU+E5n2Ux1tSexAHfwIVrGeHbF8X5VEFZLJAjYGZEvBAGiBm
         v1pdQqab9sR8TEzrX0UkPPnmVH6VfDS8RkNpQxeAai2gOj8IVSRwC9lHzcCly2HhlQ31
         8N5Pz9+tHh0ILrUfAGYavhcYAjo15EnCkaifMZXhiCkvSztKoFzlPHuCFJwNoW7dxmHb
         cNpQ==
X-Forwarded-Encrypted: i=1; AKwUvByGaIMB7FryImKXT9Gd7l8PPuJX65ru35oRvuZVD98oD7Lj2xQU2Dba994X3TeiOPVoriFWdyc=@vger.kernel.org
X-Gm-Message-State: AFuF++lef0vOBH1xnFgCXnSjY3rGdNUiJoYp96meSjNyrl9X5E87TFrp
	bVEPzq7rhxYJ0p4TiFzVHR5E3sxEwi+DYBSV9lJIJut9utMgiaInD2DDCsArcJGWjWseeaBc2ib
	dWQEYH7tSFgc2WQOOqNQcVJhPGVueuOY=
X-Gm-Gg: AYBFou2Cp8vVjBK4a8OqPlPoUTgQzfjTr08pigIRq4J99tkPzxmXuEBqaN0pcXBhNzh
	1SYSes0qVbq5kHumxxdwDbUiB3X0sRF7SaVTsbOL0TgOukQUKCtoHwsdI4KfLlvdYL29zvQ48PL
	udfkYt1hFfjdzc6azD/Vq7SG8r+oDmBrjNonBIezB7rPIJXDNK41ecoaN4RA0lc/S2zTD/YHH5V
	8IcW0FD5MAdLZrVxKHU+N1t70OedOUwLcHT6NuzBwj/MJ3J4DeCBEsXjFC2XXpHu2mkFGyj3jea
	iNxuSERXgiD233JRldoxQIdw2zVQCknDjjSlgL+pvj0OQOkrOXSqEoY47A==
X-Received: by 2002:a17:907:d02:b0:c25:2a78:15ed with SMTP id
 a640c23a62f3a-c296659c61fmr976523566b.6.1789245197295; Sat, 12 Sep 2026
 13:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907153713.2572547-2-coiaprant@gmail.com> <20260912131421.2960a12d@kernel.org>
In-Reply-To: <20260912131421.2960a12d@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Sun, 13 Sep 2026 04:33:05 +0800
X-Gm-Features: AcwNN1Wp1szdgOCnvhL-ujyIZJIERlGVxaN0L7OfiFu9TcpEfz4jyCgcrEH55iM
Message-ID: <CALj3r0itTv0+8R+mTg3wtMD95=4V3Znwsk48oxaSjrVMLoJfJA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/10] net: pcs: add basic support for RK3568 XPCS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8813=E6=97=
=A5=E5=91=A8=E6=97=A5 04:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon,  7 Sep 2026 23:37:03 +0800 Coia Prant wrote:
> > This series adds proper SGMII support for the Rockchip RK3568 SoC
> > using the integrated Synopsys DesignWare XPCS, along with necessary
> > fixes and refactoring in the stmmac core and XPCS driver.
>
> Sending the AI review FYI, please look thru it and judge if any of the
> comments are worth respinning for. We're waiting for a review on the
> device tree bindings, anyway.

I apologize; I have been so busy this week that I=E2=80=99ve repeatedly
overlooked my plan to reply to sashiko-bot's comment. I will get back
to you as soon as possible.

Best,
Coia
