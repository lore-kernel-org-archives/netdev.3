Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253004C10FE
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023815; cv=none; b=d73bd0lVJrgmVMrBT2Zy7Lo4eueuVKQ3lEYkjCUrU5+hkqS7GFPFCzmn1xAn4KEVMY5jqgMmCNPBEvEW6mi7g25klMleva0nWqDGBL2qzLxx8FLqHJNRjXYScmsiYm6hwGiHko4FxvuhReXyxzLIA1YMlD6/QQ846L6DSjxb5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023815; c=relaxed/simple;
	bh=zZDP+BUxTYverF2YsFJcsQhL9mL6T7bJo9J1gf8XrVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVDEQYVJH9VmGu+egGGIXBjj8THvcx5g86AlUWkjWOvTYybViqpzQlLu+F7NoE2c6JXK+TMGIRp0Fvvh2/BWqtncJOV2hN6Uc3mnxNADLf4e0hk3woZPVNd25dKGS5t4w60ybrz6qskp3SaNNWvbTtNsEOKamO6uLgxcRvlfKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGtYoiVX; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGtYoiVX"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d942de6574so30156065ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023809; x=1790628609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2GjyH/smBenoTcMmVaPg55qIuCzt7uV7xXBVHGA+A0=;
        b=nGtYoiVX8BXQYMAiwuZ/ZFYU5DkQIsKnoPYyZ11RHp2WfMz5Wn8j+6iXogL++5UsX/
         VK+F0CRv/j8q8Tc5H2BR1vRRHdGJMwlz3DMJMUtEEliFoP0psjhNlF7qqY4czweQxdp1
         7bsT/iFkIFgs45FcL1r6skwH0vudgNBDWAX/ALosHXFvY15P3izuwelLrciP5rDvgFcT
         lbuX7Y0XeX+iWRGg+onZqjmSDFbB6E+JIA+cExc0xRXrSX+5D966HHqcBtlGOY/vOtkx
         6erwK5W+M+QZycYO9KjEW5IfS/3SswFr8/XaAonClUYRCIjRx1/YjLQc1bnQqTuWwNVY
         lXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023809; x=1790628609;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2GjyH/smBenoTcMmVaPg55qIuCzt7uV7xXBVHGA+A0=;
        b=hDNH+0bMa3An6NwOb5LhvF0td/LaPLUUvzea3WfcKEmob0hy5W9T1lPyjeKDYkh8Ex
         d22M6tu6Z4QRzfzzEdBGk1uTxoOe11u18H1PcYx4uCyoCS2r4+hax1T8xVNeDYBEbjFc
         i1PrnKfBTv0eGFkxmALVVi4vRadbeVC42WkAddE2AgHKQYD9KW+WH6TFlIkb+K8llExn
         HbDEA4WpaT9GTQ05iBGl+f6/T/aTsqJ5VqULhMYWaSX0zvCqqyGGGrYbeQsUowZPg5WK
         wczojA4VlTt7Q7D5jfbrBvAs+v7Mtjj8P3Fg7q4kBeCHVI9IblHKsSzCzTqgjVnmvbqP
         reQA==
X-Forwarded-Encrypted: i=1; AKwUvBzE0iG48LPFlQntra5pxnwVQ/hq0BGr0lBuhQm0nKjrZ8qJ/0KgjLwMPENuE3pB/5yHzfLqBNI=@vger.kernel.org
X-Gm-Message-State: AFuF++lE5DH00PXJaGibzWEY9W14JsYhMyydG0fceR4VfVBdmRWSPsyw
	Po75g8YAxynIMd8fEpYd8488dgoxzfO/Qnj9ZYhP2JlbyxRRu++zzgCd
X-Gm-Gg: AYBFou07eoE7XQEMPGKqqvUK4HqBqMXWgEJOavUuMTnnTivaSvZN7JM4RhW1KHIzhck
	IjLddDgy9Q3XDXE6BcxgQJ7We0HSj1707tN2WplR1DE32r5UcNWhBUCflA/D5UsqyA8tfy4gUDj
	q9vhj+Qfz1LVgOee8FgB9Wuuzjd9Onld0zJ8GMWY38QmY22QkyE7h9lzJCOYr/QxHvXoatD57em
	UnC8ri8ooGA//MTc8up6TT+QG3tvT0Pt3pr8fvtvMFSfnXhKcHpDwBnabJZ5rI+fFH02wTWxsta
	Ll5gDlj97q6PtTKXMiWe5eBStmCFtZlVefsICyFjSyAxXR0xi4MuKbe3D5cEWOvPKlQEJgrpQr4
	aayVOsJw/3M6is0cdaWV0mA0ixsnEowjYou8KbIR+mhpW9SvF8ypdc0dKzxSFzG/VYrjKuTdUdf
	5/l/7ED/tDTPLHN5xQvT0rGHmWJ6KJdNOlmHzGpx6CIXZgiUtba6uTB/DmS+gf6T5DTQ==
X-Received: by 2002:a17:903:2c0d:b0:2d9:123c:8c49 with SMTP id d9443c01a7336-2ddb1b9a1famr181080635ad.14.1790023809022;
        Mon, 21 Sep 2026 13:50:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5b8075f8sm472845ad.83.2026.09.21.13.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:08 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:48:06 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/7] selftest: bpf: Use
 BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
Message-ID: <arGYABcr0mfrFXoX@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-2-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> Once bpf_sock_ops_cb_flags_set() supports a new flag,
> tcpbpf_user.c fails due to the hard-coded max value, 0x80.
> 
> Let's replace 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
