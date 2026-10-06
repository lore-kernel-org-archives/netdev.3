Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397A261B9E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261673; cv=pass; b=sT8+d5XVEXJu/+oAM+paEI+aYsL0SjJgG8alkGO0f7CxhL5hHqE3+imj76SQ7DTmcdi02XPo3uwEMkzgEdKMNW7t/7IsVrcN5o8idMyu3zpi0tB3MgVZOpCU3v83INlP8yUpHFr3us6ksMg2uGFgQ+vRcXqYqQhc6juPqZo8zGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261673; c=relaxed/simple;
	bh=b7Z5T0RYaPEqkn9QTY/5fDqqrHYQwuj5GrYZQPJTzwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjJviqgLrX+I6gY6wO63AMW5quECmYb0nJaFQQW26/SdYv8sW6Wi8Y7kHNoO2cPTTzy8xdPHr2dRI1jC8QqcruG2tGObkF8x1AEXew+ODDiP7g70Cq9+4Wi1b+LLM7R6l34/j+DYVrScdY+ZbA3AxkM3xEm3gyxFTLlRlNshi90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z16Oa2g1; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z16Oa2g1"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-988bb309c2bso94553241.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261671; cv=none;
        d=google.com; s=arc-20260327;
        b=K4waPXnKOUS7mKXqdtld+BZbAW/NQeRRdOYRw5Ckqi0YToEIBz9iq/qJkYtjTEgAMg
         v3Y1N6B13Z5KJrx6JbWTMmDWozVibPh0Rt/0AeX+nfcG8o7DHKEffgFUutSlCpMOhCR+
         U5+KPInk7RpyyRu8AxRQA0fvwfAGvEZF1E/O6enAbEkQdcLEDpSy6X36JDL+f5vDDiIt
         AOznVFvYpZY3iS+h14AXEa5mKalgwiPq/rJE3lLfnGiNu8XjH3UPSneYNwwx/GoaS/31
         t4ktDu7G9PVWDbdbFHUv3iwdKZG5+3TTN//43HktYjz1rlk8oCgHUtTesc1rtX2/AdWv
         mFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IeoDfgNYT8jj1Kan4Wt1vjpXxW0oyYjZlRqiRlFzh3I=;
        fh=d+K94yZryFTsWnbr6cWOkcK6cSovFsXk1EO0ruwUvuo=;
        b=n6zSAsNZzT+GXcxv2N48TJHNp2awQLB8NpvPZQC3sKNnK1BRnh4CbI6BzlfTIIdN69
         bui6ebGbwAUhfKEeN5nCQXrKWEeVAkq1zRAzdKNckFT26JentMhtc7pOrxcu9y8G81gT
         CRFpoBM+jkwb+VyN0kV9oDM07XC2nBW7tDdIG0IwPa4ZaGwKaQHdwd+xA+RKWbZ0s4qf
         94e9y9KZ/SvyVg3rjduvq04c4DqIjtyntiV4f+JzSOpRMosv9+X26uvYo7Xn3yQ3vNAB
         cEN3/6wY2sOqgJ4Kih5YOIg0AxPDjcGExBfw5nyXW3dqrd5BYD7JB1ENXkNSYSVu37mx
         vGsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261671; x=1791866471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IeoDfgNYT8jj1Kan4Wt1vjpXxW0oyYjZlRqiRlFzh3I=;
        b=Z16Oa2g1osFjBzc2qC3urSvZc6+Uaa8DAcwU4TKQANtJqYJScrPwzX6pkXiQsM6hKc
         FKG6p8WxQZojb1NLuwfpj7ANA4pmyG0dVCvW4mwc4e4fZ/eJlwmK5wq9OYwi1+z7wozY
         nM6daDgl0utNL33UnXv9wiJLUVBssfK4r5VrJKRaIyey5lu8DEM3tskBa5yLEOKvmsbO
         6YXF1kvM0j55ZI5DsWf99He0S6n+fbMg75Dkc+RMvM7Mv3abaCNkxvLHFNt2/4BpURI6
         yP/WtjQDUwUWv9DidILwr0xWR4lmC6l7YEmvcZT7IfTmxsixxM3tb26Ev1y9SmZd7Rr2
         YW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261671; x=1791866471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeoDfgNYT8jj1Kan4Wt1vjpXxW0oyYjZlRqiRlFzh3I=;
        b=J7ReIFn/bFXFU2f4OogybGSIY86GrR7bY8P4a67Std7zCi6kYYmfYYi+mCjKk+b0Gr
         OB5HeevwxQKn8JMlAt8jUpOdcvqhFhU/bQckL87IFvzJsVm0vIdOmoGjr2Jp5GPy7Ht2
         lLnjTLdzfNlLZ7DX620TvelxRx3iilUN0lWidA9vntztYa5WAs0eKQkgpDBNsNPnicU6
         MJxoEdINLl1uvNmMJ1zL16RlREHeo9Beb1nQak+c2cXycI6+mamBckOVg/18h0uiYg7y
         rJL4lYnERZe5sdU/hrDpTu90nHcE/2vpuH6fHLzgixxSS1CBCzh/lz30zHP+lO3ROrZT
         tFgg==
