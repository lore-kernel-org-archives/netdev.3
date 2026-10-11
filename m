Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8243E064
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791721836; cv=none; b=Pq3NxfzS+KrfNvfCwWfs98r4gBSyfz+dUgXvYmMuQ4l5tl6iRtiW3oLBIhweGqR1GDW3LizYNRLTIdK6cfMycZBGP3O8LDTFw3lXgeo+BEDWLF142wC8BjmtgQ7oBCO9Nx0ardoFKt/A0rGwbZ1GXx5a4O67boAZp75tRqUndJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791721836; c=relaxed/simple;
	bh=J03Trp5oPmpx76JyM2l40rzqxRayHRSb7TTx8Iqnwi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUE8B2uPfSm7Rb397I0cz/oarf9aRyiuZQfSVM83oSrrSJi/MOOZzOyzVZBUiSXE+o7AB+ZN8KEE66Hd0ez/qVIgw4NCV7qPtzyoeRxXnzSwEQcQX9lFwKQniC0WPHdXXPyFc3RQaqKVNwZQikE8gAs048tJ1xoklWIfbbfXijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05701F0089B;
	Sun, 11 Oct 2026 12:30:28 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: iugfdin@proton.me
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: Re: [PATCH net 0/2] r8169: fix checksum eligibility and failed TX batch progress
Date: Sun, 11 Oct 2026 14:30:26 +0200
Message-ID: <20261011123026.12896-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
References: <179098478409.1174319.4377246796187959500.r8169-cover@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi iugfdin,

Thanks for your series!

> This series fixes two TX-path issues found while investigating a report
> of loss with an RTL8125D 2.5GbE controller (PCI revision 0c, XID 688).

Do you have a link to that report?

> The first patch preserves hardware checksum eligibility when a packet is
> already at least as long as the padding target. The second ensures that
> a failed skb does not leave previously committed xmit_more packets
> without a transmit poll request.
>
> Neither patch is claimed to resolve the reported physical packet loss.
> The reporter observed 10-20% loss, particularly at 2.5 Gb/s, while a
> vendor Realtek driver/firmware combination worked. No affected NIC was
> available in the development environment. The reporter identified the
> loaded firmware as rtl8125d-1_0.0.7 10/15/24. A possible firmware-related
> cause of the reported loss remains under separate investigation.

I haven't tested your series, but without it, I see 40% packet loss at
2.5Gbps on the same controller revision, when rtl8125d-1.fw from
linux-firmware is loaded[1].  Forcing a lower speed of 1 Gbps work fine.

With that firmware file moved out of the way, i.e. using the built-in
firmware, 2.5 Gbps works fine for me, too...

[1] "RTL8125D breaks at 2.5Gbps"
    https://lore.kernel.org/CAMuHMdXPAeHoeaQbM9rXbXukoMbFV+0k28n6sRMw8XF8720WUA@mail.gmail.com/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
