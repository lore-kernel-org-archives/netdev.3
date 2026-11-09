Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794245984;
	b=L/fpVp+W2TM5Xqsns9PK51jgRm/B+dy0zP0wa37mjSEjXjXTSnqKDcPkc3UOK2DFM5Nr
	 PzJYKQkZ59mABQOEj+V6Du+fOrwF8Ib+IRoDD20lrgbquYE1zwcSIniVAGiDdUiYWLQ7q
	 X3g5dwp46ss90Pswjqj9BMXKOEqunh+TTge1ldT/sMShOJINahqMonSvmCFfzBn5YEdn/
	 MT4pSiz9HTZ4MkAPBzBRRFT8KhD7XoHXt4Q3ycQs0OrPaVon1M5vCx+yVpheCqMubIVa7
	 ql3aGnVebuya2ayWUFm+PjUVLWAu1wTyS7kCUHTMpB1qGgqL2z3r0j6lOZw4QbX/XqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DD2mG8MGLBunjUEgSEcmh70rFVkN7gmUB2QYBnzNhHc=;
	b=DQAM/AyCD4ETedLS+meW9anJUApft8Y3fmBIZJpPH4vDvNEH7ibB5IIvfDFjMXomhiYn
	 IBQCxznx0clL2OkOtni/JtGunWdHCJ8V9fuHYo7x+RnYmk8Z5d7By4/KadtnxnCOlIWjS
	 TSYJMeQDecZ9fQeQGDsfK/gnP3pDOdRKaLNegQzTYfIkgyvoJg78U3FIxPEUCuaiwuzn2
	 5AJ/NXYj+L+ga2UbiMporPgSiXsTIrOH4d9L//LkAD9Xz0VKnMTQYn+jlsT0KeReOviMf
	 cB0dZa+KaLwhetP3Ee+I14aybrx/Jgh5MCDtQYQ28fUaJVZVPqsj0Qre//rTtxYJYIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fmYM84nc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C4606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 17:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fmYM84nc
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b32daac9d7so8563937b3.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 09:39:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794245983; cv=none;
        d=google.com; s=arc-20260327;
        b=Pfn5BiExEW0MeUcUv8460xKkh5r/cUPanq9UzkiSWCFbh8IVMLSIxC8DJMmH5gNNOF
         0QZxDOsWQGt3SD5CnbUyNd/YU4jgRilrcvJ1BvA0tDXDVcW/reMvdgU+cbESsUcuxTyu
         6ZHxeomxE1XmJwVdBTj0T7IrdXDZALT8+Sys6dt1iV8BrSsQ5EMg7RkKHOPulBYB4cZ+
         xuRcTGE/56++2W6JXTZAPPM4c5x9wJsQUX+nJY9tt1nXuFuStJGSMqrQjlL1/LkRTuzM
         /OT5woPJpKtvoadvcrqKFglacgcICsx/z6h8or9RHeyvt27ipef6L1UfgLwl6nJxtB8d
         wRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DD2mG8MGLBunjUEgSEcmh70rFVkN7gmUB2QYBnzNhHc=;
        fh=a4tfmvYRNA7cS787JmMmResacWpL8B4kAuC71cqG6Bg=;
        b=VrQuiGCagbYa9hkYpw2NzmOcBlsScWjCtRW/oGQFM72LkKQmsVkf+Wt9ppz0kjauo6
         sZYSQm9rUInccfu7Ht9vMlO8/ENnv8oSkTSJuFImdyjgZrHNEVOjW0gfO1DVTMeAkdSe
         JRBQW/KSwg+NgwaFOZmYaaD2s1RyN7L4hKMZIu22ogGw0Jx1kXzZqe2mdt9Tuli1MJuP
         0ZMjSIXQECKdbaUVuP42wN2EJ7d8k9r5ML2d5NewykzzPwFTu7ARViJ8PxcwV2BUbevh
         P2petf9IhpvEf7+LHgtbZnw8+5FdvghvgydvxlUADubcASs+p95cTsWtuu4DNwZdea2P
         TxKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794245983; x=1794850783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DD2mG8MGLBunjUEgSEcmh70rFVkN7gmUB2QYBnzNhHc=;
        b=fmYM84ncLJ2vvNUd+CP9Ecj3LybGcUS3/o/QLSF8MkuMFT5U7wpLbcRq43Ij2UDQpp
         fZU5bAoGoLJ5Nt0qUb4StNsDp/l6j3N04LMC8D7HwC6O0CDvTsgEVt2NDqnE4r2GaY4Y
         nN6r0IadSsR8xjbWiJiVoa+5rqxJLCVhPrFuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794245983; x=1794850783;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DD2mG8MGLBunjUEgSEcmh70rFVkN7gmUB2QYBnzNhHc=;
        b=Zw4qz/i166FZ/8mXtP74nMW7IXBNyb7pWoTuv0dQ9LbwUGi10USDhye9Tr/jGm/4Nv
         kC1VBdACAihIFdVUalwlr3/L5+JS2E2I72eTEh3Zv+/+gKoPEbJqEnTFqBnHTCx2bNeA
         lCcnl/2n8qXbhRvpBM8DAgp5K7PFRkBkeQ4xtACBe47ZuTxuM1B+wvcJ7ngKBpNZaS05
         DzBue78iSoxgr/NkNExBihJ8VdzN9nhoeFHOjBWuvjS2ZoXXYuLGKP6RJgdYn36kR6qx
         Q7RD7CQOBXtmDq1UZz3XsOI5Ki7saeOwuGKPsmBadQFVcbSp1OANLraNEfE2+61QVEXB
         D8Mg==
