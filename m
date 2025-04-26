Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA186F53E
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745627864; cv=none; b=tlwiKjz+AckwREFQ0Giq4IsNoOEZLmtSK4VlYr30Um554RTEzNQeP2VuBX4kDwpx/UUqK5y7Z+mjjJeG3S7yjXj7XSf6YNBYTjLalbiGwK0FRgTUpGU2leGdDTEQgOlC0NS89gK9uuUax49v4bnb5rxAK6f7u06O2vKrWctag7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745627864; c=relaxed/simple;
	bh=nzXacSjoAu3gCt9df95sW62lEQxpWnLYojCFUFIE30s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBr4ZmCsfCCQqWOxvAHV5TL8tDTvShf3VOjBRNanCI+v2vVEo9RhVY/6o5CYDsKYL8A8S86lMVfxdPeNuATtZruf6lXEQPyufv7VOmLErp1IJuM0uUsWrAvRpNzF2oyTjr0TRTxo1nof8TJI5tyQepBLQwmPD4MM3K4VH9tsY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxkcx1un; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxkcx1un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4F3C4CEE4;
	Sat, 26 Apr 2025 00:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745627864;
	bh=nzXacSjoAu3gCt9df95sW62lEQxpWnLYojCFUFIE30s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxkcx1unFnJtLiSnnSoggq54UzuFbCD66pDc7DHXAmm927jXdMqaUYmAp+KsOD6sU
	 TGrFEpSVQ7WSX0b643YCsznKAQunckQZ5pTj10RIxbTvV4ss0yALbvhwCZQXEPH/C5
	 UE4kC3eMf3ZCVOvj6TZPxelv4l+YCq7UpGSDaZDT8G/wWQWxSqq6/ATUfQMRoT1ugn
	 bqhva2FqAF3yR8dFJ8cWyLhxZpIO565LfJI2Q9zMBWaMwxly+A5t4BIPfemCh1ka/s
	 g2iCfEdw9R3tXl7irEnCZiXrjvFvxJ05tiUu6Uk7EwjU5OBeugQrcbCVVfxTyz48KU
	 9raTwMbGdIsAg==
Date: Fri, 25 Apr 2025 17:37:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joe Damato <jdamato@fastly.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250425173743.04effd75@kernel.org>
In-Reply-To: <CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<aArFm-TS3Ac0FOic@LQ3V64L9R2>
	<CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
	<aAwLq-G6qng7L2XX@LQ3V64L9R2>
	<CAAywjhTjBzU+6XqHWx=JjA89KxmaxPSuoQj7CrxQRTNGwE1vug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 15:52:30 -0700 Samiullah Khawaja wrote:
> > Probably need a maintainer to weigh-in on what the preferred
> > behavior is. Maybe there's a reason the thread isn't killed.  
> +1
> 
> I think the reason behind it not being killed is because the user
> might have already done some configuration using the PID and if the
> kthread was removed, the user would have to do that configuration
> again after enable/disable. But I am just speculating. I will let the
> maintainers weigh-in as you suggested.

I haven't looked at the code, but I think it may be something more
trivial, namely that napi_enable() return void, so it can't fail.
Also it may be called under a spin lock.
