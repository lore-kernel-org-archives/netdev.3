Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F0360ED1
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371925; cv=pass; b=bw1OiJVL6tWLBY0ltk1VmE1X6RR/Mtfr7flF968NttsP/+wcU0mNpLUivGXoLhhfERFPxuZqDi2EYbc/xTm144XK1pb3r65aqhxkk+0TasuLy6aLeavJu2kj2CMzlDZ06f2AtI5YDqxjWqPonAy086Fg+qJYis8ZiekiNb9qhI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371925; c=relaxed/simple;
	bh=lgPNOxYGLQrVMMkKHpDfncXv8G2FDJC+6RVpkTCe2hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW1wsJAL9DUNr8513ZCEG0399GJu56tUVmJvXBmePlNdJOjl1WFPX0qGLFeaDM2pOZTNtPcpepE75DK+0R1N93f5Akfv02pyEu+u3bA5juX7/O4a6SDhrtMQBLinjMZQ+eH9D4paGEArFd+2zGGkV1Hh1ZTmrwcy4MH7+zRaE+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U44ekjvT; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U44ekjvT"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso2995574a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789371922; cv=none;
        d=google.com; s=arc-20260327;
        b=s4OF22CO5t8CjXmC82kkRQujjYq5Q9glAHZScKErdMCMLdrXVGZZtj8vTedU9WUVxn
         YndpJLX/ci+jovE191L4B3TN5I10mNhqj0kyaeksnw9QXu+dWFZkYvQRU0gUjT1afeS5
         hmG1ono2qk9anGP6zWuylSfIYfTLk7zMEe8T//NH+Of7xu3kxNa1perapvR+4lHHvvlt
         Oa0kPkQPBPH6URfeSCTCEpv1ouaWFLpDS8ArTZX99oT1/CK7YZES4CuIBaka6SpMw8fo
         i7q7CTOskWhwKZ8cJ6aWeiXJuFrx6nsiRD3qytEIwKRRmHjBOMJE8bqM5sdqybwzuONQ
         YkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ReSZrWGH0SBJJ2IgQuJVgQ91fFMBjHlSyI6RMAfdGB4=;
        fh=IXetPzIrFHzxDXafCIrHtN7na1LhAwxJnzANx8WDHnc=;
        b=RqwESyBSc/eb/Kdmt5wJdd4dstmgin3VlWPnNRViunUlNKs5Uhy8CE8idW5o/MiELi
         P4DXxhoBJ9fjGqj8wQvtYYBFDuII1Cm2Z6pZxbPAFZQnmRcIBp20IZ+Gk+iL0Rg+SP6Y
         dM28lzxhX1ZwfwipE3UFwv3H3arxxOcjbZiA0qBPvtHHkR1ZZOYS6D5Uha2i7MCvumaR
         iR+h3xsJihXUn8othQCfFkAcOlKdYINpX0xGkTInA4UnHPtx1lJvqxcUrIm/T8B/2ZPq
         8IX0lgQV80/4UarYqUTtW7nlFNbsM6GpRur0BrYu9Go9rJWhi/L+LxrUClauzJXVSHqC
         aLLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789371922; x=1789976722; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ReSZrWGH0SBJJ2IgQuJVgQ91fFMBjHlSyI6RMAfdGB4=;
        b=U44ekjvTrTDsR7dM5t9Li7nk0EU7ndBTwIRuClBITliQOfNmvuHOLl5YdyWqJvDoRV
         4zf7vSTJt4cggiRsbW1hNkFUh/NksIgoUT5fTr42B1gOitxFdDPmQKnXiRodq8gCSwJb
         OKw5KcRYPiLsu38rfacynIzsyddODhtbm3ebWR3CBuoLGImUVRnDDQ0GbJCm/ZrbGXuZ
         7cYyEXlzCh6QR0+4La7cGxlZ8+sJuVXzuq5ZzR4R+Y0uNLpxM/e3JJfltBJGlGQ/Q6w5
         olU2Jn5BlZKUeT8ArkJTFL+rjvstEBJyX7crqV25/4VteMe7s1fkncxDhnqS5hI+wUrL
         Tc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789371922; x=1789976722;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ReSZrWGH0SBJJ2IgQuJVgQ91fFMBjHlSyI6RMAfdGB4=;
        b=m8ht2XHJeQSH4tA2Ca782LReDqnUUb2Ue0vo7Pg9kJQMvtME9LRaBhJMm/8j0R2coX
         VxWlIjPGhYBBHKk07L6aCI3Tv8BGyLiElD9TafSuGN1n7oWH/Ynn/K0Fa/K8w2Ar7edq
         /CQ/h240glWlxHiQWgxr7gsP2wgGI3ZAh8IXdE66k66cHVGEr/NFaTsImB10Q9UCK/YC
         7nW96CF5e2VbAFvK4QCXpqWAhi0SjKdxsbd8f6nYnVjb6S8FOQywiI4Hg47puN2WaPNH
         Fux4TzoXuBA+XgSCLtXXcKYmeU42wjaFcX442y3nL1VLbC99BJkaje7ZuVFajVO8YMFk
         +K0w==
