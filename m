Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164A39FCCC;
	Tue, 18 Aug 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066779; cv=none; b=WELbwMcawc+MgkfqJnysYG2MEjc4yhsg62asDM/LNN4s36M/0EAcB2awhcRcsMC1k8Jif48h0e/9yR0olP4xabWSZBe6f1YTkGmkHyA8Prb1hqCngIU8ZLooao4OMheU+H+yA2E2KenmxEJx/tutM8vB9vAcPIqqq7a48qIyMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066779; c=relaxed/simple;
	bh=TXX+6jWVEY/QRieH4//NHVwz5Hxn4WymfvXEiJvqczA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKCC47hHc37zvKZ99WMbRVa8EwlQrPLUbkIYBpr5gmnpmgwpLfqUK3utuHVKqTfvD4VxlNgVjAMpIXJJ2RjXeGH17TSs/y1HggmgsvAd6aSGone9wIyn+E4rtMxvu5/xr+C0iA9Q/ohXgSBlP/bOJCGaOJDKmDqn+6I7Tvnz3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqovvOS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqovvOS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C1F1F000E9;
	Tue, 18 Aug 2026 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066778;
	bh=TXX+6jWVEY/QRieH4//NHVwz5Hxn4WymfvXEiJvqczA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UqovvOS41UEmrSpHr9zkK+MwHTz8uc6Ds8YNByny9mtCWKIx66GTiGfqHs+oKnZ6b
	 zsMHiattG0Opg/377vb9LuZZPe6HbTzM9pZps3hzKnrsQpoRW4zPNOLJt6uxoLsG4U
	 C/iGyCc6uYS2irxCLLZ20eVCS5ScpOoOR3JqRm/9o3D4Q5UxZdEHBd7704DanNBmVe
	 U6ET1Mk2RMDdz7iTm9VH46KgpPTLtRZ9B0HRhEl/KIvffpiLycqob4DJ1xDuDWa0fR
	 XDBgqsZLsDORWfwAqkn71AhAgsZBz5n+HVRMfCBrEPNan7wvz5gc3xGv7YtElEwasS
	 Yg97mmPsYD+0Q==
Date: Tue, 18 Aug 2026 08:26:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v7 03/14] ax88179_178a: Split driver into
 library and device specific code
Message-ID: <20260818082617.59511c4f@kernel.org>
In-Reply-To: <e72d0d5e-6368-46eb-8247-a760046cb8c0@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
	<20260810-ax88179a-v7-3-da633191c129@birger-koblitz.de>
	<20260817152800.3dbe9f55@kernel.org>
	<e72d0d5e-6368-46eb-8247-a760046cb8c0@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 06:51:32 +0200 Birger Koblitz wrote:
> I was not expecting a review while netdev was closed for patches, btw. Am I right
> to assume that I should not send v8 during the merge window, or do you prefer the
> next version to be submitted earlier while everyone still easily remembers what this
> was about?

Please wait until after the merge window.
