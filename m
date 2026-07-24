Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBF41D233
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886026; cv=none; b=owsrfHE5Vf/6cSd9t/jxulv30xIsyuBn9xgktGcUK1W4HtHQuYVpy2Agva9kzB43qmYzG6EEArX6VhdLhaWxvVxUbVxLIhwUXvvQ6vZ2FAsEPt6zRHH+SpD4Jbiz75FWjQpcDqzju1kRV901DV98rjC2M0d7xSqqSfXnoVeYMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886026; c=relaxed/simple;
	bh=8nXfIk5k6dh+bgwKm/+Wl0vJSnaFBQYASdSW7R0dNV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H1NLEL9ph+D88/RSdUA/ng2HG9IaqxEp8vDOXcWEInxEv9Fa5nlrwrqb50QH6x9hxLCHghMMl1ayW6FnI/MrFHmXXowF1cWaLd7BHikLfRaE7kB4bP/2eHKQ+Y2T4yT+6OfU3ZDaUIwHIp46SoGC7Wyh0ORFEqtlZuo3OpQyYjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KV8889/J; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KV8889/J"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15c42a45adso194114066b.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784886020; x=1785490820; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8nXfIk5k6dh+bgwKm/+Wl0vJSnaFBQYASdSW7R0dNV8=;
        b=KV8889/JB4eIpH97s8HguSvE/ERktzfHkYFlN3U3LmmJOkf9Mc/9+X7Z9wxhGnbarZ
         nPQYu0n0oXTNNPG8IOrsrzW6Imq16rzEQnnRataBZLkjhGPv7SSzJFc6xv1gNAn+XhbY
         uyQwiVy0ywFe5vY59oE/bjQs9BUqE3e29TeNMmr+PbDibF7OtrO37wpXZ1DoVMj2hmNg
         fe5Va/zkRPZdLsoRMSmb5NOgrZuPy2VUWLJASeQPadiJ1dPIqRl75SWbg0Hezab/iM1p
         jmAYmEImmZkP9Cdxm5WBH9XDOrMcQnSpUwPh6P/E9zdJLMVJVlFmdHUpSNXKf+ug8XhN
         eklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886020; x=1785490820;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8nXfIk5k6dh+bgwKm/+Wl0vJSnaFBQYASdSW7R0dNV8=;
        b=K07o4c7BK27NtOY2vOIuNuMQLAxd/QCjWKwR/Vf+xiVjfOPvYEKOEG+WKergV18Jx6
         CYeG74ZlttE3rMqSduCE+MfoSSz57EH46A++TuwDIsdpF3wtq8ULrszllAUD/7WhwaTe
         WDyZfrn0tAkH8BCToLhCmibjxnXIj+/ei+eP6ibOrKBEyBk532MdHmBBRSBXBq9BJasN
         AFR872YFJCEtRHe9lLpymBZRQjpx5lCv7ZFxv7h6CFrqlXnpZB2nbvvajdbw5dZBFBcl
         taXgyZxVlFIvEkkJNULh6UsB5tHTYSwjQWH6VpeTmiUzUZQqKTjrWyWXy7t3zlUr21Dg
         Gl3g==
X-Forwarded-Encrypted: i=1; AHgh+RoNz/XO9fkPfpQCYBV/YRbVgniI+9AbCHLAV88XrKURr9OY7z5D7h4nE2D1JlanI/UptqHv5JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFW3hWR+Kg4O1h/nLmbHDWDX75JPTnyrFgoZdSPuPAw8/Dor/9
	hQU0Mds/vbH4g6LTFbEOjqhZ4EbFQ6cNE0sNZuXGIRECD6vc51FpRciKXQlJWXAVvmU=
X-Gm-Gg: AR+sD10s+0N0XhaubrZ7gTgMEjwY6lLoeacpQ4TfKH7O2R8p+wPmFC7kVFC68Frrhul
	+1JQbEpxJ35zsnEjs8rxd/gkcgK/E64RuSVT4pls7RZeABz+FKG7nO18Y9HDfgGxdquJka8CJF2
	GaCL3ttTF9F/K7f0731KyG+8Mlna5UbfxUtM0zhrU9Pyp/ojEgi+UWSyobuUOUEQMmR5peZ5TvR
	i0Dsc60QHCBJNB/jJYHBIW769hAmE3R96FGhZmb2T2yuUmF9m8WXu3sCr8z56dkAv0JYDHZnYOk
	D0HSzqc15fWToabsgX4IN4b5dS/YT4qsY+w1zR5xC/qKw8csCVgrlXPPTw6HVPtPwtjXRaBbujM
	KAubk7pgL6j3uOlal4dJkfbUGaieTqZG+b/TAJuJVq6Rdgb0vIv+jTGraGcTKMQY5C+U4of9CA5
	H0/P103ucfHowGZt8=
X-Received: by 2002:a17:907:3e0b:b0:c15:dd1f:f2d with SMTP id a640c23a62f3a-c1c53813397mr256387466b.25.1784886020370;
        Fri, 24 Jul 2026 02:40:20 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a7861esm334032966b.10.2026.07.24.02.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:40:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Eric Dumazet <edumazet@google.com>,  Neal
 Cardwell <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  John Fastabend <john.fastabend@gmail.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
In-Reply-To: <20260723100030.3eee6d51@kernel.org> (Jakub Kicinski's message of
	"Thu, 23 Jul 2026 10:00:30 -0700")
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
	<20260723162602.3275661-1-nicoyip.dev@gmail.com>
	<20260723100030.3eee6d51@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 24 Jul 2026 11:40:18 +0200
Message-ID: <87ldb0lo8t.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 23, 2026 at 10:00 AM -07, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 00:26:02 +0800 Chengfeng Ye wrote:
>> Subject: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
>
> Since you are spamming the list with the reposts of this could you
> please add [PATCH bpf] to the subject so that netdev CI is not confused
> into caring?

+1 because we need bpf CI to run sockmap selftests on this patch.
Please point your agent at Documentation/bpf/bpf_devel_QA.rst.

Contrary to Emil's ask, I'd recommend fixing one issue at a time.
Reviewing multiple fixes crammed into one patch is harder, IMO.
