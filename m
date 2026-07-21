Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1513F7AA8
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784598482; cv=none; b=nIoyTieOOx0DGE1pFK4jKAeu83CBRjGhTUKlePSgt0NnZSwHpK4+gnKcMtZi903ScFzOlW7aD9IahWhHYfi2qPy+8HAuLYe94w/hXceLEFUhjMN8ap/Jmfaf5bzwfO4GG44gUh2wCDO+el5ZOKF5aO6jYlxY/kMcmDKmHH9vhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784598482; c=relaxed/simple;
	bh=dTVNk9f+ebsUE3FMkNKiqFCHr7hKIHI14NzUNt0oRP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfdVw2eRjKLtySKbLoXem+bnxIGepRA6w/pSFMFUu4Ow0EthcZaXrKl7DwakkRmDFJCSK6CSwj+MCsPxEgR/lsJrzag+IwUY/5m2Z/IEdolLFYPNxmelWfS30m/l0I+0RTps1sFLZi0uZiw469URaJIxYOBwfE5vHubQ/nBI9uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYMqiPoI; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYMqiPoI"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ee88fce572so84692716d6.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 18:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784598480; x=1785203280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dTVNk9f+ebsUE3FMkNKiqFCHr7hKIHI14NzUNt0oRP8=;
        b=dYMqiPoIM12TTfM5LjzoQQZdRdlNqec8FwZaIujINebLnfzQUpWARroF1jVQFO4ObB
         MOZ/TrbFH0TdwqupHq5EHCzB1Mej/NzD0hwkQHM8ohDNtpj7WMotQUG/dEC5RiHvvHfY
         qgeu4SjTTNCo/LyDzWKYUxoTYxHQavSP+QDcjq5f7HH4ku+7almKscMS8qgZ65ysUE8l
         voVghql5mmpZ3bPj9FQhPsZ/JFlEYsaOsxu4pd8OxtOsrkMCXl30W+a4pJym+5Sf8cHk
         M0ibLg8JPFVu4KVETyagLtm59JPAe6GL+5gUMXCl+9iAb8SJh1hIb0Bi8AvxT6emsuyw
         IIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784598480; x=1785203280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dTVNk9f+ebsUE3FMkNKiqFCHr7hKIHI14NzUNt0oRP8=;
        b=mrWpVoT3shl54KoLDZNNIzUYKtve2hJl3wRNgZfkw6xLbhi9xw2ZtOy3RvJ24SjVJ7
         H0doRyqfoFoIvy4D+/CvlJzpuMr+P0Ssa3ywp5EgF+OTgfi3lOLoeo0iFHP7zCroIbwR
         BLzj87Q6Ujxz3kRc4z/gKm4sX1jQhslbBtUYpy4buAEXD1nkSwgza5Oofz3PUa9F4cI8
         5Mx6Cm90v3p+KXjx0wPPfLs1p8jA6FXsI7J+c2Pfo6rTR4U1cEjETo3rQu59oUAAV+2O
         Xk8NZX0WDeWv8L6lPDPLqQRrheT1bDqXQrvZK4sP0W4gcIH83cdeFbz7DCon7X9hKlx5
         K5NA==
X-Gm-Message-State: AOJu0Yxk/bA8qlB/pJY8JksLCh7ePF4ykEACEzPDM9dlQSI3F0EQ/JYf
	yavc3XP8Rtaq18b4aD/33N4yMIqTNAkhVX1rO+69uSZ0yomVcNTQWYP0
X-Gm-Gg: AfdE7cmOlTMkxUpeToR74EqeWXrLL15IZyi0IgiCu3UeKJLMsaTaEEoinWEfGj6+Jd+
	vueYv3aGsCYn6CIfPedNhRerYIHaUOpj755aiqvKlUfDZaYirXtms6bqsOFlAcQgsCF3HJOu7EC
	FEEeqC3imGjOyvkQcCyQ/V4Z6X3z15weQL1f8K9yOogjPsgqlsa00shH6mgpOFOSjI04PG2U4r1
	fGm5/1TP0+uVobl5pkNAnrHkfKQG4OjdRYqZAplfMVYyA0ovjpoVxdbIXcXFm/OwejBwPLWDHTk
	T1b3vMpN/y8PSymvxhSycvF+gsVEW72N0pGCU+aepBqrIXJxQdjKyFALDCjLETqHIH4JqxFnOp8
	XCD363JiC0Fj1oDbmNoBmay0iOVb9hWFgihqZoreU36rUWcDoycrixchHAHNJ1xe5wtmHJs+AbC
	7K4HfT0n7uTsEZXnUlOT2sTJjQy9hABHaXOOZxSJh80RasfAcHg97vCGwMd3wCxm1tsrkYZzCq7
	s7bPBjvK0Q56t/I9Bo3ZmUCZ+o=
X-Received: by 2002:a05:620a:224b:20b0:930:bd54:c073 with SMTP id af79cd13be357-930bd54c18dmr1012046885a.3.1784598479797;
        Mon, 20 Jul 2026 18:47:59 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-13-222-20-6.compute-1.amazonaws.com. [13.222.20.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm1016668785a.35.2026.07.20.18.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 18:47:59 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net 2/2] selftests: ptp: add a regression test for the frequency adjustment overflow
Date: Tue, 21 Jul 2026 01:47:58 +0000
Message-ID: <20260721014758.2235-1-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720112842.106914-1-horms@kernel.org>
References: <20260720112842.106914-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks Simon. v2 addresses all four points:
https://lore.kernel.org/netdev/20260721014256.1876-1-deepshah146@gmail.com/
