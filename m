Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F434CFAB
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685905; cv=pass; b=lks5gqC0biWAbSsLElLP3WgIXm4jtnDIPZ0OxinjUaugR9VOImyRakCznmHBM/l6WMJOqgg7pSHkW1n3Kygl6WinOrtm+mDm5io2dfy8B62wllApW3OqEFrak7Wt9nRRj7+kPB4An4vHvDB2djRdynNf2TJQVcLcqpC98NCBQ10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685905; c=relaxed/simple;
	bh=bFXrIBCwNXQf5uSzSbdWq2pW0DAs87dD/iRxpbolg+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElJODHqdNdWF/2R77jjblCFYrbTZigANqjDrIgBAMb8A+Czfhc84MeahJs9FWGQ0Tw41Y2qTOFdh/E8e1QUBKEv3X/CC0DZfcm6XGaNhrkTMr7ziVbGDhRcvrlrT0+xvjSjTU1roE8R/uHTiUIp8lZyuOVi+TVCWfd2fogdF7Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbDX5+Ww; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbDX5+Ww"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf452def93so14754905ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 22:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786685903; cv=none;
        d=google.com; s=arc-20260327;
        b=rOAWylUYpk7jCsNzO2io4yb8tRs2T3vMScKo3gBr/e0IF3JE1+kwpMn0m8jX8PsHFC
         Q67GX8HrqoeBi8lG8pi1U1VqqfJ6l75lWVZ8CC1MTcF0oHjJZDEI+CIjW7yQa0WlMlUq
         Bfm3VjDuAQxF+yR5tQPD1XLJVrKQUfPSBBY1o3Wd9KohY4cHXdw7XHr6KdiiqQPHiG5O
         2eWyJqZsa15VeVYgKPLLWFhG+9MZc52asv73AGhOALLRPWjvpc6mDens0q3JSGOa+p/D
         ky+eGpFcmkk0j+Pl7BD8hSIJDrR2SHLXLcD9msM4wASqlJvdSsS5m++Khq/Eh+4lKcfI
         246Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bFXrIBCwNXQf5uSzSbdWq2pW0DAs87dD/iRxpbolg+8=;
        fh=m31cBVcYxJ/ldz8M/enUQcy1lIMhpfrvj27T1f+2qw8=;
        b=UiFwgKizFDXUKiJxvzhvoaoYqSoAe3CT6xdb3ujKFPqe3m3Ql5I9+11QhAv5vd6Lu+
         SCsLzl5KQOHj4zSG5czjpeudGuvFU4w0SPpWxra23xp0Ioma+X+nzoSIyT5U+9HqR9XE
         faawHLg4wKsjqfI8J2eTinwrZF2JTatS7E9UK/DVyjhDjg1xXxmdeI7hb0OcQ6E0QbXQ
         m8HxZW1k95pswwEwPox5/+UJgvlWH8aVluYw+ZDh+kZYlUwdRXebq3pjGYYLZnCFwz4P
         iqpb/kU/lVEM7igIJf00pH1MUc3lJr9nXww1nFNL/kfIYYwdXxlJuYYe89mlcjHek3Ki
         6Mng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786685903; x=1787290703; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFXrIBCwNXQf5uSzSbdWq2pW0DAs87dD/iRxpbolg+8=;
        b=DbDX5+Ww7/0OEmHX51B2obaIdohdCQoNNo5DblpToErzGv7uj+376CFFno5PbLzT7T
         1ecBq7eXDfU+Qiz0DUVritW/wCHdQ0FllospIygIeQ8dsC5qFVSCcvyEJO2HmKRTUsc3
         wy5YCUY0Fo96Y+Ve2GR+8L7ytmssp4WkoOJSQK8q93xr5I5pa44e+rQePrbxiL2cZQ8H
         vuywSolv/xkTUBG0F5P5Vuay18L0AZeI+o6gcMifvfHDAt2YNUeFp3IUf4nhA9c6IqbY
         ZnnOFtjiLWW5w9mCu35tL0DEuq0eEUWmoZ3oPu9CawEISH0PDjHJykz1KTGIOmDq2xWC
         kvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786685903; x=1787290703;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bFXrIBCwNXQf5uSzSbdWq2pW0DAs87dD/iRxpbolg+8=;
        b=cWjEKOe9xv/LMCqvNNlv7Wds9I7wISfi7UiKQMJGLGu643Rre07umeLmnOEATqdviL
         ylKgmy19iHQB74KhAg53mKdj/jImlN6wDnuzvb4BAoABb8OuhbL14QSzbYPpwUtBd1Vp
         sIag6WvZQHxeHx1+LYJg60EKnZPn9sS+e46rApdnmnPdBR+5Nh7BXFIBNeES1a5oZEi4
         1xFxwIdoYt1w2QeJmqDIXyC+wWmUfmSFubKqtKjyWiYrbvxL05P3Ft7hKonuh6VlAG0J
         qLJcHAGRSZQd9UWTiBo/PAFXtetEyHFIbzBEfQo7LxxtECL63wcMtnNyMC3B5YGoa9gg
         YXgA==
