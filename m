Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CD4CDA3C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217150; cv=none; b=Juz1ixRi+T8bffpH98AhpRGQpq1mZmIbDUQ4D/j0y7aQyd8wyvypsG3ZVwycPC5Rcp/+RE+sgXtGLGkzlGzZX39qYiwRBUK2iK/YI3QkjFygcPFxXf8gnpDaxaGapJC0shOXSurHUjsIZy71DyjnkNJNhD5pJdM9LVNecVhs9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217150; c=relaxed/simple;
	bh=U4bzZfQDK/LtAUZgkejsyDmUquXcxPrPw0XuH3463YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOM9Y3mhP6cNoi+ZV7ccOAiiSgCdjxgDcE7Ki2TxRaekMBNVa71Wpx/MWW1pS8Rj6koDYsXx9HEZjF9mkiG6303SdJKDtvq8pivIDRAt0hyYvar6C1j/PIlxG67rX4VRMrZ4wwHWRSZYXz28SzJqT/kowwrwlULrlGwOCVXgYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdRMFK1h; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdRMFK1h"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc4ae08cca6so121992a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791217148; x=1791821948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJvX6SjTIZtr+UUDG9pVuBrScJU/S03oDC6DwPSIBZ4=;
        b=HdRMFK1hSQ1j+hN+onE+BVufGxPJkr49xSt6wwEXwkESHuDTSiY3TwJ21LNrnwrSOX
         5JEckuLe8dLWxxWMQT/pdlMtU89pgdnKOH6XHlfRYLWmrUsUlGKSyJtagTb5GCOA81pd
         YIfBny8nJBe/JlHz2dEGrAS14cY29eRRRhfx25YOCbdDc4O0qJAWcOKoFPwgpWjL3jJy
         /mYHasiydwQ6kRhfwy5MM0Vz/hykKTuilVJnfozS2I6rbatd8gtoW5BK5nco0i/KCDTh
         tQsCB7PtjqeZ30sdalM5EYxZZmVKR6/G4h9Z9FEJjJxXWOPOW/zwiNVsFDhP1Oaewvvx
         WaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217148; x=1791821948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HJvX6SjTIZtr+UUDG9pVuBrScJU/S03oDC6DwPSIBZ4=;
        b=tGvwURiAJsH3OxjcHdI5a7SPRVMC5GIq9Ucu+N+KNd7ypa2/PkDb9VIioIzoIIwicm
         Gc01StI5Ky8yLu8QUE7quhMsYHrtXtknczuOOsgTRqH3HZTWf0KhxUMbHpMxwzTjdjQM
         WykCxJQkYOU3ex/6lj3bu0FEFO5QEkTph9VikL2vziqSIXCHc7IOH04aDvViVxghXyO/
         nFJqe81VqqpYZz9BoJ64hoEQvZ5up+rrcP7o4YHY69wrUlOiVvtUHhv+nhMFG/8Cjzfe
         epLzo0tRNnhNv/9v3Z51d/bslF2R52eVeCEVe4nyRft1NawW43AQCIUl4YND6hMXPDg3
         Nr0w==
X-Gm-Message-State: AFq9FYI206n2QDYm9SskwzvpGmdimko3/ictJHcf3yFy92roG/5ojKVy
	GLq5XHAsxyHlYoarIktNCSwYidMhPA1aeO0raHXsVyCTnWAPtijujPlW
X-Gm-Gg: AYBFou0iIJ/C82YF/cVSKx1SnpcCGV4ApHW2UVRDvOe/ySnFnkPuCufQQngJjv/SUmV
	xUmF4PT727dp/fN8bqj8885yKcvI90y17+Rc2OKPZ5EO/qKKzyvwtH1sdFSt4EUM/9D1mra4xlz
	HLtoVzcJQtwfNRhVPtfzt49zqyI0cRzyGhnAqJf+9Hl3FIayqy9sjkI0cDCOM3QwtQA0NLciOSz
	JuyGJSmqa0zwA8r3hRNOV/KngNU/utTQQPjHiz85vcXYR1UGH7UGk2uK2l9enLvTEoIzZVqAaR5
	+FgPEn7JM74qd507BC7mEGJIyoPYruKWUk2sBAt9AIUUmw0814Lmig6lXTe8Aa2gFNK0yMJ4XOc
	a/D5dt893/+4kgiwmeABgE2Yxt0O/1H0F74W5LqVbi4fiprKO9LaGzf4X5GuiV+oGQpOZ37mUjA
	zyU31mtRJDyaLALRQkGKCiA581F5ndf1sAuhdOtbf4TnRzphmG9jUStz4r3LM4s4c=
