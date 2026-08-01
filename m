Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32836215D
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785547481; cv=pass; b=kPlRmSoMwervzK1rwdB3zkW4fcnx8iJUrvMaF7s/GGhYtV6CGRWN3puqecMigMs6g1hnSnPBdRl8jPvjBFXzmfsjvz2wdBjuEieXHbc7/IJ9o34x+B9ouJHVzVwsV9l2mb6J8Q5Bw2Rlzy5k7PLXvPxk6TxapNG2EpKfUAb7Mkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785547481; c=relaxed/simple;
	bh=+1GhZ+xe6kF0851bfcXUhheFoGYJWmbd5WSkoS1Lgxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6NQOTPcQ8NZkp9mhe446dygWH+0WaLYhFbfWLJ9F9ACuHl9LQcIkf41gK2PIvEhm0ocsaX2S6o1B8FxUv3s5duEFTFxEUGATnXzymba6PnQ9g6sU81Yj+hB5RweF6TsH3/DGkbQTrdkSKKuHrupIAWgKnPQbSXmDRIGOkJ7xI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSXFZkBg; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSXFZkBg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1956646b3a.3
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 18:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785547479; cv=none;
        d=google.com; s=arc-20260327;
        b=o/v8r2WBYfsSZAbNuKhOILZ84TueOGKcXChoNxireZoq3U36D0Cr/NoA3EDQqpR7fA
         Pn4klTQJ7nV2xQt4GxbUtEQl6C+BS0WUffBqF5wED442z7GQ6QkijOZqPbmgX0DdYpdJ
         tc9bzbF9joJVgTkt4xI305emqCx2hRrGj10H67YjMFG8St9vPGzGHTRs2pbNufH6lqDG
         WbzVw8Uma7FoJGTy/SCRjf1YWyJKHW1ul2B9/UhY7EjtVBvfyeT2Dnofu4mq9v9eWwBy
         FfYFrZ2jM5GPfOQMn05YI3UTQRV6Mh5ZRImBx0//FE+ymQelPN1UxFdLJbYbcFsO3a14
         Ffdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+1GhZ+xe6kF0851bfcXUhheFoGYJWmbd5WSkoS1Lgxg=;
        fh=3pqAOMxj8/y2A4+A7boEVH7oZlyHmzl+i4Y/YemA2SU=;
        b=kumL1WpGbz33EwuCK5d4fxzhcrBHc9ufKo94wnKOyQYZRp2lopp0zQu/6R3UTxDXzi
         8QHXh4b74r2JM2UNizoCPV3uNpdM2PjKTBBXQppwQx0QCWs3FOS1LQJpzh3FZgI87X7C
         vg7nmIWs7JkwpdtI2jjkNWH2mG5eMvr2UblYHpt9WWCSBo4MOqJovEFODF1vcyKC97Yo
         V2h1TDbgquSOqoOe+Rsb1qfPG0+V8q7fWdGgup4PLJf0yIsgVYsKWQAu2J1A7Tj+lYmW
         AzQMeMNffosvvtVCTacNrw4wI+PB4KLzly7MTSVKOre/WlN5KC8FoktyatPowBq7tuOv
         CK1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785547479; x=1786152279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+1GhZ+xe6kF0851bfcXUhheFoGYJWmbd5WSkoS1Lgxg=;
        b=dSXFZkBgONQDTJ+aHDinZALNGrhc86NHC3WlNc/EW4EejoYdo0A+ZFTB8a/Go9Ql05
         LdfjTXTyO/rEhVI7uESIBFDtuUq70aKnxutLxWkumGTNR1J8KEqSqj2y/dSS8bDv9SW7
         WkZn/lsFrxwnv6okAbCIl8h8q7dJHQW5/yt1lNjY2Eq+driyYFvAhc4fCOX48y4Is2p1
         WE0Rca2f3ub/QNHA8EdSGmD12FMY05zVU075NpaNp2KxwP1uhCe5+aU3gzlg5ZntbiW5
         WIlD29eMFUUIE7/2pYnudgROtXhVjaIdd03HmaW+KuAZ4XApEkM1YO5EM/to4QGP/+rP
         yh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785547479; x=1786152279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1GhZ+xe6kF0851bfcXUhheFoGYJWmbd5WSkoS1Lgxg=;
        b=D0qLKC7WdLSl/wXradfNfbc/8j3DodQr29HjPJ/f4UyWyeTmTUauSe/onaTGpu1fxz
         sRQkki0b1I2QUI/PpKSJAU3NvUoAcGw4g9tS+v3Cga2tpMwxgSVmc5mlCeinpU8YNj+x
         hTBGuRdgZ3e+brJ93oZkTDBMEP68GMScMLpxBfT435lqeFuadQAlHSGxqFy6Uo52/QpT
         lZxwitn7jAeQyOdSJf3f0I3tN4PMpJbAfUPsqsK2w9RuoRQSB8U5D8OvfA+gJphwQRK5
         3crh1bYDxg2u2p3HJcXNf5XeNydX8J9p+X5Ltb+OpJGGLTk7wOYN0JlSA10xTO192gDp
         8NPA==
