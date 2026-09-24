Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A426D4C3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254907; cv=pass; b=bZSN/ojkc447fzUvJ3+iL6fqpmRHwqb5oCAkltDSC85+adDUzkCNM4X59KqNAowUs+KEQ9LaVkDJUif/VWq+ywYixlDeS70z9wsF9sqg3sWc0HK2MENNoj/F3Rhopdl3k4VnfRfsLopYjO2uuEBOjgVKyo/TTn2TUJHB2lm0xA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254907; c=relaxed/simple;
	bh=EXofQZfVJ/cSDxGuLWgZ14xs/B1YBd7tryUIHt5oeJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2/R6DDnrQ6GwY6SPA1Majrb3S0hMuQ8x5uPvYFvrEbI8pGby8LftSUJMeTHIMnb2zbZ6UMgOHoK0+2Fb2UN6xaUUtLfHM3pdec0R5jp+eE6CZZeyqZ3FtutAsmTDXU290XbjJhYsUw86rkuOrQjUHWxJ44mIe9Uztvf/isUUsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AECg8mJ8; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AECg8mJ8"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb769ca02so20062301cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790254904; cv=none;
        d=google.com; s=arc-20260327;
        b=PjF6jFirFd4tiEzbFtRvnCNAtAIjYvz/CoQ7vpKJco/TLrb0Va/Jn3icGXXqW/08Jp
         1SObbZAP+6iQP21PlFjXkjrIuxZQRVMbvTzd/7V3BaJRNxOZUVSE49TdKPqtftufmNnN
         RjJsetElr1afe7e2/KUHV0GsC7eaVqZAusFV2JoLGx//hQ0YV3PlYoQvav1SHn13C+vD
         jBOAQL+lca1qsufPdbY1thmYjY9FRiunlTpeezF3Xohbx0AT+MfhJs01v7A+jvvoB1f0
         cHoj2rI2cikeJ0mHJrMd05nsjp3Nhjio+DQgRKhLRTX5Et2kg7pB62PB+s336sRgvB3p
         IGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXofQZfVJ/cSDxGuLWgZ14xs/B1YBd7tryUIHt5oeJA=;
        fh=L1JwCYfHiiN+wNbscznob2FlpVEp9QfkwiV2FXPNI+A=;
        b=TW5y1uwq8z301bu9hdw7elEWwcrkZ3ph7kwiLkVPLmXtckcie4/B2FTQHTlEhQhD5c
         HX+D1FeFieLHS3p/2oPujnXANKGRKDdk4XXapnOnO/VDBIRwm2wlAxorI+HIyeivboN4
         A54e1qLfLlRNm6Qg3Gov57qQ5lVNW88sg/+5X0mzdfAIwoxCbRBLiqX3kfuWb4r4qan+
         vP9TPj1MKU3RAc+Qwwfy/dKnP3U6w9sGm8NupFFP7W+mS2Y/6riHr7Od8B2lin8UwK1z
         v4mqBCB0C5ZLIdsHLw3xAhlueJz1IrSRXLW6OhqaNbll5IEmbuUfll9EbeGF+NU4SklY
         4P8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790254904; x=1790859704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EXofQZfVJ/cSDxGuLWgZ14xs/B1YBd7tryUIHt5oeJA=;
        b=AECg8mJ8P4NpcdwV5+zdQlZUI3zFVLqdXuj/dPtXhlALaPQk5Md7tpmOEFmkBe7dNJ
         QZGzx4nmzTjCEpnHszaHz37hm5NjCtxRYFINfzUbTWK3E2SLNPEfG3XBQEaJKqXbEph9
         MoPhi0mAjgAa7bhG7R9LgNjURvk+7jxyaekUb/rSANEJJRE92MUuTfLgoYi+uTGvtyBk
         mmtEL4AcS6ovvMXOsu+OntN9S+51Fs5iVWSplCvKQpjUBFF+0jjv6zdOgAxCGvCKGHpj
         mBHNOMF919bKJQcRa7fQ/habL/QCMg7RY4t4noOQ+/+g6I7eCAFcgrX+q1jVz37MMG4t
         w+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790254904; x=1790859704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXofQZfVJ/cSDxGuLWgZ14xs/B1YBd7tryUIHt5oeJA=;
        b=R8aJ1X99x827ovU/3L3Kt6hbHlwhR4Cs1gn+DpPEPNbuu5s6kXfBLAMEBgnqOzAJ45
         hUk7W94Oj8f1s4eFX0uVunvescq4v+E1tSLk4jG1nc3UFLVklH/aYCqpajAq3bUPuAcs
         lddopxvwhpdVSuzoF3YTv8qcB1Uc5xHmlQrTM1vPRoMGy+GK75jsxfGhpmusOinwIdX4
         uKpuuZM5Eb1zJFdOspYUrcXZnstC7f1yHXndGJ6HaDKWLfjJs+4/jopaYSY/xft/beEC
         8/zbQEwsNGBTbAQQWUC0DVLCq3bk+ouC7mkOmSZtUg8gj9qoVXJLmSM+2NW70V711ED6
         4TbA==
