Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794572240;
	b=Jk2QQoxaMpGlcxtO4CwLh7yhC8u/GoayZyiQ3V29rl0vFRp21W85+aol9nN8rMFTWbzT
	 UKe11Jctt/xECCMA5LS4PPGqlEyRNmw7xPHtKB+KGH+E4UUezo0H9aYQRQqfqBpqdenuA
	 YRKaY4Fa6chWqLN3pmGMiWOFWW2aZpnuhKq3FG/pBstRnWqhG15cTDlc2IaNYvdFU2y8J
	 Wv3+Ou6cYRyRuQr/5VtxXo8brObf/XRb3ACXqiegQ7qLPz53UbZWi4W1LbLrnOs3oTkVe
	 C9ko4y3lZwLKFXKsJadkFCYNvz8AUO/K+UkZS5+pSK17yV8wjMvw+84si4QXHfAEmlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ly0M9FuHw+ATfebDkkODmJH0RYnp3Mo3Qbxu6si23x0=;
	b=4ZHGwkxn1l7nQtrrKUabZuUCYnpygCaCVUp31F8Mg6pjbgD3AI0maHPbnbyfxCm9bW1a
	 S3YRV1paKL9D7DgfKasWj3xLWF27JgtcGH/mu2F5CfGef3dkHPn2yFaEHhV0DSsAyV0uO
	 vFYNE/J/Oc5Zd1wDBJlF884f/9bNRUCIWEan655dy2lK1sPVT1GImJzwThSu6HHOTFofB
	 mux4tComDAF8yBrXF3VkkYyFZaWY+bsYZcpsBGNp3wxTuw952n3hYbY6cifrO1Dm2oIGp
	 EJ0npLkyVX/zyFNt/hfvMSlW8qbLIjT5fx6zcmzfTCPcgd8/jBwoAB+4yREl3QTeS+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xTSR/U6T";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB07606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB07606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xTSR/U6T
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c6f1019a3so998967d50.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 04:17:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794572239; cv=none;
        d=google.com; s=arc-20260327;
        b=NXXHl2i1OAmvFpLR72vwO0t/b7Mcb81VFfnLd+sEIDeOm85syCgTTl0XHy1rFUzEKg
         vTkJMFXHtR1aP1cRBIE6+OOH5qvIUXnJaHLYQxVP88RJ3JLS4i/OMPRLelUlLvQsuoWM
         tWLtXxB3aUOOHNrwsHRUkMRqBa2QYlVeNtnww3pnwtlMzmNhz8pnyOBLAA+wJaPPg1EP
         XmCFHORtUaep/k8NyqhgHcBmbHG7XG+uyeLOkzC8sk3nAi/CMFqp7aJlxRrPyA5x6RFH
         70TlE1M7jWtFY3cWx6efSuSPVRpltVixmAWzLBEKn5gM4+IdJHEQm0nsdq6MMlcj/whD
         xReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ly0M9FuHw+ATfebDkkODmJH0RYnp3Mo3Qbxu6si23x0=;
        fh=I1Baus7sC5qBJ5SFfykIQsEF+kE7NMCJXXxoYcQ9DeU=;
        b=TerEPUUC6ssCrhhtn0HDzcUOdqtQAK4Drn6EN7FyuOieYXxifX02x6OvLZWGVy2SJJ
         EBd6f72HA9T1BY1YRx85j2k5Qf8WGxKDbi1bBMnsBTMT8gM10poN+wmUbnC0tnIKQksZ
         iJrR36P10qJ7+FEia4gfY12nRv2346813Yvr/CggC3hymLXMdZE/vGtd4H1jI4ej0+yD
         eQVwpknSZd/Rd4d9EtNTgqJJbvo9f+n1Er6lXRVJ6DDdLtd83TvAbZHSil1xtXI7DPoY
         nSI+kkPeY/KqqsBn9Iog1UxmUwFLfbcybgk8MhkEg3IN4qvYx19pCsb7i1INccc+Kox4
         NDTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794572239; x=1795177039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ly0M9FuHw+ATfebDkkODmJH0RYnp3Mo3Qbxu6si23x0=;
        b=xTSR/U6TVmqhbphIHxJKsH2IhHjrX8yEhtZiTjHcv1aTgea2X740y+GzxHZWVgehbU
         ffYrpa62Es31/5fqYHoeXd1vZ5Q8PCyWnXmkpruHrHwQIqH8TFG5dk2IdF59Mfk2nl6i
         7EHhQ+IlQ2OqLNDpAqPebVDsO36a0VQq3OOYLMubeu4scu5uRIrqsgoP6YD6BJ6Dk1bI
         vDxyTygsuVw0/LHdIDCR5Bz915sjUAPUz03oiDr7upd1lMe0P+OsokdStoVGwNEO7UXX
         8R6D/w7YPeF5QJaLEHdCduUdxVaG8EjfLZGPmOsZuWQsIB6F94BVG/ctk7pjSoyoLlpv
         PLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794572239; x=1795177039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ly0M9FuHw+ATfebDkkODmJH0RYnp3Mo3Qbxu6si23x0=;
        b=gyfRdh1CRNTkELI2p77QbiHObCecMhFqAnB8IWztu6G0vr4hx1X48xIHp7k65OQcEh
         hRY+WHClAjjI7yBVLXXzDfyw3jYPZCho8npeLTVwz1BlP/LOAexm4eZ6qde+/XKHoh+3
         SYxUmclxdclhOIv7VCOTAOcUv9UPvgzRDg1BYZDLiN0LqSIDUd14uDfN85kbCvD7/GN3
         fX7KeKqH+WqxFY4CBH42cIW84zZ7tre/LZuxHpWE5edTicTGZ02Z3a0u1oI8b3kof6LT
         IH5TIWOxialzO4ZyTPJlMuJW2hTxsmEbLfUdsuNCGsdAM8EEesHVU9/HRgL0lLvHsGaa
         dFMw==
