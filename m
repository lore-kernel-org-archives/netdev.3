Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89A3264C0
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776295325; cv=none; b=GNW08ESgFBTtXKx/g0at1tBTOp/hCUfHUk5b7+OTAAviL8DHas+GjKuW/fMsTFhN3EdFMvaV0ctQD/N1Xy4JKmWmTvWID+Ii8eFNfUnW2EiVgMMePjTbFNl+GkxgoMpEzMzeXRycw43dsqr+32Pm7OIN8hBHa8b2WVxGgl7FkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776295325; c=relaxed/simple;
	bh=zuRT2gmso4pn2w4RNjIlAbL/5OOrwijPo7pSImuPVEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0ZfHLXN7gP8usySIKblv9ERy/StOtp+QxXGCS46jLNxIL0OWilvLEgjMq+VZ40DY0YjJEzULi45YKtFUydk0jwp6XctedJ4GXxp+uwcYefmQXoSmCVcvb/17X/pcZG1jgdh9iXuRO1/ypc3FGa5R/BaFklrDwh4680YzKpt1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Z3A0Bzew; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Z3A0Bzew"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Type:Cc:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zuRT2gmso4pn2w4RNjIlAbL/5OOrwijPo7pSImuPVEE=; t=1776295324; x=1777159324; 
	b=Z3A0BzewUoAXaYcZlMPDyBS3O3ZaW1RTYO7vUe0sNawifrvZGOLEdrU8MSyDHNiF0r5xSloOD0k
	cGRxW02xHHEYd7VVBWz5r+c5rFo+N+sMYTcADTijEk7mgASDtH50byXVnAPdpCaRB2W+1lSmH86h1
	jx03lgGM80iWITTDqj9/UJaRd5EnQj/jJibz2I2ApxnlBxo2VcB5XHb0hCWPYCctqydWww2rvHdQn
	zRTM0WQ0fLb/UfTE9eBOtAS/5MUpbNbEuwy4JW2drq70qeSwfVISGVkwQT1Fs/JmzKLa80bUBqZMB
	+mHYr9g8lmic3dR6houIzehwYjgJJaJfh0MA==;
Received: from mail-yw1-f182.google.com ([209.85.128.182]:58614)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wD9YT-0004uc-JQ
	for netdev@vger.kernel.org; Wed, 15 Apr 2026 16:21:58 -0700
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7991db3dc98so87296877b3.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 16:21:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKmlQwCHJzyisBAicWo3eXq745uEsXCeInMHRRSpyrmeFV37Dz
	tQdA4NSLgOC8loqMLdsw94GQ+tmO3l4bxCI3qTJzvOFaA500SkrrtSH7ibBYi4bdY4sXFj/9cPq
	pshjEphIOq1MG83uooHlOjZUbA2UWKeg=
X-Received: by 2002:a05:690c:6f06:b0:78f:bc2b:83f5 with SMTP id
 00721157ae682-7af6fcee940mr263760717b3.20.1776295316920; Wed, 15 Apr 2026
 16:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410200310.1915-1-ouster@cs.stanford.edu> <20260412134531.21341692@kernel.org>
 <CAGXJAmxCsBPJttXdvK=s2SLxFUBzTDvf6PewPo+6QkxZbuES2Q@mail.gmail.com>
In-Reply-To: <CAGXJAmxCsBPJttXdvK=s2SLxFUBzTDvf6PewPo+6QkxZbuES2Q@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 15 Apr 2026 16:21:21 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwfszU5dLnpeb_vO9=NuLa1ii7_cmEQ+czFR0dJSjCE4g@mail.gmail.com>
X-Gm-Features: AQROBzD3NSrfyrPkD6JACuTDViT6eQhlY_kUMwzZjeP8hER5PFczxEh4gO4G4UM
Message-ID: <CAGXJAmwfszU5dLnpeb_vO9=NuLa1ii7_cmEQ+czFR0dJSjCE4g@mail.gmail.com>
Subject: Re: [PATCH net-next v18 00/15] Begin upstreaming Homa transport protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Score: -1.1
X-Scan-Signature: 67f4a389e065da33eb5969ecb4726704

For the record, I have fixed all of the issues reported by the AI
review of this patch series, except for the following comments:

(the following comment was on patch 8/15)

> In v17, Paolo followed up asking about kmem_cache performance and whether
> optimization makes sense. The author responded that kmem_cache was actually
> slower than kzalloc (400 vs 380 cycles). While the author provided
> justification, Paolo's v17 response suggests this remains a point of
> discussion about understanding the performance characteristics.

I have not attempted to track down why this optimization didn't help
for Homa. Let me know if that needs to be done as part of the
acceptance process for this patch series.

(the following comment was on patch 11/15)

> Eric Dumazet raised a performance concern during the September 2025 review
> (https://lore.kernel.org/netdev/CANn89i+r6ogvutW1+C7ZDhEYKZN7WU=OVONpgnoX4EgYX=BF4A@mail.gmail.com/):

> "Also if homa does not have yet GRO support, I doubt
> skb_attempt_defer_free() is a big win."

> Is there evidence that skb_attempt_defer_free provides meaningful
> performance benefits for Homa without GRO support? The concern appears
> unaddressed in subsequent patch versions.

I implemented skb_attempt_defer_free at Paolo's suggestion. My
performance measurements indicated that it does not reduce overall CPU
usage (it actually increases it slightly), but it moves CPU time off
the critical path for receiving long messages. Thus I'm inclined to
retain it. Maybe the performance benefits will increase when I
upstream Homa's GRO support?

-John-
