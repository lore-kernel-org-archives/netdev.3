Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD137C103
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805475; cv=pass; b=rrFunoacXVM2A4t6nIkRdJH7hKB8JOQDohWwmkhssMnCzRFy2tupru2S3wJVowRvFTiU222NG1aV82CWUdcP5eEaF7ijWoDbK19YX10BPEnNIAaanXEaeoHlT8OeG0T+UIJNphjKZYp9LfrB4CbeSrSGZdVObgq8AUYhzTEp7II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805475; c=relaxed/simple;
	bh=TF4gCEvN5ThIoaSNFiv7l3yYWMkjVNVbqThw5433U58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6/Gro4HlcKIsDSGJ0sH2wCMDs7xUBUa/rNCjYssHBhM5bH08/83lfX07/BoBtM3b5xrqGBBOuasoxyS8T6k1NP8eCTR3HHBjM8UWadZ/pyUK2j5nRTXRHVpf4hzqWxTt6sjn3nRG66ljzy5Uiw5wk6G+BxwuoyjEXytAb/VhCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQguqOGp; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQguqOGp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso18473955ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 21:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787805474; cv=none;
        d=google.com; s=arc-20260327;
        b=XluNc4jjW+KZBS5FyC870OFNMycc7DfHKkHxNTGs2luGGU76+k1Gx8k6UmtoCd2HGt
         IEDzcAYk8aiRFLBfwfKqnZWqxNDVVS6Kg/JkHFt9NKzDDN8wejfG5GG1GXHj0bWJQup+
         F5Bw94TaYr25JIEayL8kkDaFmjTQWfRLL/DIrQasszJPj0AU0k9J/zToqhIVxwevxDAf
         op/XyKuUB6QXvNPSDk9dSyVEdG+1jYBM+FKYzKo3CuJaXWCPTeEWKyhsviOL8NRzshaw
         tTiKoBRrgHYYyitq85zFQzQaSngR2CRhMoHn/1ZP3WU/ixvwRw1yVVT9OuA4fUdak3pW
         0tXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TF4gCEvN5ThIoaSNFiv7l3yYWMkjVNVbqThw5433U58=;
        fh=KKvIeSjWEn2Fhv6xpbha4/T/xlGmOo63oBApenrXRpw=;
        b=hi92q/Kt3PstklF9P9FDbws6Cnq82GGqxeaKZvajPLqLkMxQEEPaW7xO8/h7oSqDJ2
         +0H9BZ6dqlv1EfXv/qhkFQg9bFPXaR3gxzSMrCO/oFnIkkPnX++liW3/kYaO2+oBzQTp
         y7oUnaA8Ys0359Xwq9t91SDQAZ2nhmMWCTECsgMxFcxPFfaQQOiW3geNBHR7O+nm1qzt
         C4NpjSyH+8ly0dDNE05SfvuDSphf+twP8UpUXQS5Eyo5HMvifTkPK36HvxyslxQwENpB
         bp63qJ3fuCQMbWZrmFITtYSwDs7BFHOFgmhSIpvXAmyQwDJfSMHe3KH/1dgQ8tKdvHbO
         YUAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787805474; x=1788410274; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TF4gCEvN5ThIoaSNFiv7l3yYWMkjVNVbqThw5433U58=;
        b=OQguqOGpKSMBKsKrggvFv/FNX5gfUzPkQt2r9lSKRoGyizlj6BecIlu6ZXY52W5S5m
         wyTpmA1ro092rIqdEU7LSGzrshonczFLZV5AlGkFu6vWWFBhVYDuYNjh7th6/M0cWRSe
         i4TKGwlqRyGHX59SoKKoAR1bzWLQbHROmjE/REci1y+D6I30+oRlP7YncTCIKnp0tS6m
         VAJZwvxvyoFTmowBKxnCEH1bpzNNs548dqF85OL8EH7FdeSlrPifYFlfSP4T45nZB9Bw
         0Mm8H0wWNO28ft+5TmULSm6Hu1C02lFrfuO+3Y34bn4PB/Ipt45QLGRjaCnsuu36grw/
         lcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787805474; x=1788410274;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TF4gCEvN5ThIoaSNFiv7l3yYWMkjVNVbqThw5433U58=;
        b=F6HqOc7KpdWTCEuFpfLxZOBsa2pZf6XXb0n/ESaHeUl6NUPGqu2hGIG81k8UNX/iVM
         uLcznfBA07ajoY/dDvkbWn6BAnAavYD995hpfR48+85gpnGu6JNhvaif6Mgg6/zJgjv3
         /+4ZntYr3C8yV0oXMhuvTLBXltxJ6QNvP+/7ysLqDPXUkz6FOzm0ssRo7XIRUl1HrzYC
         kBe4pBy89fm7f4piR5ZGcziXt9u4KEuU0L8SbhId1JwSY01em/mFNs8lpiQ1eibzJIf4
         veeDRWjgeVs4mly2tmLm0hLVTP7kWJ6XyR2d4uBOmAT13JqA87K9KsBSgH0nsiZLyR9C
         xISg==
