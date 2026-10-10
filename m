Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF620A5C4
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791595520; cv=pass; b=etS1L485WHCfwG9U+78q1B5pSFWg6qjqKDo1JahxEBqTWaTSVf4y7AlQgc22+HYnm7ClcEHt6yU6l56hsWG4Q7OIf8zbj/2BmZ19INUgZaCIzeJ+ke9l6VSqOgsNub1h7MBCKEnZzZHuNKUt08vSESU4y6ZVYEvZo80pzAlZ8RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791595520; c=relaxed/simple;
	bh=b3M1oyexbWWFMbupHT39KBYQPo8xp7QTlcXumCXHqA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfggADESG9U5qohSStEdw8lHeiD4KZiJ15ieMXEgX/wGllH2eT7mDofnAIaZ0V3o+lCOt9vY5iFpVx9XdlO5vtROf8D0q38S8Oqk7fUdq+AnZYwOJbjQbouh6Hz+creqE5bdo4trcqFodah+2dI0Nikr+5Jb2bSgrLB3mFzvFw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=j7mjvA9p; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="j7mjvA9p"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5339199d8c3so2751771cf.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 18:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791595517; cv=none;
        d=google.com; s=arc-20260327;
        b=Li5DwfnxiddwOukuntkUbvuHjGx0TBcfrpYlUa4E5YHDctrXs3dh4sPaDTM82lKJta
         NOHj7IIYWF4R0jgQb3tFSRoanZ9PHQKBdm2SAAIZRTgX7X5m7vhYhMLOa6unavGIGnbO
         cnVyoe/iU3dEqgd5Zt7I4v5OKfAA0flK7o2Ck5KzMk2D70yueLZAZHX1dQ61mE0vMqmX
         Jr4XTer5r288AVhqJtd+KP34wIJ1uijFvlAk6+kc43AcVbzUawKwG2yy7mYfx6nyvUky
         3rsrr8BshObAYcqHYbU5DoRhcg0v6EZPsCxH/AandT/Ux52evgz8I9pI4t5v3jLT4Dxi
         zGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b3M1oyexbWWFMbupHT39KBYQPo8xp7QTlcXumCXHqA4=;
        fh=zQkyzNdi34PPMMTWwUVBZHCio3Ig51LB7EwG7zBuTwo=;
        b=cSJZYx0gt5lVYmpD9vXWxemH9aUITV6SWvx/C6IiX1GzQKozvXhvkegeRCWa2BG5XI
         oEuDlX29hEHyZSWiVX7aM73kvFvA/7V41MWJQtFPLh9IQByt4Ov2uG3Io9hMiwsCMo2B
         K86yZPv6hiOgBA7NRpjDxdZWAKXkxxZwW+VtADAEoW9bo6kx3dFe4yJ+K65PbrDU/ALR
         bK3szwVhjm62w+Ly6J40dwfou9sI0X1QtEGvWlQW357bsjslsUMVVkC9FIp5Y1Y6MNIW
         wXGHaN4CyzicnuYckGaWf392eCUq+O+QVohuuJ9L5sPl1AzB36KkA5Dsy5YA1pSjzKxx
         dPxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791595517; x=1792200317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b3M1oyexbWWFMbupHT39KBYQPo8xp7QTlcXumCXHqA4=;
        b=j7mjvA9pwrnFTRMmfe5JuDifZfsaddbM5GemNsZvh2V3h0UkAiAaewnquAlCYreN71
         WDbDitT6NAC6LL+hTH/zcvqEv+vvvjOf/pxf1eE+C92K0WbBf4d2M9OVz8lw175q5gON
         51iATnGCHZT8yD44fxufWAxsKLl2Vwo7XHUTGDxL6FVK/fFLg9I2HsLct9ksnHIrLfJp
         AbZDnHHfmGkq191LDQnR5noevxOahXvZXiBjEaJdSvrg8ePpIg/OuT0/uaOqwkAg3pAI
         R7sLkfGv9mjwKGyYtlYfDGgsaZcUV+zc6OnuDuisOZJGyXgiS/hLxKuyNNKz08vp4lE9
         8Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791595517; x=1792200317;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3M1oyexbWWFMbupHT39KBYQPo8xp7QTlcXumCXHqA4=;
        b=B0U8d7Sngz/5x+QLgKoj3Dl0wPSeGBctA973048ljXIOyD64NhpZW66vGSk2TmzZHn
         o2zQfJvKywCaBlbcq2tWP6sBt538SCWGre2IIiI3dvHpfJcrq4YH4SZyaBYDnxdLlOo8
         Bq098P2BNhvLeCFfclN+YG265mZvaWtnYWmDgM4Qac7BYid3nb6e5zSB+wg0YANLDYzp
         2lT6WE3iwnDb035b3q88NDHw9xb2tuzULXYQyxkC0mjLSDgZbwKTcDGYUZv9aVFgpMEU
         Hx+YT3A7jrrIIvDYMfrZL68c/JcHF1i50RPRUFCPykcIkTFsFpsJSqCXMghJEm1Coj7i
         z6Sw==
