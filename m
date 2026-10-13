Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CC353EC0
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851118; cv=none; b=fT3Wg5ccS4RmPULxwds3XjG0kv215Jte+4SH9he0nQ8lZPMuDVuSV4cEYPEsLOOI86wwMfy4/Bu7GvEAgB9/B5//WC0P7FfUwlqHS18y77lXOs5nKYrYbrc0Iw96lCxiWZW7/iEMHC3jmiN59UeQVxQwhM228OJ70C9mUhZClak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851118; c=relaxed/simple;
	bh=LG093uww7LbnTUDyDhW19PclZLGzv0Zjz5nJfT/MKd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3Isq5e0LzEVNDyH5Cqd8HnzFlm6n7Wrfixnnlqag0LLivDunb9Y57/2Ey+LuPx/9JtjW2919pcOOXlW/HqONyzCSjAUwkbM8/H2bJB2cf+TFAwJKrWQSEOGZVhkA6QUtDLSMMzszz9ubqGV/AdABYklJzQMNsw8uW3B4XswYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=lcgg040g; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="lcgg040g"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1c9879395so708367a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1791851116; x=1792455916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4slDk8avvcxS11+PcuPZv6eAgYX5wi9tiBvOfeAFSU=;
        b=lcgg040g59D83MbBK3l1vgYruM1bLyJtck0rAe0I5MjSjQ7oHv1qXTZ2R2aEDYFW/s
         lMtMEg/HdNhappVhdpQlCdDHhAttZOs/DyKmInupoN+F8K7s380S4a3UggOpRTdCyA9A
         oB19s4ZZftpvhamBcpFOh6PW+FSnJkgpQ8CSfs3GK0HE/45BgAiVKNDx+6rbV0WgT0Zi
         eHTtN6I941qk3t2bH5+5Hyk3NAK38ioO1+hIWgxI1drOwbe+0mycrkxWl+DfIi4hpVH3
         8d4rW0zcRADES9kxYq3g/Jh21W94dF6Vm7AuMC0oUSN1gbKxxTx1xZeo9hDHa94k3nQT
         1z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791851116; x=1792455916;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X4slDk8avvcxS11+PcuPZv6eAgYX5wi9tiBvOfeAFSU=;
        b=foRsHOj/pKILPZUxT83hB+e8rFKC2/WAFz4FFo5U8e/yyVUrMCktpOTozjrwPleqnp
         UWC2GBQ5w1fQJ6B1+/wwrnLSpSYO9HGKn/Y5gV6LWm6tNTuDbWEe7hgsi6jdZX2LyP4r
         zlHv7CIeQaqmFIouEk0BYBmY1oq8ioZ+0Y2D6/w6Q8/4WuBN8bz1SovaPMRGBF2McX5R
         GWYwBKevjiGoHP6h0EEMujZ2oZFjQa9kFeJbgXuocojo0GoddGoqgTIJEnMiz51PwY/p
         GgwX46TTX1TL4kLTDXm6Vr8QB7u3cs01ygo8pXMWPeq4HKoGA5U8L9nvBRPBOQUAcyMa
         XpXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/grxhikq2lklmlSz8X6pqvhfDWBJdwgTFnuNoBCVQpFCKkG28s5uYUQlbWmMGipARXGDWoAk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKh88FodQOhCKpvdXJZfDzXZ2albKO3B3oyJ+6dCtIuGplFGUSQ
	iAeA8ZfJH9RNuYsb4wOUwh8TLIlsBIxoHWxmWdAxqXme8e6ktNAzw3uswukhXEZ9KNs=
X-Gm-Gg: AYBFou3OzdJdeAvxbJ927CA0WAAWMspenC0PpvU7Sv5ccdTcvVgidBWUe03mgbuL/ON
	eehXrTvcRazumX+Ak2e1UMehGdNPnfgWnQjMMlxJBY2wNArKJxqK0FAPYyC4uS3CYFbChPjm+4F
	q8ZbhyPwInEykNpn9EqMsHulqFzN5VicllG1kO/HLk74liSiy9zJ10FLXdg0e17w0idbKt9gurA
	4YLs2XISiXcZPtgv6JnCV+JFNPFp99lIa7H3tsRC32eEsoLVmhrmhX2LSY8M/Te5Fw6ASaXuPQl
	AmxMgiO43sUK3d04RpIjEKIRk2vHie8QI5JuAdtZXNgpJWwvdUk0Ks+uqY2auvoHpRWsN2KENgH
	e6XkQG+VrTI8PbN6cB78dqyiRZve3y45UcsBZtk85ARzDFBX12WD4CqPqJpzHpGBke0ft8IUw4m
	kXX6vb8seGZWppJVdhszqtr+zhjOS1Jp/fnspie/BwBHP7TmZx8RDgAGnE86Ct3KFi9nryX6zpJ
	Ms6k3vQrPMgmBbaH5QYzw==
X-Received: by 2002:a17:90b:2ccb:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3ab3afcdc6emr9344604a91.52.1791851116563;
        Mon, 12 Oct 2026 17:25:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab393efd88sm11046126a91.3.2026.10.12.17.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 17:25:16 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:25:15 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 4/7] bnxt_en: Refactor IRQs required logic
Message-ID: <as16a1s4avW9BHdp@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
References: <20261012220827.340998-1-michael.chan@broadcom.com>
 <20261012220827.340998-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012220827.340998-5-michael.chan@broadcom.com>

On Mon, Oct 12, 2026 at 03:08:24PM -0700, Michael Chan wrote:
> Refactor the logic to determine the required IRQ vectors into a new
> helper.  Later patches in the series will make additional use of the
> helper.  There is no change in behavior.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++---------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
