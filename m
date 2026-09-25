Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E0375F83;
	Fri, 25 Sep 2026 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318682; cv=none; b=tk3hkTPHM2/1Cgg1IojbeQt7PZX7Su/6BzLF/cfOKzkTtrOdHpSW3WiSDkxvifEdHWdhx81nnYANUwLmu0MC1WlHlRBs6EHdv4S2DjohHiOwxSjPQVQsFdgl/vjQnZkfZQNKlJKs1wnOFJnDuCN2HxYH7+UnByqRFv4s5w4uksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318682; c=relaxed/simple;
	bh=FfqpPNJtRO0EUXXIhB7MM4WDvAfN8CH25Udahn/qzmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZwpm3VU3hUGhU15nzz1DIAZ1NjAXwuq6yW7KWKrzOxUWYmE7bG6I57ALhOni/9NQcnbNyFpwPoZ9cU3GEkOIYwuUDL85sjTfcpT80PoVi3fvRZmQ7SCEHDXVpzfsufHS4wqkJ2Vcx7vFvknHOHKOYypTMj777i1aK6xZrexNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wR67LYNT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wR67LYNT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KzvSr9R/mBch7S+QJxiPCb7JhJ6PYAVMLtJt+FvjF58=; b=wR67LYNTPRSf7G/CzgVP6pfASC
	AOwzdpGcvG3083Y4RQU1pcU1TlfoWNCDY0K9I6kIVWAN0BBlhs2SKehnLucqIZHCNbqduBbE/0hj+
	m8YSVpAJY/oQmS6hVCY7qzvLf0n4bXYi4tba8gYWVerb0EVbYgWvK3u93kVJMF4A5e02J0raDUUP9
	QL69O1I/ahYMIHTFq/ZW9N880IcPCBNZVmWHQ4OLTM3GWq4A2R+AAGlpODxgphV1fh1Hn4mvDUZUq
	oA1trrcpd1b323POHkKL1IaA+4ou8TD9uE70Dze5wPDgnDYz3GyHXwTiRc+9sdvza+Hjv5b/ssg3t
	jhiD+/GQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9zfb-0000000ClrF-42Yv;
	Fri, 25 Sep 2026 06:44:31 +0000
Date: Thu, 24 Sep 2026 23:44:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, netdev-bot+sashiko@kernel.org,
	davem@davemloft.net, gakula@marvell.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	sgoutham@marvell.com, andrew+netdev@lunn.ch, edumazet@google.com,
	pabeni@redhat.com, sbhatta@marvell.com
Subject: Re: [PATCH net] octeontx2-af: nix: Export CN10K admin queue enqueue
 mbox handler
Message-ID: <arYYTw8l90VNnKal@infradead.org>
References: <20260915072357.980485-1-rkannoth@marvell.com>
 <178971638355.22033.14086854049232485813@kernel.org>
 <aqzpNjAtWSoi7hX1@rkannoth-OptiPlex-7090>
 <20260921150241.10a47c1f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921150241.10a47c1f@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 21, 2026 at 03:02:41PM -0700, Jakub Kicinski wrote:
> On Fri, 18 Sep 2026 13:03:10 +0530 Ratheesh Kannoth wrote:
> > > - [High] New EXPORT_SYMBOL() with no in-tree consumer:
> > >   `EXPORT_SYMBOL(rvu_mbox_handler_nix_cn10k_aq_enq)` is added in…  
> > Can i post this patch to net-next as consumer is out of tree ?
> 
> No, we don't carry exports for OOT code upstream.

Btw, someone really should do an audit of all the octeontx2
exports.  There is a lot of them, they are non-GPL and non-namespaces
which is a bit of a red flag.

Similar the drivers/net/ethernet/marvell/prestera is really weirdly
split into two drivers for no reason at all.