X-Forwarded-Encrypted: i=1; AHgh+RpvqsOZBB03RVeaJb78u9GCco4xTy9NH+1BRSgxilggE/mc5ELBHS6Z/vJv5RlinmonbhJDVY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZ3OXAl8IDgy0GLSFuWQvfxXtDx1eKcLnjm5S+2eWUc5ZQ55y
	93DTI6D24/lnQXK+gOENrRloGlFha7gFlHJGleZjxzz2xb2KvgVYObEQPj7HyHfRk4ePFlIDHiI
	Rztq+y+a7w8YY4b9NJC+P13ebiVka5mE=
X-Gm-Gg: AR+sD12rpBKJcn4t4Wxm4bzPmmwiMu73DL2hxHqHzr+sxwr9Mz6K/JN0Rl4rycLI/6t
	nombPb2ssYj5ER0WuySy7kqTy8POgXVk+HRAP+hZVPra1TSsre/I9D9bqHgAnAyWeh+EZn9OQzx
	18oNJyUOsEfnvOV8yhQg/cc+O3YJXq8Zj7rZH7eklrNWoT1xxrYo/2TKB9y8xrQyU9g+LM5wGk0
	wrC5nzI+KvLl+btKtxowUoO0JXhnEEiN7pFtyM+gTs/C8Z+APD2bdWYyBL+uxNBzQ12NGYKutHd
	RNm+cVdkg2fHSH32eB6gP4A6VBkTnQANdN3TQimJMyjnfg==
X-Received: by 2002:a17:903:15c3:b0:2cf:b9f9:18bb with SMTP id
 d9443c01a7336-2d3afdacabfmr29441175ad.4.1786685902925; Thu, 13 Aug 2026
 22:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812132755.32585-1-zajec5@gmail.com> <CAAsRjRn4Pfv3LzQtVbeBzw49fN3Fk+M4JGwKkKq6pvo5Uk-fpQ@mail.gmail.com>
 <20260813190813.63fjmjmciry6ubaf@skbuf>
In-Reply-To: <20260813190813.63fjmjmciry6ubaf@skbuf>
From: Semih Baskan <strst.gs@gmail.com>
Date: Fri, 14 Aug 2026 08:38:11 +0300
X-Gm-Features: AUfX_mxL4JRFHzU19Y1xhgEzNg2PbVC97aaf1LW7NSX7i3h8ym5DbVvC39-eL8I
Message-ID: <CAAsRjRkQuR8u+vxhZXOzKpVDMUM-tG2AoiTr+qGg05ewjD+4yA@mail.gmail.com>
Subject: Re: [PATCH V3 1/4 net] net: dsa: b53: deal with Northstar devices
 using CPU port 5 or 7
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Thu, Aug 13, 2026 at 10:08 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> Where is the code that configures this GMNGCFG register?

b53_brcm_hdr_setup(). Setting up port 8 ORs the 0b10 value into the
GMNGCFG management port field. Setting up port 5 ORs the whole field
mask, which sets 0b11, dual IMP mode. The chip has no IMP1 only
encoding (0b01 is reserved), so there was no single port value to use
there. Nothing clears the field. That gives 0xc2 whenever port 5 is a
CPU port, and 0x82 with port 8 alone.

> In the previous version, Rafal included a patch so that gmac2 uses the
> same MAC address as gmac0. Is this better?
> https://lore.kernel.org/netdev/20260811193658.14304-2-zajec5@gmail.com/

Yes. The IMPs never learn: b53_setup_port() disables learning
everywhere and only bridged user ports re-enable it, DIS_LEARNING
reads 0x01e1 on both conduit configurations, and the ARL holds the
host MAC only as the driver's static entry. So one MAC across gmac0
and gmac2 cannot flap anything, and the bridge MAC stops changing
every boot.

Best regards,
Semih
