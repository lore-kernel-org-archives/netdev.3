Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDA42982F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131800; cv=none; b=e7kI+Y2juj94eyDPS/FDA4q0htJ+5Aa9iD975wzVZhqsJh0AnS0MMtaJoCgWZrRxwuFGslS+Segqn/Ycla91Lb/PqyAfLEkfaPe+N/TBP8xpRypN/UCrrp7s17aXWmp9A3u3JLlCCoeUc18XBRwsounXbJ8oRmYSWqL9m0nsvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131800; c=relaxed/simple;
	bh=FpN9EERTp2cRgxv8FwIJtAYQnraM8IhyGexQqnlZvxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SorTz0D33ug4XrU05P8wtwGDGAXYEIEgwAwhHP8Q8kdRmrPmb4CVCrjSawA0iR1DN784epn3zXELWuyb0xPncq0r5+wxJbHDYO1C/LEybveBHV2IsorMdleFEHp+0tDg7hqmVWmKpuCLugl+57nFPHkt2h4prbStDZISm5a4Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=A0N1iQsY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="A0N1iQsY"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cbc593a67aso52436285a.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772131794; x=1772736594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNGl2PacRgY/7eEMD7XjUPhLqO/KH21uY3Hc8HdE6Yw=;
        b=A0N1iQsY42dgtKBz2p8VTyl2CrF7Df6aRgM0yWMmfR8QZ/cbjlWqs1zMIvlCxTxtdc
         zdOCyBcuNhGKejE9Il9ZQoJJg58l1s4H5ZKndsWQ3lujGuQPYRDc/VrpJRCQXPArhD9C
         iWrdZup1SmlKVbb/MfTh6wtcWWRIRGD8NVKKByA2ToyCRZAQIDGAnJaTAWyIl2vmbztU
         UMvnSh/Jr+jrIn3sBSlI4owdLBaikWOOSK5offDWHq2Lreb98SP9nL4itZseaOFSshx1
         8FToskLhvz8ccT0K6xx7HDxOX+gUzxP70T006dckRk0KxnisNTDhDc4mcusGcwXjqZ2a
         oojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131794; x=1772736594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNGl2PacRgY/7eEMD7XjUPhLqO/KH21uY3Hc8HdE6Yw=;
        b=H50PEaIifafZaSWA7WucJ0joPjKzenJWTgJx89KL30dOS5nOWwulpHaHa61RmhJdak
         CIfKKmDCspyirkgAwbDl/4HXXiBXqLyuZY/imNhbaMHK4BSSd0u9mznFLtelwzB0QVJp
         DeQ5QKw/Hilq0dawQwYisU/STCiKyDIRKp0SHR4HBHhsvCArRldVNQi7GgpYc2whBN8u
         IcCKSzFpK0i6REhuunFwe+xA2LUj7un5VfvXr5fen2l3E1xRG/jIFhXR6/RUE8HLD/Zx
         9MoDY7I6Hb3wmyNMGuCjTW8v6NqX1bPz7ZycrAS8yrWajYOE7x2gFGQ5wQ3pwXPf1/ln
         aQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUXIv8xKyJLkSAjo0npzNBNBwp6gMoslxyBAE3f3/DkoFKqcflm2hNNljDCGJaPyXB5c1iwFXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8tPUH20rUcFM/9kfibAWUvIwU46enW4qWpoz+RmLPcqpert/s
	MBzMRF9D9UVsdJJl1XqhfMuLPPRC6Kfkm8k/XwAS0eB9YnPIZ0N30FW/ezqiMpRF1wQ=
X-Gm-Gg: ATEYQzwnMBvwNOLyRL+b4EEjsgkH/M4BtlUBoiC4NYCgOTzfJU4fLMA3aOUXHWMm5L1
	UMb+CqlCCuVei7EqA07BHQwPLR07Gt/FVGDXWoKBeKHsD8oONl4OBZJs6iRfIH/8vBZVy0OPP7w
	fo3k96ZXCX4eSisVgTPDiA333EYLFbBKlk5X+vgOwGJNwI7l/7Ye2ayZcGK7x4zUyGts0xBNg7U
	jE+hxzzK35OKApz+16rmkmzbteycd/IJMTXumwLiXMS4o0G3Dmd9zR7JtRB4aHic5Y+cAaxFYiZ
	xQ+Hh7X/pPWmMs2PRHhMUzewnd01O0EAs8iCQsMaZexg3CVbja9i7rS9zbvMpPNDN/MLCVlZ5h9
	m9Vzn06oYJkbJjFvCo3iRCdDblbeegRSe/6khogy219fO/G7Ts2ZBB34QF0vbSx99e2Ta79bPRt
	RqYD2pAOXmGiiQdc33XcmLp5DuXUAwvSQa
X-Received: by 2002:a05:620a:25cb:b0:8cb:4f63:dac9 with SMTP id af79cd13be357-8cbc8d70e6dmr1400785a.17.1772131793718;
        Thu, 26 Feb 2026 10:49:53 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm268217885a.51.2026.02.26.10.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:49:53 -0800 (PST)
Date: Thu, 26 Feb 2026 13:49:49 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, ziy@nvidia.com, ilias.apalodimas@linaro.org,
	willy@infradead.org, brauner@kernel.org, kas@kernel.org,
	yuzhao@google.com, usamaarif642@gmail.com,
	baolin.wang@linux.alibaba.com, almasrymina@google.com,
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH v4] mm: introduce a new page type for page pool in page
 type
Message-ID: <aaCVzc2lexW0TiPf@cmpxchg.org>
References: <20260224051347.19621-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224051347.19621-1-byungchul@sk.com>

On Tue, Feb 24, 2026 at 02:13:47PM +0900, Byungchul Park wrote:
> @@ -1416,9 +1413,15 @@ __always_inline bool __free_pages_prepare(struct page *page,
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		folio->mapping = NULL;
>  	}
> -	if (unlikely(page_has_type(page)))
> +	if (unlikely(page_has_type(page))) {
> +		/* networking expects to clear its page type before releasing */
> +		if (unlikely(PageNetpp(page))) {

You can gate that on is_check_pages_enabled(), to avoid a new branch
in the !debug case.

Otherwise, the MM bits look good to me!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
