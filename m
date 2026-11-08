Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794134054;
	b=TfY6IAHR446omqTf8ChYEGYJZiiTgPXf4j5s1BGRp38LlqPMvRuwhYnKiU9k0TitKf4t
	 RrWhBiymFDEfsfWEajXLMsatBJcEyX5unf+O2tQ1p4Mfveg81ggiQhA7iK9ArxSg/T304
	 2DYgD/C6KCdHauXjVtp6O00qMkYb/yL3mvHVAwnPb69tb63GJDoaIcidcgPJEuh1eAxEi
	 oMWfniqoaQutLCC5AJzBPD12GgaJTyV14Dta7U7WYjxfSpamOLMfQXxnOi0V6TA7apArL
	 r3hkbJssWgHO1zotmaoGRB6cCft5UZsaFhNRtT/VXkmq5OPUY/zezV2wB4WZtgrA64A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=J/swShSxppBoSwbD3mZrd1ct4q59pujSagZCIzddS+E=;
	b=ngwZmgx/8CIOPEh6wEnne9bGkoDOeQGwL0zJhp5Anv007TzMjWAOMikzIQb8YC37K81n
	 28rFkn/Tw2PFf2AQZn38zTX6kd9QUs7vPhgrAIKeAPxMN1Vgdf4jhzK8AyOD6DFZCTTaK
	 WiWpPY3LSqSFmWjg+CgXD86WiNx/pWRKKxvW1t86i0c2HVviWzWr4JUJPfCyPO7V7hNxN
	 7+NwAaB78gYXQphNgkBgtUScPi0jL90SBQUHeq8goXn9n306HEXBW5GVR/tTZopCMEh8N
	 HpiHOjFArv8W+vOEFghnCqtv/Dfsh1HV5l5Q9WJiTMKbJptiZ0RrsrSd5H/F1+yr2ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IfGIe7Ed;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99308606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 10:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99308606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IfGIe7Ed
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-563a0462094so389b6e.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 02:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794134052; cv=none;
        d=google.com; s=arc-20260327;
        b=T9Oy4/gbE42JMqc8BvG7+gXfcqvFKc9Tq5zLi1gponPZe5MyY3LBqJcksrG4W2uISF
         Y+W33q2zIa6uMKaXQrIswf1dq/JCYwef/m0CuIth68NDKbExICvzLghJ/dWoHYOE5Xsc
         qNjSTXYsF45zuWPXPPCtW2fSiv32KNmR8xeje/tDyf2gw5hF0CKvS+8RFJbo0KzP6An2
         xVdPv4fxDEtDA0u+a8VsS05dO8VFtekaJggFGVJaF5AINLEbftjZXPJq29SRScmlSmOm
         5bEwdxEsRRfqULo7uJKhOjmmAG3Hy6MwteHNwrT+sAksXR4LwaO0ndtdS/Fr3QPxBWAa
         z2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J/swShSxppBoSwbD3mZrd1ct4q59pujSagZCIzddS+E=;
        fh=apboHd9+R1dvvCkJdZDZKmUVNsbKVTk7ZyeK9b5N4V4=;
        b=W+HEgOmltcaFaFerUL9ooPOyGZ0GbGNwcve4HmzvPDwvvSTmi8eGuHr5NAJvyL67Qe
         agov4Hto41W0cM3OyQUGYRyN04ogRddwVIMX2djtNkh6a3N+GwqVeRwK/CKynHvXfXBx
         +3V7l5ifK/zvjimLdDEA5H6s+7q65cvViEr3xWVFXIRlyEsadXXmJFwsYGigIMY/SD2H
         hOZ5lCjUYykThHpT9II1bUkzk5ucQNAOdGVs0uwPh3XA5O3MkxzWtJOHjYA1p9CMzJ46
         6cJSqci16v22hgbsf/3qVCa0S/9h76ybK8yCvU6vVvKmCJXenV3g5aZ3FxD1/eEu/a8N
         /SZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794134052; x=1794738852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/swShSxppBoSwbD3mZrd1ct4q59pujSagZCIzddS+E=;
        b=IfGIe7Ed/KP/4fDSWDbP4YNUxgrsz9WWust+TrzHRSnSdh5d6aIc43gOJLnBQgrpM9
         ZTk48cOjHWoHvubblbSi0jDzoUgnehnzUAS8L0dRoLs29Cn13WmOo2sFC7S407ffHutE
         nfwgUu2NSIWozam8AGIZfDTI9Uv5Gn5Zkd5RtPcIS7x1pNE5Gx6IkVmaDzj018GXbynv
         EDLICJ83SIuVPOgcG853LWX2bAAlNozOzrexbB6RVhWO0ipBPP3uYEpyUlQtWmW2g6Lt
         u0MKClWmyMmnpgdN9bwpo/FNcRTiAUg2bpx3mVc+X6+ksrBgv5lEuZaIRNV1YLMCXx1z
         VViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794134052; x=1794738852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/swShSxppBoSwbD3mZrd1ct4q59pujSagZCIzddS+E=;
        b=sf1W/rEIWJW8+KR4Bl2XPFnQtCySzaA5YfmWctlVm7nYYPOOE7vp2xKz5ZpTFfEuU9
         RyryHzwrJCQz6PIp3QVAmyWnsThngusUvCIn72op9XLzQpu27rWc8ChqKXbLguYOtnX1
         M0QfsaSXvfvpr9uTZ1XK6xTwsVWKt3SbnE82g1kaTRtlTlPSE7rBXWAS3yVnZ3Utb6QA
         RElwEPF3ae44Qz9MjJpivoa85ofYpguTBCG66V4mJcYkKWxbKJBBYLK4kbySi5MkRMly
         ec5o3p4/u9peARYNJl0EoS+Mh0O58jJDhltu8TMtZvNk/uMmoyXRRRHbL1Yt2dpGng4j
         nQ3w==
