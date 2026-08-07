Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79C34CFC5
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087899; cv=none; b=HjYyCWwXkTbcZeAXd0uc1REJ+ElydZ+3Qa0WlG5BDfqinQGMu5Fvw4DEoN3myPUWEDr6jJfdwHGk3ueS5iO2OLVoo3Rp6YkJ8t343p5BJMx6QYFuLV2POh9NPbAJG8JSWzvohfnDKzi+LEUQSKsxO/Kv+hqYdyKDcAZFhcRKyGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087899; c=relaxed/simple;
	bh=1VyDuJHYR+ciOz9BYEen75fLFOo4/umvL81BHUNGmEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/TXGMnQcqvd7AE8Axf44pQmvBTADgIdlcnnTzsYrnrkMpsBA3hcdfJXTJROERbhm4ZKPK6idTYJbFx33OSC03IxrxoVscAVCebNozv7Sfsem/VfT8jKn3Mi2VTSdLFTLb8yV4GrvimZT8+xaa7p5o1XU+zshnussLIWZgkk0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=WVimykD0; arc=none smtp.client-ip=217.74.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="WVimykD0"
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri,  7 Aug 2026 09:31:23 +0200 (CEST)
Date: Fri, 7 Aug 2026 09:31:20 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot@kernel.org>, syzkaller-bugs@googlegroups.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev
Subject: Re: [PATCH] netdevsim: fix deadlock in nsim_bus_dev_max_vfs_write()
Message-ID: <anWJyHCic8XvA0Q2@nr200>
References: <b7bf56ea-7522-4163-acd5-aaa69ad03b3a@mail.kernel.org>
 <20260805160851.571ed66f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805160851.571ed66f@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1786087885; bh=qF4lEOy63wNW7hqrz8tDkLwya64utF2ElrqG9+tBOAw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=WVimykD0rQZfu7zdYgBAq0HfudsyaL9tOFC8XsII51f52/7Fye4NmA64YHCrKQ+Xu
	 4jE22bBavpjZZH+8L4icizt8Uf/RDPr4+rUatuGTISKyg9w7XJOVqNY2si2aIU+KvD
	 pNA3WFJo5NfLT5M1UWuG0HN00Zkp2+8Y+y77Pv8g=

On sie 05, 2026 16:08, Jakub Kicinski wrote:
> On Fri, 31 Jul 2026 09:55:04 +0000 (UTC) syzbot wrote:
> > --- a/drivers/net/netdevsim/dev.c
> > +++ b/drivers/net/netdevsim/dev.c
> > @@ -273,7 +273,11 @@ static ssize_t nsim_bus_dev_max_vfs_write(struct file *file,
> 
> Sorry to chime in poniewczasie.
> Please delete this file. netdevsim is a harness for in-tree selftests,
> none seems to be reading or writing the debugfs num_vfs AFAICT
> so let's just drop it?

That's true, but is netdevsim used *just* by the selftests (or was designed with only selftests in
mind)? What if someone is using it without selftests?

On the other hand: what sashiko found:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b7bf56ea-7522-4163-acd5-aaa69ad03b3a%40mail.kernel.org
is true: the same issue will be with e.g. break_health. So it seems to me that a better approach
would be to change when the debugfs files are removed.

It seems to me that change in nsim_drv_remove() might be easy, but what about
nsim_dev_reload_down()...it seems it will have the same deadlock. Or am I missing something for this
case?

-- 
Slawomir Stepien