X-Forwarded-Encrypted: i=1; AKwUvBwKqbQSv68EJp0rRgRQIn9Nlw9MtJxBaaN3AnEb5M9+lD2fnWQj32ttqGkr8dXTWpegp3eXl1c=@vger.kernel.org
X-Gm-Message-State: AFuF++l1Skdx1eCqtE5PhM0dG2gEnSrcvyKZf4+WaPnyz5WBWk4r/IHR
	+IOHOeLgqBK+jaAiT72nP+3CVA92SkV2yQlnWT/EnwVCSUPX2NCoXWJ/wGceZDqjNocRR8VY/gE
	qGzhq/YylYVk8d+BESlZm3M1cu7uCyhA9Hzhyb/rP
X-Gm-Gg: AYBFou1TfvpcqSBc7AuKAHJXqIRrUObShmsO+6SBIC4UOpelhhbX/Ct9tPydWLVHne2
	HZYM5k8+bJtuH36YP2P0CP1T4H70Ztai3sci2mHhaPwehfwKXHK73sJSAcftxhDcaCJdT/OCV70
	nMkmAMGQQOH5x//bBBpEvUidVzT/IvhuxUTJ7lSmI6m02L0yKYPdXIkGtu3W2nbbXC9ifqapbnv
	VsIlFQzKo7fNx8QE5KfGK2fu7h3FBGp253ufPdEzNB7sctVJk3lODTEDTiUObzsSH+IYARfuNIn
	znoyK2YnlZAA9HbObBMyEJ7vZxTUq/jJ6m8Y5SVw+0hPqklgzpIqgXnjCsgPQOMEYw1uHcqU6sp
	qJVxD3nSA7xGVtEQMJyhZbdbwq43KeUZ8dXbUOtuhpEY/KDinEFG5XplBFBo1l+O92XXm
X-Received: by 2002:a05:622a:164d:b0:532:810e:ec29 with SMTP id
 d75a77b69052e-532fea0a61amr22767771cf.12.1790254903537; Thu, 24 Sep 2026
 06:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-10-edumazet@google.com> <179020966110.2160803.10658313067830814782@kernel.org>
In-Reply-To: <179020966110.2160803.10658313067830814782@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 15:01:32 +0200
X-Gm-Features: AclHuK_xl9aAKn9tfHgvIfdLspNVnYPqrGbmh50-xXP32w6r_xVSq735iUhVfi0
Message-ID: <CANn89iLFwiMe_JGTOd1vT8jc05Cjdnz8d+ASECiAXide04BmMQ@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] tcp: add tp->tcp_nospace
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, willemb@google.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:27=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).

Ack, I will send a V2, thanks!

pw-bot: cr