X-Forwarded-Encrypted: i=1; AHgh+RqkS5fAfAkjz+vNA4Cfk1SfdskECn/qP6Osmb4aYe/Y2YIFPe/yTMuQ4HB9nP+RHh/poWDGzKA=@vger.kernel.org
X-Gm-Message-State: AFuF++kxMno8dAILSBZPVjw6Oq3W9tKZNFQ05rPGK1XykG2u5kDcHgrj
	CTo+iz9pbS5/6EbbMBPqG4cByeIxY8fOx2NTAtR1cOf4vwWwKppgvL4pqtgAkmFZf3cPG/tBgQk
	pWhv+qm4k1gP9w6pwVXWr6FlD6akhHGk=
X-Gm-Gg: AR+sD1238KUQlDYNe16kWMLrTJYaySx8khrdH+sK+MuEK0ADJIwSd/+HqpjiFYszeOG
	U+J+4TW1/BecEZIOXsprnmv12f4IOZZ921vnNBVM7r9x5G66/nsrlGsvCUjg6HUDT2J7O3lkZeG
	mBFaZ2YV5JqWIMu6l5kgAkUAo9AQ9ssBqY/7vjZeZm5iEM4OF8yhhRzA/cCjZ03Qep2TSctcFVb
	r68mUiOw9QIKMzjpDehoj5dPIHKHvIyIVJz56r8C8uuAqCxdFp/zCuM4iMIokmjnhzRap7hBSH5
	titNdE5VXHRO5r+BEkjkyfVMx7wAsV/RRZlZ46Pqg3z3KHFWv0VAJvjrK0YUIuOqk1Roxh90wg+
	CXfz9u3VvrVnu4rZC43QQ6bJGtF7J2pdlF3i+XBjVXzvrmKctLpfMXLmnagwBPsRWQj4=
X-Received: by 2002:a17:902:d54e:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2d707c11148mr245120485ad.14.1787805473655; Wed, 26 Aug 2026
 21:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824100758.31622-1-phucduc.bui@gmail.com> <20260826124040.GB22033@horms.kernel.org>
In-Reply-To: <20260826124040.GB22033@horms.kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 27 Aug 2026 11:37:42 +0700
X-Gm-Features: AcwNN1Uwq03wbJzFAkj4RVE-iN9Gvx0spZf-CcmajrHFwjhcmB8WRiI_cPvaFIw
Message-ID: <CAABR9nGKNzNygC79eaXJMnG27qRUVTjg1S8JPnD+oqDXCHe84g@mail.gmail.com>
Subject: Re: [PATCH net] net: mvpp2: Fix IRQ error handling
To: Simon Horman <horms@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

Thanks for clarifying.

>
> As pointed out by an AI-generated review [1], although the current
> condition is unnecessarily wide, it does correctly catch the v->irq == 0
> case.
>
> So this is a clean-up rather than a bug fix.
> And should be for net-next, without a Fixes tag, rather than net.
>
> Please also note that net-next is closed for the merge window.
> I expect it to reopen in early September. Please don't post
> patches for net-next until it reopens.
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824100758.31622-1-phucduc.bui%40gmail.com
>

I'll resend the patch to net-next after August 31.

Best regards,
Phuc
