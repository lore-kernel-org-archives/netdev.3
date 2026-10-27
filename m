Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105677;
	b=DMd6ihRdXZCUx2x2MhfW9dapZ+LIvIhIlKgsyORovfHoN+iZxLorE1ArBlBZ9hhCZhlQ
	 +UcNI76wHyOz1HR4ZMQ7HrYTGW9E4deiJLYGSEfpWEcRUeR9VbVdzF+QkOcmhaBr0m4Do
	 MhA4J8GC5oD7Yp3dCqOd5rWG4GgjeS3vLfY/T5okO0s9Sa5jSW3Brhzadot1nJfUq/uXy
	 3PEMzi+n8YKpz5NjWZeJBn9PSc2AcIWd5c5/JZZ0V6AdC0lgj/qmxpA1YDU3t0j5b9NIf
	 5nuyJCoIK4TGR1ys4MXKkTJ90b80Sb4/dxvhZ80n4BHJQ364lOJiWyXNiKA39o4pTnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105677;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=w2Eb4Z3/NENc4HHbZuUZ5NK5jd4aIWZeLoSJWD4efno=;
	b=EqNzpocql+z1LMZ3XDDBEihaEycAsXkAkhPJRqLWlFs5IScVkOttuSByy3/blO0lPzWV
	 z0sxB7ijbrfwhIIu+/jQphOVSqRKfMb1x1oyt2aeV+jBPZpqPQcXn5Vpn+BGvjKY40Z4Q
	 ExnvofiMVdrMKMW8v0ahiZcE43ex8s8PtAQQ5+fRjfnNVOph9eFKlWA+pJPon4FB4raw9
	 JVGxDJS9jpwYKKDkPZnFB+FzMpW/BBgcUY7VRb9tYrFfpJ2JHVwUmf9HitnrU23+I5hAm
	 oupF6mvge/dRy8fxtRIHXGv+OrTdLrIroEA7FbyApRgx57/g+HCrM8BpumEpwV3djZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=K1eaZA8Y;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33880606A31A;
	Tue, 27 Oct 2026 12:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33880606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=K1eaZA8Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w2Eb4Z3/NENc4HHbZuUZ5NK5jd4aIWZeLoSJWD4efno=; b=K1eaZA8YgTh9mhQnw0ZSCZX/0P
	JGrl9vy19ohl6MaRxt8V8woOuZ2qREY3C2u2XAsd63RjTNgS6DsiQvSv/Z14G1VSauBX2ZOhKPmwj
	KnlkQz/PrxdvRcSnWXGSrTcqZXu9voEI3iSV25sOL6h94kK+pSu6pCmivaLtDVHrbpF8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLggy-00Cw3M-67; Tue, 27 Oct 2026 13:54:16 +0100
Date: Tue, 27 Oct 2026 13:54:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH net v7] net: dsa: qca8k: preserve port state across MTU
 changes
Message-ID: <47e9713f-815e-4caf-8928-a7ec12d0087b@lunn.ch>
References: <20261022155837.760-1-yongzhao.derek@gmail.com>
 <179268501671.3290.6623232109527554630@kernel.org>
 <20261027092718.266370-1-yongzhao.derek@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027092718.266370-1-yongzhao.derek@gmail.com>

On Tue, Oct 27, 2026 at 10:27:18AM +0100, Yongzhao Chen wrote:
> On Thu, 22 Oct 2026 16:03:36 +0000 netdev-bot+sinfo@kernel.org wrote:
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> 
> The original problem was found during development, not in production.

The point of these emails it to try to determine if the patch should
go to net or net-next.

Is this a real problem which bothers somebody? If it has not been seen
in production, it sounds like it does not bother anybody. So net-next.

	Andrew
