Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B92BE05A
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785623618; cv=none; b=Pzx86oXGPzyFgh5ejSR7axXRR4l5P2Kfaty4ezEmetWKsfOoj9N24Q/zUsBtNO9F5u3IqIVlX6HY4zbQH8APddKE3Xcuo6SwB3v42RdVzPby9OstqebIwb+IuMEPGAZ9b/2fho6CICswLz+GBw87jfyk/yVxPThSnDdubjAEYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785623618; c=relaxed/simple;
	bh=G+LtcF0822ze7+hUeyMKJ83zwbyDrPlfTSSC5mxVrV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaxHA1u9mISeGhuKvbjhq+ApeGSpc8k6ygsDjdZXf5HGKc6IdJhPOz0WO/zeUS79A/N3uuscXDezEHe2iW2lMrFlVDr/nF5FFsvmpyd0pF3/ep9E86XD5dLEVzoxmS3gT2CPmCBs6sZxGCQFCG1eKS7z77lxi6goRYJ9HqtZJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXLIJimm; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXLIJimm"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e67555e24so105694885a.3
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785623615; x=1786228415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+LtcF0822ze7+hUeyMKJ83zwbyDrPlfTSSC5mxVrV0=;
        b=SXLIJimmGeDWS2ucnK2l+6D+UPt2Y+AXy4hHJCtvJi5qS4fh9RBmON4R0UikOYfmeb
         XpRPkHhccd15dUXK96QgjPWHpDsM+RAboPSwFqeKt2bDLdSaRIWrjo9QFDUr0vGM4gmM
         N0fJTOPY+UMaoibWy+fdJIaLd0J6a0a+lc04n/yX9E9cMD0vBfyashpy/7M8WPQNsgjf
         XkaDCIXXhYYbsB0v5cDL2R/u3/d7W5FdHKym3PpRy8X+UMH4rMG/ymhQrCTCiy45QqzL
         KZOPM8Qkv/g3deO0HI500GQNUasCHfb5XtrqADLh6N8tFb+V0DrI9KqQeoYB9APVCBzD
         3F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785623615; x=1786228415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+LtcF0822ze7+hUeyMKJ83zwbyDrPlfTSSC5mxVrV0=;
        b=EHcWb5FZw+SL0TkkeKpYhqafzg6NEorVdSYJk7V5AVOE10z5aptl3a2CymGK7OXfKk
         YZ2ujxcemYjetsuxW0mcv0MInBcKfxMRSycbPL4kofL7llKiXyuM6pumbuEkhzgsdQKH
         ASQVy3/cneKYVHzC7rSdaYZ6khGLUJ+lBMxUB8nhIboqpEaGvNJVY5lIbYX4wcJvMeD9
         fkbEjQejPf3o9f3nYAQtdIrquVfuKgR7RLXqrmJ8XLrr76++iO5C9YEohp1ke/teZ3m3
         duMEOXmK2GiVDajGCzf4+qQseg0CWJ8lgP27FfNYJ+zz5fsbaVWv4rroUOb5SEHRmOgI
         6VHw==
X-Gm-Message-State: AOJu0YzIoHTbAsVsV0zz2Lj3fBSNYSBW5JxGzLDorfvOrdXl5V3+Pd3x
	PC+7spJtRaUz+LjMFZXTufqF2t2GDxvqtT4ZLhxZMcwDipTvJix///Aq
X-Gm-Gg: AR+sD12SqZgU1M6uVcKAbqkpJdAxRr/yFsSVw4iEvlQqgWeGkm646OlX0mgm+YdQgND
	LZ4lQd/j3TeImMpkQpvT9VFWUmB7TjJdqCu/P7WqRR9labqXvEIzfLbMJTynBcQYn7CnwC1n4o3
	cwWqyvHbMFr9EOWmPMdhZ66PAk9mtjPKd/CpZYb5jxtPwWLP3Ll8EUt07aZ9rKPke3ALTN2Uo9D
	k/QJAWpE0JGSd9NEjmZkP34zJad6b/myhm2MlHdk/0QMgHZ1o+gQYbtQYgKxwKvSpK0WakiOYVd
	97L1TiATK42EIVWfZSVrALlE2zdSvfCiizQQUYeew7XhKJI6VycPAtosKOHaS+wxhA3gBnB7THo
	YV8wborxYrsATC7NZfZWeEsLFz1Jq0cy0cr4M68b/9eFz990xkuxCls8JuQjxSAB+P3kGZEOrPg
	OcX939/S3vAm3DuNDsvtyKPVeuM8Vad6qMDOrlv0aHA5i7ApJIV1OuK5eth44iOq7i9ueg5cuUU
	NuAJDgBb7Er35TYv4ACdtFMWzzEtfGN12PADwnP+moEsEJk5WmogY2AfgZwrpPX5RdudWgD6deq
	6l5Q0jLRfl+wT2A=
X-Received: by 2002:a05:620a:19a9:b0:934:851b:f3a2 with SMTP id af79cd13be357-934a06dfd64mr1041044985a.8.1785623615584;
        Sat, 01 Aug 2026 15:33:35 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-32-195-55-166.compute-1.amazonaws.com. [32.195.55.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1e0e57sm348827985a.43.2026.08.01.15.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:33:35 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2 net 2/2] selftests: ptp: add a regression test for the frequency adjustment overflow
Date: Sat,  1 Aug 2026 22:33:34 +0000
Message-ID: <20260801223334.39150-1-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727112823.106914-1-horms@kernel.org>
References: <20260727112823.106914-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks Simon. v3 drops the #if and casts to the type of tx.freq instead, so
the assignment still happens where tx.freq is 64-bit but long isn't.

I went with the cast rather than just dropping the #if, since dropping it on
its own would bring back the -Woverflow you flagged on v1.

I also ran the sashiko prompts over the series myself before sending. The
only other thing it turned up was the missing .gitignore entry for the test
binary, which v3 adds too.

https://lore.kernel.org/netdev/20260801222923.39017-1-deepshah146@gmail.com/
