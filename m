Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE82E2665
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788581599; cv=pass; b=SblYbBGKjmbFnkeIMk7MW8yi59Y46AocEaK0LR0G/LLJSHDOQ52blpWFcrR+g0r5Qz6sQEOEB+VCVxnoZm2iXHgy6QF6C/OulRvBuW5/8aCOTl3MvF0wNOz9dZVVHXB19SSoYgYA91W/IjMY83OFGP8l45/feaYA1W2/6JLROt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788581599; c=relaxed/simple;
	bh=hAxL5sGS3/SOLBrBiNYFggUe93W5zuNnlP5uiKr/lI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRrazbENgB8Tg0XLMj+fPcRMe6mxKPQ2tkF4Fx/wDpPv/Qft8L1zi2RWJy+LRLqEBTYJADe75Ksqljk6bdoxQGZRWhb+5DhRjehFiS6V0WuBYBzafmXinqZDlEeme02eR3/fpeYOC9n+VVXiL46r7mbFiY3Dz67F7JxGfBwrXWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUvjj7Vh; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUvjj7Vh"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1415868b3a.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788581597; cv=none;
        d=google.com; s=arc-20260327;
        b=IuXgnPLqE5GtJC/PPL6/str/Wi5Y0hSbA3AEeO3urJKcDJCkR7XAvD/pIBQ4795753
         617CK1hZNOGLjF7Q6+z5oQ6na1oopM6cROsjiEIEFrp4cWkhzbfgNhE6PA2/1y0mc6VX
         pDDpTU4x8sQZlmZTkm2ZXudo2f9KP+1JKq/QRWtmnL9dveeKNSOJL6VXeXwRfAzifj3X
         FYI2PEAF+asLRE2AqwD3nQiATQLiKmCqs4AK1VwYH3cNRuZwzIebytZm3U9VfMK3PZfo
         KXkPHRbOSyxiiqtGtgCzAyKRIfD7K9tgcMWoUZCrDw2wHHizB6aWomBRxSV4wU3XIQi+
         FyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAxL5sGS3/SOLBrBiNYFggUe93W5zuNnlP5uiKr/lI4=;
        fh=6CDm2VnTHWAQsA2lGuAsK7ZJxGG8NjJSenFKSX5J7Pc=;
        b=EABr5zVbcdM0B6+nlp6GGZtJ/+6UdgD0fIx0dFh3Khn4fTq7ZLH/UhYbSKNU8RTFId
         vSnq0apPu7PK/ms8YSZuhdwZ23AXLzrrXvfoc5mn1hTN1DJNITs5++h7sZwBBFXcmCjC
         bBRlubPGxNf4iCW4GmzdTtMb0007Pw66t1R9ORVmmFQkLx8pK51gWHNBZ1DjF1cv64jn
         CMBYwH3yGB8MF8uFnNbs3kBBolIsoJm5bDoTAiySOaLJpELehRrwFhjx2/F8S4hA+pr1
         9VH7EbP5u7rOYK2f4cKnxZuxrG7WVvvxUWyMkmleTxA40JJSnjbKAMuurGv3B7Y240S1
         Y6bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788581597; x=1789186397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hAxL5sGS3/SOLBrBiNYFggUe93W5zuNnlP5uiKr/lI4=;
        b=gUvjj7VhJh4M16x1CFO00y1jHt33y8431tj4Bv8nFEBFtx69D+Hw2efkGoOl633Dmd
         IZ5wt8GKV33P2eGNf/q+47241lz8IfvXMGUJluJbfj6EHsgP4tSqarqniPoMlrqRxuW4
         dORcjUJOQBNxoTHyxPPhXxJs9bVIYQhG62G4V2jeouLuJBbH/RTlu2niBVrJdfpwzCPS
         gE1qXD6Vxg/4zqkfdqN/iJHerhmfwVX/rT5SYnQRfESCx4kRvg7szbiPM00hP177+Zdl
         lp9wsNbEl2kJfgthAsbh+Da7NnztVN/ZuLfYa6dMm+A3mAJnbW2+L5reROeki14CAUac
         R2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788581597; x=1789186397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAxL5sGS3/SOLBrBiNYFggUe93W5zuNnlP5uiKr/lI4=;
        b=mCG+roTlJi9bJDWckf7Ir3vhSKzBu0TwViBZF/nGoS+wFlmudoJ35VvbtGQPyQyyUb
         U8sCl5cI7e+x7005tR/yFag2y5XEDnGfG/HHVD2wJNn2LJIeBdWC9Vc7rmVXXxH+w1Xj
         s/WYMMHE0JYOJO7is6ctDOxvvXm/1FflMlHTrE2DjeHhntxWlWyyXU1teiUpoTCb/K9g
         zEzWufSBlfKR+p1XgMEkkE6bRaJiDJnzipWW7enoovw7VgxD9hL1Dt2Mosf8+pI5W4YZ
         Nedw5niFfYuMBekwxaklY4vTem1fv0/T/QC9wn2gNYLYEV4LtQkplTKG99D1YaCnOWP0
         FqqA==
