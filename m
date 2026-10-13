Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD6535FD0
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918222; cv=none; b=G3MrL5Fb9CYUkxmJo9Ft8bp+7niJSGADhkpqzkQmu0eI4sR9ix/Gz+VDoNoU678CVeHFoAahaQ8p3cAnqN1Si5OUBocmg3N8JVSbH+vvXm26GPIUiv2RUcv21eqtkvpTaNntEndzTTfqyN7uoJ7RMkcXVFS2Kd4b//+8crB33fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918222; c=relaxed/simple;
	bh=DLwihrgna3d0G0IZ8VFeYrlHIvdRySXk+DYF3Jc7hNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aov3ehYlyQK00n7MV4MpBdMHfH4A2V8/zO2BDUSrQHAGI/IlErY/7BIZeZ7ElKkUMHFeeObQoCbxk2wFTlnwbyb1UiKvM+Xzo9DbTtguIIny18ZY5v5GJ3b89c0n5xb6xBHXe/LPmRY79usNJlYB5V8MImWlzKj81aH2jrCVTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA1RUBI5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA1RUBI5"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2e5e801487so499938766b.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791918219; x=1792523019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLwihrgna3d0G0IZ8VFeYrlHIvdRySXk+DYF3Jc7hNg=;
        b=OA1RUBI5p6oTskft5kg1CNZv7p4vVbidUhYnjFLH5F4qKevumdZsjD//aMqKnEBNUX
         pJT5DkN5WSTV3U2CK+kEtWWHJ1XBOJHclR7DqZUbsX/QGFkIlC3OHrMmf7a8J53wOpmi
         I4Q95KzNrTfwOjMNS9hDdpzEUWzW5RiivIyz0CmleSN6F+t3tUWG37JlEoZJVWAPWY2E
         yAHbc+XfBCUsvX9Ny4U9NwbL93Na6iMwgNarK9oAxWJD0Yb8WbV4dyusU31y/CY9yyjF
         P3I8Mfw38rdc6+HfS/nB0rRthjdItudhg74FBVEjBHuzihuS2BkwKaiOCVo/vY9g9EqO
         isvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791918219; x=1792523019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DLwihrgna3d0G0IZ8VFeYrlHIvdRySXk+DYF3Jc7hNg=;
        b=d854n6+3rrtqjNfr6n/JrMM7TrYE1Z4I9mcMQ7RyVne6DQsWkQ/JLQ+gzbFvOGjj35
         Mk2mi9m2yyGAW4ZqMEQ7K7Ke+mrMxOUNQfkkJ9fEjakmri52zuiOFk+ML73Jmbhe78un
         hfU/uRI3WVv43QX6nAYY6vYVjQ0zc/GS9ww2DbuFv0z8QjfPScbOcTgjhY8qba2cpkQN
         0NDiL6mgokUgClVXpHWxtAdCUuMGs5Bl3j4FV2ZsCCVvuG0egYaXeuN4Wy0bNLq9EMr+
         JXC46TLyKE9LbdUTRbQAQelSA0u/HoyFaaQu30TRVmbYlTulqPPXDQQBhrv9gXyAH6NI
         UR7A==
X-Gm-Message-State: AFq9FYKjhgU/7NQSsU5l5qP6iWIv0eCN+6yZdrPaNJ30HGI1/iXoKTHg
	yw6XxvlqqXGUMtvhosbE6ys1LqDAi2osPwju33Jd/EUFvQ71dWbrBhJz
X-Gm-Gg: AYBFou376IorJRHVYkvexHbnXUYE+IZ5kwYTFbEgxYnOtiEHMtGLI0qMkZ3jY6eohqG
	puPNT+ukCMDsldATtDTm53a/ADKOrxW3RlBNjrPhDmpkXVXroePoeCnqqFznzHB0aT3VBA2FYqW
	xWqDRDV4iIhxZZc9TtfqHwNzAwrNFODJb/CuNiZHCFvdr6bsBmwLyoFeBOTxSTexf+xfoXNmQD+
	ayFcck5BarmRYBUDVqyCzpMynnt4hqO86FdikxGvS+BIZRqO4/RLyGWYmtqgsVGVwvNn2iluJj0
	jqjpwlQk64bs+DDSQitYKQNAiZUq4Y/7xLpGKw+Wp0z4eIcvm4pIWZW747+HVRwcY57J4+dTF2A
	jXjujKLjdm423mPdGUQ70TuKPpqT7BT6Vrm0FYEjQf2cSghKny5ttvGSH1qW/+x5yyRgYdP76Wu
	LYbUAbs+SCfrY5kiAu9ykqO1INFBEK09s48rfCtILqGsrjRokyGNNQWhBTvofcdvFj69XWCMiBA
	OE6T3AANPfZ/Kze4d6YEV2MoX/PfakAy7Bgxu1Wlnp98JaTChUcNHI+h13uWNAbdnSdiLtnBe9m
	FO04QV68AkgU+qWBmoJcB1Q=
X-Received: by 2002:a17:907:d8f:b0:c29:d31f:7d73 with SMTP id a640c23a62f3a-c31a9fd5dc1mr1304257866b.9.1791918219119;
        Tue, 13 Oct 2026 12:03:39 -0700 (PDT)
Received: from localhost.localdomain (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c363d61243fsm182695366b.6.2026.10.13.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:03:38 -0700 (PDT)
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
Subject: Re: [PATCH net v4] net: phy: qca83xx: read resolved QCA8337 link status
Date: Tue, 13 Oct 2026 21:03:26 +0200
Message-ID: <20261013190326.51893-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <179183374827.434549.12054936309141943394@kernel.org>
References: <20261008193515.14880-1-yongzhao.derek@gmail.com> <179183374827.434549.12054936309141943394@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 Oct 2026 19:35:48 +0000 netdev-bot+sashiko@kernel.org wrote:
> Should more of the link-up state be cleared here?

Yes. genphy_read_status() has already filled master_slave_state and
lp_advertising for an up link by then, and a reserved speed value
leaves a concrete duplex. phylink is not told about the link in this
case, so only ethtool sees the stale values until the next poll, but
v5 clears them anyway: duplex, master_slave_state and lp_advertising,
as the PHY_HALTED path does.

> Does the QCA8327 internal PHY need the same fix?

Possibly. The AR8327 data sheet (MKG-15791 Rev. 1.0) gives PHY ID 2
as 0xd033, which matches QCA8327_A_PHY_ID. It documents the same
PHY-specific status layout, and SmartSpeed (register 0x14, bit 5) is
enabled after a hardware reset. I found nothing for the QCA8327-B
PHY ID.

I have no QCA8327 hardware, and the failure and the tests were on
QCA8337 only, so v5 stays limited to QCA8337 and says why in the
commit message. Using the same function for the QCA8327 entries would
also give qca83xx_link_change_notify() the resolved speed. I think
that should be a separate patch, tested by someone with such a board.

The model test now has a check for the state left after an unresolved
or reserved status, and v4 fails it. v5 has not been tested on
hardware. I will send it separately.

Thanks,
Yongzhao Chen

pw-bot: cr
