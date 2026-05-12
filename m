Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507439937C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576298; cv=none; b=VUPv2nlt5+0+Z9tLeBMs9UdKbTOfFnwWjCxJyNFnExkMfqRqZB4OY1lXKBlewVGsJgaQtZrDP7TrgTYsfeshwxiGqplOJBUoqsaZeIXKF0G0wu2zOC4CvBuY58cCVu6OTJ0VDly9ofM0PEbOUKGw+MnU/CVmMwwiN+VSGKt00Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576298; c=relaxed/simple;
	bh=MCfrd6jW5ODBYkMsqF2MPDg4H/ZD53Xrz9h2ds4XocU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI8vqacEfKvScL+pQaEajIDEHDlDkuRfZR9Ms9ObFPkk7gLSsLxw8SaxKmDFq2rqB1VptKkedJvNWba6LzO4QfpS/V3rdwAYSlGXTLNivOskfLgtuzSL4JuygnRhw7N1T65PuVY4QDLStlffTDxR+F9+Ib3lusrKCCEX/XOiSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Xifc/s0C; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Xifc/s0C"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39397d63804so60590651fa.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778576289; x=1779181089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDcJjfwRuaogDZZ2iYpIm3E8oXXRYqH8FZMjLowrT7w=;
        b=Xifc/s0CGDv9zzDQMr18OM6c13PUwynH0XUDKP0knK8WLFRwsCtgR50ub2OI5xEviC
         iBrP6Qkforw7mVJxSLDpv1WjYkSOy/z/FR+zIKVu1SDFk49SiDMpdR/RZwY+iyX9wZ+6
         lJuRRlhHOMLRtdjVwyqz8E1R0lnIJn0C7doqwS/sC9ophx58nX+CNWqafwns0xlUOcUy
         uSsLCZ4zxcZx2Z+Dve5gFM2GJYs3B2iwx7e1U3BGLzf/yeMbFGw0r5K998bgv/kYFXIP
         YYluGhk428jEhs8tvvH0vsy1fhWnb7ru8o+c2dKAk7ZtRs64lgLzt1zNjMXL8Yb2z2Rq
         JfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576289; x=1779181089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TDcJjfwRuaogDZZ2iYpIm3E8oXXRYqH8FZMjLowrT7w=;
        b=J5NRWuvp/ih5XpVEuKeQmB4epZkIja8S1mOyeuYTZ+nzIBMaB3dNnurb8N0Xp6AfIs
         mBjZ05sJgG6XZmj3qFmw7Lz2Mpop8zQJqumq+NWyXJhEZMzDJ9o4h/X6/CH++KZl8Xm/
         Qhqk3PWsbxL2Gfhc9hdKxnZoVyk7m8ZhHKuzyT3y699o2DVWfZoXhHBD/JmVcy5ttnW+
         +1vT7pB6ClmB80FdEmrrLqfUfft1ZdCcM0lgnl2La8TM4+/HlFPOScjQ8X6iFUcPTsUX
         ZzY+J/lgTVDdRdJ5pITqLkE8La7MDASwZo7riqrHeLLAHpfNuiIm8NVR+FBJwr5VRGzr
         1nZA==
X-Gm-Message-State: AOJu0Yxiootg3pvp4IkAY0S2cFXicUSrHOuN09xMKtpSqKy50iQiC97N
	snY919XXsttr6TXOrvlxkiKYGcduVSiLzzofoE96vDzi657AW0KiS+Ulr2kmM1LyRaJ214Ofv45
	yQhFpEZeF2Q==
X-Gm-Gg: Acq92OE470kWiOEy8gsCV3tN+frQdvz7d8rT4EMC5NpN/kqELi1rGkxowmqUsbq6pyl
	n6FY9bXGug2Roe6wSaDSH0zo9L1lmsoWlQxnr7Xio5r0kDDLv2Po//9Sl9D/mbB9927HLzfJmvn
	676FIteJkIaRboxtfBVRsq7QuiWnTpM7dXi9Lrbu1ixuMXPKRMMBjF+WPliuqPjLceHjLR5GZWA
	KIJiyvsgoFyGSTciSOyMQjTmrOgZCAj1hDSps2lqBRtnzYWrYKO80AaGki9SJrgN+f4GgOaic3U
	GK8Sx0OpN+UTWxLw09QFyqXDBvUmjgbub+3Ka/AbBZOxRDw/1UAbEI6ebWGjKO38Zp8NEzvzb1r
	cfCWsDtiiJ03EUg8Y/7TO4LO/qwz946+jQDOx8lYDixUmX90aluzqykGlTncaWi1G1D8c2+MG80
	oFE+Vcd6nkyqyP/Hl3nLFaIhdgkUHCxbwMHxWyV04LMQHLQ1IMOdw=
X-Received: by 2002:a2e:a546:0:b0:394:987:945e with SMTP id 38308e7fff4ca-39409879746mr41452291fa.1.1778576289113;
        Tue, 12 May 2026 01:58:09 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f18cf5sm32928361fa.2.2026.05.12.01.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:58:08 -0700 (PDT)
Date: Tue, 12 May 2026 10:58:05 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v5 5/5] net/sched: netem: add per-impairment
 extended statistics
Message-ID: <20260512105805.1dfe97b0@stephen-xps.local>
In-Reply-To: <20260509171123.307549-6-stephen@networkplumber.org>
References: <20260509171123.307549-1-stephen@networkplumber.org>
	<20260509171123.307549-6-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 10:03:26 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> unters for each impairment netem applies (delay, loss,
> ECN marking, corruption, duplication, reordering) and for skb
> allocation failures during enqueue. Exposed through TCA_STATS_APP
> as struct tc_netem_xstats.
> 
> Counters increment when an impairment is occurs, independent of later
> events that may mask its on-wire effect. Added allocation_errors
> (similar to sch_fq) to account for when impairment could not be
> applied due to memory pressure, etc.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> 
> Note to reviewers. The READ_ONCE/WRITE_ONCE pattern is to
> align with upcoming changes removing qdisc_lock.
> For some reason current AI prompts are obsessed with complaining
> about 64 bit torn read/write on these, since the counters are
> informational only, any such complaints are false positive.

The automated review comments on this patch are false positives.
Unfortunately, the review automation doesn't look at precedents
in other qdisc like RED, FQ, ...
