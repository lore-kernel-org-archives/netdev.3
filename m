Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551702;
	b=oZEyt71fNIv1K/petpXA+N/rO/8EK1X6S/DBI1tUO7nU5ocqsI++9wjO8f3hIj0f4tjv
	 I+HgLzG3PEDBa9YtisSP5Ae/tbk2E/ltxAU5C4N1EYfkrnKzP1rZvE3dkIg39fngdcehw
	 sqfQbRI1hIaTDoCyxC+g8ZIaRx9f4n2+BKWBz+V4cdNneaLKuGURDTfLb6JloKYk8+K3P
	 3gAclVguF/XaB7fk4CXEtmeNVONl5KqWpKHp6FwCGlOXr9TXLpP93Yf/eyt5bZ0noqtYN
	 9vD0ZQyohbcJp9y8r3ESbkBBMykvUGYpLcr7UoDEyuWG4b1GzooZzNNQO0/RYH7rEqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551702;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WZaqyVjDO/h7wzGQvvWD7CYnwzds3wygpa07dAtlt38=;
	b=CIoVwynDaXBw6j8yORWflCuuirh4YETTC/uYutmfmfX8ETdpNU26r+bfIq2E6oCZXwhf
	 IoOUiYHbat2AzBsFc6cIpgqzaHSpmqBoKk7x3IlEhI1GxC/jsIwalvl1r+X6eCCFbtIO9
	 N+6NTXcjvC9lHlxKsqbnudJ8X5IsjaTHA2oU4dZ8qIzo5OrH9UE+M/uGLWbRuGVgPtuKk
	 iEEeZq8U9G+sjULDyz7gVURde+v1B/3PtIoTVODJTE6+2AKew/Mj+OioYrv9cntjGKUqr
	 Ueb+dzsUjJrLKvqkZxyQgXv0Wf4EY1lzO/2QKlV5tD7NrGFOFudcOiogrO0sOYxuzEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsthJ5n7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E4606A31D;
	Wed, 21 Oct 2026 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsthJ5n7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1B51F000CB;
	Wed, 21 Oct 2026 03:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551702;
	bh=WZaqyVjDO/h7wzGQvvWD7CYnwzds3wygpa07dAtlt38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WsthJ5n7CSYcT1/z1Fd9Wk8I/lRDENdtE8pjdGU5jw+XmG2Xio4cwk12u0jIU8jPU
	 WT10hNUwBg+n5YM2mrWe+MuD76jUhn8I20r1EdV0KsWuQ2aRc1hJAMHS8pGVkNGtxR
	 HvvHk7SyNHmmWDZ9q/iDlQ91a597/YIdgri6pW/guWyhQOJL4J2vGS6Ga9aMawzkBL
	 L8Ax/zboJXcX+2CuofczqDjnAm78JTsdHh1LDBOELdBQ5bwszq0T1hFuuaDryPE4KH
	 IpO2GotPxxe23Yr/Lc+tlsYjsSxp9toVpvHrdOEEn6AE/cBVQjy2Rvnkrd7MzWLsuc
	 j1Fj1DW1ohmMg==
Date: Tue, 20 Oct 2026 20:01:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Sviridkin <f@lex.la>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Eric Woudstra <ericwouds@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: air_en8811h: use firmware loaded by
 the bootloader
Message-ID: <20261020200141.7e717f10@kernel.org>
In-Reply-To: <20261017180251.3618606-1-f@lex.la>
References: <20261017180251.3618606-1-f@lex.la>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 21:02:51 +0300 Aleksei Sviridkin wrote:
> +	if (phy_read_mmd(phydev, MDIO_MMD_VEND1, EN8811H_PHY_FW_STATUS) !=
> +	    EN8811H_PHY_READY)

Line wrap is too ugly, please save the result to a temp var.
-- 
pw-bot: cr
