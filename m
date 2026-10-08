Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2B374A15
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434224; cv=pass; b=DpkyF40nz5Ljk2zmrhKmlLzWoxlv3jDF8dRiRM/oOypsgQGTWIA0MbNaL164QqhnoMANgaY9rkL85oMQZUhfjEZWPAotma+USTmZbWNmS2mgnPnwXpthMpFjjSdweMDaGwIsiQlHZnuoxF1G1ydmPfpId2qKUfJUs+quQbwddIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434224; c=relaxed/simple;
	bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPz+u3FD5G9bLsvDPkDsWGyrVqmixD7Unfyl9cWZhXGIucnIQMSZg/zqf8ZvJXxG8N7aVQ+KFApYWKU9aDKq2lL6Ln8+YEqvudgX4B+gnZynX/r4KCC6M0pjloleo2HeMY5Bk1mW+XDUd62AgKDIZzeJ8pJPFpe/QBVgXq5c1+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPNHWIx7; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPNHWIx7"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34bb8b31647so7556813eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 21:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791434223; cv=none;
        d=google.com; s=arc-20260327;
        b=r9xFG6pkizk4UTsth4tXmGlConwBYnTTUfo4ni5OWL8A101/aOuh1CnyCXXFq1Oi7/
         IXgYBuK08O7mkPAtvwnq57XZD1qdO2NNzc3ftPA2JKEbofJDVjleBJ0hDftmhff5PpLm
         sTE3at9lIHTpLLMHOglqAR2IaZeuBYE/OqsDQf6SlhtmGTQShENn7R2NjvZsdFls9PZs
         fSWpnT7jvOwUDCWwjmhxEuoYJ1E68rijvG5X8IHgHh/BGDC2J53WVTKzUBc3ifrPFwhS
         WRoWjAPqfqMaX+RGs0uRImvfxAaNKoOh6/8b9PaBu38fQHV+ZVhnfatIuvCd+hPzWLRp
         Hhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
        fh=gh7X816N1NPrPklODwtKJDoS3jPXf4hbN5yVWtnUzUo=;
        b=FcL2VcrrGHInsIjf1U0bk08HFsw9c9X/X4HO5Z7DfABNTfeknoOWDaduCjMmKq8PAA
         fx8ngxITZxD5O7zF3BYJ5vTs5jECFOO/8JiyDKfq7osHrKGcqtSI7tFNuNYrQmoubAFl
         COt3+TNHgRHJ+fShaocejmTvcXpQl1ECQi7odlf18QcfknF10A0Wt2GGm2gYePQNYfye
         PpWJWCW2EsLDX3bhKSKjrCemcW2jTUprW4btfWjBFUs6iW2H7yelPDt9k8MwiBe65KJn
         YPruewUYd0zW2R/wdVGUQDmsn7bc9x2NS2oA0QVg+6OAFKfHZJ1Qf4feNH3MUBXG1BIK
         DiQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791434223; x=1792039023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
        b=SPNHWIx7FQj19D8wuK40Tq4Q+G9QIh7aWlUTR2g4mDgs1sHpGGTWzs19iAjsoBK2sb
         6O7We4dl1Oe6TlOcn70TCRSmzvqz2n42dAK2KrSaFYJBtjNaU+LSNG0mwGY4o2wgiAeg
         fD5DkjDej06c3CAgq06jaG5jwsiGqsnW2HzZbq8eHcVMwG4q4gaLq75wFXPCCm2GFCHZ
         OfxqVL30VYDIE30vNgYuSwtOCpMZD6gxLIc4DeTdI0C5vA7FkUszACDbD1f2aYe6WGFy
         MIGe90DJwUKQuDzt65pOvBFdbnnVfgKHMxJwhzcMqUVVvXG00O8myvPb20QEJ5x8OvSw
         oaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791434223; x=1792039023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=783mXuBfH4W513hCsDEM5WtuPocb/VIE+cmR8680wxc=;
        b=kyytXifY49Ct8OqssVWmiH1+IsqFKO5vGdXF2TeG8rOmPdv18Uh1QknMqES3Nq7xj8
         tuGOYl6yYOB46lxqYzfIi2IvOY98/xQMz8QOVrTMjsAL4Lrvh4MFBjDFz89Q14/8XE+g
         9GlcB9fm8TntOH4QTfEBnE82ddNN8Usm4eNhxwZFwTq3A3PD7REmkhM/H3OIfuou6+yp
         6nrnwdtoaofvoTLJjRp3DIcwz6xTKbFG0wAHp1wO86CgrPoQqBgZmhk/P//SbiTtpfDc
         /L9ZreNGdJDyWN1s1CPSFarkToZImp61YbNOwqwFY9JmzLMIb5sNA4qhe+9xryZZr3ra
         Vm/w==
