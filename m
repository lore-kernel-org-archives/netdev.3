Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CC2E7394;
	Fri, 25 Sep 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350392; cv=none; b=sHrd0ziiaa+qJQ2H7D1QM7HOa8dn1CJI74ZPDoRav8BYBWG/W5deIxYuz2mj1kxdleN/D5dkFkQwGTxWR5qhmg5fnbmSYC2lkYDCQQZx3YTDFgnEkikPBWDM46V0fNblywo9JhrNXejCWoi7E9u9a0kYUNNqlxZPe65BvoS7ozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350392; c=relaxed/simple;
	bh=P56GvgXEY9J9r6IY1wmb/5fsGH+fVKSA+9I3gEuMKBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m82wpMryU9qJXNkjHXobmra+IRdEKd0ObblUzEezRptTG/S2EYwFUm7RB7UM8XWRrLbadaJ2WkqRxAuFr+X1jScK9Jg3atEMTwpqw5FX8XGHNRSr2MhKfq5wxPRMdqon2QczXQ+VbFpNtdLynkQVBFDcJl2sw5x860PRZYbb2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ilkm+Zq7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ilkm+Zq7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P56GvgXEY9J9r6IY1wmb/5fsGH+fVKSA+9I3gEuMKBg=; b=Ilkm+Zq7pPxtfw0xG+jy63shIt
	m7w6waYi9TfuBIWJYFKPp0D4jG0C2yXH51zyDqeET9nxlafmkIPsRfsVv3PSRrgu/i9x8sIP9TDwX
	uE9uexkMeObxnsENOakzHpUzOi8PnO52YhVf3NikLNyIkJ/+/8HBCYMQWA65RmJfiOHwMObKsGdY6
	rvRGno5wGX9tLy9MVbzDu+uUahKjBV5IQ00XwyBIZa2vnmbnWZFj2tD6hgI2QS0/2X9xOE0q4q9c5
	X7XwNibsaXhnJRob794Axe08lKs0HHMT6rB4BF+gAPIP5Z9GMkT1/A190w/p/M/ng/vBkw7ggo3Sk
	dxWg79pA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA7v2-005OqN-2w;
	Fri, 25 Sep 2026 15:33:01 +0000
Date: Fri, 25 Sep 2026 08:32:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Zack Gomez <zack.gomez@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, stephen@networkplumber.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] netpoll: bound the deferred transmit queue
Message-ID: <araTwjYJRMlfd2PX@gmail.com>
References: <20260923181111.1182838-1-zack.gomez@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923181111.1182838-1-zack.gomez@gmail.com>
X-Debian-User: leitao

On Wed, Sep 23, 2026 at 02:11:11PM -0400, Zack Gomez wrote:
> __netpoll_send_skb() parks an skb on npinfo->txq whenever the device
> cannot take it at once, and once the queue is non-empty every later skb
> goes straight there to keep ordering. queue_process() drains it from a
> workqueue and, unlike the direct path, never polls the device for
> completions: when the ring is stopped it backs off HZ/10. Nothing limits
> the queue length.

...

> Fixes: b6cd27ed3388 ("netpoll per device txq")

I don't think this should be a fix, honestly. I would prefer to see this
on net-next without the Fixes tag.

> Assisted-by: Claude:claude-fable-5-1
> Signed-off-by: Zack Gomez <zack.gomez@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
