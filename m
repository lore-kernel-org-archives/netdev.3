Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE28494A14
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168706; cv=pass; b=UjuRAvbwDTHk60rZFWzfjBhxm3Q5RtTiUjH+/J4vq2KyrSWewjBQTB93cUNcyBf+ZDeK+Lit7nMtm//j181pzal+VabBnKBPpHgFUGLGVAm0OubEuv/Pd+VDQwqXz5kS6jqJxJ+06pjoze5DmwEcC+Wm3f/7v3VR+5R0Z5mrZvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168706; c=relaxed/simple;
	bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xaue5bZOGi4fU+9qpIDLhKw8TLGHUVDfeVdabCMGMJMHf+9tlEuf/3+QJX96XhAgln9MwTPPsDAq9x7KlUwU2Be64tbfJToCpfiwdGIcFczbezWe9/l0y386eMg3wbb0/tPagqDKXEB1Y7o+3xfogKH+G95+EJjjGM1TLxD18Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=lkdqnEX7; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="lkdqnEX7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1173007b3a.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 12:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787168702; cv=none;
        d=google.com; s=arc-20260327;
        b=eKSvmicv77027D4TnNYUZF0MflARgenBnXyLlCLtwY5ALk6+oeY7cDYIVrZvrvdcyL
         LJWtW1DZFy7uSg+xti7wVVvpA5Yjdqbg5/VsMzWfmZIMZ7CjR4JJYWM81FgSJFgpDagZ
         PTF6QMNNepMkrCquzuy/5BQBIsTb5mRI665uXRALsfyLE7D6huXlt/jWV/4z8H9OCkgo
         Rscs84uxN/4bnh7npFyv37UBOz8xj20YqWmuoC41R2JD+PvZncYffOwaBNGy7EyfvIhW
         kwkbZ2KHIjpFjXKTC0vTKx7GfayVhOcZZGZOUYacg9vfLvPaxkDCzG2TDAYnAt8z2e6P
         mszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
        fh=M7oqS4dhWck/l2Fu3NRPAuwjyyua/Nnn2TtGiZ7CsYo=;
        b=C+IfpbRKRHNnmq39bWnQNRi5wnKATCBhDUhiT+GxNxNo7s2Vm8Q7nOe0w3dwq16nBi
         mgT94YuZ+UoQlpw7eJTExGrfvXpw+DZzO77F+caUjVOEh2BHAzAaIpCOg4gqoUEgMrzH
         eJbVKB/JAmdccOgGTWDdHXMdqojwRfkolVlhjU/WrpiC2oiY9bFLXdroChlcqBNrJWaw
         1Qge6xMDjyWdXKtdyFFAZ/2rVA5zG5v1G3RVydejaXtdnqMbwaTDe4hyMa+r97qtjJwe
         PBreKq6EO7yMB7+m2mI/82e22Gan1nxfIvQmOC8Cw35HNWNvYYrS7g36ut1nVJUP7PaW
         axuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787168702; x=1787773502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
        b=lkdqnEX7Bs3G3er9XyEm+0c11ldTcttVSTTVqaQ6nMZqD4wocZrpzX97qJg7g83SP7
         t6H1idvtJUSHBjxcbXGlf/1oOCrwMbUiCA4IGgLbMO63sdfjSPFblHAhWZfBeT7jQ34C
         xENIECo6E5awaA4VcYRO1shDCkgHcC28U9Abk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787168702; x=1787773502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDe4RMOgjhezMH46ShnCzUw1v/GgnSCnH6ivctRleCA=;
        b=i6hmTmZ8lov1mkwFJ/mpzePuyosCYST9h/R5kwj+DBaIK50CZs6QSOViAGPnFGz5jq
         Y4OLKoYQ9aRXRyIelrUaS75KDUT7gI313e6WYT58HzS9rd8AlaLo0zj14TmSvxXb9flV
         dyYxnyuoNgHqzllU/bppivcNl6TxpKYr58/XrhR6ZFMD7HriQLkgNiuMjZOFXRfablCM
         ZvYKr/ujxQ+U/Zfr/Zk9BvM28mYva8CM7s/IxcYua56SoIN+bfBnWMkjR0GzOG/iYhdT
         NQUzpqNpQ88tprwOznFUxrPhxutRWv3St84DyAzjxp2sLSXwLm6EArJinnspdO6oZtmi
         TVhA==
X-Gm-Message-State: AOJu0Yyw86V1M+pxDI7spfh34x9acDpKOiBIm4h7Ut2HXzNoJT5wttR7
	CK/o62pbG1k7hv/z+L5Eb3OJBnbGTl7FuWue5aPq0rgQhSD4ZaDQQI/IZUgjpC3MfZ7H1DzoutU
	6Js1n7N7JVUYC7cVoXuf1QA6LXibhIBAJTAN7QPaA
X-Gm-Gg: AR+sD11axvLDI0/sUMrJIN6ykzAaqZq6VE7gxp1loPxhMMC8HG4iNadVK4PP0+Y3Z1y
	16aAnOzPSey4dSnaPskfSRr2eJ5FQyrvoylpbxVSX5ghS776C4aiy35sH9uRyruAcuL8Tv3056O
	kj6TKEmP4yaCz7cnXMzTdXBlhpUJAkNzRXY1AZxtHOF964ZgpMdk6TXSGEPM9kaiDTHGNoNG9fM
	cf0fU3FiM9GadUCug9N8rN/a/HjpSRCAiysb9FEdOT2hq0z0qfLMif/WpmYsT/s+NBblB6mxg+o
	polJ14rMf3nO739lhLFvU3qy2wufDCqlABqIRB5ovo4aBfKp8aY7MZUyAEnHVg==
X-Received: by 2002:a05:6a00:3d4f:b0:84e:b7ed:7d50 with SMTP id
 d2e1a72fcca58-851d3963defmr10807492b3a.16.1787168701779; Wed, 19 Aug 2026
 12:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
 <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
 <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com> <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com>
In-Reply-To: <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 15:44:48 -0400
X-Gm-Features: AcwNN1V99rR847SZXdnEMkm7cBtpoxTJZqSrQNy8-DwUpwkE5RcNIZz_017ZO-o
Message-ID: <CAM0EoM=dvzBUxeXVGw83uqqe0Kp0y-6e33hiJ0u1R=KNn9-qAg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 12:01=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 5:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Ok. So one patch per file?
>
> I would have done that, but you are the net/sched maintainer, I will
> certainly respect your choice :)

No worries - lets hear from the esteemed sashikos, if they complain i
will resend with separate patches.

cheers,
jamal
