Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C138333A
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255133; cv=none; b=N+Y3DM5WOKhs7iZIZl0Sp3dcz0DXNQB1/jK+rd291X7KWQd3mqld8LukwK5+h38jl8jDlaj+yRjs9YqD9p8Vn+VLObBkS5Xf6EonFNB/oTYMrqOo/CRK5IeXySaf/p8Q22wf8wkwaDd5m5Nmd0rjLI5H3e13M2otdCUi0bY04fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255133; c=relaxed/simple;
	bh=OC516aLBGgP7OfSMr8hlKfRcSB86Rj37vkXzqqMuCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIRND8Bu1Ys7YW2JFblo+UWwklAbWuNMEzHJODryCejGtNlCSSJ2qKSEJ6+P6HF47XdsyTvNYc6OTAMzra9MQ8m3lZ1b0gXkBAavZ/2r+d9yaDiWMgKbaZLYxW+qGguMTvbeZtTjBi4i07H1C3D5D/FVhuXhmRM09VhY8en9mEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EF6/dsnA; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EF6/dsnA"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-446f87b6de1so264198fac.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787255131; x=1787859931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxQ9hW+X3+brrrwHxhFqtuGXtqhzMYPhRXGIT5cef34=;
        b=EF6/dsnA1aLL0PNFTtD7Rwv1p/f+Y+L2rSVmcrmlD1jGW59eLV4FWUuCnyWgH+/b/Q
         PCfc9ZDSWz6Zw1o5BwAd8l+uh9Z9Z27CyY6On0sxu9ZLdPWBVclglFkDyyOKFHagut5s
         1WG1W5oPZO09iaaFI8R+SoLK4cd57yD0AB9Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787255131; x=1787859931;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxQ9hW+X3+brrrwHxhFqtuGXtqhzMYPhRXGIT5cef34=;
        b=YZ4evNnrWNbNsWP8U/1yk/YZbXdfs+faJnzUIO6xv08Bf3KfFpfZXSO+4K2DTQS27E
         CH7P3ePESDsvo09wsg4pJ9qDqfCEDV3R+nTEbRW8G/jjXyzmsc7mTLe5UF2qSGA6hPz/
         5pGTTQ7FQA3tNoS7WYIIPteSg4IRC4UYj0rmcOnYR2EgR9AhK+y+QRySnP5ENwHZ/sAY
         PHkFvr9+79agg1NX8eRg9XojxINQzhflsi9AeT2RDJeBIn3NdZqCvL8eK2aVVSr1SSjS
         Ut9EGOPH5x/LfNN6OqZQBFvIpAkqK8XaMoqSv0fChZ01+mxbor9lJGgKnW8grXeWrwOC
         ua8w==
X-Gm-Message-State: AOJu0YyHqolBDw61nkNU8VzBAH7ET6jhFvnfjeGEST52V0uLASL7XNpV
	bYMpw6660foTU+cBC6DxUzxaFnLAn2qlguK6y6lXXEQtNcCLBEqmrWoUkts5smixl59DJlCeXsX
	1ctngx2U=
X-Gm-Gg: AR+sD12eaq1eoAwRWmF8ImP+sdHlFTDsxzbNgBjC88MvnmfXMnwtXwDf0QTKjy3nYHB
	tdWqFHY5uDT6mVsA59B1CoVZeYMRJnOhgDXbIgiCkaDOwafKdJtPYRW/GdK5FgHXicNQA/DVHJt
	n+M68++4qZivd68YbXtsvoCDVwJEbAGdnSIVhVDY04oYQY+q+W9mXMRZ7E91T5I49xqLHCUE3ip
	nHfD9SXKaMbD2PMtkf0Xgx/DPOqRG7BV55eaiI/QaZbheHZn2dxHw2C5bl3Ycvp681OO48nridl
	Xi2BG0bI4/i35+OSdZX8udwEkeFL5BZqsKK5Cjti+362gq87AlaHnuKZWy+NCQWJgm6pZeliSRB
	2iOOroThBlDJRcibC39uAK99hUcRSg7StpP/ekqOjFDfw0clMmNd9acxmsziT1vsoy7OwZ9IYBa
	YGp2nIt+8z86erWqf4bEeu2728U7uDZRIBJcyzmVEsHQOK10nG2/IueebGz+mfLtzz2qBNlUnvS
	SNh+DqJrALQhQSLTDkdQJzbsLE5H67dwejoEAhdk/0=
X-Received: by 2002:a05:6808:13c2:b0:4b2:6ca6:9cd8 with SMTP id 5614622812f47-4b2ef25db7bmr543975b6e.1.1787255130643;
        Thu, 20 Aug 2026 12:45:30 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6ce0c3dsm2392184b6e.11.2026.08.20.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 12:45:30 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:45:26 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Muhammad_Hazley_SAMSUDIN_from.TP@tech.gov.sg,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/packet: defer vmalloc TX_RING free until skbs
 finish
Message-ID: <aodZVp2PqHnEiLV8@com-75606>
References: <20260816235646.76500-1-kylebot@openai.com>
 <20260820124253.1fd25425@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820124253.1fd25425@kernel.org>

On Thu, Aug 20, 2026 at 12:42:53PM -0700, Jakub Kicinski wrote:
> On Sun, 16 Aug 2026 16:56:46 -0700 Kyle Zeng wrote:
> > Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/netdev/20260721015824.45829-1-kylebot@openai.com/
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Assisted-by: Codex:gpt-5.6-sol
> 
> Kyle, we're missing your sign-off tag here.

Apologies, here is the tag:

Signed-off-by: Kyle Zeng <kylebot@openai.com>
