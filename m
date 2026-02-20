Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477383176E0
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771589801; cv=none; b=enD52inTqOAJf83I68BLxzgo9xwxBstd7noz3i5iO/vLEPri+hCPASO+VFzwPot+jN8Snlup9Wa8js47XbGCaBQF7xBSFyxRH3Bietcc0u0L+tM03CW2VBXcA1+vRHnMvWjtyxcC9LesxbLyG/we+VTqyn0uksFVXOwqkqhqikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771589801; c=relaxed/simple;
	bh=wm76su/KSHXbP9XpFDxWLEEOisiuyvETB5+Pc5yMr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ/c6V8v+Nifp+cpGzGvMzuKmOAPu7QdUJsN3Goq0QJsVxllDgvg0ULYcW7V3YxTnF/Xi/8YQWikC/990LqaMnvTNLWFqZqg2iVESdaU1KyHSGs3EIYDimC41HQsp2swadoIZ/D1PHEzZgvRUZ6YpxuZvn3DAloq/R8D1k9CBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZhsIFG6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHTSWF8i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZhsIFG6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHTSWF8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771589798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cLoJ+jp00IG6fGnTItrasTfbATFvyrsRR0CaBc2zB4c=;
	b=hZhsIFG6DSSJMPV0SF4EhyEwn0gZlZgGEIA6LuXaV+8djXM0fKCf0PmneFX4ykvySQ3ktJ
	gW86kn/dS8eQjVxjQlcvlTFcVAYN23Y+KDs9qkg0f9nsn+f4RQpIuMi2Bd1x9RVAi4MCzB
	dzstCmcAA0hHTpyCgglVH891IhExKZE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-NrJchBEaOC672NJELRDpYA-1; Fri, 20 Feb 2026 07:16:37 -0500
X-MC-Unique: NrJchBEaOC672NJELRDpYA-1
X-Mimecast-MFC-AGG-ID: NrJchBEaOC672NJELRDpYA_1771589796
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-894a861fd7cso211291786d6.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 04:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771589796; x=1772194596; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLoJ+jp00IG6fGnTItrasTfbATFvyrsRR0CaBc2zB4c=;
        b=DHTSWF8iCAOkwxTFEaj08Z9jvgLErR6HZ/Mau6OA6DhMjAKNmQg269fy2yXAtFzQoR
         Qpct3ZdR5s+iH0yvFKsOVg7FdIMDjaqVUZQjkklKnzgavAa7YXbSRvEhMFMXMjmYzSuV
         QZbTYDak3pIMWRYrcbgJq5JBC7ijV+aEDlWBIdNdbrxko2Yt0x6YqjJ914HgaX4fes5S
         KV/weHji/tkKtz5QtCv/FtuSLmCSb/5V5uvL7mZkFS81OlymiIi/IBkHXiytTNnkaJbY
         eEAezAuOARK7Y801WS4etcCG/rdhZdgAqtHgiwXkUlDZQbcQ/ShUQIMDXp/FlOxZ1ZHI
         KYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771589796; x=1772194596;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLoJ+jp00IG6fGnTItrasTfbATFvyrsRR0CaBc2zB4c=;
        b=B8f3+BFy7yeV+cyDTSMx1txiyXbndrFuszB3KRp+btGajC4yKdfA0uywoGr4v0VbHS
         tN+HQNN02FsCbMr/jRhdrR3HwWAL4DtCQO//FZYO/7bQSanilMOx3PoBw9ejYhK0tVMn
         sIpw6bPyNihzSkAHQrNIngov0Yv9LMcFUFLzoCPbqOC74T7f8hF23NgLCeDzAyIXui03
         8LomPiy+3q2kEuw9/AVGyAn/WAnf++39VNV5Px78lEmchN6bHwnGnsTMdjVa448OZuuU
         CDQEJquNcxgVl9GkF0T5pLJsyhEUkyqB7UEI2jphKgeGVnHjO6g3O88dbxEpT7H9I/+l
         tiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUVxAm/uOxp2P430dNBShkM60CUJmnBaTC/k4rFcwzjzNZTV9w6JVkgUu3TpuQohRsOXYA1jrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7v1iZ+T3mIgQuxaNzTJ66PJ16oM94cVwT1Sjopi77rLwVo6c
	oBp+UcuZi6nwIS2bDR8TkVSTxlC6YLlB6otUNfwbWAivAlb4+sv+r70r0DUAD4wOU7l1w9I9VqD
	G/RIkoSKIl+4ynBJnpgL1dW5Oyhw49XmiCyQNKCEQaaq9PxibwGQm15yNnA==
X-Gm-Gg: AZuq6aLmBj+9GE1WTNlebr4Q2/XHMHjUJI6BhTVlIi6EpRdrCsnZ9dCGIZYTKXZ1pbp
	SqdqbjgVelgGVvdhHwHn0NBiXeKdr9iaNK5cAA9vmT/SGWsLJiiUA3eyiZvUZ8+IJicKifNw3p2
	wxi1lEDkk61JWmQK9FWkvZE46+1VNQTgi64Dqe0oXnvHAw6qs+IU3HjnH8U+jsDgeQtdVO2U0kv
	otT8ilZkfKOGEW9xxmc5x1ZerMiw+dE9SbEpUIdyXyOMswSLVtH9ebxPw1mfhQ/ot0S3OOUAk0Z
	POatpjhPR2IlT3saedbg8+MoDKbhczWLSQAKczFnwCeobDZybNY0GXcLYY471pMXKNPM1iWdzbL
	8eZR1WyGrOvqYff92iJT09ArwSpkfBhhZ0/JhcZRQmkAg1+am2VIq4EII
X-Received: by 2002:ad4:5e85:0:b0:894:470f:677c with SMTP id 6a1803df08f44-897404af8f4mr315254386d6.51.1771589796247;
        Fri, 20 Feb 2026 04:16:36 -0800 (PST)
X-Received: by 2002:ad4:5e85:0:b0:894:470f:677c with SMTP id 6a1803df08f44-897404af8f4mr315253886d6.51.1771589795818;
        Fri, 20 Feb 2026 04:16:35 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdad6c1sm235678206d6.39.2026.02.20.04.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 04:16:34 -0800 (PST)
Date: Fri, 20 Feb 2026 07:16:33 -0500
From: Brian Masney <bmasney@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, netdev@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v1 1/1] clk: baikal-t1: Remove not-going-to-be-supported
 code for Baikal SoC
Message-ID: <aZhQoY55bwGj8LJc@redhat.com>
References: <20260220082210.2320303-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220082210.2320303-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Feb 20, 2026 at 09:22:10AM +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

