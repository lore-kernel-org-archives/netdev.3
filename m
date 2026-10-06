Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4035AC00
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259040; cv=pass; b=g32N46YaHaCENpo+Fe2PNrTRr+mtuoPX+bjAACOI8eoDwuoVEtUVd6zX9+R/+YnPTLWZc/WaYgZ6bwRxxWmcqL2N7CYx0gT9np57U6wuIBgNX9abLUbuM0xHtvaSIz4rlvQcBjKKUI/C3v3ENa8n4X8KmFo/ax/8WBUsq82o6gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259040; c=relaxed/simple;
	bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxtpMKjQmUe0OI3Hc8ZVSjlGXCM7SUH8pU9fLZ/HSIgGhPJYW2Uz5ABjdDK1ra6tUgEMJLdwLAnea0GwSFtPhIIe6n+ysIUmLLU0JRSqTNGMd1JL1zwd0/pHOFBzj5NwJ7OGFnZxK2WhemvGYG0mFaJs9ai+Cwb31Cs4xWUL4/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuZ5d/fB; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuZ5d/fB"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso809714a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 20:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791259036; cv=none;
        d=google.com; s=arc-20260327;
        b=SyFTjAMsitXmdW+q3WypGZXDffB9mPf8APnlWbb+sOnxC7A9lO67OqoBshv8dyhh5O
         F995i51VV6gYkqc7kRMKNved3ApiST7B0o1IiGlhY4h8/SctR8A2Hf0xyyqIpK3KfIt4
         JJwUO+19f8IHEviINl8sxf3AUoqbsZheqWcdDlfeHt8jw7wYjjAwRf4zozBkOutGiz/t
         CyV429b3qtYPvl+W+Y07Jn1MuSiR3NT63sRAG2Sy7bJ4FvfcjwTYunZIUBZshbp8ICoA
         2lmhuk2v5agMNWP3Gdnr1CVwaiWBLbwPfirHbqZ3IPcFsj8IYlXJmhdLjUwndA80z5p3
         qlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
        fh=sGVtkZ4XqO1Eo20M20kW4SzhOw6swYYxbBHWff45VRo=;
        b=lxLhO452c8cbeWxO55OIXZSffSwY87f3JqtqYH+02FkCHZ6AZRWBsry1O+3BrX0+fj
         6nYj5EDbv5TrQxZf3Qlj3zp2pWyixhD1DftY+zUS9hha60pERxQvo/il1GvelNtwOVK8
         ZW62Ovjai+QQBfP+D8a8DmnpojdtF+yMYderHuG8QyvNfZEs4PfnV35CBiYeET7H5kcw
         w7OP7zdcug/Ys76W5yatMxGuEaoICn2MMZK/K/+UVcQa8JN+LpASBKPE+MV0IyEm6B5g
         07DeFM8v/Jr0pRdOIwjkpjwD3hRbjoH6eoCkQ2QNluUvGN3lHB9zLS1nYEeDu2AFv82f
         TIfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791259036; x=1791863836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
        b=fuZ5d/fBYdVJWcmI6k/DPPngY255c4n9mWL97UrU2omDaP1i6tXuy6e1feARF9Kgiz
         mri5EiedH0ERmeU7PZZsa/KQXORrGHU5TAncgNhlFC0Coa3qdytBVFiJVrdU+bQr3apQ
         /KEbHk+K17Re5XiibuPK8NfxmJWnPxxNCh11mXLjrqXZFvWx38kzshF9rgsE0+BKmjcY
         drqEU2KA5GC2EZXNJD9q+wTN37hBP42GSRL6CNCnPdiF1aviIWfeU7bPNWGIovu8f0E2
         6LvDtZudLBH2PyHY+xzjgozHN9zxZnCknXBB3194nfq+bsfxrHRYe2GR+iYUJgv7mUY6
         oULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791259036; x=1791863836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsQPTCijFFnSl6uhcmGXEH58t82NdDV5ST2wdTt6GoE=;
        b=fK+g4OY1O+r9sF0oyTmwbQoTy+jj1KCHVDtnRZ36PHXR1T4xaFRp+H597+jD+abNha
         ZFGmnOwpBRz0Vns/jFNqAy9r02Wym8NjbI3v0OrpLYm+gOUb6UwEmHEtmWkqCHyQ0dVC
         pvsj9LATPx4apOvAlFkDCozQababeUGmVlTXmhi7G67v7cKBIyqFaHiqF9RwSlLHyZ2K
         2a2TK6CPoYFEnFQXb3xV1lVuav65sYF9fGZe3uZLuRHAl57jqr+JIkpRhUqtWBOtClWN
         XsZQ8QbW5yqLwqQ3sOa62hsMDSf5/I6b2nvlJIgUnIZpKrXeLKNf5BuFAlH0WzEV0vEK
         uiAg==
