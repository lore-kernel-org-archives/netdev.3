Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE42F260C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582187; cv=pass; b=B3tVIpacLuxSobZAUNrBWt7CeWYvtUXXCtBRpVFqV13b2nRIVXye1YdCKmmdMtBP2uQNnMO6kxTCr8XEWQr6cEZixphFaxfYl714u9OFa51hBndIYrnzZ+BACrmFU6qQcg64S3Wge9V4TXQyN7J1ZtIjL5HMKzmnzsLGlsqzpBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582187; c=relaxed/simple;
	bh=ntyuBygtatg3S9e/FanppbVbflFKD3H4Sq5wNjVGCcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKtoZhBUrh9bSlKyYmTJ1jmIje7+AB5H3IXjUXgZYnxRmLIUZVxkkam/jUDi3zQ0XiP83kUX/DRrQxk1u8z0ezUoxZVhZZdE8/Ae18SVR0bvwRCg5F3VgsExMi7MUS2acLsfI2Yo9XF3SBKberSRxdiSL6vmMGSTncF4oRhjisA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O79xVD7X; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O79xVD7X"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f7872abb6so719319f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 17:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786582184; cv=none;
        d=google.com; s=arc-20260327;
        b=ARsqohde932WIKz88J0SknUtWXCfYmt1iufBOn9G4joOpl7Z48UuvPeXIornSdvwjZ
         BvhfbzNgK0ipkJw0PtartuVcXku9b2KeZRoihf+rFgvsnAhuBjl6yZ5Txci3VuK4Y1Oy
         Vj17OaWJDFCT5Wwx37DuF38i4wlvb+dmh/uLh3ZaYlzJdCC6lO2NkxQCLfiuyES3vEOG
         yEL6oW377tO6OpN2/5GpDIxPTHqnEvJ0rECvLHPkN5B74dyQzEtBUUbxfTWQlYGLV7Jm
         ZKQ6M3y4ed1ImhCpxSAlFlCUqh7Ih64nW1FEu1Kr3eyhTp+tO/e6upPkbt+EjZZKpJG5
         L02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ntyuBygtatg3S9e/FanppbVbflFKD3H4Sq5wNjVGCcY=;
        fh=QRXTu9w39zctloY2KNXjhGamOLCxG/s5uV+JlYp4ZOA=;
        b=MHw1PHDwRZi5ffU776JTkCTPEaoghN4tw/kzqu3/b8qw8KoeZ8IWB+/TuVZbvEs0gy
         ZtsF4pyvyVqvgxDZXg4omxU62Q8DGhzK97XSACeyPcAZmFRSF7/oVbZEaM+kFXSPig0E
         Tiv0yOB5ttT+Y3NFgoB7jAeRpHMY3qdgsJ0JbwZq+hXo90fGdgM3pavUp79qnzbYf91x
         hj79tbwgTuWDW2rTQ8aKtTOSebZCX5PSMOTwqNeZS9iD73QnAZ9NY16tuWc0/WcwLGn+
         lUT+HgjeEvIJKLtawHD7WYUW/F8OXoPrq79gzETjr+jc7PrJXWQkeOEaa0Ik3ffmkSFc
         86YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786582184; x=1787186984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntyuBygtatg3S9e/FanppbVbflFKD3H4Sq5wNjVGCcY=;
        b=O79xVD7XFNeXkiAc+h36+MhL4W+m0NsuMCNroa+0QErEjcpHmLVH6HAgRFSmoNCKTO
         Zbo+sTPjy6nGeA3gSDDH8OkGxnul6UukcPAgnPqWURnG8mxxq2TQEE+wDokTPxONARQy
         R9YReEO3I+J3xdMrxAnx0skdUziTbPjsUa+Gvl1ekxnMMXqqd7GRUYMQWBrAReh6nlnb
         OcetTkXQ36gWkgQg79KRjwl/EHQtrufCMIsolKvO+so4Bv9cE7Z2vlQp7/P2O9NoUnZH
         iij7ltJsL04spzxrgMW3d0YKRnUhguOqYjwAV5bpPxtACWUUY+DsM4OErcv1SSjpXFQw
         mZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786582184; x=1787186984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntyuBygtatg3S9e/FanppbVbflFKD3H4Sq5wNjVGCcY=;
        b=eGOgmeOeffN3CoZ0WiUI4WZt9ynmFnMzm01svCi0kxE9YqwBFDKKWq49juZcgAPhsC
         BJTG51hafeLArYoeQbIqzgkC9+CJ4BNb/qOLfbhPQj4Q4JgzB23P0Q+3l+4Mbn9rNvsl
         clO82/adID5ees8SuL8wvC5Jl7wKFgYC7i7pQrOXPfhrSjD0iAFptuI0YRqqfZfDdOwe
         T81crfGe5beuMKWFu2YQpgpiui5KqGAmKQsbFQeiBdDAfb+5zP8/zbopw5GpTeZc9o3N
         XUCUrT42CVUlIyNrF4QKH63hQxvTOKs1W2o1qDRh51emCApTBtjRzabLuuvQohcc8FyO
         zJvQ==
