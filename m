Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D613C908
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694836; cv=none; b=oafxDbxdStTa8qQQimzj+bZuDPHV77UjIS5RXzOrktiH7DMnRqo10+D+Tyr1g/aPCvKfHF05BAIsS+A88Z69qNx69EWEugMSu6SYhCWIXxn1DBBozFX8UVdIFkkrAx3UfmK02ZBOXsVdWH/nCAf0Q4hUVgK19RlYvO4KzP6zatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694836; c=relaxed/simple;
	bh=1okgXvgUw5NEGILYoJRfRfBrq9iJVK2rgc1vaGBQjBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+lEv2ElD2bHjcK8pe5HVXEve/oNj5I1PiOexkvc8d6Oboeil6vN/WzMmUPQ0hXyq0rZybsdez3HdTNAOHgw0VZiXKDw5iNnrzGBubg9br/mtVvra05mIUGtuuubajYvAym7OhjQiKdzq4Hkb+BwC5LcWUh1EPNz7ZOY05jhgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=vbedwRFL; arc=none smtp.client-ip=195.10.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="vbedwRFL"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4hvM0q28c6zLmVZ;
	Tue, 29 Sep 2026 17:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1790694299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ehEFk6+Oqjgv+ea9WtqQTocvEpjkhSY9KWs8yC8OME=;
	b=vbedwRFLZHdvlGB0L5vhaDrx4lkgW1F9+ptr3aVWvlPJzEam1wYzUocl93jgOXK4cK5H32
	4G96bBEZEuHdwuVDtE4/eoDCvwYKm8+uzdSJL1ilW+1Aw8oV0LWyrDm2oltCTBgSXNpQxz
	YApxUIxjfj+H8J5un8z3Yulho55SYLOPSUmpsFjZ2Q9vEbllKq5J4gveGkPxThLzbhLmuf
	byXMJUzV9fitMy45/VVfQJssE0WJKABDUZ9MQ6xu9eFhJMhizcO+JP+HBr9jBAk4cMyqrV
	oupRI8IxBCB3aEafJNNvrW/bP2FsIWnJEbXvpwNZifRhQ2iAfLxHSW9NRvesdQ==
From: Ralf Lici <ralf@mandelbit.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB changes
Date: Tue, 29 Sep 2026 17:04:54 +0200
Message-ID: <20260929150454.466148-1-ralf@mandelbit.com>
In-Reply-To: <0c6f073c-12c7-4843-846e-69c48c290107@kernel.org>
References: <0c6f073c-12c7-4843-846e-69c48c290107@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 08:09:46 -0600, David Ahern <dsahern@kernel.org> wrote:
> On 9/28/26 3:56 AM, Ralf Lici wrote:
> > Hi David,
> > 
> > Just following up on this. Does my previous example clarify why storing
> > an old dst with a new cookie defeats reuse-time validation?
> > 
> > If so, would you prefer that I pursue the kernel-wide lookup-provenance
> > approach described in the RFC, or keep the fix self-contained in ovpn?
> > The same late-cookie-sampling pattern is used by several drivers and
> > callers in the networking core, so I think fixing it generically is the
> > better architectural choice.
> > 
> > If changing the generic interfaces is not acceptable, I can rework the
> > patch as an ovpn-local fix, although that would duplicate IPv6 routing
> > details in the driver and leave the equivalent pattern elsewhere
> > unchanged.
> > 
>
> dst's are cached in lots of places. Why does ovpn need internal routing
> details that the other places do not?
>
>

Because, as explained in this thread and in the RFC, there is enough
evidence that the current IPv6 dst-caching pattern is racy. If other
kernel users are expected to live with that race, I cannot force a
generic fix, but I do not think that is a good reason to require ovpn to
do the same.

If you believe the sequence I described is safe, please explain which
invariant makes it so.

-- 
Ralf Lici
Mandelbit Srl
