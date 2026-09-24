Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5773DDDDB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279184; cv=pass; b=lWN7A8Y3Vva4RuuA4TCUOQaMaAyHe46KZAvfSDPrGsNc1Mwr4Z9lGHjBuZeNKp4ueOLNF0YtoNYBwf7eMuppgTOnyAiCVD8lyM5meFqVXHwYdRyCWA6wv/qiw4Ml/E/x2HOWdWyGR8BD9JhU7QztmeSkiI6ZJRAAJh9NcjfcsZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279184; c=relaxed/simple;
	bh=cWBBE5NKGRnMa1w/IhPdQbTbTPbXKFZ24GCRjXXb3gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htRZtPuEcsZF5smRvq2aA2T5fWw3ToOg9JvC9V8oqjAT0imZEgX91JgBE1lCL7hVg3+fCcgd7gFHzdvEDIKFuau5iWqJbvhfrFXyMmG5iEwqLNCXJkWxX318It64iZfhXbEH/n2QsqW34cPWSVnXgjsdMxEZsNHwPWlnwpJ8Kv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cellusys.com; spf=pass smtp.mailfrom=cellusys.com; dkim=pass (2048-bit key) header.d=cellusys.com header.i=@cellusys.com header.b=aHbPOj0F; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cellusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cellusys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cellusys.com header.i=@cellusys.com header.b="aHbPOj0F"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a64b06fc66so361721fa.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790279175; cv=none;
        d=google.com; s=arc-20260327;
        b=rTg0XhnIGHP6o9UtBvOoW6teJhldPXwzAOeoXEXmyLypM+OVAXtsp4MEJQTbVDzFbY
         w1Ovz/BWWbUdE0o0+BG14WszOyXLq0+iLliAcALiMKpqd7mz25S48dOQg0Xtkvss7cWX
         SzPGmxExg9QxcF33rNOnYsdB/HTvwV23n+RxNs6o0CY+SVfDOFYPNZ3o92XWLqIKq/lm
         QMUMA6NFRzh5uIe7qO0I5ezs1mcGyz923/DH+zzORDKSe7H66C+69liAA1BSsjYnNc7R
         NrySsrxuFG7kc+w5wU+/iEJf0HPGvfpw1wq2iA0rR3DfiWRm5DX8EaRnhz2anoe/pA1F
         6exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1uYTjFCSvnfULFVrptjRLphPX1S8KB2IOyYhkGGsRus=;
        fh=6qw2cvpMOx/l9AexFYWhHTrvA0+vMC3KIShUN4svRjA=;
        b=m9m77tmcE56JLTDmq+BIFWenEiPEoFGOYmiKz8x8+ENxignHoo266kcKnoICPQTHPs
         /I01n3i0NrS7lndeO7fpGJ/W/hR1EuBF7WYHgLA2HC8fwuXMDJvhaLsBuAjbcRmgQbtY
         BCXZTxh8v2HQKD1cAGgQQyEWhGv9YneipW4iTdrVRMI57XYn9J7Se5CTjTbEBIXAdNaT
         F5CwvZXlmTR2QE5IkD9H3f+yrPkHMQDzqcs1IgEhihN3xgXLcNU5vV7An4woQoF8elAr
         2iUH8zYMJjIvXd4haJsg+6ksUQsL6QcjO7Ydejss7mgcwyNmpbz0+1eh7+RPmXgV5xjT
         uPJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cellusys.com; s=google; t=1790279174; x=1790883974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uYTjFCSvnfULFVrptjRLphPX1S8KB2IOyYhkGGsRus=;
        b=aHbPOj0FgZOQf2zJwspaBZpbo/FoV6n4/YRL/WexokbtU8FgdBWezDNeOsoUd7dGoO
         WUlRIW62fcEd1xgbE4luXS9MFUdjLoyLOqncU0BC2WhsCdCHYXJYEWMJz85i07q9tiUw
         xHV+ZSiRzaMgrJ6iGtaOccIV169UyEqy2oevEg/iGEHbviBNtQQuNJDj3uBehywvttBM
         wSay2sS5vpKgvyXVFG+sLDlldMZ2LZSGPQ5H9fNBAuPVIbyR+qKT8fpi3Yp/RBJuSQTs
         YAjmcXnwvOjU3KNEG8A3OQtiI+2DcjXnAkZgEU345mJep/lz/P1G7JXRHWc+YGrCm2L3
         zo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790279174; x=1790883974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1uYTjFCSvnfULFVrptjRLphPX1S8KB2IOyYhkGGsRus=;
        b=Bub57uO4aCp8eiEmzrtVw/AUPiTKBBq52WDc9DrAXA+HZsHDqJE/U63ThxopLPUGZ4
         oB7aSFoHrNHElSYLNL1ib8zSRcq1Zz6Ndozd5KvX35XzTIuINQaRFYu+ONCvx0EA2kAp
         HtvDc1itOvR/94GYK2kOnIb6NcvNF4QqjVqMQh4BBIqd5xl8S0CJrmTJ1d69n3elQFHN
         8cRxtqONnsdQKwSoKtH+w1YMCV5kZ7K34ZsqQbMqVavenMSbd46OPT87S9mE6sRnMyft
         5begVwIwKU63M7Dz7dKuIfOUPy71Xl4hs3+9GQyxHZ7vvuFZMpi2zlLlKxmNBImq6a8Q
         KroA==
