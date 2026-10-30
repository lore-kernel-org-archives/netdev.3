Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318851;
	b=K4q4ZH5iXODinbmOrP49Ol1AbyGJzKsEmR0UOpxM1ob+nLjRxR16QkC/hRKcwq8C1/sM
	 D7pDQAf8jFKVCqVOHIDwW6aRFNap+3xjUjMSywhzaJm8dCh25RTKZepK34IIx5bzkkzyy
	 ZE2Oog2XZrX8LQiyeSc3cEgnZ2gG3sur5h5WvScplRmUd6nPyqrtP/FNZOZPvmMkrhlt1
	 KD4QiDw8JOuXFR+fKeTjInREZpGck7AtwgAMmjvgXJnqrJSh3T6jO/v2/XgUZedCE79Ee
	 pR4njnxZ4OwFufLlxpaXc1jiU/u6JGCPc5kRO3jj+V+YIb+maWpJuDqFx8HGrg7PGTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
	b=2zAbKkH4beoVQwevypxfgaAtrf0yLH4YsOH94QVjDsYcxAwBIO0i6NuEQufY2q5XPwX7
	 BUa1p3crrce7VRkqRNjR8tv71tmWxlAZG/BcEMBHBaUR70V4jkDaUFMLapvzeKCsDjlEJ
	 TZADKxiCleYB80cC25mYACobtv8Jqa3Z++6qWGzgpO4hDMW/7ZU/UbaBN9EhWbNe9seYf
	 ENY1kilvUjf0vN/3ES2C16IUlHC7wn7bjNSpVw5Dm04rklnpnE/0RSQuPvl1+CEhMVoSF
	 2UWsMryL32mOc9fF1s4wL/h0xlu2sTeL/AQYB+QX9iltFzLnkQtc5C45kyEbxu1W2KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=CAMpbUEf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE03606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE03606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=CAMpbUEf
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a07078200fso20549b3a.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793318850; cv=none;
        d=google.com; s=arc-20260327;
        b=Divw3/xDDPUQAWbIWPvk4j7mAc2aEE8A1S+gpbY5KUMpUH/Lo+Zz9yKsJvoT8aBqry
         NSNMEOvkSSY3kh4WaPKmdXz4y+HyaVOO8ndlf8k/VeqghR+xJZ4yEUnReqnCRw7L4HTu
         gHCycexFDiSR6c5MZI2CL/NvFKQyfe5A4775UQIEXReEz6prS0sO6vgBeOIZKGyrPMEK
         XhYm3bAIb+0P0rTrXLckA1emvmCEStyYKKiDlGh65c1JMNtGfSKtyxGjDtmi/tchvmDL
         5/9kP9zO5uC6CiIN8CcUXIkslWEwnwd770wXsIgEhqi+eMbiJQrkMwG+wW0/dMUzR+iJ
         ck/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
        fh=FPdFFs20Lypb4tR2ERjXU79VyEEAjxg3YedmVzNdH1c=;
        b=dLRfQabIUw6d5IMiA3kSHlI0Q8Nf95QNX7BteVeFEx/PKsvDA1iwLHk2Z8VOrjRsSZ
         +N/ZMLFCgGbHz8/CDRbCdlMxc3ryKpw0yfOOyeE/PKItvoTCeDmZVNZW/v84VlZt1PU+
         4fYRifqBXJxP406js9gxt5by/GpYz+CwNBIY1dCgfTFZxnWW/cz/Kef0kyyMQuGpBr1b
         Qs6l/5EwtVeDGtMa6Ormi+J6ZX48GoWWA8a9lZUIkuX8BraE5OobpHCICMIwSZKuKb+Z
         dD6FDio185kHpGiueJgV5KywYuvwgAzx/y/AcJ4p7ct/eqzOi8GN4K2/jquHzFATQdR9
         z8xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793318850; x=1793923650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
        b=CAMpbUEfcPZQe2FNh/d6BZ/+67nypKPYHrdo8SlJyXickSNV2ZNWXHWV2WuakoUonN
         TleR3EGOw/HINKyt6QtO8WK2r9L4JqpSIwgKOpkyJSOxy0mU8+hKYUYJShXgypz0HSGy
         OfIIRzOs1wwTkL7jk6L5EgG54mV24y/98SJ0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793318850; x=1793923650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Is1q1ecUb7pBSKWvaFfSBH1p7ZqbUFX03RWCbwfOws=;
        b=U12tMWZ3AdC1qp4erxHQesJ+DyGgkZVvuxkQuS/bWcBqCgZD3yaXF8cmNMgZAm62Q2
         jhi5nRnMclqNSGpzXGNA7N8Ym4ACmm0DrxTjVv2MbtjAw5yJzWCcj8ACS7APRqdCKOY4
         CBImVQ3pPDhVKEtZHgD3yIAi9F26Po1kbgL2RKe8I+SuMRTmqdTf1Yp0wSvC98QP9JxT
         Y6R4fk0QkzOVqFlrJumTz73lQqGyKntG9ZhVcIUfAXNn1Ic5i5uUC0PFTtmIf0d8ercq
         qJKv5Ut8L0I4314ghYckt7ZHXXi8B4+QV46Aqx8v8XsCnzfx1HgEq3vit3g/uDPV/lbJ
         Z4vw==