X-Forwarded-Encrypted: i=1; AKwUvBz878XXx8ZxVFXRAjP9CmvUjLfGnrr4QYCjuqV4MCV/bQz6LxPELc4TdnMyph34elSjO21tq1w=@vger.kernel.org
X-Gm-Message-State: AFuF++n+mua6dVI9TKkq+QZ9pPagc4pvF3Twju/a4nFgkku5r5F6qZys
	Ypagt9NmJMlc/e9u76KhzzwDeA5cNtjkZCoiItDZywLSGDffi06GLPJLjjH2Dx65xZzf7VN2/uR
	V0UR2y9mq8uhmXUinUjdOvfW459oHIqc=
X-Gm-Gg: AYBFou3+MDcXk0qesDYWRPFhhyCoBTAEqaAyGpfZj3gG8nlPo4zGcCHCrqDiwx4TEVY
	4+FFF0vY+9YqJT1HbtUgXks49uoVhz3Ek0RaijcRPkwoqgI+uLSh1AfEHjlw0Zsy/v6NetR5Gui
	JHJzKWE24n2fwbGIveGqqVoOf3v8lXW02NgDWLHr4X3t/xM749cxbsVEwOggBkcegD/DZJnQOkv
	NflaMTWQNdQZWkYcCZGKjaDwx/R5kJA+RRUtQOiecYsZBSJev5X+u09j0ZBKgpmGQXl39KdFdY5
	sEB70MJ4vXdDAZjBKyS/ejNeBQbl3OlqAcJ9NqEkQfChOxQm7SQKNtY=
X-Received: by 2002:a05:6402:44cd:b0:6a8:372:edbd with SMTP id
 4fb4d7f45d1cf-6a9f61fa7b4mr579620a12.10.1789371922292; Mon, 14 Sep 2026
 00:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904033138.10620-1-running910@gmail.com> <cd7e9145-20f4-43f7-9c18-c323b9d13a9e@kernel.org>
In-Reply-To: <cd7e9145-20f4-43f7-9c18-c323b9d13a9e@kernel.org>
From: Zhixing Chen <running910@gmail.com>
Date: Mon, 14 Sep 2026 15:45:10 +0800
X-Gm-Features: AcwNN1Ub39YCZCWFJMQmN2TX86VLYt4FNXeRXW0AD1U6_ugc4FYq2mW1zIpdu5U
Message-ID: <CAMyuFdWdeDna+FMmOkJwQOCN4GO6=Zu4m5DyX7XbeT=Zqr6PKQ@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] iprule: warn about host bits in IPv4 rule prefixes
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

> detects more than just host entries in the mask, no? 10.1.0.0/8 would
> also throw a warning mesage, but that is not a host address

Thanks, that is a fair point.

What I meant to check is non-zero bits outside the prefix length, not
"host addresses" specifically. I agree the wording is misleading.

Do you think a warning explaining the actual match would be useful, e.g.

  Warning: from 10.1.0.0/8 matches 10.0.0.0/8; bits outside the prefix
are ignored

or would you prefer not to warn about this in iproute2?

I am not strongly attached to the patch. I noticed this after I was
initially surprised by rules such as 192.168.0.147/24 matching the whole
192.168.0.0/24 prefix.

Thanks,
Zhixing
