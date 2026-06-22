Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350081E2606
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146738; cv=pass; b=AjRRpuvqljGMGqTX1bjqxAjoQl0LPCTrI8EqKrlpNc6NE/s9NIRWp/dF68dHiQAERRFkyVPVx6FeWQZmm3YPVoG8n67WAnF1lZ6iSWgn/ZaK0N4G+gczdy4UNfrYys72WP5KEkXgDegj7cRe5zk4rEkzHBAUUrDFYm6KfGbEyag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146738; c=relaxed/simple;
	bh=Qyr6y8XnB6obPG2Cww2lCaufpiPWQOS3nnI+2KMnuZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzSqU7rJuWkAmolUOn8KcMYvE6Xlq0+nislAMTQ6ioLqbsltwX38uiggUGHAJT1z7+9U9YjFjLbKUlVkifMe85rk3nUyQEiFJepMZ4q0GSoffSe+BAevB/+plUkRiMjifmVhK4JeSoWscEcRduyIvl2QwZj9inmOB6+1e5s6GrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUayLHjh; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUayLHjh"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4864ebb6268so2628540b6e.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782146736; cv=none;
        d=google.com; s=arc-20240605;
        b=KAieZU5FcgR35Ng6FKnWoJt9XYT+7Si47KVqlcGTP5pZAAJBw3ISCJ/vxcjHT5hkFu
         9jEITru+cqZK68X0NlA+TAVS2l4dMMomaTToegmxysMYtNex56px7Hc4fyvj9cC4yj57
         zUzbsTaG9FtN9/aX183wN8EL7A/xLuTvQgGsUCydoTi20h0THVAHJAq+yKVOXq/Cr+jI
         wq/zAEXHtHdRlBANEqMViTrP/ARIJw4qdvN9GqqX0VyM9UamfxR9KAt+FwSqrReQroAo
         CKgGGzzVPsZf31ELMMqAqYpd8yFZEBtoW5/++35U2lFNy7ii4pTX9d0Yxooj8xRt4LHN
         RUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qyr6y8XnB6obPG2Cww2lCaufpiPWQOS3nnI+2KMnuZc=;
        fh=RBkxkx+OskVRAE9rMLOt0J5nHXyjp0FM5UQ9DgLyWMw=;
        b=A+7lZv6qIfB9lOLtI9Ah2E0PsF0ZhRolV1EW6/6OFjlhy2IZkMKBSe1GoTPHBP3i+4
         9AxBV9qAn2RXEGjaDzDJopFQNgep5mVPjNGd4i9g2m/ExWGA3dYitVy/OCZKAcR3p55A
         FzVa3hOXRSeEV0P5ajvcd7CM4FTEvZHTkDzglhBy9sQ1C10lwJwblavyjHM2XCCMvtEP
         HalZ6/Lelfbl+DzQ+qB3IuqPPh0Wbx8N+tUjyZq10bF72nHgDOl6pajeRLHBdEJUYLg3
         IqJYSUMp93devrRfEpJh7Z1FMMZ/0+RHL4B8nAgr3gIVWStQuDCWTB3Aze67VT1aZDUW
         9Izg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782146736; x=1782751536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qyr6y8XnB6obPG2Cww2lCaufpiPWQOS3nnI+2KMnuZc=;
        b=cUayLHjhUe8CgDtBMfsORarpccSAK3yRPWuN9/wCHkedi8WPsAqWYJw0MONMTK13qM
         qX+3T+igwS+g/6tsP9MeGuBtIXEhivy9z0LY/QS5+a4/g/fBmxhGOkp3RY0ehzKkYuq4
         zFd+cqkaBLtnh3Ik5UOBlB1y15yCRY2/CHex07d0B075kyMLVewg/uAEQ9bEP+xksOQl
         7oX2E7MvcJcQ1x/qKLKQmTsImLRqITW6f2kNh2hoBvJNf4KWyU2H0oPu+mgLb31j5PNk
         55ECFjgLNfvZDsM99vh0/F8KWvvJfqGA6Mhl3/FfA9Nkn4SAf+r0boWQBYM4LgwP/X+j
         Eang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782146736; x=1782751536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qyr6y8XnB6obPG2Cww2lCaufpiPWQOS3nnI+2KMnuZc=;
        b=gtO8O52HNP8ET+AInWgRLHscBofgirv51IMRHp1GbWTlXGxh5n+N2N8PJHBv/HSWvR
         IdFFFCVqP+g+CwaNxrtIcZb+R2F0lo+DImiK98EEXOEnAZhgsS+1av+kpt0HjNAT2PNC
         o6FNWj+iYc1x0UC4xu0VqfZ710ewe1VFz/A5iue7TQpQ3QrCZd8tO09bC2lbLMnh+LUP
         j5G0iJ/oX1tza7AUbnQc6LTRwO76eMaBT+Jw//D9TtQSRJnO6+lE+5WvEjiwvB+9C8+o
         YH/XeeBXBOiV8AbZ/DcVlNioE5meuAFvgwHZ0US1Ep9W6AWozCLGhD5sg1j+mZe6usGt
         4FTg==