X-Forwarded-Encrypted: i=1; AKwUvBzi+upT8tbV4wQ1n/anh4jrXPBj4MinTRQhh4wYTAl0P9JKNJQw8DsbNNyOB3lhORchHFlz4RE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbP83n04HKPe+bYpGdKEXgo5lt7Qdv/TyQZitjXT9vfzIR3ODE
	XQugxlpeYP/oQOFCCne14p9RgwaZmjvSu47Wd62t5pjkZ+H/iS/2Q/dA3v5eQRy5O0RdN+zHWXq
	UlwTStyu0FjJr4K02uFaUi7QS0UbkODqZpraiFdWj
X-Gm-Gg: AYBFou3ZoDd8a3+d2IraMcF0yBByB3SbECZyUOOqb0gbII1qkO/80ihxvbvw3ervn2v
	5IwsmuXI2o2j4z5noqpSIGg9+5XxNlm6ehloNuEltfeQq1EHo/rBE7QvhuXbWTCHdtcamigm0ms
	U3eTSwWFBlg/p4SXU+qmpRP7VBOISodt3hmIeAohHJx/FCC6D54pOREAypofz/OBdGt0DdIg61H
	mKNnAAxTA3tq+w2AsfoCF+LSsArRJGyMcPKWf3/DfCo4qP1l21tKgYYm0t+E8LuIx0rmhy1oHl8
	FmhFHCjbc/Rtm6OcaagyllQtgKe8rDc7RSRb3Lr7yoRnR1ZjF1eSoDuUbboG7TkKBA==
X-Received: by 2002:a05:622a:4d07:b0:531:11ac:23d8 with SMTP id
 d75a77b69052e-5359fba60edmr54510921cf.49.1791595517306; Fri, 09 Oct 2026
 18:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009143506.2507607-1-jjc@jclark.com> <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
In-Reply-To: <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
From: James Clark <jjc@jclark.com>
Date: Sat, 10 Oct 2026 08:25:05 +0700
X-Gm-Features: AclHuK9fnyUSFTBRatk4Hx1M48w-fuilgNmbIw2Nk6Pos_snbg5ersatAiB3CQQ
Message-ID: <CANz3_EZMG5SMYL+_sxgVD80ZG55VsWNtO-POd1L=6DowVcuCiw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Russell King <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 11:04=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> The clock frequency is fixed, so you could also provide a fixed clock to
> ensure that the clock frequency is derived correctly. I will check the
> actual clocking because 200MHz sounds odd to me, since the RGMII
> interface does require 125MHz and therefore a 250MHz source makes that ea=
sy.

Thanks very much for looking at this.

Here is how I arrived at 200MHz. On BCM2711 (CM4) I polled START_BUSY
in MDIO_CMD with the MDC divider in MDIO_CFG set to 9, 14, 19, 29 and
39. The mean busy time of a write was 6.42, 9.66, 12.89, 19.30 and
25.63us. A clause 22 write clocks out 64 bits, so assuming it takes 64
MDC periods, the MDC period is 100, 151, 201, 302 and 400ns. The
comment in unimac_mdio_clk_set() gives the divider formula as MDC =3D
ref / (2 * (div + 1)), which implies in each case a reference rate of
about 200MHz.

Could it be that there is a separate 200MHz clock driving the MDIO?

James
