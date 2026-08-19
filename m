Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628F3B95FF;
	Wed, 19 Aug 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152074; cv=none; b=rzWZ28Wx/tScaStAvvyU4tBacB+rsJhusBYd6YQKQvi5BiG7mRCvuOyveYdKTWpWdCfHW4vAuHM69kcxVjCFiDTlgvJrk6oNOEpGOFytQ8uiz2TuVhRTr/b/wdD3O/C8PwlTEmF+MXz2h46VxXmGfD7XWkFv7fxlhCR5YdmwMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152074; c=relaxed/simple;
	bh=YliGEzyzkenxKs1ExSfIsUXUq+u34X5/t8FYRK4grS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulKgdKodrnDB0/tQVZ3aOOpKoJfSJpgBLiHv6lSsF9aTjLnHY5a/xffQiCRujuFcgAfrLRDjITtDfJua/IbW5rB0k8VwdYprUXL4aHHoAoUFcC35+DCtZVO+MBWS41sW8gxBpQzqtmrznOs1dphM4dpvg/ycPj86jbRgwM5Afmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PSSkdAVi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PSSkdAVi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UKRmSpBswMjrzwdRBTz/rttve8CXD2uqfe1H4KkNhN4=; b=PSSkdAVi7v0p4p3dZCDqgjkv/d
	SnLG4+o79h7icj2KkwdHqS3ykPO8Parck5Zxke0JRvXyCPFtFnocW8mkzfxBV9zu0IxrbLYexm3OQ
	fJHSjWS+VdTEvkxVWezV/PpLVpJhdc877nKW2Z4Mt/v3ZspClI892sDA/Ew+Lm98/mTrDdQ2va0m1
	l1WDThUcvB9Jw3oYUrYjLh42tOQU+BarQMamaXl1dQcW5wvtjyCASROCiGkFc4dzue8GV4GPrmoQL
	b25csZQolURVbBv+27cHb4NulVNTzOaiC+eyYQVgDCwxbmJZks0gOLTgIrzcm8jrF996WNWIk3ph6
	C/+OnW1Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwhtG-009sKs-2w;
	Wed, 19 Aug 2026 15:07:43 +0000
Date: Wed, 19 Aug 2026 08:07:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net] net/socket: remove unused do_sock_{set,get}sockopt()
 exports
Message-ID: <aoXGoRkWVHHhxs2n@gmail.com>
References: <20260819-hch_not_export-v1-1-af4b0de70e13@debian.org>
 <20260819142758.GA922@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819142758.GA922@lst.de>
X-Debian-User: leitao

On Wed, Aug 19, 2026 at 04:27:58PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 19, 2026 at 06:15:35AM -0700, Breno Leitao wrote:
> > do_sock_setsockopt() and do_sock_getsockopt() have been exported since
> > they were split out of the syscall handlers for io_uring to reuse.
> > 
> > io_uring is the only caller outside net/socket.c, and it is never
> > modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
> > and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
> > it needs, so no module has ever been able to use these exports.
> > 
> > Drop the symbol export.
> 
> exports?

Ack. I will udpdate it.

> Otherwise looks good:

