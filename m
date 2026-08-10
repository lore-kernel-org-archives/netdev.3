Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CC38E8D0
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.67.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349190; cv=none; b=A1Qszi8+RCaYJSFefPGi60EYpb8TTkM8OFIGXGxDV/AbudRX9itc2SfbZxpKohKXoHPLRFBUy0YcoGpiWWqmKm2bWY4smod/03RYrcXerY69EQI7mLXVTfGy0gQbsMJiBNKsqXG33ZfenOD8mk3bcSJrFV7On9OpyMA8fYjG+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349190; c=relaxed/simple;
	bh=2R0N38cQyg+9z4f6+8mKllGslg3z8WpbANxKatSrqQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKpIuHgzKkgZfE6YwPUO2rwAUMoBx7d7OMjKwh0pvExwvtfIa/2Jq7KtLROgcMQK5WJZOtU+nM+adbRHnjY/3PCqHgiP58ycwOZQKSPq82pvtLspM6gW0Rru9VOJZU9T5bOr1jJURDiJJnP9hAuKbWnFQCcazzZzbIR1ShhyMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm; spf=pass smtp.mailfrom=poczta.fm; dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b=EQ4LvqCp; arc=none smtp.client-ip=217.74.67.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.b="EQ4LvqCp"
Received: from nr200 (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Mon, 10 Aug 2026 10:06:16 +0200 (CEST)
Date: Mon, 10 Aug 2026 10:06:14 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot@kernel.org>, syzkaller-bugs@googlegroups.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev
Subject: Re: [PATCH] netdevsim: fix deadlock in nsim_bus_dev_max_vfs_write()
Message-ID: <anmGdjgYCnH1G9gd@nr200>
References: <b7bf56ea-7522-4163-acd5-aaa69ad03b3a@mail.kernel.org>
 <20260805160851.571ed66f@kernel.org>
 <anWJyHCic8XvA0Q2@nr200>
 <20260807144755.49141d2d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807144755.49141d2d@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1786349178; bh=5MUEEcbuzgwtEAb5xoGkQk/hmb6TxNRvXJ7Qdg1Xaj8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=EQ4LvqCpT8yDo8zvSmmHec/5WaYI85L3iVIoOKe+2EWR30mPMKh8eC1R4dpMSkttQ
	 tqWqAlnd3jBiOj/ZtHbVEWQAz3TkTjrgQQ8Cz3yMi4m0ynvyXNkBQjuAfMDe4rknUo
	 HjxnX3cWOiFQuBK/mU3fa7HSFPqd7J/q/9RO8WYc=

On sie 07, 2026 14:47, Jakub Kicinski wrote:
> On Fri, 7 Aug 2026 09:31:20 +0200 Slawomir Stepien wrote:
> > That's true, but is netdevsim used *just* by the selftests (or was
> > designed with only selftests in mind)? What if someone is using it
> > without selftests?
> 
> Quoting documentation:
> 
>   netdevsim
>   ~~~~~~~~~
>   
>   ``netdevsim`` is a test driver which can be used to exercise driver
>   configuration APIs without requiring capable hardware.
>   Mock-ups and tests based on ``netdevsim`` are encouraged when
>   adding new APIs with complex logic in the stack. The tests should
>   be written so that they can run both against ``netdevsim`` and a real
>   device (see ``tools/testing/selftests/drivers/net/README.rst``).
>   ``netdevsim``-only tests should focus on testing corner cases
>   and failure paths in the core which are hard to exercise with a real driver.
>   
>   ``netdevsim`` in itself is **not** considered
>   a use case/user. You must also implement the new APIs in a real driver.
>   
>   We give no guarantees that ``netdevsim`` won't change in the future
>   in a way which would break what would normally be considered uAPI.
>   
>   ``netdevsim`` is reserved for use by upstream tests only, so any
>   new ``netdevsim`` features must be accompanied by selftests under
>   ``tools/testing/selftests/``.
>   
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#netdevsim
> 
> > On the other hand: what sashiko found:
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b7bf56ea-7522-4163-acd5-aaa69ad03b3a%40mail.kernel.org
> > is true: the same issue will be with e.g. break_health. So it seems
> > to me that a better approach would be to change when the debugfs
> > files are removed.
> 
> I seem to recall being annoyed at the fact that the health API takes
> devlink lock. It should be callable from IRQ even. Forcing drivers
> to worry about calling context is annoying for real drivers too.
> 
> > It seems to me that change in nsim_drv_remove() might be easy, but
> > what about nsim_dev_reload_down()...it seems it will have the same
> > deadlock. Or am I missing something for this case?
> 
> netdevsim is just a test mock. Fixing it for the sake of fixing
> netdevsim is a waste of everyone's time. The first question you should
> be asking yourself is "do I understand what this code was *designed
> for*"..

Thanks Jakub, this is now clear for me. I will create a patch that removes this not used part then.

-- 
Slawomir Stepien
