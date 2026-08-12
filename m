Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261A41A77C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531593; cv=none; b=gB6aYyQBlAVch17Xf3kNSVjseDsiHb2yQyMhRL4iNdAmjQgZy17c0zo0gAx68FTdqx6qlgOeuWkYVg6zS1sTymJ6r+20x4zCl32pYnR/7X8J2i+7A+Pl1VDViHCJ262tmQ6vvQm9HEEnVER6MiuKAdLeOsecjN1pAxoIPPSSYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531593; c=relaxed/simple;
	bh=Y9swL09ZIp9bfzXjSHRWWOPEZ8hS7xmIkw+p2ZI5Bww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TSJ9yHiuFsiWleVPEOHUhxsHRC3ELNjSp/lF4ExogrVCcRH6CxLx5HWfbXWmEr5VT+sMZ2OIq93vWLPlLJGgwanHbKWvAHnsAAPc6+YWL9U8FzlemTDSFrL9/e0Tr/8YP3PBAH7it7esiaJeLjxWIZAK/kH62dtaRwBW6wAG1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TS76FZcX; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TS76FZcX"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47485fde05aso481364f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786531590; x=1787136390; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=We00DF4+3BigogDR3VtOXvT9GTf1WR0fMhM2uJPuB/s=;
        b=TS76FZcXxigyTD8qb18xjd5F02dSJFSIXb7tVOL36QG6u6W1zez99cjL7fAApAIwOh
         W8QksQ/o6vFXRRrHJA85oUgRR77IYTyg5MEZEcyRrJdy3N8PkwIYbgcPJumtmKFIWg0Y
         tap3fHgS5eLFlTCK2DkyQ7K+SkAtKAiyj4efwtKl/EcEM2p9xWS8EusStdd1jnsr9+Hp
         CAjXuSLMaLwj+a31EUIx/UxXL9elEZJ/57LwW5nUCxDbwZ/65EzKpSwVVw6UTSYne7Ib
         CFu06KjMQ0ZgtaU0FzaF7TF0DjYxqbPts0G8BPvkhAOSgDxsN8NPJ0Tg36P8S8Ao0l9x
         QWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531590; x=1787136390;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=We00DF4+3BigogDR3VtOXvT9GTf1WR0fMhM2uJPuB/s=;
        b=LELPgZX+DKy0PNqqHcHUxYTRKDzN16m/t1/uDjIlh6Oj1q5h/sWj9yboYJKfxhViVH
         Jf3mIr80bl+dt/Mol1B2Mh8M/zdvjXJWQScm2tnc/87FoJ6jb3uGDQEaAzYJ2g9ritfh
         NA5Yvm38KUkF71QXHVD9ZQ6F7PcfiWjioE+L6BmiQkhjkzW4svSaQ8xZGYo1tzscm/VB
         VVPgM7LkAeDoo1f4/9jw1dlFvAJQbXmlMADnJBFNgqiGA3YMjIO6IzakmzVlqFgKNM7w
         RAuy12LUpvFJu2Fg5Lh0vAezrZWMfKZR4ig9+qQZ9dMJI5D1rdXQbmP41CbWFg75xUXy
         qPhw==
X-Forwarded-Encrypted: i=1; AHgh+Rozd0yu9dZGDbhIeMQMuxD0GD578k0hbQKYVkajlvATbABmYbhEk77mH6WIiPsEVVnf4+hVOYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKKWzz6mUZk50Ox1RfKHR2wHQFZs8eKVSm4EiUmchLipAfcQ3
	FZ/BI1mioP2Xx4gbKJYMi3SmggQE/sr0/c9r3pNh62QZa3cSLpM7X+iyfBBHYN7p9yWV27Q+G+j
	3VU+OcKPxWBgouj8hfw==
X-Received: from wrou11.prod.google.com ([2002:adf:ed4b:0:b0:480:268:8efe])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41f5:b0:481:56ec:b422 with SMTP id ffacd0b85a97d-48156ecb42cmr208328f8f.9.1786531589687;
 Wed, 12 Aug 2026 03:46:29 -0700 (PDT)
Date: Wed, 12 Aug 2026 10:46:10 +0000
In-Reply-To: <20260812011056.902771-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812011056.902771-1-surenb@google.com> <20260812011056.902771-3-surenb@google.com>
Message-ID: <anxO3VT1JPAuSNf-@google.com>
Subject: Re: [PATCH v5 2/5] binder: Make shrinker rely solely on per-VMA lock
From: Alice Ryhl <aliceryhl@google.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 11, 2026 at 06:10:52PM -0700, Suren Baghdasaryan wrote:
>  	return LRU_REMOVED_RETRY;
>  
> -err_invalid_vma:
>  	mutex_unlock(&alloc->mutex);

With the err_invalid_vma label removed, this call to mutex_unlock() is
no longer reachable as it comes right after a 'return' statement.

Alice
