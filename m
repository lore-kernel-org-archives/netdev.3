Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18186423780
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889829; cv=pass; b=gM74zyCy+fuJ88EHS5OCnefTmwxv8iVGAGT8h2pm62FJlH8JkyDNjPNHENpA0wTQH2pVH0MXToNd7lA7rEujB6vndocs7GZgD80Vjx2ZTbcV8aRzRvw3SfhsDaxeTfUkRJuVP/opBQR42kniwyA5FY1zDMpm64tvLWw2ZSylWIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889829; c=relaxed/simple;
	bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7lwIYK2yhzP7Vmd4SMwif1siQpHxtJCDmBe/lqIzPPBjXynGhB1/KbGLD68PFVxF4v9o7FlbR28bshmDC+UIM9G9DaJ1eB0b2JawBScfymaNj+XqjfAMd4HfIWKQQvSOOoRne49SlPhks3rKEN2GnwFzhhjJ1avPZrtztVrEq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYo0u6g+; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYo0u6g+"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a33fb0031so38594a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 03:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784889826; cv=none;
        d=google.com; s=arc-20260327;
        b=bYlWW9w9ZRMnCQiGR+43ZyZsZn1EIrg0VFyUgVRqt0ZXwS0gdJO1dbHjTg/C4Ldmn4
         ZHmGcq6D+3iuJ6vr7iCebGpGp6bKF5NHO9JTc5s/fb6bHA/XDEqC5UD8Pyd5ZvVi2QJ0
         g1mR9J53bDaUnPzTG9QqR+eEB20BVFdYzHwHm0ymI0fFj+Fg+63j5fRveZir5ujGDZFA
         vql6LD+6WlkscKK5jtvlp139JlMO3kVcctM/OjqMLb8fLnXK1uU/4/oxpcuV7oFs8QkE
         eyy8Q+tNVL3OweIUmEoCeEMeObpNF+D7vpM4ab0HpOYpmuoSt3dME2s8nDTUFQP3rFtm
         aGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        fh=dZdguk8Ks7pECqSYqq//neV6Qg2Q/WrVLo3YVrgxMR8=;
        b=cQJwgu0sVwFuxS5jg1p9EF/k+tk1C+UWT7ktN7oVBLHRnnRlqoEevhATMEK4ti81P1
         dEzHjA7DkpV8XD0XYRuyrvGYqe6in/iy7tA7MNAkqzxGcVGz14j00+jmPWgpi42fRPuA
         gfyQnKj9pzAlnrTtodSSzqOkw3+eOyz70AFc+Q+lUnxuLVSRPxzOcSiKzGrHoesVyj/1
         62HKsAzDO6cT1607H3335FJsJXPysa11SSADTVdtSpBVFWOeCA3k6G+a4QSU1fMNCuP/
         PElryJLiIQra44TYo0awqXmGL/4I/be/l7ST4Xtym9y0/83722vnH2ikBNC57xxldazf
         wENQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889826; x=1785494626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        b=VYo0u6g+ZlXejTwgeQp1hmpxlhdOFiBh6LXBNM0GcuKMaUaryc+CKy1SYV7Y6aVf5u
         OmtnTh4pEK2MQa2pDJNXPwQx2WQcuWP32aEh+4HI8nvdWWRjFRuKwvXs8JZd+oW01z37
         pFboOTUKL2TTNboj4DJbg0hWde29+5nRB9CD8bLNqGDFZn2mMc/Y4CWLGP7fxaizMpim
         OFGtDvF0BmAG+Rr/THtJNktOtKlPuRCs73C6pXRZWHbJrku67qLx0Cfk3PTtdYyiBNVQ
         iu6KfeilKMz5Yyr+tQAnY1rQwKEnzErvvBooA2j8X8C9vFD7AzQexU+tsG87gdHrJW9+
         54WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889826; x=1785494626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        b=TlF4C0feXmf3cGFxE4ADnIA/k4LEEYhFz1hvtcVYIM5jAI0rhULfnQgqdGwy1SB1Mj
         JtGxnNBYUchWU7YBCWuDFD9Ah5xY5tiZQCYG0WzOKCQdrcPJ6ksPnL2v6BBYrgr85RL7
         M4hAyl5WvEAI2eJdpx6bbQZghxl9QxYGtgftERAyuz42m1PzxeZiTkpBZQarMrMPneoq
         8ST4Xlhhj6Nas37vUcWk++p/FeDvC1KBiqqkA7cA9VhYAi0JXXhnFuUBiHYiFAV8id4/
         RyKmion6s7CKCg9Y5CKSTjkSMzvtXLM69nGvBmRIDcAN3kxVR4y/voHAcfhmMwIaegQX
         c8Xw==
X-Forwarded-Encrypted: i=1; AHgh+RovrYKvDm9BeiaEWI74Yo7fyN7L0QIVyyMbq4+rfaAUbfB3Kx2S0KRyB9OUhJY6jWd2F+y9OQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9X82VKy82KSp2f2Ayflj7AFnod4PPmhKn83kG0Lq95wfxdTuk
	qLV93SHticmkyM6xowXQ4h2FIxLFmhHr4y4ZPKIY9N1Tw9SIzpUqA3av3OlCDp2qq1inQpXqgkU
	DKPly9sB4dsTiRYiDAWhoMWGviM7ItWM=
X-Gm-Gg: AR+sD11AqqkYCXws5HFec1odCfZFdGomZRtucj4WmwiMgeMBcE9OfIlMCFBG+DR4iW1
	54X7zXf/QCcmyp3xAH1U0MfAxMhO3rbFhciXqTNNt28Q8xfpj6hHea4mRvFD20+SFqcZvxE0Blf
	CLaxAI6fiidwLALgz8BZ9nWLlyFe4XrIyEySHqPypqnPs1ZNs+aamqGVYAiBQdwkjNn/zadJr1Y
	AgcQxfwsmggDCUbGmnM+lou846E56eIPqs6VQ8C4/d1lT2mHa5avZ2plPEQxBP2ronEmmchNPbp
	Q7mwJj1OuH90uc4=
X-Received: by 2002:a05:6402:5388:b0:698:81d7:b812 with SMTP id
 4fb4d7f45d1cf-69f8ddc0d34mr814454a12.3.1784889826059; Fri, 24 Jul 2026
 03:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723162602.3275661-1-nicoyip.dev@gmail.com> <20260723100030.3eee6d51@kernel.org>
 <87ldb0lo8t.fsf@cloudflare.com> <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
 <87fr18lmzo.fsf@cloudflare.com>
In-Reply-To: <87fr18lmzo.fsf@cloudflare.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 24 Jul 2026 18:43:34 +0800
X-Gm-Features: AUfX_mxnlnSFi_yV1t_Ui--j4AHwdWK1tce35HMxRExxAoQFSSo6xtrsHUCb3QU
Message-ID: <CAAo+4rVrB-Lv4MfaaH9sbosbOPFJQy0_UaDcbu9tLUFoGtWnvw@mail.gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:07=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
> You need to resend v1 with "PATCH bpf" prefix for bpf CI to pick it up.

No problem, just resent as "[PATCH bpf v4]".

Best, Chengfeng
