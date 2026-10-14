Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1956568545
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999440; cv=pass; b=aDaazBgPrevW9o2rSO/UQZnvR1AIsUAXCavA9gTgWXZSapKUNYLk+R1QypGuUJgibvSwu94v6G1DmTrPNGD+ifoSRd+FM3HN+TZgSgUJLKQooVMbg/BUcHNf+YWolBexbJI7owzlhx/bbfyEH8FQPzBEKtEfkPPCmSZvM3NLjGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999440; c=relaxed/simple;
	bh=DJDLKOvHjnSL+2Jcfns2ZRn0oxghNlU54Ys8EPUdEzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGYCUt7SWou1XItV75ehqJgAyfqODwr/PXRnU16UBmApepYbl+Jvx0wkHgG8kc2J89wYTCyFej6Ko1+7IL1O8sT1ExFXeFKWm+3y4kJRxDJkaIbl35BkLYmjZkpDiS+u3CK7iMp9g1EJVilQRt/G/wmIkV4gzrhZ43yEsglnRtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=uU81Z9ek; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="uU81Z9ek"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bb7ae22913so2812887e87.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791999434; cv=none;
        d=google.com; s=arc-20260327;
        b=fmqw8/7KFUNE3DuU0i5LAuI0CoAyxlFaCi8tOQTVdo+oHHcNSaxfeBMLVG0nHFD5Xp
         Kl1W1GzIged+lnjTICdDbFyj4x2sWAuKw2y924gt78wEsvQmWiMb36i1jCRv+Y/EIS/f
         jUZHU5qw0pW+pGsXQJACV/RVyvz8yFI8C+GIm3MgpUBWDDByyBM/jQZdIXEkV2YAqmqo
         dLBguKcUTmXkBxgynih1peQ+b1D9FLc7Col1G71q+WVewUaTPOk+zfW6bRPySNOsgFAZ
         hYzOWqO2TfOWboXfEjfky/RmGuGL2nVflJpzjahD2U/mCaSQcqoyLxNJEjP9gS8hlcSi
         U9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+UTNS/vFfTzeveyX319hgkEum1jsnQsp2r7KYlOn6KQ=;
        fh=kALEexMB+d1D1OglMyfhB2uuZw8Ptmfa04ZbpQJ5xHs=;
        b=MGEGJDvvDHvW3lfstJwAz+hySWPf3F3CaxyTqKAOL6DdwbnbL5mWHwhtg6vNXLJVqC
         oNhW0m7+cdPJPxJ9KGSmur6DTOmzGJcUP0Tpf8SGAMOlD+JYG5Ov2Gr9LW6cOw+Jc1xf
         BD1WoO5XCf9KLdIEz5eIZBTbzDN1/VAFplHCrzC7v15+uE+GmcNkrGGMgo1OxFOeI38G
         6cELR1QYrMblypOoqex1Km/9qot7tCUL4gAVzvXs5B8GLKrQn0BiFLK513vMtcYG4+V1
         F+Nf9kQ90QnhxGgkQqy10AhRY9pjqRqoQwB75FLedwvoWhlJUViHImvGZChSR5HT6ugR
         e9IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791999434; x=1792604234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+UTNS/vFfTzeveyX319hgkEum1jsnQsp2r7KYlOn6KQ=;
        b=uU81Z9ekcLjnWrGckdx3sq3yqMOSyjT0oHlSD1crc/yzAAXy/c9HLhBeqX7BpY3Ngg
         aNi8G9e0KlenJsN4+/hdwMY9ul0zRMgG+2vDEfq1nbg5MqSgugw9f/u7x7qWIxFXTFU4
         gDwhr1Di8Rzeng9kV64UHhrQ1glLDuq1Km8sgEfCwJ5HtZVtqZylwYTHUqhnoi8xRkDq
         cbTkL/EYTLRwzPjjvPTR0xhk4Ni1JDRM2L91K2yYvRo8pxhM17an6NJcoxT3OTxdFLzd
         QI9xrjk2xfb6yt+9glzuJz5ufwo980V/UynluKm0RVV2tobwnMJcVCQPY9K2jXZjZIgB
         vEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999434; x=1792604234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+UTNS/vFfTzeveyX319hgkEum1jsnQsp2r7KYlOn6KQ=;
        b=P+xYO047xvO4MMb2JKyFeHrXmW+UA318tRod+xbSQZwp+izA39gZGlZYyvXYG7USkC
         HPjTmDNMXKGUBi5Ew4UOpVg29KrZCTFKsol4yJnQYr9y85o/uipklq1tEvzCaezix5UQ
         Gf53bX/HsbO4DUqwz+nzRu8QQYQkzjKrAJMMk6ANzuxmP6kmpTrXpNg+PmE84mVHDl6V
         EC61pDhM9MwX5siBaltIRaEGNFhz1UKWQ7CblLGqpcCC1v4fEIBeq7tTYJOY30xhtTO9
         2wjDFNXmClvwcxYZJw5nB7sXdmKymxlrmaldWe/01ws87/SnqRlCXjHyzhqIBgilsaSF
         ZUPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcZsexqfbWkR9da+bm0y84k4K2ubl2+ShDfMlW7vUHhJoH06Dki8vV+wj/BYCf5YZ5yFGZBRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaV35M/NPBY2thn2NKAH/1EF+qgm5AmXC8fCTuMIJ9Zkn1/fI1
	+jUYEfpSSmteOcEoMupLBDtzA1gAz9KM0P/YQeGJ9mMOmnbzxvr7u0ETDBXWoeEExj186dP7DQi
	oK9pQfHB8HIQn1X+jiWp/k4gG0x2MnRPVs+ZV6vkCy54=
