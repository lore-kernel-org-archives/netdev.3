Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835CD493627
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431866; cv=none; b=MVHTU0euL6f8rbRRl2ymfRRNCl61E9zvePkX4YIG3CA4CZwLcTGQVV+2pqfRJSreYLNGFi5v5Vqe8Ed7ptlBpMsaHEwmBkFZp6FkzcEj1bpPUnxJ6NtlsjtIWHVjy1MyXq8Gh6Fc07/vWf6FcY9DFkSzjE9ehuTq5+2leLxYebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431866; c=relaxed/simple;
	bh=7iG6WDHvO/dcMgmtK2SsHJU2hik8vECHICn0V6F49zM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvsKoVs6t7iMDKJWLIuVLOxYG1HhcIACCreUwOM4vu4xxyLuaDrArO+FQDB4ulOEeyfkrkzo5CA5hM7XMya+i8wVMok55PWqFSUe6d0tpQduCVz8JOyCQ4BMtYqVzhhr1xgU9FVV5bfiEAQ91uvdSNDI1hpmHohvhfIVeqKcSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTeWpoI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTeWpoI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F21B1F000E9;
	Sat, 22 Aug 2026 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787431864;
	bh=kCNWFGT83mW7OgSsVZiAoeQGNFonxbot9+TzH4r5J3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lTeWpoI8Dz7xVYVadfea210hh6nnhGR7P54LFF664QZu9VVwpXH4yZh3whrQeIVxj
	 T7jSbsW/WSmqHisnsaTAY29kTkZyBIdmbKBWcFZhCqKVnwxlb7QNXZmu0njeInkrxo
	 04fa+eAvUu4XmlnCOA8/IfWmIQj+I2H+GppfbXpv16gspM0sz8Dedjk+zymjCcf/NL
	 krsuYmNVoPzxKfoeujGMxff4GYUpHabLAJDfa9DfkFgKpQt/PByjJ0V45ZVaspSxs8
	 UKCwz0YjIzoPR2WvNWwJ9puYS/EXIs5GgXnpgwUC8bF39i5qx8inAK24g2aWQSrdUU
	 f4xgfFt6NOCIw==
Date: Sat, 22 Aug 2026 13:51:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Gaylard <ag@ffroot.co.za>
Cc: netdev@vger.kernel.org, wellslutw@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: sunplus: fix tx_poll spin_lock missing irqsave in
 NAPI context
Message-ID: <20260822135103.6711ba25@kernel.org>
In-Reply-To: <20260820130159.1584806-1-ag@ffroot.co.za>
References: <20260820130159.1584806-1-ag@ffroot.co.za>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 15:01:59 +0200 Andrew Gaylard wrote:
> spl2sw_tx_poll() runs in NAPI (softirq) context and acquires
> comm->tx_lock with plain spin_lock(). The hardirq handler
> spl2sw_ethernet_interrupt() acquires the same lock, so a hardirq on
> the same CPU while the NAPI poll holds the lock would deadlock with
> IRQs disabled. Use spin_lock_irqsave/spin_unlock_irqrestore.

Please explain how the issue was found and how the fix was tested.
I mean - this is an ancient driver, if you don't have a way to test the
fix you should not be sending the patch.
-- 
pw-bot: cr
