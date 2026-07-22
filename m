Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF7368D4D;
	Wed, 22 Jul 2026 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731372; cv=none; b=nTW0Ws/ccURFS04ruOWzzGEK6QF9K4d2kllzRnf/o+dYlpUAazuQ6ptY+KBU9E18pnHc4UMKt4/OxGBa2cMuUWkyr/tHYUNXey1VfeI96Y62Vq/uFj1tQiAXYWcfWcO7GipGvYu7uTt6jUUgV/P1EwH+MQSw5wPZhebeiYMS23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731372; c=relaxed/simple;
	bh=0eSy7p26iHMPo22xtyM0VZCgk36/FxfA0Sd4vzmm5F8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxNzNgonHgptt7VHBa56PxoZ+YzQWJne1A361Hq71NPAZP9Sw2vVepuUGDQKv/JWCkuhXR4Z/byhQN6CyH12+zK6RwTaM7hHe4Qgg4JAG6rj2C6z2SdsjtBksWWlvZ5X8ph7YHD8kjo3zNpVI+wQceHqys2TsMYTWu4HlaNJIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbkBPGLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbkBPGLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138511F000E9;
	Wed, 22 Jul 2026 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731367;
	bh=HfA1OHyoNK5FzbOdJuHu4i3K9EKRHzDoufrZr64MOwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jbkBPGLaDX3JXiyqNCDIBxFixmmYl6VfPzw/C9jgOh5v8WVqY3cc7Bk3idYic5Wa4
	 v6NRkglYIjHt0eERQ+LrbHILNxnk7r1778vQLqne4u57+JzedVdTtuIBPZAzvt930I
	 /AQaK/8O2rmiWEoBN684qf9YOwt432F5DuUHpZ1R/rL61P+/nFO7Ay1XJlREEyAjtB
	 CmflNnxCqRthkHKaalM/qyKEr+wPAQGVK8hJIhHZ9gIOrhEh7kfDlKwYNOrYNJ7FDh
	 MI+TIWlXOuBcjx4Qsi4XXX1H3uyZqcR40TxGNVzNk9QHWmsWjFI/JvOIAjABnlZ32N
	 DLD3Ft16eRePA==
Date: Wed, 22 Jul 2026 07:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup
 when opening the interface
Message-ID: <20260722074246.689401d1@kernel.org>
In-Reply-To: <20260707195425.405989-1-stefan@agner.ch>
References: <message-id-of-your-v1-mail>
	<20260707195425.405989-1-stefan@agner.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jul 2026 21:54:25 +0200 Stefan Agner wrote:
> Since the referenced commit, changing the MTU on a running interface no
> longer disconnects and reconnects the PHY; __stmmac_release() merely
> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
> is not enabled. __stmmac_open() then performs the DMA software reset in
> stmmac_hw_setup() before phylink_start() resumes the PHY again.

This patch is 2 weeks old now, which is the time horizon for most 
of our systems. Please repost if it's still relevant.
