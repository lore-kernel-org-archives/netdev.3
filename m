Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A5451998
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541900; cv=pass; b=h8CqrtU2o7YgNuz/6szI0DiPjMyLT9Hn97UwBReoR6Ca+LaFITzg1zD0pYLwlD0qkVNMNDTFlgag9ra+BpeghI/IOO5edw11oKhx6MKmRYwjMeqHbL31ZYDS3Ozmp2QYf5pSbxHLrFrnkZp4MYP+/QkyszAqZRNorFjyZcNFqjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541900; c=relaxed/simple;
	bh=m/BBrvqFmoKgqI+UzPz88oy7g0FJco048yVhEoJJIog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aX0fdpEyQrxexsjHHGsyIvz7Rep2VdipTJNnYLwYhMLeK653yUTw8EjKGuPf7ArouhotmguaLMFhYbEy7Lskn3c2uhJR09kZuzqkl/180NWSFMv3wm1ETM8wUw72uzPdqG6squfR4BCgdbO5jI3awebVEiQF6Jt1FAqLw0LlCDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xph9rzQw; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xph9rzQw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c10ed63c0so236571cf.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786541889; cv=none;
        d=google.com; s=arc-20260327;
        b=kuw9rLRoxyBRKlLhyjPyPFTQbNXtUBSfpz5MWz4LYi9VMxhFKGLtJZOXXjpsIke9tT
         yqqJ6qgMoVTYOkyMmlOlyctcyRgPhWHkxVihzReW8rgMnLUqGGBpxrvDXFbWYO0nXjf3
         TNeljVejVb9lSAmKmzy2vjQ+yexFb5+D7sqguSsDLUkyl9DMwu2OkUhW9/bcWByZ500x
         +K8IN4VgbPbNw3jxCS5YLGra/cyoedNoBm/hie7xC8dUkPWVcJgiOruXyjUh7IxQ74wI
         tvkYLAXQVXSndPsQRUbdSprjRHJtd3R/pUM5ePU3afsMlyEyyOFRRX+k7xkHyrZ3tNgB
         KXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Af/S8eLr9zVnK4LInUNnEDFqmidhuoOMIoXFwHiIEnw=;
        fh=mbRZWXZ32ijxlbSDS1V9ulUWxRzjA6DDjAyNXyiwbwg=;
        b=dIJCXs9v/tpcCM34hNVW873HJ/tPox86OF7BvnQ5aa9u2S3JX0Ucm3MqxqvRMc7xBT
         BpC0lRWv1rQv7RHcjtSrIerJhedpaDiG2EoikxARgWOQI+q+ph+Q/2Gp086DW5O32Foj
         O+xkuwxSFcsN/GvzmYXPeqbKb5ZinW2tm6i+CQr0lct4tZE4sYitZ+c9RDQlUZubxwih
         zSPgUIPFg8W19dph4gopsxjmOhp9iVuSKd2KmFO5Oqfh802iZT5QQm2T5PhveFRZzEU6
         /emuuUHvx4dvzHZKRxFnmHUd8xVoi4cyYxQ72ijznd15LIYaj4hOcK8udqIMKRh12u6D
         NG2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786541889; x=1787146689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Af/S8eLr9zVnK4LInUNnEDFqmidhuoOMIoXFwHiIEnw=;
        b=Xph9rzQw9wQS0VO2JVp+6RWRJ/ufvA98IOyTtKyynGH084HtCR13R7e3wfO37gsjUI
         jhxni+t0m9z2Wy2Q3rt9WAIapodn9Gqob8uw5AvW3Mf6uXLq4vCgT6mgSJ9WqENUDGGw
         p9gmFCyj2sWABe3rOzBo3MF5Ta3u5FB09uYr8u+NvxzfX4km3quc34QmWzT5gjErvybe
         qmISkDfMsL529DWrVNhGYPVIt0Jl/NW5h1jckFTi2w0PKLVxBNIHIYYWlqaN+GSRvhuY
         CN8CJ9Z7eSaJhmQZkG7Lp3KVla7il9ZFP9XZ1Nbfkg7Elhtj2zQG+V0kQWt3CYtjw4l7
         OlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541889; x=1787146689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Af/S8eLr9zVnK4LInUNnEDFqmidhuoOMIoXFwHiIEnw=;
        b=s7zQz+D3ID+oGrcRhast7s46274/nsdrp5xYTkAZ6/qXlPbLSrRO1RRBQfbRTXCsYz
         1Nl6sdrDDm2QQct0OTWmuxXhh0dpw6q+VT68yzr20QN+7tRzCcUs8SqtnPzVqGzzsVrC
         rVCulJRk/JUz/D1mgHKaXzKiI2Yv6yvWI43H/FKjup/4kPU9p5aLkuDhnzW9XQTYzDns
         U3qnlnfNm8tMy6MUuB/Gq571Okh88juglpIMQZIeYSH4JlTPpfWdZIGH0TUJ8871Fz/B
         KOxSMxDdtKHxRaTygpz3zcfOedpVpd7tHnCT5NpjbJTC9ur3v5jzwhKwGG3UwWQWtFEb
         Rm3g==
