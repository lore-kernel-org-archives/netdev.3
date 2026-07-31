Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2702222D0
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457083; cv=none; b=HXNQQGZg6gXLKP9p4Ije1reyincT9Q0bZMgjQs3CuIoXtKIK3cozo/j9K+kpy5YDMsdvyNmC2NTYMUPZybcQFEgBL8b8TFxBkV+Q+EzSj+ypWYp6RJglTWUo14t0g+jfiN7RI2y+AHlvneMlX/kMFSI3MCDs1sBc9uM/qzyQfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457083; c=relaxed/simple;
	bh=szGFnTCsakcmVQdQfLLQUpOJjjCAEkdLGZEZAc2bHME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGnLZq5n1G2am26lFxXwKZMj/hrvaeG30zhLLiKXqhg7wSHUOC0PieR1Qd5WJcotZUIyhY7F5UvqIeplQW+9lMM2KSUCR4HmmcajH9KmdjOHYTM/F99c1jhw/OASoqWhwz0DGtJ+qLB7C2TAiOGaJj8IMTSI/icXD4GjrKJdYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv6zoMeH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv6zoMeH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso3555435ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785457079; x=1786061879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LBitaL1RUUQqXSfqSECtyVEDWdgVsoCHsw/mJvM7Qu8=;
        b=Wv6zoMeHF+IhWXRw8nHC9HMzFWrtIHGy/ISdE7yIGDPSRfEUQrXXTmmb3b+n/Zr7RX
         IC56t6eFGPlBdh2maiUx1VESxsvy0a9EFzzgvfBnRwfz3OgaUVVwU4SE63RTD1KtSjnx
         8J9Dnip4cmvzMDTVa0dbrmPFzcaoy+HB8btQdyic0uTGjcLcOd6cf/8HyeQtyJBWZ9Em
         x/Lxzx4pq3BvBqignqnUbo25NKyDMi8o2Xu1SVAzFgDtkYb1KW9enJFh+h9hEwsjIjy5
         IrzKoO/ETSWai9oCAwVv9fgZWIFfQCaFqmMcvk2OhSo/SFLYTZRroLHiEUga86Rot5Na
         VfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785457079; x=1786061879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBitaL1RUUQqXSfqSECtyVEDWdgVsoCHsw/mJvM7Qu8=;
        b=TMHocBGW+cT2qYKyKVxbzSEP2cv6d6jJzH6BiU8xNp7vR6jPxl1DFUCIVb/dXImohd
         vzjpRfsC5qYr/kI4vFDW4bEV3umP8ZHAMMvwJTjYAItxIubDNgm6MGq5SWVKJ1thKacM
         50G0/JKLMt/tqVyFXgAcw0raton0XiElknsL3DLPfi6o95X99yMYfOg9DdMj1mLuerSO
         yVtQUjQrfjQ7PG/FAvm5FBKV0bkMsYFVt3fbxURp2UUTTbBhVhr2hMtlALRjNdl+2fAJ
         0ToS3LkwNy4PGzWXt3x0v8nLK3J9BLzSnJfxFu3C1DFO+vgkSc6iG7ypluGbbgWBeQ8m
         ZCnw==
X-Forwarded-Encrypted: i=1; AHgh+RqUHW9B+ffJVo3rra7cx2HXi3HzillTuJiFZWzSyqMG0UMO3sxyoGlctx6t6SawDT2JRDzLF50=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRLRw6iOqpskGnz+NsqZuqwQ7/bxGEkp5PtNG4bqKnF6Y/Uyg
	MFLUICK5MDZkXK6+igbtRzvqiHTG/V7LEComyv1PokvB5jlFRqkUegQW
X-Gm-Gg: AR+sD10E8Q4zX8BMpM6xETDQOMgTYjsYWOTpR2OKF4omUeTvBiXjH7F0wT4hmd2IBIZ
	1/Zszo2XqjL7ypnvoHIozZxMmAdP9+ApAPRcoMwQHRG1anSu8YqxMP60O/vaRnkCI66odtQ0CCc
	5uDgRf0S7TKcF0UiCR9VejRXITJy9SU5LaWL1Y9RlmRkQ1XtosBb1E8H5Wup6vCe7MS8E5fv9bo
	ounzR+34iOEKciUhKLMV4IwGFdKpXIM/4MqMKXLlcoGaFr9GNJpJtL7l+xB6nu6nWST0Q44lOvw
	wdEvqZjQB7KRYPfv61m1LQjBusk6i8u+aOsZuzbH4kARvNyh+2XoskqZqkVsraX1Ixzwhn8/VrE
	c1K5/BD0PQQRKxjJz7kw0T7nECevSQn3CRQDt3O9YbNpvRJ6+WvanScz8i20e3PgYFGfe1w6NZm
	FGYgzFWqbQiA8Qh5niJSC8FoPlYDsMdItsTSeoQmEZg3g8Azmq6vrtlvYQ2/SxDw5wcs3a3IipD
	1TynJmQMlE=
X-Received: by 2002:a17:903:4585:b0:2cf:bfbb:61e2 with SMTP id d9443c01a7336-2d046eadd5emr478805ad.39.1785457079096;
        Thu, 30 Jul 2026 17:17:59 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c8b9aasm32885005ad.50.2026.07.30.17.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 17:17:57 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:17:55 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amvps7AAHxjvxbhQ@devvm29614.prn0.facebook.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
 <20260729191649.55ab7942@kernel.org>
 <amvEJVio9XtCn+YT@devvm29614.prn0.facebook.com>
 <20260730151433.6f71258e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730151433.6f71258e@kernel.org>

On Thu, Jul 30, 2026 at 03:14:33PM -0700, Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 14:39:37 -0700 Bobby Eshleman wrote:
> > Poking around, it looks like 231.1.167.0 and above should support
> > everything, so fw should be okay AFAICT.
> > 
> > Looks like the config is missing CONFIG_NET_DEVMEM and CONFIG_UDMABUF?
> 
> Ah, damn, you're right. I grepped for DEVMEM and didn't look closely on
> a hit. Turns out there's a non-NET DEVMEM, too.

Ha yeah, I kind of did the same at first too, had to grep for
CONFIG.*DEVMEM in net/ to convince myself.

> 
> Could you send a patch to add the missing config options to 
> tools/testing/selftests/drivers/net/hw/config ?
> 
> Can be separate or part of this series, doesn't matter.

SGTM.

> 
> > Sorry, took me a while... was certain it was a bug in my code.
> > 
> > Not the failure here, but wondering if this was on ARM led to seeing
> > that 16K hardcoded rx_page_size in run_rx_large_niov() may fail on ARM
> > with 64K pages because it will fail the IS_ALIGN(16K, 64K) check...
> 
> Ah, good thought. We've been meaning to get an ARM64 server for NIPA
> (our current server supplier is out). If it's not too hard could be nice
> to guard against that. But also not a huge deal for HW tests if they
> fail instead of skipping.

Sounds good, I'll throw in a skip into require_devmem() if rx_page_size
is passed in and doesn't pass the alignment check.

Best,
Bobby