X-Forwarded-Encrypted: i=1; AKwUvBzVH8ag7jjz/yZA23DKrTFKZ3XH92BDjTPAiaT9qFadnYQAv5/KABjehJL4JKdEXG5n/T9ZvHk=@vger.kernel.org
X-Gm-Message-State: AFuF++mowgz/eZDJd3Q4jfrEhYM3mT460iFDj+BPKsygXUfF86ElQSsB
	UaQYX7GAvrfOt6YhcqXIZ5LJq5QXNFxk8l1YUVQIjdA/qP79svI5SS6gIlGmUuener5UP6eivjT
	PxPraUQDX1rqxTJc67c91gtd0M1o3pMxkO9dzuTCvR8+4BYdi2F5L3MRfnDI=
X-Gm-Gg: AYBFou2mAVKZT0knkrammMfAVvN2LO4R8mxhPI4tDmhSkvHj+GB+Dr4OhJYVdwiCh1V
	ve052w3Bz7FhjjtudZ8+i8T+G3vle6xhYKfIOM33pEMUBetKk2YqkidlJGAXzXuftZJSHVWn1TP
	piKKlECMq0jilyMrrqtSzxGA0Igr7PIaMmirnUqSLnTxSIhogcfuVJg6EhXgEwwTPXxxqo3tRLj
	zyq13Haw+xlYsvS6ZJWeemJRZtzPGVnmhqosmKDJ/YRXGkogLir6RjacaIEAsXsfPB6gy8mRpi6
	c8cqErRNr59nGNN3mBePN9vXL93ZA17KMP1YrjQXt/9nnESvig3tVCKCBRTauG7eu8WxlBiJuT8
	l3ZYeo4XCj+VKFvnpoIBCo8Mla+rms2n+JwtQspuTVaCHJtJfAM3iBlN8y+V3QbLHe5p8vwCvJs
	mm8DClyeWtJNeK
X-Received: by 2002:a05:6a21:7a91:b0:3d0:e034:a26f with SMTP id
 adf61e73a8af0-3da3a0a6f2fmr18502910637.17.1788581596547; Fri, 04 Sep 2026
 21:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-6-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 21:13:05 -0700
X-Gm-Features: AcwNN1U6crAe-ciSVXOk_TCpO3TxJ_NwPkVOJBod54uwryC_qhkIRKqR8eOZtPw
Message-ID: <CAAVpQUARJM=pxaYpDk4mA2s370Wo6+f0M4YA1kU8qACemK-j_Q@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> VXLAN_F_MDB is an internal runtime state flag indicating whether any
> MDB entries are configured on the device, rather than a netlink
> configuration attribute.
>
> In preparation for converting vxlan->cfg to an RCU-protected pointer,
> move VXLAN_F_MDB from struct vxlan_config to a dedicated 'flags' field
> in struct vxlan_dev as VXLAN_DEV_F_MDB, using atomic bitops (set_bit(),
> clear_bit(), test_bit()) to avoid KCSAN data races between the TX path
> and RTNL operations.
>
> This avoids having to dynamically reallocate and publish a new
> vxlan_config structure via RCU whenever the first MDB entry is added
> or the last one is removed, and prevents potential memory allocation
> failures during MDB teardown under memory pressure.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
