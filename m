Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AD3AB26D
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476123; cv=none; b=pChXuFYjnSC9QVfq/9nq9jIR8GF3am8fJ+tunByRMVq67nlELWZ1/xX28df8ddZbhxYHjHN9LPF3KVeS5PWwtPnAh4hXUTqheR9WyXsjb8xkBdMxlPlL3p6oKdBCvYQfoVcNctlttJnsNDHL07qQKhIy/yNcqskYPudykL1Abko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476123; c=relaxed/simple;
	bh=NtjG5Nw5m1997/9B7PcQY1C38KxBppjF+qQjGWhTijQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTfDCy2B7iyKgZmQ+jCTSUjUzzZD5m8vyyJ6QA686J6hmhq75zpx80rCK0foMuVfFxHPNmqJe2dE2p1dNIvWlN1lLdPWm0ActmC7TO4NXfF4u97DbSZEausaVToxzTFuNj4+pDkrRjqig3FsULNl3oNF7jJE/lqLHUdYha60Tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlmIeHJX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlmIeHJX"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81eff3ddba4so15336957b3.3
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784476121; x=1785080921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NtjG5Nw5m1997/9B7PcQY1C38KxBppjF+qQjGWhTijQ=;
        b=DlmIeHJXO5MbY9WTp7nHuYgbjeU+2obxG5OgAIQo6C6iweCqrOzfEgrnLBr2WHFO+y
         nBDxoOv4jMERB3yI1klFRK6kpOxH35I5iKAps69LnrjZJ6/A8ERNmtHYDPIROrRo79qg
         iZTrKmZvTTFMcDur7DxK7AWJjveC0SJYViKCei+zA+r99v4NwjQMQM/zwz3Nbug77zIr
         6+csbv8GCv7WvXAr6KSfhajxY1P+lfV27ldVGrR83V9pfFEuTZFe90R45tlnW+247HOX
         O5XLCpsHx0+b9H/qiYHel42KLsPBhh6ogQwTEJWy5G4ypj7jGyjuSB+bFEEmDx1+HGj6
         XqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784476121; x=1785080921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NtjG5Nw5m1997/9B7PcQY1C38KxBppjF+qQjGWhTijQ=;
        b=ZxwOTDpq6zidvEWwl07YKK6vHnAlGHjqMN23IXJrPjtPRz9cG2kji6Q+XSdRxNPObw
         xpIJpzx0OlsUoFFjVlJ0J35jNaqR3Qgm92FxpMV5U7laJtZpGpexEYKV+TCHVx+cJGRK
         A4dHNuFuoju+kESHFxmCM7je06TaDIhYOdnzo9pQpSVrn8HRtj5edu+fWcA4RfNHAR9D
         4QGAGz2ttWCnIuvQqops1hkpXcEUUP1NDn7KnDNdzXMxm19uJ+CpyCJ4jqN5+DnRn7UL
         HbiEW6FV5XNLSe1z35KyFgvBGnMYv24FTlrVhY54XbVLv6PSFMz/7OUB4OJzHEkF3VOE
         irgA==
X-Forwarded-Encrypted: i=1; AHgh+RpaYPyfuW+plCPciXFEKZQBTBC3lzGzhZv82qGSTCOjDXcGsdnftlonspKBTFEjgMrWoW9/8hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziwqW+xuVTKw5gmhzv4hfmVD3RwmjlD+X13YNshH/Rj7vfvmbQ
	XC360V8YkbIDOr/zGKNCVps9tIwBfLu1R8A3hckG6UMchYMoM55OronK
X-Gm-Gg: AfdE7cnXx4QnIErh6anlw9nug5cwCMJ0iAsRajR6nMNvRx9PGgEzEeK/XRZUTk4Jg7x
	NQwXfkn3xyuBTo5XRmKZN245hNv9AL+hFKGL6Mre0XBYRy0uY8iogA5UfxVVVYs7EwCwEZNSVDC
	IyddD3yHBL7kAO8nCApgmjmRqkcJ756if316sOgF7ZOYwPCQtK0lrqX/MzBqR61iVZiB1m4zXin
	Qj6Y24BDnkjsFshpZp616NkZsbsULvFnXtq1P3k12doqQ+nYYM0nezh1rQnxw5CWUaEOXFGU4uP
	FTHsbjf7dJ3u6qawM/3pW0nyybaPtnVOoY3tGThd2ECrvzy4KybP694kKOLGx1mQvGWu16sTnr5
	V2Lk2jIGlwAhBYHaDZZisWognJTn5eG7E5x639SM1DyQyom0vOVBRSX/pHdWvzQ/y31YzMCQv7F
	lqP3N9YxFZiD8k9mpuplSobGVGbZyux5xcGSRiYsylsHQu7v8/vlcpFswhM1cLBF5rCnhhE3/XS
	9ugUj0DlUKX8Q==
X-Received: by 2002:a05:690e:4813:b0:668:434d:79f8 with SMTP id 956f58d0204a3-668434d837amr1539118d50.109.1784476121006;
        Sun, 19 Jul 2026 08:48:41 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b80eb49sm4769861d50.11.2026.07.19.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:48:40 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: achender@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rds-devel@oss.oracle.com,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH net] rds: tcp: unregister sysctl before tearing down listen socket
Date: Sun, 19 Jul 2026 11:48:40 -0400
Message-ID: <20260719154840.6830-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <259284aa1280d387c413cc34fa5e4b11ad28379d.camel@kernel.org>
References: <259284aa1280d387c413cc34fa5e4b11ad28379d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. The KASAN stack was observed on x86_64 QEMU/KASAN.

The full KASAN report and C reproducer are a few hundred lines. Would you
prefer that I include them after the --- line in v2, or reply to this
thread with them separately and keep v2 concise?

I'll prepare v2 after confirming the preferred format.
