Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F43C0A02
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671970; cv=pass; b=TpSYHV9CHDezNgE1IZO7gB5/KJ61ZyrI3Kece/q0bI1a9pO6qQYWncKOBuuKG6JphBpuiSWJQNUfUtf4CkVUvNvqJhaYJF+8T8qhrP8gT+qJpJSaasraSYhkiZx2LkBd3nWpl63zWkFf5/Mb6ddVZr/BnAVPc3w1ax/Wif4La8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671970; c=relaxed/simple;
	bh=H+7LkQADNzB0cXhx5A1s857U7lWmk87SJ7hEPe8oOa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsJUi917KYY13/RNL8/66i/3dx4KBXnYqllidINF08fqrCf5QVIl9jmwBxhwGDNIU+dBNwlM0sne7V6jubp7IXyUf0XNWqIefzrpeLvdF0QulxiFZ9AneL4s57lgi3kWYx7Z1mOGkIkQSfzKcbMXyoPf/GVBA95cD8PPn8KR1cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N++S9/fg; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N++S9/fg"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-848643382fcso12889507b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784671968; cv=none;
        d=google.com; s=arc-20260327;
        b=DmyOeXoEWMnmtBC1rKdqFbY6YUxTQDm35CwnVbREkqPxVZdegdmUgBFPP/KswDoa/A
         mHIPG/K4x/dC0od4XYBJfoWdoYTIv6k/FnJo4v82Mj9bjyz1QmYr9EqLVASpiw45HkR/
         FFkFXye7lMfEZ3GqV1cZVyY5pnXFgfCkiXJhBKKnc7RVbRmRyDPcPkmCXyObh3KuxxSK
         SNphS/z2nkpSOgXTVyUVNzxr9B/eosmHkwnARjQek7z/7DQyjQhF85PTkgP5JKi3biH9
         Ggu1jWg5Pf4hCXWo59SLOZuNv66s1USUbJzqBB6Y3bC3mZ20uf/pdZwfyvociXB1l5lz
         9G/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYVMxuiA54aa9lgQfdByJFmIx0IDKL8nOBFRc8WiSV0=;
        fh=KLwVJK5x4Uv6oGtS3d6KgM2Joj/0PsD0MF1jfoVQqsU=;
        b=oHnSEVQRntds5dTVGzPyvN9a+74WuaEfykCygZUj4Myn4ch3pNr0lIza4cwPvRF7vV
         Px9ZEQBPQWMPGwb16aqYplEh0b+kzDdRQmkvPZq5WsJRB+nPnEGO92Mt1aWQlsa1P7vr
         6lv4pKRmrQU1aK/POrWZ4Aig24fJv+aoJfRi4JGvSo2HBe0TVnnAPVZOnwLXN7f4la/t
         uSxpPyOpUsbHnqRZo6ePZqBVmDbRCEC7OaYfWV97gDtfoKpKYMJ6w+t2+ubxaxSIKsjW
         EI+jabrUGjXGSyU4+s49E3k1lRYsyCeJWjacodHwCmpLtLLzD06ahy0hiTkFUhEvnoE8
         PROg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784671968; x=1785276768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gYVMxuiA54aa9lgQfdByJFmIx0IDKL8nOBFRc8WiSV0=;
        b=N++S9/fg5hEplY19R75HSK4MngF29BldSXMpeoVeIJnuy/ZcgDizosnRlTjrMJ37Lw
         YqcnUmr0FwOaoGRnd7WqaQ0MESZ3xic/xl9VNWKCZuuneGl1pMNsmItXM2JpGu/UejbY
         fF4N6nG696Vfy2y9QnjwzAO9CjPwRjEBaQzs+pDSw5YRDN9x3gZormwkNjT4mObKnRY5
         E5WffiDLRH5sFr9YO5kq2rRuQPew3kVcMBOSU5xVVWIS2q/jFJfgGgNwPwbHgBzajyQQ
         QWPzzppQtriFW93ZqksYR/9srEL9K7N49kbkvcfDkp6org4XWeMdtpzILXXJFfNU9g58
         Vn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784671968; x=1785276768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYVMxuiA54aa9lgQfdByJFmIx0IDKL8nOBFRc8WiSV0=;
        b=tTQs3hFMHZG4gal3eg2PzS+wbcg5OZm9VvFP7hVMuI0d8zhqHQ4XuMzmbafS1NuxY8
         dRAwLVxMf26sw/Zx4qTeIyFM7H1guH5XZH+LwNJ2BHarb+RUxHAofWtYx+JMzbO1McKo
         4gf5AFluLs2klsCAAwmSKGqVKCaBgGEnWF4Tkwx3yJGZ7IwsBq6JD76jDytI+iFV6FLJ
         yxxN9CvcAtaPT5kLGjiU5gaj//CEGDsOh76995m7T/4x2zgunfsGm0imG6qjdCGdGqfh
         /Zyy3BkW8viBGx2nSyenalRz8KenRniascl4BkSEq7a44TdMa8ahwjQi6i/+BspKM0A6
         lPEA==
