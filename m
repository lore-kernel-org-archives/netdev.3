Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11C31E85B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243750; cv=pass; b=sGylw0jkTIkDeRSNIOy+lLxXV3dYuesXoUPyjRcor/+fXDsuz8u0aRuSgc8H4KcG+GkLXrzV+hWYGJASC4kJkubFqsZ77DmGBuNsZjLTPOXXEIPcw96/UWtTpFhDMOnp+qrvdQR9gS1JZh7S8DZsELB7cH9lgFG7rgN4a4S1B/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243750; c=relaxed/simple;
	bh=SkzAWydI5aCKtJpc9Pi5LIWXBjOnu4Lb8GnREo4uq0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQJc+90ibSjHDQBd3kd9aI73dmn8nA7UM2Fe1qpEm/BVltS3yleuRDSFvihAFrB3vvwxHu9pT8PO6+gAoJ6S+WU7J1W2GsjPWlup4a7RwKtRMyLx9VV2K0VP+Rz4qwt/+yO5gWjD3pho7r8CkzPyqPYfBQXOvmgTe8g+JJdA+D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWxE7Sy0; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWxE7Sy0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so3001344f8f.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 16:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784243747; cv=none;
        d=google.com; s=arc-20260327;
        b=hmzKwWhhpOxWIPi/+K5TAEaLLP+1+P3AuVIu2ChVr3g7zr3XXr3FmPK48CxNgnNaEJ
         DjvQG3N04VyK0dE+Zi9bBVSsUfC0xE9bHFQKjc8wQ1/JXlFWDE7gYZjPU2a0+xBmeTlu
         Sdz5BlA9Bo5gCFCnR8MlyW9YXphPKSHLCo2DebBcmIDKaZaLhVwKHXpyxwi2ewdgUzcL
         60IMLbeLS/x0fw1onJq2UbnUJVlQgDbxmm8PwPMQfX4iGVWJaQdNFaRLjdkVJAWthKjT
         UK5b/nhBMcCbIuCjymwFnC2564lVF9qIAyg0cyaPyAKUrjefnjGaguLe3jdjmmtu63/y
         wTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkzAWydI5aCKtJpc9Pi5LIWXBjOnu4Lb8GnREo4uq0M=;
        fh=QRXTu9w39zctloY2KNXjhGamOLCxG/s5uV+JlYp4ZOA=;
        b=IV4oTgx6jHc9zbGN2QljM43PV0jz9jzILdSdY5Z5c75l0/EO978FoxdAnxs5P7/LI1
         B+3us4Js5A2vT3RDL1+INianb+noXnH/3wg05RS/koeOixAUFh+1tgleVfsbyFngD7dL
         T7Tyyx9Xz7cO4fa23CQc6IflTtpb7v8IYaCwKJcmj8eHz/5MY6JMY4mgRBxD++Fsh8FI
         obx6rDsRlTicZYGGOKomb8uQ9O/kpbzPuwshkpcKRff/xMzm4G4LdA4aDYW+b7Fva3UO
         5nLF3W2BESKzym5G51TzPnXRZWRM54mUtRMLsVaTKO1PmWnfteXxNZgowo/2cz+y+Cou
         JRvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784243747; x=1784848547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SkzAWydI5aCKtJpc9Pi5LIWXBjOnu4Lb8GnREo4uq0M=;
        b=jWxE7Sy04aobBCoJWqPph2oFRaRnPQcEfUMaqZjuwka78w2xr5oqy3G+StfRru0Apu
         FuwCSDIhuswjIBpms6bnFGnCd8vG2V6QgDNPOCHq9PC2KILlO+rUC8JtDmJ88lqyj6jX
         sWGCOmGnk0SIsgjtT8nOCFlh8LG9zIAGNYv8u2IhgpQiTfNS3QSGEnjzyoZyYKmL+9Pw
         3dxI4C0/63H6xmSGazheKmrP5irvGrjIjbw6Ie6jQHJV48t/LEhg83V8cFOo/gvMb5Qo
         vSYGKcWDd0k4MfCcN9ppDrU/uiV+wud6WrbirnIQZKYC8z90aFdRcmSaZ3UWt5GNREEk
         088A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784243747; x=1784848547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SkzAWydI5aCKtJpc9Pi5LIWXBjOnu4Lb8GnREo4uq0M=;
        b=iyFkieOY63gMkwg1nt9yR1ORwc59ukYRaoYWuHcORB/O5clSZUmffx+uQg9QxDIeBs
         GAlyQWIRiTwxo/8o6kNmzybA801uUCGny3Er7ZiF0x6KblYEHrGcvMoNxnMTZBawUk0n
         cDrqmA0HD5PcgUIOPZeD2diAsMKie+LQoKebM4zT560an0ChUOKFw6ZQSci7z/WG4YfN
         RmvVtSgG4G5TKccA5ti713EsGMN8VlWr1x/iGtLfCfkW9dt8KKjDS4hK9ESMR3ck4UAY
         dxDxbv/3eicRxL5Hq/bb70YxTlPdc9G/0OSDRNOp4dR6PjqVlytv09DFQNDsQPWElTv5
         yDvg==
