Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6363C9ED9
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568230; cv=pass; b=r0TXmpAk+gNbd9OWcqUA/13kf1cEygmbmIQ+lX8sUe1QDDAF4KVbG8IjmeZvFtvUVk2CQFYfL8l/EZdzI2qcDw4vL7ytfa7+CX6ws4+kZwl1/pJLowFhy2ig/pJqD6G6KmraMNIDistO8KHzMg4KiuqMZJZutDQpZcVdyTWltTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568230; c=relaxed/simple;
	bh=+7UxBRN93+sdYitbJEaeBcavKPuj4E8V6fUlzVH7bsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fz77dI/DZXsERQyMWS2OMTgAgRWZFfVpXSkRsG03O5LAKgYBPtzUJA7pWzvxEPsNQfcbguBamUPchW0y0KZhS/bqldGo3iO2091rADe8ULF81q0meBYuCzY8M7Njm6ANTbAlUih059tZCcGSu00O3+85Wq1oO7m8INrm+GNclqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXs79Eq/; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXs79Eq/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49557167508so10777805e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786568223; cv=none;
        d=google.com; s=arc-20260327;
        b=mnOdyK9QIj3c801kiG3yVkHxt/NegrRkxu6P3SHhx58eT4Qv6d1gjevGN8Mg4JQDo+
         B6CMSTZ9grzv4d1FxCHK0FuAvkhsPyCV8aP7W3CJ37Ecfu6rKCS0HiwiXVmnwHri+NQq
         uVSPhPUNR0BmgWIV7vmiFuH/VMF7xmK4Ru0E/fSGjVA9XLd6H+TzgGaHTYGZm+xMXJt2
         LFUnfM5bWGXMCO8YyUUWU53bos/SFClc3+3d3BT03qLSw1cNClogXoHG4HlJ20PfteJM
         c6sLGocdCdEJQ+F864a7hvtnFA10ZGeZOPOSMEi0wihtT5v67dOSuF3TYIAKLPDAnMXD
         Dp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r90klb1IoKEwH1XH9nwO0D76Cq3lPCOQOI83WPY5Wsw=;
        fh=QRXTu9w39zctloY2KNXjhGamOLCxG/s5uV+JlYp4ZOA=;
        b=PzrkGxGSX2C54bGCcFWhFK0pmbH2rTZSZgKxI+pgH1GowSOKL/OOQQN562IXA013e/
         2XVVu3yyxRmah8cbL6YbPkMroBBgvnPD7eNJPsvi/mJUd8303FnGYn2rQNXTuKz/lZns
         GNffQitXE+P/ySBYV01ilHVa/L8ChbQDPA94IgTWfVp9Anv8PQNlPzqRsWD3KUFG7ZQU
         4uthdMOBdOy6Nq5pLzH3bKF7kS78l1XeQ6mFIYU553SF/6Wo3ljWScSwgFfekv6WJGhw
         2ItknTzipmKQfDtF/MVKkZosy1BOUdK5ST17/+Snd8NkxJVmscU+C9WRbmEke2Vyppa2
         hA/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786568223; x=1787173023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r90klb1IoKEwH1XH9nwO0D76Cq3lPCOQOI83WPY5Wsw=;
        b=lXs79Eq/mSl4wGCxIAp/2/l7UzkoZqvKslcoKe7He3OJcIOTVaC/QKeYIi4If901vP
         fIUjKrWReUBATNhOZ4FB/yfB4hp8fRcttHHEnha05ZXTqwXapEOjVBVXyiv6vw4khqy5
         Fa1vzTpwMAKSbX7cF8fHQ19Xi1ZsEi/4RQRQOX+VFVkGAB6FGnTMCuZZVQNH6ScUr041
         uimPSwyd52iHY6ZK5nY0GC91xC72/AhKLtM6DDLAUgd7MwK3xfyPaEpi3AkK4+MWJc9A
         kkf/IXLwmxwFQ4eY0MzXsNYDWuDys5ksbtFoVgYd2b8SnLdHgiKUpApD3iTRA48sciNQ
         JeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568223; x=1787173023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r90klb1IoKEwH1XH9nwO0D76Cq3lPCOQOI83WPY5Wsw=;
        b=EJYfFl9V2Ha77xnQhWGAnWXoAxYWvgK6NMLRJ6t1wPzTJJIk39437lgI/+QEnMynXR
         R7hsMt82DkOkCO53/Eu8GTMrOo2ZLl+pQ5P3Eq5oM99BrT0BvMYieZUHxE4hw/GPi2fg
         yJcXUJmkPLvHYBi48BzHpNMywmjR5O5G3ecyHqJZZ1nDYR8k1cD9zjMWpS7DbmRIpwwu
         eSyPZEBNplxOCn4kG45JijfyHWu9cf5+JIC9SdXB436T5dBQ2+mYJv0YHHvJbQbwz3Gf
         YNIyu6Tnc7T0kh96OzI9zrZdLzKv+0qcSWtwUjOkOQraga+q8W2m7TbUcrhKpeuOLfhy
         +gvQ==
