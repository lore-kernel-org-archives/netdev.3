Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361F438003
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620863; cv=none; b=dgl5AFZJD3odHm6WjWKTQrI0Hgyo0AIe3sAK6wmuCR2RQ1On0AiSPtCeI4hz1lqGT46IDJzjfIA3bLjLSfSht5SmFLxhdl1JNl1BBGN7anDA1CzlgwnZbTCS+vj322IfoJiYYV6b6pq1CTGYIGI0Pz9qEcET2J9lch1FDauqlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620863; c=relaxed/simple;
	bh=yq5AesY3WbJ8Pgvq1fyy9I1ZZo28UY1oxpCoLb0euC4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j5P9d1ied06dLMAnTqYB7X5hm5p4t1mW9ypmsH1yW1BP4kNEsW6fcYBrNMRT18ZM5IQWW09j0bP8dIzBNpLhJ89aqQ0IJa94yEdA0DjeD/qigTwKQOV3NAtFjdyL7hc8w33yJtts6IZgEg8+vJYzh24UbA5pq6eDNbh2ffl/JuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtvOfEnB; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtvOfEnB"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81ed2a00f12so85076927b3.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784620860; x=1785225660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e3R4qRYczJBnpWuDaBta6gvyeC66Rhl7Tf5bIRt5HKg=;
        b=QtvOfEnBVOjkTO7b9XsQMEvAd3ccoBj4nXQv6eaZL+4+9TVD/Rn1+M1IilNj0F6jl/
         DP4i9+dPzOtT7Zuc9TYRXK1dhKNEfABQitB0C+7R7PMl8f096c+Z60jwWhk5gldoUpdQ
         53JsL/3oZHyZ6vrvvXaDQnAKdtY+SRy0VFjlv2uswy91ubXPY9D+3R7FLoxbjGCJyEJa
         SumwAUS1VljWQxDg/3hmP8QJ/nNGSBGR7nRVloC2ZS18d58YIWCDU2PmclgSDxooOgiE
         IRQKHgOf8pIZ07SV1GwNmouhIXu2PBPfVXMIQABJIjLGhg/4L7n0DfJHGTgAy4/akhPb
         1HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620860; x=1785225660;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e3R4qRYczJBnpWuDaBta6gvyeC66Rhl7Tf5bIRt5HKg=;
        b=gJHsEjlYpdKp3pyWcI6ToQzoRzuFBNEYaYtJrsLXYmg524+hcgFfoDYQqeyjXGmHvE
         8sabrg4xDA730I7SOnKxXJAh0B8gn8YnIAZixBLF49+Axrcexb2+l7SnOft9zO3EZGJl
         wkbKOFU43XsY99iB4HwjWvbGtB9A+XTGXfXsHDaEek/KwH4sj9njdaGHD+ap6q+sWf3C
         wa7rK31NwyM96SwhT05m8GCGJ+zOfppOaTjOdKtE71xXLBB89p6w/Genf6PtCSQWbA1y
         Lp3Sqag+rf1zGVivrfdfJMVG+u49qejm/iY8JL9uhjTe8e4eqs8Ix4cFQQMS0hPGs7ZN
         kvkg==
X-Forwarded-Encrypted: i=1; AHgh+RpuNT7rk/jymLO+GWeDfG6cufxVQKm7/fizt71fjQEEW9Cnfq1RwK5/Vwx0YredfbVD/n2s97c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoFbku7XYZ2rNRKGFruDnHc+8LrCiR55Bfy9125SVckr2CrDw
	UDeQ4O0TBurOx1aLS+U3bimAjMu1hI5VWmNU4Hmph5XfkKA3lOQ2tMNf
X-Gm-Gg: AR+sD12J022mGAxViANDvgC7UJ52xHwuYrE9Lf2LrCto51WKtt/37LGpkf0MYS8NIRs
	uvtV/Ek3GCjO+VEtGlv1aqz7pNV4QY7E4fUUh7qfvEay2zLzMo0SYtl8/xoP8yRYVZFWGem54HI
	QPe+RbiejSKzpf5YJ9r+2BvLluZNNqIEYNuHOuG+bmJUlRqhjL2DPrrm7utuJM2XkBw2J4uldrS
	rS6tHARd/Wt9W/0D5IwXNPH2yIW3TaC/I9WhMBNKvQOscK1jwCCien0V1cXwetEISxLgqGHgS2p
	kA1X1r3jymwLsy9SdqnC/X1cqB6W7YRJwkNRQ9mXMvFtKgRtev1t6azouYLKUMwJ8BXBdn23HhN
	bKik2+wN/6dX7Rd5dJoZfIsRgXphFAJBH1Coz3HPVBptxaQuQ5hvF5k9wyBg2BhVb7GeFHWs5JE
	Xiru7f7NLzr8ZxD1tAsEHFwZLKQ8iHXqRsTXF7XiDWyq1osiFaYWfBrYf/1QEue/mh8g==
X-Received: by 2002:a05:690c:3504:b0:80a:9ff6:c01 with SMTP id 00721157ae682-81ef285019fmr59688947b3.53.1784620860213;
        Tue, 21 Jul 2026 01:01:00 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4034901sm59680597b3.12.2026.07.21.01.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:00:59 -0700 (PDT)
Date: Tue, 21 Jul 2026 04:00:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>, 
 LKML <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, 
 David S Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Dust Li <dust.li@linux.alibaba.com>, 
 D Wythe <alibuda@linux.alibaba.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jon Maloy <jmaloy@redhat.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 linux-sctp@vger.kernel.org, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Simon Horman <horms@kernel.org>, 
 Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, 
 Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Srikar Dronamraju <srikar@linux.ibm.com>
Message-ID: <willemdebruijn.kernel.53771955fa7f@gmail.com>
In-Reply-To: <20260714013940.4068189-5-srikar@linux.ibm.com>
References: <20260714013940.4068189-4-srikar@linux.ibm.com>
 <20260714013940.4068189-5-srikar@linux.ibm.com>
Subject: Re: [PATCH 1/2] net/socket: Record preference for synchronous wakeups
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srikar Dronamraju wrote:
> Scheduler differentiates between affine and non-affine wakeups by the
> way of sync flags. Scheduler prefers to pull the tasks towards the waker
> if the sync flag is set.
> 
> In some cases, socket APIs are blindly requesting sync wakeups. This may
> cause load-balance issues and non-optimal performance.
> 
> Record whether the most recent blocking socket operation could benefit

What is the heuristic that determines this?

If respinning, please state that explicitly in the commit message.


> from synchronous wakeups. Subsequent readiness notifications use this
> hint to determine whether WF_SYNC should be propagated.
> 
> The flag is advisory and affects only wakeup placement decisions.
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
