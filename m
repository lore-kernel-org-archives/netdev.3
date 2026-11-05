Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918356;
	b=vr+AgWjugJ7BWmJqYR0QRK8XRCeBYOB8tDhnNsFI0N2XeCU2H/8lYquH5FsUNc7FnRmx
	 sDzJ5mpQ7lnqXO9hqlaxTFkE/7S2m0TyzqnJMfp5y06ot/9Y6zat4Kp6+9tmgd8mGlmmu
	 bFsqLieT44mwrLiQMWtK3P6H13/Pqtl6S+MLz247UA+AsuUce3NhAxrLwamQeA2zDO84z
	 eMaDvi7dEuiisgf/YYtlsfud8uAqKUVpJ7f9QlRxSGl464pVCqBbvyJD9roBLScsegrv8
	 l4Gf27a7HlSEjZw2jBVJfCoeFpAw0fOGasEstFH6UTs+MAsf9K95hh0iCundYldVo1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KK1T009lBv659R3BVEe2mU9bkBriyxNyZLx4Y8BArDM=;
	b=UrvnSABoCbc5c8bPwXU2Uozrgfq9ff9d3K17fwW/1w8f+QjEx+FQz5hcsKtNeECFEPq5
	 Q3QdRUho8E//xMcu+joWAaWw5E7uwXFT5xBmlAAFyWtfonv+SSrFa4aLBDASWvcJYyGBA
	 r9Y6lHgZPaWmA6vDwZ0upDuuEIxRINtUXlJklLAzpidJjidkP0dZjSdByGyCqJTWfzjeb
	 11T4wNHaInyj0XuGMvER0F1rxaPNec6PPOho+BENaf8A7q/qWRb+/J7PgBXouhWMDUlt0
	 ZeUpSNw/XwfP3Mn4u7UQypIBgF/ZDjYHqUdOD9mwgK9WfoaAAkleVNsP+cfu5sdalVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKBkVYNx;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B712606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 22:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B712606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fKBkVYNx
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso35980e0c.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793918355; x=1794523155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KK1T009lBv659R3BVEe2mU9bkBriyxNyZLx4Y8BArDM=;
        b=fKBkVYNx8P2Gj6C+A3wKogGFFHeVVlAxr/XDwWKcaWx7D3y7zlz213sDPT0hEISY+i
         tfdEj3I3ohQnOeFFUWpJRovM6FfYgY8kcfdOlugS/khDG0HXEr9GIlO03zNhM3B/spyc
         OynAop7lwRA0ceLKK924wDIPSIWQZYTcZ5zWWYnu+ERRhPq8DJWs66IFaoMvFdp5xna7
         voqbWguXIOQ5SBCs0Qn6M4WpMQWbqR7VvwXKG5In0Nj78gut2nvSlEpOBhYDIeCvTd+E
         6zGJtbQnnsoo5/Shr9y14KM2Uy4nXDB3Yz0950j2hs4UL6swpH9owzwLPjXmfISOZ1LI
         nBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918355; x=1794523155;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KK1T009lBv659R3BVEe2mU9bkBriyxNyZLx4Y8BArDM=;
        b=mX54qXJ3kLAHF+QajcF/7SPd0BbGgXXZJS0Jr17rbRpbUCWG85KpR6cKQ9JsRQ8Ik+
         pBKaetrwHsd9sa0Qr5QJItHP5b/5hopvDI+VD2cd3/Y0ojdgA5Pv9lBVHXbneTheKbws
         656QXgFbYTvRUpEEzqi+Nd1X5JDAlpkfsR3OcqxpRsHJrtFXdZWt4vk4zuYpSKiTlCN8
         HH+V3oZN4HGNI45jabOB/hgie98PfrpdcElvr4A/k/pJ/YA9cCU+Jp4kWLRD2jJggZxR
         Hh+t9KOjIXlSuJRMVynnWY9+o0EFN8051a8XijvZXWEd47RRJOLOVHmXRg82wmirXT+Q
         8akA==
X-Gm-Message-State: APuU4Z9ZugifeWWtsn/IKpxcDtoKC2sdsejQOqNpVcME3H1+VASdID94
	bbrIxc6Z0AYCY2klRlxKdQwY56d0uEsOV/kmWr/BWXw2Lxh8zLn8n1b0
X-Gm-Gg: AYBFou3LOoqWaptpeOt8GoW8IDgmsOW8quzqqYQo21OoC0Ix8KPYZ7wP8NG+FgvJSyE
	zubPDEEXg11DtxtmfVBu4XLIu+nY4CZ7qr3cJbPDiC3/zzQ/pUTDJhbZKb/1c0usvmrs//uOMze
	OUprRhNA8zLW6BtvShmK36e64ZBuEjwrNE3jkPz5oNu7a+I9yE3Lza6An7fMZOZTZX5CqeWJ34L
	IS5FYJqbBLZff5sqXxxesLc0HLQ4CcZOHwxMtl0RDrK1X0h+aqec0j5b2UM0iY+riXXAQIZlOaa
	qAbqajogkSXoxtPvuvRFj4hCwgQh/nlDxRwAlBrtqG2Gx1r0nPbPUkGSuwbZSbOg44TRcLtty2T
	tN9eII6NdKE02UKSkCWo3t/WhBYQOgMQsitiWH+ozjkYkDUziFMu689jTDVlWksPsPYy945PRy5
	ydgMWIQUNjdgy7cHoTPHqBxoj+XEPnLNQECmPPn+FELHP6JrRKSD2Fr8pSOf3A3njWfsUSHITs2
	haygei7qzAScMGCEvp440nlCYHfGfiBCVXrkU1qVMHTzSER4n+JubvzBkVwFkdlfFVP7nXDsfTS
	qVJO+PH9x46JLRvDhI0as9TzIQJtNZJnrFBOuategQumjRJNb2zuHc86/Md23L9T0wrX9V6rFSk
	CsTXjycrYoJcipYs1Xvbw6ILec4X03ppG9a5klCBEsT0YTPf5chdmTMKkWfCnO9coYAj7LFs=
X-Received: by 2002:a05:6122:d12:b0:5ec:3e18:a88f with SMTP id 71dfb90a1353d-5ecc447eb77mr570357e0c.23.1793918355322;
        Thu, 05 Nov 2026 14:39:15 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ccb58sm50897e0c.9.2026.11.05.14.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:39:14 -0800 (PST)
Date: Thu, 05 Nov 2026 17:39:14 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sinfo@kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Chris Mason <mason@kernel.org>, 
 Kyle Zeng <kylebot@openai.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1d573ca061134@gmail.com>
In-Reply-To: <179391822817.488859.907054151678387708@kernel.org>
References: <20261105223512.3647504-1-willemdebruijn.kernel@gmail.com>
 <179391822817.488859.907054151678387708@kernel.org>
Subject: Re: [PATCH net] net: skbuff: uncharge trimmed zerocopy frags on error
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

netdev-bot+sinfo@ wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

I thought "The issue was found by an LLM." in the commit message would be
sufficient.

This was found through analysis. A repro can be built, but its output
only pollutes the commit message imho.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


