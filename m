Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C6491B12;
	Mon, 19 Oct 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420930; cv=none; b=sK/FO4Ix6Hb9TCfe0ddqrynXFV7UzF0jZuhKWqJoh/w3yfHkxTP/sbaEJFFTSoDO2aoH9zKZ3lyNRay2F7AgELFB449lgtkD27bUNeXtHO3pIiSfqpgx/VbO6f+jMZpzI/wyBV6eQVC6R2KReclpeRtQufb80SP/H5a6TWyRvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420930; c=relaxed/simple;
	bh=+CcE//8LwHV5giiOzprhXnBLjNfbqHe6aALXRB3Ow80=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=oZpm9DMUNqO38jmObRi41HdToJlxjB6rAl/cMTLbf5MLAxifPq7MWeeQXFI4bAgs2bPinU9WX+/96O2laSBB1ETlv0ZJIM+Z/JespVFNQpn/tSQa9UwWF/eOWx5NH6oWJpcvpmRn+PfEIuwQxIN7t/7e+B/eFFIuj5zcfMS7mRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=n8aGCNXm; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="n8aGCNXm"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 354A4A156A;
	Mon, 19 Oct 2026 16:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792420922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gdPAFwtkiyGOrrmpDJKuYvH8c98AWepp1hYqr6NQ5+A=;
	b=n8aGCNXms/uv7CzfapYewb+6FNb5I6XxvEM2THqbJ+0eVNxdgBR1CdLKSwAiP6yTZtl/+T
	BiQqHZgfXpvS/NVyOU+x9fYvXTl8J12rfCsyzJmNMvgf2INH5/p1d/4S6eYV3h2jcQEj9l
	o+84ZZILEiA1SxvgRTuXJUt2fvcPfJClCXVIpnSDaZHosUzqijz3rUU12HJui/Fsu0yAXN
	7jzCW2uzfRSZCfzjayRdU41IZp0mee9yAWAwg4xw6oOzsA5Lui9jZFpYEJXTTSYPv7P/Qm
	6BLxQydaKShJXXDOQt3fMgc/1q/5/coEb+FuAJ4cbj0GsgOqc0ysVXApbKaD5A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 16:42:02 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Mikkel Eskildsen <mke@visotia.com>
Cc: Oliver Neukum <oneukum@suse.com>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [BUG] cdc_ncm: soft lockup with netconsole over an AX88179B dock
In-Reply-To: <PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
References: <PRAP189MB185019A5A8D411482BB6E0CDA9982@PRAP189MB1850.EURP189.PROD.OUTLOOK.COM>
Message-ID: <6aaea20ede0bd16a5138bc126f3ec897@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Mikkel

On 19.10.2026 15:48, Mikkel Eskildsen wrote:
> Hi,
> 
> My laptop panicked with a soft lockup on 2026-10-16 and again on 
> 2026-10-19 while netconsole was running over a USB dock NIC that uses 
> cdc_ncm. Both times the laptop was docked and netconsole was on that 
> interface. I have turned netconsole off for now.

I was able to reproduce the issue with a similar device.

Seems like netconsole holds the tx lock while the cdc_ncm driver
lets pending network work run in the middle of the send.
... which then starves on the lock netconsole still holds.

Below is a patch which hopefully fixes the issue.

> 
> The trace below is from pstore. The netconsole thread on CPU15 is in 
> netpoll_send_skb -> usbnet_start_xmit -> cdc_ncm_tx_fixup. The 
> spin_unlock_bh() in cdc_ncm_tx_fixup runs pending softirqs, TCP RX 
> sends a packet and it spins in sch_direct_xmit. My guess is that it 
> waits for the eth0 tx queue lock that netpoll already holds. The other 
> CPUs then wait on the socket lock until the watchdog panics.
> 
> The first panic looks the same, but pstore lost the part with the 
> netconsole thread.
> 

> [...]

> I can test a patch if that helps. Is this a known issue?

https://github.com/nbuchwitz/linux/commit/319cb0933e2eaf984b98906ebddb55befb4e2996

> 
> Mikkel
