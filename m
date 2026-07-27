Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A736C5AE
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196445; cv=none; b=ibPNqBHc+Hb8BvL3vjzpyqJwJXhYYbAXIYBKm4CObI/OnszjiQ+Lx+/0CpjMhFE7iE+8+Pr0mIiaNIWGuQ1wEn5Q9y2v7ZDMj2Dp1b4DjDgPR6BvyIgWnxyfpLnQIjSQ3lFwVUTqLiMs7Z45iKlVGC+DSKL13Vy+OKN+z0Y3tzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196445; c=relaxed/simple;
	bh=aznLbjrmFl0BjNfaBPxsYAxtmhmBAQFQIvL5xUfP17U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu8nGIPrp2NGZPvtwrfH1mE5+NjYgLnL7tUsXC0Jj7Hn4iRvuwTmNziPGxZuxZzCLQPCEReqP8ydUh443ZtzqiwBz7/V+IfOtDJsOkRbaxycE1FAYnotdHCOI0oBLbXOwZtcFi+SRZtSFFZ6rjPu5LXM8dDm4lWLvf4DWK5+t6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfQD4gaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfQD4gaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893091F000E9;
	Mon, 27 Jul 2026 23:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196444;
	bh=0oY+9nPUPLDrTIBLcVHu6q6Fddzoo6wOIr09h6VSJsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XfQD4gaNAYrzdyoJleTog21v1pe8BbT0AHkXllhCRRDpA+IWJ+See7P0JcCq9O/5G
	 jqqi46nCmSVytVjoYvu8tv5uY2my+We8+/O6Ifkk1pT9i8i+qEW8gt3t+KswFebHJ/
	 0bV2EGduXDtKuE6jjcMdWBqlndjvek7ja/9KHSI1wRPpXzqLdCOja4gFnwBIvJvszE
	 Wa0/SJtOcD13l4eZHSMvIoXhbZlBfRoHojNFWbk6rq+JeQyTmvSdEJK0hVkRJpH22i
	 rI9BlMsfGZqukdiHpjEn+NRCOH8EfXoXxtBEdEgGEig9ZzVQPCwgxlgLQoGbZhHm8Y
	 D7TRLHSVaKg/A==
Date: Mon, 27 Jul 2026 16:54:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 mohsin.bashr@gmail.com, Willem de Bruijn <willemb@google.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Joshua A Hay <joshua.a.hay@intel.com>
Subject: Re: [PATCH net-next v3 3/7] idpf: support pacing offload
Message-ID: <20260727165403.268e6e4f@kernel.org>
In-Reply-To: <20260726202902.760552-4-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
	<20260726202902.760552-4-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 16:28:47 -0400 Willem de Bruijn wrote:
> If skb->tstamp is in the future, program this future delivery txtime
> in the transmit descriptor.
> 
> TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> the FQ offload_horizon is configured.

Hm, you're not even acting on the activation of the feature via ethtool.
What am I missing...