X-Gm-Message-State: APuU4Z+JxayUHqCGdZMjlp39xM5bLEVQ/kOlKV+ZjmFxZMO+rAGODR1v
	PE/6PdeD3ob7K6Fsq1H+mnseydD6mxdEWUDBudj6bltHMFKhfrfN28T8PzWlE4SgVxMjTkhgOxl
	CTARqHh1JyDlwGQvzAZtgF5WIUDkvlE8=
X-Gm-Gg: AYBFou3+L8f1k9xCjpUcMPKOAmV4gADzo7HMDlrToRHRFll76CU9wJ0UbW5xUWDd+GQ
	lXFBeGanor62pw057cu1cRbHIoVySm84WdlgemhRoWd8espGxI7JABPcTymqzhqQPdjmiqO1iv+
	c2o98jc+K+nfCc4W38XMp5p0KyyRbn0edDQr85VIjRJurZBGjpBxX22j4WTNenXtfMyxs1zHgQJ
	P3w5MUlx+FhKfL0QAGcpb1jxkVEJaGUwdO1GDSTyj8iJi723lTcfKhVG4bsRo0AojsWJUZ5ucMj
	yPomjIByhidndJbS35IMh9ptHjv0RKzByEe4nd/f3bQFURS1CfxdrQAy20el67qx5a+tV4B9U0q
	Xjqo4p4oHq3q880uEq22eV6jMDbI8JbX6BCqGwBSAIP/V4dv95FUo5KT9ATeworWCu+WuRuUAan
	DTRcfMVaGLQymKgFnn
X-Received: by 2002:a05:6808:4fd1:b0:557:308a:9e9a with SMTP id
 5614622812f47-5681446e786mr691736b6e.21.1794134052341; Sun, 08 Nov 2026
 02:34:12 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108101648.1308271-1-mmyangfl@gmail.com> <179413333835.488859.2320463860948262077@kernel.org>
In-Reply-To: <179413333835.488859.2320463860948262077@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Sun, 8 Nov 2026 18:33:35 +0800
X-Gm-Features: AclHuK8NWBEv8FOBbCUFazup_79-wSN-B8rdsbn3juo45PyflMowuN-N7e3LR50
Message-ID: <CAAXyoMOnuAY57Sk6Ehn_LEvA-mc31Fq2x8+2se5=BtAgC7PgaA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: motorcomm: Free the MIB block on port teardown
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 6:22=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

not a fix - explained in the message
