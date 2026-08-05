Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C53EB0FA
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919944; cv=pass; b=djGuUz525cVP2+3GIbPGVqNnJdq2FjkP7oILdP8CPJ6jHDYme508YRFWAa7ZIc9711d9IUm1k1fJGg3tBc4Ar3Xlj5notZ0ujhyEXf/7/GLwl4DHe5NK5cC2jgG99MqXlFMtXUypGCDgN5cyCaJYmIHL/Q+ynfP6GJaN3lqf+04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919944; c=relaxed/simple;
	bh=j6DXQFZPqoJxKT6AqBIKO6CcGnuuFezI7MlEPU5EqfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdMpBclVQLva7zX9R6WWy+JgTw4ZRONLj1Jh/pVX3R2c8ao7gE+RRnw+QedFcQSIfwyz5XU8aBs83hoVL4kmcE8lhb84n9VrhTuxrMv7Ow8kjeRn8J5aXb8vA+P+TXyvYfeERPTlPxMcWMDD/dOKO+v74PS2W3v+Jmb3izmc2e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9NQDysY; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9NQDysY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52b4e988c77so3909531cf.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 01:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785919941; cv=none;
        d=google.com; s=arc-20260327;
        b=MEAQlJvcPLc+ip/YN8Yne15+EayZNs29zV25IvASS0PaJJBOcy26/KfFePmiQ6s9qe
         wJkx39wpVrsrRS0/9NWmyTgu73go6LW9x+uIN3z6e4fcndnCuqTyofXrIr3mYh4oMcl1
         tI3NNNSe4WACYGXQvDVVAZwO9Mgn/NdX2CYG1JSmTpRDnCvnbonSxbl5PiDdVW5kcO3d
         NW04mRTYQ0Y606HPrmdLvNxNo0YaOTOjDm4OoEcJvolZzwQ0nBys4jA6FwtnrJVkOpbN
         Zs+jkXyMb6qehrIMAWOggB4c6UlhY8coO5Ppj8jclbGK66W3TjfcHheM/aZLs1pJxVSQ
         KlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        fh=UnMPx8OhKEvvyg0GTQkk6BrjpBwT8xG6mxX+W7N6V6w=;
        b=sFh29in24DDBorqllgIvSAt8XOwG6rmwUhZDt6TFSABb5h7WjKytyH8bdeuzZw1zn8
         Df/qvZ2CsfCfecDWti5Nx4vAgI5VIGJzAdn9eF2JXVWPMuPEjuBwzW1/AiegCJ0XFhOT
         8xiHYdC4iYya9GxRiEBGM0e0UmfAUm3arO1qr3ZR+dMDBHfHnKPy2nTIQIPgNsVq6TO+
         vSvJ9zelppm4I72HmUc/L8Is/UaPWCNWTNiDjHKYwI5a2Z23a5KWeig846Ef0TdQlQIH
         W3UF+xJXkVJgP/Fh6P+GspIYq9dDypgHpH+ncy4JQ1JM2Pf65MFp0UXYWstPxkNREvk5
         C/6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785919941; x=1786524741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        b=c9NQDysYwMbQ0WI27HcXuTZraau/G/TH7mbu/OARtSRdKbogjhRT5fqr/Y9G+QU0/z
         Rymkq8035w6WyzCap+lbbT/K74k7GACfwj2oDjDxlYZE6Eksf12kudTbRS6yUbjlScWC
         G2W5SiS4L/y5sz0z+Y3I/maVauZUr4RDBfedQPAAuW7Aj2Ud9zXvIQeirC4urNbgq+4I
         vQSM+pJTPjVBgeAw9VtUZ4BJfZp2LlelED51yyRxw+N7ECEnh54NAHNhEJtDEvYNMgwb
         ka5G01gTOiG/2+NmQaCMgRkvp1ytf+A3mYSvG5A+BqryWDqrJjSpwOtUUsRhNa8euk1Y
         prWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919941; x=1786524741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndI7WpQKsMazS/qdplorjx+o/2tpreiwv2UGpHfpCdw=;
        b=fvIYYhQwifdhHvc3Ae40WfNawWJxOglfrkGDFxsLcY4Hqw0AHNw65X7DEa0XWiAIGN
         hq2QZ+W1nONNG300BWuxi0hP5WAKz//qRP9OjsNgwLvzpSPKKuRHaImEdU+GaTZtFNxj
         U94TO2woHB3DN8T3l//81q37pxysue4bUEWKbjEdZ1vKr5Y/ECAFXYn45+rlrSYmgOTh
         oAGRL3NupyUJfD+SJVEDWXD9T3oJ5icT63W6FcqxWbr69G1x3+cR5n0J1Zl9ZWCLMf/b
         mTmEf5IKfakuTcpp79thuaoygke8JqdcDHluKz9evsL8vFFdBM9ifg7hTJDegXdSHQCw
         nBww==
X-Forwarded-Encrypted: i=1; AHgh+RpCxVjfkN4GZm4Vk1vF50Hmuo/e2Q1wKKKU4yM/RSYcgR5SSBlKwA5GayhEtAtsMk8e7Sn3dCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkefX4KwuFe25ySKXgKCLmQPDcoKaUzWjUKUTKTs9keG6LiUxZ
	pF1i8MOARL6Z7gA4Z2NyUDfnq/bgJhHxmfKL8kl1sEbHN3ReGhah8OSOxosvPkCKcCOeoK4tZmL
	uaatCU8jzj/1gEsKpiL837DO4z15oVSA=
