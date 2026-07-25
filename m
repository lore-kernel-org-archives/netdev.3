Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169F2571A9
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784963733; cv=none; b=DokQwYsLAtdnvreTcoWAiMhWipHErctYFFpPg8OgFnJyKHKROJXZ6XAS+5hTWik1QYzU0eXh76jABe3rTRhXYbp5PQ6GBZ8kVT3w/aDKBUXF5QJQOcpQTC9MkJxBxKgaV+7y7aN5yJBiyybGLG9amlszqr7l6WyVt4NVdSErqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784963733; c=relaxed/simple;
	bh=iT1PpgEXBh2eSj9Am9NOwlr3KVFNbywVX6yMief9tNs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bLvbXa3uTFRABUfkLsdVivlM1LRJmd05tQVPmlTMOueaX9nmqPq1heESmgndtZ3xnNaQQehV5hOc++s+dEgs/RJ5RznfXybinBVyZjQjL0lZyayvGYXznlHjpVpbdXisBpdBd5YTV8AAS0+DFKYTxVV5y2PPDQMNNaiqvL66R3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsBnRBIX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsBnRBIX"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ef8255cccso11196527b3.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784963731; x=1785568531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vzVzJZS3OAbAuoAbfHflezUlm74CWBmWTbuWTGzELfQ=;
        b=dsBnRBIXMZLppPuVn1PP54gBTKXAo4ITl3erobSnZKvikqqNbZLIoZej5IlsaZdDsI
         HmmUPqDtovoU2sH/QlHk0mhLnO+OTnCd5Ok/LQBZ6jguY/WiTemzD4db2m2IVU/St5qx
         Fn1bHwgRDkW4ozfUtSu1HNZF9egbtY8rNBu7jSyXVmYQaS6MkMUUs8SZ+YyNlCvRw0Y1
         dWowIkDFRDPe8ewe6LxEbJQ1CruHxOejUITBM80z9TxBXk8sdZvBy3gMcBjc498Bv7Eu
         3O7Ld98m5wfA91Y3eu+Gv0XzlMNgRSMWjCyxRuewg0r1lErW6oO/atgNUOzS/LtOjXnH
         EEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784963731; x=1785568531;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vzVzJZS3OAbAuoAbfHflezUlm74CWBmWTbuWTGzELfQ=;
        b=QPG8eAhS7qBHG7NihzkGuxaoQLUGHDWr8/UvT/llc0joNSSCGUKdxBpzdGdyg8BuA/
         Bm6TBzakC9L+RKVbC2qeKB1Kya6uj9z9e8qeY12tI3tyv46CvTiVNeSMwfxGesT6GldF
         zw5VfSVlteu8Ha6W2XNdRKo6HsqoVkF8YVp1uAUpCwEDnSfGga2Ynf0yUOUBGAcHbzWP
         32OCUIbivTcLTKQ3pavIAwvdImjd/lW3Qb41E2gyH3nYOAJvQK7Q5L4+w3sySD2O/OrL
         zMFxAYRK3U2WA820W+Rb3MkXjlJOwwLo6VvBdZRM8i5WD46pzh0hHaG8agJPy9/VTzlF
         64ag==
X-Forwarded-Encrypted: i=1; AHgh+Rqr7eSj1RuQusi0ZqYeZOLKKsgl3IdRFkrkqY3YkC+XZWmJumKrQq9RV+mIb5wtYRgtUPd3h6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGErRnr7eHMG0kyn3kghKIdrkGTwJvsE7uO5COzFketCRfLuL9
	tMUSRXjZ4URruDbfXRqYmC71sSQPge9U+mJ4nTYqahEWJTxsCRw7L49E0wKxqA==
X-Gm-Gg: AR+sD10bf28QUqxUB1Tgd4p3GW4IuqgUbiRSoKu5SXqHtT/dQUgkoHWZb+xF3su4Lmi
	nfseOsNLcUlgILAceHiQqSPitXztg8UisWuiZIS/+SUEztsYGuAINZInbEatLuybcI0PpnouCBZ
	79PC8tvIfObZpsYDtc/SCyBQBKzZqWT5uSJ37YmepeP+0KNPOU3OqP+NUcZvX30wtq7uwxQgozQ
	r2Yf8L0PUpydmBjsa297+EDWajJ93+LuDFBUZQf5fDWpWEcrnotvsTQW9o04sRfrJkrsVt33gPR
	ZsBlj0d9PXVIikHCJrF9kEjuBilr69HgB5PaMnHGI8RljttX3sLMfbZQ0OjFP5jmlbWmnaVyB2a
	lmwGglC6hJLdj9vUUgdhmebsc6HrfoWMt8MCzA0yVzEaHuMyV89wry4rkNZ4rJmHC7qWATdGsDQ
	KcSH9kHqcU7xEsQQQLl1Dom6BscPufz5dXzyd922CF2Yrtbm3GYXXdZ3w=
X-Received: by 2002:a05:690c:692:b0:80c:c6f:1b4b with SMTP id 00721157ae682-81f69ccb5dcmr4775427b3.12.1784963731502;
        Sat, 25 Jul 2026 00:15:31 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65774b0dsm10082567b3.1.2026.07.25.00.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:15:30 -0700 (PDT)
Date: Sat, 25 Jul 2026 03:15:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ziran Zhang <zhangcoder@yeah.net>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Ziran Zhang <zhangcoder@yeah.net>
Message-ID: <willemdebruijn.kernel.32ecf4de53a33@gmail.com>
In-Reply-To: <20260724150659.6100-1-zhangcoder@yeah.net>
References: <20260724150659.6100-1-zhangcoder@yeah.net>
Subject: Re: [PATCH] net: skbuff: Fix misleading comments for skb_put() and
 skb_push()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ziran Zhang wrote:
> Both functions only move the tail/data pointer, they do not copy data.
> Update the function descriptions and @len parameter, so they can accurately
> reflect the semantics.
> 
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>

This seems subjective and superfluous to me. Certainly not a fix. No
mention of copy is made in the existing comments.

> ---
>  net/core/skbuff.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 18dabb4e9..35ad782ad 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2614,9 +2614,9 @@ void *pskb_put(struct sk_buff *skb, struct sk_buff *tail, int len)
>  EXPORT_SYMBOL_GPL(pskb_put);
>  
>  /**
> - *	skb_put - add data to a buffer
> + *	skb_put - extend the data area at the tail of a buffer
>   *	@skb: buffer to use
> - *	@len: amount of data to add
> + *	@len: number of bytes to extend
>   *
>   *	This function extends the used data area of the buffer. If this would
>   *	exceed the total buffer size the kernel will panic. A pointer to the
> @@ -2635,9 +2635,9 @@ void *skb_put(struct sk_buff *skb, unsigned int len)
>  EXPORT_SYMBOL(skb_put);
>  
>  /**
> - *	skb_push - add data to the start of a buffer
> + *	skb_push - extend the data area at the start of a buffer
>   *	@skb: buffer to use
> - *	@len: amount of data to add
> + *	@len: number of bytes to extend
>   *
>   *	This function extends the used data area of the buffer at the buffer
>   *	start. If this would exceed the total buffer headroom the kernel will
> -- 
> 2.43.0
> 


