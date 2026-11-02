Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637616;
	b=pCw4xXPN/802n+UwJuEFrZUL4aurW6guNDhv+6m9DzdI2INegysyAL5ChDttNVJNpJOF
	 Rl89Qvf/SynZ6zxM3trI6h9M2E9yEDnpu9v2mo7S45egauOWbmS0S+S1hUpNltnoKmlCZ
	 fvukOWA92u1xgoS5kRp1y4yhjOSlCdtqZ9xS1CAvHUKqiFl6YLszk6HNP4h2JSMSdI/jG
	 Mpv5/qB0RoMaAq/kLliV86WxmX8JVWHdGu/oLSMuYXinbxpf2Q4DvHm7O7lZxpj3uGd7E
	 k4M1p8+O63565vLjlTgHTe1/LTnKG0YE09kmJzfmvHsHbjz3c/V7JCO8XF8xzo68+vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637616;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DkHgal0b82z5KPvwqWkyhs8Es3XYDe2wNpBo8Z22Xe4=;
	b=1hcj4mVjsyAEiws1s5AwT5Se/VL9AEjgqYweI0cTXAMoPB4Hw5wWd/NoJD1QNWplxzKj
	 9Q9TIq+NyW01r/FiCUB1MtyxDQH2RJa/4ygmZey62Ude21iMauu3cWv65B1Ld1+jFOPmm
	 TYlxD5yN7C2/hdq0/lJUqBBVBYuL9TqRu9ZRRZUUOaGya5TnE0cR0AcjqR+N+bQj9XWDK
	 Lajdwrbv8cKJm2qbc6nYXd5FpUeSGmqiOH1GJhbPI2JhBlVlauGnCBlpGZSwrWna8CyWX
	 OtUYTfiL7qmu3sJF/zpKoNUplAE87fNQ2ZhIB9degw6N61Rj0u6loAvl5kB0t0xY3Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=U97dZExR;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC14606B0FF;
	Mon,  2 Nov 2026 16:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAC14606B0FF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=U97dZExR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DkHgal0b82z5KPvwqWkyhs8Es3XYDe2wNpBo8Z22Xe4=; b=U9
	7dZExRHAFKmBqkf/WS8CqhY7/DyHvZftUHM7ZMQ3dS66uwf2eHCczuYxWCs4Ki8HYbxr1XJWIY0QM
	5QSuXzlOII6oweMasRVoDbbN+SyOtjuRRtgWS8PH/wpz2PZIw2vZ2g5uVyuXPwZWDEpgQ1QDxwydh
	KsPh5JQkINZ9W4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNv4o-00DpZV-Rd; Mon, 02 Nov 2026 17:40:06 +0100
Date: Mon, 2 Nov 2026 17:40:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip
 reset
Message-ID: <d45e15a6-3f15-48c8-bb6b-901a094ca990@lunn.ch>
References: <20261102101125.3523835-1-mmyangfl@gmail.com>
 <179361442917.3286.13140295265370118734@kernel.org>
 <CAAXyoMO5qCcnMeqqHM1CC__FPMnArOadvmCtoAzYT2SDhSJDEQ@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMO5qCcnMeqqHM1CC__FPMnArOadvmCtoAzYT2SDhSJDEQ@mail.gmail.com>

On Mon, Nov 02, 2026 at 06:20:52PM +0800, David Yang wrote:
> On Mon, Nov 2, 2026 at 6:13 PM <netdev-bot+sinfo@kernel.org> wrote:
> >
> > Hi!
> >
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> >
> >  - Whether the issue was actually triggered, or is only theoretical
> >    (e.g. found by code inspection). If it was triggered please include
> >    the symptoms, like the stack trace or error messages.
> >
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> >
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.
> 
> Reported by sashiko

What is also interesting is that i expect you have tested this on real
hardware, unlike most of the patches we are getting at the moment. It
is worth pointing that out, it might help get your patch merged
faster.

	Andrew
