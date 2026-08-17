Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF932B110
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944432; cv=pass; b=ZoUMFqjthjbM/7ZY2x0zTUeeFPB/rbqBrbGIsrkrkcBuV3nAx0cqS+GZteF7TSWlLfVQshGRKqEpJbatftenr7fNFPGphySPDj3VFON6X0RliMjqmOE4HtFN8zqvmrjBFxV6SmQaQbULMSee71URA/FnawqHrBZsoZqoQeS0e1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944432; c=relaxed/simple;
	bh=MyhiEXjJfwR7Wgdbq7vvvvPhDSM8LUZqH0AOgl9YiuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEBaiXBz8oW3PrmlRWOAKg07kSFeKz/qQ67Vn4nDJNdWC4Ob54iwK7yItRRVUe3Hm9ZOaDTSP1CWQZrlolyRxr9onF9z9RbTvi99e+tYRQW7B0ATbty2rNJM15NtwmnZ4kS7EcTIPD0VH6xScnIEQEbSbqmbnUL4ufUYBYe+n14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Roc8bDq2; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Roc8bDq2"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52b4e988c77so18961191cf.3
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786944430; cv=none;
        d=google.com; s=arc-20260327;
        b=YmezHWvubo9qSjfkRYiF7zeFWW2JHBYE1hLh+1TRrvgmZf2O3urpL+xqLVFOwREK1e
         0yJMXecUq980cnVgl4tCMxDMO+Rma2ATfwyCNngDFGH0e8xxjYuKPItdDCol0NUp9Jg7
         HqiJUMpbnA8baoEB/Rg/kuxItdltsF7Nm+THk0ulkrxXylhfMWJxaZsIgey0EAnrslbU
         lSHSYdbDFNw/yIr43QWBfdkT1APWz7UYq1ilDARWeCSSTzVcoi+9S5Q3p5UsG6y55KLD
         w1tipIPJmd8e+WEqZzEk87fA7gS2W+yn9ZMZ3Emy4WnxMXqqIpiMzGFX4zvXqHnZNCTi
         g+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MyhiEXjJfwR7Wgdbq7vvvvPhDSM8LUZqH0AOgl9YiuE=;
        fh=MiJgL91gstineZyQqgu7vocIP1wwzzOlX1XSmAM2U4s=;
        b=mPaSAn4Bhak6qw0S9iVM0yvxHCCq7zJFgC/HEZfaw8pp5TiboGmGHFuqJFhVXGA8sl
         OyxQ/yvNN9Z58ivNBMIn3BzFHzbVKsHcjD4iHi2FmjP6ez8J2tWSSCzXLdQ5+28XUaXc
         1UkVv2L46nbk4EVfLa4ypxlXq+T4qOrHpanu6qyIDGV995d60TwF6baXhTO3lKLH0r+f
         yjk+J6dIlloIDDqarALC9iG0uo8GktL8mlU3PGCrySNOTCTF8obkaJY7PCVweAL6c/f8
         2k3d969Xs3lOnVFWGW9DpCpk+Q3Ag9zCIE5Js/wqduwy3Pau9DzTzghVJ8aY6t15AkYT
         L4gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786944430; x=1787549230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MyhiEXjJfwR7Wgdbq7vvvvPhDSM8LUZqH0AOgl9YiuE=;
        b=Roc8bDq2n3kevCBm2wVZ/r3tcNKMg/xlgVzBRHxyCv+4PyXN2Q32Rcg6onRd6sJXSe
         Em0qu2M5CBUDCzQZUwQTceqbkk+5Dkj0Fxe/X9wJgv625ntljX0vb3BlRGZIyy701Q/G
         opouTF7U2tWwo3eiPnw1e8jL/UTZaV70oM41yXP0r8ATkTzL3MZYLufmrXss0c8+xwfu
         GPSkHi/1ChoJw1JfRMEwZM+28Emafdbx4drfssn39a2+QF3Izzpq/sT8MWT+0s2CN3fq
         zEOjHsrxesKStv72aNvlr7SX08ToO2+oDkGTtZBU7dbMWKDGycJeWiztJ71ZwgfBCdpd
         BNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786944430; x=1787549230;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyhiEXjJfwR7Wgdbq7vvvvPhDSM8LUZqH0AOgl9YiuE=;
        b=kJ/2ACWl7SXGbbZDzQXtMFTEUj6eDv3DLKBdeoY4VfXBpHn4ld/7Klt7og5uuWgUPW
         aaKLb6JLGrYqFXBXCwPRbI0W0nH4flo1Du7KdNCwuoUV/YzClfs5u5DNxRHgsb7EMwGL
         DuTdG0MW/XF2xHZhJ0jYLCRV9OrTTgdGqBz/SyxAwgOVxs12guv+5woT2bAz0KPIJYa2
         iHM0GfU2R8/AIAbaCaU95k6qkG2KSwsgiNGYHbuGDrNm/boGYFK8vrPyAb4DQLRUfuoQ
         a9tH6C9vf8IENMxUHOsn/8zYqNPYZ/PVpZxjkejie30auM9fmGP6SJUiSI6wPkACRTgR
         sbPA==