X-Forwarded-Encrypted: i=1; AFNElJ8tiH2UfcmXg/hNHfxhyuOkZs1QDEmP6SmimO2tBqME1xQHGZs1dxdV18o4XFOQ9t79xsWLZEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4P89xNml6KeWqnI7IcNXhgiaF+UnirPfjYBdgYmjDoj1m/RJR
	09I7v+TTQMk+KKKt57gmfW8kbHHcWpQOagyi+fcccnBpnUXKMEeFQw4Gf8+PV5q4QPWTHuYdtNm
	aHrmwHA6kckXWx5ahUcw1VxyGBwn1SlY=
X-Gm-Gg: AfdE7clzN8qkmi/PDUCg/3ThcuGLVFCE2XeyGTo31ktrItFqGCaKMQrmkez3CLi9ZIu
	OGQphK5M3392MPImS3UYv9iXxG1OiXcOUODkQFzPsJ5ACaAb7eTWHYOhB+MIO7pfsukBJxOPWmN
	oZ4YiBsZXzB7oFGwD4IBK46gftcay1zJERaeqoL4BRHRSWry+dPdMpRb2IbwamtrXqkjCbB4Xhc
	iKQW5Pq/IVAQYTNBPLmyvo1pAs7L4//F9w5OJf4v96D65HVXhSj8dt7Jiwj6ILf7iZ1nrzs
X-Received: by 2002:a05:6808:22ca:b0:489:ef64:c5f1 with SMTP id
 5614622812f47-489ef64cb2cmr8392827b6e.16.1782146736182; Mon, 22 Jun 2026
 09:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
 <20260618175619.671a4025@kernel.org> <CAFnkrs=kE3thiFLaOULGv3n_KgR-r5T4vB7hxJsZL4iAihO31g@mail.gmail.com>
 <20260621132239.79000dae@kernel.org>
In-Reply-To: <20260621132239.79000dae@kernel.org>
From: =?UTF-8?B?5ZGC6Iqz6aiw?= <wellslutw@gmail.com>
Date: Tue, 23 Jun 2026 00:45:24 +0800
X-Gm-Features: AVVi8Cda_mLyQ0oT4HYo2eT9Zvm1d5qBcqT7-YuOH3UD_q07FGXEs_Jra9_mlXo
Message-ID: <CAFnkrs=7_2pQiP=Z5SpDCQ3z4zDaZEzqirdkmHOrkySofMb2UA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: ethernet: sunplus: spl2sw: fix of_node
 refcount leaks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shitalkumar Gandhi <shital.gandhi45@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

You are right. I will submit a patch to mark the SUNPLUS ETHERNET DRIVER
as Orphaned, as I no longer have the hardware or the capacity to maintain i=
t.

I contacted the managers at Sunplus, but they have declined to take over
the maintenance position.

Thank you for your understanding, and sorry for any inconvenience caused.

Best regards,
Wells Lu

Jakub Kicinski <kuba@kernel.org> =E6=96=BC 2026=E5=B9=B46=E6=9C=8822=E6=97=
=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=884:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sun, 21 Jun 2026 12:38:06 +0800 =E5=91=82=E8=8A=B3=E9=A8=B0 wrote:
> > I'm sorry that I can't test the fix.
> > I've left from Suplus and don't have the relevant hardware.
>
> That makes things harder.. but you don't necessarily need HW to review
> most of the patches. If you don't intend to serve as a maintainer of
> the sunplus driver please sense a patch to MAINTAINERS and step down.
> Right now you are listed but don't seem to be fulfilling the duties.
> Or please review the patches to the best of your ability without
> testing.
