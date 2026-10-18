Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71306347C6
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289009; cv=pass; b=Np5Kl77hBwwNeN/y3CvwY1gN8PLc/UtguROMT+9sGRx/CNQBfkJQlqZKZaAgj97CbMgRwUgW+oM94xIEhqrMu6PbJr3s2AH1/J7/OJ693sojbIJMHj1DH7zrkQStjmlR38LCOb0KxQnEEpmvWpOryQtBJrt9rHvEwu4hcxD5onA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289009; c=relaxed/simple;
	bh=OFvFUXE9xCFsK6/kBrpheywoSYe93LHItZLxp7xrWHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aysHINSqO2AKjDULQOKgEn3HI3NcJx40wgSRIP2iodl/vxQo12uSs1hwUv/rzeJ//oU87ltuSTCiHLsz4ZeyoMA51HUsZtP3Y+UGDqCecd0GoNNxRYC+9fqucW7KRlVDnlr4HUZekR1W7yJFG4VXT49PrEHAi1GPVhe4uaVY0oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=Nr0pP7vV; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="Nr0pP7vV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b056d58f2aso7839187b3.2
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792289007; cv=none;
        d=google.com; s=arc-20260327;
        b=Q6dUxPA4bwqjkedNjmyZsdyBGdY2ThwZHI0OLtAusGKdPtIYwNHFMaaYVm7TgPFPv4
         rPA91vSP2EuvsyLY3Ut5q06U07gOfvyEvtNK+UckIhY/BsFAwov4Sxtd6OGSsCy0ZzxB
         WZ49ebzeg96Xy/zLoCdN5+wOrdH1riXH3HlxJCNy+vZv4orvwSsqJVq2tqjRkdqgkWcZ
         95Ch9wnuUg5PTzag0O0xVQONEEMyJnn30ON5Eh3jM219EAgVoHOV3CDtb/fdn2wqxMkJ
         bCO26uGrtuI1U+qM/i2MreiqBlfXSUpX27Yrhwryil1weYKztT6uJa+6bkgVXzR9gw0E
         lHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OFvFUXE9xCFsK6/kBrpheywoSYe93LHItZLxp7xrWHk=;
        fh=XbDDdsyV8SRUF9GQ4My+3UbCL8dGPTFiKH5ArMe/QPM=;
        b=nvLWplWnWSZ7ZqQqMxI2/bX/wE41ja9ZwBw2FSt/w041wEKIoNp15rP0bqdgzR4fZy
         cjrkUzJjQWKOhFEQORFIVQinXvmU/5ixwL/LQZpnXpDcOwvxZZexoG2gU9chmQ74oCBz
         /n7kZZp24TeAAoKJkFwAHXfxS4IEBGaN3GMO3dDzjmhn1/uLuCtss5+ImvVQ8Li/hAsr
         7UGqwPbkaRFXZ0n9xM/RiooYInIyjD0SGDDsRSLYS23PUvIilj/snqZZaU/G2vPA4EQi
         4jfro2mZ9QNgkt8ruLs1h/gEtOStpWGvlM+z3QE6ZwrNMFUbeJSngOWU7EGeZ6JiEVF3
         BXbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792289007; x=1792893807; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFvFUXE9xCFsK6/kBrpheywoSYe93LHItZLxp7xrWHk=;
        b=Nr0pP7vVL4KeAR6PNJUeqzMXTnHsB97OF6gWi7jtNwt0qBvNOE0UvtQk1UniP2sCJg
         5M/VJIGIjHq+HPOlyRCYGgFq4+hcpvO/Gh7ouWmtqrJ8cOL5UppFYGMlGuMVnyz1Snlw
         JBLVKi3sWjDJ5dn9+KjaPSyVf1n8233GRJLMELG8kbFMKdotnD+w9Bt+04wTuA+d4t8A
         NRkR4oB9cTTtFiV1C3NDR9W40SApTrVU9m6y/4wWZMiNOOTTd3y+aJ/lOH4Z6k2+WrMr
         NsNwbLmjdsJ+PBiQl+QLvuUd2q63FglcqUflYsp2CgrbeXe5k3TQDgUUSxzMjniDk+xl
         XfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289007; x=1792893807;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OFvFUXE9xCFsK6/kBrpheywoSYe93LHItZLxp7xrWHk=;
        b=oMuUa6SiIS4mbu8nsISMJ7pMNk55nTohf9vP5i6HzwwZyvHobv6lNR/oiMLY8c9MMW
         jn0Lt6PrxPcwVjL0vLyfA6UW+67MerQmN9etdA0APzlI7fg1PR9rzZ2LeWKhi4KB24/X
         TD8HKXHl27eBpVVt/9U5VeW9GWUsIEj32+qbGZLMcV/B50ekucTH6+qwN+KizP5Pz35b
         ca+lXSGuVTbrGz0Fw3ZUBixkAAE5fEiqhGtwyTizFNbu+Nkq6pCvbIXkyUsdFjlRqPyU
         6qlOtrFVnTVn+gSe1YsVcE0dKcCg7n1WJNYCcuQ1Y6ORrqpMlHkEhp7kGEQgDsDN9G1u
         COhQ==
