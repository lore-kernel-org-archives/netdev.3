Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFD4EA394
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795042; cv=pass; b=FzvYS6aajWQlL3xW9wQPex86/gevU3dlX8OJ1M5WkYLCJKcWLximP0g8CkGNWTiIJXO/45qVFIU7KUpDg6T3ObHUkw9kB0gM9yDm7cvZ5PExuPIGctLXlvAWbxkfhZ3ss+WvmWMhLnq8LfdME3+afDRKhHeFVkdB48x+kN7qnG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795042; c=relaxed/simple;
	bh=lGFXfZ5XuVaxMLWoh6ArrdyCudpeux6klfmVJa5bp1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RT8sM0SgFmUZ10DCGAMWy4/RRXNg/m9mKr8WsBFFufGj8UuHoQjYzKMUYEj1WExydDAsFiSTcBl4YDYEHoKMnrwNOfKjPQgdq7VwerH5cqY12E0yEZpLXbXP9Z85ojE7jWYWSfAiGHuyKmZATlzPKZ4o21zeCX+Ipb8ZATweQsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LITXYh8/; arc=pass smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LITXYh8/"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6a7e0ff423dso7678423a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788795038; cv=none;
        d=google.com; s=arc-20260327;
        b=ea+QRNQSMYKDPRhXSnFHaF/Y0D7cPoLRvzdmnLOfnHpn+Ht9cFeQ0A9+UyhZ09w9//
         8Nl9AMZQ3rRkDy5N3nwoePGKokb0ueCC2VXD9wQVNHcHFLb48rxOZ/KBC9UL9cFZpkhM
         1VFtsQjuOAY0Klq1Mp0NNamAyYNy7+vwONErutia+YQPiHh0OYf2J1IMQkhpU0iRp1uY
         8/JOeldlltP08LC7+Ue7Qc942sOO9o+hQ2ASlZPjv9iOiXOQM8a3PiwdW4TmiPWcin9E
         xgmjlJnFeeLDSaMMcivTzozAxEv9YwUxzATt1hxfz5Hn5sgCFguOiX0RHtZwm0V/Uu7g
         DLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lkzdnHLNDNYqM7UpPRV6i14OmTu1unpa7gOTpfiF2qg=;
        fh=hXN9O1Jp2w5VIt9mi8FnYIzjXCU8WmDpHtYCdf8kkNk=;
        b=Erucsu1hzVqphtKyeo25WPMLp8DZPzN72lcmOCQ0KVQcxoq1P26DX9dqxquTdlpqxT
         +OfF7fTAHEENc+LifntAtIzsdfmduewHNOuS/1Hsli129xZmgiLdB0a9Zp7wzxrZH1mK
         CibMmuYXS0oUrReGkrx/UV0EOKT5NGnu+wyqXigs3etH00w0V5bT6huWnGJPgXkgyQlp
         gOuL7anpX3hAKglCulW/i5Oizo/PTuSQRtuafRPODYlJ89taYIw59fTVpb+aIzrko14z
         Nb0l/dMfaoAm6JBiztr59EF9t9Vetv4BRkVP3NraWQnoCTf3vBf0lK5cFsvZv0n4TOF8
         cDOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795038; x=1789399838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lkzdnHLNDNYqM7UpPRV6i14OmTu1unpa7gOTpfiF2qg=;
        b=LITXYh8/g5jBcACk8ww7y7kP8DUvXMLpAXWQoH+pL7Z9JsrTxmZFKSH5qXMLtfVQAS
         xdvBiptnO/LVjT8ugblS40pN5QMnkqGbixzUP03hWZ7fJTJNYuHpyNBrcBegG207Mc1w
         y4kT5xuusKl/KWJdXuL3FVSshc+iJiXpL/evtAVxtdIqRwRLfWBd54MP0tYr51b0GTdw
         Cb3PSKavDX5ylT4SEeB+lGjdkEqBrSIsSQUWttcGvxbIUlR0hUB8LQ7lY0dTKrqTtXcB
         BVfCNesZgJWGrWrNLE1uZCD6nvS6Ir3oqwMr0VmEBs86Y7yvRBh9V3ejAY0VnmKt8mkZ
         oJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795038; x=1789399838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkzdnHLNDNYqM7UpPRV6i14OmTu1unpa7gOTpfiF2qg=;
        b=EPxSkGt1DgIlZPB4qmgjs72RR8bomGMlxqGE/E+1KiNRmWxTO0+lWciLKDqlM+12RN
         M9bv8y3Z6juB+GOKMg6Yvwb0n2GqNbu7+aol/0M6Pi75NhigQxmsyeFU1fahKBbpnlxq
         Fl5mS5mq3WnwB4DQt3lXWSLG2twKvy6u7D9ydgK5xJdiUSGD1wYLvJzTGIBO1jU56HYN
         ho0debbF+swt8MGpq6qmA1GLlGCJsbV/O9WRQgFiMY2n8OFVxlsrNR+MMlL8WE23gGLO
         4t535kMKJbaZ8YTogVnLYaRLZFi2irypBIc0xb91E5j8pbI53KOk4CcNL3Frhwbbgfhc
         awgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxG73hNb0b/zFzrN74LQfjFxUqUazcDdY3w1HybSZfSvAGQSyYOTtYa0q2w3DP8Au7c30teeVM=@vger.kernel.org
