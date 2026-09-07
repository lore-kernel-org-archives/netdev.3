Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A53DB62F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747610; cv=pass; b=Qe3r9zHVnIwQxv9rzpDsJRQxVj90SWaiyBpRpJ293k1yFuzWG0360R9/9QndNyjD8DHVoj5T7xB+X0MqM2JJZQywq5hZMRiswdjQWQ+5fUzU7yqIPzZLITfv1OLD2/nDdFjQjPNiAJL1C6N+/6sBhsh7/+ViAEjx8Vg+hpXOtVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747610; c=relaxed/simple;
	bh=yjZIwk2F/FS+WxKDAZj/VzO4DcfE/wopEMvNXvjZ3KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=al1pzRWysZBNeUM0DdBFiyIqg1H1Rw2U3N5CE6si/iZN6smQWnHw4tgS+5Mw/t923zjvKKxT3qqhmzR2nQLav4nFaFebGuoeMaxIxEHePX8HJ31B+0yaalyusD8cnDLeTbE9uUUVonONXvI7KnkUtyEfJkNbXXzXgrc9RjAuhYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwc9eEyI; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwc9eEyI"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485b358552so2614555b3a.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 19:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788747608; cv=none;
        d=google.com; s=arc-20260327;
        b=EYI+823HLGBvsj9J65I9skTDC43uCpijvQPfVBXjrilMU2KHkGqQGKW5605Ybk7Hlt
         dA0fpA1vy1ycjfzOiRwLGLM3mw7RWz5Or4Kbyp/jIPpXK7nP72lFURlzyYQa9fcREZDz
         4pOQHRmepnvZOlY5X8h8lDmMN1LFc7sNHF+I/oiTjuofX/wu7Y3GJk95fjrtYvaywSsh
         yRcUgo1ZYpqN9iGlwrpeJDoI45LZAFdaAVPzQ/5iOqS9crMxWe61GW6Xw/Wk/9/4J/7h
         VVrk8ygajkAc1Z2UYhH7C7BoL9q4XnWNXUZD9hpU8yyNgPpRjrtG3A3UffMxGs9OSOKt
         mLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yjZIwk2F/FS+WxKDAZj/VzO4DcfE/wopEMvNXvjZ3KI=;
        fh=cm3HTe7DuZH7q5WpCqUjZW2NhP6Hhr6LBbIaCtuOFuo=;
        b=KnDv4kGq38Vy6xPn1uEqljkpLuCTA/6fRECsEYNwShIsMPjTZCm621zbN6Jo6KqThn
         9+e+y52Ip5zJkCVgF9WakwlsuS30arNs76KvBYF6Ruj4v0rMj5ez/+mE8w+PLMuPY+i3
         xTs0D6U2ipw4FVSAm4nvtvShsGCEAOxUvPALiCbEwVhvB047R1msSBygWs8u4m7n8aq8
         wjamwNpPPrNWVL0eTCCMgEA/5MqoDPApvyQYgpmegS3awuH6WI+0VFBjScyFuW86mk+E
         zb/NxLwWlPdhdrpK9/3ssWTHEMyXg7nc8m0QlCwftTP4fjyq8cPysXa6Ky/aPc8jBCHO
         My/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788747608; x=1789352408; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yjZIwk2F/FS+WxKDAZj/VzO4DcfE/wopEMvNXvjZ3KI=;
        b=dwc9eEyI2D3sRwDz1DbghK9iJkDXxoI7VEqWBhwLHBg466tnpEsu+QHn5up5UmmOYk
         98BZgTPahQzu0oklg9uIPpU/Jcnn22fnjX9UbgAiewHKBrXu4exwEr+37kz3HOL81KTj
         LukWkGntxlFPPBTE+QmHkrmDOtYEbSejo7urSBYstIPEh1KTaBgjqynqZIqdI4WXJCKu
         W7eRo9QbBWuShiNXSr9nkKVwRcyUZpStmYtpfeVtFaEUIqRg6Q/ggXpPOjkqpgjGNKKa
         b/aQ54MoUOaRRPwBtvf+3ZEDsrBmPpeNxDNHCm/uNDqJDr6Fv/cJbBNzkcS2Xc0blqoQ
         ohtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788747608; x=1789352408;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yjZIwk2F/FS+WxKDAZj/VzO4DcfE/wopEMvNXvjZ3KI=;
        b=Ac2qHz63qpd8qjaIAsy9Gy+mQHjd3k7hzyE8sqBYEJ0CBmI8/mVd15D+7HTaQYs39E
         AvkYAUuae77G9kqgrZuJ9U8mkFxFKYOJBEj0FBJlfQi3f0mRHclGBqCcSzkq1iXEJFYA
         Aoh1lFg3Jgw6rcqDDaVzdG9XDe0tBPUu2KAzbHvh6pxSR0duRl47gyTzSFQLVOktGdUS
         eIJ4ebIpIdDfU6YF9Mwl9R5rVTUf9JlCgByBAKHPhpSZ8a6Q2ZwZOB8f/uLQnEQakg+p
         /Aa8lC+ThgbnylLaXo59oenvcXkf0taU7XeLY8itZ3oEEpA/qm1MWg4kK2y2qJw50FLC
         gi5A==
