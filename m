Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239DC4582E8
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803467; cv=none; b=H67sZA8reCEvqpMm56ytiRoHZRpoBVu4MqDbRgUwkLWB8FU7rLwqU8kkSch0rett1wEeKjkhNswQSlm8qNSxIBbM+X6Tw9jMXtGBrvrf8i+URWgdFH8BJIWY79Ci5hduiegXXEjgRK+evm+pCUAlQ0o39Qr9IWDKssGvjnL6uqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803467; c=relaxed/simple;
	bh=Ek5IOI6044bBPYcfeIf2BvSBxolhZzEABxqC8yBnwIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/7zSmHOp7RUaApkLzsxsBA8QX9pGB9IQBLArVUt/eGQiEoeR3aqUn8ehryq5iH6UiTQYCMevypYwSEiA4rerUfLIM/lgu8rT/h1OTBxpQFhbk7O/ZSVF2jPTrNXKEUkVr4We9SUwixABqBlNbYk9LaW7GJV2+1sbJ2HzJTJ7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haIieiBo; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haIieiBo"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so845555866b.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803464; x=1791408264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PR8LkwW+JzP2em42e4m1kyqysrkviKYFFCZC7Wjp3g=;
        b=haIieiBoGEHfHxxx2JaVobYg9SrToJ801j6yLERQLXmS0vEX35TQbmvga12g7kLblT
         c9ipqJdFaHrxQmCOMHgyDXP9h6GhueFn24mI8ITzFebUyhsmHPsOgEKNxoKXJcz4rjtq
         fFZsUhsbRu0iRxapmtFrPXJXbpxeVBjd/ADmCEU+qDuZ8K/k+tECTKdwaeKWp+N0Kgei
         1tjLf65uRg50w6fKSHT8A3bb1GifKaEZyNE5ra5xtWO0tWamYd6Vgu8X7MLdoAffGUO7
         i4VpcbIL1H7Ha8nBhNK3ogmcuX9fChzabg5fLZY+PAk3ZkYLCHzlqHxbRwa3cEw4ier/
         eEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803464; x=1791408264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PR8LkwW+JzP2em42e4m1kyqysrkviKYFFCZC7Wjp3g=;
        b=jtKqAVIlLyR/m6HXN+iy35wW8/VhXl23BMhDeE42KoZGwFCeL/8Pf4Jtyvw73SZBks
         IT8aD4GrXTo5pD+h0Hkn3E9lW7Kd26K4NZPjexLvjIqCHf7PtOGqe0t+W8wLA38agRuI
         Ny0DlQ0xaI30BOs+T/EKsQ45xYU1mayMg7qrR/geWgeue+weEmUqDl0qKZXYCA/K/S+z
         CEUqCa9apogYanOhS9BqkN9XRNvq7gNO/EyFQdA/b5IOJGXCwvwgSbvExkh0uWznncRu
         lvJUDNVl7yaIln46xaxM5eJahxyn2PiN9rp++9HQw9uGuNAvoZU6YPuVlRrLv6chDV+D
         gpaQ==
X-Gm-Message-State: AFuF++kbY0mebMPqyXbE+6c64luW2Lk/SklVA3j4n1oOLvy971dLVroM
	/Z2VS8dksIWGyRgeRBDbFUBS+sIQ4suzy/qE7bnpKql82lPYb3y0YSoh
X-Gm-Gg: AYBFou2BXFLWCAdOx6aeF+jZz8c99pubxPKUn1Fvzd4pN3dZvT+UexqKfvRQl/7E1XG
	7rIEkb7QXw5i0BAHSLSsZHZ9sW9g857wLFQjFQXJIZ6phtA3xeSMPTPnHuOPikbwSjUHyWWIrwG
	uPZJy2TGxdjRVYifTKEqzDHR1ve/qeDXsQAT3MMPZBP0duB5OIHwI8qObN6qY7lkd0v+OD9O8/c
	aeybOY+GauglE0HZf9rufwmuF+gfBbB6BE7PfH6eldwnWjtrfpfIakMSwqnd1sYpgfQgZzATKYF
	RSacPZZKYQzgFfinN7/EvQD+l1/u9MuLnjlzZMf2ozasfWsvbKrSVWnNHSKZCaJEet8jr43QCvi
	1aslyQlVYN4Hi04qtUY1GLJNTAewpM/Mdp4Zxlgtu5wALenaktTCfFKWn4fgzODGlQvuAz/2cVm
	LnPmQXykt7tmTIGYZyR3c9Lfn05h4qISbqc707TKbpK5/PVY/0yF4REuIWIkC61xt+75Vr/AhJT
	RGmLJ2/w3OuyofRROk31y4yFKVxMPPaRrvPk25tGsXFIfNvY/B4zYHHiIjkCAAdTedUVlczXMos
	ncgEzMG0M3YNd6lD/Bmu
