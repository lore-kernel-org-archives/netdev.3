Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792717266;
	b=WOBsyr96ValWy2foEWeizcAY64totZo4PegsHKNeHt+ztAIylF53Dy5SQOIyc5SmPNXO
	 rp277M8DGZ9akUCg6G60uVpCfEny9I23Tck5PTAP/9/4M9dMWDgDsKpGl34ifnpqRLlOw
	 f+tQeVicpGdCarWlXlBL8XZyUNydk36rwWSNs2dKAP7OLqRCBZp3V2PZQ6P0Jx2MBoulh
	 WqDZelWXFKy14q/I2c7ax8PM5R7HAWU98VzGOQmZncrrMkw7nJ1eiSssqWHCj2IRlauFj
	 Mkt/OnIFJJFeqkJOHYo8gftEZkG/TQMi8Xfj9OWyCy9pWOZUYZ7f4auXA5v+RPUMQsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792717266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DkhJgpFgb1NzTq+8EZOytBhrmFtUa8WLKSMncnmwEDk=;
	b=qmqRo6akd/qsCxbfq5B02QdwydEtfPUlL0e0oS4vT9anFC179av9EuFkB0IHAlOFlpht
	 R8+pyquFSzHxyQjBcs8Fvzl/e3YKQX9p/vx/FmMr1bvrOvc8C4Zdq+JUyicQO0M6F/OlM
	 onGlmFT8iQ/Xbi09BQseJxZh4nMILYv9/nc37BuZC+UVBDZaFJ1qAqAMRf7EHdLkP51bW
	 3ri06Ee+P+rRMc+z6XD29/fxOR8uvUjuLbXlpKnlTovcMaXlJjgfXI0/1eXYLrEvQxcPi
	 CSayY3+XjtsXv916Ib8YADAKUJggIYU6RjYSlVdVvyG9Mg9crCPx8e8CyRs+jlHnjRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft4RoOcD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD3606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFD3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft4RoOcD
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so413673a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:01:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792717265; cv=none;
        d=google.com; s=arc-20260327;
        b=TRMal6SXKU+KbRJlqT410wTUJDa1mnWAXEwdI7nSOIi+HhuIrywi8mnX+B91Kn7zxr
         TFmMmDKDPWtDAiZUbQ1wIgRJlegTA6FV7EB5MSoQA44InFmnFCM9zxTz2jHfUUye/97W
         yDp2b2MFv/BcN7V/zLkZ/aFiRLZlmnUIOcPLFgDy4sxzsltcocDE7css29W+Wh16LerD
         sQCnpewNo6tg/jxfqYAcR+uLeYwuVROFMvyVCFpZAhA+4T67rioR6p9xM63PETi/cuEy
         RYX+T8Y6GfNvcy8AyIOimvuIC62u/3YcwOJ4AZqmIfsFKjMCDmI7bU8MbYxd0glp3dBF
         J+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DkhJgpFgb1NzTq+8EZOytBhrmFtUa8WLKSMncnmwEDk=;
        fh=BahDePRU/WkCF12JBChKVJRYsnchdUMY75iI7qrUROE=;
        b=cdd9fHNhIL2AwSUgDpoMU85Va3K1E2m5NeRD/C0obnx4M5BcmQb7cTInL3mzSLsFD1
         vu6m6kxEYH52jXA7bIfOMTIxfxAf9mxneWOfTuNAQXPxzqECXAHwDp2x5Kar8VtNB72h
         9InqVmA0tov+sHagiDc72LzARd97wmyQzoIfyrO4BzHaojC9mj6GFS+awFwc6MxXI+gA
         PJNHdp6ZI3ILG9DVksA5MtXTFDaqR4SLelps5EDeOAYUJCPxDyIjCp9st02I2WyQWUx7
         OqgsCgXtMCKKii3VQ5jOwIKCWBNojXN2CQdNx6tEquftuqAuO9Doq5jipiUklej51xe0
         pq3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792717265; x=1793322065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DkhJgpFgb1NzTq+8EZOytBhrmFtUa8WLKSMncnmwEDk=;
        b=Ft4RoOcDa25bt7XAZAzTDAU5mkaoltdYe7I1VRitTmY8itcC1NHr4YqKKfX/eO7ti1
         rAHdC5UU30pXDC7/Uv9+9LGW8N4Aey8s4MSGwCTfzdpzO4APTwQmx2YnWdEYubrCjBtv
         WNCkhVdhR7e1mgwx0ijQ15T+uy3AD/0PWBNkrF7BVx0NQr+FwFzcQkIr2TR/PTP9PncI
         gAprkgIf+cTgnC18fFeuxCxd6btoImRv8yidGFWkYWB8N46DKRbFJoRTreCy3quYSxXb
         JyGqIt9b52QMz/p/5nQ3//tglA9CaKjq2jlX4qWx4vwWzE13gWFzAODtdVMYLHVJn0He
         /NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792717265; x=1793322065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DkhJgpFgb1NzTq+8EZOytBhrmFtUa8WLKSMncnmwEDk=;
        b=QtblzRr8Y2RhYrTb5app0AOJaBZoLm+CkSu1hZzBQEfH5aU+1V16mDBV/yBRUjwPIX
         27GMIFSDWzUbqM7Gdbhbp8Xna1aGFy4nvaTTmFZG+xB5bzEc3IOfKVFHP/1+5Ps846OQ
         CnUiK1iBKx+4icJsqFj4oOCcgTU9zZnIy66e0bpCHgS5cO1eJK89KKVjwzcTv+AaaPKK
         F5R8PWTCv4fUapsG0EWpNptA9VKEyqfTbxPsyN6B9I4ErzeR8HRlYWGE9JFwvFDKYgpU
         QiW/Du4ZsH4K+WzobAPds3TtIg8zIV49Bp5Nx3KlhT8RCvP+WjEQW94RLGOCx9rXtfLh
         QcRA==