X-Received: by 2002:a05:6a00:2d9a:b0:87d:430:1437 with SMTP id d2e1a72fcca58-88c632c2355mr6569785b3a.38.1791217148410;
        Mon, 05 Oct 2026 09:19:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b069b47b1sm3773938b3a.0.2026.10.05.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:19:08 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:19:04 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Luigi Rizzo <lrizzo@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v1 2/2] docs: netmem: document netmem and memory
 provider design principles
Message-ID: <asPNJ2V8Tv2Z05n-@devvm7509.cco0.facebook.com>
References: <20261005004958.3603059-1-almasrymina@google.com>
 <20261005004958.3603059-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005004958.3603059-3-almasrymina@google.com>

On 10/05, Mina Almasry wrote:
> Add a Design Principles section to Documentation/networking/netmem.rst
> covering the netmem_ref abstraction, the prohibition on direct
> downcasting in callers, decoupling memory providers from net_iov,
> decoupling net_iov from unreadability, delegating provider/type logic to
> memory_provider_ops and netmem helpers, and the homogeneous skb fragment
> memory type invariant.
> 
> Cc: Luigi Rizzo <lrizzo@google.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  Documentation/networking/netmem.rst | 46 +++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index 217869d1108dd..57e52a947663d 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -19,6 +19,52 @@ Benefits of Netmem :
>  * Simplified Development: Drivers interact with a consistent API,
>    regardless of the underlying memory implementation.
>  
> +Design Principles
> +=================
> +
> +Memory providers (or the default ``page_pool`` allocator) allocate underlying
> +memory (``struct net_iov`` or ``struct page``), cast it to ``netmem_ref``, and
> +supply it to ``page_pool``. The ``page_pool``, drivers, and networking stack
> +operate on ``netmem_ref`` as the abstract type. Existing ``page_pool`` APIs
> +that allocate or free ``struct page`` are legacy compatibility wrappers for
> +drivers that do not yet support ``netmem_ref``. Code that is not yet
> +``netmem``-aware should be converted to ``netmem_ref`` unless it will never
> +need to support ``netmem``.
> +
> +1. **Operate on netmem_ref, do not downcast**: ``page_pool``, drivers, and the
> +   core networking stack should deal with ``netmem_ref`` rather than
> +   ``struct net_iov`` or ``struct page``. Downcasting ``netmem_ref`` to
> +   ``struct net_iov`` or ``struct page`` is not allowed unless a code path
> +   strictly cannot function without knowing the underlying memory type (for
> +   example, ``kmap_local_page()``). In those cases, to keep call sites simple,
> +   add a ``netmem`` helper that performs the operation on behalf of the caller,
> +   cleanly handles all ``net_iov`` and ``page`` cases, and returns an error if
> +   the ``netmem`` type cannot support the requested operation.

[..]

> +2. **Decouple memory providers from net_iov**: Memory providers are not limited
> +   to ``struct net_iov``. A memory provider that returns ``struct page``-backed
> +   ``netmem_ref``\ s to upper layers is allowed. Code must not assume that using
> +   a memory provider implies ``net_iov`` memory.
> +
> +3. **Decouple net_iov from unreadability**: ``struct net_iov`` is flexible and
> +   has no inherent restrictions. While current ``net_iov`` implementations are
> +   unreadable by the CPU, future readable ``net_iov`` implementations are
> +   allowed. Code must not assume ``net_iov`` is unreadable; check readability
> +   via ``netmem_address()`` or ``skb_frags_readable()`` instead.

For these, idk, I do agree in principle, but it is not true right now? And
there needs to be a bunch of work to generalize?

Should we document where we are right now (mp return niov, niov == unreadable)
and where we wanna be (mp can return whatever, niov can imply readable or
unreadable). And when Bjorn's xsk work lands, he can update the mp section.
And sometime later maybe we'll lift niov == unreadable.
