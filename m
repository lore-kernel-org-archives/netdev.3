Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B53002CF
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448932; cv=none; b=IGR1rdqRNBhZY+2S5g9ZMkxsjHqM8fSAcG6te70yB6qKtFyS6709yGgnETmn7HJH67h9Oai0Pq2b8FT779AOxu5a+r5PC5CIVrBlGcYe+g8uCADHuIza5vMQ3OoIUU/yYyLe7AAU4c5FevEJnBmVHt3fwoQmIZeClfoa4bZMXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448932; c=relaxed/simple;
	bh=2ZV+1Hj/UhdYw1uvUPcYqYevnxoEYOizS2cgooIrU6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUBvPq+qiLzYSvePf0AwiwMQLcCpoyWuMqUXehwA//CHnozB4/1KJyvUSGNNVwmVCUw9sBm5y/KCliaJwQRtL2XwKhf5PtlSYIN0hvShHRZ5uaSip/2fLJlk+3QntfuJfn+f2984bMH7dD1uWD3MqIpCsb3pLuBOiV7wyUeSJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUJ0fG0c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUJ0fG0c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so5749335e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 18:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448930; x=1781053730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3GAR7SC93N2eePKpNe9tCYUdzk5c1g7WEzw2IFy6ZM=;
        b=MUJ0fG0cIpJXmkAFcfYXyp+Ziu0eTA2MWQKXOJCX9h4zM6quBFYIGbyFGKTKcYDnUP
         QCr+wZoQugq6gZqHvmB06ZVuyPnzsP+9RN/MkIZdhn6sgxeFendYavb4LX94sVQknFes
         u34G2sWsdklgOrU01MKqa26rFpWStx3YomD+VmUFaipI31mBQETea10anU3ZByFumeG8
         1Sz599EnabnRLD8aCPMaViugxHQ9CtMt2hpwdrlY23Rhnfa0dM9pgwNQw76F1S1ifBSz
         0MuU4qj8NGZTi5IG6fILtSkgR1IA4sV5TgiE1cozubQ48uUDm1VgtXRT9hiwZV1aLvSN
         vJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448930; x=1781053730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3GAR7SC93N2eePKpNe9tCYUdzk5c1g7WEzw2IFy6ZM=;
        b=rOBBWWQe52W6dXnY9hU0hbH4z/2BFWQ2zQOyp6OkpmZXfZh0MbZUFjZAEsRlqe22AR
         gXlQA51a3HEDd08t8/iQBRKan9o6lfLv9o/5DFbwOgGE2x1eDdodDz1d2w06JNCUuRC5
         luciKc89IF/Dnrx2Ta7x0miVVm7wcOl8TqxlA31FK1Zz9UOr3LcLudaXOH3gY8bPy+XF
         XuASP/1yAWVZC9iA1MRQbYIdkitWY8t7yCCw2deInKh00N1y4AZVObfqNIJsQj3rkQTq
         3E1o0X9XaZHUokqVrwVDR/McK56r+IyNc3LIqy7W1v9oixFBa1c0FXvc2lQ47C1fDjtg
         ULPA==
X-Forwarded-Encrypted: i=1; AFNElJ/aUR7uhVph9h1n8MdGCPalmFFLID9vCpE9DTVGTvub/+GZn/yapCU8V4FfvrxitENEitYXqUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuWV6He6pKiNY2+WeWWBAx0aPLJG3sH7MXvqFQusI15lvqtUr
	EKeYrs5hspdwqrMu/szgbc/6vNG0aCr3nuAd20xfwPnIsje+YE3liuJ2
X-Gm-Gg: Acq92OF/xRj9lbuqrL2PZCN2gpIb3vUt3qXb+xRulWFA4etQkO9Xg91TcTl/dAo6AKw
	v92UKcis3FUswMi6N01NdCiIdoMXtmxkTv1ysA5I1V+sMzRHdPfl8+Ztg7Pys0kbWgO/fumhFDg
	nxbeoENHr+JPNhlZKbBOO57L27lSLmFlcR80WtggYgJWI9AWSLMxDRZVPye8CpnwHTkU/0x2HUI
	/pRI+KqZcki6fZiYl5a4aIvErE267AjuQSWYKC8cODloj+KAlQbUv8RudsdVTAX38JX7nVopzgF
	PF8FbeThoV/8r8UHhwORDCKZjtdjjCnrQr4q35MrK5rqWWpzBZh/NyXrItTr4xWQKiU8q/o+F5Q
	R8Wx4vtSROFAsW9QDh/5N95JCFXzKHapjynWJPGkdPMzI4hEf/6RYyb2UrJWy14gWJ/WMIsmpHZ
	Vp12DfjCq5tvJchGaSAndhFdeS/49fBA==
X-Received: by 2002:a05:600c:3e19:b0:490:b58a:dcc1 with SMTP id 5b1f17b1804b1-490b60fcd56mr18908035e9.29.1780448929768;
        Tue, 02 Jun 2026 18:08:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b725fb1bsm11254325e9.8.2026.06.02.18.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 18:08:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 04:08:44 +0300
Message-ID: <20260603010844.257094-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
References: <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus Torvalds <torvalds@linux-foundation.org>:
> That absolutely would be my suggested next step.
> 
> Something like the attached - get rid of filemap_splice_read()
> entirely, and just replace it with copy_splice_read().

Okay, I will post something like this soon.

But I'm slow person, and also I will test things in Qemu, so this will
take some days.

-- 
Askar Safin
