Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793331829;
	b=ioLVc8KR15+WAueUNdb23PNzTFFluqFOmdBFR5JfDIbsugjFbRwf1TH6tlND+VejF28b
	 6ALLSJ/LRDRLGpc/4J/9RMusGYxplBDVKUFnxzxXpIOjXDfFltqnOkMY/KwoFRTfL0/3W
	 galFB0CnlqQESAnoD/iQaC/obvbViSUC7z4JaDvtKEaIATMkjHU/UxFqayGKBLXfbpnN3
	 sZIZBW3b6WtDfHXyTrmtViqZqNzfR/7XSUCr7o6UPc9lV0G0rI89eA8dAV1BIiippzl7s
	 U5l8k+mTpPOzwUxjuCi0Kx2L9PsjucDzTogX0AVA5GlNrZRjwqcGhMRoGrdcqfbayPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iGPtEew99eCH6XlEoDIFTdAopuhQlECCY2fMA9kY8Fw=;
	b=bNM9u0ZNqtiPBAYam1OPKAQl6Sj+GkkVeh8tFk6neayoT8D4iNkwGYLvvMd+gboMJzwg
	 DTJpIIiD5Q1sAfk3gFuz8uZv8Ua7o3+WELbenz3mY5V3+s3dGs3CTiADcdu8DlSfqBEsx
	 nJAh/PffRV5JckoEikWJKI6Cus2UxwxmQPp3pBGv8+PPnrpNATgX5ft3kWZC8DYTWI6My
	 xacxZRdh6psvDYw1U/uVgRYI1NJDMNoyfgSULctVCqQR5C33OMxt2QPVCbvAUDwmzdtCc
	 anijV4lXfmxAhciLq563bIcTROyy9RzrmVbeUeq2UV+GhD7MWoZsuYvYtgAQVY07DJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kSpaj31a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC2606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kSpaj31a
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-845f3fa7f38so146261a34.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793331827; cv=none;
        d=google.com; s=arc-20260327;
        b=Pl586f/zX/I7WJ+jL6iyzw+8QfdBQvz9qT6028FYCqcCI1Kz4OM1pRXmQ5IBOeaBXs
         Fnj1KAgJMJgzAwb8Z+JY47Fx9CiIXjvMJGJkFdARN8dn9Dq02u450yvfEuFKIbEq8tNr
         vdTVf/JHBfukAARONqS44lSuCDsPsTJ3424Lle4SVgAWIX2wAClIJNV0ThVtaHt/IGxR
         g3ujlWC5XqQokUR9zNe2YO6/Jd4JZR/gS3+r9Vvl07IxFdn8H1D9D+nbBcOcsjGZggSP
         ywau7zP4JfGi6WidyXV5GsswTgcIoThLm5zI/jLpDqSGkQBKQ1EBf+QBLSkxFMLf6Bao
         7RAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iGPtEew99eCH6XlEoDIFTdAopuhQlECCY2fMA9kY8Fw=;
        fh=CuH7/U/D5n0LnnnOK8P1R/nJ/CPyCDgv1I7ISFR6IjE=;
        b=i4jxiUMaVGOW79cED2hi/wDLJaZsxsSJetjZyUTzjQL9duYiwwMSHnBfQma+uunYkM
         s0bc1jNu3XxaVhQ8ElpJrcTsv0YWDSgYcQ1du53AB6OW+Piivdz9sXvPwbSX+U7AY4pf
         K2rFK7j0L/vfroLgussN8zyRxqtEBaiNVbZ1Fbh0b/eT/a5lv5Lq4OHee+8Yl3Lxud+d
         LCxhsDfprwRMaizuUbfQef4ItaSP+9yPssP7L5p1EV9EtiBBzjIzBJvIgy/hgkuOCidq
         HpDayuvnlHJfZ7UORkzk+p8f05ojy8F7gElcO7kDUe1IZ/goUTvr9JMA8/JnBpXGOCIi
         sZZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793331827; x=1793936627; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGPtEew99eCH6XlEoDIFTdAopuhQlECCY2fMA9kY8Fw=;
        b=kSpaj31aElVpf/H1IqjzoApLtqgJnZFPFj3YZQJw8LMO6GUuEGyfIH19jmtFZny2FC
         ybXdpAzWtPbFZOqY0FYMcIvUtPCbs59EDt/fsj9RWEs26/Hbd9Jjss8pzpghLarBq2wq
         oh6LsYnF6Gzz6Ur1wIg3a7GTHpXfz2tGvuljKmmgMFPwo3m9LT3O5N6hwdFAKUn0wJG7
         zIIOkVJRybgAMRVm2dSjG+Lpof8Q8s4NdkarL5C0TPuWuhSoXEvOB+FsQxkzeLrfyUx3
         5QHtkeHnpQjCwMlOe+H6EgXqZx2hqgDYIpzGuFYwRxrZoTYSGqjgD3KY8Yx9RtKRjv7r
         UUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793331827; x=1793936627;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iGPtEew99eCH6XlEoDIFTdAopuhQlECCY2fMA9kY8Fw=;
        b=eHUSpgh62em4epqTY6gf2Y8RKvI7H6KCFgs5MTdQEDrs4ziQ37SOXGiQbw7EEqMFo4
         CaOm48Y2Ko5ykx/Lf/fIEt4s1Q0T09F68I0EzA9Hii5fZaung2l/mupZdCPSJ063bfFY
         KmERWR5DqIzYD/7Jp3H1HKXxWI/ksix52qkyk33wCr0wL5bjzh4fDHn94VscuWseIzXf
         nwwmOv7Xj2F+B0O/+ZthYAWCg8mDsnWy2jUPKBw0ywjrVW1XAFb8nj0zDBQHWyTywjGT
         jfIFKDilEeVkXhDgI4kynNJquFxwgCEcjjxEUZb60cJmrjEHRYUlEdcapJuDdtBSOkOC
         MWXg==
