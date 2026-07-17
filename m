Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488B2DCC13
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307425; cv=none; b=OMBlTwrENnZ71TskPxfCkKT5kIc6Ga6Z4+FfmarvFjSBLyYyZ+Yk5TpmgPGnqXHuRDqOERdwl7105SUnNt460MqthrUMOwQ8Ks6hjA4llgrTZynpinY12FYhagkD/y6vH9cs3so8QSkr04nRBwYCTlGhAVN+98XBd9tcC8DLJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307425; c=relaxed/simple;
	bh=wKs36SOVOHO3LJ8mNUlux8QFeak+dkTNaXb1CzDcfxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKGgD1crkoctbA/KKwT8o1slPvsNRRZjTWod3Y1neOxhcfQMWw9IrV6BmAnYbpA2URVSS+hUZP6t/XbrVBCvkcrw0u93/4J6Q8WWyEB7mZfq0jrEz+FhBUzE0KtOc2eDVVbZKh5aQJELK/gCD/D1kco7ttv5w3uw82miRe88GQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsUQx8IV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsUQx8IV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848882fdb18so5285956b3a.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784307424; x=1784912224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jjQtERwpEh0m+PQ7Nbhz5JQWbFkPp2mGwWfv53pig2A=;
        b=gsUQx8IV9nvoQNaRbJqUTT3p3FgXDSSYDd/b1oGAXQbiLg1CXpbs/Fttx0dh8SdRHy
         oJryR/zEbQ1TlgjgbCna8fclAzncSF564bDR6Ct7q11Pxv/RMbldjoUqw8WeQr/nOH1Y
         IXLIuuwpC3aB6IWyXfg3camudzpWbDiWtwY86h07Wvbs7FrAtSHKHIR8qEu8iAbCGikT
         jIBP892WJnlx2l+l5+/evTZo83g+B1XYxJi7YBnMkvSj4Rr11OmvJI/fwAwg0ER9Wceg
         pc/mJA1MHgchFDQKS0n86ftrpHiO8QHIEKrQGUCv60dMbqbG/dv7ri8do9zzfo/IEvNs
         5Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784307424; x=1784912224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjQtERwpEh0m+PQ7Nbhz5JQWbFkPp2mGwWfv53pig2A=;
        b=UvT6YuUql/h0cGZJBupNX2yD2Q2wujalUZM4sThkrraHMWjOEKYhOCL95/5jRCJpLh
         CHClRssIEPVbioNSfHmo1P08+aSaNBDExtKr+M0uP4uDDF3auDFMnQ2aWVPABJM5eRYH
         KMgMCOMYtopIxQENTfQ1O2Y3vWiwmNlEBG05HClYKP5PcT/GuEOROM56JGuFFbKPxmPA
         bkkvGWHSfEein/0+5EXTxuw0BSwDREn4M4vCaNbr6hEKYUTkJkFFkZram/gTyuR2DtQK
         MECO1sJxugjmYg3QgdZg82iaW4cYSNHCjV0JtWTgMXpNpDEqA+K+J+5lih/l7j+lmyxC
         rhLA==
X-Forwarded-Encrypted: i=1; AHgh+RoZpphWgQfQVh0d86yEJowwDsIj90jBpAQCeP0vdiOhgaXzNwJPjrkNaAbnTlsetAoVzaIW4zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0f/ButF1VW3SdOG/f8D0VCZv3BZzFYbdhImdJbD741KLqaDi
	hBim/mozEbvvIiZ7bilH2HnWnfLhU80lMtc+QhtTUVB78bTNKVgCegytlg8J3LELGw==
X-Gm-Gg: AfdE7clJcP/MLmexwlNti2djbOvC6HQMYcqyrIcaqUFXOeFB2gLqAXFwl9yIAPilIqa
	YlxFwVZ55f5Q2/jjtB5RTWcQ3/lR5/5sYjsg6UdAEOija0tSablr/WWtMuxk5pgQQqTZWEWn1M9
	NmYevAgMcxH9qkqXcZO/dFJERncigsXnMWJGYj0RQYvM19C4oFOf7usxPCk72YsQ8S6xXEj4Cax
	aU+hSC4BKUtKuXKaevkTm4UbsTS6xcnbck6N/bL1taJhvIjWRtq38BryDzctP4kod3E+MGCxDsM
	KYPChgKCA3oHql0IK7t6vIDSt2PUXYL1O1uRx14l7XbtjJQO6dUmfnqdKh+jvv5L0xOElf+dJzG
	J6rC/u+stg4LecuCwJJks0312IvSt8i0a72ra+bcxQ8ZVQI2zSP/G/v02gm9zSZBfCL0Y3UxKn7
	DLjy42x4SZyZL+WGmKylDIyKyWI43+biS8Ya6aIIpc1Ufb/WkWDqZBhaWEGAgZ+LiH0SO+S3gc9
	GQ4GzTgqcRCtE0dN3MlvM5KNg==
X-Received: by 2002:a05:6a00:421b:b0:848:5010:ad3a with SMTP id d2e1a72fcca58-84c294a6dd6mr4175030b3a.58.1784307423560;
        Fri, 17 Jul 2026 09:57:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e87:6:93e6:5c88:4a97:3393])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af30bd6sm1442066b3a.39.2026.07.17.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:57:02 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:56:57 -0700
From: Nick Desaulniers <ndesaulniers@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Nicolas Pitre <npitre@baylibre.com>, nathan@kernel.org, ajordanr@google.com
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <alpeswexV_jIgT5q@google.com>
References: <20260118152448.2560414-1-edumazet@google.com>
 <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
 <20260118225802.5e658c2a@pumpkin>
 <20260118160125.82f645575f8327651be95070@linux-foundation.org>
 <20260119093339.024f8d57@pumpkin>
 <CANn89iJVQe=wedLheJmjZjOTJsWHijT0jZs=iRxKssJZbjAxHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJVQe=wedLheJmjZjOTJsWHijT0jZs=iRxKssJZbjAxHw@mail.gmail.com>

On Mon, Jan 19, 2026 at 11:33:29AM +0100, Eric Dumazet wrote:
> > Many __always_inline came because of clang's reluctance to inline
> > small things, even if the resulting code size is bigger and slower.
> >
> > It is a bit unclear, this seems to happen when callers are 'big
> > enough'.

Haha, yes, and I've read LLVM's inline cost model before and "a bit
unclear" is how I feel about it.  At this point, some of your Google
compatriots have even resorted to AI for inlining.

https://arxiv.org/pdf/2101.04808

> > noinstr (callers) functions are also a problem.
> >
> > Let's take the list_add() call from dev_gro_receive() : clang does not
> > inline it, for some reason.
> >
> > After adding __always_inline to list_add() and __list_add() we have
> > smaller and more efficient code,
> > for real workloads, not only benchmarks.

Yeah, ChromeOS is hitting this now, too.  They're deploying AutoFDO
where you collect traces with LBR (x86) / ETM,TRBE,BRBE,SPE (ARM) then
feed that back into the compiler.  Then they're getting modpost warnings
from section mismatches when constant propagation sinks addresses of
initdata globals into specialized copies of list_add that are then not
inlined (so not placed in .init).

https://github.com/ClangBuiltLinux/linux/issues/2173

I think list_add, __list_add, and probably __list_del_entry_valid should
be always_inline, possibly except for the different definitions when
CONFIG_LIST_HARDENED is set.
