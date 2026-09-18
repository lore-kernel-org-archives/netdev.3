Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF24F96A2
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746148; cv=none; b=Uqi5TL/D56tSU+HTMgK0CA3SuxlCTrSA+b4AGFdVQmJTtA/WtDu1EJI66BNYSgHr/8ZacmT189vKI5Y4qGoIVeojm4kf3LGwUWnSTiEw4bWyXCcutUjJ6dFdx/wOZhIKpY+x9vUCkFVhiNh9rTeibfH/1HuTVDW++EfdcLcPkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746148; c=relaxed/simple;
	bh=eZ4SEhWZEANKJF1J8OlfXLUVf8J1yG8ZB50AVH4RbSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfjcLSBZz1KK/ZNX5o3uU+yBuBeBBC+/nbbGVQNLerSlJ6KlVk1zmgULjVzUTaKcLjkKxMu5FUNG+dw+Up5j0iE9f7kdeaEo0IA3zk7oYH3zt7SAswyhKEiAHSbvw68iCnvm05iNcr1ulb4jpHyK0rAxshNW3v4qUAGqgZSrHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BmiQFmvm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mL/6gPnY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmiQFmvm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mL/6gPnY"
Date: Fri, 18 Sep 2026 17:42:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789746144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxgird2Q5ZUW3dRfSovefzpKGs+nBZpFGtw4evyDFnA=;
	b=BmiQFmvmEm/Oa27UQkWWIAEfkV+VGP3AzJ/6WvPTBM+FdKkm1tOLv4e7tufoRYMM7rc1us
	5LLhDlx1tLwrFsXJAqZxcmpyXN9B48hfuTzAHx9UUS8FXJL7o9QPFyfKa8IZjF6p31+Z8S
	hgz8WfJDLakAsjnzu3SOvjEWs3LgtEOazMS4u4TO2ch89RIVHjIrWas/qBzCENlzQD17E1
	LyFe8WxL2+O9YSz3plX/RiaBtAJ/ItLNk1YhZrQzmiKB1aNzTzvFd5OGTXzoGGBoM1Bk6y
	C795TN1Zy4uMpiheDjh6CCY6N9vbnzL/ckRpMlhocG3dHPZPt1T9qnT6ZfKRRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789746144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxgird2Q5ZUW3dRfSovefzpKGs+nBZpFGtw4evyDFnA=;
	b=mL/6gPnY9FXg0zxeKk+bshWQpL/FzciOblFyCCUGx0KSWA/OjouN/0yKyCgJqgoJp3Xghm
	RJSXaUprkm//5dDw==
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
Subject: Re: [PATCH net-next v5 1/8] hsr: Add header_ops::parse_protocol
Message-ID: <20260918154222.8Emm5vpm@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
 <20260527-hsr_ptp-v5-1-158a7633eac0@linutronix.de>
 <willemdebruijn.kernel.1794b95d53a30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1794b95d53a30@gmail.com>

On 2026-05-29 15:53:06 [-0400], Willem de Bruijn wrote:
> Sebastian Andrzej Siewior wrote:
> > af_packet uses dev_parse_header_protocol() to assign skb::protocol.
> > The hsr stack does not assign a callback so the field is assigned to 0.
> 
> It does this as a last resort. It is preferable for set protocol.
> 
> Either by binding the packet socket to a protocol at socket() or
> bind() time (but that affects which packets will get delivered to it),
> or by passing msg_name (of type sockaddr_ll).
> 
> That said, good to have this backup for senders that fail to do so.

okay. The socket is ETH_P_ALL. Passing msg_name would work. Since that
backup path is not objected I keep it.

Sebastian
