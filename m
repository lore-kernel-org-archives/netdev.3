Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB5388394
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678806; cv=pass; b=NGE0ik2DRhGYq3NUDxfmEs3tUIu1i4liW+hcb2nZ6UDyHjVuFeuz39eOp+kiP+KmZl1QTBj9hqws8Av3PwVVSDDdsEbWBiOjn3SjWhK7HzrrwfzLk7bZjSaDWs8YgBZW2p2AKaHWFqjwx/Q2+NPBACNK1wJDPc5GFp8lk9T1nmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678806; c=relaxed/simple;
	bh=vHNfCGUdUcyqkwNR2iQ9FmrmlFh0vtUgL7Dub2BXaGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuG9rKPC/uTBQXgKmF4FFwDV/xH88VkQaPE3260SNB6AFCddNXIymPzIQuVv4rfMYW/7a7yr2hJMDCvTe4sYhQplHsSNqGjCApT/dat7R54PdqEecbRiw34ZBunTGBDprQqR/kHyPSYVV1atS+lglvMDAu3U1sijpvyr4COK1QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4+gLwbj; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4+gLwbj"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15fc4707f5so48377766b.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787678800; cv=none;
        d=google.com; s=arc-20260327;
        b=qZSDi1xPsFIiHavAfA0JdWKcrrvdjQXNWieBJdg3lqme0MvO2vuqCpQf8MYrdFvrJO
         A1Fni4R3Og52GXhXLQcO2+rxWdlo3SdahQ7TInLo+ACyMKkAXxiUYif66oahLuA/G76E
         F8OisUKAjQ1QhU4AgKr88jvnoWUqgwYjIPmQUJpiPxlp1vOJM0BHAUHZBmRgUxsqWekg
         jJ0yRoFCcS/+VNGmndPkNcDkNvVr/wRR8jHzNu+eVCbqe3M/MlwU5ApsAATOwDw+rF4g
         tfrFAf/mwL8Pt5gaX2JYzCjRMd86V/fH7behbmaFyKVDe8XMONf3DMcPR4DWD/RWtCD0
         I9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vHNfCGUdUcyqkwNR2iQ9FmrmlFh0vtUgL7Dub2BXaGQ=;
        fh=skE7ppJdzWOcdhXiW0k16/OSFBzGWf/+M9UUt51dvMw=;
        b=bnpwK4hK6vG1btsfbNDw/6nn/8pm2Vf6QjpMqjs57f4OD0EIxnbcBCaoZLgTMAb8UH
         Dukn1X5EKxz1DT7gH8yzQ6ZhIy6s3fCYavs3DpSaJe4sLJqKaIRckVvhocqXHgjht54r
         luOL8SFuLkBrTalXM/e23zNJn3pNV0kIrQ0uu57pzLeE4nV9Kym6+RNNFYOY42QKqske
         l2ya2f5TN0HRN3zocZH6XsivWWY6A5XWkY62SDHphkCqZaRUtBnKukamATX1wYlvHHKT
         OUqPKrglWp+fbfpO+jir6+emliTk9krAfw2f5e61/t9sCsS1YiRVA4KqljQw7tBpQgj8
         S8Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678800; x=1788283600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vHNfCGUdUcyqkwNR2iQ9FmrmlFh0vtUgL7Dub2BXaGQ=;
        b=K4+gLwbjW0ImmB6DjYmtOupAgWhv/XM/jMfbWOdckVR/WGRhdvaXVTCMn+f06RoEDj
         TdJhaKCNGdK7vvmfVbF2DsECYA5+hZ9Ede4DOdWcPhz3shXE/r2cSGP62AD2qwdkhVsx
         yqYn6Nd3LHRBpM1V4SU3mjGQKMI63EmVdj3KPiyxP2BR/ev2d3aHKMTgDIGRVBqEbBss
         ao+aFvoUz0lk3dEpI1wgCSLKC+C00zzJv4m2pK0l+EPVDU+nkWsxmgn+DFt2BV1RodrL
         A7cxwZ3+UqY3wFs+Mg7yNBer73KuQ8VfI7+oXc9d5XUihsQxTh+z6nPOy62fiWfc5t+k
         dLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678800; x=1788283600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHNfCGUdUcyqkwNR2iQ9FmrmlFh0vtUgL7Dub2BXaGQ=;
        b=b3JhBrG0XzazjJu8tWneRpJ1uMPCNOApdj/IbqyrfWwxoqIsg5sLhkjEgu4ZU4zEiC
         EJ6ispBegB3lK97kULTlcS9x0mFOtTcXpqTSyUI1GVL7kOLL582awqgUQSjulDPFUG4O
         Ih2Kbi5lLCsJ1eHr4IGbn+hj+VyIoka+42+esdqYl6qVzZ9FXzy0DhZsRW1OGQGQi3Y/
         u3MX2BDs9Im0VH4TS8C5NZuFjVlBospELiVpAvyNSIzpMTv+U5Z6uqDtMJNFsiUiSAh7
         9XXTQsemadPdua4mS8tB5I1tzLXSi9JFY0lTwAGQdZYFdYVj9vmtH6picVGt/LQXEz+/
         ZfVg==
