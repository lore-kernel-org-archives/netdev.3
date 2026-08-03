Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78053369D55
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785672; cv=pass; b=osy3lWIq5aNNutlHGZsvLtixYGle1+9VZwZmdMqBIyObfDnMuZZp86W91j69MaPBvv/1j9QeI4Bgno2tKGhcXuQ37Mfgt/RNpLK/W/++YFQE9pJZyXL5MUjcPcNM+Ptez72Ylw7JJIudtT8BB0sxLfm71Xr+y7X3c5ut86QXnr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785672; c=relaxed/simple;
	bh=kDIfmTxPvwkhihMCj9mYB45L1wPJrTw9byPix9Ugmuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5Z7iZ6B5lWJS9+JWAkvyzKvsPhgfPxAUh+6Hr/3TiW4XG+qeBtd/9vDWmg9kL7ZVN8ANUwoZCLb7uB/97Vul13XOOpOLIyp0NFjACn5KI5MC4+VpSu2pORPXuntezGlYKe6G97xgpqIhb7B4zadjV9nBsxkGLNwB1KjyqwvLIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNChOXav; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNChOXav"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cab97c86bdso1115ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 12:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785785671; cv=none;
        d=google.com; s=arc-20260327;
        b=i3CcXOpBNmnCWGiX+nv8fn4aaCrusjE5agGynVSMleUg/iqp8T7Vyegqi7XBGGYvL1
         uEf+cxMVYBym62fOxxkxH2tnUgf+SZRTfJHpAi0qAMm6GN++raLvv8I9/10KKVNY66RO
         AtbtK8XFgMS7DXZ/tI9Btj8dVYPG6TXJwQCGeCmmBP0D4FKpr1eEdmWH1EYd9P11Dn5x
         3G7ndOsz4RWYqh/b3QJwBdjpntiIHsKWsFHe2D7AsF0xv/3L7Q063ENIO1yd5mVLq6Lg
         Ta3fetK6PB5G8py6MqGnoO93Y4M4VK13K/xmmsxCMvF1C9SihgLIEhyG0jdX5Vt6v88E
         2NxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDIfmTxPvwkhihMCj9mYB45L1wPJrTw9byPix9Ugmuk=;
        fh=MyoWtLJRgek1qaNyINj/yWfqSE/HKegyk7A+ehM2Z0o=;
        b=sAFZiWN3uip/KtYr+NfVzlMrIRUUyFP1mzk6ey/t2JNYFhs+MvGXqhkeKUIcshRnPm
         vufMe+G9t+9ympSladXmmAncgoG7YWm8YVPusGQAzd/2NGbVzUkCqWcjcDgkDjZ6i1gk
         3uh6en/VyZjoUOj1musKsVU7nZ5oEkGDj9KFjM2QiAYue5ZkIvKukcPcmT0rXro3TYJn
         6TGdlovGb3AIZpgURjK/JaslqwFnZPiglbghl9Zn9uHR2TClOSMmJ0sxb9OPLuNcu6h6
         H1j6aEzKwd+PyP4UbFX5xt7s2p4LcTmUwwgPKV6AonvfWumhJ3tTK204Gu0mIqIpVm8N
         HL2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785785671; x=1786390471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDIfmTxPvwkhihMCj9mYB45L1wPJrTw9byPix9Ugmuk=;
        b=cNChOXav403+gBPJHM1xw+jXvqho68F/rhf5q78D5dXs+XJNHGsVAgZaaO8vVjakRM
         MFiY30Po+lJ7RBcVGMtGrIwtNH3nZQIRi+IR270FSovC1HVXDSQK2QUQJcCE8VZsjNSj
         j2OgWUM4akWCgnApQDse6MQbWUertam35pG70TY3i7z+xmASOk2puHcyjkFS1YBorRbO
         v1jGmWpY0y54DBL3W+rukAsI+K7XeGukCL6iPjBN4m1jdwE1IMz8+hgDuQbjoJicuBAX
         y0kBxdn1yUwLWkZ9S0OgNodpxyAwcUdbBr/WpUynFLSohEyZPq7GjXBZoda7yFzP5zgq
         dszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785785671; x=1786390471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDIfmTxPvwkhihMCj9mYB45L1wPJrTw9byPix9Ugmuk=;
        b=biPGetLliQX6CAfARp7KlhP/rNIimwu7H2TUWMIqtFpajdccvXZjgZoanCE9vStyou
         RyqcxhDIGOPsFycxPUt3y//Y+mSFHj6WIBtRd7NmTk6YPg2hCRgWkjMkxQ59NuiukGEj
         4nHaqemk+HeMk4Jnu5zA75U6YEqoL5XImYMUxef29p1ShvNfV9QB7wb48vAi74jjOuy1
         A0zSHMmnIT4ZNS/raGwXdH9HFFJv9x+mPMG+k6bmw64RZvStCRc2Jv6wEJcPYs87nlbF
         nvpO1CDyydTaVZz6gOzVv2XtVQB8/+DU0hQSnymAIgv8oWrD69dDBoaok07G+DyHq2v7
         XJaw==
