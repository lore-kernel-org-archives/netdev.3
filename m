Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFBC3CF02D
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643871; cv=pass; b=VjRnzDW5mURZMSGTn65/CAc6KHeiAYSLQW6JtzjRbw02K1yLNXK/A1HxqWP13XYnlP04JBaMVyOI1hiWGzcvuwmgaE3iNoy2nV/nz+R7Az6rr2GR64mspwZXNuSOM7eZrij3UZ9GHZp02jaZizr93y31Z/S3FN3DU/a4PuZqWz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643871; c=relaxed/simple;
	bh=X04DIHMZxw6/5xtn5gumEmBjGtO0g/1ZdeYvU0NA1jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVHtcfnqb2YFcHZMcAJEM2K4tOZDqckiNHEuIeso46CrxF1FtqivnDUhKlJhkgasXSR27mlVImcBtuMkGSjDDnSVG75KSHIC43R5e6hrsVM2IRCbuMuX4ARWYyPLIOC1pHhXtHrwZdxs0EFbdUlknp+VGef1DV+0TUA1140f+nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOopyrHO; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOopyrHO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52d590ce5cdso30733751cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 00:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787643869; cv=none;
        d=google.com; s=arc-20260327;
        b=XfaKzhQQmu8eOqaxlCEjHavK0ZX1bMYa2oTYwkaJc1PftmFmVhDhb7tJJ0NrmKLgyU
         DjDWbokwjw4mK9urzeAum01OzKYLGGx+FCeTVC0DHskBySQOcOJVMsXlOFyV1Yamh22A
         8394W96hoxT99GwRe7M/83Cwo+v4poPvQHb0yUCi03j4Vrb974lKEQuQjcxyhVTjrEEP
         BV14jF2S+uyOgY5JR+sVL+kixmDRqQGL7RHR5Ge6iHUySoZLajbzOFaSKXUALflYXPj1
         3nHA3FxpQYqR1+aVo9ohIE2zZ1AZjYTPDpnG5NkTEkSSK04gFY8J9OvdjLpEJZlelL7x
         sbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=icSIZLjmkJhUkdPFsKLS4ShrJUnEK0Co35qci0jNz2c=;
        fh=NwIO3k2crFV/B+OMG8RytN+VgvsPlWX1wehtVlBQ1gE=;
        b=GIgXYihwOOLBV6eb4aHSOrvAjXqIxSEOiZiB3+i5kdTwiwwzVGXgrKKXArxYLb7aUp
         wPGvmL01ORhnQ6RGsPZKGMLXnZP6rTrrQRT9TUt3ZHcIW1UrB214LfhQ/6LrFcjBZ8vg
         g/hCR13EDbNJpjzYGtmMEILuWFTetoGsQD86Frp8hlQExj9kEXy0DCh9esvX3ePiRc62
         YdiaBUB6xqJN9C0scNtdaOOAIZGY7Qsv9KmwrsR4Hwd10/OolPm0xuzZ6iDB0ES3G19A
         ufF/8d5n7jsBlFRXQ1wvmIugTZZ3ff8W59Ne8cdQ2S5a2ZguM3LA67lOEN2cHiEECOBv
         S0fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787643869; x=1788248669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=icSIZLjmkJhUkdPFsKLS4ShrJUnEK0Co35qci0jNz2c=;
        b=sOopyrHOyJkRuIaWuQZ9hlyT5xTiuPC8iFLvpriJUBJnzvueHngMFl4SY4VK8sjCye
         uBxPlOuT8MQv6Z8Q5RuMkMHvwJ9jYWr2j2GAtX++k2vVtXh7LOHLHN3tE8iDrsdMJk84
         bq+jJZZRK+hVsQrv94RNXx7jSLtmPWsEsuX56EtGAqjr5qLmKtC8WVZ6FsVQJq6ASuEZ
         M2IF1JZhN8glAc4yCTJHmWvQ0h+ICAWDE4A3JwnezEdO7SQ7cvmuHf8RLSVyy+8WJEnu
         NTtyOQIFDClq3iRSqWojMydy2LfGdl4rJ/k23RjDQ3Bi9av9q4cBooyGUvZrmZqDrYT9
         mAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643869; x=1788248669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icSIZLjmkJhUkdPFsKLS4ShrJUnEK0Co35qci0jNz2c=;
        b=Mi8Bh93VbAfGBBIvF/95ZeENJtnfotim5LoU5KKr+Uzx8O1kU2tEsAAqorL71eg0jF
         pCozVfxiCkbsg1aMuTI3PqTKJdFjojF9voNp98CI4w4AHC5GD586Zzs3ICWs9rJzq2oW
         fL55AoDV+gFh25ZkU76+/cAEhPsRZRrJX/RCKRtz86s3fIau12WUu3Y0mLnXroVAa18X
         7LKkjpmB/BXYmNyUft16PKRyhazYeUhR+SZgGXEqpw+ZzVsY9Wep5HJGv5o82sJkGeYn
         sXs4CahSomcrK3ct8Lh7882UIAVUKVcsvqewXG628Q9u9CinJxGpQhlUskgav6U1gUjr
         5TZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZmTA7uGpDNmFn5c/S5qumlJyMPMq9k71oBPd7eqzPFJm0hm7ZqdQmdcOJ6T8KIZltTORbaP4=@vger.kernel.org