X-Forwarded-Encrypted: i=1; AKwUvBw1npzjjLh2y99X8qa88Rm8wiK2OLtO/2j1CE9a8BfJj6CLftbyfCZs13YobhAs6a2yOuu0YTk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD4lHy75ig9cd7PnZ7atFHRBC8Ruu9apaECb9IOxI3aHYmpPOb
	fO9HhLJgxNTdnRYwg5XoATIQ0yUpASmaX5ba/ScyohA5TK5X0MSBDeXzI8rcX/ovVI358RiMN4d
	uZ3jvYDXtUGTChcpucwcZTtX/XeyGQmE=
X-Gm-Gg: AYBFou317RLAFN4/+dH4/za4a/oCg+ONK5JBhVdWIMG582cCUNh4abg4gB5cTpY2Olc
	fUO7Y5hLNBshawSjDh3i12YjWqxpGW+Ocj5IYbSMx+RnxXcM2QmFfNb09vEpTAErzX0Pt9IE74X
	dUiI44llk8ohrxfxRseIDR52xXQmLgqx7tgAEKUfsxktTwSqjnv+wAZ8VzfIed5oFAduPZObgeC
	HgAnXvMlB4NeqG4eLsJI0oeZpBL2DdNeMlLGm1K+BxlEXIQqTVLsbj8d412pHoNQ6VOuYzzk/SM
	GPhK5lcL0iAcxzHeFcZcOmVj5BnjqE+VwGJe0f6JTXyT+HC1lrlY2b1Q+GFxmAYMhEOYWP7IoYJ
	fyn1pxxccCt7cMXp+2IADMgcYqmng9/p7GOTC
X-Received: by 2002:a05:6808:1828:b0:4f1:6ab6:8fc0 with SMTP id
 5614622812f47-5640dc2923dmr940951b6e.15.1793331827570; Thu, 29 Oct 2026
 20:43:47 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com>
 <CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com>
 <CALf2hKtiCaiabDQGpm+jzy7VKgMr78eQTKGsN10aXp0JfaOhLA@mail.gmail.com> <CAAVpQUA3meY_3XbXsj_OG_Gqg=b5+QA6DLuMZVOmTVWHudcjqQ@mail.gmail.com>
In-Reply-To: <CAAVpQUA3meY_3XbXsj_OG_Gqg=b5+QA6DLuMZVOmTVWHudcjqQ@mail.gmail.com>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Fri, 30 Oct 2026 11:43:36 +0800
X-Gm-Features: AclHuK9uzyamnI1DHE0ezUsT0aKUIET85yZcntstyXolaLghDN28rTlXES-UeSg
Message-ID: <CALf2hKsMY=huNEHhvrAbY_ttWAGqHZs2KWZ=F3v-akPjtjLiLw@mail.gmail.com>
Subject: Re: [BUG] tcp: cross-family IPv4 option echo stack overwrite
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, ncardwell@google.com, 
	dsahern@kernel.org, idosch@nvidia.com, brauner@kernel.org, 
	dhowells@redhat.com, lyutoon@gmail.com, tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Please do so.
>
> I'd keep the original author as Eric.

Done. I kept Eric as the author. The patch is available here:
https://lore.kernel.org/netdev/179333098042.3327.6001182207228154005@kernel.org/

> P.S. do not top-post on lkml.

Sorry about that, and thanks for pointing it out.
