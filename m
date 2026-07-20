Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA479356759;
	Mon, 20 Jul 2026 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590440; cv=none; b=mXv9+6M8jiup/Utsn5RE97vWvIZFGh3Ell9ifDBFqvF4aEAVqWawkvcoUEYy8CIloCDwDNhJqnKxFzzFm3PU/oDY9AW87TewcIOHMrAoodJTfaXOrB/uur5lgu0GAuyjm+20z1PE50hT2+Obvv24xom97R0iUQFL8MJ5AuQeP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590440; c=relaxed/simple;
	bh=xujS/y5Z0yTQwDePNjRKdptzQgfvyzfAfmsNg5wJMYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWt07vm/Z0GUtUagy/Q/EgWceCpUKX1q0KLD/CuDYD3JD/rabTfZ99I1Uy+jIFVfTBgA25veuAeSj3Qo1T6yBSPz1XK/uXELfMjzdDv5JwRnKcDCSiBxLwpMXumPrV86JJ0GmkpjMYbHtnQYZW8K7SFxsvmBZAcmFHFdafmlVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px3scHjl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px3scHjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B601F000E9;
	Mon, 20 Jul 2026 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784590439;
	bh=xujS/y5Z0yTQwDePNjRKdptzQgfvyzfAfmsNg5wJMYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Px3scHjl1kScfZ9sUh+Ieps6PnPwgWhkzSCPte+hbWhPz9Vso7mI3IkZ3V7JAyl8U
	 HpqljiZBCwr2FKV4TVdJYkB1moil0q5O5Oq2QNgX4XIMdjbcxYJ0CvhIOh9vIMoqM1
	 5SREFhQyGuFSMv4ufvFRD5l0JyqnZfwxaIaBzYwrLHhsWn5R8bce4khpw1Bu4IECul
	 8gGepE/L1Kb+NX5jZ+epyo+WCn/1T139H4P2RGg3BOIqD9HaBrLArQc2QbuOaKJp5Q
	 p0a7z29ub+oi2cy2wfiVvqFyoFp77loahguCT8Fc4qjZ9f4d+S+SKIJ0Y89DpGsjdh
	 tv7mj94FNtSZw==
Date: Mon, 20 Jul 2026 16:33:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: enable SGMII port for
 KSZ9897
Message-ID: <20260720163358.27f30ba4@kernel.org>
In-Reply-To: <20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com>
References: <20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Jul 2026 06:37:28 +0000 Tapio Reijonen wrote:
> The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
> entry never set .sgmii_port. As a result ksz_has_sgmii_port() is false,
> ksz9477_pcs_create() is never called, and ksz9477_phylink_mac_select_pcs()
> returns NULL for port 7, so no PCS is ever instantiated and a
> phy-mode = "sgmii" or "1000base-x" link on that port cannot come up.

The netdev patch queue has overflown, if this patch is necessary you
will have to repost it.
