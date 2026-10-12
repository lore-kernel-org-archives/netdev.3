Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93A404BE3;
	Mon, 12 Oct 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809938; cv=none; b=etN5V+5SQ1cyXh9IRWBOSIG4F64ENB5USjH1N3eYscLU/cm12P5MgT6Yx2EoH2f1IfO3wa0fCozVpJ96mOf1mhTdtiSplGvDE/Ssa5tOtEEB9GxxmtQdzkeRYoo+xmFDiQ4kQGV5jZtdsMxoS5vwLCyfhbYB2tRuwywMYkJI3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809938; c=relaxed/simple;
	bh=qin85BibcWwdgs+nY2xiaiEYJ2+uws3+DNC5ZdVJOAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY25MIuc3uOsbz2V0S2GWuVztDrI4oyzz/VtfKV3AbK7Km2h2uBvqc0LipassVv+OT7fY4x0mS8j8B+qlPMSFw6nsqijrbzEn8tVzc3lBDWVNPEi6ZhA1jZlp/XbXbs3Y0aL4N9m+mAOVmEHUY/a7L5CAqmp0qyjP6o0JPpUhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tj/M0iIh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tj/M0iIh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WSN36eYvKDf/95wB4rGwHHwtlLBvopUuhPlbum0P/zw=; b=tj/M0iIh/Xruqt1qxZJofswqCq
	g25G17pzS1uod+kg4wJ3Lt7rXcLMl7Xb+LXPNUQi2f1AJ6yfQxmhJPPZTeysvIU/cRtG6h7JH7eeX
	ocOa1PPNLSTaBeVCLppFHXVpCPKdKt1xwJEDn16vGVS2j2RSLrT/oQQkgr7qI+yBHmjk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGFcD-00AKE2-Ho; Mon, 12 Oct 2026 14:58:53 +0200
Date: Mon, 12 Oct 2026 14:58:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS
 responses
Message-ID: <f84dc8e1-8dd3-4850-b87a-b526e66943b5@lunn.ch>
References: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com>
 <179134657946.434549.14071341559835135672@kernel.org>
 <CAFGKm+zjOtU8WGpcqqb6_XnFd3vmPw2RszPig9PJzbq3Uqh_Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFGKm+zjOtU8WGpcqqb6_XnFd3vmPw2RszPig9PJzbq3Uqh_Lw@mail.gmail.com>

> Fixes: 36c35416a94f ("cdc_ncm: fix endianness problem.")

What has endinesses got to do with message length? A truncated wrong
endian message is just as bad as a truncated correct endian message.

If you want a fixes tag, please make sure it is actually correct, go
back in the history and find the real place the issue was introduced,
not the last time the code was touched.

    Andrew
