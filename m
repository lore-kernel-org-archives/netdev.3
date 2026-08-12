Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E34449B09
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556416; cv=pass; b=rwbWjnEWm37Zmv2o1cgJABAxJU5F5arlFlfa3gz5BdH5RJNKQY8gN9Ufl+W9mkMBPHyDbeYAMJ5WRBxF2CbzU3TVSN2jwP0oxavs89avTu2pp3eQ86QV1F+6mi0Bzgl+rYm1WDYK0245xVuWiW87BHaTwAD9T0FYLunWkvoWb1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556416; c=relaxed/simple;
	bh=BVW3XNZVcoRauzWZbb/gHD2TzRMVy4vLhiPUA+p4teg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7Co9bZUhgVO1ZMoefQc7B0Sl+IH6TPHk0I+Gj1hze7NGDA7oBnHJQ18sHCAu5CK8Dp+cTMArf9ShWhtgV0xJCeQP2IQx5UL6kRp8tk3fup/elmVNxfk6Vdp0TYGBkNzt4xv7COVw09e/etWPKc5XqzneU/XAgSzVbmLZwK9+aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Lul5C00U; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Lul5C00U"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66899fe9077so2063246d50.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 10:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786556414; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9HNaeTvlYXk/nuXIKm10tVoNXYYeB2EVDH6t5Ig4YUYATqeBpmN5QDKR01GdebgoH
         IGtSFVtGxs+mkGauRbPNC3QeDiZ/ONl8Ugtveu3mnVqcRv+9hejAI/Gvc/cS59b/kY/M
         qcp4ls1uZO/pWyceafP4paGdzOK3T/Bg7nexpif8HfHz4zJgxBSqhuE2drUuJAUoTAe3
         jEbyNqQPi9eZdoTFe/TgkKkZ6X83Bnm++sW22f73tnqFq/Nnb7wzDy+16zx41ak23VE8
         EBCsSeeOw15OwKo6kEqyL0+fbq2cT/QAD6VKuqgl6W+tSnKdCTUqzuw5ot22U9iUVPjI
         capQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVW3XNZVcoRauzWZbb/gHD2TzRMVy4vLhiPUA+p4teg=;
        fh=7j8S6N69N6kVvHP/gWt25CV4a3/nsWxvO56K7GzpA1Y=;
        b=ByNHiMkSd6aPeq0ZczOH7uCm4LWuOpRSwPPRXgBNNP+7tVejB+jqqiHevDmMPiMBku
         soTGcpS6V83Bz/P8fI2sDv0BrjhI85cRMyH36xMvZ2xx+y5vnYamBGIxmFvHAFv2Gj2t
         fIZucGMd/GtKSegV/z54HW+7pIeuuiEXW4Tb/+NySlqxK+nLbvofBreN34RK2ijCS+DJ
         f8Ufujo2OlojvMSO1N1FAE95D4vkC6F76wPSYUTXsWiCJZbWAcbbwBOFE5/pY2Iwgpit
         NP86rTrciwX7MV5nLe65GP5byHLmXZta3ct3ggAflFcyLvgJUn4u3XxjMc8OTO6xCkk/
         lwpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786556414; x=1787161214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BVW3XNZVcoRauzWZbb/gHD2TzRMVy4vLhiPUA+p4teg=;
        b=Lul5C00U4sQtSX3ZH9yPExAFZIr5uaLgIN1S0oVp6O7E2WDC4oL+UxSQ15tl2rDULI
         Q5Kx2os+Szsdqy9aCv6WYLPifohDjLY5MXltSYbCi32ue+f/ZHnKfogosKPRFF/6FMa7
         Xpf0yug08wtP0BYqGvzjUrdRbQ6SoWNYeB2bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556414; x=1787161214;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BVW3XNZVcoRauzWZbb/gHD2TzRMVy4vLhiPUA+p4teg=;
        b=bs6ROUG9vDw11h6w25jzRcb3w5m8CmmbfivlVmQoE/WeVToTvhw2wioPx2hYAgPb0x
         QxR//UguuIEX9xo3/3yC/rKlj/cq3/hleG72laY0UYcT2AddoJXSPEZuRab4HkIfjykh
         c0/EDaca+jmDD/fjbmox8dswDd61zfnxIODFwi1PnvyAIpuLoAslFN+dYYsttiFZdUNS
         sg41S7/+utVCpv5vglm4vY3EpYamP5ErzNDIrU2BjA96VIGkgSeMEqrivcDLe7htPJGt
         IaUQ/0zX8/3TU+efsDm9Wkj6igZLyRS5tU59MjejEjkROSC9QIa1ntGHzaku+l51wOVo
         x4vw==