X-Forwarded-Encrypted: i=1; AHgh+Rqia44iGbOuWoNA6gnBuCQKTGTe1ivYiNOZVk20DS93n5or+JZMEk7FVvQCP78jPGxfYnH7gao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8ZSJqJ9gMd+Z+A3EPwAIClGBDL/PTtmxni4nL+AC5hbVYng3
	8R/BE+kS/dgzsmxJaN9ebtREvy67x/IeY8csnoD35qpwB3t2m/WJcdfzd5UGb12L9B5ntsVBTE4
	yBNSZEDvC1M2WoZ2ru+ETkBEnnz7tdBt2Jza+zXd0
X-Gm-Gg: AR+sD114NIzFWtZNeuP43SRcUbY0aihw5kr+XguPGw6LC7PAMmClK+CDT28VE3Ns8qm
	AmVA9IsuouhSkxl/oeEY11kf7R0Eijj5kMqooYLF8laxwU8o/zaCyMIMTT/3c2zVe4n3bb0VVTf
	3wAvQK2yNvZvkwk+y/qEe3OWbh8Q/OomkYsNraHXHXhGdbz6Nbt9rKDSFWzHyJdM6nsO7rG6wem
	gRhmmkzo8latt5KH8/a6ZPLH1PJbmZm3lND67cvD3R0DLqIwSllzLEH4Q65X7vEgXGNgLvQ6GAC
	2By1dB8uSrPSaPSKYinSPuMxtOy1oOt+Do2PPwXNBfqlDY+8AJ++5qEaiRmVeFpyNZ2q9XZuunQ
	h+3nK8x00gvpaBSLpqZg3hFMOCzcs5sdcdxGTEtNTqqM=
X-Received: by 2002:a17:902:f80a:b0:2d0:8b22:22ea with SMTP id
 d9443c01a7336-2d08dae97abmr1315915ad.19.1785785670348; Mon, 03 Aug 2026
 12:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802215459.2769283-1-surenb@google.com> <20260802215459.2769283-2-surenb@google.com>
In-Reply-To: <20260802215459.2769283-2-surenb@google.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 3 Aug 2026 21:33:53 +0200
X-Gm-Features: AUfX_mxv_noTyqo8QCRPWsUmWKn0d3REtIV89ykTA0nxB-q-Uskzd_b5sOgBh6U
Message-ID: <CAG48ez1w6oPobKZPzoRRN+Nf66PrVYRJwKQx=qwTLTR3n0EFRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: Make per-VMA locks available universally
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, dave.hansen@linux.intel.com, 
	Liam.Howlett@oracle.com, ljs@kernel.org, david@redhat.com, 
	willy@infradead.org, shakeel.butt@linux.dev, vbabka@kernel.org, 
	aliceryhl@google.com, arve@android.com, cmllamas@google.com, 
	christian@brauner.io, tkjos@android.com, dsahern@kernel.org, 
	davem@davemloft.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 11:55=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> The per-VMA locks have been around for several years. They've had some
> bugs worked out of them and have seen quite wide use. However, they
> are still only available when architectures explicitly enable them.
> Remove the conditional compilation around the per-VMA locks, making
> them available on all architectures and configs.

Reviewed-by: Jann Horn <jannh@google.com>

I've grepped around in arch-specific code in the architectures that
weren't already opted in to look for stuff that takes the mmap lock in
write mode and manually mutates VMAs, and couldn't find anything, so I
think this is correct.
