Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476259;
	b=YjHQd/DQYkF/C4dQYFrcpK8mr7dvGuiMHcjKg1xrv5xukTjWdr72xcdJypRf0lyIjuyo
	 9hMmOVFcJ7pKZWmRI8tF/nuFgeXfa/xSXeikqaB8jZZ3Kd0BuHPYthLvwGqq+rWXBaKPv
	 Nd0Btb8wlo36JeW9p7RDndOy5ZRH1baqBOFcHwWNWoYcrApYoKOHUjEQ9eIF8MxEJthJF
	 mM0nLYbDHFJM//7w7u1YuDSX0dzKa1kzyOnMKB9qkH41VzGAQEvdVBgC401JSqyj7d1O6
	 eCVb2kOJIF760sQ1kfTEw3FgnqICZWLHPDSyEEc0AtI273s0JHc5pGBpwYlQzvf4qfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476259;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	b=0L6CqykPrZF+WhXvKSlIp8p6M7wip5xgM2s4DpT7CNeSQLoUqf0uuPa4RSKSUJ23wpyr
	 MXW+DvSVNuyVncw14TaKvS5xPlZW6pO9MQ7+A47SOWuvtUrrxsWMzCQWKtWiMtH5XKm+D
	 ugEKfwft7ktCPSVKMg0RY/dxU3+S1Ob56ZA+96TbNq7yEYGW+fE2c4YGUs7YyhklF6tX5
	 TXATG82jAKAoXPraekFjQ/j2nsDGrbHPNItDdSmHXGLMZ1aIk2LJIeCp4cr0RnQMkYNmo
	 eEboNJbmQ6jkH5D4PN2cgXpi4kY1uXem6KqGrdk1YvVMcwbRxJp0a0ekL3ORu34rkZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R46XEboI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C628606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R46XEboI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF5A1F000C4;
	Tue, 20 Oct 2026 06:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792476258;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R46XEboIq0Xpx9YF2vTzb1KkhKTnJmaRHUVcpK5kM8Axs+dpPn5OKSbQS6i2kNls5
	 FyzwFzOEFXLNbsd/jQClz+iUFbbYW0rqNGHJx8Lf2+DwEUsgHBPOMNPt+EyT0pApsd
	 DB5Ii/ylg/jnVuT/JzFvjrOFh1PjZMHNIXuURItkwOSYVG+P7JviAei0UxrT1QJ45I
	 bRXAiaiGI3zdvrUjRSS10pos47YP+hyslduiy8IJSmfzhIavjUfT8VR5OrCSgjtiRQ
	 aoM5008Y70UUpQAh2zoJr/Eoo5vvUAPUdyzv5IuRBZNPJ5n40cWR63cCT82noC4962
	 8DTPQHsiUepGA==
From: netdev-bot+sinfo@kernel.org
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Jacob Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>,
 Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Uwe =?utf-8?q?Kleine-K?=
 =?utf-8?q?=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: 
 Re: [RESEND PATCH net v3 0/3] net: wangxun: keep MAC enabled for NCSI devices
Date: Tue, 20 Oct 2026 06:04:17 +0000
Message-ID: <179247625706.3290.207824944994471146@kernel.org>
In-Reply-To: <20261020060107.25636-1-jiawenwu@trustnetic.com>
References: <20261020060107.25636-1-jiawenwu@trustnetic.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