X-Forwarded-Encrypted: i=1; AHgh+RpMItA2R20sbMipxVB+PnKDJYRW2n191CJD6OZMhz5VjhtQb3hlwSMiWM1bmbE+brJQVnBWA5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPCXVhZein4wylaJMGk2FiuapPQtK9tJ9eOSsYGoJXeKUKozQ
	e5bn8WKIG6b0Y5Ga10OzIp0gTcIwMqthRJkFgFxWZGpqdwLYhKTwfDSWK4yHzP7s4Ja8lVul1C0
	OecvjKSD+hwlzV2L4tI2jKHhVOFKixE2y+j1GqxFK
X-Gm-Gg: AR+sD10qtbY8VaC3HOihwriS0pK/Fo1OwGsdjP5B1y4cR4C1VtunGPlR3lUfbt6fyPZ
	xt79JeeRlbZDv6MnqE1Gu4J3Jrl1vkGVa+K2IQEvfRhvHX1VQw+wDHNJmdIGciTSWMr2xSWd4D+
	LPL+T4Dt/n3ghUIMcEh9tm+Ylq4wzgteI7F7gz4lxCqMgPhisO1G5IK8xOMmne8bRwnYYg3hDo0
	fmwSl1JVrbQd4Ja215Cq42iVc/yW94DbuMOzYJT55VmzbRRAG+1vipsKpafTHnjiiQm/SXWUeTM
	IrGZ48B1IDO5PMD1QTwczThows+Gyxs+SURI5VP1KjPP+eiwXvvhdXmmJFF42vEFd/fJCsQ=
X-Received: by 2002:a05:690e:d57:b0:66b:15f3:97f5 with SMTP id
 956f58d0204a3-66c5139c703mr58697d50.9.1786556414152; Wed, 12 Aug 2026
 10:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810144201.1563259-1-victor@mojatatu.com> <20260811174552.21d08728@kernel.org>
In-Reply-To: <20260811174552.21d08728@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 12 Aug 2026 14:40:01 -0300
X-Gm-Features: AUfX_mxE77OYc0CquoOc2Y2alST0njtUDpb6reYJ8CmLxEdjmxPLZmrXodzrFfw
Message-ID: <CA+NMeC_00ZwOZcnLmL6giND4TY4LhFVNXi_5XFdwXgmAJcpbtw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_ife: use mac_len for ingress header offset
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org, yotam.gi@gmail.com, 
	edragain@163.com, vega@nebusec.ai, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Aug 2026 11:42:01 -0300 Victor Nogueira wrote:
> > On ingress, the L2 header stripped from the frame is skb->mac_len, not
> > skb->dev->hard_header_len. Use it for the skb_push/skb_pull offsets in
> > tcf_ife_encode()/tcf_ife_decode() and the matching header length inside
> > ife_encode()/ife_decode(). On egress keep hard_header_len.
> >
> > For devices where hard_header_len differs from mac_len (e.g. PPP, which
> > reports 4 vs 0), the previous code pushed/pulled the wrong amount and
> > could hit skb_under_panic on ingress when headroom was tight.
>
> Clashiko points out that act_ife operates on Ethernet headers
> pretty explicitly. IOW we're fixing a crash in a case that
> functionally won't work, anyway.
>
> Should we not simply drop all the packets if they are are destined
> for a non ARPHRD_ETHER device?

You have a point, but I need to double check.
I'll discuss this with Jamal and get back to you.

cheers,
Victor
