Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600814D9F7A
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400853; cv=pass; b=QBlb26QeRb+dR4ga6oqbgoqrIkSIA4S1XtQh6SPQR80obo6fVnADOsz5GcVcHIF1KlWxdvbN4J+G0buyv3K/DBxwv0TYztDUwRrp2lCFdykSp6OQEQeDk9XALpbK8JMCkEYXWY7cjyyT0hzFs0pRzk0PnNcwce/IWqy7YbJxTPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400853; c=relaxed/simple;
	bh=EjsbS1eNmBDsqz3O/3wfC9b/H4O9xUxhKhhvWtJGAyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwMWFtepJxJOUUvhzoiXi842p5uF8xi59/4nuixgs6jhjbp9Pli+HvIi1yRp01bzTk3qkV7YCKxfBOTPFVW8YiHDT44nKZDfo2nEASmaN/hmmHrmviKYsTSIhDztd5DwtvWh5dpX24lM7F4QSZ3/HjTGaJ7C9zQzQrCg0SRjAHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co1OE/pY; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co1OE/pY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso5520304a12.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 12:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791400849; cv=none;
        d=google.com; s=arc-20260327;
        b=qCq8UcnnHxl63YXQF5p20cbM4arHFA5ZDQU8dNPPOD8TQq1JJmDOHqgBI5+zU2PTAx
         EpFyCo8ZdukXnA+BFlx1HvPz/d2/8tfr9cQwB9hArHGq1oVF8bdqh/4D8f2Xv2jRB4EY
         VNXpcC07LW5JRgkaJEziSnzvap/lx6QVvXaCS4roznXJyx61+leIQMcYG/tD1ga1+GuL
         dqif6gFnRmhKQIovwJZHqGGmNcn/7a4fNjOyMOEZeyEASNKEacYrKg5ocGKwX+CXA1zN
         gEBFLGZOBx4mZpzg4bao/WJ+hxU6xPcgrceA0uA3p2vQoFJBliynGOU/f/3l2huRjlhw
         iKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMoO23SY9hhpB+IiBotOf4kCqfNYHJ3tVwJFHgs1Bks=;
        fh=eGA2bSOerVHAkvo1l0zipwMttWrtxiBrwTDkGnpX/v8=;
        b=psNUud2a0oWUTfdU9N9lAmZQJfrh96FXTAK2KZLHoJNAkaeKm0jc9vwdjIGuj2tKfE
         w0ZwI1TAzBlNjLMo/YQ2N/4uZgfEHuchcWa0PoVEusejH+JxvHL576H9Z0JSGEmv1OOR
         cXivoaL04kQdLladLzVi3BktZd+AHXCRYBegxhY0QeKHTw4rcHh4p2Z7XCMLlK/1wSXv
         n7Y/dsCoR79C1TTTXEi1+H/QZuuweg5oWAmks96OopjYXgt/lNe1f6yDSSa3QldPyPEs
         qLiS8c7FIvBwWY3zAI8jBiFXTJoMFYr+ud3pCw5TpjfpVt4r9pBqDNDL3mEvGnau20jj
         uVdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400849; x=1792005649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMoO23SY9hhpB+IiBotOf4kCqfNYHJ3tVwJFHgs1Bks=;
        b=Co1OE/pYWQaPA3/Bvm1pfFCnieDeC1tdutZG2smECrgHvmYfdh+etiAivqa4I8BOF+
         wFiTE66zdNcMpTilGaKDyr+kjTcnyY51Z1k9Q84qTub+jqrecPW65X/80jweUbRgtr97
         JQkRki1R83kdoT/EnjVvYaY+QVll+I7nYsyLg1Oz+lGFVkFzK76lPhnTT6Yvt3acdgUk
         s2QgkAjq4w2Yjvf48eg0RAPlNJwRvmrqmlOPV2NUvHBr3i+XmbmS7IeQvEA0daBwAR8d
         Ofa8DADoolotiElC7akJtAGPcu19/BHGIVMkt9WmMz5UY/1grl7KbdcNb0IEySPFG5rA
         e2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400849; x=1792005649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMoO23SY9hhpB+IiBotOf4kCqfNYHJ3tVwJFHgs1Bks=;
        b=17jwSFCoe9t0Lxz321Ym3snmdyh3ComBOgxfTTdeTIovMZhhBcKEJtUx0nHbyDZnWS
         KKs/DjtgKELlaUm2V+q4NL0MPWhpowdwTMDn9ricmBzsNuVJE2HIhKhTQHFVfe8fZ9n2
         uI9ENG/l9i4Eox3hpNs+Txm3kSNny1zMp/B2fToUmJVPonjCQjXZzArqqqNi57J5+Tf7
         7J+h4nA74m+fQEYl+mAfdY886ap7H3fYoo9Slbggp33Jqpgq9/5ByfPIJEPduqOqrKdJ
         NnH1LZQWqd6RknfIHydFNkyIzej3jwVqAhXOj/aihApmE06DTBlWfEAxcXBXW6lo6owE
         62iQ==
X-Gm-Message-State: AFuF++mkJhKGabRQrtap3DZnaO7AwhWfKYLi1S6nC4A7iQnbefv8yZ95
	KuxDCPROqCMgw276a0EqrH6OyAEUoGdi94lptHFEFAOIkqo1PGgnmbVFWtYioA/jqAU+auCcpPW
	E4xPen3NMrA744RiQCntwTEAhs3N0Dqc=
X-Gm-Gg: AYBFou1aekXHM5AIe/+aZ4Qaz+tEdc7BMNCoOdZr4d0Ls3dwSXXsM7ZSFkcVVf6IvZU
	Pz7H2uw9Qo7tVqzEZKt4JNnauF9QdB3hikAXWr5q6gS23vihEPy+hnsqnOnsSkW5ROr7c6m3HdF
	l5NPClYlB40l1DJU7ruK781mfyYnJkp8enuyHBW4O6QScou/xPZvnFD10/8wp3UuLVZfCMZdNky
	znf838HKhSfftn40jPE3oST/MuCwwzPXkHNb4UUEdORm7/BBJouflb0/A2mpj3twyEo+mtOwHnP
	fkFl6dtvtaxUJe9ipU9ayC0TdZPBLXBV6e9rmMTWXlCy56tKFcob2pyZhI2ZfNU5O0fSQ+CIx9B
	juRO8E1x66PuP3LZBoxWCy9TrOv4t0VfptGeDU/96WfvQRJiAqSdPnRe+tUbCJLb9PPTlFCMo3r
	LgM3lnvStFCtmmD6nXeP8pqGX97JnfHZic5zWGVceD//jhf16nleKJk/qOX0A8F88deQ==
X-Received: by 2002:a17:907:7b89:b0:c2d:c060:172 with SMTP id
 a640c23a62f3a-c317bd9cd08mr366600566b.10.1791400849357; Wed, 07 Oct 2026
 12:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007182112.821061-1-rosenp@gmail.com> <179139748566.2527009.10663595607133766847@kernel.org>
In-Reply-To: <179139748566.2527009.10663595607133766847@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 7 Oct 2026 12:20:37 -0700
X-Gm-Features: AclHuK9d-QkdC7CjqBtRz-soH3z7oZ7yyf2mAw6rm5tTthllCcH0Iu_mhkGjJ3s
Message-ID: <CAKxU2N_k7YL+JmdgoQP_9hRne+Eg8udFyEjLOeiKUFuus0sfcw@mail.gmail.com>
Subject: Re: [PATCH net v4] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Stapelberg <michael@stapelberg.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 11:24=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
Tested on Helios 4.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