X-Gm-Gg: AYBFou3egVIbR18tlQPs83Dpsr5VvJSaSCjMTXXTXp/gf2UAENkCeTZVFPqD2NJQ636
	gvskiROrT6Y2XRHvQg5FfZobM479EBJPyQNZ37QXGYsTNIxKOCBDIiOE3vGwD6qmQCn03ElO4Dp
	D8p9grF6IZwyvc+7Tf6KAuqHXa50snrBzjSQyKrOuNkjktCS/1NGv32b76jAzsPbZYzzyXwcVtJ
	EXKOf9BN4t9Gttrwd8zAQJeYYjU9J7uMuVwYO9FL01fdLJ2lpfD3qOvakUzV/pyovBQPH3hY7aF
	iIt5776J/zNfSM21u+QJrfMDvMCjMSDWYUjAoWTqMgDM587+7zMDdNnBvE+hteLxTh6Zfjhui0/
	ZdDr0pKk/Bg==
X-Received: by 2002:a05:6512:2306:b0:5b8:f4d4:7ff4 with SMTP id
 2adb3069b0e04-5bcde6adc9cmr5665129e87.53.1791999434574; Wed, 14 Oct 2026
 10:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791994057.git.zihanx@nebusec.ai> <179199785507.408196.211098055550383602@kernel.org>
In-Reply-To: <179199785507.408196.211098055550383602@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 15 Oct 2026 01:37:01 +0800
X-Gm-Features: AclHuK-vOPepnbg13hewgZkMF7S8wuhnTX3Xl_Hitlt2UDLk6ISp-g7qHfJ75is
Message-ID: <CAANe3eRCHBV=eNebHdHNpH+3YpFVmDSPkc7yXx4-+U5A-h1gqg@mail.gmail.com>
Subject: Re: [PATCH net v9 0/3] rxrpc: fix encap_rcv skb accounting exhaustion
To: netdev-bot+sinfo@kernel.org
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com, 
	marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@kernel.org, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:10=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

 Hi,

 The issue was identified during development through LLM-assisted
code-path review of RxRPC receive-memory
 accounting, followed by manual inspection. We then validated it with
a PoC against the unpatched baseline in a QEMU
 guest. It was not reported from production or by syzbot.

 Thanks,
 Zihan
