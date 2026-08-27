Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66C3CDBD7
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874068; cv=none; b=rk4lBOlr8hwzgu6altosdxGecWhAXprddAmhQ/n1Y2wne6G0cx9gdCaSgbn4wtcgkNKCihDHrO9UNmPJzajGviWp/vYgm27O1eWpIF9ALsGsSiWGKW2sWC2dO8eENQvxk9qd3sGu+cS4IqBWnDupDPaqrFwzRjodItiWu0WSvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874068; c=relaxed/simple;
	bh=VhXID8Q2Dlk7SGe+8uD8VtqeZ11RIRSkFnVIvMqoK1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M14q84aEIEXqc7KG4/Nc+fZ3teRFsRp+F9LFv4FLG557MRqNeTDeX5wQz6NmVCzOdVuoxpiF11ifHPcDa8JUzr9iTw+7SlVoeNmRvBCaSUU3uc8oLT3SG/1SkNr2fghHSk1imX0ypv4tFzn1QNBwvw1L4QpRz2nqmSom4rNjJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Wj4kbHJr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Wj4kbHJr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3964e480f76so656929a91.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787874066; x=1788478866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAjqfC0SW4nxG2w1tJx7WfUnmE/BSNkbt+YGxZxti/o=;
        b=Wj4kbHJraKww5MW0qB++UX3yBLjeqjvLWC5TVjCxGn8HsiYdf4mXM9gII73C9GbAER
         So4Pm+xsD4RXICdYcvRJ/WXMpDNISuAfJ4K6uz/cYlEjg7nR6zQKjfSqOVc07Kv4eQeD
         dFbXQfRggl8iWyexbPVw3y0dQsY/uLA9k+XNrS3VDeWWKvbsbIIuXcCkfnA3/PO37+IQ
         bMeFhCk6K2LY8bY+rRIsmD/sYipNHj28/hsR4edJrHeyn4ECBgPoN6wpLc1xW8Z2+dGo
         LnbEmmfrfrbRN1VvlM9av03JAx6YCJX0os+4A66yIDXfkLLZ1NdlaQNJJuuCpUukCpfu
         64NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874066; x=1788478866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gAjqfC0SW4nxG2w1tJx7WfUnmE/BSNkbt+YGxZxti/o=;
        b=pGCrJwtQ9eaHlGiCUSyXrINzhHlZBbQ1OPliE28uLJaxfDsGktMLho4kbv1lIM83QE
         Zz/MXny5IpMaRplvpx6QsWQgjEUXI7aOtUBJosV/sRYoH8Tji/SJrpq7OZLOXihniO0r
         Mva6CltA6hrmNWygMQ03MfRBNDu4DA6LFmhTCfZPwe3hSBlSGmRaisOkJwtJbXfMJwPe
         1dNgo6s+iuv9OiGWL6F0jkAksmzOvQSB26+TqyR6jSqUfmexqxnmbR+Nlt/ERxKYEm5l
         mNp8aIiAOppxwRT7O2Ij7eqDP2xvaDQmLzPNridYJNOv3r0i/dOzjFX7/nB02oR/VGlL
         2GvQ==
X-Gm-Message-State: AFuF++kFCT/CCxkCZW3ZP7Vp4jfI0hp2HOkXBNy5sMN1ie2SAwWlBmxN
	nMPG7WfJwaj5hwBGufISR0jrvNfQ7Dow6v0qtdfWtmRok+iAF2Hh6RXsmqnl6pn/GaY=
X-Gm-Gg: AR+sD122zJZUgnN6aBL0EDS9rISsxHldY8d5GsEhN1G0dwpiP31YSBgU4uMxJBVLLLB
	b+XJQoo8pryOGDApky9rmftrznlYbfHsWK/tNQkV1CSPK4qK0wYbQg17z1irWXIyDeItNj2+bRH
	x+EsxmNcGtmaPnHap+uX9Wb+XvwpiCqrrysTXfOwYCiCc/9yW6RyuSIafzPaST+OuP2w2Migp5f
	+QRUdNLyb62EqcK+MDaNNZd//zKpws2BrxTrYXTrEU38qT4+NfLL8tI1AZ+wO1IA1oSbtyBHruO
	jj0PDlN5LhYbE+zVrH5AP587H+Gu2b8WloemB1Hgfv6Veic6/J/Yxelfm2eAlsfFJsx8eJkDFUw
	s9JkTV3/Dj46DiiY29zySWcfwdq4AoUtUAxQ5FBXAhObxr8NxtYyFhh2vHqg6D4NK8R6mnV3Rw0
	/n8LzsQWY9j8ZuqUscEtZ5bPd7SzDN1iAWU6elujuLkA==
X-Received: by 2002:a17:90b:51d2:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-396d0f8ffdamr5528045a91.9.1787874066635;
        Thu, 27 Aug 2026 16:41:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1992e05sm4677116a91.15.2026.08.27.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:41:05 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:41:05 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v3] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apDLEbEu1PLTGU+f@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260827185700.2157164-1-joe@dama.to>
 <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>

On Thu, Aug 27, 2026 at 04:07:16PM -0700, Michael Chan wrote:
> On Thu, Aug 27, 2026 at 11:57 AM Joe Damato <joe@dama.to> wrote:
> 
> > @@ -3831,6 +3834,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
> >         int i, rc;
> >
> >         bp->max_tpa = MAX_TPA;
> > +       bp->max_tpa_roundup_size = MAX_TPA;
> 
> This is strictly not needed.  If we return early below, it means the
> chip does not support TPA at all.  We skip allocating the TPA array
> for every ring, so it really makes no difference.
> 
> BNXT_SUPPORTS_TPA() will be false if we return early.  LRO and HW_GRO
> will not be supported.  So I would say it's a false positive from
> Sashiko.  Thanks.

Sorry, I should have been more explicit in my last message: is it worth a
respin to remove this? Unless I am misunderstanding something, it's harmless
and while not necessary, might be more clear for a human reader?

LMK what you think.
