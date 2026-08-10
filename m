Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF4F390C95
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348783; cv=none; b=HkBS/1kIPl35b2C+DwC3wLGcIGNWWdfUtq1ZZ4IW5PUFKe4Yj2wravwuIRBVk53mI05V8XEsq4c6NkpwrM1XqKdznnjZ9MyhU0r0WWJNO17MEdE4NHl21PiNsgXoeA8yxsAJBgEUhrixy4foWHDRqqZr4wr0MHIUmRUu4AqCfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348783; c=relaxed/simple;
	bh=uD86DJvZDw9bMSCmDq4xvZrO3VykDVvurzO2DO21mXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6ILgV+29VBgVzyz4DhrGYCb7XVMsxKAJkoIVMq0qShaz8CMd2IQVNAptYEm+c67tJV5plC0KLxtvc8TIpFjtc4MDqE0KciikJWqijFTef/zgWZHVahHYSqPYk8SQ3pRks2H1Ii3UCMneNZHnV7UrTYKSLut99E2SVjLI2qkgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0vS/wwk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0vS/wwk"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3811f512167so2256009a91.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786348781; x=1786953581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+pcbraSXWcqC+YnM+SOOMfRMFDFBi4/Lpd8ztFJEEpg=;
        b=p0vS/wwkviV+UWNckOacVxiTbJT0aB4Q/jTSS6OauKQPh7ny1KbkcLahXwhn5NyD2E
         4AP5tqS1Gab699aS1CZijdVip0RsadpHXMN/UDYxTq9p0MY+wcPRHDQfoJL3PEJIf85c
         oAwiCwCyfNY28pNYi+e0YrOJttrJoWlWTOcSBn/pM3+k0B8FD0bJJkyrGyQIUwmS5xGI
         dyntXgHKfvc/MdQuzE1xyzAkiAGeS5gV7xTpsjNRyhk/Uex42jc9FhnBFh0p8JgLwhyD
         1mGnYW1GhvDLOJOucm/TbxUw9oIwlgWB2Gd3n2awl/MkmeC7QzQo4XqxAd6u1a1Fje0I
         XWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786348781; x=1786953581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+pcbraSXWcqC+YnM+SOOMfRMFDFBi4/Lpd8ztFJEEpg=;
        b=gu2XenOeRgKH46LnoQJSULo9YWWiCdO8lw0dqRxpeGwRg5v672GhgdcocjrD/6c5Ba
         x358o6SC+HZ3Vife7TpGCUy9j/T6UIUtcLYGRSaz3GEEUIOTKZPSE4jOtqFOWw7Vu7sP
         qg1LrfID4rRPLlur0FY/Kj6gO8LKQEndnVXXMKF7M5pNiIMdvuGv2OcVkdtpR99g/BbW
         +37Wga1OqbswTuZ5uxKDuYz4uMIvHq4Wld5yb84uf12q8ZnvpNlnQ5HYdeXnT/nLYO0Y
         yV5EclpdZ0Q19efqqhZoE3OoH8et99dPdDzu5dp3wk2F8YhnlhaPcd1FIUcg3wkJtGAH
         LE1w==
X-Forwarded-Encrypted: i=1; AHgh+Rps5WDDntd83NYaIyHwCi8hamaxtu6lCBSLfA33EIae8/b2F1V6ru5C9RfZ91CpcRf0klNo4ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykdCzucaM9lMUeJzsCcor5FyRxtEcE7N5JNRsTLOTqREzEf7w
	8Mk2ih482LohqDrDGzdpoNLEGv3VsTuJ+xoecU8cmEfn8RdcDyheLE8+
X-Gm-Gg: AR+sD11EIHQ+mfNbTKao5lE7+RMcL5yW+pqMb7GP7fM6CJ0QV026pXgRA3YTGvK+xGz
	FqR/0ri9Oc4AAwxAkw2ynI1qaBgyVLrmRL5oxvUPW83pqiiW60H7jpmsbccPsELjCZVl6HEc/5g
	U+KznncSawC12Ah+ib0qYgy5DcezU9aiQxVI65SqebaKwiuLHgH1Qij8btbmKPbPxP6c7TfllBb
	3gRC84BKiWzW3PUw7XXGrI8XVaGf10TogGplO2nAiExT9noYyj2/4mGB5Xn7KuxXCaLr9MIg/H/
	HofM4rIKAAMxoMv2+M9VTDob/xnuCGjXxSkI4zXWcXOQUBpodf5Fl5YnGkUpZ7py2b87VzZxn83
	qcIIp1TtFFpm6njANW6LAchboUfsmzxqRCHWm18bWxWArfmdMzLTTqRyotiqX7Ny6Vfw+tPa8pX
	0tMlzgio7EQvn2LOsXc/M7NjQUwRO2tku1ZAkqYFGOVkSM1Ebqg+a59Cg/XrE/vIrFgCrKKLd6T
	fQEFcSoKsmzAkE=
X-Received: by 2002:a17:90b:1e53:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-3903c5501efmr37893588a91.3.1786348781098;
        Mon, 10 Aug 2026 00:59:41 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6f13dsm11391590a91.1.2026.08.10.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:59:40 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangpengfei16@xiaomi.com
Subject: Re: [PATCH net-next] net: ethernet: drop skbs with a short linear part in eth_type_trans()
Date: Mon, 10 Aug 2026 15:59:35 +0800
Message-ID: <20260810075935.2961699-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CANn89iKByRiWyVdPCzvb5+0WWrPcaeLSXDqP6GqUHbqRwMF9bA@mail.gmail.com>
References: <20260807102802.1696827-1-zhangfeionline@gmail.com> <CANn89iKByRiWyVdPCzvb5+0WWrPcaeLSXDqP6GqUHbqRwMF9bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 7, 2026 at 6:52 PM Eric Dumazet <edumazet@google.com> wrote:
> This is obviously a wrong patch. Please fix  faulty drivers instead of
> adding more code in our fast path.
>
> If you use header split, you are supposed to use modern NAPI api, like
> napi_gro_frags() which will take care of that.

Thanks for the review.

I put the test in eth_type_trans() because I thought the stack should not
be brought down by a driver handing it a malformed skb.  I take your point
about the cost on the fast path, and that napi_gro_frags() already takes
care of this.

I will drop the patch.  I do not have amd-xgbe or dwc-xlgmac hardware, so
I will not send an untested driver change; if I can get access to a device
that behaves this way, I will fix and verify the driver there.

Thanks,
Pengfei