X-Forwarded-Encrypted: i=1; AHgh+RrjKZohVjmEhb93Rgt+hOwSc43tWD9EN32QXIj/GFWFw2sHNq6eh5msXKHfAo7XT0vo+xp0alM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbqpn0dKTvK0F728bxJxz6iRto9YhV6GSHdjXqMJTbo02bVGg
	ZcnwLMpTBnUj3eSJZo1CKfO7QpGxG9SdC+B1YJL/4ponrmHGVxM0GE+31mBR3Bc5s9qKSeWMUaM
	TzB2z+iHqma/dfbfX9dWTn36KkpBNzKX9VTge+pSc
X-Gm-Gg: AR+sD12n/9wokeIZiEKrsuKRFSv3RyQRq53yeMAzppfowsqeFolgZZqokaminZRXWTM
	pOGqt+IJJmI91PfqD+cSIyX4jocf9LpmUWyzs8JhqRJKOhaGx2R9ux/6IKpno3RPe9rLv7zKkqA
	WsNfl/QjWFBUvBRcQMTHAGss1qj1b07hXhIpWug7GeLW7EdqPTgEAatuZ1o8e3fiFOnQ+JGtgqQ
	z8WuUdj64MPa+D7CxO04FQAEiwWfK3HUHMwUuQ0uMRqmnQmIxb7CAa6cWtZ/17Vhwv3Nn3gtSdy
	UbxM9BGR7kJWsORvceayjomCK9Uuoph4anwN6nEIdOLiJGUpIIO5bg==
X-Received: by 2002:a05:622a:1e17:b0:51c:ca9:3d15 with SMTP id
 d75a77b69052e-52d61fa3c57mr18476801cf.12.1786541888875; Wed, 12 Aug 2026
 06:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812011056.902771-1-surenb@google.com> <20260812011056.902771-3-surenb@google.com>
 <anxO3VT1JPAuSNf-@google.com>
In-Reply-To: <anxO3VT1JPAuSNf-@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Aug 2026 06:37:56 -0700
X-Gm-Features: AUfX_mzbFA-KN8buPIyWzFvmXLKnb07ifBNN55GX1GEWXEY0xprOs_eMrg67EEM
Message-ID: <CAJuCfpF_3W8BwJ5rqWHABO_2N7Ow8qCbTMacGj8gLTV4mCUy1g@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] binder: Make shrinker rely solely on per-VMA lock
To: Alice Ryhl <aliceryhl@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	jannh@google.com, arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 3:46=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Aug 11, 2026 at 06:10:52PM -0700, Suren Baghdasaryan wrote:
> >       return LRU_REMOVED_RETRY;
> >
> > -err_invalid_vma:
> >       mutex_unlock(&alloc->mutex);
>
> With the err_invalid_vma label removed, this call to mutex_unlock() is
> no longer reachable as it comes right after a 'return' statement.

Oh, darn! Carlos pointed it out in the previous version and I missed
it again. Sorry about that. I'll remove it, double-check I didn't miss
anything else and repost.
Thanks Alice!

>
> Alice
