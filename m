Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049762E975E
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791153454; cv=none; b=u7HCMKwW6k7GfdoIeYO/9FmNnD0UUgvMHees8qZKtwQ+eePpuVFCWn1MvCG08RrCTVJ+qzoIOYDWEPXAnmVavtZ2yXfs+jEbxOqFajf3A8fiMJYthrq5rWKiOz+YBTHGej9smk0x8hPhEvO3G9Q56M1Wq8+e+hBreFXYBYj7CLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791153454; c=relaxed/simple;
	bh=rrtiHvr6Qi85ugDtyX9mH/wEknkoCJhUTn0imeTAwHM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PZJnFkQvNgN88rkSH3FRg8rloRQzk9qayS4mWj/mtWDgAcZH4s4fZtk7HMzb2a+9fOgm4NmozMjcrg4F7cnonOxEZGLs3YlDD867Qt+g8mYIb+GX0On0pZ7/prD6T8JdwElXSAz+pCvF3Keq1GIk24eVr2oE6bG2eUsShggqYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkDSkUxv; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkDSkUxv"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab445ac183so9186387b3.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 15:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791153452; x=1791758252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZiXoVAS0knVMasoF8E0Xd59e4v3gxi6qnyKSg/X785E=;
        b=pkDSkUxvBhP1xw9FXHObaXXe4hWyGrfBVVyDBFILE31DcqDqqw7zGfiE4n8EKgINf0
         7JprkarS+q8y3LM+mQgBI8slMKT/6Dw6fzYLWzFdkKaXG5XGcfcV20jy8E/K1KTVG7ZU
         5RQXvd0iQEcer+NZ7MFW9j5sImRsPlQtcgcwFXwCPm8/aHeo7iYOV9ke5oufd5w2vWu/
         TZ8NP2ymsG7DdTkYpaaEM46vsdzEAwkL189SMp8UqEwpZTyLWAwArG2i1U3J3woKZc9Q
         2SOchdD4wRyyIpAsq3zN6KiswZWe7Fnc9g2zQkUYYcSEM3nl1sS23zzj/I/jSKszx3lm
         3Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791153452; x=1791758252;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZiXoVAS0knVMasoF8E0Xd59e4v3gxi6qnyKSg/X785E=;
        b=DPYEhWVGTBSg5QTJG8rcdX3A9tdn7iD1jO9MM5AKmW2FwewKZ2fxqP7BTS0GhhKsJW
         DolH1nwAsvXh4mjnJPY2SXg4zZdUssv35fGBuDcWRLox5K3nD2ClEb53YZc2t4ExbPiP
         fFJ6o/7sfc65gc4njQhAKzFRWjaCxdJTrgwoHY/g3hFIXaps3Nu4ua9wCNtTcOCN3GFi
         b2KASo+BkOnS1PF1aHkrQW93+qbTE5aF7u3Icr/cAdCYGqG9OH05P9a1fxG0El7Qfm81
         yDfyDC4vuVD09/VELKGtfYaXqmgX9ldE1kAmtzTyVAFvcxkksLCvrQZt+Bm/mfhOL+yf
         8UzQ==
X-Gm-Message-State: AFq9FYLtI68U/iPFhIRy2pAZfKjXIoq+J2ye2WDsLrlui4HZ2qEEtXb1
	WgixDHTtvY0uhFkUt0k4sGoX4gcTrLrCqAQ9EcCEP14yFt75+O5Q9wPO
X-Gm-Gg: AYBFou2lswWCSl9cUPnrWCB81np88/RNeFzDSkVAwtzguoZhqWEwLGzmkZSgIzLPPQb
	q85pHsSldJOF/U6F0wAGC+peBSeNlIyBhB21UCbqTebcAX2UXiiA1WEISIQWDi4O6yf+Mt64frr
	JcCj8CibLs4XbkoOnag1au6H/HZo+6N7YcZVcfCVzXRJhGe0raohBzfkwMKTumPsfWoqrQI65oG
	En0bPusVdO65d0cBtyTSUfvfhvCPU0/jHpurexX6/Jr0NftSykIUqgjVxoPWyi4yetGEScWE7PH
	N4Q6/3LsknP6C2tD3xIraw4eTJXv19nPIBosubKnIbqwM55KL0sumoFHJXh2LEk5+3Rejr4SiNS
	rTiGQJ7MvAGD+nAgs6smua4fzazV8zSXkSIcKMPegfzzxjkj/Z5BSxClnNeG+fMante/hoQ6zr/
	7HsheS7SkU/WUQjQJQAuLy1eyI1pqRe0zMQuK5mfduW3J0gBimQDngJ2PikrC7Utdx7BsudgRAr
	P9JUFB3RbNrvky5TxPz89CCS3+Kxk52iYdvmj3Sj8ZKR/ekOZI5/A==
X-Received: by 2002:a05:690c:4:b0:89a:63da:cbdd with SMTP id 00721157ae682-8ae39c0cd5fmr42621997b3.35.1791153451850;
        Sun, 04 Oct 2026 15:37:31 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8aec11be77dsm14260437b3.39.2026.10.04.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 15:37:31 -0700 (PDT)
Date: Sun, 04 Oct 2026 18:37:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sinfo@kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 daniel@iogearbox.net, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.27d5333494a60@gmail.com>
In-Reply-To: <179113469733.1402591.8712402637621399147@kernel.org>
References: <20261004171847.186954-1-willemdebruijn.kernel@gmail.com>
 <179113469733.1402591.8712402637621399147@kernel.org>
Subject: Re: [PATCH net] net/packet: ignore timestamp bits when testing tx
 frame status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

netdev-bot+sinfo@ wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

LLM analysis. This was flagged a few times in my internal reviews.
I don't immediately have a good Link: to an external review.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Analysis only.
