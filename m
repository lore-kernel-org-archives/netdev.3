Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312B4F648F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370130; cv=none; b=UDHK4yGEI7S3tf0OZe+uhd3cR8/1y17Ry7xbErfB9CS5W2rjZ9xh5yqZazvjaj+5xbTZKL7NbP1YEjUxAj6EiPZv3s1v7BYeJyf7p0qYidFcm4a3PMiIme9TRiqwlNm7SDk713lpDzPAJLRERwRMx6Kk5Ls2s5KELhED5ALVuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370130; c=relaxed/simple;
	bh=Qbyuka3GiyzI8GcOPcPBKISMBjQR5N/Oom1sUT6XUUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5clM5UGHinoJ2eBq/mRlwu2E1Y0u5gunTMQ6EsNCU4VExNZ3mnVy58daWxvOCniQR9H6P1EOM6KV5QF9kb2PyILNYeVQtTy8pcG/rsi+TQhz7pTTH35W1MgOkw+yfOxRQqdslZ/UStWoB+N/jwvOKhdkZQlSYgNJr4a+4TA3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYkBDx6R; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYkBDx6R"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso153390966b.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370127; x=1790974927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qbyuka3GiyzI8GcOPcPBKISMBjQR5N/Oom1sUT6XUUw=;
        b=oYkBDx6RSrPyUWLQ8cGXg+XE7agKlIF+K8YIUSDhpCpY/TGFUOmzk5tRm3FUK6e3O6
         cHrFC9YcXB//NLzk+JHQdnu4B/eDv/ahK2j8Jvu2Wab5y5PouDk34CXg13Y1iutu+vnD
         hlGVV+eCfxHxMxRsFjyS2FNGs30GqK+T6i3C0CCXMmF8NtywFK39DVRixtRbKpJnIexY
         fzDpsvaX7UEXNi6NRMbYnWIcHMRHNWdZbMMhn+qtnmLG/7+Oa1mBwYRt++NYi6MzwGIw
         uIiXzaLRihY6jJxkmWwjc6eQXsni5fUB2iY3//m5giItzsMbcg/N9xHZUjeqSDZVgb2I
         47GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370127; x=1790974927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qbyuka3GiyzI8GcOPcPBKISMBjQR5N/Oom1sUT6XUUw=;
        b=sodtBiRG1f2kGlGwzbwKR8jIfw105oEFWHlmiZm+N2eVab2bdm5lRul8GLhIxgmp3r
         LlzQqdhRvC2c46omp30SblWSUt7F2UH6A6VC27k/XNHPcLYT0xmM6CIG6+c50/aIT7gy
         dVY57JQZY9/qfVRZbYb3YrPuK4lE85qW/MernYB6At7Mq1rvAm38f0upKKgbVJnPNv/g
         qMr1YExPtjl1DdrN2XNHjoSisiwzzmo87qNLM46xKy8jTM4Sf8x+dQ1uA1oVis3G3IiM
         frAG/5KR1/XnTn+X874pdJ0St8iGXVHgr0oE4muJM8Vf8v1vmP6pH4om2pU9OfWrEdiP
         H3FQ==
X-Gm-Message-State: AFuF++kGd8UWzK1cl9Njmg4K5oQ7YvSB9skYf8AGXQQ2pFfDKh6Bl0pT
	yhk7zwJIPKFXZp3vJcoco1BNALnU4YhGEVVVKAWFNNQ6twg+fBF/tcSx
X-Gm-Gg: AYBFou3f8adfTWWlhfSdnPs+1P5V6IeX5rnjDRHDLSBZxNyGKZgDAWiXe5XV22kUDoB
	2D3nHPhnb3b4W9XiJyWytv1tr3x5tstTWvty4ttbEeh1nAly40NT9Xaup1Uco4RGB+OC6TF2sia
	yMucuMFd/ZPVgF0AFSYY98wWSfQ39DNKIDDkYALPdaJw/F1k+xe9M8CgOIkkhiOY/Ku4/3oHdYZ
	xkQsXLUkw/bNcdf8198nVi7e/vvfWavQDbxxYVaseTQhcaQKKZfKDbQNgvxNvj5w1bmf2CRhfAt
	wAqtqR+AYM3OsJT34/WDILOA94FhDyeW+vlFfpYuulhJadsyH48Hxk133TnITyCmuL6kK53Z2ge
	a0pRt45u6CjSE1ixfxuykEEITcYcPbk65Dk7r2A+OQ7MuAw3BLBVLhmYNQAETnwEXIvZ/UdXar4
	XxLWxfyjbnzG9ZejnuPPXbnesCQ54s3+hKDlnp4tLufEB/s3iBgxmd8i11+1xdVzahiZ/aoz2Ke
	q2WA1SAMQTb1VNMLP6pppo9y6rTVmG1WY/GT7O0GoCBwHazoEAL2rXG
X-Received: by 2002:a17:907:7b9e:b0:c29:4970:abec with SMTP id a640c23a62f3a-c2ac24cb86cmr657977766b.19.1790370126717;
        Fri, 25 Sep 2026 14:02:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa1:1647:5faf:ac50:9dfb:d1bf:ddf6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5df167esm1421523a12.25.2026.09.25.14.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:02:06 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
Date: Fri, 25 Sep 2026 23:01:53 +0200
Message-ID: <20260925210153.8717-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com> <20260923215858.1653-5-yongzhao.derek@gmail.com> <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch> <20260924234814.1734-1-yongzhao.derek@gmail.com> <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

> But this is testing the wrong thing. This is testing downshift
> works. What you are actually interested in is downshift happening when
> it should not....
>
> So take a closer look at the user ports. phylib should report when a
> downshift occurs:

Thanks, that is a better test. I ran it on RA74 with the OpenWrt 6.18.52
backport that includes the read_status change, so phy_check_downshift()
sees the speed from 0x11. The user ports keep SmartSpeed at its hardware
default (enabled). The CPU PHY keeps the existing workaround, so
SmartSpeed stays disabled there.

Across 8 boots (1 after flashing, 4 warm reboots, 3 power cycles) and 10
"ethtool -r" on each of wan, lan1, lan2 and lan3, there was no
"Downshift occurred" message. CTRL1000 stayed at 0x0600 on all four user
PHYs, and each port came up at the speed its link partner supports. The
only unexpected event was one link drop on lan3 about 7 seconds after
its last renegotiation; it came back at 1 Gb/s after 3 seconds.

I also tried to recreate what the CPU link sees at boot, where the
IPQ5018 PHY does not advertise 1000BASE-T at first and adds it a few
seconds later. On lan1 I switched the PC NIC 30 times between
advertising only up to 100 Mb/s, with autonegotiation still enabled,
and full autonegotiation, then restarted it another 10 times. lan1
returned to 1 Gb/s every time. In 741 once-per-second samples CTRL1000
stayed at 0x0600 and 0x11 bit 5 was never set, and there was no
downshift warning.

So on this board I have not seen downshift misbehave on the user ports,
including when the link partner changes its advertisement in a similar
way. This is one board and a limited number of attempts, and the link
partner was a PC NIC rather than the IPQ5018 PHY. It also does not show
that downshift works on a bad cable, and the CPU link failure itself was
not exercised because SmartSpeed stays disabled on that PHY.

Disabling downshift for all qca83xx PHYs would also remove it from the
user ports, where I have not seen it misbehave. The CPU link has no
cable, only a fixed on-board connection, so disabling it there should
cost little. Given this, would you accept keeping the workaround limited
to the CPU link, or would you still prefer disabling it in the PHY
driver without a flag?

Thanks,
Yongzhao Chen
