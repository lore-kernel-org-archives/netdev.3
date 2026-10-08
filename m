Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0533CB2F8
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488117; cv=none; b=JAXwvh6eGKhJoDVp5+6HzHYll1SQ6+8x9vym2wXKSAebdvalWGG7Xi1x2oDpEh0VbEyMQQhEDKc06npr9uxxF9pIYE7cEMlpWcSkjwHcjTcp6A+ELtSbe5XjZngrH4OghL3gKqZnYnKVnaALto5sBFD8sLrDouLQaIM8IFvCkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488117; c=relaxed/simple;
	bh=fpC1Eme3VEz18Iit7OxfXGD+XO5w8Dx1LlQClNa1prs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QekG9+z3cSLcbrRzcnMZP64Ph2vCOnNdxdv2y9HhwddDytBt5pXEYhIQtdV054e39hYyZ86PQY+uXeu3XRkOU/vhttvcbAzP/SuxiWuxLnKuGwCI4Kx0RWyzIed0hJeyPLE5Us5x7pKbUlD1xq/3HxXnlXcB5qoOIvOPipoLf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh6mZ6Ye; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh6mZ6Ye"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c31a34de844so40348666b.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488114; x=1792092914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fpC1Eme3VEz18Iit7OxfXGD+XO5w8Dx1LlQClNa1prs=;
        b=Hh6mZ6YeeckXZTR898XQjBmLEGbeXw18sCPz7rrAH0DuUv+vdP8pbPif/pDiYRKL7R
         nUPe5AtsHFadO2iY1o8pqu5SCzUVNgD4X+et6qr7dTpucw+MSJrrVQ4L50I5CWwtLInN
         hS/6ObJCLQaAXVo2sMtLURdBW6mjJ3cENnPLWDoB7niy7pUeyTxHM/BWFQu3vgpEtbR5
         sczdqKEJliAQWLjKI3px7mufo3ABznZ6gcRmvhOW7Eqz5aKQ5slIv5w0vOSc6XReXirn
         9GhND3HcpCqYNB68PMFrc5oG9/9dswu/4byiZtoVS/oXVtGtIk+5V3t08abYwQP1n5TV
         k1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488114; x=1792092914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fpC1Eme3VEz18Iit7OxfXGD+XO5w8Dx1LlQClNa1prs=;
        b=h220n/Cr6Z/ByImvFEPbSTf2Ja2d2KvDIaxMmWYNtPJ1q0UgGyUySlphnXM7iJAV7F
         Sph6u4mYuTpjXIJD1NhkcGnbx+aDEX30TJbZHDaB9jqeBx+mTMCWosvOCh4sIQuxIUDa
         CC828xGufedJkNPXpQn1O7furO29V30c0am6efxxuZr7cN5ej9L3EoaIsXJhV/V3jIfl
         Lqs3jNS77jHdf/3pIH2/I0tpXV4tdQKQo3YL9hIa3SCEMHQfQVwNajfGTck1oq8d6tKq
         14mIAbEiMHW0f/L3PnEOH8YVbN81B/KbrB95VifixD/BCq2UZPjQErI7Yklb2QUJEWpV
         QUyg==
X-Gm-Message-State: AFuF++mqApUndadsJJSnmrND+dFjNRQAZ7EpKe2JZpKspwrAuFZnD0ca
	KWQEB5OFfHuxx0qWPxJPz+MIf03ts5EzYHF9jkQp1onkHQYouh2hVpkE
X-Gm-Gg: AYBFou1B+JqeEkgSdMHXsZkO4Ly3Bvdu2UEh47RtL4Tzgn/xn0Z7nIsDeyIoTQPhsOJ
	S/TrsAd49qVKCsYJJjOYFNuxIlMR7DJ4CpEcgX7u3CiAoTDMxl3vZs2aBQ4iCW39h7EkZcSnMAP
	Kfdt3GgMCCCZ0Ri0eQ73xSph4ieuFmavfWs5x64J96fS6r7mg46mMXY7/qBlLLY9yIUYVtHhZu8
	rLhSTNsTS+ncujX3ZTU8S/CeaKOVBDzSKL1Lw4maBGrXUQMbUdxR8HcBq0ZHJpQGiwGTHMQy2Uo
	1lJqZWPmA2WhRDG6Y1Q5IfogMvRq09kdh1eJv6s5V+03yVCV+0/ZzwbaDX2oxD5/Dg1jxE+1N6b
	puUkGLZArSgwkGpfgyzn86i+7s9gzU5Nw+eeOqcWZnVKgOLBZtmzxWzRXziewTssw6hiN1Kp0oo
	xlsae16G4wLF0556yPTByvLZdTxZjZRLnjqd+1k8G7wSVnsMw5/f2aP6cDSJRIMRwJl9o3WeQbY
	T8ZW7yxXaIfIzyvOZ6cAUpK74OU9zn+YrIL+DAE/2ON6WhXPCE2QCKLn+PiaLlrnjWrp5Hy1DeN
	39QFJwqi1nfaXXd4kF/JFnI=
X-Received: by 2002:a17:906:7316:b0:c2a:fd39:f231 with SMTP id a640c23a62f3a-c317c094878mr682956966b.26.1791488113806;
        Thu, 08 Oct 2026 12:35:13 -0700 (PDT)
Received: from localhost.localdomain (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a4758795sm10017366b.5.2026.10.08.12.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:35:13 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phy: qca83xx: read resolved QCA8337 link status
Date: Thu,  8 Oct 2026 21:35:00 +0200
Message-ID: <20261008193501.14850-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <179147542415.434549.1369676326541511457@kernel.org>
References: <20261006160316.1356-1-yongzhao.derek@gmail.com> <179147542415.434549.1369676326541511457@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 08 Oct 2026 16:03:44 +0000 netdev-bot+sashiko@kernel.org wrote:
> Suppose BMSR shows link up and autoneg complete before
> AT803X_SS_SPEED_DUPLEX_RESOLVED is set in AT803X_SPECIFIC_STATUS. What ends
> up in phydev->speed and phydev->duplex in that case?

Both points are valid. Thanks.

In that case v3 reports the link up with SPEED_UNKNOWN, and the early
return in genphy_read_status() keeps it that way until the link
drops. The reserved speed value ends up the same way. I don't know
whether QCA8337 can report link up before the resolved bit is set,
but the driver should not depend on that.

v4 follows marvell_read_status_page_an(): if speed or duplex is still
unknown after at803x_read_specific_status(), it reports the link as
down. This driver has no interrupt support, so phylib polls the PHY
and reads the status again on the next poll. The qca808x approach does
not fit here. The value it falls back to is the advertisement-derived
speed this patch replaces, so after a downshift it would keep
1000 Mbit/s.

> Should mdix also be reset to ETH_TP_MDI_INVALID when the resolved status is
> not read?

Yes. v4 sets mdix to ETH_TP_MDI_INVALID on every poll except during
a steady autonegotiated link and reads it again only at link-up. That
covers both a link drop and autonegotiation being disabled.

at803x_read_status(), used by the other AT803x PHYs, clears speed and
duplex the same way before it calls the helper. I have not changed it
in this patch.

The model test now covers both cases, and v3 fails them. v4 has not
been tested on hardware. I will send it separately.

Thanks,
Yongzhao Chen

pw-bot: cr
