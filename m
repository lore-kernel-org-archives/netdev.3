Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F04227BB9
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927650; cv=pass; b=hLYRlQbNYbTeLQUHiY6y/1RC1du89y6+Y/HuS9dvBw78GYUZqkQzSUTDoYZg7pxMDu8GsMrlF3sg9fj42o0qdEQuMLwtZs6Me9vU6AKz5hIvi8cTpZDOe9vqfLHvqc/fNT19WShJgfbI4MRPiX/Gbt/HA1SJ28dJ17Se82BZ5Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927650; c=relaxed/simple;
	bh=h6urPZgF8bTfvFzVWce3FkqNPdyyhEqvIBFSzMK7R9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jny/thJ5KapsX00/AMLyZHejcPn07jzCVuB6UxKSgs1K8nAPgj32ZgOeLNoO//Aza2bj2L3lwTALXiSbKJxF8b6rC+K9Tf0XvE/8RVRujm0W/1qwCsmEBFae7Hy9nT6BDVAlW2Ly8q4Py57i7nsZeJO9vBcfEVkU69PW+FcT5II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PV+24Fli; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PV+24Fli"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-52ff513ea9aso364171cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787927647; cv=none;
        d=google.com; s=arc-20260327;
        b=plXskDwUUJNbE1VImWieQMBp8ebcYCP6s791yR+yUcqKkaMbor7qsm+6qh/QK7TCSR
         EZNBeXYl0I6DkjtG9LPyxgGIKIFuYLv+Q7eXyfuzj/UMw+4wfYEdgTRgAqRRIq9ZtyIL
         VtpeAkie4DwQ3KZYctOX62gJ24nUNnLYVLOXXHKxGp5SZGu2Uuf1XwW2+H7j7jbjDo0M
         XtuYpHsncU+hevmK96tXwFCRrG/maUgjF54j6MVKdty0G6b+dzq8mQ1k3hrCGbx/e0Mt
         t43cd/2lMgZyuQAIis3T/1JA7jRpjVe5Tbj3E/b5XEGF8L833Ib1v7FZfsyEklPxbVqH
         cLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YumHW+3Khcd3HlEzxF3Gk3LiB4e45hriCCvI83W4xOA=;
        fh=K8pSLk0mbZqKp1UDnewipVkCEIe9UlA/jsp1jLEulP8=;
        b=ocVM1XoucAvtgUc9vhOcYoOyAsCger5JH+cfu1ssbXkzCtbpbm7MBf0ONr48f1Sb8W
         0J7qrl/fQceKHA+E6NRUfX7D+cgUJ8ZrCk7LE4hGJascsOQGDbYkv/ct8RLe4jDY6Zov
         Uev2+hpz75QUKqsdMKvrT+3Ovb6p+CdbTzaMBrxz0ofvrfawyQS4HxnSn32i+NfHdpmt
         hHIUvKALe45Lxu3xttO6Wjolzl7p0dM9pw9SX8bC2nXRQM8pSS7yEzAP9g+YJwHnP6oh
         L9vYvtxA/DV/5nQkP7z4H87p6zAeZB16zhiT85qjycNB6yab6NY5kBUtPU6/mIhZBWJp
         uzCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787927647; x=1788532447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YumHW+3Khcd3HlEzxF3Gk3LiB4e45hriCCvI83W4xOA=;
        b=PV+24FlinxZYo4O+wz86GSfYocJt9h8gu4/B3ENqClxT1pRNumsocQy1E/bskA9C5d
         8PTqDpruTr3W95CVLFMU631dbacg/Rf9nSMu2f4MUD57uy0aeFIEfrL3+86QGo5gj1x+
         4wJbiBaf+YO+uffa9xW8ANloLqp3w/OlIUutdHeS3tQA3EDNS3zE3+SOwMat8NyHwKfz
         HINtHPMdA1jEQEqVxeHwzXjMp5/KVs2VqFMZxlN+yLmJBvtZwAcuNJEQ/iPTsHMRsXA6
         Lc9iqRo4E9i8QbmMNfJsd/jW1JXx60wWOMynuCylkNxd96pVF3a5ccXQy1SIVZrkSTXk
         YmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927647; x=1788532447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YumHW+3Khcd3HlEzxF3Gk3LiB4e45hriCCvI83W4xOA=;
        b=eI/kSOQlJidtUovyTVZxBO6Wru41+jcASMY4/AWOtEWqjR5VyrWirI7twDuvKfmIsk
         7+OUr4XZR4um/wzI0nCEMGHd0s5Dvn7Uf86mjlhOoNliQywrQ8WlLInxVDC8G+Mrx/We
         DlntQVGBSFzWuk0U5UE4defVtCuee18H6qs9/la7NhG6mWqD71do4lqIg+cUwB8wyVxd
         NKRJlzh3vZLaK1vjUdnduCm/FugL4dTeYQ6GOLBKlJuRqCqwvRgW5YN+csR0743wZaC3
         M38z9Hwca6g5fz7Hv4eXwgv779RWWGb9jJaEVaP6lRTEl9+MHyG9ysU8eEgaQLV7ZVBz
         itDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTDwiP2l0qGZnt2juaU8l3vNOa/+rM6e4hI4+2jqcACGNp4y9lU0ee2GdDfFkSn3EPT2uSWMY=@vger.kernel.org
