Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579494908BA;
	Fri,  4 Sep 2026 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525955; cv=none; b=kNMpJZLwKcclb+h9NMJbz5qB/0KFYuHuT0ow1U7gkI5skKTbmBi12+5AexETjYPxrCElaDUzCvwAUl/vsW0iWLWESyKHNsLucbmvIooWm+m3DeLFPtGH41z7gT/MHONdko+hqNo6OmyUXlocQjpugNbLU/1aW+um20ivvUyjOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525955; c=relaxed/simple;
	bh=LtDSf5wMlA2r+uHZqfKaOqZ545wbJp1ntr1rZPKlqd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unf6skvDCpE9X4+uitw51QetLSiSb6nxwcsL1DP5hHNBZNV5Src0RngGFcOsBamwFbbvFjjep+YZ7X+Ho+NzAb2rjpRFghMLjrN/3nsYYxdxSM1yiUNC9y4lPj8GykKSjGxIYpDoIIVVECXKVEGBRioeHJvlr9BFORVo4bv+D/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PKFbW+GK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PKFbW+GK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=++VVFRwRIs5zVADnPYbShAcw38wpWaquMiqbejU7Nt0=; b=PKFbW+GKUT54oAJFRHFkzm3whC
	wDWRYbkzWsVMseahWm0mzViMNkUxip1IKFWxciZGDdOc3X3okEnBpTnnG+H/22W7paGxCxpiynLPd
	ZezqicjzvgxMqx4FhMLDcH7BbPR1/DsTIIh0RQQ16GLU6o1XKvgeROLWup73I7N8WaYY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2TIS-002yIc-4i; Fri, 04 Sep 2026 14:45:32 +0200
Date: Fri, 4 Sep 2026 14:45:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Anson Huang <Anson.Huang@nxp.com>,
	Stephen Boyd <swboyd@chromium.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
Message-ID: <d12608a5-468a-44ca-9442-07f2eee4e335@lunn.ch>
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com>
 <GV2PR04MB1173931CA07AEAB48339FF71588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFi06-7=uHmOBFGZv1eUYCskv8WspOdUxbDuQ6vMk68Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nFi06-7=uHmOBFGZv1eUYCskv8WspOdUxbDuQ6vMk68Dg@mail.gmail.com>

> Second, the current implementation can silently ignore -EPROBE_DEFER and
> continue probing instead of deferring.

This is a stronger reason. You should mention it in the commit message
as part of your justification for net, rather than net-next.

	Andrew