X-Gm-Message-State: AFuF++mF9FVoAovakLfIP15ts/VcfWciSnURjby3X7Iwn6YgqUxbX41v
	bZII3sBjznJcAg2d21lM3BTjqgFnSpvCm9QuD0L479PTYzL9oLmr1V9++yooNFyWZssp/odp1p9
	nP7OBhFBO4eYYS6iNd8N12ryyjHLvYbo=
X-Gm-Gg: AYBFou0d6E5Ai0xGDeno8EExDFHH3nvtVa7VYa9ZRFQDYDtFVsCHdpABONqvLxkC+3v
	XjNO1haWr8dOyVy5UDrwUW1Pdsg+76PMXlPblN3+IzdHAguEdATPJDsUZGIgg30LxtN9/mIZput
	RnWz3ODDjR9m9nDdWGMO3HlabiUOyaI6D1+UJvN0anbwzQvV755RxA73ShZ8uE4kxmNys+DHfJN
	NyjX3KIX8pJ4pQWJI6UmT5gmZZrY/5zmZ52v6NssKS0te8QsXG4sA8RsNWK/BB7HAo4f+eygxfS
	3WGB0zR71AGxMVkzGLdm4tg8z/i9Fu34fDk8cwDpBFb9ivq+ilQGmcoouA==
X-Received: by 2002:a17:907:ea8c:b0:c25:4d9e:bb28 with SMTP id
 a640c23a62f3a-c25efb68285mr1154227766b.3.1788795038010; Mon, 07 Sep 2026
 08:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901150111.141037-1-coiaprant@gmail.com> <20260905130002.554a167a@kernel.org>
In-Reply-To: <20260905130002.554a167a@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Mon, 7 Sep 2026 23:30:26 +0800
X-Gm-Features: AcwNN1Vvl2lnQu7OUmDQrL2TMEu35axYNEauRYInB38b5Eog8jJzDQ2t3ClFiz0
Message-ID: <CALj3r0grty9-s5FoXN-SHOrLkVoWgW+Ot5nHs=1wYzxV3hbC-g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/10] net: pcs: add basic support for RK3568 XPCS
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

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=886=E6=97=A5=
=E5=91=A8=E6=97=A5 04:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue,  1 Sep 2026 23:01:00 +0800 Coia Prant wrote:
> > This series adds proper SGMII support for the Rockchip RK3568 SoC
> > using the integrated Synopsys DesignWare XPCS, along with necessary
> > fixes and refactoring in the stmmac core and XPCS driver.
>
> Not sure if this was already reported but FTR this series
> breaks allmodconfig build
> --
> pw-bot: cr

Yes, it will be resolved in today v4
