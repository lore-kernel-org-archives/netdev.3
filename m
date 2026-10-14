Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05723002AB;
	Wed, 14 Oct 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791963508; cv=none; b=utjU2a1bUc6jtj5ieV8D9GFvttbGkMx+PWVL2P4X56i8eJ2TLAehInP04FRpzgylr/b8EmbfMbKF5ati7p5J2w24jHoMcZDpwOXcxeIkXPi7qRI5W6pdchR7FotqwyvE8trcR8gqu8W5F+x/IMl4zHFsVVF4ho4GfAzhevi6PqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791963508; c=relaxed/simple;
	bh=vj1fm0p62yUErMUNpojScfEgVw4chzyYOjGeEZckTTE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyFjWt4GOmpZ9QtM7Ov/EWJowZ5urpkPMBDbTvzvIwGX/nDewN0qkbEfK0qwBtzmchmLJBTP43YWF6lRL0FrI/kTRMl0vQ3uvUROSgm+S7LGfPBSXmpVHIMTw+RjZvp0qxxdG1zCO/TuJUBlnZ4b7p9grhZHM/UOr+8iO4O7ipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MpXUWcIW; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MpXUWcIW"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3A47920743;
	Wed, 14 Oct 2026 09:38:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PG0rncvwrFvd; Wed, 14 Oct 2026 09:38:15 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8A7DF201C7;
	Wed, 14 Oct 2026 09:38:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8A7DF201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791963495;
	bh=1jnFWsYQSFZML/4PrDpytW5QHfSmkatmYDGHzSZn6B4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=MpXUWcIWUWFnRlFfAHm2p+pOR3enzkwbpPW1WYudZ2KINEf/j5LnHHoULnMph/PHp
	 xBXbIh4+WLNA9KleJNqxgy9M/Pr4IUFxgdgZBm8XM+Va1skrUc+7W2xHAwSznynAwv
	 6nfkaAa28D9RK+wSMKEfLK7Y+wTdyUDUUHN8qi+PEsn7SqGVQV89YnYMKH493rOZgI
	 l9blCOCQKJIC4vbTrK6Owem6OEdHknlKw78FJvaxpVshFgS7yTogJTmWcHP+ce7Ig1
	 1YW2lPayDozLQfSOTIj1Ku08BfCfWAvGe3psA5zXLwUx+rc2iaBwhqPE8FEF7uFg2+
	 hODYHNpHA/nFA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 09:38:14 +0200
Received: (nullmailer pid 1274379 invoked by uid 1000);
	Wed, 14 Oct 2026 07:38:13 -0000
Date: Wed, 14 Oct 2026 09:38:13 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Shubham Antil <shubham@octane.security>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, Giovanni Vignone
	<gio@octane.security>
Subject: Re: [PATCH ipsec v2] xfrm: zero-initialise km_event in the
 replay-notify path
Message-ID: <as8xZWxejylzr4lx@secunet.com>
References: <20261007075807.70009-1-shubham@octane.security>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007075807.70009-1-shubham@octane.security>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Oct 07, 2026 at 01:28:07PM +0530, Shubham Antil wrote:
> xfrm_replay_notify(), xfrm_replay_notify_bmp() and
> xfrm_replay_notify_esn() declare a struct km_event on the stack and
> initialise only its .event and .data.aevent fields, leaving .seq and
> .portid uninitialised. build_aevent() then builds the XFRM_MSG_NEWAE
> message with those fields:
> 
>   nlmsg_put(skb, c->portid, c->seq, ...)
> 
> so the netlink header of a replay event carries uninitialised stack
> values rather than defined ones. This was confirmed at runtime rather
> than by inspection alone: the .seq and .portid carried in that header
> hold values that nothing in the replay path assigns.
> 
> The request-driven paths set these header fields from the requester
> (xfrm_get_ae() / xfrm_new_ae()); only the kernel-originated replay path
> leaves them unset. Zero-initialise the event so the header fields are 0,
> the correct value for a kernel-originated notification.
> 
> Fixes: f8cd54884e67 ("[IPSEC]: Sync series - core changes")
> Reported-by: Giovanni Vignone <gio@octane.security>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Shubham Antil <shubham@octane.security>

Patch applied, thanks a lot!
