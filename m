Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8803321C2
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586492; cv=pass; b=ODFrEvXZEd3dm5zA0JD/Yc6m1ibmnwHUJq44OurBUsgGxPVpFB4ifwG4WcDqSYnolQxVJRZ4ry7a/6MXgrEvqVGDuWFIVnmdYO/FpjjBT9x55bJ2GVZ569PmvV/Kr8gZNbhlmDe1Q2FrrCTg6enGWjQC3oFz0Ksbtl+Ra4RD/MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586492; c=relaxed/simple;
	bh=hlqE4YkW5qnrwzgS72oZG+BgbCmAWDd7xaZ3TX+rX00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPH6cJfxk6hSEKQ3sYvPZrycOtUd0NocQ1A0H6JLOtLznjKDb/AqU7gDd/hPZtXywFegPltnVtLhre9qd6pXf6BC/HpXPLRWuCbZRaSyyrTEM3GDBcIwb8XUeeG9axv5HKaadTyV5bivREZF4SQ9IXUy8p99QfcoucTyhCRHsEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfI5eyFe; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfI5eyFe"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1850851a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786586490; cv=none;
        d=google.com; s=arc-20260327;
        b=Au9gOLlx3zgZwG/98lrSugaGWsiV4LlKahuKzJZTIzbcpRBF3M9ryhAxR1dQgEeCh6
         e6FnDlvUyFd1SZYpsH5UGRU6umcv/9D2duHhJm4aPnuOimp9sRncZZBQmSs1CF3nec5T
         gcmRFFhBm52s3Wnqm+2XSdNg4dbd+ruphzZ0SFAniLCmGXB/O3CFIup+vM0TGfE9uNC3
         6gCtDdtzpdt+aJKu0xc9v7aaKWYoAg+wdOSsxopyCL8ggz/f1qNuFj5uKyL77pdA+QXv
         EIhyDZigWsYVQf/oZsIhRoJm6c2kHRnYCJtLv5HQSxL+o52yqz5NZTuj/XToYzjfzWJh
         6BlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ga93l35D89aJ2IHV9FDqwS6Op1XlfD1igClEfFwYr1A=;
        fh=Rw8Nl08Jbv7HlPnZQtWgowRNoueFZqC7OyyK/BQ1Nd8=;
        b=YaX4hhQEVa6b7tnfJTLtP7t744XX0GGpHKrZzv/5eBUOcXP9POwcD5zvmKcn0uYfC1
         JoAQNzUfuVacCS9R/QUSYlJLenUBOIL9V73+TM1buwQMSRwubxcJS6k2VtGVTg/SfBxo
         dpdp/SeALYQYxjSOosxBnc0zhXCVSNR4As/Wlk8f/hBEOQVC3Wkq17csLftUe9OvswPs
         7CkQlqvWn1g6QBMAOoBkKMzQc0Dan0Cqzj3dXLJnVo47TIb9rJQGTD+lYBB+RsgEME/P
         8frcM0GWFOKRLl62JCuaDgjnlZ/jVR07Pr+i98TbOYljYrsOFZAbFiskq2uUfZLwfvZS
         J72w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586490; x=1787191290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ga93l35D89aJ2IHV9FDqwS6Op1XlfD1igClEfFwYr1A=;
        b=nfI5eyFeCC8D9jCxCQ+WcwCJ6bTPUaAJSzAOPKgHJHa9KypsKldr0sMogFvrw/Vpl4
         oW0+sJeX9nUvi2KYBwmEZnqlSkSLzgltaz0wNseM54GpY2lq8J6iowmlLcl8sjETut2l
         W8LvIPPzDKMWyTCuKz2LJwi+EeThkgIA0VFgU/4p4qwOSGRLlgZdwX2+FrBYurj1tYBu
         qvn5LDBDV8efAyvf9B5Nl+gTZVX/rLu5aKzAWwb61UVfJy1k2ZxhSBOTrcVetpJvBNS8
         /kGRuIbw7SM1ju4kH2lBiYXB6iAEKP64r/qXdLUCqch6nFl95JxVxwixL7/HZOIhxjeK
         H2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586490; x=1787191290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ga93l35D89aJ2IHV9FDqwS6Op1XlfD1igClEfFwYr1A=;
        b=cZbHE5/iWVOw/veC9eKT/15EMSdaOryys+Be2Vt9xQ/35CDkaByOGW4kaOyWAjiLjW
         Ee5jwNclx0i6Lezlspyl53RswrR0LNklh1JJ0rWcOSVmG26Sd17ggznMrcbOoD4iIexY
         HkHnB5Q4Ul5cmQsdn+KfRAOZVsPwQyR1MFsOofaniRylfC5/L+0XhUbAq+NAOn7IL5yX
         ZHCk/FWSV2CLHDrzUvj1Ktup+QSCp1UfkrSsH3xzCEo/WN9hLiBTWecNWtW/SqAXvtuC
         hZsoxPHcZ+4ck4jD/XFxl8maSnBa+C0esUsvgBbnYLTTcPG/TzTWPGVmF20JhCtlR589
         459A==
