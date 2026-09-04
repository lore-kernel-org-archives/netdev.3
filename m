Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742D3F1653;
	Fri,  4 Sep 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530801; cv=none; b=kZRlojS8G62aGQlOuGG8CMbGvpII0AnI4+aOUsneS4Sg7WV5ERE/WG9CgbRzRCxcHdRlCWSTzETY69fween915658nfVZnDDfT38PNx+6KbTPvTsdmskbwXpVO1aQdVzXF4skYWkhlzdgYuLTLiVGmqop9vMj7D/pe0t5z8cp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530801; c=relaxed/simple;
	bh=XnVDiGu274EUdebWL1IBsHvy2N1BGqVRy+c2kkjzZ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8atDFxFuRJig25nD+YSh0OhkJlhmX47xAT5/YzRewc7eVEG2I46a9/RQk8L2sKipwgtTaL+i2VhfzaFW5oQTkhXnzaH0CZWnEbaUxSgULEUWStSeTDc0MVrS4K8W/bfzdKcW9lQVkIQyTnOdENweLkswOT3ZJFk7T+Ryaz5K9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zZKnReiO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zZKnReiO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lvfH7ynNQ+zc9zKW7XQOlu+jjiRQgmuVWnL9D3qepdg=; b=zZKnReiOMycIR5rl5koVdm1280
	cvQaAVFP3vGaTffD3YlgWw/u/nryeei3X1FOZGY31EtL0IYOSI6GcF70G3L7DZdkBFApbxfzANvUY
	0WM0CuaeQb1JJ+L4jTbN+cjVjTYLP1cF01Qhdz//5RO1fC4TJ54QCRbD+lnu06gyxXzY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2UYw-003080-8w; Fri, 04 Sep 2026 16:06:38 +0200
Date: Fri, 4 Sep 2026 16:06:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/8] net: fix typos and repeated words in comments
Message-ID: <52ce81a2-84aa-41bf-ac67-cfdf137b896e@lunn.ch>
References: <20260904125336.12749-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904125336.12749-1-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 06:22:53PM +0530, Hemanth Selam wrote:
> This corrects 8 misspellings and repeated words in comments.  Each is a
> separate patch so that any one of them can be dropped without touching
> the rest.

Nice to see a patch 0/X, but you somehow managed to not thread the
other patches to this email?

Please take a look at b4 prep, or git --send-email.

       Andrew
