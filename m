Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520445563C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578699; cv=none; b=cLPAMIzLr4pi3DFd/bB9deQu4r9EevR1FKSrUWKAmnUMbuGS0119dKx2PO5PMg82d4+bSvEwKPLct7T3FtR3sO1PdIsI5VrbkfqFpFwEM4+VbR5ZFkPk8FGvUo1+ubsaEedZ2LkcSei8hQ+BDoX5Utp2IDw3SbpDz9+y+bkeL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578699; c=relaxed/simple;
	bh=x4UOc67gdqAtkLbv3EOLJ2rgbePcLiaPfOeYJPFnXHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cctXOTEc/Ai8tRXI5SLdwwHkjmXEFwab8ECv5a1qtMW+W0G/cVltzkl38QFdq4+uxko1S1unm9FL9c8C93VQ9obEu0Rb4ZMdL6anNwqSyjK35gccMAf6sBfW/cGzrd+3N37az7DyKWOjzMcyRGX/b9PA5thm2sXzDIdkAT1ZqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxiqWaJg; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxiqWaJg"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaf5e6878fso3221903a12.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790578693; x=1791183493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4UOc67gdqAtkLbv3EOLJ2rgbePcLiaPfOeYJPFnXHM=;
        b=IxiqWaJgcx+Ue7br5kHQeGpbeQrXrlPvARZyiN3d++H+1Z/HfN+Nx43yRdJYe37dpB
         fXuW0WsWccQDd1BptViX1wA75MRuHPWDpsRHw8DaryqBp1tajZQjRBQBuTms1GdI5aH7
         a24YvQX/N7l9JHJ6KHIkqFgEB89IC3TZcX2DbG4Rne3e7em18E3mtUOzvj/ufquY3v9r
         u9tCve5tHZ/ycFatCaUh08N2pg6IAHK1onuxFWdAc8UmYO02SDOQywv4IOqZoDK7l3nT
         6oiy5TUyuYutCjxMH2CUp1dgcOIogPMEatfxQKVAfot21TnPCbmk2dMLIeOmZ+pgrpkJ
         DpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790578693; x=1791183493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4UOc67gdqAtkLbv3EOLJ2rgbePcLiaPfOeYJPFnXHM=;
        b=uAI/B7OfvXqvxqhtUyaKWThR/7QRE/gRo5d5dqVMQ6yEkNzCUAHkrqWk+p5LqhcWF8
         1BVbuq3MqRxMoYjXIXu36ZJEdwLK8y76C1/DULAn4Qhz2LuPwhnk1J2mCWvVXBwdXiGR
         mPJapjDdrOLE5Q8oQWuMOQ3c7hRj7/1vhLlnQp514TORVUfcNToHNP7Yjt2+jDlksEu1
         YHhQ+Q/LvcD9Ws5PUBNQXcpeuaAzFSkrd+OxpU0kHzZVYC5JyU3UpaLy93/hD/8OPIZw
         W2lzXIVf/3yqvPv6NalpGIBYPJ2rABoLRNIm42jSbBJqfbv8gKeIbMIruH43+5yJW6SS
         vNQg==
X-Gm-Message-State: AFq9FYIojpo1G1DHyiLKdsQ1rV+XxACxkiGbVzc9zHIlXfReDhpuG3Q9
	n80ZX6kPpqQCDsjM9/yCXC6kC328Nl8+i9FyVXgHznexHzr4apyXFJVp
