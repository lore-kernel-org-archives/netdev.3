Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D24A0EF3
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265271; cv=none; b=esn3SHydJmOMtC+5cZbKUw0o8XVv4hutGoe4TtsrsmQenHmXtEU02SukjimfLDrkpxIue0LGCblNHuaMXjKI4Dua2hMaALRguJQfcVDPzDrQOc0Zc9OZ/yIet6Sl0WTtALb+u4bEU98if8M2QfLMD2k+ojw0ZuLfOfvAj8LdWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265271; c=relaxed/simple;
	bh=BAkQ2U6Dgp8aoHur+vjQIurqRFLJ6nuDA+/I7BXKXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4xcAszb9F4Vmuux5Ha2gPJDNA+344PzN4unShH/MHJw82zBxleB0fFOPKEqwwmvnMa5IsLBYMAq1kdIiDjGvjjS/n1L3OywpECEXiefNIuZN/HKTlplPK4ZLH0t68PLjuv2+S8KmZqV+z2vMEGJHf+WEq8rNAaVVo5PnpXvU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWY2aCxB; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWY2aCxB"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2db1be98255so13052145ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265270; x=1790870070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FHI7px9tREpEQ/rqg1xo81x8XQPKrvVBlshNX5vePa4=;
        b=HWY2aCxBrRZshVUAJVYxR6qxkFUOdkLxzSHoAolfXFs37H/UtEVdRMC548VQ6BXpxN
         3PWmoPDZ6WeqII46Efu6wDzDuGGlky6V9PO+lQonjlYrSsOc1AL7Q5dNivmIxyAY19fw
         Bn40hhGXgVLglxPReLsgCIRI2nQAhp+wPJnltF4NRCIa//z0JjBajDyV8HazwFQLk/EQ
         QMDla0IrfqYC8mikSSMexGpm2ehcpubJDX0nSmMxpVXu1yoONHn/j561UFuByHJTLiHS
         OYIMhH5ImreSt7+CSXNPaqrenAstCk45vkloJvOVxI8v8dPekWqrOpodq8aXFNW1GTU3
         XQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265270; x=1790870070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHI7px9tREpEQ/rqg1xo81x8XQPKrvVBlshNX5vePa4=;
        b=kbA/1+zpWgGrjLWTaO23L/2UvUOPJTdRjlRUJM0nCZwQpdbjuj2G6TIa4MvRrW0V/3
         /WQxobrhayzbfIl2pUWlIdbZdI9otKnvGahE50yhBugdrzSkjGjs+peWYgvKNfo6H1Ug
         TM4DuYVz4djv6z7XIOJdAQBs8Uotqx90q9cFZ5iPEd4+2O4Dmc/D6gNEH/ot6Ast/8LD
         hq2exRcYFl2MqZxqXfWLeub2x8iLNSUKGuuer/Ds5mS5wlVRbxxix+ZgtpTxMPctcCPH
         UTL/B+b7PCD1RR0dE3yqqMzCUSVUWTaIxD8anY2o21Tj83lycmTJTmlOblX3h/kNNKjH
         zIWg==
X-Forwarded-Encrypted: i=1; AKwUvBxu/qSkt3o7lXJDEWgeRA6gsfiHOcigbrX1OrKV+ZCs+Nh/V0tR/ChYJnTPhGrS3wwy5otDt+Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nQIbYNREzHW8rRwEoTCpaVvCJpufDDI8cxFKD9W3CnnujUAHXW
	BVHcedVZ2R6klN1E1WxmkisimkC4G9F+Qp4q10aRkjb0yEjMJAlJvlX2
X-Gm-Gg: AYBFou3d762ewYKCSGiRWKrb4qJFvduayIYbfwe7IVQpYBsCOW31wxNI4tfEzb72sCG
	BCwYHZWMmLd3aFgmSuWhcKK4y2tUWxciAj2EgPn9mbIbuJu/xuwbQRpliXug/hCecsE9XOD3o+p
	7jBDcLgliVePTzPaw5e+wFB+Fp5JWyXyOzuqU2JjfcDHre6MreuGTsHtKS8XC0PdkflHVV4Kzo9
	YUmXBU4nPSvscD/8ZXbn4Ra1Rr7YNURGF6WJ3fQABGkmM5PyJwcigjU8RXwVdIxU5T5mJRtXTR2
	w+Vzgzyu8SDydiWCRGg+8UpbZIC/5/EDP3h8lMWnCyi52/WLV0zzUI8jSBjX2zm5OoucBCpFj0Q
	H8GQNZECkSCol+Y9PObl29Fp8YDsHmm9y6a3eeJhDtDomwl8pwcy/5Pma4r8HMSPHVJZ4q0d+/F
	OIm/XI2vPvrqyOIcWzYwXUCbEDU834HFXd/Y4nCpX/j8gY440DXA879fX61nbN2+Vmd/Dd1+yH9
	Q==
X-Received: by 2002:a17:902:ccd2:b0:2dd:c100:943a with SMTP id d9443c01a7336-2df7e65e22dmr25503715ad.56.1790265270026;
        Thu, 24 Sep 2026 08:54:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c316bsm30074495ad.37.2026.09.24.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:54:29 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:53:57 -0700
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
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
Message-ID: <arVHjxxCfOm89WV7@devvm7509.cco0.facebook.com>
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923213719.224838-2-kuniyu@google.com>

On 09/23, Kuniyuki Iwashima wrote:
> Currently, four bpf_tcp_ops callbacks are not allowed to call
> bpf_setsockopt() and bpf_getsockopt().
> 
> However, the deny-list is fragile, and when a new callback is
> added, we might re-open a can of worms. [1][2]
> 
> Let's convert it to allow-list.
> 
> Note that it can be written as offsetof(,X) <= moff <= offsetof(,Y)
> but clang can optimise to similar code anyway.
> 
> Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.dev/ #[0]
> Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux.dev/ #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
