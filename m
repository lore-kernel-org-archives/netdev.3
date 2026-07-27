Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAE40A958
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157196; cv=none; b=H73llBfo1c4PYtgxgo67PKsUfsKuRhlI+IIyHWqU1/BX5JQSMWYROpxQ+LOZuybqY0vJGXs6xlnimu/HFNVDfBsPNI3emm4nfgpve/KD6WB9brh7CX3FjK3/jW5KexH0pPYri+XMA0e3TmSkweoATreGxG2szRCUA9QNwufRLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157196; c=relaxed/simple;
	bh=WbXVFO9o13n+Kh3XJVydjJbkPJn+hUcXxNF6aQtVdmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCDmOhG8doPp3/o4gEVPrmx6bNK6zUPH/z43zNOf3+GtsXVFRu3oKjPScIiTGqET9KCuIXzHz7AddvpzhvGbgcQWeov+tmZQ1H09GaWU70eNEVQmx4Hk2svn2o3V/eFrQbsp7aUaPzYvXiMVLEOTVfHSJMb6dbBHfSyNHp0pzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja3QLJa4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja3QLJa4"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1851529a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785157195; x=1785761995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WbXVFO9o13n+Kh3XJVydjJbkPJn+hUcXxNF6aQtVdmQ=;
        b=Ja3QLJa4hdpwHiqVGsk+Xi2OW3INO6ZWvQUnJRfp/1nQXK0lSFqWj2CwcVEICS0spU
         sCVKtM5Yge0Yxd8jV/S8yjxu6204l2hwodk0TLQmpC7adQFraPI3kYJnx0AGANgA/IBy
         F7YZvXeg3GgMZjvTMN/c3drF1YU6amOe8ZZ1rRChTC9X9odEhJelOCadj+X0jAj6w0o8
         7sIyiZqjs56b2jBmryjD6/b5INrTa2B8zVo4xoSMW9kFiLXcVHnVsgpkppRkNY26U6jh
         EjP0DXTL5CDDvFJMLUtMbPuRTRq1CYIMTWZWkJR5XQfJsdnNF7w0yuCYzn1dbC6Er/wQ
         c/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157195; x=1785761995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WbXVFO9o13n+Kh3XJVydjJbkPJn+hUcXxNF6aQtVdmQ=;
        b=A5EGWyLc6HufmL2cW49arS7X3JmLCxzzgArrtp8qGawBJK9qvKPAjEG2HCtuVGsrGg
         pyLnfIF8XLs1sXO0ns7D5xQVSJALqj0jB8NZ1W2zJIJvN0UV7JrGDiKaaXDCBOSna6mT
         L1tZ+EeoWV3t9+AQROyZnce04beQrDGYIWaAZYdLz9VqOaoihKOuy9Ygu3Jg0YLCZAXM
         jDUpffa/UrVowRdCbtSQdbYszeNOJp9XDRfbgO/ALM1hTAoCNfAowAuLH8AEnEmMjj0Y
         jxyicmiaZ7DaAOCgTWQMIfCRbN25uUm0SVwUUTAEeXTR2guZtXcgqeACb1d+N0xmk69P
         ABag==
X-Gm-Message-State: AOJu0YxH7WVoO5Q+xcGJTeh2BNaOxDGsHV3CaE+ahURvkhDSvCTl7zOZ
	3tvibVyKXwpl1D5OoiMZnA6OC/v+dv/9N2rem2QTV9ybRQSbsF1vR5Pv
X-Gm-Gg: AR+sD13CKsN6vzd+G/Mh4Zgk7e5M9tHE9f2a3QRNwv9qHsMAro+ZBXe4+Qx6viNWI9y
	0BsuhWkQ6DkBPmvPzDyHqByrkuw094GEkAKfBqt70deGERMtossa32S9r0raYe6b757kCqHhxJf
	uwapsjPtfZgUgwhYxa+ICL+WX9diglrztJkL1KyTVxdGUCea8XvhiH0PX2y2IcX9QVxoc7ZdRCe
	FPvqiY6nltY9gZtgS1kRKWwwi6odA8X/xqpiq/OQmJeKrn6r+YpDQJ1tEGnRwZgGnq6xImgNwQK
	itSHCefbJG7X7F0dYrTTCqYimP1MN651QFvkw8qwB+ocwWM1cWTNAcvFfsDHhZKGOvB7IDRl1tB
	4pSeeR45faCo4ptChUgfXewt7AXQerCk78WqkUlhyw7Pp2UYCJaeMXjGsfjIIph2ltYEjCw+/55
	eC9a7wFiGGJAtNuGIDdPkbJdmGQW7qad6adKpr+3T/2ZJlk2s=
X-Received: by 2002:a17:90b:398c:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-38f293cd1fcmr7935519a91.6.1785157194906;
        Mon, 27 Jul 2026 05:59:54 -0700 (PDT)
Received: from anna.. ([114.70.9.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03adb224sm5147172a91.2.2026.07.27.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:59:54 -0700 (PDT)
From: chanyoung <ppoo1220@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	chanyoung <ppoo1220@gmail.com>
Subject: Re: [PATCH net 2/2] selftests: tls: add a test for splicing onto a full plaintext record
Date: Mon, 27 Jul 2026 21:59:47 +0900
Message-ID: <20260727125947.2889407-1-ppoo1220@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <amdHFJlOVpACBir6@krikkit>
References: <amdHFJlOVpACBir6@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

2026-07-27, 13:55:00 +0200, Sabrina Dubroca wrote:
> Why 4 extra splices? One should be enough to hit tls_sw_sendmsg_splice
> with the skmsg already full?

You're right, one is enough - I checked, same oops.

> Do we really need a fresh pipe for each iteration?

No, one reused pipe works.

All four fixed in v2. The reworked test still reproduces on an unpatched
kernel.

Thanks,
chanyoung