X-Gm-Gg: AYBFou1LdrAjc9wUryC/GZRE1FGlGHcGF6tz8khe88YmefiJLDpdgqXt/RPQpp+HvN1
	TthNLVemviJtzTokYRPbWsTvLeb6Nm5ie6R6GPLIya6rY/GtwQ+ZaHrwo3HQLACAWM5lhTDfYNH
	4s8cczh172wqqosd22WcdmDQ8vO3XxeZykWdiiutC223ii5JtZTyoh+XBLiQ/pvxyGgSV8sbo4E
	RBcVDByUNSdGn9qst4pt+4QJZKu9XY/h0gLENNBXmOyprZkns7ewWQeQ8kBhCyqpYBrQT/qgmz6
	E38KR6RH5YnmUQ/RqMc+wt58Azo5CWCjTuYgFbl5jegNfe4CsJgoHM9sxoJhKpdR9Mg1O7W/176
	v/41rg+Km5oJyEmMcWddlWkcC1Zks6LNh84M47rWMDZt4E/DlRKQ+qXFgKw4tbQ4wtG0zI4b0vR
	WTNFMmbsKpA7ypCTZDJ0BZEYn43t0Q3QD+Pl1WtxJGqxss3MjjGHoWu0M6aXSxwfpk4MbVDuf0F
	fWBH1jIiLqmXkuOzF9deVwt1itSeSpZhzdh8O4pvVcn7kjuIpnVbHdx
X-Received: by 2002:a05:6402:21c2:b0:6aa:7ff:4ebf with SMTP id 4fb4d7f45d1cf-6aac8ef938fmr8251360a12.15.1790578692435;
        Sun, 27 Sep 2026 23:58:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:801:793:68fd:c07a:9093:1956:b4bf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ab5be57b13sm2286016a12.33.2026.09.27.23.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:58:12 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>,
	George Moussalem <george.moussalem@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Mon, 28 Sep 2026 08:57:58 +0200
Message-ID: <20260928065758.5507-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260927153616.2317-1-yongzhao.derek@gmail.com>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com> <20260923215858.1653-5-yongzhao.derek@gmail.com> <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch> <20260924234814.1734-1-yongzhao.derek@gmail.com> <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch> <20260925210153.8717-1-yongzhao.derek@gmail.com> <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch> <20260926082129.1632-1-yongzhao.derek@gmail.com> <426f9dcb-7473-48d5-a473-4435cc81312c@lunn.ch> <20260926215152.376-1-yongzhao.derek@gmail.com> <e18c66e9-7ba2-46c0-baf5-b4281a45755d@lunn.ch> <20260927153616.2317-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,=0D
=0D
Following up on the initialisation order, as promised. On this board=0D
it was the cause, and the DT workaround is not needed.=0D
=0D
The IPQ5018 GE PHY leaves reset in ipq5018_probe() and starts=0D
autonegotiating with its reset defaults. Its LDO, EEE, MSE and DAC=0D
settings are only written in ipq5018_config_init(), when stmmac=0D
attaches the PHY on open, about 39 s later on this board. I sampled=0D
both PHYs during that window. They resolved 1000BASE-T every 2.5 to 3 s=0D
without getting link, and after about five attempts SmartSpeed=0D
downshifted on both sides at the same moment: the IPQ5018 PHY's=0D
CTRL1000 went 0x0200 -> 0x0000 and PHY4's 0x0600 -> 0x0400. The soft=0D
reset at attach restores the IPQ5018 side, but nothing touches PHY4=0D
again, so the CPU link never came up.=0D
=0D
Applying the same analog settings in probe, right after the reset, and=0D
restarting autonegotiation, fixed it with SmartSpeed left enabled on=0D
the QCA8337: 3 of 3 warm boots came up at 1 Gb/s about 2.5 s after PHY4=0D
was reset, against 0 of 3 without it. Both groups ran the same kernel=0D
and rootfs, with the probe-time writes enabled by a private DT property.=0D
The final patch was then checked on the same board over a first boot,=0D
three reboots, three interface down/up cycles, three renegotiations, a=0D
network restart and a 10 minute observation, all at 1 Gb/s with=0D
SmartSpeed enabled. It is still one board, and I have not done a=0D
power-cycle test on this kernel.=0D
=0D
So I will not add the workaround property. I will send the at803x=0D
change to net together with the DAC fix, and v4 of this series without=0D
patches 4 and 5. George, I've Cc'd you since the at803x change touches=0D
the IPQ5018 probe path you added.=0D
=0D
Thanks,=0D
Yongzhao=0D