X-Forwarded-Encrypted: i=1; AKwUvBwkreRU1FdUQB7A+YbysRahSHUPaIEPdbD8bUyLYqXdYO1J+rZQ4Yg1j6qd6ozHFzeIbwNgJRI=@vger.kernel.org
X-Gm-Message-State: AFuF++lnKom3B4PZdmuK9OvZsxyTb9b/WCgKcSpM4NB2ZQwMEFQMgnvk
	G8NDFrBcyPntGf3qVIZBidTqfc5nFyHmgJoD3f72iUQWtdKqbemeq3odNa/oYV8DA1nKaS+N1d1
	GyXnE9qDoek5IDSzD3QWpOEwPbLjaCGymOH4Ah4L3Yg==
X-Gm-Gg: AYBFou0CwrFV4fE5voSIEcPcewIa/FafHlWZ3HNsjx57BPr8gwtensnwT0eqVOZXc2K
	grnGA3mrEa3aFqfyhDdNSTgTb4snimZUStg+cmmytUAE71I0b+qdRTmmZB+E76itM/vYwYmZZZL
	uPO2cco1xpy8FLrbXjW371B4K22mhIon7rilfaditrr/CawHWcTH/zPWnmw3J4GUjRcr+ORrWLF
	Xu0kzMgm0/WonjwTMxlLoOm5XqNi2M8bRvMT6SYvRC5xFYTgBxq6dI/ngfLONBxFP/3Jx7TjNTh
	ADWCVaUWLPubPoOBm4KiPSaL9b3nkMRmFCD3y4MigtAOKf8mGAlpl8Va4sMtR70oSw==
X-Received: by 2002:a05:651c:54e:b0:3a5:f982:9c92 with SMTP id
 38308e7fff4ca-3a63c061c09mr8269281fa.7.1790279174670; Thu, 24 Sep 2026
 12:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921135733.577647-1-wbriggs@cellusys.com> <179021514567.2160803.16218616091479610626@kernel.org>
 <CADvbK_c2P-qxJJ3sCDLJMpCQ4g6PaKVN3kiLTiXYx8UREmCZWw@mail.gmail.com>
In-Reply-To: <CADvbK_c2P-qxJJ3sCDLJMpCQ4g6PaKVN3kiLTiXYx8UREmCZWw@mail.gmail.com>
From: Warren Briggs <wbriggs@cellusys.com>
Date: Thu, 24 Sep 2026 15:46:01 -0400
X-Gm-Features: AclHuK-O0oW-wMX0yMzGjTG_pFHVFuxMN8-cHfLCwcd4-GHCZmAeQO04RntgfNM
Message-ID: <CACjaXw6eEyjeJ3YS+b-xQr89QDRiQVdD7fKH2OzA6V7SQkBo7Q@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: carry peer capabilities across an INIT collision
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, marcelo.leitner@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The testing notes describe ASCONF and RE-CONFIG appearing on the wire, which
> > exercises the outbound counters (addip_serial and strreset_outseq, both set
> > locally from asoc->c.initial_tsn).  Was the inbound direction tested too?
> >
> > Should the merge also carry strreset_inseq and peer.addip_serial, or
> > re-derive them from new->peer.i.initial_tsn the way sctp_process_init() does?
>
> Makes sense, please follow the suggestion, and add something like:
>
> +       /* Re-derive sequence counters from the peer's Initial TSN */
> +       asoc->peer.addip_serial = asoc->peer.i.initial_tsn - 1;
> +       asoc->strreset_inseq = asoc->peer.i.initial_tsn;

Will do, placed after the peer.i copy so they use the new Initial TSN.

The inbound direction was not tested on v3. I will test inbound
ASCONF and RE-CONFIG on v4 before sending it.

> >
> > > +     asoc->peer.intl_capable = new->peer.intl_capable;
> >
> > Would calling sctp_stream_interleave_init() and sctp_assoc_update_frag_point()
> > on the surviving association after the copy address both directions?
>
> Outqueue may already have data at the time, we can't just call
> sctp_stream_interleave_init(). Let's drop the intl_capable update from
> this patch and address it separately in another patch.
>
> You may add a note for this in the commit message, so that the AI review
> won't report intl_capable update missing.

Agreed. intl_capable is dropped from v4, and the commit message says
why and that it will follow as a separate patch.

> Please address this one as well by adding:
>
> +       asoc->peer.adaptation_ind = new->peer.adaptation_ind;
>
> either in this patch or a separate one.

I'll include it in v4.

v4 to follow.

Thanks,
Warren

pw-bot: cr
