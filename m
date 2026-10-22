Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666321;
	b=JI/qHnVyC6wSbCYeF45V/4qY7knqSTN/Ty4JU3nkdaLVsr3GPgm6l+GB674tDe/HSMiG
	 G+ysbYgGLFW0kVYeuydUB1gJSdnyNEmAb/94HnEX6EawpZSn7rnD1UDkPIylWv7psnxv3
	 Bjhu97kBwC1pq3gz5EpZWRL27f1vr7ElIabrPIpR+oxkpbHgHUHcLMv7w1EzIdybti94m
	 Uq3l6jHMnjKOnDzgHQxR4Tgm8fBX7QrIIVRhbT+TGlrd5l3QeRv7NwONvSRYCbk1z+fNy
	 TVlOdgZmJeDET0ynPqYq/OZbxCCBKDz01PTf6/IlKOJt3KSF4YYvej1oIrwrL+XgT6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666321;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0Fd4M8P9CGrNe3fKF6pXdZwlgw+B/jEmtEkhsHHnwy0=;
	b=w/XWDcznG70zfGRaqDC/wBXFzfxDRLP6RQy4YFlvP3azquDNU4gd38pfr1RKuEFXqa7C
	 86El4TZ/ruJNL0qqtW3uKskuZIuG8kwOOdlgYnt6lpRVzKFzrFqzs07DHZbZeOgtAdVcd
	 Q8tA4qnU3RszVqk5dqBj6n+ZdYWvzl7YsyeFIMvc0YIZTQJZEepvEjDJLQfzynMIHvTKD
	 9FqkRODzAwFm6goQ1/6x6HZovwrdXImXKmup4XGSryMD6QmbCy3DumKVL2KfnLOYPUA37
	 v3EaP6cUcCoWrVownG5iR9hRP7dUnpKjiMnCwscB3z2gbXZCp4B0nL9v4e0lLEn8CCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753D606A31B;
	Thu, 22 Oct 2026 10:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9753D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B9EDA61115; Thu, 22 Oct 2026 12:51:58 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:51:58 +0200
From: Florian Westphal <fw@strlen.de>
To: Eduard Zateev <hackerowskiy@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+f3f4fce0609f8e91b540@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfrm: disable state hash resize work on netns exit
Message-ID: <atnqzmyrwps9xc76@strlen.de>
References: <20261022102641.1429128-1-hackerowskiy@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022102641.1429128-1-hackerowskiy@gmail.com>

Eduard Zateev <hackerowskiy@gmail.com> wrote:
> xfrm_state_fini() flushes state_hash_work before it inspects and frees the
> per-net state hash tables. A concurrent state insertion can queue another
> resize while that flush is in progress. The resize worker may then replace
> and free a table while teardown is still walking it.

Is that correct?  Can you explain why we can have a parallel insert
while we tear down the data structures?

If we have such a scenario, what prevents the insertion from happening
after the disable_work_sync, or after the xfrm_hash_free() calls?