X-Forwarded-Encrypted: i=1; AL+hErFq5x9yNIsV9ano1As+Ds8xj0EoPtrFKoVgur4wojF7gMULtGJigD40jmJy0h7yNlLjSwz3b0g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P0mgyGaiQEvS/wqrx5+c13lsSHzmoXtTzZCgdPEK1Wd/eVmnB
	DCSYbEh35W5qLVHcb9r9ptAjnRfFrkAK219OFEzTwLd6QS2eBL9Vk2Y/Pipx9A4q5r3ZRztUazu
	2fsr0J0VU4zciQKX/3NPif55/TE4zdt0PIDCJjkGssPynkJDbD+4=
X-Gm-Gg: AYBFou3CUhxWYqwGrmU43MEnD+BYw8j2IYFGeAPov9L3ZXMjfzSUxUi2N/pXF8rvQxk
	sxMyp335Y8Pe1T7e4AGm6pgW2/Ke6ooI9WjsJD6pE4O3SGZGEFlcnYBWFKF+8uHi6p3+AYGphtf
	4vEgWEEaIFaFBPotvqFaggIHd+Z+hKh8VC2K2bVnKDuv0eSi6LCV4hycczF4QXjSWGYBTlynNnE
	7GTR7ffU6SExQC0M1EW5x6fMjWAyjcrRDr6X1OISXWu5AF9KWD/vuuk9ODieYi2Mb5VcBPE69JO
	jERNZz/S2pyHTwPuIhWRvQ3Lm+L0wF6S6llR9TObB8XWFgWNJq4vdTuW3gk1x1jM9oa0DdnhWzs
	GjUS85jZCn5oi0/VjYnYsfz2hZlkNG/UZqct2WZa9UwG6Aw4vNbU=
X-Received: by 2002:a05:690c:c4fa:b0:8b3:392:dc20 with SMTP id
 00721157ae682-8b392714ee1mr1011397b3.36.1794245982729; Mon, 09 Nov 2026
 09:39:42 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6f0ee3c4-32b7-4422-b69d-c879c94262a7@kernel.org>
 <20261106092441.00cf9765@kernel.org> <CAM0EoM=4fNFXaFUV1kh-H9Bdrt_K0yDsbOMJHWpgON2bG-GyEA@mail.gmail.com>
 <ef3ca6c4-57f4-44a7-b44e-f34e06dfb3dc@kernel.org> <CAM0EoM=GofsOkOdLv_-xRMRK8u5_E5BSgnqUCUcReZDrKuUEHQ@mail.gmail.com>
 <415e54b3-9bc5-41a3-a9da-3631dcb46157@kernel.org>
In-Reply-To: <415e54b3-9bc5-41a3-a9da-3631dcb46157@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 9 Nov 2026 14:39:31 -0300
X-Gm-Features: AclHuK_lLVA9W0ZFyU4X9KBx-RvGb5YeCRI4ZH_3IKDFd3rdkiNEDfXBiOxJvDE
Message-ID: <CA+NMeC9TKz3a=8JYHavHRv2UcM4GxhhnqM9QzzVAu4gKSiz59A@mail.gmail.com>
Subject: Re: NIPA: TDC: delay the start
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>, 
	Pedro Tammela <pctammela@mojatatu.com>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthieu,

On Mon, Nov 9, 2026 at 2:31=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> On 09/11/2026 18:22, Jamal Hadi Salim wrote:
> > On Mon, Nov 9, 2026 at 11:58=E2=80=AFAM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> Hi Jamal,
> >>
> >> Thank you for your reply!
> >>
> >> On 06/11/2026 22:39, Jamal Hadi Salim wrote:
> >>> ,
> >>>
> >>> On Fri, Nov 6, 2026 at 12:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >>>>
> >>>> On Thu, 5 Nov 2026 11:43:27 +0100 Matthieu Baerts wrote:
> >>>>> Hi Pedro,
> >>>>>
> >>>>> I hope you are doing well.
> >>>>>
> >>>>> I'm helping the netdev maintainers with the CI (NIPA), and lately, =
I
> >>>>> noticed the 'tdc' runners were often marked as either "timeout" or
> >>>>> "pending". It looks like this is because it missed the creation of =
the
> >>>>> branch which can take more than 2 minutes for various reasons: PW a=
ccess
> >>>>> is slow, git push needs to be retried in a few seconds, etc.
> >>>>>
> >>>>> I opened a PR to delay the start:
> >>>>>
> >>>>>   https://github.com/p4tc-dev/tc-executor/pull/2
>>>>>> [...]
> >>
> >> Good idea, I just changed that!
> >>
> >> Please ping me when it is fixed, so I can re-enable the runner on NIPA=
's
> >> side.
> >
> > @Victor Nogueira  is the one fixing it..

I applied the change Saturday and it's been running fine since then.
I think it's safe to re-enable now.

cheers,
Victor
