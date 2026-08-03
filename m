Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C3326D55
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791560; cv=pass; b=XbnOYqaRkQVx0QPqsgeFvYD+roEWP/LA5ANr2dOs281PURWD4wBOUpvPGe9O8DYC3yrpaM2vXCghtDXRqg5nyY9Nj8DLXYs/uZVbA7eC57TRZlaj4mBzI8/hOZs1lx9wfJX48bkZutDPIcDGYk5jzIRyGSsLRabpzZU+U7XlLmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791560; c=relaxed/simple;
	bh=5jJvfzzQqRDZBdeM5OEoiauFHPhYv6Wo6yFTQ3ygD8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phJSQd9QlynmACTgLA+ugfJ4+2DL24X4MpWk0wSNuasPK14b6cEneTQtXBO5FC8vL4c+RkM3oQR4lsPCTLHEYrIS0R8eFGB3M6RvlRFEMEQJA8Gitk8e6OlBT/DxcZYVwNZ6y45WwlFaydsQsfOUanp7ib3crRiE47Hpfp0Vcis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGG/UZq4; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGG/UZq4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cede6375caso38555ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 14:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785791559; cv=none;
        d=google.com; s=arc-20260327;
        b=ZR0kSkxvXshdkdu5V4pUjvv75YMsuTJpSMZmJ6PibfnkirIFf4ULUFUohlymcTfPgG
         S9kOr3CxOHLNplhN5bZXD1GBmtF0X6+gUvnq9aGNzuNffzWEpLVSLdcBsgGI5UyHqWhn
         EyKrKcM6MM6pnH3oH8BPjANeV4E0eH140jIjHb0kYC6A46xHBZzLUlY2E+UBW6PYTZGW
         dHr2I/ldXdU3FrF+RKW+1OF1Rw/3U+4FppEG3XwPdmcwrRlSIiXMQ23myBsx79MiQ711
         ok0Cb19Mm+A/skXLrrhbeEqOWKNmc0XSh/rJ975mXJofRW0bRkzfFVE3w8iZTR+cMuAK
         xoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5jJvfzzQqRDZBdeM5OEoiauFHPhYv6Wo6yFTQ3ygD8s=;
        fh=ma0dZOKmT7E47Id7nCHa40HisrwUcs9Toi6FFkz9kmg=;
        b=isYC71a18VpatpYM7rumyknDk2MkJlXjrnEBilkcWiy6KvnJQtIEdly1lPWpZ+66iW
         djqQiSr9DGrkXpwrM/7oKP8FuQQxxAWWFt5oViaatoUar6BVNaENdCP3keMX1ZSr4cYy
         FK854BTVIIp/yfG64T6gxX9aRkNOSbwvelR56jw+OGKBdOSKzPXq5P7LUW2aF7gdApYz
         KLqKwMwfl/UeOPTPdS8gMQKjcHJLg6Jx63SuCwq4eeOKIfHoFf8l0QAVdBuKvNH6MU6q
         tb914IXctcABRZ4YHFQ7ivonr7QSBc10OMO/+/oYFUkStVptB8wg4NUEQaLYxEOXr0fD
         IZOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785791559; x=1786396359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jJvfzzQqRDZBdeM5OEoiauFHPhYv6Wo6yFTQ3ygD8s=;
        b=NGG/UZq4KYNCZTTkTSLxC0nBxwsTLSJz/yIPbu8eA0FAYT41xJ66ZS+n0ulVzh6B+H
         vlo02unWbPItVdsmMlNXX35F82QR1SaOCQcWwTsSasGuoQzsVD/50LwqDd8CrqJ1vQ8d
         89j/P+s0shzjL6VxmzTDtDORWxhorXzYKP1fNoHfSme/SdaCFv4DkDmIYSkmoFVt4qta
         vFgNEHuTh9dwdmlWTo9YWsIZ/PAHt9RJnO4s/u7EIKlR+4KWBfHrIYp0jSONLLVE8lxk
         UUOMVnFcKaEKwDvd/juMbkVP2VHdmOd17+HtVavGc9GFuMCTcDzf+s8CZLw/iIi61L+j
         Rrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791559; x=1786396359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jJvfzzQqRDZBdeM5OEoiauFHPhYv6Wo6yFTQ3ygD8s=;
        b=ouhHEPL6txcIOPFbaJWg+kMBalE+uieuHvuI0Tke1Zq2SuoS0uHYX+Y1TPwmNpi0LY
         L6k9kvRqouoRVWLBHGSQED3vQ2MYA1dJdPVfVy7mbFjzDa4FAUzo0G9+u9HMzrbi9te4
         XjA39aaHdLvFwUpjTY0oNhIgtas1VO8TywI2GmWCidIVUG1GgdY0lcc2m5hbnJS96oY2
         LYmUZ2pH5QMtsx91l98ZOU4lMSa83+PsafrIN4tTea+5hfwz3sRU/ZZDvqpiIdbRDjb8
         rCPVtoJ+25pPrp/559BKIik9uff02vIVYsEHGitNQQkHjfjU/rL7ziakSIZaNks0tEmf
         B7TA==
