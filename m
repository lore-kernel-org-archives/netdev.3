Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E130F7EA
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175020; cv=pass; b=fmdAoCSiyAwUuge2SKsY15j0/HDtNrf9DdLJUfyasapOTaUOHrdVD5Vobz6GXtouymJJExq5MziT1reqbHKsu86lATap45OmkUD4IRp9IYBFy5RG+ExQDb16/L6138YlfHIdOh3GM+k4ioE+TR5am6Ctlw1ND1q2Rk5zTnGQMSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175020; c=relaxed/simple;
	bh=4JaW8TsfEgIYQ0t1F0pY0awGa16inumluGQbcchpNhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcmXV0bw6PVwgW+t6jiVHDzkZBRhIQabq1QWB3YI1M+82EUhuqVAxMEnAEouGoO15uc/dVzdKz8SkpLgQ86TN8oNzoQIcoPAzhtYfPDPCuO+F9VQE7AU6bXsefxjsdx5kImbT3TAnlIrGXVHfOLoOpEt83OHz1PpzBJcsiSGhZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGJeDFSL; arc=pass smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGJeDFSL"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-826f42e479dso194183a34.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 21:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791175016; cv=none;
        d=google.com; s=arc-20260327;
        b=YyAPqxqsRmaCQ75ntx/dC04zjMaV8pZW57sDSy6YS2/NJovG7MvIE23u0ukEw5ZFBd
         ovD0nFFIdDqoLrq9Ap9m+2rkSS5N78WjsTbaM5fi0SSAuk7qsckTRASqRZQZNnkkYzZS
         8VjSqt0XTe+pGqTxt9AdzfqDc/D5bEXu8YZHnCamxTcJK3RwQMVxg0OCV+PXhduaRjQu
         91n/UzUPZBe2nc8XruUfP3X0Mnlqqy1mrFSmgiBcuD54U3RHUMpsBc4jDMkzNnlvJarr
         OFapou6BZKEInkQ+sBtl3O9yHe0x2Hfe8KKi4QcWoTCqrzG1rz1z2Rl/gCJS5AxvkXyC
         R2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jMemwemCDjVQ/IRLCAlo5A+Uc/DpvQUIN6OnaV6i+nM=;
        fh=O+NqppMi2tP7qs+U7ZA9Kh5pFkd9M2n3HKuKfjUNAQQ=;
        b=ClPI3hPOaiWy3MD1FtiXN36qj/MCmOT5VVGkffNadefZgMekKa51NFjxGL5bCR1NZ5
         7lUtdd/T/2I5Hwdf8Om1jpESMoTx9r7GJKOvzwJqGick9k6XqPIDXS4ReAfMluKm72SE
         7KoKKKz80ZDxLLNOExrzIBws4TcJAuqL2oZORyhO4I2HtkECwJQT5wTC5xa//HOerodt
         Atb+jZ/0De+71UiNfw8rPSun83kKUimGMcc64T07DelBHgZHwBva67jhie5ovxaeRg+6
         wQ4hDshvfRSnwEo+ZCNm+mWDQQsZn1N04oBMWB28MdnStfRspa4RHLQScKuu4rKOmVlv
         rkpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175016; x=1791779816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jMemwemCDjVQ/IRLCAlo5A+Uc/DpvQUIN6OnaV6i+nM=;
        b=LGJeDFSLZkI/vPN7f6LghCYPc/jKOpleFeaWKdzZDzdOihg8ozwKHvBFCGqzHZ4+Fk
         iudgg00839NrKv6mRHs4sGjUaTRZIP2J/zBqWcf/zxmzk9q/Eg7P5vp40rMFtDVBOHQm
         H5qEGHr45g/LpgcFQFJ7yGkQXfEU0UTu4twTSgFRcfcUFtFpX2U0tnPt3VTDyNENoxoz
         c8KtIhABRG1vheMUe09gbhFaM3ldigSRskHlFPoeLrPtyPxG6VwINfRNbTS9nKnIBWcC
         ig+rgWHidmPpf3Z/xlxVoU+PpD9BuoRY35M9ePkqTcL2TJfWz8AZRJUvr0t4hbElrfE+
         fWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175016; x=1791779816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMemwemCDjVQ/IRLCAlo5A+Uc/DpvQUIN6OnaV6i+nM=;
        b=IinAHWLfK7yPXeU3SCo3QesLyqpvbXygwW/TqTA9oiM3JWaQxB16s0A1lQvXB8aP0f
         FdXj7eBZO7kBEA9mtPEnbJrux5JjEEvIOMzh6AjNaqIadE1oLyKemXDeWs8eNb8A71IR
         Iy3jEJRRqp5WLyrAixVDD3AbY6vI0qKIY6Vnq87vCagrI5a7SGxksdeU7Ce/gbKhauYB
         i8CYFrwqJO/P4FOGXd6qlZAekU9lsy+yxvF4frIhOtXS6vT9RnEz/DUK1Ij3i+OcvzSZ
         i+w8uyeyooNup5t8146hP8n1DDf1ak2UKm1nJcf8P3pMXOS/HgIxVVmXr9gcZsb6Sc+p
         aR1A==
X-Gm-Message-State: AFuF++n3V9Sp+gHp+nPS81vMEFHv2Gwu1aQ57oI4skRyTYPQxGaaqCkA
	KpAagO5M8WRBAtpI/ttSvkCGdUM1ARH94SUSHxSR3HXWcRzToa0SAHy13cqHFhHy1GvgZnvdBva
	N0FZ8wtOE0O+f/2wh0JShH7UHylB5QKU=
X-Gm-Gg: AYBFou3+WAeYpV3bi5+qPlIV8dkvf0PWRXDIgjlBiyqeoQAdOr7SmLI4Nn/9oIUILZZ
	FVvmMbCoUkU1f/+HEeBsp9ChHNUDxqopMaIUdEim9eOHRVwm/fUpvreTT8Ai5FQ3jNi/wiwr146
	VULZANCnsMfi3VABeH7oaJNbqUPCnd920CqqW+vY/AFnEp3LdTxVcc9tHec40GXCUSjH8p1MEpd
	Fm9kDEfByNCLgtD48XHLK4LFmP34nkqOFcUQMeLCntGuAi9jP/wWfpB3Nby6CvmWxevlw6CjgOp
	p41ahieFsmy8+hXPTWA14OSOncmxlS4Ys+YzFU4PzDtpoFrQH/KVK+Z4UX+JnFA1y86yERaFVN9
	6J3/VPEuqtwXK6a+HuTZbyYPC0g==
X-Received: by 2002:a05:6808:169e:b0:4b9:a829:f00e with SMTP id
 5614622812f47-4f529a2c191mr8446849b6e.26.1791175016138; Sun, 04 Oct 2026
 21:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005041525.49111-1-xinsheng.zhu.ny@gmail.com> <179117397560.1402591.15477443356899321449@kernel.org>
In-Reply-To: <179117397560.1402591.15477443356899321449@kernel.org>
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Date: Mon, 5 Oct 2026 00:36:45 -0400
X-Gm-Features: AclHuK8AQ_fJPqH9F2RpLy5B-liqnS01GJJ2XrnacHzFOOm1bTKvMDyxIGNhDR8
Message-ID: <CAFGKm+x2563P6iwWwrJq1VaLJJEbodx8-f5r6Fe41R2f1wdbvw@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oliver@neukum.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I noticed this while manually reviewing usbnet_read_cmd() callers for
short-read handling.
This is a theoretical issue based on code inspection.

On Mon, Oct 5, 2026 at 12:19=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