X-Forwarded-Encrypted: i=1; AKwUvBwNpZJL+jmbJldoJYrqmQeWRrGwpFkttLR58D3TO5DzGR96MUwVTArpgEeAk+t5JX3QrsaVrnQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k900MjBeCJWIOd185fIBFu3Y+t+U6U0AmMFAPsk2AVhw0mdn0e
	YOsY5pmOXTnjy7SUpt9NRxI6iCkOqp20+ya6JQzeGNbDLznBr8OJcxqNDDH6iP0Nv00PIewDy9g
	kxD/fgpfGOJ3RKTdsCImh1MggvGofP8Fh7PZ9zYPJ
X-Gm-Gg: AYBFou2WjdLhfU7hrRhg/r/TV8V01SCBjKcVITY/NIn2BiCt1qyybe6Jq1mGvcMlBJP
	KyXbbuw5Ei4F9NK2d6nHwGXfDpfUpnrXpo3JO0i1XrEK2uxwsPXpChTVwyaii237F92knKdsZ8z
	zblUjK1D1HO9BFJgxnISsg55anwvHz0KRPCv7fXdNR1ipwsaY9VxQu9joabvaLNueYpS5SQWcme
	HSH1Ud28Csxeo8f5kghPrjLpVF6OOuuy5NVzAIRRGETUQ2iR9hcc9j30cDkrBi6esVRLE68Qtgd
	HjfFatbGpfY00QcpvxqBfX4tB9DfBuuWTfiJpy4fZLrB8ItJtvND9cFTUK0sENpEoPT/570DXS7
	45kWW42yUvTToAzxHLPwbk9aQLhMx4wlqecED5odIxoX0TIEwAdYFsfinuq39mgB5y6uxCZvYRc
	mjPfV3gvPqvPZty+glratjdyqclA==
X-Received: by 2002:a05:7022:f502:b0:143:7001:7645 with SMTP id
 a92af1059eb24-16209760be6mr4222902c88.47.1791434221672; Wed, 07 Oct 2026
 21:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-3-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-3-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 21:36:50 -0700
X-Gm-Features: AclHuK87ASE-Zp2KeBO8qmfy6GnvIhawhL-XqcImRlz9HQrRj1dcVhs5k0D0yrU
Message-ID: <CAAVpQUDkBCXRfaFQcjNZg7LgWy_cx0c_eBPZfURdp0zn93dN=Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:09=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
> broker or the coredump server cannot learn the identity of the specific
> thread that sent a given message. Now that both struct pids are recorded
> a receiver can ask for the specific identity it needs.
>
> So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD.
> SO_PASSPIDFD_THREAD delivers an SCM_PIDFD_THREAD, i.e. scoped
> to the specific thread sending. This is completely independent of
> SO_PASSPIDFD, meaning you can use both options and get both cmsgs.
>
> On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
> boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
> SO_PASSPIDFD receivers all threads of one process remain a single
> writer.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Co-developed-by: Andrew Halaney <andrew@amutable.com>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