X-Forwarded-Encrypted: i=1; AKwUvBwwKdnHU9ZEkoFUKZiwnqrdBtRF8ZaDcW3q0yrHr244M8w5T5m+iJVWxBSTMIvGyCvtUtD7kns=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7UihF0DxloFpQgP4rMmUe4IqrR9JVZGSwfJ04VpsSBeCNS1m4
	6SNwpfXHmQYtzyCZALOgrMoyGXNBW3eij/jIipLDMgX1+rvVMjs5msREENH2T1KJkfKXDISPl2E
	4THtNagrgXtqyQcqSY6BklilK25dD9QU=
X-Gm-Gg: AYBFou0ewVfWqvBNblCZuTEeWzQUpRiT9tlDFjZuJPEMjvkXH7Icz9QEN5R9Aw/imdg
	KT0ty+77hTNCFMPHcU8GI2zQlgzySt08PsbGzIGc8MEEj35WVtjBDocbfNTCXBNq4ChGph1G0zz
	Kgv5HhS6pCW3w2MXoBHno1Ty9nMpJp/gA9JUNcU/C1clmSXi4wHNNNtirT1a5A+UkJ+4LJuXQAY
	95SpTjyyKtPG2uaRfD1XQTNT76bQFn2xhrm480I2WfCsrawRpx4/ubncOAPZ3W+rLfxZWWr3thJ
	3+iwx5+gTBFQeA51JhOuAd89NyMRO2ST8nRiPmvdWQhqPEccCTDqe780
X-Received: by 2002:a05:6402:2488:b0:6af:a270:b2a7 with SMTP id
 4fb4d7f45d1cf-6afe280985dmr147282a12.0.1791259035733; Mon, 05 Oct 2026
 20:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHeizqHDqx3ue1=0QL92ef+6C63Ur+v1Z=d93smgdD5zTj_-Pw@mail.gmail.com>
 <arORyXjxvZUoEAIw@chamomile> <CAHeizqF--yGMCLGBEv9f7Gs=dmbZO6+DwSh7KZjpDgbNonCotA@mail.gmail.com>
 <ar4db-oTyeSGTpCy@chamomile> <ar6DFv-zudWg6i1z@chamomile>
In-Reply-To: <ar6DFv-zudWg6i1z@chamomile>
From: Subham Pal <subhampal789@gmail.com>
Date: Tue, 6 Oct 2026 09:27:04 +0530
X-Gm-Features: AclHuK-4B_jprqNVXhLiushIvBfXup2XgaXBALX2ddQEQ01QkjBFDMAPA_kUpzg
Message-ID: <CAHeizqFAFRLf2bGdw-pTLh-ovWFR729Z47obV7m17TrcMb6SVw@mail.gmail.com>
Subject: Re: [PATCH net 0/2] netfilter: nf_conntrack_h323: fixes for NAT
 bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, phil@nwl.cc, kaber@trash.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 9:28=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
> > We will need a reproducer here without requiring such hardware.
>
> This requirement is too strict, apologies, let's remove it.

Thank you for understanding and waiving that requirement.

Per your earlier note regarding the target tree, I will rebase this series
onto nf-next and post [PATCH nf-next v2 0/2] shortly.

Regards,
Subham Pal
