Received: from mail-ed2-f39.google.com (mail-ed2-f39.google.com [74.125.228.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D578247C101
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200674; cv=none; b=iT9WL1RrX00jATscJkSItC80g0lKbqz364DucJ7UXD/FSm5mzVwtbPxDHdPurFqn2zC5BUPoW0wc4wi2YfbD3mN5Tl67L7zrkv5bE4n3mgf8iHtZoMI0bLMAP0hnLztfPYOE7PKRuE6R5mSULZFCP4A1FVjia0g8MNd0q/FqOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200674; c=relaxed/simple;
	bh=1AK2BaJZeG64voe6gKOfVpTFFF4p/0RUNEYvw+VGdjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VX4VHzLbXTUWJ9nRPr3hx8XwY9r3ruawaEVAyWKIZ2LO2Xnf0gAZv268MWr7dAvlHv4ZPK7OQPCRBM8FDF6pphA+FfHsrrmjKDOjW9hpNyZlRY/yKmOFn0OW7Ae2O58w/zJe02Xvpw9DNuHck+umKqwVlwM8cHz0bg9xOK1PTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2Ay+0CV; arc=none smtp.client-ip=74.125.228.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2Ay+0CV"
Received: by mail-ed2-f39.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso1742488a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200671; x=1790805471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AK2BaJZeG64voe6gKOfVpTFFF4p/0RUNEYvw+VGdjM=;
        b=T2Ay+0CVksZFJESuMR1u402Zj+R9s54h5F3KI27gfZCbC68veFNsjprk5P6Nncktgj
         a7FiDvVmiRR9G/I/nwvN0CYw5x0zCwEiMJXBz6U2RT4y0YHdoVIZ3oGB6smpSn54lnMk
         Yz4sUgDRYOJXqmy4dIxDMotow2SWfIXoA2HTdV44fnHaPV/vRsPeA/dQAk9J4jeAhXvq
         q0Qg9PdkDp4GwalFfj4YNtDhim/mQYIGJ7DXzgMrFbi/hKSBTNSNfuYWYbqoBgP1/3gl
         yVpPyjZZ4jXgpqhE02d+4tegWrbLrrt6BsSCrUs/di8n5Y2gLedr18ZyCrN8XnFkN8bY
         GBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200671; x=1790805471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AK2BaJZeG64voe6gKOfVpTFFF4p/0RUNEYvw+VGdjM=;
        b=UAvaYk0vT3zMjXZT2AoFIYn+u44SRTw3wZlzP2uIW+HzRMmPSlO3o/bTwXkZc5PynD
         EHz4kkRGHuh11BanI1qy+igCm/Zz1dua2utMnRLZVfq9atDUhZvoTmGBgLu57Oh6jI24
         Bs4jBKAm18lABO+1Syt4cj2MslHP6XZ9Cbwi1rayVKatYntNh5AVrvCkd+wProX8SLNz
         1GuXsoawJ2+qYzJ16Sxz7L/MB6Akz18fpDZ8gXBa674+0bLBwOGPDoZn4z62M4dElPE2
         bQl/mwmcpoSzifcFEAcMRaHx11c6WPb+fbRfIm5Odtk5cfha5mPqGM4eHHe4aBHZEOJs
         fUQA==
X-Gm-Message-State: AFuF++kXolxIWstDUcm7O8Tko2k/USi1XDt2kYS6GNqnVdTmvkYTrSZ/
	qHALzZNlSYdu4nj2w4gkaoswbQwmQYNbJvTSnlt14BMVPul+dW1OEGYD
X-Gm-Gg: AYBFou1XHzFX2AsFeGJ9+oWnG5NjZSifx7hocM5vSNtef+ukgmyxlHC6em7LFK15RE6
	aJNmZn/z6bcP8VcwZ6FsQmKG0ZuxQpNDnVVrUR4TLsn/+Ly2+UU4FRl8hegBdSUVx1hwBLwRHvX
	hFE+3wl7XGeMWYMv+ddUSM2f/ngxC4vi/Dl2ZUA/0Pef4AO1qmSmLnfsm8+dh/EtcjgIq9DJqQW
	2uuFshu/Av4Xt7w74/xbFOzg5GcbnG1WWCqUoFzLHQnCvgj3OTiO7Xo8GaNraSJGQ8i/CBqeISd
	s1SavzbpcW/uZtrXfa0m7FUVILfmog30WtsAvuUnW32G3N4Pph+8QDYhg7KsZVS9pKIlZe63Fg2
	tzPchkRGHYOSFzV0P4fOoaaOnetkI1KE+bYLKmsP/kC9+FNiXfvOXIl+FdcV9hOuPHrTNvbhlFb
	dZ0ubnYUFW+KUPIEWzHjV9p0zEzI0jVWL28IuZrbQEiMUcAC6/KSx8Sf8oJRWoBIrFGKSXR6/o6
	Y3r2fRqogb/Q9j7ObJ99WJH7AvoGmEN2Yp7DApH8QL3j2sm6w4epsdNBwchPnp6WM6EQUzwQsG1
	u7/poWEafWCNUXAHxeZpCGvA03xSca8=
X-Received: by 2002:a05:6402:3210:b0:6aa:481d:983e with SMTP id 4fb4d7f45d1cf-6aac8f4af38mr531235a12.20.1790200670788;
        Wed, 23 Sep 2026 14:57:50 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38b2fc5sm2488739a12.27.2026.09.23.14.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:57:50 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Ziyang Huang <hzyitc@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC PATCH net-next v2 5/5] net: phy: qca83xx: disable SmartSpeed before resetting CPU PHYs
Date: Wed, 23 Sep 2026 23:57:35 +0200
Message-ID: <20260923215735.234-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <c50f5ffd-a67d-4adf-a38e-048acf7bd61d@lunn.ch>
References: <20260922202653.1153-6-yongzhao.derek@gmail.com> <c50f5ffd-a67d-4adf-a38e-048acf7bd61d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Yes. In the RA74 trace, generic config_aneg() returned successfully with
CTRL1000 at 0x0600. A later read found 0x0400, so 1000BASE-T full-duplex
advertisement had been cleared by then. I did not capture when it
changed. The instrumented Clause 22 BMCR/CTRL1000 path showed no
intervening write; other paths were not ruled out.

SmartSpeed is the downshift feature. I have no evidence of a broken pair
or a successful fallback to 100 Mb/s. The 0x0400 value describes
advertised capability, not the negotiated speed. Clearing SmartSpeed
before the initial reset kept the internal link at 1 Gb/s during the
tested RA74 boot sequence. The trigger remains unknown.

Thanks,
Yongzhao Chen
