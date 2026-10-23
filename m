Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757991;
	b=PuVFBf3wQAxIzToEpUYQTd6SwhRlw1Mp4C6fnUsCa9ZsjcVGeztIuFsqwy3C7DTccFlE
	 Ke/0x1aPdVy/pTJNzZwmRFeAevejhqOw096SX44lBzpRa8xuqCs9MThimdqCaZocOTde7
	 MN/luCn0/CMELMfL4LfFCRq9fRO+hIEnsanVWJypiXl61aA1NmLqnnnMkhNgDK/n5iI8a
	 sd8M/s1svxCD4yY0P8U2oUwZD3MWKj4kTzGfUZuoYvcRvsRnWXxs9V8TrktPhcy+4FD1Q
	 XdIUCQwtEW9FS+H0vUVWJOFcWO7Vz4Kl40iIPsd0SupTNb2SIlq1z11YabvAMFDHKag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b+XymWLVoX8vB68R5CvHr4Z7XFy3vIesV9wzBrMjA78=;
	b=RDZf39ICCaxM/BXKD1SsIWXzgu6oNz2IAzBt8RLN6igVXqH6o1cSuabrpkEyGpIZqFdl
	 EAV+2gMscT94rmsXgcTih8LGpaR5wIXH7lLG8BEPuQVzMR0cYkPvR0wJgu44kkhHaQNQL
	 iQ7e/ErCOOqakD+QViGpFHw+HmDUq/oG1bKoW0oj90BaHyTn8bAAOXKwcq+ry5nqKfZGZ
	 RZUT2VYtB2hLa0fGAM1Nj2QLruJ9Hd1c9fkkXP6LTtQZsK3qThXHZvATxuELlQ9uX7Zle
	 FU0yodJMetzIA+oA1ydbPASvMu/aIaFAPtJkZCyp6Nkc1DXK09o1fVHt+fU2ZCXydWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D4Ww5XBc;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6638B606A321
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 12:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6638B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D4Ww5XBc
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c46822eefb6so103682466b.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792757990; x=1793362790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+XymWLVoX8vB68R5CvHr4Z7XFy3vIesV9wzBrMjA78=;
        b=D4Ww5XBc5qWGwgQdAAf7AJ+qkyPmCuu7N4V1KBARpvyAOtW6Fv9EZMduH3qQ4f/fei
         jxbu71Ig6rhKDGbzs0II4n1OJ2sBivQKFJRcxJpBIWJXGU8b/acm4CxDOkUZDT8LpYJ/
         Ry+Pgd/w0UTxfRZmg4N5IAezNG0b45gZCPFR1oLfcrWcIRRv0Fnh2ODC26oCLn2j2fNE
         w0duXd0C7Brjb0hQO+3rGqbZz2ocmA/CVt5mWLWQtqClzx80xzOUEYr97cK73CeazsHN
         QtEAtckUqVTUlba7I9JaYS9/n/ngyIO1b+Jp5Q/aPlaT3HvvJCt8ywWZXZOwCKmxhN96
         KHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757990; x=1793362790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+XymWLVoX8vB68R5CvHr4Z7XFy3vIesV9wzBrMjA78=;
        b=l1GHnBkfyJ7f+34xJeAq3fKMxQB1yI8KCzOmtoqufZUXoCVwD+MOnsKMjZZQL8Do2H
         K8JIc9zQ1RZasp2AltkXEAGo7IbMTOb2ZRxpLQ2WM0Fy7nVj/ee1q/HJ88zAUypOeEu0
         rjq51qOE+yQA513St6YOFHOScO64W7Ft4fUJaQl16oJKxPs4DbiiICCg0mLutfzfY6QR
         Orcg6vNtZyUNfn0o7fmcsLNRaBgnqLpTCj0nEXQT4dxHZABqQCRPA9lyydkX2IKNlFIE
         8blb0lKIceCI5SnXpQbCmVpTg7+vlpRxzqJ1Q2Z8+X690RmvfYJu0/wei6WW+cBWYL8Y
         4cLA==