X-Gm-Message-State: AFq9FYLVTwuqGm3fPDg5qgbb17V7KybRrYtVr1RPBuHwB/l95VK8yuzQ
	BvNW2pPItp59YJjCmUTvuk8wj+Fr15P+DbqUpPo9lHcJphmlp582QK0FcU+LJFcVbNs64wIztYm
	K+5A82RwYxVqZAmX1Uqv0UXSNf1ZU+H3Po+4/ZUvn
X-Gm-Gg: AYBFou3tbGfzoamFtkhN63HKOVpEokmVqSUFCjPS2zCKnN8iwi+Hqn/V+1VkydBHSWe
	UC4x2jM3SVkwOtPwQ7acbCpsfdWQwFGIxLM3BERoovZNGwKY2rwR1HoyKf3thOISW44BGc4pcoW
	j0Pd6SucSDiLdQAy9HW567K3COXVqgcxhKoiWGNKHcfuv3626cO1+PhDAZUr4N8fFMR4js6CK8Y
	cjBLwUppoG5rjg2q3WN/ITs1H3LxYkdp1ksKmKyHq13MXqrWeDuyYSTbGSZ+eC6rU3rFrLZ8/fe
	UUWtU+L3yUKOo3qXry1fKTWbuEVQUnn+KmnBd03OzRNypYxtXmuzF0DU2TWKca3V+w1HX6KQy3G
	HAGmuM9sc9VdLVHWLKvXgQkFjKYtjmqGmwyE7ngLZkB6GmNtW7ttgI2m+VpRKhYecUe39EiAhyB
	rphgIGyiWJEXfZUXY=
X-Received: by 2002:a05:6a00:e85:b0:886:3a6c:a9da with SMTP id
 d2e1a72fcca58-8a9beb6139dmr541320b3a.26.1793318849992; Thu, 29 Oct 2026
 17:07:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <20261029165943.41fc74c0@kernel.org>
In-Reply-To: <20261029165943.41fc74c0@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Oct 2026 20:07:18 -0400
X-Gm-Features: AclHuK9pGK_NVXysy8qJ2rHmdSeqy6lRR3eJt7FQG_a8cHC6dh8dDfx_bs51Zoo
Message-ID: <CAM0EoM=WYGMNxc=n3j+nwyXA41SHq8o+bVvTR6uYp6HUeEa5aA@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shaos <shawnq1@163.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 7:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 29 Oct 2026 19:27:36 -0400 Jamal Hadi Salim wrote:
> > Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and namespac=
e boundaries
>
> Please fix your setup, Jamal, all your recent postings have patches
> posted in reply to the previous patch:
>
> Patch 2 is in-reply-to patch 1, patch 3 replying to patch 2.
> They should all be in-reply-to the cover letter.

I know this is what you asked for before - but then Sashiko started
getting weird and i went backwards and saw it accepted this format. I
will resend this in 24 hours and stick to having it reply to patch 0.
Maybe the sashiko issue is not even related to this but it was getting
a little frustrating. In any case , sorry ;->

cheers,
jamal
