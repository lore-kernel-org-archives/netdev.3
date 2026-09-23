Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6851DFFB
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132291; cv=pass; b=izLYuXgiyoQY1OORwHF5xjX5qgmYLtShy2EgLPWwxOeAccvYvZZSOKpu4foucjxs165069b7YrSYKRhNFsMQouezT2hgNWqsPezBf0iq6WCpTj/qC8u37AKUWQBiswOtZT1zIdUYRCIOYAiaAkivWoRlR9V8KXqoc6VZdsse6lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132291; c=relaxed/simple;
	bh=l3tgQkR9srvgyKL7i57hlhGzAomIE6FEMYu5Sirphko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tw8kVMeR3tqHGMhGvau65QPxTaEjopOW7EVoyRLYAqk7d+ZRmT4cM9OQkIBEcmsuMtEugzU0uRV0gNWVNB0bO0ELYbByoyvZC90xe6JOQEcsMMI2rHfoZ7FhrK6VTKja9enjNM2nLZ77zD8WXG8coEXqxBPFzmzr2xd6HwtQxCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noRUpoMB; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noRUpoMB"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76ef19aso5467471cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790132289; cv=none;
        d=google.com; s=arc-20260327;
        b=aQ6Ykw1/JDuNNPj2UGROH11kTEXkhj68gGOgNJCqE8vYdbCgKIT3LqXdT1SGlP+VeD
         hAfmSJvzr74VJWwBsq7LmEvl+iimkZdtJ9AeTN3kkL8a/oxq1k9owL4XkJ0deM2t+kai
         yEL/MVOUpWtkn3A4ObAHzo0xZcT+22AwojOlm/ZiOUJb8yoxAyU09miuqGCHBrI6TKgJ
         yutTMyIxCip67HuNHDztZvmUR9vQu4HZGm4f1Ykb+D1DGbzv00SNLRgKsHRtXuWFGstz
         It2/BQSJ05FDDvDmgWVIptlcn7ZpxxNiK/L9UnfcrbUYFtRtQc26gQQnaiBdv/UkvmH+
         5p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3tgQkR9srvgyKL7i57hlhGzAomIE6FEMYu5Sirphko=;
        fh=sl5zkcdiuo9jYGQWxzluigEF+0vPY0DYPcDIHJl/xhE=;
        b=YBSOUr+jDcdVKglrun5xNjhSsijjviu21xQJK+t1sKj2hksJBiK5h9cLkT07G/Wlui
         ctzRoc1U0K0g2xQ4jHkpGPI2vy55zqqp4sEuEmanr7vVBYpO5p9fu3w98+Mu1zwij4VG
         QrpXiFCKmwFV24vu4bxzYdBpZLiXeQlEEv0ZI7aUufFIjKlk5RpGfbvMa3eqZCBT9Lbi
         7OnUPlPCL4wqU0cI62PiYB4TevsKZcRMtoedN7E246jZx+o0HUNUGJnh/JLn8sN2nYSw
         BsHN/86x6gacY3e3pvRE8vOUHIATxNM9PH6Yb7kMVo+Uheb9hJO6zfjc9HNiyQe/iM/t
         Ya7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790132289; x=1790737089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l3tgQkR9srvgyKL7i57hlhGzAomIE6FEMYu5Sirphko=;
        b=noRUpoMBzhTWXQAK8YbGy737qnQ0CxsuGRYEQvGtZ+QaTjPWRMZfJIhJe+SYmB5Vdy
         EocXWF1K71ONHLJA+Pmmd7O6qLYyicwLlyYGdevdZHR6TU78Sq8oQAKxMoiE+o+qEFKU
         D+eRnRqvdnPWiKOCIbFy0c+A1EnwKX6+Omdz0o69Aye0msbLT8Ma5CNBqRcrNhqUFrX3
         6kcM6QXh+GiQyLxBYx+rMS9UAkxd8ncvX5Yh9y/Mpaj5VGb9Sr145lMghnD6bc5v8tdr
         UKq1Mobv6sHK/FfU2t05TbJX2DRT52CDFBBRFaLOnpveMGAkm6Z7DZRLyyikGWLwgWFw
         v88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790132289; x=1790737089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3tgQkR9srvgyKL7i57hlhGzAomIE6FEMYu5Sirphko=;
        b=uMINVsKbKSFAMxmMPbct678leBH5XeGnU15CByVBN8Q9UpQ9PMUobfxUcNBatB9k/8
         TklxNw1FT4JFLJNMJqa3U9N94oB0otd7K/ghKKINfUy64r6yf9lugDzIt/FSFgur0BiR
         uHYxSX+cDXGr+zk1hBd6e068vtO/iTGUNm/Y8FZyhdFVrevzTxk3Cqa4iNwbE68Ao99r
         Vjqt8yEG4BDNYj9naG7EAhgP33L2MYjRxtb0c7QMjaPX6dZQrWJp1Qty7OWvft5KUfEa
         qX0V2dCue9QZV1vkRCSImonm/OFGOl/AgcpPbl0hjYB0BEzDNrhpLn1iwBTza3mHBSou
         Pfog==
