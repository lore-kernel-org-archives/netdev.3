Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB3233920;
	Fri, 12 Jun 2026 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308126; cv=none; b=sifiiiN6b4B1tbz4y0Vt0J+FGupLco0J1zdoadociUB1KVPax+sE2OiVT221revCdzs6GWfZRWkA/Cbn/dGkZLx7H/3Gs9hfU/AHaDY8fmYhiN1aaK/aZIIYecp52+XuYZ1FmrVLIXxShvfZIEYIepeCujyucal4on3huPRU7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308126; c=relaxed/simple;
	bh=jfg4PkbWjeFfksq0loUd/x+t0Yzdj6Ba/Yuoor+uKm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kba+8mg0iadPHuyBhpGyHDYrluVIBZAGZOM3RF8xwNFhTPN2a6N9BrtcWIUkmYqU/FuGQzlR6BMJen0LL1tiyOXvW827qAd7jlfN+HT+7qbLkbR2qhKy1H7a/3xJGyAmQMY6uIed7N2E/mBMNfxWN2teDPwmG0OFjUzbiYWy18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfIAcWvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfIAcWvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA83D1F000E9;
	Fri, 12 Jun 2026 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308125;
	bh=8yoUjmsgvioaKiWi9pA9SXBu3LhphwrTuMsejO5mvYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FfIAcWvA0WiOiXGgbpPhe1qHwiV+dPXOI6/urAsDW2rwoGq7E7k1XoQ5kVr/2ySig
	 mXR84OZGQYEUnbyVuDgSB/qFKqNymOxHC61M8HnBlNIz4mkKB3gymJQ60d+UF4ziHb
	 gtiSnrCn3/69sZaDDNyfbqDSM6rk+Ed8bguoNRwpm0MPTHw0WvuYHL6vpKRgOtoQCh
	 eid6hb+Is2U51b9wkCDfc8MLoxYy+J2FpZBZ/REIIvejlty50YQ+UobjekXzo63kIf
	 Rk0x1C2+fN8pPdUb7IRuis3K3K4WmlFPLlas4FomgW7agrtpGOUHFD+NGmHCngIVQF
	 MTHewTBP/Yx2Q==
Date: Fri, 12 Jun 2026 16:48:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, Li Daming
 <d4n.for.sec@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, Jeffrey Altman
 <jaltman@auristor.com>, stable@kernel.org
Subject: Re: [PATCH net 4/5] afs: Fix netns teardown to cancel the
 preallocation charger
Message-ID: <20260612164843.20452d5a@kernel.org>
In-Reply-To: <20260609140911.838677-5-dhowells@redhat.com>
References: <20260609140911.838677-1-dhowells@redhat.com>
	<20260609140911.838677-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 15:09:08 +0100 David Howells wrote:
> Fix the teardown of an afs network namespace to make sure it cancels the
> work item that keeps the preallocated rxrpc call/conn/peer queue charged
> before incoming calls are disabled (i.e. listen 0).
> 
> Also, if net->live is false because the afs netns is being deleted, make
> afs_charge_preallocation() skip charging and make afs_rx_new_call() avoid
> requeuing the charger.
> 
> (This was found by AI review).

Both Sashikos think this patch is still racy FWIW but not a blocker IMO