X-Forwarded-Encrypted: i=1; AKwUvByN5Y2IaAnPHqe9LT9FaGfki22x09UyQk5VW2xdPmpO8IxnRxFREErantkDA76xR3Lc3pw0z5c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIi/OezlTs73u+/nuuujTLCLc+xX/ct7kDlhlqczhq7BzKox8vy
	RvpeGLlZFrY878CIaJg2NSLJxnNRqVlxr+vYFYH59Z/daUfttDS7cFNEoPpO1oBO/Xl0y5uUVWR
	OQjRHIMceIP3BGPb9/A224O5lKhqmlyP+LIGQTwCX
X-Gm-Gg: AYBFou1rHUVz7Sj/oUugBPOp5Ea/KWDu4MylAs59LHHZYmo+8njY0bCjWYJQIEZfh9U
	VwnsdOGn053D7QNSyk1DAy1c7o/yvCXDvBnBtW9jPqnvRc41DKWPZDGYCzTIT4Jz6aJzL4w4a/M
	+TBk4pkzoqCA7gBij0maHfFImysoDvIBXjYSWWB5S1u0wCD4OoVZgr65/oOiWW5DQc5CNT/SvN+
	4j+lsPbbuu57e3izGX+gkCsvbZWsXNtGsxbUeKr/1wRmf2xq3m9frxa9YIe+mkPjwBBOh5u0bEn
	EVu79aSM1l79VP5cZC+LLULVFuRI9we+AG8vJ7pkbuDEqlu1pYFCYT+8yH90WBLrmngHhoxb1+q
	GJkUiEvIcO0QK7wlB2Wdq8QsjG/sOnu3rlGqW+c/D3Hceu13JuGbnvg/rW6KahhHWgoLX7t0FBP
	zpSH4WYttRHQxDAxMJOA/T8GlO4IsRTJ+hfFsO/kYGfD1OuW9rsB2x/qIcgCg5hhKGV0otdj5PR
	fhZzwtvpxd25Lw6PZ7aXvdr6ZNVYiAWsnAo9O+ls4XwAwjkPTOZaTcyhKSfZ0JI/L+tbrtKMvzd
	1Qd3ju7z4sK4Zw==
X-Received: by 2002:a05:690c:c4e9:b0:8b0:f04a:3132 with SMTP id
 00721157ae682-8b0f2163601mr11361017b3.27.1792289007350; Sat, 17 Oct 2026
 19:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004171628.3544978-1-julius@bairaktaris.de>
 <20261018015434.3326758-1-julius@bairaktaris.de> <atQoL7WUM3BvDwbI@chamomile>
In-Reply-To: <atQoL7WUM3BvDwbI@chamomile>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Sun, 18 Oct 2026 02:02:49 +0000
X-Gm-Features: AclHuK8LcA_x4fXjqJQJo4qGB6xwiKVubMehR2hBrYfUz8uLAdhaaMXVC05SGRY
Message-ID: <CAC1t37JX5HnbU4gPxAE-PkNz=6e_pr2p6ujgEB-3gRi0HjXybg@mail.gmail.com>
Subject: Re: [PATCH nf-next v2 0/4] netfilter: offload a TCP flow whose reply
 is never seen
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de, 
	coreteam@netfilter.org, netdev@vger.kernel.org, geldot@protonmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

That would be awesome.

I will continue the development downstream and send the items upstream
after a merge one by one.

Thanks for your time!