X-Forwarded-Encrypted: i=1; AHgh+RoqUFZ3F8oz2Mn1Vj7JispQQlwQXWYaUWgGD3cYPI2yCaRaMCR617waOs4Z2i6ZPaECKK89oEY=@vger.kernel.org
X-Gm-Message-State: AFuF++lXb4SzJYXz/zvyt3XJnynawLpxe1mhkvyBw8N2hQ10EsKjEs3c
	TYkk11Txlehmfezzt59Zg4uc57YXG7Cyn5YPwkupPIzJ941Qw6YPMgsW9+rU73okLMrmcnOomDM
	vioROda2ewrOd4hkLP99lpaoOO2cCeZc=
X-Gm-Gg: AR+sD10TFU6CZn770ulECt+rcXnP0UyTphx65ywVJOQXryE8UdbKWEOZ8yqLdmwiqAL
	EbWKxwARcwcns7jNmdbwQf4RXlesH9r2z6UV7HwnFpWxXRjxU+2BgZvWjuUsEYXZWebSzbm/hdL
	3LpeQmTOPGLuk9ULlF4rW5Yj3mVAA7VGUE4iamnLENiL95S+13P6fAOd2Fz1cbbVwt9ttun4Glj
	MUEtPfGU/IQrew3ye6hhb2EK1/manJ71P6U+W3OkPI11dK3kTyALqznR2TTLT3ZAb3Kf6pdSjWV
	2nZzsjB+kCDlUmGXZIrjkhjb+ecForn2PJa+fNmQCKSHgEetm8IYjUn0ls/cF8tCQXpIbnyYH2c
	ZoW3IsxTPpA==
X-Received: by 2002:a17:907:1b27:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c250c37aff9mr9906166b.4.1787678799683; Tue, 25 Aug 2026
 10:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823171311.3857087-1-nicoyip.dev@gmail.com> <CAAVpQUAaCuwYyC97xXAwry=0QAWLo7+AM1ct2xqq45PkwJKKOw@mail.gmail.com>
In-Reply-To: <CAAVpQUAaCuwYyC97xXAwry=0QAWLo7+AM1ct2xqq45PkwJKKOw@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 26 Aug 2026 01:26:27 +0800
X-Gm-Features: AcwNN1WLdlGhOxRrnLU2WsMkoLsBG7YhN0UiE5KmcEL7J63Ct5Ic33kpZ-H5Y-Q
Message-ID: <CAAo+4rXuRKuzzxJeMHm+3qsfxWDwszca768raB5JZFB1Nv+rXA@mail.gmail.com>
Subject: Re: [PATCH net] net: pin protocol module before socket allocation
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Frank Filz <ffilzlnx@us.ibm.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> inet_create() rather looks broken.
>
> inet_unregister_protosw() calls synchronize_net(), but the following
> proto_unregister() might be done after rcu_read_unlock() and before
> WARN_ON(!answer_prot->slab) in inet_create().

Right, that is the root cause. As sk_alloc() uses GFP_KERNEL, it
cannot run under rcu_read_lock(). I just sent a v2 by moving the extra
module reference get/put to inet_create().

> Which module did you use to trigger the bug ?

It is l2tp_ip, via socket(AF_INET, SOCK_DGRAM, IPPROTO_L2TP) racing
delete_module("l2tp_ip"). I think inet6_create() also suffers from
this bug as it has a similar pattern, so v2 also fixes that path as
well.

Best regards,
Chengfeng