X-Forwarded-Encrypted: i=1; AHgh+RozzAx21B/5/PXqaDXWopxvs+qR3QnlEEYym3CNAi7NyqXK06tUo/9KlbTBp0/vsmvHu+7RjUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GxWpHU9nJc9DDofB1T4wEd2dLUK5ud6WJIYeXPMv62wD/FMl
	HSONMYZtlVL7RFMmx4szAgtJ7YuHGYjV9hAhPOp9q5BR/4k2WL//eLa9cDAH3se+pfLj5kTLBSi
	3ynx6IIrG6AqSElLmKvi3uwKOGNPc6ZY=
X-Gm-Gg: AR+sD11eVzmeUrjrl6ziFliXg8v5SGnBKinpOVKjkdvRbnuYrDBi3nDH6P7cOcWCakt
	GW05xhj5yfi8kE6L1kEt1OoIFMANTAoB1LgmiLzJDo+KjezPVorpPDk8SZIkTRh3QYszsSxOQMg
	/o9kKlcmRbrn0BPO0TuX0h9tO3nW2KupaN8hyH1TPbVGKFE+pmCpbwyx4sDFm3IkFDdsnZnSIi6
	FP/dtsK86SBWBBayNxiN3hHqrmomg7mlU6N3VtGGKcrs7IPtZ/ikx6sjPBa/GuIi0JqAn2PQldu
	xgz654LHWy3C/aP2C9sQSk+G7bcdBlSIaEfMR3UPwbe4wOtSQqW2eK+hmad9dYHIOV0hpwwZ2S2
	SNkS0LQtODZiPDXjAfAbOH3FrUU+VcMhBFDVAgzOO9CiRArS9pDt9Fly/
X-Received: by 2002:a17:90b:2246:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-3931dfdcc9emr2607429a91.2.1786586489664; Wed, 12 Aug 2026
 19:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811034715.6034-1-phucduc.bui@gmail.com> <81a38486-d4d8-4ca2-8d22-d3d178c17665@lunn.ch>
 <CAABR9nF4q=eyUbzmo6-Co7NfVcg_bufHnffy8Ho4ZehHFZpqJg@mail.gmail.com> <017b2a0a-0092-4958-b554-45139db50cfd@lunn.ch>
In-Reply-To: <017b2a0a-0092-4958-b554-45139db50cfd@lunn.ch>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 13 Aug 2026 09:01:18 +0700
X-Gm-Features: AUfX_mz6vikeDAWQkBfvSuo0tedoVTQ282pGLuo_TeMhsfWXN6Hkhq6AgPX6zzg
Message-ID: <CAABR9nHApFe45RCcXoHDiNh6yqnyVLxgD=oFmpYohQ=QT9=wfA@mail.gmail.com>
Subject: Re: [PATCH] net: xilinx: axienet: Propagate errors from optional IRQ lookup
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for the feedback.

> > lp->eth_irq is assigned from platform_get_irq_optional(), which returns=
 a
> > positive IRQ number on success or a negative error code on failure.
> > Therefore, a value of 0 is not possible here, so changing <=3D 0  to  <=
 0
> > is directly related to the error handling described in the commit messa=
ge.
>
> I think this is a separate change. You can then reference the
> documentation, and its example:
>
> https://elixir.bootlin.com/linux/v7.1.8/source/drivers/base/platform.c#L2=
70
>

I=E2=80=99ll split this change into a separate commit.

Best regards,
Phuc
