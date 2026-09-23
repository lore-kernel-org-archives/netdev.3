Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB24766B3
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200593; cv=pass; b=Y94jvy483qGmf2P06GMECv8FQjerxgSD5doCeATaSxx52LAnY9l074fTerJZ9aV38z3iY+xj0qgX2IeyehjCI69m5BwOxlxiLAo2qASw/kJjxmBPS3BO3guVDzZWuqvqYU+BWihoJyyXJpEJH/t8TqDqPrIH3/CSAT+1jPc6cfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200593; c=relaxed/simple;
	bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4efF0h+v76+CDr45gd2TITluUXG2JDrCvNY/FaI5p3K4+H+aviKFiDcs38d5VIzfnGIvI3itFup2lKBuQKaUN6rhv2jgnWlFIo3PgRvSJB/HFWreDIgKl8f+HrURG9F+pXJLDL1rZvbtfEac/sHSMoFQ9EwnAWZi2QQtbQxyxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCjvMCn9; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCjvMCn9"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso906352c88.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200591; cv=none;
        d=google.com; s=arc-20260327;
        b=BMCT0TExWXmXl68QNbMbBeO5sh7SMy9c011t6/JaQoHn/io19Rlp8KMQxtx1Ie3Aoz
         dfUzGXE0Tq+1ibLw9wc0SaAiYruFjimN304iSmlwVHA1LnmiOojesvOZ+0AiR0MSzjZJ
         /nOGJDXfKVJV1kVYi2VCZAPt7sVJzgMJGDfhgoNUkRjIyhP7VOpcfJUzqOl+Owj/uM+U
         /uMEyPP1Va90Fn/Qxyi4WhA8fh0XFc3feRi/MTJmmTL3syounOaWTMnuLvK6fBey0nyn
         MArhw+zc5R28WUUNIIPnvScnaiDgStbRemBQApjYuyakHd6eH08EmfNfqtGMKBhqIkzv
         8T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        fh=q4VlFEUseu12FZU/qyx3Ahpn6LYkfMjcGFNIsxaFfNU=;
        b=d2QNrLix8LarYvTb836kEAR6xWKZd1NdKXc6RoRSr1DY7POKXgCST+D2TemxMV+WkC
         wC6sVk7CjCin5rdQ9qTI9zBHPsGm6upQP298MeWuMd29u0+HqjFZZZK6TRJxaP3r/o+l
         yBcgI4PekGL6PlbzfI5ldIAPmj+60eN5SjSAMJoxJIW3F8yrb0olKriAdi1zP6GEeRm4
         B8QVj1oZUDXOhfa7IU2ZJOnZ5OifXFtxWqDl28hiuGjWRM//vxBMxjlbcRJInJO8KS8x
         6+qqrJoC56UBCrMY41zSM9uTGdeb3EGJTnVnTPwbfMQjlO1aP/DvcGuZlCh+Ye0oddkl
         lQMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200591; x=1790805391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=bCjvMCn9H7o6JILjKvrXutxR8idUNWMD/rUIeGfpN8/YWo1rc8OBDVI+tKPiND/NpB
         hXONi34aOKxagN/6/ry2FfEpUvlbzUEbXHeU6ca8QsR4MOjKCtEl2lhqHNcc52DQq4pa
         h2ec+KadEGbL7AQ/5cmh+WSLWFcqfSvZMbK6vbBkiPabwuoe8vv1MIzGeb8vQDlTMFGO
         VDM2AuRiLl6uG3k+KM1R0Vxw0sPChoEu/bRGzpKyph5yIEDNTsiukQ7BoB51YsyHO131
         kj/EYR6hdhJZuR1+Api+Xiflgd06Fu9a6ABIPMswmJyUzUNZfrg8pl7D+1L4f044DXiw
         borw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200591; x=1790805391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=C1CScumdPXEWMndEucFjOu0hswnc0kQrNx8svM0gvDhor/CTNwX4X3EBb4LLPFxEAp
         /rahKa3oXBLGySgrKpH/gFw6b7WDFi1y4btr9/A9l0KjSAba5yHuJ6MnDLImuzshbEhZ
         CtE27jrb1xZ8D+GwbcNtMDxThEzI1qA2ufhW+m7OyvwEnvrrhWZCxUXY2NS+NNZR9IjA
         53koZrCcHiKGco0j/I7L25GuB0jvnCHZxbt65/z9yW94qRBNiSmpW83rhSSUSSJZ6Lpm
         klg5wm8OScmvPvTn1XOrUhu72qnM4p5W24vNzQHZL4fwdp9xODSObBUDZFtfPoc4DK5U
         3kyQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0TZfeRdERXpYXGGdxZg/PiIwV5wAboctrINM9RBMqDaeElAPyhhLJT2GTRC5q++gEr1zsx1M=@vger.kernel.org
X-Gm-Message-State: AFuF++mSqtwXy1sDf2sQ2+64dhjGJfzNJy+qIJPwYG6EFKUWxBck2buI
	fq+hryPR7ZG06UTPI2wK/DUSPv5z57jgYQEE1M10iO6fMLfccLis7ixiauHZGuqBlhOqx5nioNl
	pr0M4rOLZg/ijeKpDaItXGYRyhSrjYAOuRsstmGG1
X-Gm-Gg: AYBFou3N8mF9ESVstr7KhAN+9aWLNZd9nxomDzPvpIIOS87okqTlTHCH59i5vyAjrh2
	260QtOoHbllFhubfmruI7BDzGOFjuqt59W/xgWR/5wEsVyf3WYCxtUT2JQjrtITCaa7kGKSoSZb
	aTapEsuOMaJivsxdSzDsFFovzp6lEDaNw1bAFj7wIfQ/gFBIErfz1mDt+U8jdRBbgjFG5MCLme8
	f5j/n79v4sURov3aipHgLPB2Wy66sKrYrcL2fMIcLnbf12fhvrwbHFCojROEye/C09JXEGpF2+Y
	2WTToqE/2ZP61g9Zhb9mBASLXnS1E1HQgANAG4w0o/I+HgJ+bQSZsm19Sw6rvqrsZyFJU0YRPxh
	RWivzmTgNMfFPk3rsvbOu+Fu66KXF9hT1Mg8WtjPjOJUpOlLxzcKEiT3b+g9FrSnw8VXgmzusIK
	+I99qWdiiGeTA2ZprV7Y6EZFYiRiOPKQhs
X-Received: by 2002:a05:7022:283:10b0:144:fa79:174 with SMTP id
 a92af1059eb24-14503fde7bdmr332221c88.44.1790200590351; Wed, 23 Sep 2026
 14:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-9-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-9-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:56:17 -0700
X-Gm-Features: AcwNN1WTmRu_UcCqwbUzcj50WRmlZQF-1DnBwp1Mc1zme4G7j3AGU3vKP0_d6i8
Message-ID: <CAAVpQUCm2cYO4MVQiRHPTCJweT5p4-AUwWBgY5nLAmXPhtPG1w@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] libceph: use sk_clear_nospace()
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
