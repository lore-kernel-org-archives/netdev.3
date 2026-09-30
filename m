Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D840682A;
	Wed, 30 Sep 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759620; cv=none; b=RgaUkKtCEjDgEJ73qyd7maGH0lMAfpzM/7OYykn/ymfBu+gi6I+zXLneSTwyYHLORzSOufscC+IA8/XraO6zBQ1fWo+BYwp8PyRYBtgAUGGjHb7LoBXSkFX7P8t2hHdCpzWAeKx66wFdsjEN/xUWQwXY0rxhWZquPKqJTmhhoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759620; c=relaxed/simple;
	bh=WkIjjnIr1FTqx6OwSGy19wcnvSGs4r1B8kuXCn4Z3Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaJuyOTm68SqYOJdfANqloR4+1UTCr8HUWi8o+VTXDL0cZOWSIJtS33mEYs2CyBw+9zEyP43TW1oO5K8p2BKxL9X9nP4vDTMffoy1u6FXiT5HAZZxVCw1eu8IJOztLUhlHimXHJZwITYYeBrvp6tdxkgifPux40Oad+N06uCZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FwpxOKCD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FwpxOKCD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cdJJeZ1bhNDcY+rf7aor9Q03O40l/Lr6ZvYURHNxEEI=; b=FwpxOKCD5anE1763qbBS2ORixr
	a3JSaXryl0itquTW6Wb66Q8D0uxKWuhV/M0EgRi7ekUoVyyAri4dmhPdvLUols0qYHvrt62ua8QK+
	CZnFHLR8N7BelbsZ8fszgYYPyROSdnCBPmMuqe2JUfUykfPyFXmAHvck5G6w7rlq6TNTxrLJ680it
	Df2bc5mz5mCXZJHdADab+Wz701i0u5gOoiRcJKszpuhesdsWwwdo0phNT1pOfqKFadIyPOPu79CUr
	2DynxtSerKiYFWVSjemcAtsoX6qAqs27yU5gLUWhQtbZN3XBxEBnUU8QvBobDmksFXcUPhqxyGnGG
	oVs8i3Mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBqNR-00000003ZGU-2P74;
	Wed, 30 Sep 2026 09:13:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4CBB2300673; Wed, 30 Sep 2026 11:13:24 +0200 (CEST)
Date: Wed, 30 Sep 2026 11:13:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yiwei Lin <s921975628@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rbtree: declare augmented callbacks per field
 with RB_AUG()
Message-ID: <20260930091324.GI88198@noisy.programming.kicks-ass.net>
References: <20260929152439.91443-1-s921975628@gmail.com>
 <20260929152439.91443-3-s921975628@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929152439.91443-3-s921975628@gmail.com>

On Tue, Sep 29, 2026 at 11:24:37PM +0800, Yiwei Lin wrote:

> No functional change intended.

> -#define RB_DECLARE_CALLBACKS_MAX(RBSTATIC, RBNAME, RBSTRUCT, RBFIELD,	      \
> -				 RBTYPE, RBAUGMENTED, RBCOMPUTE)	      \
> -static inline bool RBNAME ## _compute_max(RBSTRUCT *node, bool exit)	      \
> -{									      \
> -	RBSTRUCT *child;						      \
> -	RBTYPE max = RBCOMPUTE(node);					      \
> -	if (node->RBFIELD.rb_left) {					      \
> -		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
> -		if (child->RBAUGMENTED > max)				      \
> -			max = child->RBAUGMENTED;			      \
> -	}								      \
> -	if (node->RBFIELD.rb_right) {					      \
> -		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
> -		if (child->RBAUGMENTED > max)				      \
> -			max = child->RBAUGMENTED;			      \
> -	}								      \
> -	if (exit && node->RBAUGMENTED == max)				      \
> -		return true;						      \
> -	node->RBAUGMENTED = max;					      \
> -	return false;							      \
> -}									      \

The one thing that did get lost is this 'exit' stuff. I'm not sure it
matters, but it might need a mention.