X-Gm-Message-State: AOJu0YxoKDfHRFYs+AL2O3UkMdvh8BifpMS8Eg89zvm4PDGEa+XN/myE
	XW2sslTKU5XI6xBn131QAQc4uNWqDlkkaMi16x/F68QUOMYXOiWrxkjvY6QQs0Gm3O89Pa5Y7F3
	heC8ho/SWqeG4Oo7n1qkx80ezCOGn+DE=
X-Gm-Gg: AR+sD10lKzP/tqzLw6dR763dkpb7zgokKufyjd29uskTuvjmVwlVKweilE4BxJfW/+z
	LSyxJcXFHVae9DezrBf0v3Ez+Q4OWxtbzI+HdqSrunjv6G41ZV5+KS19PUQ1E3X9+UzF62GDgie
	ODKUTLD5udQqUuiYZsS0BM9faGFXlk79k3RaW4PORoRe91NLGTDACAbP/4HbhWE49VzBHlBkYv4
	NLLUe3TLxDm6WNfLT7fPkMFRlFyEyb+44BmpOJ286FuWuZHEaz7wwdQpAbkuORAqpjcJ/YHvZKJ
	fA86/kk6PFkFcgmo5bOT2tHaeEgopr+2j4vAWo0wSSuJIKxWaRNjhqyEqMGYGdYpbM5iqmxi50S
	g/Ma1Crn+j8IjezBh2A==
X-Received: by 2002:a05:6a00:2445:b0:848:2f73:8ff6 with SMTP id
 d2e1a72fcca58-84c29519487mr19079987b3a.63.1784671968180; Tue, 21 Jul 2026
 15:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5dc95f295bdb5c3f60e880dd9aa5112dc5c071cc.1783707823.git.lucien.xin@gmail.com>
 <20260721140227.538ce6b3@kernel.org>
In-Reply-To: <20260721140227.538ce6b3@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 21 Jul 2026 18:12:35 -0400
X-Gm-Features: AUfX_myY_Kiu7B2PbI3W-OCNeoqmK7UY5NNLOlIFHZufRuD7emAW2GZPYOFX_bo
Message-ID: <CADvbK_dRySbf_iC2qUt9a6A8sMHpFcwtrCtKyJzKY_wnZg8PVA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix addr_wq_timer race in sctp_free_addr_wq()
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 10 Jul 2026 14:23:43 -0400 Xin Long wrote:
> > sctp_free_addr_wq() previously removed addr_wq_timer using timer_delete=
()
> > while holding addr_wq_lock. However, timer_delete() does not guarantee =
that
> > a currently running timer handler has completed.
> >
> > This allows a race with sctp_addr_wq_timeout_handler(), where the handl=
er
> > may still run after addr_waitq has been freed, acquire addr_wq_lock, an=
d
> > access freed memory, leading to a use-after-free.
> >
> > Fix this by calling timer_shutdown_sync() before taking addr_wq_lock.  =
This
> > guarantees that any in-flight timer handler has finished and prevents t=
he
> > timer from being re-armed during teardown, making subsequent cleanup sa=
fe.
>
> This version did not apply when it was posted (IDK if it applies now)
> Please rebase and repost if it's still needed?
You already applied this one:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D976c19de0f22a857ba0112f39635f8fd7a257568

I think I accidently posted this one twice, sorry for the confusion.

We can drop this dup one.

Thanks.
