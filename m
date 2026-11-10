Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346636;
	b=uioK/UWodyPbhZYO0LJc4cxDuT2rW4rVmdzKTDPTef7akSS7ZUKe+nt/6VUilyOXSmrs
	 RYlsKvYL0sKQ0rmr++gZijrjf/nxmA7Zn1UtrZXVKkeS2mHIhXYBrS1WHEqxJebvR9GGB
	 oCvlVHwojQxtfsX+EAx78kpLnHbKmr/bloOTePjh4uM3hMgClamyilNYJdFNYeerOw7YL
	 5hs4YVheslmPlaJaBhFUpqAhngd6UNUJGmif9jzui32YU6sXMVtc2qI6CgEUJ6NX2YGqD
	 fsWkl2/KoVKqFlobHrLWUqaT4hCpzGBfdng8zOJR7gYidxdJkud80Fn3Ovh7/ahOR1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346636;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dHQLqsEaKr36dBaXrexzXFbwlAmhl8mbH8C+Uh+ZmTk=;
	b=ESBsuo4Jr2Hp0LDthRlPmh8cGvXexK3Xt7tyHM9kYZUm5fHsHDoxpYYIMzn7rkqyX7kt
	 axEhpDcyCINTxAKI3frFvjb//0QzHuXZuzF7+YY+oP+VkEMTdfy8YnctPDM1Te1YaTQFL
	 UEF5HzV2mrjMF4NYjIPlBl9h7jkpEIgc12cWRMsjopRdgbVBVpVY/t3X0eLNNGZpcDSal
	 lqnsII1lKc9mgkxzb+tG6iHdx6vpLUlg4psmLqhM3o6nh4O8k5oTadzpcsSs3ceNpON/O
	 XE0KfwCykwJuYsRmtIqAxfrGKDTt3CZbE9XRLlwePNu4jBDVxQn1vZnd4b7jl+KWCAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/WTij0I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C624606A31C;
	Tue, 10 Nov 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/WTij0I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585E11F0089F;
	Tue, 10 Nov 2026 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346635;
	bh=dHQLqsEaKr36dBaXrexzXFbwlAmhl8mbH8C+Uh+ZmTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y/WTij0IdvGa01fcN+2r8VYM0QcuRvDq9EheuYvkoEErjIYXCeVoHHIrKS/AI65sr
	 4Noox06x31Yz/szrciT85fg02HaDUwTr9lUDEeCovsjEpKgJbyY70JKGmmN4V9oFeF
	 uWP78Khuk/Qg9eUr9ozNoLdCeqYCoyCC5qUVbOHfvw+KYjoeex+aPvWVlfryw2KPB2
	 TatY4lPEyVlDALJYdHBj6qImEOv0XcQmQdHGDEjJZNiriaUt3UxEJM6j5v+8jlbDNL
	 x+i5N+cqelw76VaZEY2mKRpLIOSWSUf9YuWf56wcCA0OHVUV1MVCYxlFdvV79lbG5b
	 X85UkkszueUHA==
Date: Tue, 10 Nov 2026 13:37:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, nuno.sa@analog.com,
 Heiner Kallweit <hkallweit1@gmail.com>, Chen Ni <nichen@iscas.ac.cn>,
 "Alexandru Tachici" <alexandru.tachici@analog.com>, Lennart Franzen
 <lennart@lfdomain.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: ethernet: adi: adin1110: mask the RX IRQ of
 the port being stopped
Message-ID: <20261110133714.5990470e@kernel.org>
In-Reply-To: <20261108-adin1110-net-stop-v4-1-yuehongwu@cmss.chinamobile.com>
References: <20261103-adin1110-net-stop-1-yuehongwu@cmss.chinamobile.com>
	<20261104-adin1110-net-stop-v2-1-yuehongwu@cmss.chinamobile.com>
	<20261106-adin1110-net-stop-v3-1-yuehongwu@cmss.chinamobile.com>
	<20261108-adin1110-net-stop-v4-1-yuehongwu@cmss.chinamobile.com>
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

On Sun, 08 Nov 2026 12:05:00 +0800 Yuehong Wu wrote:
> Subject: [PATCH net v4] net: ethernet: adi: adin1110: mask the RX IRQ of the port being stopped

For some reason CI could not parse this patch correctly.

If you want it merge you have to repost.
Please make sure you start a new thread if you repost!