X-Received: by 2002:a17:907:6e94:b0:c2d:bf0a:190 with SMTP id a640c23a62f3a-c2e23caab18mr223464866b.15.1790803464383;
        Wed, 30 Sep 2026 14:24:24 -0700 (PDT)
Received: from localhost.localdomain (83-233-221-82.cust.bredband2.com. [83.233.221.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31a35d61sm57600366b.10.2026.09.30.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:24:24 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: dsa: qca8k: support QCA8337 internal PHY CPU links
Date: Wed, 30 Sep 2026 23:24:12 +0200
Message-ID: <20260930212412.1973-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <6abb54ff.332d3c56.21546b.7fef@mx.google.com>
References: <20260928220811.1880-1-yongzhao.derek@gmail.com> <20260928220811.1880-4-yongzhao.derek@gmail.com> <6abb54ff.332d3c56.21546b.7fef@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christian,=0D
=0D
Thanks for the review.=0D
=0D
> Can you put an example DT for this? Also no additional register are neede=
d=0D
> to this special mode?=0D
=0D
Here is an example using the switch's internal MDIO bus, with the other=0D
user ports omitted. The SoC MAC has its own PHY at the other end of the=0D
PHY-to-PHY connection; its phy-mode must follow that MAC's binding. The=0D
full example passed dtc and the qca8k binding check.=0D
=0D
    switch@10 {=0D
        compatible =3D "qca,qca8337";=0D
        reg =3D <0x10>;=0D
=0D
        ports {=0D
            #address-cells =3D <1>;=0D
            #size-cells =3D <0>;=0D
=0D
            port@1 {=0D
                reg =3D <1>;=0D
                label =3D "lan1";=0D
                phy-mode =3D "internal";=0D
                phy-handle =3D <&switch_phy0>;=0D
            };=0D
=0D
            port@5 {=0D
                reg =3D <5>;=0D
                ethernet =3D <&soc_mac>;=0D
                phy-mode =3D "internal";=0D
                phy-handle =3D <&switch_phy4>;=0D
            };=0D
        };=0D
=0D
        mdio {=0D
            #address-cells =3D <1>;=0D
            #size-cells =3D <0>;=0D
            switch_phy0: ethernet-phy@0 { reg =3D <0>; };=0D
            switch_phy4: ethernet-phy@4 { reg =3D <4>; };=0D
        };=0D
    };=0D
=0D
I did not add any register writes for this mode: qca8k_setup() already=0D
programs header mode for the CPU port, the four GLOBAL_FW_CTRL1=0D
destination masks, and the CPU/user membership masks using the selected=0D
port. CPU_PORT_EN remains set by the existing setup code; I have not=0D
tested clearing it.=0D
=0D
I tested port 5 as the only CPU port on a Redmi AX5400 (RA74) with an=0D
OpenWrt Linux 6.18.52 backport. Readback showed header mode only on=0D
port 5 and all four destination masks selecting port 5. BPDU, LLDP,=0D
EAPOL-Start and broadcast ARP frames arrived intact in both directions,=0D
and unknown unicast/multicast flooding toward the CPU, DHCP, MTU=0D
changes, renegotiation and ping also passed.=0D
=0D
That test used the external MDIO bus with wireless disabled, and needed=0D
two workarounds that are not in the posted series: a dummy phy-handle on=0D
port 6 (a fixed-link user port) for MDIO classification, and a NULL-PHY=0D
guard in qca8k_port_enable(). So it does not validate the internal-MDIO=0D
example above on hardware. I will reword the commit message in the next=0D
revision to claim only what was tested.=0D
=0D
Would you prefer the fixed-link NULL-PHY handling to be addressed in a=0D
separate prerequisite patch? The guard skips phy_support_asym_pause()=0D
when phy is NULL, as it is for a fixed-link user port. For port 5, are=0D
there other CPU-port registers or traffic paths you would want checked,=0D
or is testing the internal-MDIO configuration on hardware the main gap?=0D
=0D
Thanks,=0D
Yongzhao Chen=0D
