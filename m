Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0F3BE630
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000563; cv=none; b=X8RpaaKM2fI60M7w5+X43PN8DwOqvRO+9RD+8oSyvrJzMsCi35jZKQnQOR/F06aVf0W420pGzJHcSiom8VKpj25u6BIF1gyTWLcTakzV0JV3fGC8L1nUp65OfXmFHy44TBtktmkeRsa2w01ocve2SjRwIE5dhsZsR+t5ttWakhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000563; c=relaxed/simple;
	bh=OBF4nRNWRkXeGvYZgQo5/rE99ZlB0dZCjPG6K+A5+9o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPyJdJv7yCIDhpvWHVJojVR/uOcuCB5tkkrrh2gQv97BQMzOYC4g+Gxt4yNZpES7q7fcbtG84LMq05OMSHvlJ8T3bLuYUUEUWQkCyDCHXLvI7j0knUesY2g5Qyfvp4W3lv5d/inN0Mwi5aJtKRPCG5+z11VETxmHz9UMbURjRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUGc8WLw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUGc8WLw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b966dd74so25998265e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000560; x=1787605360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YsdJSQ5fYAT9wBvdQXX0+jSKWG1ZCV+4ju+rZFixoe4=;
        b=dUGc8WLwtjvazkOoF1yo+1IiQ01uJQWBdJne6fmCMi6VB6JzO1nUjqaSYPhqUdLsTt
         798JAwuKNy6Vjaj4fDWKIJDeNfkYLGsltIbRic1Hv1tvQzyqHZktNzb5mAL9KUetTjdM
         GyKNX0dgJGHvBAAu6lSo6ngDxW5SgC7EXLwRoppX9la+1ObVvCoqxJxKYta6d02JpA43
         BBUf5z85reOAB2CcIMTx7BkkIILFQ3emovVLokjp+YT8irdGNj2Trm3zGL0Q283HmdDR
         IVwtr/OCmL9LLWk69AtQ6EEqWUqpRUUfH7WkyXwy0hfQE3p9UzppQeEUqy6K8jX9zVqK
         9qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000560; x=1787605360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsdJSQ5fYAT9wBvdQXX0+jSKWG1ZCV+4ju+rZFixoe4=;
        b=mv/tnPERH8HWTLYJ+GXJ+FrLpo+UHvYDXtN68xUI0tJ+jQZfLttjFltPmQW9vvy1HO
         gXDBAbg5nqY+bjsOykmoRnh6bRe9mEetqrqyw5sq1VY99TQG26tPw7z/mTyves6YNRDP
         M/nue9szSnrHMnn6FryJz93WRxZ0n+TiP5SxyLPtzS9PFSGV6KdD2NfypVyRFe9KvFdJ
         hvzlC3/0SLR0sFOWGRfbVz75RMNtrpOa2Y2m1xgtt1JwgEZ8H724NoTJpKgH71rkRIDK
         056pO7f6AWiW4A/pnPuVlPoJ1Mko8/FVsn2ONlozVe1YyCTfKN9eRiqGJyBHtb6udRLx
         7QlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiJtSulTj0xrruLv7rfo/7TL4/3XxBKmIPePREt4REHb/Y5ugCyy8ZCRyp4TQx7sulhWFlDrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6iWix3LO10w6vcNSlZQA9BXJjE1rQOwPESzU+FSPCABr4FwPl
	GByFzB1y02DMJE0oTiTWrXVeTvNgOv8fLs3CReGIj8wggyMd7GTGMefF
X-Gm-Gg: AR+sD10WiP3rIhVzl6Fp2GXFwAKzy7gdzki8ula0fjtfKny/cz9OeR7/gYdG9v7lQ5s
	yrlnvCOTqXgqhG/x0VSTuzeujkNelV5xKu3wUgN3zWaVv/JbngfY6F5bw6ipz1EoGcbCuuGqZt1
	II6LC+XqF8wF/w1vy+24DYDj6Nw0YGgugxbbBleWg9UJlsDKD+JrD0nroHoUygMu3Ht6TU2BH5x
	VNYFfQdhwrlbv5XETCvjnZtffWlc6eD86j0NU17Hapf2vHMNw6NNwC7mwqQvEwbhu1ePxjjmcpK
	hpbC3+W5DpGs3JmfoiHoir5on2i50fChtCfsYdj3mwEZlEyooyr5uYFhcQQB4G1X/CjSuch/k1G
	4GdwuaHuIM1dDOWGqJp9GHOXP+6OtOZalLEg3f9z6n739sL/M04vcBVvrYlILY57nVBsEQqqop5
	AY3F7FiucFGL48JL8yENzaIpd3pOlJ+I6v6B8k823Mq+gkmLHb/sqZ7RhR8pHjP7WU8hw3fHvRI
	PyQhRVm1b+a3gIJszKXJTP/wY3iEfk=
X-Received: by 2002:a05:600c:8209:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-4998796f497mr470360865e9.13.1787000560141;
        Mon, 17 Aug 2026 14:02:40 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-21-27-15.retail.telecomitalia.it. [87.21.27.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b81748sm7050409f8f.37.2026.08.17.14.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:02:39 -0700 (PDT)
Message-ID: <6a8376ef.be1895d6.92f57.c9dd@mx.google.com>
X-Google-Original-Message-ID: <aoN2606mlY7pWZ-X@Ansuel-XPS.>
Date: Mon, 17 Aug 2026 23:02:36 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v14 00/12] net: pcs: Introduce support for fwnode PCS
References: <20260813083536.970196-1-ansuelsmth@gmail.com>
 <20260817134727.1f76d6dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817134727.1f76d6dd@kernel.org>

On Mon, Aug 17, 2026 at 01:47:27PM -0700, Jakub Kicinski wrote:
> On Thu, 13 Aug 2026 10:35:05 +0200 Christian Marangi wrote:
> > This series introduce a most awaited feature that is correctly
> > provide PCS with fwnode without having to use specific export symbol
> > and additional handling of PCS in phylink.
> > 
> > At times there were 2 different implementation (this and the one
> > from Sean) but Sean agreed that this can be picked and used in favor
> > of his implementation as long as his case with race condition is
> > correctly handled.
> 
> Coccicheck says:
> 
>   drivers/net/phy/phylink.c:1039:31-34:
>     ERROR: invalid reference to the index variable of the iterator on line 1028
> 
>   drivers/net/phy/phylink.c:1364:26-29:
>     ERROR: invalid reference to the index variable of the iterator on line 1346
> 
>   drivers/net/phy/phylink.c:582:7-10:
>     ERROR: invalid reference to the index variable of the iterator on line 569
> 
> I vaguely recall that you're supposed to make a copy of the pointer,
> not just add a "found" boolean. Dunno if it ever happened but Linus
> was trying to make the list iterators override the pointer on exit.

Oh! I wasn't aware of this intention... I have seen lots of pattern where
the last value of the iterator was directly used (if detected valid)

It's and easy fix... I can send a new revision right away if you want,
I'm already on it fixing this in the meantime.

-- 
	Ansuel
