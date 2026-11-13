Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794555964;
	b=oKC3SDdFpmrtlF+L2CKBrMm7gB4EwlGwvct6OCBxM4xnp+O1U9/ESProPkaQb53dwvaO
	 FBGuUK46w0s7N95QcJSBSQyaOJ8i6JMdtT6gxOsSJ/DYXT+5qeBUoccZjeixiDpv8CGdU
	 mDbBKJt306ftqqhEvnKjeAzLUmOUXi3uYBHSCzbESfjJA+oxFAbUM3/7d+5ozmwnEIX3N
	 soO9h+sAqqQl3a8DjGfAwklVxdPkSedd1MiPSqVDE4NDevn6GqUohhvjnvbwWkFffc8Vx
	 gEHLew0wD8o1w33bdPqlNkK85lbwyz6J7690EBADAAKffg8JLt539EKa93ZZblPaLTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
	b=rdmf4BRtLgNWuNmp7ZS0BmG7FfHG4V35VnSdx8xkyeUBmfXSuMMvG/tCGf9XNvTpyYoK
	 LVHRgqAEbUmaYMR+7JPsdptuKAAm+afFErFXQV9NGLARTN+LYQVzgY8dSlgC3F2tJhAGq
	 iCfHffbmhIWOwDEh0DkcOFgF1qG+LSMPGXHUwHFPPK8IP371tlz9tyXRAk0Zc90xij8G3
	 ej/5XHWChsdv033nH+lCJZUPQaiiwMoohJe5rMwwbseEBdxvO9JiTBIGaJbnVRs2OlhHH
	 UQJgb+iqUga+zOcel3rEq/YPdXqpbt19NgMJUBLnOz/24Lzas4hMKXGO4gffv2oqr2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlV5pE4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54506606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54506606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlV5pE4W
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c09e2ed679so59238e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794555962; cv=none;
        d=google.com; s=arc-20260327;
        b=TTtpY9RINjA66gmja/I4atzoCsH+As6ZL8ut1DzUSzBaBUlKsaXmGQKmFiPEIcwLVR
         snI/0MNAUU7dgDIvQA4gznqgYoW7PbGrbRDOaPXV4UZR9KbhWti3CAHREzGhgB27Rrux
         Q619/4K+qEWW3hBDaNnO2cEaey5WYeiimU9MVoVtBqbhe8fPwhvdY65L9t7PO68B6Ok2
         EKHIVVm4H9AW+3QhCzYrcNr8F0HkLgIAQ/6XE0C+OCB5q1Ed3Dygt5JucOwjgKId5z/L
         aVOhCiWvBI7IIv/tLSaRdvGtSmfXqt1Knq/Hmexy2662Qys+mgiM/wDpNwNyJzRzBsgd
         znqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
        fh=QsoK8/+i+XD0ekSrftenAWuBoOe4Fyp7sBbk4gMAaQU=;
        b=cp/KW24OY1dBAQu5lrMRNCp1En94IU/43vnK9TzlY3shRhmr3ZsIKUvX80att/PkZD
         OU0xUULOE556bDllor8fOn2vbp4dVqdBv9erzqXNZYoCWfvPTFAQIU+DWqvcXSSqQQlH
         t4jfSP1oYdSkQ7j/4MJpvL7gvMoJCuzJbzCk98nBKeb8FLnWfKQuUnEaPuF+FjzhM9ap
         8VTpiWfY8HHM53h5+e0UjKAhNGBRaA0eOuFhaBrxD92+wbwJVEiNKK7Re+Knfcly20pw
         7aH4S3IxLhd18CDh+r0YYeUCalk72Kt5MYR8XeeCCP4rUQQg0sdtTt90KamJZKDNa70n
         eAAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794555962; x=1795160762; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
        b=DlV5pE4WyozKzf3B5GLFZflBg69H+ArJqhA1q9Onj5Rac+wqD0MqfXqqkk6+0utQfH
         oHo7TIF5iYCLL7Fc2hNjSjO3vs05ewSsUTy9mcDMZCSmSpieIyKszHgDUvZML6v9noul
         NBHlUnHbzeMPl1O+MFM2IVK/LfZVMzJ5t5d5ScnWJwJenfTp9A4CFmtbZAsuZ05M5+Dw
         YUEvm6L2v/VttYbRFz8v8XDWJU72wdYRJeCsDQHfd6j4exyXF1vggZDlf9+JBqbO979/
         cnJbwKnqRKkZa/GSdZ2NGD5cp/idJe3tUyaEJ9aF2nraqyFZYntKX8truvnL9g55l841
         Qoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555962; x=1795160762;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tvPQQMwBZ/Lg3SekknzYW0QsE4BK2jGjRwomhq4ONEc=;
        b=d73Q7bMegHJv4Y9CbBjZDZ4LyW9OBIjDkT7lnY3FFxLha2NTn7wOMgcnoS1M7q1bEp
         bQv8xTpE4OC8hRCX49l6AILAJEYj5743/d4fBFNTOvVA+6igQUhKLefKe9xos78HwQsG
         6PRy1QQgHXzLKF8PtuTCeOyWapDHwGBuIyZcNFoYtK4Y0+Ujy7SbE87Ux4utXjgEKgJU
         wF7u9VXM1UJ1ZRbmgj9RJsSkTmgYrNrQejdNXZuJzk8LwawQdQyXdRUphnyAmEhebGJ9
         LdHXOHB0/HYS/631y/xeSjGK439nMxHBZq7Bo86hTSNjW08jz6nNs3KZDvjmWzVdpRo9
         adJA==
