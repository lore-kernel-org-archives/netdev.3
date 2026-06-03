Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051971DDC3F;
	Wed,  3 Jun 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452708; cv=none; b=s7bBnYdOLF25+AprjIXCIoJR3J/2hxI4sxg0IV7eHMjnqv/VIgltlnleN8rf3ahyoH9Q6ePfrHm+4U4NYySOoOK/0rjLIT63VUM2pHsyE7CgnACgNa1fdc/sHhdMhkeTtv64Btfxk1U5v4ZVkUalrSq/BxdM2QG8Myc5WDWn+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452708; c=relaxed/simple;
	bh=voVZx1GIudpGX0AGo7GPtPWorlvJMKRTYdDmaZd2AhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKlCypnXqZ7ewb9AUN4zyMrTRDbuRq9ILiPBrqEl4EG4QAzVgx41QhtTqn6woQ73o+mc/ME8W9+EW6LMvLQ2IBQm8JwhXDIcJpWRbTTiR1QzZuGJ4agVofnLLj6pNGzb5XYsFrk3GVeabK8p/WvZcRj0jDSzPm0+SESoaHTVV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIhK7AxS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIhK7AxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B4B1F00893;
	Wed,  3 Jun 2026 02:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780452707;
	bh=2ZnF787JgdPjtfwtyHh+h25jAvQi0FoshaX+J1u/6x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nIhK7AxSMbDx0ECI2DO6OECw+1ErY0dTDMXIVzqNxbMGR8TpVrYwfl66eaEuanttd
	 03ViQVILVlM+lyWIomgHYczR/FQXqQLkEGlbWCk5nHJ6x0JDcRd3EGmqlVthpoDHTD
	 E+cu6+eS2vDjRx4LIpJccCI8zCJKcXJe7/99SY/4jaNhHgnwRspcgEgZl1OVqrTmwG
	 MzkYkZrme3DUtFTfz6bD4S9qcUM/dSMIx/tStmXC2OhhkT8b5P8MiKr/Htnf7g7sN8
	 5oH0NAH/52qrABOfM9t41EBX+x1y6oVg255DFUiZgfrTLss2ghiPbCqO00ukTEs+/R
	 tKo273gB0a8Ig==
Date: Tue, 2 Jun 2026 19:11:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, ernestas.k@iconn-networks.com,
 horms@kernel.org, kees@kernel.org, kuniyu@google.com, leitao@debian.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] llc: Fix race between sock_orphan() and timer
 callback in llc_sk_free()
Message-ID: <20260602191145.3deea6db@kernel.org>
In-Reply-To: <20260603013007.1171695-1-xujiakai24@mails.ucas.ac.cn>
References: <20260602133002.3ed70fc3@kernel.org>
	<20260603013007.1171695-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 01:30:07 +0000 Jiakai Xu wrote:
> > Sashiko points out that there's more issues if the timer runs after
> > llc_ui_release(). Can you reliably reproduce this? Have you checked
> > that this change is sufficient? Sashiko says that llc->dev may
> > disappear even tho we don't clear that pointer in _release().  
> 
> This crash was discovered by fuzzing. Unfortunately, the fuzzer did 
> not generate a reproducer program, so I am unable to reproduce it. 
> Our analysis has been based entirely on the crash report.
> 
> I'm not an expert in this area, so the quality of my patches may be 
> low. I really appreciate your patience and the time you've taken to 
> review this. Would this V3 approach (moving both sock_orphan() and 
> netdev_put() into llc_sk_free() after the timer stop) be the correct 
> way to proceed?

Not sure, feels like we're trying to fix symptoms instead of addressing
the real root cause.