X-Gm-Message-State: AOJu0Yy4el6kInuxzm1FkNUzFAtZMw0in8l3/ZKswEnlicPyAnVwlIpZ
	iCt4cPUoVjk2EGxXCW1UkTxisIqjK3VVIpU51ebxKelCjCz+CeSLNvBHy9Cvod1EVIqQFW9fWcY
	ws8cI89DgStUmWUg8WfghWm1P0IGGzLELORJbyhPt
X-Gm-Gg: AR+sD12j5OBwA7jdapZWEBOqOjCSXp7xr8M7imGrTIqG1j32ORPxIF3wlQO3JUeFvqU
	DMxsDRFm8DSrx5IpKtoCdgiMPapaVKEDJrEHZ+m7zbE0jdq1l+lk+o8HOUGWhwvw5rcGowLhh8t
	h/nNlQsT+sL8kDvU1306qq3LPeBFTIvKm8K5Z4aQEdrpIWG4ffftxXwYNcEtyrQVR8pXzvVv0rT
	uddXlpVEmXNd9u4INpiQqSybl4cVJu/pK6MPDDwQ2MdYzImcWy4NMCDEuwgF8dNBmB/NF/4cSDv
	X4kuJdPHfB8Sc1nmogKVivzCCxN+z6qIlfyhd4VxJ8RC84uXFRZF+QkwQp2Oktyohg==
X-Received: by 2002:a5d:59c7:0:b0:481:503b:b663 with SMTP id
 ffacd0b85a97d-48159eea252mr2566757f8f.18.1786582183391; Wed, 12 Aug 2026
 17:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
 <20260619115905.051eb340@kernel.org> <CADWJPTus-1pXZZeYfGqJ1=OR_RPZ5Wq=H2tc1S0_tGi1fGFNEQ@mail.gmail.com>
 <20260804071657.03263c97@kernel.org> <CADWJPTu9=k5y5WmEfdFiemhg+sRA0ZW5e5J_W_Wazrt+JKpMyg@mail.gmail.com>
 <20260812145422.049f49fb@kernel.org> <20260812154344.39afcf7f@kernel.org>
In-Reply-To: <20260812154344.39afcf7f@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Wed, 12 Aug 2026 17:49:32 -0700
X-Gm-Features: AUfX_myPm1ZVxQW0YQzIDwQkgzQweo6ZQMQcb7JnwgRzJ7mWeMuDIytEUQ-3n3E
Message-ID: <CADWJPTv3UjqWNseTskM9bae_NSSLJ4UuKpLYr2Wxd_=kGcPYSQ@mail.gmail.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, 
	Willem de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, 
	Pin-yen Lin <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Joshua Washington <joshwash@google.com>, Danny Gonzalez <digonzal@google.com>, 
	David Decotigny <decot@google.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 3:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 12 Aug 2026 14:54:22 -0700 Jakub Kicinski wrote:
> > BTW I noted that the branches tested are a bit spotty.
> > The gve manifest only has results for around 33% of the branches
> > over the last 3 days. Some of the results are nul so the run hasn't
> > completed.
>
> To be clear -- some of the results are nul, but majority of the missing
> branches are completely missing.
>
> > idpf runner looks better but is also missing around one branch a day.
> >
> > Is this something you're tracking?
Thanks Jakub. We fixed this previously but the issue seems to have
resurfaced. We will look into it.