X-Gm-Message-State: AOJu0YyfCXwWhR+Iq2F8EuG812QoWjdIwIvXnxmYZazPZrssREkHnCaU
	pjEvSHbW9d4436Wpc7aB6tqce9Opn7fjf5z68+1U4WSY7+uIOgW4GK/e0D6RlP7wj9eIi7hw+4w
	wlPvYkF6493dsU+mMlFgfF/iIwgk5jc95f4ythdZ3
X-Gm-Gg: AR+sD10P9yeRNmo1fTMnM6/oDlUcBWxywnULdl07ais+tkmM3RigMRw6knRYP7Isshv
	PN/5IK1+PwmnXKtguf87w8reFZ7U/KSdzycIlSg3g/MlehVIz58hkE2CDwfHYFvjixXsOLtwejq
	dnVnTg6ymVZTTH9o7flwUAg2aBdThrVPjZfSy0FjISDyz3GPzF6cmlJNyF0j9vG8WyMReoxLKEz
	/WRpyQoyPY/Wy2DxXqOcVyr5wCHoapH+WA8XrmAUL/dcvtsSsHJW7hQYcfv84Eqq1YAucM4BX+w
	02ZTF+dnLgJwsHMUXonhd2lPAX3iNJrlQcv6mKlp/LQ=
X-Received: by 2002:a05:600c:3586:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499821f5d09mr4364355e9.13.1786568222642; Wed, 12 Aug 2026
 13:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
 <20260619115905.051eb340@kernel.org> <CADWJPTus-1pXZZeYfGqJ1=OR_RPZ5Wq=H2tc1S0_tGi1fGFNEQ@mail.gmail.com>
 <20260804071657.03263c97@kernel.org>
In-Reply-To: <20260804071657.03263c97@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Wed, 12 Aug 2026 13:56:51 -0700
X-Gm-Features: AUfX_mzbhKfV2aOV6sFzH-oIK9qDCNNMp5HH6q-Mv88U3SnnqzVnsHjTK_Iaa28
Message-ID: <CADWJPTu9=k5y5WmEfdFiemhg+sRA0ZW5e5J_W_Wazrt+JKpMyg@mail.gmail.com>
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

On Tue, Aug 4, 2026 at 7:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 16 Jul 2026 16:15:35 -0700 Sheena Mohan wrote:
> > Thank you Jakub. Just wanted to share that we are working on exposing
> > devlink info for both GVE and IDPF drivers.
>
> Hm, but please don't expose kernel version as running.
> It will spam the aggregations which compare "platform changes"
> with a different version every week for no real reason.
>
> We know exactly which kernel was run for each test,
> so it's also useless info.
Thanks Jakub.  Device information for both GVE and IDPF is updated.
Following your suggestion, we removed the kernel version from the reported =
info.
