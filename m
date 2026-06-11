Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9927257845
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199060; cv=pass; b=YO/MQNEFYGSIWAN9IDkN7lALlrD+Q0KnCr347Y+y6DWNdgPUAiPwndhawm/WvJoC1faURnC0nB6DOYRQW5wB0+CvpGY2OtPvUMQNB0jxN2YBKOGFx89A5AjivK6nbQtQeqjqur0S6pT+2GzCjI32N0UDZmvQjxr4Iu3SWoPfwEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199060; c=relaxed/simple;
	bh=vrHGHo585NkvRGcRRNmln8fijv07gJfxcN6glAfoLlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3qUJ/cH6DhmzB1uGABEtnV+EwCCsW4EekeddxQ2DFJ+UHINcVKKqYXsUyYUEBBbWBS2wAdcK7x5eWkagq7bNcMklpMzSaWD9m0++lxOq2f1W0OeNaXup0Fb0wi/CZH0PTbSMHMxydRPqI6TUD6SfrsF7FrfgwU25iTFQ5P5HWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Phw4gQ6W; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Phw4gQ6W"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7efd49373c0so1015357b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781199058; cv=none;
        d=google.com; s=arc-20240605;
        b=BKlM3q39ndtAEmeVQMnKOhhGP5z4Ei/PObqgrppwIhctvJ6vc0twWhuM7DjjBtJm/n
         FtH8WkmyOCWhQjQWXt/Bjg0BUhCm0JQuMLnRXnnfdH/q7+OvsuUOi95eQpd1c4rzOCZM
         VDniSnnWlKcZ94So9VYQQSfcG9U2fZUw5Epdo2ww8H6sw0Ow7lmGLUNwZGIq+8PXKF7+
         E+Ud355+6UDo56tVSlCCnI2skd69dLY3IYUEOL+4eoqxDF/skVYKB2L1xXDc+X+pfW5J
         zEXE/gmmCRavQ5imBjqVrSvDa2O38IGS22P5itYNJ1cHdEH3e8hlzF5pQs9GxXC+kaBN
         a26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vrHGHo585NkvRGcRRNmln8fijv07gJfxcN6glAfoLlA=;
        fh=v732/D34Fi4ackKTxuHczf/z/BiQLW1VJLkPLuuFloM=;
        b=aml5Bz9zZiXMinQMhAcrr36rYgmXqv0bCsTLJY3PvaprqZLX6Y6NtdAybghmGp4r+L
         cBW1/r8T20/j9gmgx+8h+fpH4M7el6Qt2xd878QuUzKfyHmbYyR9CDWbYjvt4OOiaPzQ
         EqwbZue3CmVNQ3uZdcWbWhMe6UysL/XzSh5v2u3P+RzlBCzyQ40aKNuJcHduUd4MA2/S
         xtH2NLN7SgjwE1ZsjC2nPbZm90gIDeWtAiwpc0933UAE0YJ0ixMuerIpGlaJeiR+fWbX
         bJjbS0NQmqeeNuT3k1F3z3wew2qmsEupcdj5AaC0xBnffZX5JP8K+UGLpvBY/Al+ohr2
         na7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781199058; x=1781803858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrHGHo585NkvRGcRRNmln8fijv07gJfxcN6glAfoLlA=;
        b=Phw4gQ6WodnmIMn3hKhlQlHYu1wRcctFloggBg37e/+MTOFPOmm8PptIJa2/GMwmCj
         vlBgGZ9svnYXT/MiPrRcM4gRf1rKRaxzg4Fui5TDx+ZnJ8ANkpm9p/cFkqZrHWiGmX5w
         vvMrlSsjaZVpi26vmG1OVM/PDX06o00tF1jRo9CZr7AM6ycriSl0c99uO8ZMCYqbEX1W
         Sd8EwNodOrvT+ajbo9Lc0Unn1/2cOH//6Isb9L8alk6vXltu58hIg2dNnNGYzmK8DBVl
         JPT6R5d2gqso0udcEfixM4XAirGwywAA3Cw6pDqvpL67pHCfl6Jp3X7+bVW6pU5bEkey
         hgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199058; x=1781803858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrHGHo585NkvRGcRRNmln8fijv07gJfxcN6glAfoLlA=;
        b=SkDgEDX5mEUDaEGqqg1H06zyI209HgW0tP40EN2BLCbrmMlUtlSwXsVVxwqxH2LNqT
         eKmGESGH9+GeBRsKxs0K9QLQ9+YhJWJd/4YjrVztS+F9sLXp4M8cjgRwVB+Q682qWQyX
         mBCP7UuROJP7dY3/XTYu5A2mgKxQpeBP4/3cFtH4isH6IUy1cApG/XnY0w+/dVBgVJAT
         PXtqLFLSrKTfNtVHb1ahNuXWmfMxKeZW7ES9fbXz8M6vO4oGnZmtlt9djOInchy1ajvl
         bNkQYCQV3kOHaTlUPnuxwimqn4PhWKH8o7zNs4d/zuN87nfTijy8hjFDLxxMF+6fBKxL
         I1Pg==
X-Gm-Message-State: AOJu0YxNtz2BJqjfNyxGZ9C8ikprhmas3QZtOT9o0tF49ZoXMTOOmXh9
	ECs4rgeWl/bMD4aLxYByFysO4X3nQwIfbw4t+A7oWD6wXJyfLJNq8+yFVyC2cH34hAr+lExuspi
	EFqI2W2P8hz9SZgYWQLlutPdXyT8REVywdrR3oPbx
X-Gm-Gg: Acq92OE/uml8tKiE+9op7QCzZMwdkozNK9Z1pHcbQ03xIi5tAVB4WiK29qzRHnMCdmq
	ZJiFFKgKzi1H9sf5/3QcicR7Am4JHGMmyNb1G46wdUPvV7aJb7S/FQZrj5QPM+swV8FfMW3Y1wC
	Zq/1hS47ztmZ5Pgkgmu+1CIU+ESrpYyU4Cl6tLzcFEMAr9DDVRAhUmTZcsx6SQbx9JDzErTr1hI
	H/cDY/pRlLT92CXzmVtqF7J/k5XV1SJy/MP+iJiW0ap6rr9ARSc5uRBz64yMiLSfoEFywuaU2MD
	2X7YefWjiFCZaWO3UrdHKbDfcbvcRwOf6zanwKAy7njNuzCB8+L5nBjC/m+/LrntyYG4fqMpD8w
	xcTc9/fWZ21SyagqAwhOwa2QXbMejFw==
X-Received: by 2002:a05:690c:4985:b0:7bd:4b0c:52cf with SMTP id
 00721157ae682-7f658124883mr41290147b3.46.1781199057288; Thu, 11 Jun 2026
 10:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781165969.git.sd@queasysnail.net> <d124db74f6f0838b652f0ee4b4530964f3cf8d49.1781165969.git.sd@queasysnail.net>
In-Reply-To: <d124db74f6f0838b652f0ee4b4530964f3cf8d49.1781165969.git.sd@queasysnail.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 10:30:44 -0700
X-Gm-Features: AVVi8Cf05e20LntJmH3RuClHFeHmR2wHTU-EsBSPsK_Ch6LoY6ZKNrpL_xFbKCQ
Message-ID: <CANn89i+r3j0yBSLfm9wofQQg9zLr6+F_+y=Q+OaO-WoCek940Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: remove some unused EXPORT_SYMBOL()s
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 3:21=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> chtls was using a lot of symbols that no other module requires. Remove
> those EXPORT_SYMBOL()s.
>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Eric Dumazet <edumazet@google.com>
