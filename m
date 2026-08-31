Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFE23C1D5E
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174801; cv=none; b=IKeEMfH5gTyFUlw3+k7nzuaQz0ga0Py4tyZxP1oklQcvbWHzpCwE4UbyAfg7nQuHuS4McnhrTBw9q9aVei9N5n6tXojsP039dS3UoJAyx6d1epleWEl+WqMtPeXI/5qOPCxVEZeuEm+C7iubEVu3h0juE7/2DzILfI5PySHmBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174801; c=relaxed/simple;
	bh=MMEx33k1LYyZYlu5OmQuopTJkf6VBtgSM707IwgP/XY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHB28rN1AWqg2N287zAnjAt0qwBkDxkOQhrbqmoBkS7d+khV7lzG0jIS1uSvsmC1j36ald56JeYIskv/j+NF4F2vIUoYIHHq2c0tm+1XIB8Bmi3EyWTG5vbn8JCb/of0Qwy8LQZnfGZCr/JKC3hhzk6a/vWLbH4WJGX+TUCJQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imqkLk1O; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imqkLk1O"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482e575596aso1418408f8f.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788174798; x=1788779598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDmovA/vEGNiV5yN5Fli3lNnVvafbmOd9G0QStilyjQ=;
        b=imqkLk1OeadnjkDzHTPG2KFnDQ3QBee8lTLYUa1Ise+hkV+4bsD1CBmsDeHZhNBjBH
         ilTAy3nLItRo3nZtgF1qNoYYkNO/p5zSm+GNay9Slqm3ytGLqc/KtiAG8uyLYecM0G7S
         k+mQHOGbo//Krl8FYJm1vBBYYuhCgH/nxuSnvYhLDW4c0Xt/aZe5Sd7pUgDB4G2i5bV7
         /0EUdZG5KSAFKCP6Pr+8loCUzLWO1RavsWpZHA165pNugrw75eFHQ4BplWAVZbslWot8
         6iWD88YzV4AyKfqArIpgpg9UFvl7TcgcI/IOJW+41idI08emm9D2aY6qw8U9YF8DGkop
         fbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174798; x=1788779598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDmovA/vEGNiV5yN5Fli3lNnVvafbmOd9G0QStilyjQ=;
        b=QG6Rz6ee4Qt//ji3Bnww273FDUqPyXHfpl1JC+8fPraCrxtBW6p6GtHSqg4P4rAiHQ
         Vz2q0U5a9LAya0rL6TNDT/bi04hBmffovUgRFILY3KZ67KkkLdPSQlgbh6PgCp71p6La
         eIoPPhd9va6cugE+DUNRMiqd1FPxnHl03LEeXzvB6KalfnJmFzLZIdVoBx5r7uqpYSxA
         yqp3AOrLBqKsPS+sBWyP/F6w4OPFO3CYqQSVTZrEk7fBTFaJt++e2N4lrWB4+YMdfd+l
         g6eeRhQWn4Oa3oCo02wqWXiCVaZCTVVG8MPMHsOWMiChlCjBLJcoBg96N4tKrja4Dd2O
         9uBQ==
X-Forwarded-Encrypted: i=1; AKwUvByecf/uMj8WnGCr1kKNNti/TEcuy3dkhsE+g0jdRLSaGBd2gPy/3zIheZYJbaauqaSQOocMVGs=@vger.kernel.org
X-Gm-Message-State: AFuF++lSuEKl9Kl7it8vaD4qWNDYNHUo0jOAdDtd7T7Yxm6YiUPVpOzn
	wMWRg8C8okBGVbOqyPjGwlJGKNpCV4oiy7Ln+VsMRH0lq/lSsUJzz5EA+kHcWNZvmMQJ+XB5f8W
	Tph1M8iMPa6jbjsmSXQ==
X-Received: from wrte3.prod.google.com ([2002:a5d:5003:0:b0:47f:6f9a:3629])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41de:b0:484:3315:1a37 with SMTP id ffacd0b85a97d-48436329b4dmr19698226f8f.27.1788174797557;
 Mon, 31 Aug 2026 04:13:17 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:13:16 +0000
In-Reply-To: <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813193433.3318288-1-surenb@google.com> <20260829185625.f5ee1b2931818843a78af88d@linux-foundation.org>
Message-ID: <apVhzM2501wSiGGg@google.com>
Subject: Re: [PATCH v6 0/5] mm: Unconditional per-VMA locks and cleanups
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, 
	ljs@kernel.org, david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@kernel.org, jannh@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, Aug 29, 2026 at 06:56:25PM -0700, Andrew Morton wrote:
> On Thu, 13 Aug 2026 12:34:28 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > v2 version of this patchset [1] was written by Dave Hansen and per his
> > request, I'm taking over this series.
> > 
> > tl;dr: Make per-VMA locks available in all configs. Simplify some
> > of the per-VMA lock users now that they can rely on them being
> > always available.
> 
> It's been 2+ weeks so perhaps a refresh-and-remind would be helpful.
> 
> But it applies well enough and is adequately reviewed so I put it in
> there for testing, thanks.
> 
> AI review might have found a couple of pre-existing binder bugs:
> 
> 	https://sashiko.dev/#/patchset/20260813193433.3318288-1-surenb@google.com
> 
> and a small rusty thing which you might wish to attend to.

The binder bug is not actually a bug. When using VM_MIXEDMAP and
vm_insert_page(), the vma takes a refcount on the page, so there is no
use-after-free even if free_page() is invoked without removing it from
the vma.

Adding an INVARIANT: comment to the Rust code SGTM.

Alice
