Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3DF43F8D7
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302710; cv=pass; b=jvRuwQQ6E8LwesZv32OiCD4A4en9VujI/HOXjmTBifh+WE5Nn9428krFeLsZNSyBN6hEE4oIPSy1cm8gsjDjeuTYTi49nlBKzppw285xykKFWdhni1eJuElHG0rDPtCsNkM9KN0/RqH6cwlbS3KKR5VdNBkfAW258AyRZWjP4xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302710; c=relaxed/simple;
	bh=cWURZBce2Co6LLpSdW/y7GirAma8nKHh0LJ9gYyKZ5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cC5w5ox90/E22SxODtcYHBFlpsJFoGG2swz+LHp1e0IF7JEq3ax1BiRSdibDklr/iqYqkPUhSYpfgCJj8gr6lAHNqxiesl0NiPtW7DavWBDtNby8+GzuAz5cTu+Qr1fm60dM5eBXDCx7VsN2bxWu5RjgFv0ocIrUe02NTyO+SVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcfN4yvd; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcfN4yvd"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-836cbcd0a48so10964437b3.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 01:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787302701; cv=none;
        d=google.com; s=arc-20260327;
        b=EdSQIMg+2TFoVTIC62nACuo8N6M7WNn/d2ZyVmL+OiKNDUC3elXiodBYVVZjcSRhsC
         K4sTQXWEm419SjF9h2ilMTGgLiphC+gQ+iBQZMdfh86fG3QMDN0DfqbM1pljICGI59MG
         KqpC/Yfn6EeNZ/ovT38RESBLdtuNwoQghIvbtpEsvvKN62SkExRymks+YJ9IkcpFIH19
         GyE+paXPj1Pa5gf2LzY2mSI5UVQaKFBptYxtPxdt5cCJWVcpyCjKHr0mWUctMGKveCMg
         BqTxDPqXPh7O9BT4uV5BHVoKipz2jbV+acjCQNt74kkkrtCEVAPdLkBUIPzEXzRTktHT
         FUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWURZBce2Co6LLpSdW/y7GirAma8nKHh0LJ9gYyKZ5U=;
        fh=ZGAYbm8GfdiwCpgqqM9TtV7VfMCdw3or6/U1lNHCo6E=;
        b=myPtFb8L0Zr3JmWHZ9P9aWNwiK7p6yEkZG+BG4zm3b9pYub4B3ubzar/P47aIlvvrB
         +nxtzXaSaUkmEp/cJcAjIwR2oRlwo2OsbzR7ISbiUye8z3OoeKwHrz2863mFH/Xecrg/
         FlPK6snA9xsZ1zML7El9i+uGaj0UXj7gdUO86//T06SWAXsqmLC0us+q5fLtFJIKEVj/
         3BJQX88JysgyL5sANPcjM75k2BB7wEPglzAxqLhPLPZoIHu1/wGAPHhzccvrbxkn3s7v
         s/2/dZW2I2Fj4ehfn5nwFuN/rfj+P/jyHtuXvvdHE20fayEPy/fYCx5tvlxHpA1MKQiF
         d7Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787302701; x=1787907501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWURZBce2Co6LLpSdW/y7GirAma8nKHh0LJ9gYyKZ5U=;
        b=HcfN4yvdd524rRs/fqfuNn+B8XE3xxrM9KMDxhrBWoz+/2ngJhmYENcUxJq1f7tGyC
         5gcroFqA7KhSu9gYFX8J3BWKcnV/sZNrBC1YHf3nfWJ+ll1Ombb5AzcKJvQ0LE/YFNmz
         0rjPdzciD5OSZ7ECl+8J5M/dhwoISCSy807NF0qkmmHSfN58ZVKlIPmKIXNS7m0Xg8au
         iqPKCsPyf5xoFYyo+hP5vrNs/VJatXO9LSXtuoAOYnL30nFnHN8Tyjp9hgLtwBhZWxvH
         YY5EtoCNu3CUBgQxgQR43kmY3bAkRlEMyLKxgFP7Y2Ko/voTS7td8OW+TUpDOYS+vDaU
         ZDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302701; x=1787907501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWURZBce2Co6LLpSdW/y7GirAma8nKHh0LJ9gYyKZ5U=;
        b=PpWzU+EKTz4KpkuvQHjZsS6/K9mWCYgt7TKU9TiMb8uRqB/DnbncKXgq9M/91u6Jo/
         k6P85kQHVln1v+h3rfld/xKVaq5Yf3k/YxXbMqTiqEHmjLSsb5rYnR8RZ8m7eRDbJlUJ
         Bay4GNwTs6gAfpHIA6f161W5BCrGuF2Vek/XxncdANnPn5mvM1OwjIoLZHPcr+avWHw1
         7KpCFHJr94rxYOTdrAGyNSoxaDQovtjpA0xfwzGPJMCjdxorNP+3tFo9RYCsyOA+5Ll2
         Xcc21/rk6TU08JCr+YSe3J2fOd0uOxeB2c/pFn1k0eOtJ1Dypqk2FJ+n0/YW+SoBS0TN
         aINw==
