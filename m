Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102436492D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572574; cv=none; b=kTtNLeZh1aIjlYf9ZTSzUgvrFCPYJOmiVKNHRoPILyqmL6tXR52yxNOfChAPonoYiDiG1eo6ek7NdQWZUbTxRmKR3yeP59HX738WF78zh5tJrfXAmQTLvnX6jW+nBvXSt9cMOeRzKVbTYvfCLNWH7YblwKnMX4MTqAviUlaBKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572574; c=relaxed/simple;
	bh=Dyta8YunCFGs3RciPdfh2Z3EQT/pXwIy4XJ0hlRS0PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5PAMUpgKmTs1rLbDGLu/8AXkQY6+mYwdwnhMWHsLjhnMNByT3ISgZP5f3WkDK2/7h89BwdEGx8fOQvSlXGtRfACKNe+scFcFgqRwI3vVGi+Ca1PIIUVo+5wCKJfx1jNoyxqThfEsjhsKtZ9tpX6hlsOlgO+BraDXet73DUWVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qo9/FdqP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qo9/FdqP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E6aVC0k3FC1fg6v0gwh+qO58z3Fx9AwQ5p9vhW37L1w=; b=Qo9/FdqPUpuyQhNAwoJ6d71bXW
	GukeKFo5M8kdWuqbq9dWttXhRTOtJfjMGDi1WVqOX7oGu8CvvyksheONbeKQDAAYrU7NPUYuPrQED
	YLrTtrQ6DXA9ph7c6WHNsLtMRPziC7vIbzwylhPw8y5FCqjMQOyonsOJuJqfSMK1ImMkIM46Q9c9I
	8GPzOGjshHrUW1s2nwRgoO302bjo2y7ewyde6w4PxOzYHYF0hJBcalt+5Z5AH/kyox49xDfsO4b4V
	9ZpypIJ2kcZQnZIxUvlpkx7o/CZ6M4USozBhUfk+blqOO7YE3hi7xJTMc+ApjTG6qIclq1YITunEc
	abPqhBHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB3ib-0000000HLle-21TP;
	Mon, 28 Sep 2026 05:16:01 +0000
Date: Sun, 27 Sep 2026 22:16:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	hch@infradead.org, sgoutham@marvell.com, rkannoth@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	lcherian@marvell.com
Subject: Re: [PATCH net-next] octeontx2: remove unneeded symbol exports
Message-ID: <arn4Efet4feI-WFl@infradead.org>
References: <20260925201042.1174488-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925201042.1174488-1-kuba@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 25, 2026 at 01:10:42PM -0700, Jakub Kicinski wrote:
> octeontx2 has a bunch of symbols not used outside the module which
> defines them. Worse, still the macro which defines otx2_mbox_up_handler_*
> adds exports for all the functions. Remove all the explicit exports
> and the auto-export from that macro.
> 
> otx2_mbox_up_handler_cgx_link_event was exported by the macro and
> is genuienly called from the VF driver, so add an export.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