X-Forwarded-Encrypted: i=1; AKwUvBzJmuo+95ONIaPQtBPpEmZ0MT1LfrQny/7xUjrcB+4nBL+ElqnQua83aJYZsb5fHrkcGBCjIu0=@vger.kernel.org
X-Gm-Message-State: AFuF++np+AyMLAXwwqXBiZxfEnMSUaWGS4foQLn8zgL00aDuU+d5ZWNP
	HUtWSrOnTN+TkTOJXYWz0tdHrFleIDJ2PXrw5apCn/JC9M4g+uWLSM9x8C+9qq8xiYYHT3r+THc
	PK0VI8GymQ+fQJpEI/O09qdo72ypOOwOruKLgHm86
X-Gm-Gg: AYBFou3m/1SXwey8FCploTUEAU/dM8OjrC5fProSVywOsLk4YGSEsmIgEgJxLjWAFZ9
	G1/N+cpDGF8V3lEWiDwIihrOs7qJRC8VO3lpAIKmswwxNgzJdHBJrzRf1L5h441vMEPzBrMnKAJ
	REZoT270ZidEIxFsJKJN4A8PlhOjeGOdWty4ffC5TAj06kzskAUZKl3FjJaNtFMahPwu/Ik87Xe
	JDmXeli/dZZSeeJzx0Hybqsd6f5Xhb8qRTCZPgTXGALcEASKXEsxHeoV3Gt5wI2l1eMLkTbBXEc
	OWst49hFVCzhHsstdENhQHYGdpd+QbyDmadE1HcMEoKBQ5AaZiShBI3rztKH/JsKgVj2qlQmFxR
	N8FOtMgEeqSbaoaw21Um2RaP/YFg97NVWmgxm1ZNV70uLjTb/zf6m3O5pKRdi3TdgY1U3JlLJzp
	tebfrBL/hlCjB4Zn0=
X-Received: by 2002:a05:622a:410f:b0:532:d36c:7097 with SMTP id
 d75a77b69052e-532eae7c962mr21206521cf.63.1790132288661; Tue, 22 Sep 2026
 19:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920063419.3587332-1-yilinzhang@moonshot.ai> <CANn89iLUNiEjX4U98=SsQWg5BSV7=cV6ZzwPBiDC4Hu-6US6Lw@mail.gmail.com>
In-Reply-To: <CANn89iLUNiEjX4U98=SsQWg5BSV7=cV6ZzwPBiDC4Hu-6US6Lw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 04:57:57 +0200
X-Gm-Features: AcwNN1WdgL1agSkiZKUcafkk9HpYDfB-wvgSX3PVaoVjaGY9yaq8Zt5Tz8dmB7o
Message-ID: <CANn89i+rkvu579v+F_PBoSvHMr=S+9vVLtr47so9HtAQaWB=Aw@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()
To: Yilin Zhang <yilinzhang@moonshot.ai>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kimi Security Team <bug-report@moonshot.ai>, 
	Weiming Shi <shiweiming@moonshot.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:49=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Make sure to rebase your patches to latest net tree, not an old or
> in-house kernel?
> The context shows void tcp_send_active_reset(struct sock *sk, gfp_t
> priority, at line 3694
> rather than current net (line 3887, where tcp_send_active_reset()
> takes enum sk_rst_reason reason).

Ignore this part, I was looking at an old tree.

Make sure to not hand-edit patches before sending them.
