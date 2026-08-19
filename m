Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E347A865;
	Wed, 19 Aug 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149696; cv=none; b=cl+pf/w/lC5Sbviic3pGLBJhPXSlhrSE3PnEFXakI4pa162Zr2DaGCP89hisXAv12IdJgGssU+66idNWUaXa2r8S9opmkZltoWOwgyFvgIoHd4geTptEB+1JUwl6GEMPqvjlE93IhGj6wIBeHhMn+aPLAGMHPdjqBAsCmIpFSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149696; c=relaxed/simple;
	bh=OtJ3Rk3ubtIY5JYbTiCBqJb0B5dq/qOLm5MDG9RF9e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8IrgK0Wf9vsseEuszknWUMZdL4xP2JkjdUNjwnZBYiBoLoN+fqC8oSGhbpJY0v6746b4tv/ol+ndeJHVXYUfwfNGS5eJYnJpAmSu4gWab1W/aUxQFoQGA3v2RWK+X6ruVN4U7uGAVIA4NMuAjWHMOVgzRB7dOGH1155YqL+3lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75C0D68D07; Wed, 19 Aug 2026 16:27:58 +0200 (CEST)
Date: Wed, 19 Aug 2026 16:27:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH net] net/socket: remove unused
 do_sock_{set,get}sockopt() exports
Message-ID: <20260819142758.GA922@lst.de>
References: <20260819-hch_not_export-v1-1-af4b0de70e13@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-hch_not_export-v1-1-af4b0de70e13@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 19, 2026 at 06:15:35AM -0700, Breno Leitao wrote:
> do_sock_setsockopt() and do_sock_getsockopt() have been exported since
> they were split out of the syscall handlers for io_uring to reuse.
> 
> io_uring is the only caller outside net/socket.c, and it is never
> modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
> and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
> it needs, so no module has ever been able to use these exports.
> 
> Drop the symbol export.

exports?

Otherwise looks good:

