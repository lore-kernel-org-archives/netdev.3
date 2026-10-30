Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390337;
	b=4O36e/9Jho4/jDBZyboWUsWPTtWezzpciMqsubJd/OcSZofGTCQGUlvAgvzq1mSZP2Ux
	 STHYR4NDaOL2mNWTbTaOJgLqvJNKmYy0e3AQn+csgUYJ9j/vcA1ZGg+O6RAtytpVOk2z6
	 BAc0OIscoHIYKEls1Je7PHJ6TT3kT91/op/j7Uxn1JpftnVPqHqpfZ1OraRbHj6fztUvX
	 sSAYOaAjxWI7P8iAj0vhSbk2CnqN8I6DH13zF1QcOMnCLDwRolQFBi+l9nv8SqFC3lRX9
	 RmoobjSrGQ6ioAp6xuG0MBLX3qoOKuIoCbXO4k3WxxDQMCf2AdtzjpYSr4Bhw0KFx6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390337;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=5qjG6i4xA6DIkXt/Q+KGqoEk/cGxbTWM/nESsvws66E=;
	b=sWFPJqtSaplkK3Z/40U92lK/TeH01ZQu3M+wC3RDqTpMXkDvXysT4ZWEMt30/CItUFn5
	 6etdhcjfydccLygy2+Skv/ehk3EEOh7uc26V8oo40wj5qnRiCOKy8i1fVuCtu13Elx4AU
	 ENgtmKb/wuVoGwIxd3YoVMNB0lfuythlpzaostK6zFKDr0LSVvIH3prW0ctIkC6jfBvzN
	 rzI6ai8k/rBHtWJ2EGc6UjCUTmTlWxzZA0IIitVeF3GyXS7ivJsWhqU+Rq0u3gTuHgD7O
	 A+FEynlBXzSpLJ5E4nQFbMMXbZ8k42FMZbqGymvHePvpSAEMuzIaiBfIL0Fcu83kqsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=tF9I+H8b;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD21606A31A;
	Fri, 30 Oct 2026 19:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD21606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=tF9I+H8b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5qjG6i4xA6DIkXt/Q+KGqoEk/cGxbTWM/nESsvws66E=; b=tF9I+H8bbSgAY2bbDjP4HqepXx
	GKNBo50OqY33VXHTbynu4itMCmuk2ec/eEJCiD2Tty6O7EACb5j8O4zlkAnu+a+j4g2WeJE128qQK
	QsYPnomF2nwvd6sWmI6cFPk4EE26Qa75VAoh4qWevfA2/XKSqIzl+1ewc26X8Pygl9Q0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMskI-00DQZ1-3J; Fri, 30 Oct 2026 20:58:38 +0100
Date: Fri, 30 Oct 2026 20:58:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: try to force agents to disclose info
 for fixes
Message-ID: <fda901f6-5ed9-4a58-8e8d-da36b2a61dfa@lunn.ch>
References: <20261029153459.2257998-1-kuba@kernel.org>
 <9A74CA14-D4C0-4252-A3E7-256F9626B513@tipi-net.de>
 <CAMuHMdVJVxpX6OLVpE9K9CDY5q61A2rFGf7FpUjs7xpFwReEzA@mail.gmail.com>
 <20261030093418.2fbf0999@kernel.org>
 <20261030164758.GD2673734@killaraus.ideasonboard.com>
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
In-Reply-To: <20261030164758.GD2673734@killaraus.ideasonboard.com>

> Tweaking documentation in semi-random ways in the hope that some of the
> changes will have an impact doesn't seem to be a good process,
> especially if it's to work around defect of tools.

From the commit message...

"LLM-driven-developers" are not including the info about discovery
method we want to see in commit messages.

It is not the tool which is the problem, it is the developers. This is
in fact makes the tool better, it points out to the developer they are
doing something wrong, not providing the information requested.

      Andrew