X-Gm-Message-State: AFq9FYJsRmmucafei4pCoBceworMta3Pjn9XVmpzqsolGZcl71w2p2j1
	GlMSKDPMw4cxuwX6YFsYmLbbZSuITHooRn1nqravF9pwDzNafMb6bwKbSOvyGK0G4nJLr4tEcZb
	piWv8I7EFt9DbkPzF1QxsJl/k+KLwNOs=
X-Gm-Gg: AYBFou0W8MV58xMw/zIffHNMfKKkoD+Kx05AW6cj4XQtVya9S/hlqnwH7fNHeLSH5mG
	q4V8OYI7WY0dtSF6yIXLQwaEHFImejEdl72GfpG6AxBSXXKw2JS/+bt8+mcSxtRXLqsfkHRPYhV
	1TCQxQYF4NVT0moxIQrsgmbUPzPYGlKpmSyXlcephY7plvdf5LXGAEOzbZnFXsmWInzxkDBG74z
	M0L1Oah8VI7Xc+ALHN1Zdl4PPhrlfgE+SrmH1uK9iOwe70uCoR01lHw63VIuAx3TdEncuPNEPM2
	vh5QPLsqTVOpelCcmaa/xSvUiqfUFygKo4hRkFqaHbkr2kcxWoHWWOGH2SJqO819WcmBRmWb6Oa
	F0Rb3tSI6YOZtvD3Gy3LY7ooglHhEiZRKUY2EvZOlx0a43S0z7nTppIWi9v/AVD9TgZwkkOXNgn
	wa8aLEol3VPGMWfgA2ZjtvueVRmFVpWGjJNQh2Da5ukb7IkpkprzMCI01Ezvfmh25R2ovw7op0O
	hxkF+lZiChH/TqgI8cpIKlDyggXcSYb+VrbSVnR5LrnnrWen4e8ImpxP53AC9dkC7Qek94=
X-Received: by 2002:a05:6402:c517:10b0:6b1:d822:7c72 with SMTP id
 4fb4d7f45d1cf-6b432bd331emr1054781a12.24.1792717264670; Thu, 22 Oct 2026
 18:01:04 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023005313.3946390-1-rosenp@gmail.com> <179271707120.3327.4775409276963055481@kernel.org>
In-Reply-To: <179271707120.3327.4775409276963055481@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 22 Oct 2026 18:00:53 -0700
X-Gm-Features: AclHuK8fvNbAYREOq0l26jknYmFGL_ykkYwN0WqP0BewsTW1yxD6nfVtrvGAJJ8
Message-ID: <CAKxU2N-_Th-ksPst_1KR3W1nYWoZpWR2Sjfo=RWroot5A1RR8w@mail.gmail.com>
Subject: Re: [PATCH net] net: bgmac: fix oversized RX frame check
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 5:57=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
I added Suggested-by in the commit. LLM only used for the description.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
