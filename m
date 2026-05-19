Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467D256D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150175; cv=none; b=IVPrJs7/WFUm07sk49kbFwIyqfiFziY7TvSyKuPrjMftKbinf9apT3xlcsfxlZJPQVtBt1qQeJ32IKQKLiRP1Ru3Qno6aTq0ucDTET85/mHju/yW6DuKw8n9pwkBzTYogPoe6TGlL0IlhcVLuQqaPWYGaqeNEPkhfSvgSXIgvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150175; c=relaxed/simple;
	bh=Iws5004BgHwoCmT4F7XTtJrQISpYk0ea6+c2e385HeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAPSEx2ufg+BomwPrc53DnQBzkU9wnaleGl0DiJQJqcVcy6hk6NVeW4A42tPO9CZRit8xDihNPGTz7SE6Y1PHRDGOwxR2l6sm/0HbC9nmmFlaT4of8uUZoDcPRGAWumpo24E86gVKQH94pW6nCqL8QmcIO9GeeLhG3ujLnhCnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGgz6+v0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGgz6+v0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04987C2BCB7;
	Tue, 19 May 2026 00:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150175;
	bh=Iws5004BgHwoCmT4F7XTtJrQISpYk0ea6+c2e385HeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UGgz6+v0lxkYM1prWl8yYiUP0TIinVyV/VJbxih4Rws7AJKXmoaidqQ/6a/2epDWo
	 JgNQC7rINVuKr46JHDxal6uC1c5zq+qIgx1siwlBiwnmb4k5VV+9hVsY/pVOi6LTSW
	 NhXGNeUXqfyrT+H4zV6T6aJ0yQPAofJ+YNSi0sXlLlyLc+HUn19jfkOPSKcBKx/ha6
	 kJ8o/ZX5YtOoraNjEjgDnE3N5HVOgdfIu5HvXPla5CDsko1I+syZ8hl8iVAVBx0dNp
	 zKxJUDm4X5yZ6L6hV7ulzjcQ8QeD75vfrXjA0y3bk1OZoTm/XijKRhgwN38bBUjWFS
	 dw1GBdS5xf2iA==
Date: Mon, 18 May 2026 17:22:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 5/5] ionic: Add .get_fec_stats ethtool
 handler
Message-ID: <20260518172254.4163f226@kernel.org>
In-Reply-To: <70a655a0-4e43-4b8a-8e7c-f4436e2a8f1f@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
	<20260512224421.25236-6-eric.joyner@amd.com>
	<20260514183209.48fa771a@kernel.org>
	<8fb773c1-411a-4b61-915f-5111210abe1f@amd.com>
	<20260515160223.1a6b62ea@kernel.org>
	<70a655a0-4e43-4b8a-8e7c-f4436e2a8f1f@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 17:06:25 -0700 Eric Joyner wrote:
> Sorry, what I wrote should've said "there's no proper/good way to do this by
> only making changes in software".
> 
> You're right that the firmware knows; to that end I'm almost done changing the
> firmware to act similarly to how this interface distinguishes valid statistics,
> and have the firmware report "-1" for these new extra stats if the hardware
> doesn't actually collect the stat.

Plumbing Linux hacks into FW is definitely not my favorite :S
The way we use -1 in the kernel is a local hack which is never
meant to escape the kernel.

If you want to do something similar with your FW - please make sure you
add your local defines, and code which _explicitly_ interprets -1
coming out of FW to the driver is "not set". IOW don't user ETHTOOL
defines or assign the FW-reported value directly to the uAPI stat.

Otherwise, if we change the hack kernel uses to distinguish "unset"
values and ionic would break.