X-Forwarded-Encrypted: i=1; AHgh+RpAqSrrL4mJJ3ft7JOqxkbCUJjFF51jk3p7fzfTSWTDew81LTeKraWDbMr5ZJZKgd20Xi6NLzo=@vger.kernel.org
X-Gm-Message-State: AFuF++kQpJoYNk3ZE7qQW8znMP1pOQxflpoSe/oNou7soMPuOrWIv3+y
	l4SAqVfaLG0XxgReg7JYCyxR/ASOR1Jft+ctDIYcm0bz8kp0vwSwfro1URnk+yPUXd4FsDYuyt0
	FmL/pmYwJ5ZQGzP8F0UqpTvlOlT+KXfWLUMS19XUV
X-Gm-Gg: AR+sD11mnr88acsLc5VRQxSfAMT+OHY2YEgXs/JVFutKsSzIEgjZPq9tHG3Ovb1C/k7
	0m8MLottlvsxtoAQHzb9kJ/88FpPdGUDT6viJ4hDmZa+odeUhma6dwFC0pCsCXf67TKaGFLj++X
	pE4ppQNK3gUfbV/e3zeZdjZACxZSeJT+CL86oY+/vz6yFigou7j8DNPJXk5EMzYujPcFtaC1ypa
	64OZEjbCknbjL2v5axmfkh6WQ/GvzgXXyijL44a81BETxn5yUC11cedpXR8Gi/1um8Ra/v/0wJ4
	tqgHe0813xze4O9U4UFi6h9FRHhcDVOTdddoqxtImc5G0P/B+eW7mzJjAaPOsFl1d0Z63TsOtsI
	msOHSUMcSOLvBsHyAQjSJwwqdO3jhtrXXtILMqoO3tWbKQ5l63+P0NdFTtw==
X-Received: by 2002:a05:690c:e197:10b0:81e:c17d:7b8f with SMTP id
 00721157ae682-849f7454600mr18143687b3.31.1787302700140; Fri, 21 Aug 2026
 01:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821-hch_not_export-v2-1-c62b62ec459f@debian.org>
In-Reply-To: <20260821-hch_not_export-v2-1-c62b62ec459f@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Aug 2026 10:58:08 +0200
X-Gm-Features: AcwNN1W6KOZg2gyTMwlLV5UwyQrWhgQTXvNqX4deyDny_vDV1CNcKxXQyAea3hU
Message-ID: <CANn89iJku1MgH+NRPQ7s4+9d5XQ8vjKD1bBLM-VmaA=BC1Yr5A@mail.gmail.com>
Subject: Re: [PATCH net v2] net/socket: remove unused do_sock_{set,get}sockopt()
 exports
To: Breno Leitao <leitao@debian.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 10:29=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> do_sock_setsockopt() and do_sock_getsockopt() have been exported since
> they were split out of the syscall handlers for io_uring to reuse.
>
> io_uring is the only caller outside net/socket.c, and it is never
> modular: cmd_net.o is built under obj-$(CONFIG_NET), and both CONFIG_NET
> and CONFIG_IO_URING are bool. The declarations in <net/sock.h> are all
> it needs, so no module has ever been able to use these exports.
>
> Drop the symbol exports.
>
> Fixes: 1406245c2945 ("net/socket: Break down __sys_setsockopt")
> Fixes: 0b05b0cd78c9 ("net/socket: Break down __sys_getsockopt")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/all/20260819090439.GB9267@lst.de/
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
