Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FA2248BE
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786763652; cv=pass; b=pkMOxU+oRL//ucg5PjyEq0KW5eDhYLCgRIOcOiquCrTduMHEd+pyD/doYn3sTOKdIPpA4di6zGN0Ysjfz6S4U+Fw8EdVKux5ej8TlVEin1jC5eG/9NegdnClm8Q+MgJ9do1BeCDF23tbe9gtZdeCEsG427FGj3WfHF4Aeia5gpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786763652; c=relaxed/simple;
	bh=C3V/eB2si6PnrWffympSjftN4xffJyXASce7EUYZ4LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzOey2T46KpiCd08UxPWAnxwUEgyTUgympN1qo/3bbypD1twkwJc7R1fTPJzCxWVgUy/8FjQ0u5HYF8ZuIuGaudx0Jcub9XS/WQXoYH+P/yXFxqJyMFzITUwNztvd/V8vgArWKTMZNjk/A0M3lhTIse7gBA0VZK62Inz8EQfxIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG0stGcZ; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG0stGcZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so17580865ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786763650; cv=none;
        d=google.com; s=arc-20260327;
        b=s2EoeatUkRvabO2TuL8czC5GL2X6ZORlYindr6VXS3q6QhQIiej4CI7X5MTEQMF7UG
         EsBRhIsIw7/pgTkWHu7W9PYRCC2P/cUlaSkc2pMo7KDLn1Z1HE6PfObZjA3m/ehxRcfd
         xw0pS0Y10dzOj8Y79cemd46o/IL2TE/3UYAvxzbepOTwtAEl+B72oQKlLbdiRBg6SV+7
         mFxqRHtSTiiX07p+geg0P4ok4h5nZKLIeRC1XOHP0FKzDhE+W3zb/dH6UhJmYTl42WmW
         smgO8OuPpjvPEV4lxDwNZD4Pa4ZyB291Ze5hOWRUqwGcYCY+FBmDwZBVuhyDuLiMd+cJ
         iKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C3V/eB2si6PnrWffympSjftN4xffJyXASce7EUYZ4LY=;
        fh=/jQPyImdig9EisHABK3v1vHC+erBTOjliFAZb6muLIQ=;
        b=bMUoDN1MOu+k2vRt1RqcvOmVG2ycOB4q9c1fULblU6vRcbWpr+78ZrjqSglQwlfXcA
         VvX5hzN0NJWn88+Ikuk92oHIpHvQxV4CIygvoLiIz0yLKyKRcRQw/5thGkqwNfypHgrI
         k/5eGEy56vJlO8ybbk07CcE/IRMV8o9WhSK1vZARK/aNwKNABPbasd5hNbEI7S0bLbrp
         4jb9vT5RaUc/Tdo6ExtkkAnR/qRHw8YKUYg/Sae99UvBQ4pDkixuzlm+LhO+N5hbZYgs
         Rfo9c9lYfvq2QSB/Fpa+Zx183IO6+mgcceK1Re6Xy6QacIAiXXo7EmjaKTQ/4l9Xc8pt
         jU3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786763650; x=1787368450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C3V/eB2si6PnrWffympSjftN4xffJyXASce7EUYZ4LY=;
        b=BG0stGcZSpUWRLj2nQICD66E/CXAsKhssCpp+LXbKWq9H1O30a6NGQOcx4mNQtLEu3
         4xrMW3TiWNKNjJtlM5l5S6VxMpGx+4Zsv2KEo7N8ypZbw0bSlZdK/sG1DLfsUNXvH6Fc
         1MjtLnbGwO1AIIqWJS0Io61Efq49GO395iQf8mIN47E/KVxgmteHOrqBtQAp7tGR886V
         oeeeP9q7R1l8rgwW0OnOA8W1UAbckiijH+s1I19R+eb9tgjFZ/tukyQ14X4sCcq4tfHZ
         fvKyPmDUubqmAj8I8Oh8L+1wAHU088JZEOqupB9xwNolyMYqKCmZCJ+IB9Xs53DdlzeB
         OiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786763650; x=1787368450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C3V/eB2si6PnrWffympSjftN4xffJyXASce7EUYZ4LY=;
        b=da7t4DCCZ4+3NgPoMJ7wTdjpkKNJ8/mkxWyzhcJYxcZqo3xzj4cGQUIcBYzaEaEMDG
         36LinI/LeQjMaAglxmqtCR1+FajQUh5AhOgy7zaWjH0c6rc+QnsL63nlG4ewVw+gaE6x
         m/9CAFnqtQoEM06BZ93TCGDTNFxQYQzKJIMdg+5Ju9CCsRctdcW0DPIb/wAdnBkyUmmc
         Oiiv1DT3VSYfABIgqUjc1/PyEIYzof0maxy9X/BtwYtOUgEez+ZdQDzc5lPlPH/xNUoo
         x+e9Qbo2dL+yiwa6bCnU+3iGZuplwL5yebKUqhyE004azuJUAYq1gIm8U2yHefNJ0Ar/
         idng==