X-Forwarded-Encrypted: i=1; AKwUvBzCsM9nUTyK6xV6lovF9L5hzCc/sRLGDL3lsuKxZ3G8NxJWyKtGCqVuyQS941aYsJsydzX2wRE=@vger.kernel.org
X-Gm-Message-State: AFuF++m8PhGf37bC1wIWiGfaHq5bf0O4tq9IPzWk7NwSq3KxdQRJwGdi
	ZeGHmwZUjnK8tPNflNgqkjqh6si+5YwrtuFN4Yc/BHubspTw8FKn7/SNq4t8SV579JEM6OEfnsx
	7/pTL1RBf6r9nMj14Pixr/KQHEBOBJXw=
X-Gm-Gg: AYBFou1tLdaOZ60sVbTIM2gT0zzaTOBUL6zz8Ggd/DRGdVXrgCBNn7LJaJTxRikDAaW
	GziDqt6r1y5eflEIw0YDGJs0RuOHSbrlFz1LeqnUvJ3Lk0EY1WsC4phvfApuvnd4CLoEmq7uZxb
	9R97tg5pLEZ9XCkYmO7IYbbdxQ3oRw0VWAWnje22sDiKTLlYtk2QK6xoG8ZY0agD2emofvYPaNz
	bSqUPCFYbtWAUcP5Tyn8UTUk7FujzdwrVCMYYTOYuO9FkTWFGTikbnEx+Eo27Z+1wcJvQXs6CUd
	Vt9/0lmOBPlRMnAJcyxC9hGJVKuVd7/58bVasd+Che0hMtUalNCRMwJTlDO9q5fTz7x1G9ql4eT
	mFtuw9x6TxWmBBo514jFXvMbdtIz19dAE1ZYP8y0rv2gWhDCs9s8wXg2M
X-Received: by 2002:a05:6a20:914f:b0:3b4:7e2d:a3c2 with SMTP id
 adf61e73a8af0-3da3a03e965mr30021035637.18.1788747608151; Sun, 06 Sep 2026
 19:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com>
 <GV2PR04MB1173931CA07AEAB48339FF71588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFi06-7=uHmOBFGZv1eUYCskv8WspOdUxbDuQ6vMk68Dg@mail.gmail.com> <d12608a5-468a-44ca-9442-07f2eee4e335@lunn.ch>
In-Reply-To: <d12608a5-468a-44ca-9442-07f2eee4e335@lunn.ch>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 7 Sep 2026 09:19:56 +0700
X-Gm-Features: AcwNN1UlYoV4Zt-Ge1izy88cCImOs4q6AUtidKnj8n02ugjYmxdqp8X_pG3V4ag
Message-ID: <CAABR9nHuSC3jkfuvN0hUU2spfeDfSRDmkVqsvWdwHyyQOsZe1A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, 
	Stephen Boyd <swboyd@chromium.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thank you for your feedback.

> > Second, the current implementation can silently ignore -EPROBE_DEFER and
> > continue probing instead of deferring.
>
> This is a stronger reason. You should mention it in the commit message
> as part of your justification for net, rather than net-next.
>

I will add this point to the commit message.

Best regards,
Phuc
