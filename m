Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4A287247
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791392525; cv=none; b=HIw8j9WbUMpEQPiBX9whqGvc9jND8aZg1fpgdM4NZOw2T0LJi6ICEQWU/dTfVbE9ehs6MNrRsLmn+jDdaTWIVXSOK937P42xYuljZG53awY5D5+Kffmj4rGSylE4XoSytIxzhzaRsVzpdX0vU9eEuIKG0qfP1MvLVrIDr2DQsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791392525; c=relaxed/simple;
	bh=rs8L/qTEhKZL1H/R17zqR66wvZ+ovmupMmj0s8IRhH0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HEruTJkcsndpRSBR5+KEyNN2+54Z02iqioET+Z5TOXQ2cnamrOii25wXaJQjYStH0+U+8SeSw3MYZ6MeuNqB90PMQbCg4vnMtyJEII7DJkKzxnVWD2AGGYyfG+Y99axYH23mBaZbu9Rf9bLwl0nJODyRP3vw4ncPW6jpDBKmCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM5/7ZQe; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM5/7ZQe"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8abd68b3937so42698657b3.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791392523; x=1791997323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T7c1KaoHyf9JEwZ0dBy1RVejEEkV2hYkVxP30ENG0KE=;
        b=kM5/7ZQejigzgv8rtLcccc24S4/opAlImO3fgHHlTi77Hwvcdo2lVBMDplL901kQG+
         iDUrvNgbpnIlntbIbYgPgZr0P+5qW+Gd2gmwurHdeFCDeS9JdFERnI/ClnbZ7IXp+9lu
         cXpcsWzOfcOgCCs3fGY+0vDmF0uO665PW+ncUO76Fhlfnslu7lwf7PHQgWbuuJa8Pzd3
         nF/AoxOtwdqdFQFu6z8LZqo6JvtWfSPnzut1Iel/qWtey1a08EwyIN3RWD5p3cjJV1oO
         R9YK19NY1Vp3dIfPWgmNzoMoi+lNh6udXCQ5tKgo2qGnLbvLLx+yk0lIlaA6mlgBNFdW
         Hnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791392523; x=1791997323;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7c1KaoHyf9JEwZ0dBy1RVejEEkV2hYkVxP30ENG0KE=;
        b=XzUPhfDNs+0Mb33TC2E7RJtBKz8kpEIHf8nV07vJIA48NXsWx0rvWGOE5nDvJpInDZ
         6f6kcm4bQpdrIkZ9s1Z/FblSXQOSX0vk1qSduoJCYSXPu/rEMvRIrmhnitUAgqmKw1n5
         UZAkFbyxs+UFBUdI6rLMgx9Ez3kdIz9fzdZ18YgjHaQ+KNpNNNRVsQB/nBSa9C5McN5Y
         eGqeHzK524O1aFxsp6TWGcP1qP1weY3HWXwTYrZqE0UY9dNeHgbKUiIhkqQ1/p/CqIdZ
         RD+cRHWaTlEadcJkM+EOTa/zRJt/lxTRmGv0/R/2A4pL/9PPKs9rP/IEPh9Dapx7E5j6
         JhGw==
X-Gm-Message-State: AFq9FYJmK9Lj6PxndaopP+R4FwQDpQZs2xSy+Rk67S/9ioL5Egac9e7C
	5HnlLOueyy3FEfz8rlDqWCwCMFgQC2cuUT0ek09cTa3fXceSgI2FW4yP
X-Gm-Gg: AYBFou1IwHoLIT9BEU8DuOkFSR3QdTFaH99xt96nJYHFMbvRD3sYj8aE0aCzFkmPU3K
	iENuKH0Pew3a72QbQGtcSmvjBzZXaHFoZdDSBIwWQRZCJcxXZ1P08GQgmfYpFlJy5VirjhXjk8u
	eb1bXnYPPSRaJvNb/cTfmuZzr4QOUfhWPOOPYfMnM4D0Qr0OhmeU+9u5Vq7pJyb+2O8cEDB0JLn
	2eLCI0N0uaRwJANr+bn61cE49omjxYg2vIkCTxuQuHNJ62i53qYQ4KNP5WZcOcRgLeLx3j/jU34
	GNDIOeDwu3eR1sbNBltiG6IVS6NQwOkzKeD8b4YyXO4k3cMiLaTNiQZfsCsPPHJn53wNp2iIG4M
	2j/SNromCg6umAKW27WMGb6v3uvGkWmIqbOpPVFTX6A5hYRx74wRoHj5EXbcoV1zLJDqwRplt7t
	jAxuY1iZuYsMV49r356YGGYee4RsmhAfajug2854USPni+7kjxJS02Hv7x3GOvo6EbOp0QcuR58
	beUXTl3zGmzcJRo1iGgobcK2XadjMNVX5dRxP034VSE/hioRE5ceW/Y0jrXavc0IctUp29ex+Is
	ZcnAaggOI1sRa/TSKENS0n4=
X-Received: by 2002:a05:690c:d8b:b0:884:6e29:24ca with SMTP id 00721157ae682-8b05b03db1cmr25893057b3.42.1791392523412;
        Wed, 07 Oct 2026 10:02:03 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05a9b795asm10928937b3.6.2026.10.07.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:02:02 -0700 (PDT)
Date: Wed, 07 Oct 2026 13:02:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sinfo@kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 mst@redhat.com, 
 jasowangio@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>
Message-ID: <willemdebruijn.kernel.39c69387bef9@gmail.com>
In-Reply-To: <179139123996.2527009.137247187640502878@kernel.org>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <179139123996.2527009.137247187640502878@kernel.org>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN,
 IPv6 and IP options
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

netdev-bot+sinfo@ wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:

Oh right, I need to learn that.

> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

External report, see Link:. That does not say exactly how they found
this.

> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Created and verified with a reproducer. Not sent as an upstream patch,
because the code complexity vs added coverage ratio is too low imho.

> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


