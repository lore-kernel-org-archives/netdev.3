Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3597414433
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200539; cv=pass; b=NUeHlrcoQczYW1cWQQLGeGu39EQsuJ1cxpQoKuH2dVn1aUSrOqSfY2gn3Rb7H+N6BU8gTuc1gdErj0wZsKhzzr620YwVbmGD03TvPxXi6GPEMJ0CmZwlA/ydfTwpQKNzd9c1xuYik/0AXE9dhERFcQkz2JkfQWuX725kH+CNh8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200539; c=relaxed/simple;
	bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1BMYUaeHX5g4Ix85Lsa1B8LPNu4nTJ657wtjWH9GXv03CcVM4MBNrpsMm100Co/FrK7EfbxjC2N416f+XiE2JTIcAMPFhnyrvUMqeVWeg97s87XDvzYPNAZ+M6A10ojDQQIywoji2Xi68y7pZpBiOx9s2MhIHPPq15p4hvp0ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBVXBYwo; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBVXBYwo"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so1025800c88.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200537; cv=none;
        d=google.com; s=arc-20260327;
        b=BXjS5aUO4d+sXhDG0+ONo7p4E4a03yo+tUuEV58zlgy/rAJ2bIDjJZIzx6Vox1cyJ9
         g03MjSYYALURlG5Dji4CUEhpB+6J0nRNwZmwIzjIdk+GVpokQNlXQbMPV/aXgi9soj9Y
         BdOPkRxfUOdxeqJ4nW2lthNRjciGcOwmIx7St7cIeIpZNt/+UQE83vX0Llei8AcFx/Qa
         4eZ3xsdovmhk7+tu1oAWD0CiYWLXx0iUaXVbFcbk0V7TuGZJJ6nz45hJkdI8bNe9uElz
         rJf8f7GJ7s9aD73gWxtkg13aiLqN2IHsWJDUD3kCK53mHMkPOSdXa6qEggP61x0Exzvx
         lb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        fh=Apw9Zh/yKbTI8WEhKecpITbl/53ADSWWo6Jk3TyAQhA=;
        b=Q2n67A4+hpC/firtdDxy4Zg4IW1hw4ybqGqLSKmvCk9YkVGi8VErQotmisVgV670WU
         mPHPwSPKqheH5SXRva416P4J1VhquYxu81djm+J4vsXOlUmfcKL1PY78EvSZvYdlqvo8
         7fwuKKAfd2GOKfSFbvnWBa+seU3sj5H6jtJuZI1HmyepB5DuXWB8KhiEuRccbztTMtAt
         swVdmYPwdo8xov9UZjLOWLaOPf/dPI6mH5WRILaviF7/OfmXo5Di73VbJcm6amDGfOyX
         sc9vPYIPBgBrUowpD1HhBJw6Ujrr+6YSPx/TOQJtR2S6M7SqMsXypzZwf8H9yVkK/0Cd
         UQnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790200537; x=1790805337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=QBVXBYwo84ZzFFrpzIQnZwyzY0Z9ZdW/gPg3hZnZ2ilPi2/KIViGR95UiP67BXwJYf
         R2SJnYrMHa/WvgKRCPL7/Okc31rG9nlfgLpVXT7S3Ao/RfIo9MFHHSvvl2+J9lSrkS60
         3+H83x84imKFyKKXi3O/Rlb1NFPwLjBjZDalBWWJ8QU/Ke4FmbCoIjzrY81PsEi9Z6+t
         GMIX96UHmeXUwJ+iySRS7Xbma+lvqBLZykwxTr2prjsJbJKmQaIwmKvrXuh6ciryR1Zo
         6G/HnGD+13DaJxed4w3e88uGOF1x41Qg5kHVQksSQyamwM1tc0N/7YD0Guy6C+UdC7vp
         OzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200537; x=1790805337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJkPatkmGpmQ2D5AsxWdweDT2bcXDybKgZIC4Dpw5FU=;
        b=B3ml+izQ5B/IfdgWuS35jvsGV9mxEw8dJZrkeSQnZNDCI9tese3rWah9HC7q6Swa1u
         y930xxTtxBx/a+W/TLdT0PdncJKOXW8eb0N5UrpF6ewo8g/zBDkDRsgOy8pmmVturarJ
         jQcv39eDWbpbFudwmdVsDPsGRsglAa7JpGwUIv1mL8xdEBjV1k4KlmTZQjwnzSKhXFF4
         /HHBE4VDAiDa7+jJ8dxCVfim5RLqZO6jVlSfKZr3RnU3P1e+Q/VGpKyYQX+b40ZNC9v8
         QFshNVAyRQGHCPdCIiNMEtFZnnIswNFRQjRHRLJtjmkFuGCCEpDTiV3BytDr906+kgK6
         yWpA==
X-Forwarded-Encrypted: i=1; AKwUvBx50TLXVQhthamBGdTUkWsmYdWTlkWeMCqDxa5TT2ugeJoubFDBRx7l9oMgNxfjUFzpuT/OVxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mLkRoQDXHozPryM6JpQVADMXIvpPucCx6w5nLP9DeO4c2yLESl
	iWZo4cXir5B60+xxEc3ak526KUmsqpezITcvkxSHc74SWTp8QWMBZYqcN5hZbpDHbRcYq4R9d+T
	z/7FpTATihoqSkmEjE74+J8gn0lcCGJGiHd3ShSKx
X-Gm-Gg: AYBFou0YIWBQvsx012oY9Ry+qG++RL3ANDgE/y+BDn3zhdahXdsJN65b8gtjlaqhNn2
	kRR6EnasSj3xc9D4qFCTODOlhbNPfetx3tGz3uNPLJbBtM1UrSg96T8841GPlYx8Lx/rKdSSI6i
	7eqU3iTbTMhZHPAE1+i0zdUd3d6EXPjnQ//VT6r8MQW8NGHl0nzFUo4c7t034R/1fo6odXA0D17
	U1Hk9tJszWTp+UZVUuSvxliL/FTs/jy2uzDWf0i0v6qOqbD5sAfyaPYQ/6/CqmAu5/XdfjPzcjh
	ZO0jws6jKbnE16knQh81nthc3/uubP+vLa59PLs8AU2wBO0X0JqVurj+dvqFsUEOu4luuEhHaSV
	EtCaSsiusMUymkKN+Lo1hwiiMe/Auv2wxlCChvygIp8T5R9SJHPUuBTk974YHnUZHalcjvqmayt
	t3QCILnebddC5eGlmJW2kGEw==
X-Received: by 2002:a05:7022:286:10b0:143:707a:8958 with SMTP id
 a92af1059eb24-14504049060mr306096c88.33.1790200535978; Wed, 23 Sep 2026
 14:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com> <20260922122721.3568295-6-edumazet@google.com>
In-Reply-To: <20260922122721.3568295-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 14:55:23 -0700
X-Gm-Features: AclHuK-ru32NRT7_3wqZ-D4ghWALsXNeZ-mMM-o1Q9qr8IZxj7gXy8nA4sC1Ctk
Message-ID: <CAAVpQUDtN1nKCUqbgWF-S4MZhZUuUYMbyAjihT16g8XkU0h-rw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] dlm: use sk_set_nospace() and sk_clear_nospace()
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
