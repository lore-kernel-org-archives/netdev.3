Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED613CF695
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400276; cv=pass; b=AzUsKxJgqhDPMMBlXUK/F9K9TKU5oLmdrx4PoHehr3mvSJStklqBsfjlMC+zny/eRsO7vzQXLz2aw+E4VlMSergCf/BgGlxHP9EwQbpFq7z/azdg0myrxXu9cDxSEDcgENyoIaNHfvo3B2yUzhmYhG3VOEihO3e0qsUF3vZKkn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400276; c=relaxed/simple;
	bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUYZlLp+cDAvg02u7p9xINIrq2s43/7Uzb2Wq56ePjTUMJa7a5fzCGnHjudPucyJLO6RlWv/F0KVcvF7348S7nnW4MZ59aa+QBZWBx0VvdQtFcSp9inU+gfdGrVBdZGgKzxasvX3MfBDudn/AMkNBeOxGf6KDVb1U2qlPxI74CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQgWoJ0B; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQgWoJ0B"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69f734cd461so252818a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 01:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785400266; cv=none;
        d=google.com; s=arc-20260327;
        b=eTDHjRV20soACBplBGdX+8iON8V+C8vmsKjs98B2QFTo1nTv5E6DwHjUDZ2I8713s3
         hNHiMY8tdXEGRa5JXYunQkY/BCGWAHZNe+JKWubhjTUX6Sqfp1zPIVWkKbVD9G/QqkMY
         FPPv7RQToA44jU31gBY7tqqVBOTsSoc2kDNR8UGil7nH/838K/LuJJYIv7ORegkvF5Hs
         hGpdP4eFJqNsXhL/0AbdI/1lXKZuijlJ+X7uxFBhQrvXctYD77zurujhh+GCYy3MZCEY
         D++Ys7U10/V+pBp/pmB4X1LkspQLrFPL5W47+T61VyGU4vu+xpBylQVJxCehV3LNFBdf
         NxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
        fh=3D5LD53N2mTD02MNTPY3GM+UxfQsVDm5d/l40gdG0NM=;
        b=nhoiBpvNlvt5pCgN0zDQFZG13Wzw2K/tygGbM63IDqIGPcRPRwdUNFWD+TNTb3N9nT
         rSQ1QNmCQD1xyZO42zGu6p9EOwYbKquCFCsRTMAxDZayiDtVYSAcDWw6stcrrDoOW3c1
         UtZ3y67vl1+fS32zpIAigpZoRpK65VUVEuXEzcK/eBwypf+Vo+p4+Y0fxUU8Yf47KQSJ
         8eQIb0ePc/SAFWZXVfSyhXaGSr5zcF2gFanQLXcl2eV+gWah5NyhfalfT1tcQp+IPzUG
         rx3fA8MLMYL6JzzmPD1cAa0SPMayMmfAXDDg/Hl0xAtZKerX3kdhHvItcGyAdV9c2gf6
         cE1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400266; x=1786005066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
        b=FQgWoJ0Ban7tkpBIKsbVb1GhdVRoDo24YlMgFlki9j0l/FrFMU0x90zTbpVnvDiDYz
         a48u9VKaiivILVKwNQzBUdLJU2aMhJaaK+rk45p1OC/D/CCTBIlNUVkC9lFaIdWIwWkn
         G9VFtal4QUBUje+zolTUwBtxivKmgWV+9ImN7csnM6AYp68ZOD16BaFlw9A0AD0MablN
         mjCSr797LW5khJOUgofZt1MFtI0J34cO//1I2B7VKKVpjcOqIDijSfYVyMWn2SUWQ7HW
         by7YM+2W2FgkJHHd6414dS4i2TWsVYGD+NcFFlu6Oy+3B77GHCnKLWoGbarBEMHkhm38
         4/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400266; x=1786005066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
        b=GEfmcVYL2RXDZyR0EnSO0IxCph0nESxWc+pCOBNbZNGRr1enbVWxBzG/vP8h9+lrI5
         LvRKWwfkIwYOC1eaOjcEid5SbOWMPFv1XItWB/ZNSEOCbIsf02QEKQ8l2/0/lGRfLDHo
         fJ0y8lE8+WdeB4VA0DwO3cDJh4Igd5NlgzBDf2PnY3rCG3PyduZPnV/l3rE/8FMhgLn5
         dK6VJheFUZQbnM5VyIplwgvCK06VkBL2990EcjsYKyo3LwW2oWginQ+w7P1aVQCb9G1R
         XC+5XQHapadfZ1VWk0LUnu/9s2K2DxJ9Pnm6YYA4HxyZSK3R5gy2vR+zf29o5V2Epdcu
         j6dQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLf2/o7uIpPFktuBz+WeGe4Is7lPGeifL2pFtT0CkD2HtbIcemlz/KHOz/jrGDnOsdODsfpqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4R9kb6lQekDPLTXvHWJTB30vN9Fg/NJlcxKhoBe23MlTLmNPg
	YM+h6Tg3dbXsByM7MHrTdRhPZFpz6+Ew7MjfrqpUFVwmQRW6GASji0+pDlSWJOrPdn1L9PnvwPz
	nroxsdOit5KY/CfJBUTM93eaBXRvhQFg=
X-Gm-Gg: AR+sD111j9R6d07rXCdHDWHgo29qn42PK8ui7a2oC7RK14mUY2LTOGKWmDMxGMj5s9A
	hvA6x+0NeMxKea+oxwNw06H17gR8DqT6+xk55SUqMTcb3Td0xiBe6EejnT3T9F84S1TMv/c2EGC
	Zsr6YtWDyPB0Jp/prdFiZmml9A/HNvzIuHvL7BWb5bJq6krJg164Ws+9Dr7oZJE3SRSQCQJiTf1
	4FedW6G6yHbw15GazvhZoQ1bd9YbcXzT15Nv7eWhTZFBesyFd1bYwwTXR0lrdbiBZD1+QK/ilG/
	DyfJHGcVWOXZEwHnWNVVeYrbaRYheXF0wPx7S0HYz5+QvmONJr/Ut19/HYoSr1861CSkhDTY0g=
	=
X-Received: by 2002:a05:6402:2792:b0:6a0:eb:ae4b with SMTP id
 4fb4d7f45d1cf-6a07b53987dmr789961a12.0.1785400265443; Thu, 30 Jul 2026
 01:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729163141.213611-1-nicoyip.dev@gmail.com> <DKBP6A3V5I02.3GNQ1SEZST1F0@etsalapatis.com>
In-Reply-To: <DKBP6A3V5I02.3GNQ1SEZST1F0@etsalapatis.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 30 Jul 2026 16:30:53 +0800
X-Gm-Features: AUfX_mzP2_dgrdwIJfpJtiwvx7D1iQ4FEUItWv_JG1MEc41mX0jP5E3An5U4l64
Message-ID: <CAAo+4rWZAdy=6HAHiysb86E5eFmXsWNZACtf_eBzFNqg=9EJhw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix netns reference imbalance in conntrack kfuncs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:38=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
> Sashiko is right on this regarding all other fields of opts having the
> same issue. While they can't lead to a crash, let's still snapshot them
> at the beginning of the function so they don't change from under us.
> This is still far from ideal - we may read an inconsistent snapshot of
> the struct - but it's backed by BPF program-controlled memory so AFAICT
> this is the best we can do.
>
> pw-bot: cr

No problem, v2 was just sent.