X-Gm-Message-State: APuU4Z/2jaYs/lZLSw26VXIyiJydF3hychrbaooRDq+eKCm73gao78kr
	YfBOhyPk9JgwSVfIBc2xB73Q8a46/UHG7TR59PXqaUfq/Wc58Q+B2n/Z7pJ/KTp1TyAGmKF8kUu
	b2Zm65EOsIYL38ZxA9YNn4xGrrloYI+c=
X-Gm-Gg: AYBFou0DrQfHIoMGIF/9Mi8CRoA22BbAvw80F/6F0VPeuRUrdKUYo1ZrWKmMrM1F0K/
	GpRqWYJs1TeCeKn/LLclCdw7Y7QBJt3H8oD95U7+ewFpKFC9inDd3XWsEuG1vv0NkdqStCcJtmi
	pq83qopeNOfPSFtvyqfL5RJ9jhdDWhn3yzkR/hC5TxAwWFXiOuSQSHty1R3pG+WxKe9K5n2835j
	lVsWCzW9/rGNZ4fFiMRoXMGH/4SqpAmUMOc4yEeDf1tAX8CzEH8NBwFUFJS5tT+tNCfNuIzqQmy
	E5MvduV/GgCQbUvGIZ6K57KK1bPUAHGsTZ/nd7TkOAQ3cpVTRM/JMAnsUKv8zfwtiQK1Bbr6I4i
	5IKOoHAfa3ANuDQuwTVN/Rq4Wwr5WT/61mnRRTWMhlNz/NSbaP4nd79lw8iGb0Vrk439YM55hHC
	sZvPqf9xPrUIC/aeposyp58BVLBIjW
X-Received: by 2002:a05:690e:439a:b0:67c:1101:c0bf with SMTP id
 956f58d0204a3-67d895e8edcmr817703d50.38.1794572239104; Fri, 13 Nov 2026
 04:17:19 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112192408.24771-1-ralerrdirsardx@gmail.com> <179451171375.2168702.17531890187326124496@kernel.org>
In-Reply-To: <179451171375.2168702.17531890187326124496@kernel.org>
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
Date: Fri, 13 Nov 2026 15:17:08 +0300
X-Gm-Features: AclHuK8bIw7uAKPAEfiKAJ5sjAQLFJOhYdsEVAZCYjMQUc0T19gUhH1TRnOnnxY
Message-ID: <CAGHp__Y9e846ziEmgXfQRzxOW5MRAyDC09Zm0ACT6r1_o__9iA@mail.gmail.com>
Subject: Re: [RFC net-next] net: phy: realtek: track clock state across
 suspend and resume
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, kmehltretter@gmail.com, andrew@lunn.ch, 
	hkallweit1@gmail.com, linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was initially identified by Smatch during static analysis of
the Realtek PHY driver.
I subsequently inspected the relevant clock management and PHY
power-management paths manually.

The analysis identified that rtl821x_resume() may enable a clock that
was already enabled during probe,
since phylib can invoke resume without a preceding suspend. I also
found that clk_prepare_enable()
errors are ignored and that subsequent resume failures may leave clock
references unbalanced.

The issue has not been reproduced at runtime. I do not have access to
the affected
Realtek PHY hardware, and no hardware testing or fault injection has
been performed.
There are no kernel logs or stack traces demonstrating the issue.
The proposed RFC was compiled for x86_64 and checked using Smatch --spammy


=D1=87=D1=82, 12 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 22:2=
8, <netdev-bot+sinfo@kernel.org>:
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
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