X-Forwarded-Encrypted: i=1; AKwUvByd0NWJlmxC6pkKrSpaBGzjo2YcfmEHSo3vwrNbqXnLnYO1rvwdnJHfP+YtJ+BOiCeUCkSJ3po=@vger.kernel.org
X-Gm-Message-State: AFq9FYIc5bT7lXANao1TUhjfsb3UHqeGyiKb7c7kVHfRfA5SEldE9Opq
	mvtK89P7cjMAL6WTPs4Uni/ZctWX46IH6Gic4IQCl2EtjbXj7VO9d9wi
X-Gm-Gg: AYBFou3rSW/DoZYov8ZBKI3EgnzUiYZKYAdeTfT7p+DBvEEjjyIoggV07pHxUT/1LrK
	PX/8LA4FU4Y5klTlo5043dv4qxFq69lbLewBsUUggsBam8BVthmTHugILOwrVf59gCeGYB3orTs
	hVDjebqXG/GwFR0WGOaGOThHrXo5ym5vIdJHqq/Dw1XT+3QD8VNqd2rFoXThplOQeVda84HVPvt
	cvdqkBTk69aNh2JUPlZO24uVKPSBp/PflHapGWVEM991an9z+Hagksjpxdc3KdrvNOIvbTpEBMT
	WiInpN0Vc9Owm1LCQ+HZk0nNCQH5loDN9TD+5/wrShODTfM/ldx7agpPuJxuqjMzSqAtDDXPoaB
	ioO7HvE19RhTH4aviFGeB0CJeSzZ+SFkU60LI66oYFurhAuxXgPDbV5s6XDkxnwPgljGvdPmFfJ
	jD1oljh23iClW4HNbblIZFa0TFYU0TyvqzHTQxqMI9mJ3u7V0Bnm1VhE12VSOsQA259Rf8+AOLt
	5yf1tWkK2HIFe4aAkHUkCv1A3SQmL7jgq/7qBde34iB/gARoA==
X-Received: by 2002:a17:907:7b8a:b0:c2b:f3d5:2090 with SMTP id a640c23a62f3a-c46a9039cadmr303485366b.27.1792757989570;
        Fri, 23 Oct 2026 05:19:49 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5cb7fd2sm96847166b.61.2026.10.23.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:19:48 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>,
	Boqun Feng <boqun@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] lockdep: Keep dynamic key hash nodes in lockdep-owned storage
Date: Fri, 23 Oct 2026 05:19:46 -0700
Message-ID: <20261023121946.2260882-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ef57e0ab-f0b4-46d6-a2f8-f6c97fec8d8e@acm.org>
References: <ef57e0ab-f0b4-46d6-a2f8-f6c97fec8d8e@acm.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 10/21/26 8:01 PM, Bart Van Assche wrote:
> This patch introduces a new hard upper limit on the number of dynamic
> lockdep keys. That's unfortunate but I assume it's not possible to
> eliminate this hard upper bound if the key storage is owned by
> lockdep?

It isn't inherent; it comes from preallocating the nodes the way lockdep
does for its other tables. Two ways to lift it:

1. Fall back to the embedded node when the pool is full. Keys
   registered after that are linked through their own hash_entry, as
   today, and only those wait for a grace period when they are
   unregistered. The key stays at 16 bytes and there is a second lookup
   path, but running out becomes a slowdown instead of lockdep turning
   itself off.

2. Grow the pool in chunks allocated outside the graph lock in
   lockdep_register_key(). That removes the bound without a fallback,
   but it is the allocation Boqun preferred to avoid.

For what it's worth, keys whose locks are ever taken already count
against MAX_LOCKDEP_KEYS (8K classes), and the default pool is 16K, so
what the cap adds is a limit on keys that never get a class.

Boqun, would you prefer (1), so that the cap can never turn lockdep off?

Thanks,
Vlad
