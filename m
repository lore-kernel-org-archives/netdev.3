Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528145;
	b=X93hQmI8DwW5ys9xjy6Y+4IGOSKSveIXd+oZccY20PBvOSXUkfHiCzNU+KYP51pPnmLs
	 dfkz9i3TDe0RPt6AxpCs1d5bQWt6urj9irccVCdNifibxvJCcn2llEFoliGoViYuHbnmn
	 QBPwqDuo0sZ8XD4lLpPzMEU72ZxV3CFcgOpfEFbm8W1tl9YP4desFISfWxI/b0AypFGhI
	 oDmynJi7Ig6pUEmuWeJ9eYy+AYPHkFPBuKoa7krHUezDsJPDsh+BWpFu6r3yYVh/ji7Xw
	 ESS6f/xcwrERbQjoC5461LYyzko9Dgu/KI8ZS2uBfcMR44V2cZ4VRCZG5HioeKD5ZsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528145;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=ER3VL/YKcVAvi6I4leAEmmCSa5fzlRBhaTWdm3Y34p8Q+Y8OGA7gKl7ey9uzlBnvfuw6
	 6IMmcyI6C5knwnzadONtAKkHvKgNtQvNSs7llgAhrrvfGjB6ZP5edCP5g9fZ0Z0kCRrzJ
	 FskFUyhS3M4OZs3K2pyJQyQ+aHxfhuXwVaG3NTqGegibA4AKytNwgXW5exsAOThtFhyCn
	 UnfiQpiEkU87yzcHmqtBiCnDPvynxQYfxW5bPzhW2c8ed2l2E0CiCOmdmEdNVnlDvKRkC
	 f9+QiQtItafCem2iFMLdy1/ZvXc8LAOkrQ7F5bJQ0puvvFrOhENNNZ3m+DRF06HXfYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVn5k188;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE1606A319;
	Tue, 20 Oct 2026 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVn5k188
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19DD1F000C9;
	Tue, 20 Oct 2026 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528144;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVn5k188EQ6OALYXS3EEOWOS7LLlYJX5eJAothAcwLyQ0ugIGMLAKM32ayOgB5v7z
	 SPHWgfDt+FmsttDnX90hmAr57mp67FYK2A1lmINGDTGHJXuVFDi/ZmszxqySjN2BzQ
	 ld7pCSuOgAvWSiY1KtKRvcMuaZIHptxH5QAU3p2NoKKcjUqP6iULXpn8jsph6Nq+SQ
	 cfXVIMahvDw2V++H0r2RkE2yz4obJzjGb0kGK6XZAeox0flMnsSpL/aCTnyZCL/KfB
	 0sUDUV1/ul0EmJyXqhoDMlUN/NO1cBSDOxbs5X/JXTAj/C4PnLMNFh4i6IxOsVINTv
	 omJ3bFmGnQYIA==
From: netdev-bot+sinfo@kernel.org
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: usb: lan78xx: fix error handling in lan78xx_open()
Date: Tue, 20 Oct 2026 20:29:03 +0000
Message-ID: <179252814326.3290.13906032175458755329@kernel.org>
In-Reply-To: <20261020202614.30277-1-stefanomunari.sm@gmail.com>
References: <20261020202614.30277-1-stefanomunari.sm@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