X-Forwarded-Encrypted: i=1; AL+hErFLgvHFOCW1fs3sURyqyY3VrLPxNUIriu97Re218VSAIN0sxZd/6rPXLpKufgN5nRC3z9Yn7VU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V8FTBlLVHbR5Bas36NBp3zr64MSsHz6spAo9Xp+fVgTqHmtP0
	cDQ/M8RZJRZT/RtQbkBZgqlPD7eagCHWxaRTk1ak2tSAWuqWwnu2jK8/S+2VGDzMuZT1J+8ci6x
	o50bco4fBa/FovLMDx40zgatROkvN6eE=
X-Gm-Gg: AYBFou254ad8mX4SWBHPPSo+kYuVIudbc8JGY1J1Y44mNNVs8VrfuRDHUCdJkUUapg+
	itRHYh85fvQ4nndx1y6xZvajnhchfQaItEH7ffKFx1cLJ7/ZhGrrV9jFpMCsHBL4Wdp2PBn9JBu
	seMm5fqEtINa1iZseV9iIF9av07xMiSoRqk5BwfOJomb+Qd0qns9OrvOVfoJb2gmi7kQg2YU1Gh
	ykqA0THfITLmYS2RNTG2e/MzEFNtscZqevA5QVFv0TU6vY+d6jTFgn2AjkgZXBb+Q6XFBhg+viq
	CDiVTY8dM+MW+TPOiMXMe5XvJQ8xNFq5yrPuAX2tDr3eCTVgvVEbnG//3AainhY0A4Hi1AAoww8
	uiKNEQroroKjuEw+elkgpfmPUsrW5ZwVtql57t5tNbI0wKxsArxYuM4iHkkIrkoLqC4eBSGQ=
X-Received: by 2002:a05:6512:61a4:b0:5c0:465:3fc6 with SMTP id
 2adb3069b0e04-5c1709ce71dmr805206e87.4.1794555962280; Thu, 12 Nov 2026
 23:46:02 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-sun8i-emac-mux-uaf-v1-1-308ae7e6fcf2@gmail.com> <e526541c-f91a-484b-a677-4c55e4a96a7b@lunn.ch>
In-Reply-To: <e526541c-f91a-484b-a677-4c55e4a96a7b@lunn.ch>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 23:45:50 -0800
X-Gm-Features: AclHuK-IYiE1aDGEHibGFo-Q3L4DjiCYZIfUZ-5mDw69KYbW_QlhkXjxqGYSAjo
Message-ID: <CAEy9hNX_E0riGS-TdDogDWMv3-fpAVFLAjx8F0cvq4Q_rH3REA@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Fix use-after-free in the
 MDIO mux error path
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Does this bother anybody? Seems more like this should be for net-next.

No user report. Sashiko found it while reviewing another patch of
mine to this driver, and I have no board with the internal PHY to hit
the error path. I'll resend it for net-next without the stable Cc.

Arun
