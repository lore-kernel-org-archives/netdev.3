Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654FE3A3E73
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200485; cv=pass; b=YXnlXj66KdVQj66EneUgi7KGiVT3oPSQ31Y5qvx9yYUwudcMbdfFrmprBnqmt+oK5tQnJVBgA+5GJ0WrzHzNkG2wEdjbhEGarwFev+nQHj1G/qTaDplW7F1PNGbmtX5vRn6SavnWsIiy9KtofXrUlp0cGGdx8wYeq37OvitTkBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200485; c=relaxed/simple;
	bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GikoCp+pdjfluvEgD7rXfBXdOy4ELbrzF4hXmho+wYFRofkcPjyLbSrS3vjfOFlF7U5LMQmAtXGTFYr4j1kCys7gAPGyqbrnAqHgGGYOoeARbKCQLdXzAarOHl6V6Vszvwf6CyrgEEqHTSUXB7foRdn4MENPv6KqxioiQ1xYbDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKKnN9vM; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKKnN9vM"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so1171463c88.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200483; cv=none;
        d=google.com; s=arc-20260327;
        b=RY85zkOzsLbA1upHpe9KDv/lr5UGbqoPF8tguPt1i6MHIC+fwEl/Y0h3TAMQYtVAmM
         9CQTOmX2o/rrMykpqUc0TI/WWEyklYK061Ewfq8DzgaczfYnVMjlronGXbBOuHIqlK93
         1kCtqYvNl/zetO2koE79SYnC7usK4KFqNAroUFEmvg3jJD6BgxgxbgqKqQhYgc2ymdKE
         pErGcYOUou18JoH28A3/0yMp+2cBWhENkJkOd58AC9hkMwxborX3ZtyyI3Rco07axcf2
         l6GnAWQEhl53uUVNgbP1sFW6Np+JZ7YzKDIrz46NHG5VW502mK69XeluwOd2SBY1nsrQ
         F4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        fh=woP9TSInHgHHW76i7Qu5jlPMcUitaogsRzrDlvxuXw8=;
        b=mk8CwxRNECsciD+Rhh9QKODSyWLsLaCYNx/xhUeDefuUR0B06u650OJgj5iv4Xuld1
         ZR1GPri2lXQrxhTmGoxRw1qjNRovHG523b0JQNKU+GZ8GjEY6SXjYr8B4tLyUub1En4m
         8C73m7mwEHAng9tGVr+vkQt9l+/Xi2l5GwDoQkT90WdpJ5fZIFJs0l9yrH+LbCZMR1V2
         GIv+trDmjlNeC/hkci9Q5uAvc+w3TWaI7CPTrhrj92P7Ja4nQz3xGm4yyXjF9jfBJsBy
         sZm+q4WYNYlwpcrNw+hGcDhGOjwp7MolIbrpZXsWwrsnp0COaD/gshippbRjXVY+2eE2
         8ioQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200483; x=1790805283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=nKKnN9vMvCPlzPy5Pd230leYXb99CXXlwQ9tO1zT8q39QNlDweBPe1mBzj6pYK5S+c
         ZMGdiY+D29WYLxpvEnxGWXPAxD+AdrEn+z2ZCDyYj3XYKcFHDOwwfQGBwaulhB3HGIGZ
         oGYCHzOVceKbIkDiNaAhdRWMdx89b80+26b2SuWh2mO8UO+jXlDMB2Iw4BtooRm37Xjp
         TolQVKXI9F6koV0hz1za+ze3PUduQ8S6jzpHaEBhswVfrLgu/SDFPmF6A+LSj0kpOD4p
         YrAGP/lk+iTQgya6x1fV81squXQXtA+66ONWZA/Unh4Tf2RIBjc+d0YrZdBAaMNUzj/J
         iRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200483; x=1790805283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=ryFBqnJAGbeQzCqU/re6BFvy74SAGoHy6lWOTrpUmqO2W3d2aV6yb4t/9T6taVjGs5
         5PcXhywrQ/k/+hMzKMONvpNGkb2Hbn48XXAvWFJgvgrbv3EN9AOK2lpUODoAy9TTexyE
         SbuS/fu3S0Ncf25CUI8mS+A+iFhbBHVjwcuTXTgkiEIru0+Zp+F4ra8IQy163tmc0wOf
         ztwGM0OW719sTRI0MPOT3LuH5l8Ljy/pVKYzz5UNwu+TuoUvYEJ67/9arviYz9ihK5dv
         t5UIUYs3u0tpinmyc9N+xpNV7sn50TNLYgeH7KlSo9UlyMz4Zhm6Iu9LMzoMPBS0p5UP
         ZkMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJLCWINzVFj1FKRk06rS66D+iUjw5anLS150mY6/+mQfqsu10xirp+ml2YJwP06Gd+3AcTFYo=@vger.kernel.org
X-Gm-Message-State: AFuF++lpmAOiUV4SuAFZR+20grTgz48KQOy96wzEed01XNhQw5NnP9+0
	1LBQZSIp4KybuKeKeD+Ht6vEjX5IfEyGLWTRYOyiTG2zm9VOQ13dTklqzPCEHxw8lcQhy2ooK5t
	e8mm5um5nvCie9qtPRFpbSDde99swq2EhDlIvNHCXYNkXnievI0pJ4Mvi4uE=
X-Gm-Gg: AYBFou27oEpQ/ziGaRuXIMYnFHJbgPwOg46H/vkx7NpXOoUx3BdMgkCe9vsJskEwUNI
	97gkpyB3tOpqQ13vWoBwIwWDzGF64piB8bb9SSR0fr9viRBetiJgudVIQAVl0ftj3EmrKFrTWsy
	tV5GwsFjX1Zn8oieY0fRz/fa7/QN0qPbRSYzm4FPYCprLFSfsVBLmrROJAgcrAud0HxS9J68TXP
	HxSNPvO3+1ran9T5M9XPdi2C49TeBWEU6T2Xb/eyRbtu2kadUsF/+QCl41tiPFiQXfm2YgjQE7R
	GKiGNCpTd5qHRA6lMlNwOtPqj8Vy74/d5d3LUSvpcR/3USwGhvBoo92L0D9J38Xed0y4scNKZ9Z
	VGpOHgrmSIdNckqfXNiN3y0CjTKVRzvOhltgnGFDTrvMk7lO2eVHCNsTnkmndMgrZl/bca4sCoQ
	Fw1T3dZvUg5YahVNR/XFmtIOuoLLn6xigq
X-Received: by 2002:a05:701b:4212:20b0:144:fb42:3e with SMTP id
 a92af1059eb24-1450409409emr313738c88.25.1790200482656; Wed, 23 Sep 2026
 14:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-4-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:54:31 -0700
X-Gm-Features: AclHuK-L97ZWztvsj1LocOI3mHgEB8A88tDXh0gK4bgFGmO9Miw7FrBLCdA3kYI
Message-ID: <CAAVpQUCjZp6bgUeni4v4HKP0Md4vNHM0y8WESxgjjKnMy7Sb7g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/9] sunrpc: use sk_set_nospace() and sk_clear_nospace()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use the new helpers instead of open coding the SOCK_NOSPACE
> manipulation, so that TCP can later maintain a cheaper private
> copy of this bit.
>
> No functional change intended.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