X-Gm-Gg: AR+sD12/fLwl2yaLsqQJa6iiCDaubkYKGoZxnQdRCAG//O5P2jBawA2OGorEWihtgkR
	CO4nKsJtmRvMp++khi/rprCElFipJ5WDQJEcwAwpm3ExPHjYzBDGVqA486Qaj6oS8NEg6kZ/tCE
	zHt8bzhDAOz79ioESve6WJm59g04jeREF5pPQUVp+88xfmQJBbm80rQ9+Ude7ShD8Qw0yH3ko9G
	3FYY3pJbJlvur2R6Iep9rcJDAhUdmKo75wMcz7eidLELbxSZw/ILXoBvMPd8NtKghHJnoS8rLjp
	aMqXQFZTy76QplgBtf2SFyGu9ZyJ9E5CpwH4JbfaOiO4TjRGCnocMoH2kk1g3zOorFmVf61GiPg
	1i8U=
X-Received: by 2002:a05:622a:1e12:b0:516:dda7:51e0 with SMTP id
 d75a77b69052e-52ce5ff11acmr52330181cf.17.1785919941452; Wed, 05 Aug 2026
 01:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804095051.715355-1-david.lee@trailofbits.com> <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
In-Reply-To: <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Wed, 5 Aug 2026 01:52:10 -0700
X-Gm-Features: AUfX_mx8a4ogrmDGIJBdqb1hUA7WGigHW93m5FaPqnH_UvGOCPhqWGAgYlL8EvI
Message-ID: <CAPuPA7KZhv39w=nCG71WBLOcPRrrpb=CvDdVcnCRbfu+z9ZELg@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: hold msk reference when cloning request sockets
To: Matthieu Baerts <matttbe@kernel.org>, Kyle Zeng <kylebot@openai.com>, 
	David Lee <david.lee@trailofbits.com>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, geliang@kernel.org, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ren Wei <n05ec@lzu.edu.cn>, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com, 
	Vega <vega@nebusec.ai>, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:00=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi David, Kyle,
>
> (+cc Vega's people)
>
> On 04/08/2026 11:50, David Lee wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > An MP_JOIN request owns the reference stored in subflow_req->msk.
> > inet_reqsk_clone() byte-copies that pointer when migrating a request,
> > but does not acquire a reference for the clone.  The original and clone=
d
> > request destructors can consequently drop the same reference, leaving
> > one request with a dangling msk pointer.
> >
> > Let cloned MPTCP requests take their own msk reference.  The source
> > request still owns its reference while it is being cloned, so sock_hold=
()
> > is safe.  The clone's normal destructor balances the new reference on
> > both successful and failed migration paths.
> >
> > Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retrans=
mitting SYN+ACKs.")
>
> Thank you for this patch. It looks like it is similar to this one sent a
> few months ago, but where changes have been requested:
>
>   https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.177840=
4619.git.caoruide123@gmail.com
>
> Do you mind checking what they did, and explaining the different approach=
, please?
>
> It seems there are two issues the Vega's team tried to solve: one with
> MP_JOIN requests (what you are trying to fix here) and with MP_CAPABLE.
> For me, it is fine to split that in two patches. I also don't mind who
> is writing the final patch(es), as long as credits are given. If you,
> David/Kyle, are doing that, it might be OK to add a:
>
>   Reported-by: Vega <vega@nebusec.ai>
>   Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53=
f.1778404619.git.caoruide123@gmail.com
>
> @Vega's team: OK with that? Or are you actively working on a v3?

We seem to have lost track of this patch, and we sincerely apologize.

Our patch addresses two issues: one involving MP_JOIN requests and the
other involving MP_CAPABLE.

I reviewed Kyle and David=E2=80=99s fix for the MP_JOIN issue, and it looks
reasonable to me.

Ruide and I also do not have a preference regarding whose patch is accepted=
.

If David/Kyle' patch is accepted, please add:

Reported-by: Vega <vega@nebusec.ai>
Reported-by: Ruide Cao <caoruide123@gmail.com>
Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.17=
78404619.git.caoruide123@gmail.com

Btw, Kyle and David, would you be open to collaborating with us on
Linux kernel patches? Over the past few months, our team has fixed
more than 100 high-severity vulnerabilities in the kernel. We=E2=80=99ve
learned a great deal from maintainers=E2=80=99 feedback and have built up
extensive experience. We=E2=80=99d love to help improve kernel security whi=
le
minimizing the burden on maintainers as much as possible.

>
> One last thing: it looks like your patch is conflicting with this one:
>
>   https://lore.kernel.org/netdev/20260803061739.134737-1-jiayuan.chen@lin=
ux.dev/
>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Co-developed-by: David Lee <david.lee@trailofbits.com>
> > Signed-off-by: David Lee <david.lee@trailofbits.com>
> > ---
> > Bug found and triaged by OpenAI Security Research and
> > validated by Trail of Bits.
> >
> > Trail of Bits has a reproducer for this bug that triggers a
> > KASAN use-after-free and can share if needed.
>
> I think it would be good to include the (decoded) KASAN warning in the
> commit message. Regarding the reproducer, if it is with packetdrill, I
> think it is always useful to share it. For others, don't hesitate to
> share it to the same people: it can help better understanding the issue.
> Maybe remove the mailing list when doing that if it is security related?
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
