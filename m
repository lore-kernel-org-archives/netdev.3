Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5B37C118
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461630; cv=none; b=Bv+7C6X5r8pIWaHcAUlppeJCkQfrhcHKPLaO0MkpX/rLt8WOg6g9TgvwxogdtsPZbDfBGoR7ys+E4ZVH7CDUP5szID9+VhSkPcrFxzPxzZ1fj+VArR/xECMz66bmATWEUTGlsWwx92EA8pcgo/qPloAr8whuqjZRH2p+lvz5LOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461630; c=relaxed/simple;
	bh=r5hlH8MA+K0N2NKbQ4FILeP3e6k2YdKHZsmaZ68Z9QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INcvwAnQiPUOpH3O35uHQqzzdd4z0LXLxEJA2BAuzKTXBumMTkzqAbSQmrCFrEVu9LRx98qSjqZdcG8V3ca3x75YNng/yg1r1epwz0peyG3UFx0mxHPCmrvry6mFSvVNw1WAjHyYRJ2MmkmbG2fu97sWtIO7tcHUryE53LjhTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMpZL+p4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMpZL+p4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC7F1F000E9;
	Tue, 11 Aug 2026 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461629;
	bh=R9AN0vTySNP3Fkgqw3IiBTEara8zy5n338Je0W0gh7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lMpZL+p4c7ZrPNVEHOqvbMH9tYdG4AaPZhT+rAQqlvPDahYsPxpIP4tidmLrUYbhI
	 xkLqUDYnQedrjhOjoVvbAL6seImrZPfaDRmypYHJkMbv93WaRBRzS1XLO9tBFkYWSL
	 M6TXSVlmZvpFDkTaz1lCKBv/DbZAZORGbL9tY4yui1LUkfcMaVCBcdvDLulJFycz1Z
	 VVlcdO4mgcEx773eHoYFhlY6KFaSmS7+qmhy4mT5Xi/f7r8CIc2Vsu1CC64Go6a08v
	 DQFBGW4mVJC7A0MW52uOtAKv3hGfPoBl8y4gqbusc9O//EEZBjM9IeSHKK+MCfY8ht
	 eA9xIvDFu9+7A==
Date: Tue, 11 Aug 2026 08:20:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, Willem de Bruijn
 <willemb@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joshua A Hay
 <joshua.a.hay@intel.com>
Subject: Re: [PATCH net-next v5 3/6] idpf: support pacing offload
Message-ID: <20260811082028.6223543a@kernel.org>
In-Reply-To: <willemdebruijn.kernel.2f01b2b7b1be5@gmail.com>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
	<20260808155217.885299-4-willemdebruijn.kernel@gmail.com>
	<20260810181248.7b05c051@kernel.org>
	<willemdebruijn.kernel.2f01b2b7b1be5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 21:38:07 -0400 Willem de Bruijn wrote:
> > > +	if (!horizon)
> > > +		return;
> > > +
> > > +	/* Skip if netpoll: not needed and not safe to call ktime helpers */
> > > +	if (netpoll_tx_running(skb->dev))  
> > 
> > Is this due to Gemini's complaint? netpoll sending packets with
> > timestamp in the future seems unreasonable to me, no?  
> 
> It is. Makes sense to ignore EDT request when running in netpoll right.
> Do you mean that we should not even check for that in the hot path?

No strong preference but I wouldn't check. netpoll is for emergency
data, and bypasses qdiscs, it can't possibly be paced..
