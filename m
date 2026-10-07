Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36953DB626
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396814; cv=pass; b=ez2/zlT6XV/6cqYevcsnxZoxfDZbZfB6jzmRCnqJGomiOKfjR7kGMK1apWnsdv+W/1PSAXHb+lmghtaQtHi2NUQiR7Li9mDE2jyBW/P5/81cEHT3qagTd/hOOp9eLaVGN/HXKjCM9s1o21qwDstBbJqEy8wZETg+Nl2EhVz4Uwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396814; c=relaxed/simple;
	bh=0wykPVPExtMfhxKcAfrp0hErspx+nh4RqrQTL2Nlv20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO+SDeQo30uUCLwnNWx1FoJqu2lpl1qV+48OwPKU8MKapHYFxHLdBugn7HacPm1GwK0exvC/la2kgo4z4akE0R27V/t0d1xmrrm118rcGA8kAZgRQ/8TgIpCP+RBv8/0cdb+x0Y313dqBd+l87iqF6ER4YmCh62Dqq+s2hXoQX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI63g4X0; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI63g4X0"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aae147ef9dso1340a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791396811; cv=none;
        d=google.com; s=arc-20260327;
        b=Qgko3eQaQUrpxJ7VWmv7LTTAX+HfXa8DKAVBmVksE4ChRrncFgNjYPanOHFWIAVoxd
         avVgQtaXoUeRSwfsn4OHq5jdjK/S5XJBw6SqlB6ntDcsP/Sjo8D3Bn50++6pFkuxD0nV
         duW4MZwb3okLODeWAfA1ho+aRmxSKkWpMyEtNKg/gMroXvPZ+0MKUV1qM16HS8sbILOW
         Q0bGZYwCO+OJx4xrGO15+Hg7jc8O2YKVDmiJMK6N9cr0YORqyqEMSh9EC9HIE4lwxxL2
         gDSkzXyekKkw7//lcEZco3lmUmVtA1hFXxDNssRabJIc9vx4uUbScf97TT2YUOH8pbRy
         Wsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WxmdSGUkA1DO3egL6WOHUvJBsfcKWsZyIgmusUzN/4E=;
        fh=NeA7ZcefIJBK2bRRl+eJTqOgLpsQrKJZX8Q4TGdXsPE=;
        b=dr8izei351MI7GWJnVgVCfIdSr7DQcghG5my9csSUbpQo2ntshSEdkXWVYtzk2+07H
         tGXbzHVLVt1KNSOaMK2JA/84whC/ByAYAiyY66Bo7tYkDSuojvypm/ZB2v5g8gg15viR
         KOdsd48jh0TFMhAiv4jiRGc9FS56iMj39BIAqUHZYjir5U4u8PIb+WSjchW9j7jG2lRv
         MSNNZxnkG6aWmDd+odrPRm6OZLEtvQUrDzgz5l+WJ0k/87ftDsjQ9PEBnVbFbSVXZxUu
         rb2aZWtQdWnvgtKZjk30Wf6bejwrb4vJrwKuddwyxGF1nIRCxMKTyuF1lHui6N/rWoKN
         aNdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791396811; x=1792001611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WxmdSGUkA1DO3egL6WOHUvJBsfcKWsZyIgmusUzN/4E=;
        b=qI63g4X02xZmzfuK56jJO3gVELnPNwY9BOz6Ihn9TOyI9AFwgoQpwvzlDVvUiTwqsR
         AmObwXOxqTNnE5VY2JJ3rydhVx4IznQ2Sjuaq3D6MJ1xyntwKriG0DDL/EB0tnwEA/X4
         qb5gBrTars9FqNksC5PdJHCjyQ8+heR5SIZrrFTno6yMEi8WJ2UbYRuAwqmRBkDFVDaH
         5ABPrkvOyauYd0aHCygF7I0CcghUbtcdIBKoYUWe+nWfd6lsnbGpUNbajMDnkOUxOeS+
         cUM5DbhQJQ2deHOs4ppxIxLEEPnjJZQAB93gyUda/bjyROXErAFAj4bc/vW9i/osz03P
         QuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396811; x=1792001611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WxmdSGUkA1DO3egL6WOHUvJBsfcKWsZyIgmusUzN/4E=;
        b=k5UIh23ar8lbvdP/1uqgIu1Ubq6gwtle6xaJsqYMcGICmzK3L2H7nmjygBBWix73SJ
         c2MXM8OymT+e3tZDXxKRZl++/AN3TBZpGCK2dbOSgY9s+JygvLjWw8DVY6ECKQGWjalu
         tkI8E+KMi8Dnl8yfYkwxy++MMMswAI7v2pIOgFPQ1PNX2AAoOwGV9/zxgkbBg+Pz0Tqh
         5QB1lh3Rcqwbv1tMSTxxKmxDEABc/nfDYvYkZaVRViRQruJHIkct8M1KB/u4WATUCGes
         qDDeyTU2bbM3EQ+q+dGJJeWwxSHUEj8KdrtKtDV2docmYwOTulRvvMKvYtQaKORMLR9t
         VCVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcQvmBkgd7Muc9hiK2IhfvE5+lqO2ooT41EK3nOU0W4X3oxJRDSXr/BXdeaH0krNlTgTj/aZs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLf9WAItmy1p7Nzu80LW+rbO3s3UkCrG5mmnk4cwNM0MbdnS7xU
	g+sjuiZeAEEMYcDMAn2WG1BM4D7e1H6fIGtcNpA5tbYo5oeLPiGSCZmlxdfXu9YQ7HJDTp6THX1
	Llsy2AalmN9z3yyNqwYfPJ3UsZd1FFdr9ztZRA723
