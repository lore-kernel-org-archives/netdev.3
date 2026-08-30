Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA113959D
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788127880; cv=none; b=ktEESxHVpC66+TQX3QWOOjCbm2DWgwntzqDn0ItGn8akd7xHX9v1CfVbkK70vFvVY2uxbX4xjNTzfkxZvYR21pPEoQ2NScnUXmu9llNJTlpK7lbs+mAlqS/b3eoAm1kreGCoiQ6wKKf9dz/60yslu/qHIEiPYhW1kAr1aSgsyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788127880; c=relaxed/simple;
	bh=2zXSAYsNegag5NXEriA9Zj45P81JpMcNiRSHg4UVj2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smcVnCzZgc3tF01xor3GTJqvrmcAwUYrNYflPHZTz7EdBwHYBbL5D+++ANwAr+S6KYl9wa5QcVSCb4VkR34BP9v4nJ6sLRxDoWEyEp+yr4/faQA4K5b0lLcIBh2+u8jBgLzllY5SvGjjXpzwsQeJdVjxgfBj6NbGqyBcdnlQ8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8kMtGP3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8kMtGP3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so2673009a12.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788127877; x=1788732677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2zXSAYsNegag5NXEriA9Zj45P81JpMcNiRSHg4UVj2Y=;
        b=b8kMtGP350rdbfOsFX3ZqyIrxgcggt+Vx3wZfXBdQMGsrdYtGTdW2SnucBKDPMpkot
         4uJ9+SRzlJFWhKNSxX9DG1k4g4mfENF1MWVefpQmH1J5AbiiQUuNp8uoAHzDhCioyjJy
         l3Un74c2UVqrAr5tt3ARxhbkS1h8RjUZWXtRIwQkDax7BqDR9ZShF2x0o7LaWrBFA0Gr
         uypSt2gT+o/6YiPRJ5rBcOx2A7uRevpaoSpmaDI5dDKYjxvWvz3Dxb0QE6FPA6el2Ylh
         Lbr5ir6++OTifo7760oI7oRpi/DLZywkCu4RRKefZAIVdNhbNK+sUTtloMkEIL4feAiM
         ycsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127877; x=1788732677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2zXSAYsNegag5NXEriA9Zj45P81JpMcNiRSHg4UVj2Y=;
        b=r/N21mMDOz/xwMCdiBhXxAxNF1ibc6uh9zk/FePGvJHBWPXJM7X+eqDO9I6cJSPcQd
         ijUXOYHrIg4sVtjRu/bUVj7DWqKj+IHuwBKrCDeC5WoHVp9PBlMmzFOtLABPNnqXtTL1
         ggFKgcw16ROE0GKm8Mm9w4wJPbx9bAhtvExSsdoxuVJoimQnrANZAuLhZZ1SZW2zLbL6
         9vPGgTHcsT+8MryBkCq4sFUj7zzwOxAZcf/1PkKkwva9PD4hDadW4+4Ao2SVkjDImW82
         rgvZ8DqBp6oW/uqYiSzO4ce9DGI4p1eToq86/tGo0/sLe6yu/6JQbXiHaGGaxFZ/qnE1
         m7Sw==
X-Gm-Message-State: AFuF++ngma3G6gGt5p2K5hsTnxKvxztb2h0NocTERv536jzYZmqQg0in
	Wl1wY3L56G7hReZAmkIDAxD+Gk3eWRxLgBiMSeYF6uMQkD6FudAZshUo
X-Gm-Gg: AYBFou0ghLZBH7ShPHLx3E2dOMO8Cx49peFf9SohdRjPrn79114oKBF7E0PjUW1P2Bp
	+OYdSnQ94TYN5W+6WrS2CCoBZshoHZ0dm5kEmqmSaTxh/wxajJQkUXhedY8KLeibDEsJuK0QYwq
	Hj2BB9BB2yGSUHgl0UhLZvHlR+WRRKmHwQZyKRnqri+q11uT7QsB1d8MXylVBga+sEbURHW49AX
	0IQJhzdSmDxboAwkoeEB344tbnIo0bZpHMPIPz56GdFa+BduTXtOEKDLbxJXkrf3m/0cOAwOB+/
	xvGRDtkdRRjuuBS9Wpy2DE9hR7Zg7HtAdOIfW/lVHJfSxksWEcON001MfhsO+eYkJGBLo78tsre
	4J5Fnx5+6xu2zVBpebXy1yAHu4XEQxWGVZxY5252OogrACXCFOFykyLNEVKGojJzv1GZbTfoErj
	pnEzeT4f+byk9ZfR0fqee0Gi5KKpq55Y92iN5GCUno3BH34mpup2JUhNhWZm+4VD3goKtwGiREb
	mXx+PVUn6qvXvOWn98/8gJFPqQoHzaGskDkjN/NswIFvtAUoDXlXNY4wStCcAQfwWZKGHXV1Pt0
	88WS+DW8Fxf5CdgvYcoW0oq7US0oOFdkw/l2Ex3zFzlMfZ19+qyPwDnZ
X-Received: by 2002:a05:6402:1ed6:b0:6a1:fd14:8832 with SMTP id 4fb4d7f45d1cf-6a60d3c8b6fmr12523036a12.12.1788127876853;
        Sun, 30 Aug 2026 15:11:16 -0700 (PDT)
Received: from fedora.home.arpa (77-162-219-136.fixed.kpn.net. [77.162.219.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611b675d1sm2933128a12.9.2026.08.30.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 15:11:15 -0700 (PDT)
From: Bruno Xavier <bfxavier@gmail.com>
To: fabriciogava@gmail.com,
	florian@schauer.to
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	lorenzo@kernel.org,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	bpf@vger.kernel.org,
	Bruno Xavier <bfxavier@gmail.com>
Subject: Re: [PATCH] net: skbuff: keep the page_pool fragment offset aligned in skb_pp_cow_data()
Date: Mon, 31 Aug 2026 00:11:13 +0200
Message-ID: <20260830221113.1238112-1-bfxavier@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830212331.546227-1-fabriciogava@gmail.com>
References: <20260827122926.31123-1-bfxavier@gmail.com> <20260830212331.546227-1-fabriciogava@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 30, 2026 at 09:23:27PM +0000, Fabricio Gava wrote:
> That version has already been sent, by Florian Schauer, the day before
> this patch -- "page_pool: keep frag_offset aligned for odd-sized requests",
> now at v2:

Thanks for linking the threads, I had not seen Florian's v1.

> xdp_copy_frags_from_zc() does the same, net/core/xdp.c:700-705:

I mispoke in my own notes on this one. I checked system_page_pool for
other consumers before sending and read it as having exactly one,
net/core/dev.c:5619. xdp.c:753 is the second. So fixing skb_pp_cow_data()
alone leaves the defect reachable through the zero-copy path.

Florian's patch is the right fix. Please drop this one.

On veth, drivers/net/veth.c:762 passes its own rq->page_pool rather than
the per-cpu one, so I don't think it widens the sharing. It widens where
the misaligning loop runs, which is the part your reading of the Fixes tag
gets at.

I have the reproducer and an A/B kernel harness here. Building v2 now,
numbers on Florian's thread.

Thanks,
Bruno
