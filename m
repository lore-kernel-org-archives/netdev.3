Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D544A403
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616007; cv=none; b=OAe/48tS5Sl+kV6OSOlLPY6LeMHKpr7bXfAmMvwceU7UVw6uefRJ01CNZavgsd2GrJVnKM/cTGKznq58EkCxbRYb34kDzYvLTfATY13ilmBPSxLRURxdnSJwbzdfreh5YPsixHpP3TtEJpxXTlOOsVK5LORH9QRa2OHgeO7i8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616007; c=relaxed/simple;
	bh=VNqAjouGl0DgXdxFLP6U0GGMMmgOOvcbRsPlNLCe8ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhbMk7/M3OBG+vWV5JYR5TyNsnT02TgIGbkckwmQHgzrl+uUShuE84iJIrjwyde2+dca0npewpDkqB7F/TdHFqOyxYL13cxlg+mtRjwv//wZ/jG66eSXyNY14L+/gaBeyrZ2ZjrGLQY0d1c1Fz9Qt/yyUYA4c9WwSBve4sLkpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtbo/9XV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtbo/9XV"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1853534f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786616003; x=1787220803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NrOZueBhFN0ZmDbFx88d1p3GnP8LNGEUfoQ4yi+QHNY=;
        b=jtbo/9XV2tH0QR5G2RUxH9hE4YKvpr72lCsbmYeqgAH1nwWjhzyPBkoPmJLJpTTxhU
         oBKrtsdvgtnlvywZgCf2Y1Xo/jPXfWMV/Q0k/pksbfd3L5NnJjAsUmVRGbpG71wOUX1q
         Gzcx0ayx6pcFfpTbYuZNRrYiV+DInCvxOsikgbsTK21DTmwPXphSqmnmEa7Udbhk7PXc
         3HU2I7AvZEC3Vhbn1WWtAkrxhdHQAYF8UVSOKJ1N2kbqqZfoij+D1uGxs52zP1TzWMXe
         5MSi3M7uEsruXoNjhWzLNtPICbyh0eCbQkcS+Z5+E81Tq1s00W2oHtgaCE3r4S1y944+
         rhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786616003; x=1787220803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrOZueBhFN0ZmDbFx88d1p3GnP8LNGEUfoQ4yi+QHNY=;
        b=mK3RE8TkWm0HoLiihPyruT+hs1LpbR38jT3IRRbNvPTs6QGAMtaVkNs5sZmIjmv04x
         DoX3TMuqyj2zAU/X2HMzVkJcWVwXDOEYaJ0H+mQy29jHOqJAeHeO5qita/woG02XvXCn
         V3QTrbBrdPAgRKuRJzp/YLzMdzQaG3rbvi+Z2Q3ZQbKEixh/QEME49O7i5E0d0FuzdZE
         Rj00w6q2Ehgw8yVNT3XXTc4h55WpIPqK0dhXaLcJiz8PDyvOai59//Oa16zuBV0nRgYH
         h63ljGqRajlK8++Eei+lBPGf90grP0hmr+kHN4DU2NofJCRbVEHyv9r3p2264h+MSzvE
         IKNA==
X-Forwarded-Encrypted: i=1; AHgh+RoUg5k1kqmVa2ZmxCcVwpL2Hp0uE+0/ol94jwUcE2ZzR2S4p99mCnqfImEbk0WVMl94WKDkdyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9XuLkAYMlFuX8BbzZAYosl25Z9PtsLLV/uM+OyU0Qi1zirgJ
	jRuaOzTeE+GDJg7nXvnVsrCGxPmJMTGzGgUctdP87VfwG+/DGHpSTSAh
X-Gm-Gg: AR+sD13TpfT6O+cjHYd29F7COvkVHUptkmRIKg44rQTJkQgXBH2WNyQGURtOx6Ue0/g
	Nnbl58OJ6xLQWOv51JOJBWbsN9AFPTO5BRQAWEGh6Sqfety82RiJ4hV5TEKBYvG87I1FBfiOX+E
	dEBUzJ/wDK9GKzBRxARLAo3GXDvl5six5Bozr2GNIfSkXhqZIy6OLYuIivEOcQQS4k8VO12bD9p
	noAqWCHNaloiH6IN1riVvNhX3EN7kvcOWoaTpp99W2fEBJnnqA0R1TPsupVm4E7CUll9jCdmi9h
	AyKjeRbh8GEXBkhpNRvrcqkM4KLjgQnAeJoxOCRWgpd8sNgdANp6TyzP9oWrAyh59xuC+OWbCnv
	X7JXkqz4nWmA/IMHM2ops5xOe7u8HjjR+13DVH6I39beAjnJ/IyeQXhexLvEyU1RQTUB5hV8xIs
	gAu8NThCOV2N9jHR2IOVss6MUql6RlZex3e9p1jYa/mWqWqCCpC+nP9SKkNBlZrysHqsFgybo4x
	gsTpMt/0Ebu8JQKvfy+
X-Received: by 2002:a05:6000:1a8d:b0:481:5ba5:9927 with SMTP id ffacd0b85a97d-4815ba5a034mr4000236f8f.9.1786616002724;
        Thu, 13 Aug 2026 03:13:22 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56981csm5227397f8f.10.2026.08.13.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:13:22 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:13:20 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, sdf@fomichev.me,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 5/5] selftests/bpf: Add ksock test for async
 callback guard
Message-ID: <an2YwKV8qx1wXkcA@gmail.com>
References: <20260812154328.72834-6-mahe.tardy@gmail.com>
 <427cd292151a90f499819620700c9c582f1b63348d91d8727eee4200c268200e@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427cd292151a90f499819620700c9c582f1b63348d91d8727eee4200c268200e@mail.kernel.org>

On Wed, Aug 12, 2026 at 05:25:40PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> > new file mode 100644
> > index 0000000000000..5b9c6cc303922
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Isovalent */
> > +
> > +#include <unistd.h>
> > +
> > +#include "test_progs.h"
> > +#include "ksock_wq.skel.h"
> > +
> > +void test_ksock_wq(void)
> > +{
> > +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +	struct ksock_wq *skel;
> > +	int err;
> > +
> > +	skel = ksock_wq__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
> > +		return;
> > +
> > +	err = bpf_prog_test_run_opts(
> > +		bpf_program__fd(skel->progs.ksock_wq_start), &opts);
> > +	if (!ASSERT_OK(err, "run ksock_wq_start"))
> > +		goto out;
> > +	if (!ASSERT_OK(opts.retval, "ksock_wq_start retval"))
> > +		goto out;
> > +
> > +	while (!__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
> > +		usleep(1000);
> 
> What happens if the workqueue callback never runs or blocks? This loop is
> unbounded, so the test would hang forever rather than failing. test_progs
> has no per-test timeout, so a hang here would block the entire test run.
> 
> Adding an iteration cap (e.g. a bounded retry count followed by an ASSERT
> on callback_done) would turn a CI hang into a normal test failure. For
> comparison, prog_tests/wq.c uses a bounded usleep(50) before asserting.

Unsure how likely it is but it could be indeed improved in this way.

> 
> > +
> > +	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
> > +		  "workqueue create rejected");
> > +
> > +out:
> > +	ksock_wq__destroy(skel);
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886