X-Gm-Message-State: AOJu0YxrhBJK8HNIha6FEKxR+oebTU3WYOLXow98CSiO2H7hZZUTsbd6
	g74+ChGLWfBRTer+988k54HDP3gpFd9PpOWgvqNcJn89Wf6/7UN8NNEkEwCE8BVqpeLZlUOBghD
	EWoXFsuYGrSpZ/hEV8zO7/c5zlyUfs5yK6SqfCz74
X-Gm-Gg: AfdE7cnEvwj9MFs1uWGYOr5X4h+p+3egG+PLAypEN3Tlc/SfhuWvbSjrbAIau4OIYYI
	OT+yIVtoBTn9saB4uryZY3/VR7y79gvfBvRJqOrviQMzNqj0lwepmxlTqjkeDBiEt7OJoBl6Y85
	i9xtGOyfa5p6UJTLCkky1RhBVG/cguQsv1YPWgV02SYr+XF8bvp8pe7MmC21pk06II+wOMtNVbk
	mzNc4ngBROLfhCJuCQIBAFyptujVnkPLh7/Mm8eh3RF+ZeN8JRY/td5RtKG
X-Received: by 2002:a05:6000:707:b0:47f:5527:3710 with SMTP id
 ffacd0b85a97d-47f62305754mr262156f8f.12.1784243746685; Thu, 16 Jul 2026
 16:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
 <20260619115905.051eb340@kernel.org>
In-Reply-To: <20260619115905.051eb340@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Thu, 16 Jul 2026 16:15:35 -0700
X-Gm-Features: AUfX_mxXdJa3k62fgDM7ZXhyPOl6ooz9sOMUQVjaw_bR824VdY0S04hIYMY1oy4
Message-ID: <CADWJPTus-1pXZZeYfGqJ1=OR_RPZ5Wq=H2tc1S0_tGi1fGFNEQ@mail.gmail.com>
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

Thank you Jakub. Just wanted to share that we are working on exposing
devlink info for both GVE and IDPF drivers.


On Fri, Jun 19, 2026 at 11:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 29 May 2026 13:44:48 -0700 Sheena Mohan wrote:
> > Hi everyone,
> >
> > We are happy to share that Netdev-CI testing on both IDPF (running on
> > Google Bare Metal) and GVE (running on Google Virtual Machines) is now
> > up and running.
> > This NIPA integration work enables executing kselftests against the
> > current proposed net-next kernel branch on real hardware.
> >
> > Thanks to Danny, Max, and Pin-yen for their contributions!
> >
> > The test results and logs are available in:
> >
> > IDPF Results: https://idpf-netdev-nipa.static.usercontent.goog/json/res=
ults.json
> > GVE Results: https://gve-netdev-nipa.static.usercontent.goog/json/resul=
ts.json
>
> Hi Sheena!
>
> The Google runners do not report device info. The results should
> contain a "device" object that identifies external components that
> may cause regressions (like device FW version), see:
> https://github.com/linux-netdev/nipa/wiki/Netdev-CI-system/#device-inform=
ation
> In practice the main use we currently have for it is to auto-categorize
> the results as executing on a real driver rather than netdevsim.