X-Forwarded-Encrypted: i=1; AHgh+Rpd60h4hFH2F+K1xZWAxX5ySxQ7iS9tJRMtbQ76nzmLXKaHnh73fyB3cD9+eha7Nvi2KsVTZMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYIWfFiPRV7nTEzziJCdOQB4AH1WQZ9arjT/3gkrq6uSR0RsK
	ElsQjRoZ7CaGCm6ajV3KfJVETxdjqPGoTzuDzA7MjiLOmCm+si1tWb6STD4BUBNRRi1JCLt9dNA
	cz1jxnOH+NWvmP1fCVvKcWdSYKM0m0e4=
X-Gm-Gg: AR+sD13bV64q7WpKHBXH7fZk0zX+N2Dp0gi3XGrkW3GV+ieZL/hmJg24xWUaprljSwY
	LaCbkgGR2rOy+hzCzTj7xolhU9fSPj98X4EF5/LzwW/oj8dB8c29fM9IMX1ETOsATzzZddO93Ai
	Pb6IgpVOuRjwcQRWRuBQEOITo27Qs7L4vls1DtuPWn2H0sX6P9AZpue2EqqLCulW0Xyoz33JwbE
	JAxG0eb6Uof/ZtHPCG/z0/cgTNOk+glcSTcMGn8gdNlLeq3bHieXm0arChY7JQqdMnZLbei95I0
	ktT91+3IALSJCL+Ax1/y7YcvKLGrBP4JAXlYWJmbe/kBOYwsjwLn0IGLXvWSycrJWGPxhFhXEN/
	fNMEmD43hqzWyzMB18LX0EsUCxiJJGmLkMb6S3zvCjPIE
X-Received: by 2002:a05:6a00:2301:b0:84a:2e5f:d697 with SMTP id
 d2e1a72fcca58-84ee480218bmr1414400b3a.33.1785547479057; Fri, 31 Jul 2026
 18:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731120558.558957-1-david.lee@trailofbits.com>
In-Reply-To: <20260731120558.558957-1-david.lee@trailofbits.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 31 Jul 2026 21:24:27 -0400
X-Gm-Features: AUfX_mzpegywlV7QV3WPhDcRumAMkglk9BRzHj3-GDSqPu27ALqbeoWb7nBQuLg
Message-ID: <CADvbK_dWeqUFR6XqC-BqjjwsWJpNjEeER-fJ2SVYKhUObkMm1A@mail.gmail.com>
Subject: Re: [PATCH] sctp: hold shkey across socket migration
To: David Lee <david.lee@trailofbits.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 8:06=E2=80=AFAM David Lee <david.lee@trailofbits.co=
m> wrote:
>
> sctp_sock_migrate() transfers queued DATA skbs from the old socket to
> the new one. skb_orphan() invokes sctp_wfree() during that transfer and
> drops the skb-owned shared-key reference.
>
> If userspace has removed that key from the association, this can be the
> final reference. The following sctp_set_owner_w() then dereferences the
> freed chunk->shkey while trying to take the new owner reference.
>
> Take a temporary shared-key reference before orphaning the skb and
> release it after the new owner has taken its reference. This preserves
> the selected authentication key throughout the ownership transfer.
>
> Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
>
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

The "Fixes: " is not together with others at the end, and the "Signed-off-b=
y:"
for yourself is also missed:

Signed-off-by: David Lee <david.lee@trailofbits.com>

Patch looks good to me:

Acked-by: Xin Long <lucien.xin@gmail.com>

Not sure if you need to repost for fixing the tags, let's see.

Thanks.