X-Forwarded-Encrypted: i=1; AHgh+RrFz/W9QUYPiOtLpz4z8/veVu1eWye6GaQdZHkMAMbp/uAGF+DRobAbKiGvfJsBXdA80y8zHL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi40vdt00ttWM4iC1/x55ryM6m73PyoXUR+VVN1F516ZzNgsGb
	rThfCXyQat9wHWSb6RkBaq1pCj8Z0JN1mbJ5j74VVyKZfaQxMScLEIjdXVPTTX+AI6Val0CuN84
	t1lqVm1BRTQLuR4yyGA69HSYNxyXCq3O+u3tNKR6r
X-Gm-Gg: AR+sD119w3FJ1gnn5yhROghPN8iEoTlALNQC9oWR4VWXQ/6foCNzXNNNsrTQNOBoPyc
	sO3Zk7+ZKlMCg1mSkoMNkNwATeMBBVr8JpC8zN98U+9/4AWCiRSkqq4+TYUaSKF+a0BOBP41Swb
	OPKRr24WciF/eAgMh/y5vGW+YZq4dq3xiR3EV/tnHn+qTFxcwA06LwZHfAwTmVV7D3MEonNSBv0
	CsTuvD/QeUtRlm+DfOY0x8QvjqyAwt80JYY2421vEFnyph0maXfBGJN8MTUUjyHZeZ+BtMIza/4
	w1LRh8KMjpfyA50ghsTmwvDYDjxjkH+jcQ0ANU+ye+kqtIMBfBCrHfCV1JKVQd+DOw0cUu+MVhX
	Q7FXFg6GxZGgW/zZTo40nJrkoPWK/Hg==
X-Received: by 2002:a17:902:cccf:b0:2d0:8b22:22e8 with SMTP id
 d9443c01a7336-2d08dac64f2mr2794505ad.17.1785791558228; Mon, 03 Aug 2026
 14:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-2-surenb@google.com>
 <CAJuCfpGezxdaSme_QpHVq-QVeZAUaF360_Ajvkrn3QqDcSQVog@mail.gmail.com> <anC1iE21eonDK06n@lucifer>
In-Reply-To: <anC1iE21eonDK06n@lucifer>
From: Jann Horn <jannh@google.com>
Date: Mon, 3 Aug 2026 23:12:01 +0200
X-Gm-Features: AUfX_mzFwteAQxBUM4TvuzYNFGYmEeNzpupbj75hFXyN-f5Jb1ghubsN_Vgb6e8
Message-ID: <CAG48ez1=_O0g7rArdpoVwg84jOJuELEAXu5sw=TO_CWBsK=T7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, david@redhat.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@kernel.org, aliceryhl@google.com, 
	arve@android.com, cmllamas@google.com, christian@brauner.io, 
	tkjos@android.com, dsahern@kernel.org, davem@davemloft.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:08=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
> On Mon, Aug 03, 2026 at 08:24:44AM -0700, Suren Baghdasaryan wrote:
> > On Sun, Aug 2, 2026 at 2:55=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > > -#endif /* CONFIG_PER_VMA_LOCK */
> >
> > Now that I'm looking closer into this, I think we would break NOMMU
> > case because nommu.c does not take VMA write locks at all. So,
> > lock_vma_under_rcu() for example would always succeed.
>
> I don't think anything's broken actually.
>
> Per-VMA locks was gated on CONFIG_MMU so nothing there assumes per-VMA fl=
ags,
> but now you have stuff that happens that didn't before but:
>
> * vm_area_free() -> vma_assert_detached() - fine - it's always detached i=
n nommu.

I don't think that's true, AFAICS vma_mark_attached() is called from
vma_iter_store_new() which is called from the nommu version of
do_mmap(). But I think you're right that one blunt workaround for this
would be to add a hack that prevents ever marking VMAs in nommu as
attached...

> * vm_area_dup() -> vma_lock_init() - no asserts, just sets refcount to 0 =
(correct).