X-Forwarded-Encrypted: i=1; AHgh+Rpkdjp/8c6Zb7PRD0JbDptQ2J8gXTzE35HspBMldd6uPiSD4sPrmeaA8fQ9kjPB7WvyukT2oZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc5fZFp4qxoWj6thPbFsF+XWBtPOWhdCvuAM9VCtw5H2iaTZu5
	7VB8aNCgQJ5/p9Xj5rxfJZEe6croK3S6MbZtU+H1KXeUNNU6Pf/5njcyunfqw18o5i6LX/J0UuZ
	zsdTcHmdlq1TYE6gpZ803BzVHSmd/gsg2l2kxad5W
X-Gm-Gg: AR+sD13MoKs07JjJVQqbU0HJwKOlHbyDwc/IKCFu0jSl48ORUnsrU2H85SCGS8fC9th
	TknhIUKe988d8ZhaTZiCjFrvoNmrXhp1913+VmRGYYiQebbJR+Wvl2fU2xq0U49golTqXXtEaKP
	BnjHDcmwTR4qYXwNooai6AY/dYU8/QuB0M+UFUZc6nN5HOe6QO/R+orTw24/cIYMCDppeYPwSyo
	9qcX9putBTIEsn0t75No4MxY1ErVtFvWwLmVqe+NcRupWlcuOvkddM1VhNK+zmy0dMxMlxHspug
	iy5GeXCbr+XnkQ3l4IaxkX4IKCri6ePXS5acqRQwqlsRY+93WIvPmo9zWsHFm+sxWBtk9pYfI+W
	FQoAKrFc2GVISG4hJZ9cK9nIx93wQrX88t8tNnyUcyUexhUizxCqvOnV+vQNl313Xj3T7PuQPBe
	saJ6kPxvnItVUPFT8=
X-Received: by 2002:a05:622a:50c:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-52d8556f3c7mr222625371cf.36.1786944429262; Sun, 16 Aug 2026
 22:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <34f44e8a-9fa4-4cb3-822e-5db54fb6df44@I-love.SAKURA.ne.jp> <CAAVpQUC672LJN_8KQ5BzadS26FnUrh4ayjyu-n5x=W7U69u7fA@mail.gmail.com>
In-Reply-To: <CAAVpQUC672LJN_8KQ5BzadS26FnUrh4ayjyu-n5x=W7U69u7fA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Aug 2026 07:26:57 +0200
X-Gm-Features: AcwNN1Vk4v6gsiE4lwUzJUgJVrn95xWxU8Jn8HHarnXJyp36M6pllkW7z3KSVtQ
Message-ID: <CANn89iJd-s+mocDFXgt2rtFQVBGNJ7xEy=tUMKa5Da+brptXzA@mail.gmail.com>
Subject: Re: [PATCH] net: make sure final 'struct net' free in
 net_complete_free() is always deferred
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 6:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Sun, Aug 16, 2026 at 4:08=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Since there is no serialization mechanism (e.g. the RTNL lock) between
> > llist_add() in net_complete_free() and llist_del_all() in
> > net_complete_free(), it is possible that net_complete_free() finds 'str=
uct
> > net' as soon as net_complete_free() added it to the defer_free_list.
>
> Did you see a real issue or is this based on AI report ?
>
> netns_wq is single thread workqueue.
>

Indeed, this patch is not needed.

pw-bot: reject