X-Forwarded-Encrypted: i=1; AHgh+RpT14Y76lkpDfeC/kzZ+uHUxTcG/lKA5bxnEaeyTw+RlGy6o4M16ibnpu52IaIx4zoM7DDaeig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMoppdbbIIC4V/WQgPsFlWTiMc21AckV8KwJzEV0od2ByC8To
	5qHDmp8YelKVWg3tONiKQMEzUM1Z3QS15yYQz1sRbfgOhx/hguwvcO3+03Qw3JR6DvaoTUFeBaV
	jW6MQJDl7ZiXqvLMb6SYFTSSlDkcYmPPhceI9
X-Gm-Gg: AR+sD12V+JUu4ykIczZFSAk0XmU18ZrFYWE1qpQNRSpPMCLyYzGDRFQ+PMhoFcJhLkh
	wxf1ppSZaA/viMs/8pq60+hhLQQt6T99r1bzKYMzIGZosrXzkRYHukPac9uiq48Toa8FkSozBqc
	LKMoSBe1GOy+ojTXwQ7aoy5dVxWW3eph0LCFBbK+/IyBrryaE+FZFxwf2BudR/VKqmUAx0zC6tC
	jJn2gf29YYDN9t9VY1H82cJxZ6Nxr+LMoZzev2yiJClqbWF3DUJ2RuCrUgi64jOb7/nacMnoFT9
	v+LvmT3EQOSnqLslTnWE1mTTWdGnE3RGvnBE3ZuvDgzfrajSQCzwVKsFlhcGjDpheHLR7T3duIP
	WHXqF+2FnsVYP30Ff7hi8PWWnkirzGcJ1GyLDp0YeYgWYR0A+5H0oeL9PpskQyDcWSYbE20qAXh
	Sqfp2b890QTRTJlIY=
X-Received: by 2002:a17:903:1b04:b0:2ca:bf8e:35fe with SMTP id
 d9443c01a7336-2d3b0d9591emr116157115ad.16.1786763650444; Fri, 14 Aug 2026
 20:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813042012.17631-1-phucduc.bui@gmail.com> <20260814170001.GQ265046@horms.kernel.org>
In-Reply-To: <20260814170001.GQ265046@horms.kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 15 Aug 2026 10:13:59 +0700
X-Gm-Features: AUfX_myDmZ1LURZeKvvYo1pSU4U_UuWwDBLuj9naedtztPbUm-U9GqL07KDvox0
Message-ID: <CAABR9nFxfzf8QP-wq5iaJRTL+HG+a+tNqqX2daj-=Cwp46hPJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: xilinx: axienet: Propagate errors from
 optional IRQ lookup
To: Simon Horman <horms@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thank you for you review

>
> It would be useful to explain how this problem was discovered,
> and what testing the patch has seen. Please add an Assisted-by
> tag if appropriate.
>
> Link: https://docs.kernel.org/process/coding-assistants.html
>

Greg Kroah-Hartman previously asked about how this issue was discovered
and how the patch was tested, and I provided the details here:

https://lore.kernel.org/all/CAABR9nEfPqXAt8wDo597qDS3b3KMaHeF6-swAFg9RLanap=
DnBQ@mail.gmail.com/

Regarding AI assistance, I addressed the same question from another
maintainer here:

https://lore.kernel.org/all/CAABR9nFgiNv6cnYa3+ZY3KnjbKpcF-JHpZY8TVcR7H40vO=
oR=3DQ@mail.gmail.com/

The answers are the same in both cases, so I hope it is okay to refer
to those replies
rather than repeating the same information here.

>
> The same check seems to have been added to both arms of the if/else
> condition. So it seems to me that it could be moved out of that condition=
.
>
> I would suggest placing it below the existing rx_irq/tx_irq condition
> which appears a few lines below this hunk so that those and
> dma_regs errors are still propagated.
>

Previously, I understood that errors should be returned as early as possibl=
e.
However, with the current implementation, I agree that your approach
makes more sense.
I=E2=80=99ll send v3 soon.

Best regards,
Phuc