X-Gm-Message-State: AFuF++k0/I8QsyfTIObR06GDRJP2NYil04dUkq5n3LVWIj9alKRYDCsN
	HXcM14CTc987oiY1ZQ4/sIM0Vk3LaTGPsiVLQmp/0P4bU4xi0REGN3YJ+u6ztOv37eSh9d5lchu
	3YeuNkufIBXTih5o0zt6ApbjiiEHnAZ7avh5Npp9r
X-Gm-Gg: AR+sD1398zT6jhA2nfGE1QSZcxHtjZYgLQd2PQPz5PDygG/iEyNxY4PSKPxNU05+Jed
	bnWrPE/bF7fq44btP2wJDZrKcAxfHbZWvXtRVWrYOgyFOfz2vwv0Izfc4NZjae8yJntEUOrX/Gi
	PpsggL+m0Fxwz2QnmlYjijlEPb31xWFa5ejsQ2K0rh6p7VfiE+cY9QJ4WBDc4sFqTFLUnuXsWAq
	aFj6LxnFn2rzGI/dOrBQ+4fF//6v6NW9TTLjYpMkOy+VaUJGxuFJP5ds7wV+vamIRpvAuvpNHf9
	D3eYWWxEUDwMrX1Dki2pM+zxfdUfssvV2EsGJn7txwhw0EHb0rUwsLTBHm/jBfblCQ46nFZg2wF
	+311FaVF2Th0Bzr3cieZOGPqyEFa982SboHcHnOA99Wdje6bUOHjZzyKMFFw=
X-Received: by 2002:ac8:590d:0:b0:52f:ae2b:da0b with SMTP id
 d75a77b69052e-52fb942d67bmr84786531cf.16.1787927646262; Fri, 28 Aug 2026
 07:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828073245.126804-1-qingfang.deng@linux.dev>
In-Reply-To: <20260828073245.126804-1-qingfang.deng@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 16:33:55 +0200
X-Gm-Features: AcwNN1UhdM8hO1u0XPNdtSnx727Mw5Sdf1F5y6RfcZsOSfmGeXvlUkBvd0DUx0c
Message-ID: <CANn89iJ1DTd-C65Ps-6C3djV=yihFinGpEqQjEwn7=7X6P3iHg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ppp: ppp_async: simplify tty disc_data access
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+8e808eb853386f575d86@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:33=E2=80=AFAM Qingfang Deng <qingfang.deng@linux.=
dev> wrote:
>
> tty_ldisc_hangup() invokes the hangup callback while holding only a read
> lock on tty->ldisc_sem, so it can run concurrently with other line
> discipline callbacks. This currently forces async PPP to maintain
> separate lifetime protection around tty->disc_data.
>
> Line discipline close is called under the write lock during hangup
> processing. Remove the hangup callback and rely on close for teardown,
> as done for SLIP by commit 23c53269f2ba ("slip: remove slip_hangup() to
> fix use-after-free in slip_receive_buf()"). This serializes teardown
> with all other line discipline operations.
>
> disc_data_lock, refcount and completion are redundant with that
> serialization. Remove them and access tty->disc_data directly.
>
> This also eliminates a lockdep warning reported by syzbot. The warning
> does not indicate a real deadlock because the write side runs only in
> process context with hardirqs disabled.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+8e808eb853386f575d86@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000002fbad30611e25849@google.c=
om/
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/ppp_async.c | 82 ++++---------------------------------
>  1 file changed, 7 insertions(+), 75 deletions(-)

Sweet.

Reviewed-by: Eric Dumazet <edumazet@google.com>
