Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1AE42F6F6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425073; cv=pass; b=Xi7HaX1WXcPC83y1eRExEPImyGonir5Oea0a/bcRVUxECz84AzfsgVy2hWi+1lsbdAJfiBR8R8wO5Oqv/XRFeyaTe6gKYhbTgY1inVmtPfaVZTIAq/PBY2ystsB4FWhPN/qoJASpiaGu14o572U/8CctXnMgxig1BnegNZDQtjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425073; c=relaxed/simple;
	bh=eo/mKAbZ8+ZAo6pNEeH1tClKeAv5a7K+pTLrtQ6S67w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnCcsCE2xfcXtcMCx059SvcoOdSOCHZCmQzeXQqQsIDnVy/zY3e64TotFGJKufsxPThsL9JxaN4Dlu8UZnwk4HojAFYse8cRJT+waDfD41fiHtQAjf8nfxYEawgUrNTeESFpYUt4sldh6r+HImIeo3rfTxosRa6SJSNBb/CZWmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6kiAv3f; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6kiAv3f"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52ff0b7c98aso19406611cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788425071; cv=none;
        d=google.com; s=arc-20260327;
        b=kd4TQrsdzkR3YsCZqsCT4pke6/iUbft3djZNIhfEhyPpB5t4U3Fkcvy8sfQogVnFou
         k7avZZvz6WAiEfv0xuZ5rxoeEETLy510KlSOM/bKpFuPiL1oeKHBgH0gzsRfJXQ/R0kX
         iVSbDDK7JWjlP5hK5tpmMCK7un5/PPzh8FNHEQI/6JzM+h84g7JM4vkZE06aYKy9ZDLL
         M+8PIZXD0Wnc4m+imTw9i+tWg+ZLLlgeaXzrouxle/V4x4QNtNreocrFwpR7gziob5ql
         jHENCGi+vwuaVVGOzZWZVtr0SNmrKecJWzoN40VTK9JUr0t6ScAw3WGqlqJ3AdwjfS8o
         neQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UGXcmmUVVzmY3X69FZhKc8apP0syqk+bcVAviicg0iQ=;
        fh=xRmSFVpWHGf3Ob03Ze79S/Tz1ntJPP3L0PoxkK3CqQU=;
        b=BVwKM7fYJOv+4MTKIcPOcrk/arfn3/LH1ShJF177LKNZRUQc6dpwEiHayN6NDKg1Qo
         EUNMsaY120M8xOecqShzaZuJ5EyGhh+rg2kJSXNVe9xlDgua0jeQWLpPeYqGT3qM96Y7
         CMFzDr0q0/PE4tevIUBta1kyzo+uo3GdmtA353vBdSYeSKO5GrRmYvBnAyJRC4nuW5Kl
         WQXlKuRLKbb2KY2TpchkYccq/0FxUD0+eAUBs8eHYAFqNDJCkjJ7lEjLrFle7QS+ZKZi
         xBn9Ic2EYhZfxqQiCa0wU60ylEM6z12qmE8mX9d//fmcC0abZSckAHblBFCSPH6nAhzf
         jwVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788425071; x=1789029871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UGXcmmUVVzmY3X69FZhKc8apP0syqk+bcVAviicg0iQ=;
        b=K6kiAv3fjWk24m0b08pvLqLEYgRTmYEtPUBxvN3wgrYRbEMZM28PCUWCjnWzwWcbSh
         uGTPbQo03cLbm8V4PV9tFHgWP+mtmy4SblAM0rOocccBe7Ar6R1u6DSaKB/cWGij9ulP
         aLNUqMssasLEYzzxh3eib9F7PCRub2d9OThGZux26GcUHIB62QB6nf1k11aSnYlacRDN
         VPy4bl77Z7cF142k8TctNHE0IHCPhpZzB5wtqCCwK9Re+I+cAXHobLVpsrh6F0L/MC3p
         2pEctyS0mgYpHUDTi/Egi1taKRsKY6OYfaaq0sKspG0ROw6QL4qy+U/fB3jvqJYedICF
         gs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425071; x=1789029871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGXcmmUVVzmY3X69FZhKc8apP0syqk+bcVAviicg0iQ=;
        b=V1HgbJyAEcjhkdM1tvGjg461Jsj1ivL4MOo5vFFYPY6WjPFHos/QMxNmF8+7rtOaWb
         6JL1sFo9PrKOLZ73l/22Zdp5HzqswiBQ5qwLTVHUWUBVJGxuQevZhVeYWzAVTAxx5hMl
         OO8QOHSvGGYgAoTESk4w2xnLOeRC+X7V2WS5X9ES4OP2VV+TeXvNasFlEQ1h95F6e7/z
         b0nNxB1GR2IxQMbaWtEo1jL7WjOOQqYtMGHF7ZPuEI6TbrWuZqKAXMsLquQ8dpOE30PJ
         U1WZE8O/tjYdv1h+9kbUfKWhz3xnM7bS/ZG0UijO2ie7eNkXj4bylgXvS7V+vonUyzDJ
         Zw9Q==