X-Gm-Message-State: AFq9FYJs6LQHHtpxUqTfiMqKscusj+3SZdudOOLz1rOcMBpqEbTpWMBB
	+gAfSNp1ytXvzgZ6F1ElFDd0UsuPOAyqXLpmJ07R+HTpTy++3ypJCQh26/P0KbiNm02+YwLnBo0
	56ocMyykWSbP9mOInqyAKm9xZvE3UlZ4=
X-Gm-Gg: AYBFou0ANnDuAG9k+tmF5QaUr8qfGB/5gDkosrHRsO/8pHxy5qI2YH75VAD5EdUmvxF
	RHuX4S7EPHkgE5dvMF2ouanaITlnhjnHA/BFA7qAZo555MdsHF2IbBQy7rh0HEccmS0nJ4G8WH4
	2/Cwy89D9Kjsvu8nnHi5SPnvwoF1JVda0zr47YC+Si4PenuuGiHTo9Y9tHhetpAzuPZTslEiAFU
	Ma5rIkle7hYWowML823TADEUle8hTMvoeSTcAk0RNR52bI+e2GR0+0P2ynIQOG7PmV8mJEZgXdh
	V9+9nmeSjhIpUBwGQfr0pzkDoPVn/8DAGrLXgzZwPz8RhcbM5SSHdn9Gk45cC12vtIMCg7wn9pY
	bvCr7yu6Nu9DRN7dReE/JQkpfXaL8dpXeidkozT31aAhz5kuvm8nl0JwyMHIVXC2/GDUe7Vc7vs
	+NzKypijpmwzOXhZfN71b8bwAfXbIWG240MyJJJxdnMttt
X-Received: by 2002:a05:6102:54a9:b0:7b4:879c:bb76 with SMTP id
 ada2fe7eead31-7c87a21822bmr29412137.21.1791261670633; Mon, 05 Oct 2026
 21:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com> <179083314427.31693.1407407420445848454@kernel.org>
In-Reply-To: <179083314427.31693.1407407420445848454@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:40:59 -0600
X-Gm-Features: AclHuK9zKgof2n6jvYIhDW6Tw2zSN3edePIn9-NkWw6URrUfpM32rFePJ-dC4fs
Message-ID: <CADvTj4psWkDPe8F-Fz6E2aovuL-TnxO3WzVS9scutc6GizmH9Q@mail.gmail.com>
Subject: Re: [PATCH net] ptp: vclock: reject failed physical clock samples
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 11:39=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Found by tracing PHC read-error handling while working on the larger
stmmac MTU/resume recovery series. Related cleanup issues were found
during follow-up review.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

The failure handling was checked in host tests, including reproduction
of the partial-registration cleanup problem. I have not reproduced a
clock jump or teardown hang with a real PHC in a running kernel.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
