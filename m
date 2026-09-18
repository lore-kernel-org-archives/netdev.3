Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04804509EF1
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746243; cv=none; b=s0w/w91kP+Y2cA6gHKtAm0o1MQPR/HM/g9OcKgOm8i3JE8rHs2OydMJqAM3Xwf0KZHPAy/6893sWNnZJsxB5M+DQUuHJ3JVG2FOoL09riB2vbGyt2NptJHWWziZQORBA7abRv04wPUbhf/zPBGkMKCoRjgM9tVJEllo1GANJa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746243; c=relaxed/simple;
	bh=8wx69PGb4ynzPb+rAgVcJClrWfLLqrYptEoCXnXplaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJpNwc0xMCOQMXLv4kxLPgetHcqOHnRr9hKITv2O5h/O1lUQAF18u2PlQdGhXoHRrh/aUp39Csq70s5SyPrUZfmYHQmP0mtvkW7HQYwSLds/gfc4YRXLzOTYTzJ0mHNxMlZ+ABFfbhZe2NXJKKbXeF+jRxQOf+ZPgnaAcJA5xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbrC5TDy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7LXu03ob; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbrC5TDy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7LXu03ob"
Date: Fri, 18 Sep 2026 17:43:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789746239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/tCweFZSqUOdjVbUkrygSl83cS1eRmnx2NtQc2sZB7s=;
	b=BbrC5TDyVzb+VH1YQgmcp5oiCPRq04G2f/9PYgP2DO9lun/bG+7PG1jcNVFJXSGIL1rTb+
	MNaSKhujiUSSSb+60SiKT9qAemRvPgxgTnP8peKRj/OLixj96a0UhI8CXgD8V6SF1GsXfu
	q8F5L5onKA7Yhp0aMJw31z8otBsuHdWsX8xMeH9nxSgIGJiUb1ggAVi/uFc1xSfYGORwtV
	B2daO+XKXlF/uXgVW8enN2kFikuHNb2WrJURduKV1JNWvctwlQj1ok0/qrZ8cJdAtg5zXK
	6hxQAg3uLmMLBGUvpxXFEOi+rjyLNNUB1XleuKxbOgwtFCkTirxVlMg7KVCJgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789746239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/tCweFZSqUOdjVbUkrygSl83cS1eRmnx2NtQc2sZB7s=;
	b=7LXu03obdnf7j0G8qgo3zr8odbuj/L9UdhYHSP09Ph0d88oO3P+NbjQm2GxOH5+gZQ4s1Y
	fVvs15rW/YjYdjCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v5 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20260918154358.bTSERqD6@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
 <20260527-hsr_ptp-v5-2-158a7633eac0@linutronix.de>
 <willemdebruijn.kernel.92aa2ef1162@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.92aa2ef1162@gmail.com>

On 2026-05-29 15:55:45 [-0400], Willem de Bruijn wrote:
> Sebastian Andrzej Siewior wrote:
> > hsr_create_tagged_frame() creates a new skb where the HSR header can be
> > prepended via __pskb_copy(). This does not copy the skb_shared_info part
> > of the original skb so any timestamp request is lost.
> > 
> > An alternative is to use skb_clone() where the skb_shared_info part is
> > copied and then skb_cow_head() to make the header part writeable. This
> 
> small nit: the shared info is not copied, clones share the same struct.

updated, thank you.

Sebastian