X-Forwarded-Encrypted: i=1; AKwUvByCKwYFEk0Kt4TUoDbqWtPNzkBZKREB4Tn4XUN+BWm9DGd+BMXoRYlc8sl/zZgDlnQA4HbsK68=@vger.kernel.org
X-Gm-Message-State: AFuF++kPC2s4EJR80ZUEQNfEU6wk9sS1syNvIDFSEAEnt9eVABoQIa4O
	gIouZazFBI/OJ3NQjhl69a2Og6gGqbe0gLLClTf/jmMKlWGdvyje4r5gigHLbhnSP4Qnau0+KCV
	u98GA7MmgQasDlbpzecYJ7ZuidR4th3o7Urc0Dmw9
X-Gm-Gg: AYBFou0o0SUp1yH1BtofpUe5O/BCYJpA/F5X866a5sFmnUCVy2Rvq97m90N3eEiVGJc
	dF32i/tQdO3VPcEd3TvsSqt5LKp+8Hh25MLKQBXhr+a/X1O7CL4iynB8KNx7vSdmLjq7hlNYSRl
	ZvTrpvmdDlD1X16kWHBA7mG+H0Xw9CRnVXm3OdC6OpXHKj1q2zLJC2tJ6a+dnFM55PLrNRDAcH8
	JwSxli2O6H0s/i2DmvrzU6y7iKwJfKBuL1STpttEMb3uuuDnkpXkdejP0CkMAmGzWyRBGy4BUGf
	eJK/nGcxU1OXo5gjx5Fw3AZidjVZHz1ErhWgw7+GC4LHQLBnbtk6lrSfkbaG9c+ZU2hb+OCQ40y
	RODotS30+QkaNYjQYj5AAntwB7T2xIy18EW0vYwqDelcaqizGSF3BeamV1Q==
X-Received: by 2002:ac8:690b:0:b0:530:42e5:f3a2 with SMTP id
 d75a77b69052e-53042e5f5e8mr64804661cf.43.1788425070051; Thu, 03 Sep 2026
 01:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apkR6ZU+tqP2C3Fl@griffin.linux.hr>
In-Reply-To: <apkR6ZU+tqP2C3Fl@griffin.linux.hr>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 10:44:16 +0200
X-Gm-Features: AcwNN1V31QTbQHlVUR2Ei5qRHgvPD8qcEst2_28P8qGgpJy2SSyFXeEe1YOcxHE
Message-ID: <CANn89iJ+qV5T1xzwqUKzw+mCryOfKyncSB2WPA7vhsTMJ6DfGA@mail.gmail.com>
Subject: Re: [PATCH net v2] ppp_async: drop the errored frame instead of
 resetting its headroom
To: Vlatko Kosturjak <kost@linux.hr>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:21=E2=80=AFAM Vlatko Kosturjak <kost@linux.hr> wro=
te:
>
> ppp_receive_nonmp_frame() prepends a two-byte direction tag before runnin=
g
> the pass/active BPF filters:
>
>         *(__be16 *)skb_push(skb, 2) =3D htons(PPP_FILTER_INBOUND_TAG);
>
> Nothing on the receive path guarantees those two bytes of headroom. The
> frame-error path in ppp_async's process_input_packet() resets a reused sk=
b's
> headroom to zero while claiming to restore it to a freshly allocated stat=
e -
> but a fresh skb from dev_alloc_skb() carries NET_SKB_PAD:
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