X-Gm-Gg: AYBFou0WixaTs8cGD9nPHhxNNpcSGhZCiw5mK1shFFkSlBgMgx3AI70EHjJO27jBLc1
	bnDCUz0xsLhERmwdYxs9Kb6IzV57DIYQ1uo9EQakaV28B5EkT3xwo30lGejYDSgEt2IrFNOTTuZ
	10MHY1Rnbiu5HvWOZrjf78sYSNpyHrVnFmd2FcIXQPqmN5GVwxl6Ev6blhdjnmmsoc7H7s+ccbI
	tJYx0md4gAWpV5HkElkhejpzpUwcf1/CMz80rE+4NzOko5HH3Jt5SreQknlglvcCo7eYcZX9C9I
	OV2xI555TcIte9IUlnIHqGYyP2dPIutFdW2h0lTTpODqVB86yI2RzA==
X-Received: by 2002:aa7:c38f:0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6afdca6dbcbmr143558a12.15.1791396810631; Wed, 07 Oct 2026
 11:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
In-Reply-To: <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 7 Oct 2026 11:13:17 -0700
X-Gm-Features: AclHuK-_n_A8xp8YB-RDEaIVKPCVRrxiagUfshfsGewdeFBoQIHEykC2h8UN_Ns
Message-ID: <CAHS8izNHr1o922jw05y5wmFr-Ac3+VxfybX-LMOng6cXeP8Yrw@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 10:29=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
> after copying only the linear part, and the rest of the caller's buffer
> is left as it was.  The callers copy into a buffer that is about to go
> out on the wire: an ICMP error quoting the offending packet, or a
> driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
> is zeroed beforehand, so whatever was in memory there gets sent.
>
> Zero the part of the buffer we didn't fill.  The checksum usually
> won't match the data any more, so the receiver will usually drop the
> packet, but either way it no longer carries anything it shouldn't.
> Only zero for a positive @len, a negative one from a broken caller must
> not turn into a huge memset().
>
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

We probably need some better csum handling with unreadable skbs
eventually. I took a shortcut in the initial implementation and
returned an invalid csum because there was no way to return error from
the csum functions. With LLMs now this is probably easier to fix.

--=20
Thanks,
Mina