X-Gm-Message-State: AFuF++kke1arNGapg1DMCmROJubeFHzejZKwWL2/9oq56Ge5ueN7oZdz
	+isKrfQPr2ONh7cSbA9CP383c4pNtvWvvqrpvX0vy/uEqImaATc0J7SCnY3w/IYMqg+T2/p61Ef
	xxMbOD2ShmTjYyuiyePSELGgv48oJv4hvImHt9Z+Q
X-Gm-Gg: AR+sD13wTLdSBrtGlHrfyzKRzb40upXP5tvc6nqAB4g7SQFmI4stlXVe+N7xcPjcANH
	myi1bonz46lhHILp6hmRZOkbvXbFcD0HY3RVMafRbdkuvfH8C+a5iihfR+ooqh9/cFaDoqcgquz
	/8PCcU9qMwaJSqkRHxAPpBRmVR+3PIdKX4TgbfnbKps1wlFDeXDjbWgpltVW4SkNNF3GDNuBB/V
	4bWCRA1/hEjTzbHZwiawxj+7toISxQ0Gvp1eZifmXI3+5cRu2gvONqBILk8vX84Q+als3AyfRxm
	GnPRTOYcKksG50b8FFnP1Ty+TNONkK9XyXCxlzbwjziJXpBik91bkZFEonTpX/84V0uLdFl7Zn0
	zQ8zY0l0hO8sLqEnZRKEW9qQO/aSV3A5yyTwkLkPshAigNlFkcFgWEh9c
X-Received: by 2002:a05:622a:4d03:b0:515:189c:e0f8 with SMTP id
 d75a77b69052e-52df573a231mr353332591cf.17.1787643868848; Tue, 25 Aug 2026
 00:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825072033.6921-1-a0yami@mailbox.org>
In-Reply-To: <20260825072033.6921-1-a0yami@mailbox.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 09:44:16 +0200
X-Gm-Features: AcwNN1V08EdLmukE1q3m4sOYEto-IGNkL2x9GXUdsJBRGl4YLU1wMSpMA79x4oo
Message-ID: <CANn89iJMhLgnMjhRp6RKBZxhAQrtWqJB9s7wNcshjJ3derCOdQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: fix AO info use-after-free in tcp_ao_connect_init()
To: Qing Ming <a0yami@mailbox.org>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:21=E2=80=AFAM Qing Ming <a0yami@mailbox.org> wrot=
e:
>
> tcp_v4_connect() adds a SYN-SENT socket to the ehash before calling
> tcp_connect().  If TCP-AO is configured, tcp_connect() first verifies tha=
t
> a key matches the peer and the bound device's current L3 master.
> tcp_ao_connect_init() later resolves the L3 master again and removes keys
> which do not match it.

...

> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
