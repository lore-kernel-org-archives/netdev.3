Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2AA2AEF5
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432018; cv=none; b=AY28w4Hfddsqa/kMC3H6dw7NGsvBLDKFukt5fvwgOMuRn7hCg5wnn3BKQvPr062NaX/XgxA3EJCN68j1WFz42wRsqJNAvFtAjhXaGF4Bkmj790ddwd6GlJUIkAHx0mNTwnXJ1j2vaj7odXhg8BgvfOrJ3zRVYH0j47kDdMjv5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432018; c=relaxed/simple;
	bh=0w6gs2HNBOp/IrjGqpt/mp4zPE7HqKXPAgoDwebfZHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnK57zD2ElMkCq653jvtUdmcrDND6wUTVovq2Ubz89A2alUNSsRBGjmrClimTGsml9FdBiWqUVzdiVzcedf8y5ZeDEMAvLYh5EA/65zS9zwyPxTQgleei/CNp5Um3y0ZgUxUOptZ5EpixhxCsd3TGQAITkoSyMlSteUdcfiV8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=GzDODlwK; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="GzDODlwK"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137f18f45dbso854898c88.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780432017; x=1781036817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dxEBZLgOlgyTlqorPNmJvb7cVUKP4xbRjIu6n2dxcE=;
        b=GzDODlwKUxulGL5f8FBZU8/vXtY3AnPtxt/AlVBnuc9W6cXWGBJfGlRzNl4gSi0610
         Jq6WyK6+22dZ/wbJCW/t3hb/vVC4kNa5Uppfy7Fg6Kuh1aeCnnWO8xujJb2ikiHqgA2z
         uk2XqYAKk10l7k4WXwFUpWi/9/D1+6kyViMl3snNDL4Yo/9Zhdu0kpF4y1aZHhE5bLg+
         GUHPMNVNtal/BJ5kuG6ERvRkrrj4UeIURzCwcIsnmBb3sA4JWe6AiSlQ95bHVwEjBdcx
         i7kAX7VPDEjudMfmxIGZchcRjC13h0vktnaor6Sv0hEF7RaAoLwegHGynXWu2uybUiWE
         FZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432017; x=1781036817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dxEBZLgOlgyTlqorPNmJvb7cVUKP4xbRjIu6n2dxcE=;
        b=ecwi8VDjk0VWiJMDT2WPyu0hdGMr68yGAZewGzi9VPz0Kkd9X8J0qs6+ZE9zmESa6b
         40X5s/kYk3VnTu6ylLFIBTXxAeJz+4jXvdgBVDZGudPE0dv/rfQRh1raYnjx/UVi7U1e
         QlEIxQGtIxyOCAbaVra6V/QpsIlffATtG0aSls+so2BbqMa/wHInghWYgUf821m8Y6B/
         tKxiF+28tni9miEQSY17Hlb+yGyp0RSvZVH0QpdiX7eJrRM2amgZm4euzOP/vPMGgbC0
         WDCb0OvDyigjR/3T50t8tr/HDSllIg7L0GQwsLVMw1EZHPJaIGppvCVtgBeNji0KVip7
         0nPA==
X-Forwarded-Encrypted: i=1; AFNElJ+DuUr77ByNaKsQlZBQoouqo9LJp76hgi7ZwV6iN0JMUmnj6Ml0uFS61wD7E17Wa3t5qU5IFsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybsWdjgMeljAO5SYFsXfm8R12rxBBqZwB/HCdNlk3VlVxt5e3Q
	8qmlpOyl+Gr1ZV5qVfvxNtotrb5+kDewkGcFKm5Vlc7quTJt5zwj916/JubNpOW8V4c=
X-Gm-Gg: Acq92OHe3PLw0GAFiwsnX6emX1HE7BK3wEnkS/B1TTkNzur0sfnIF+mFjKwdqCnvp2W
	yfz5Wvw0GXeewTVlDcQ/A/pNz4G7e1gqXLVkMbdgcjOtdJ3isjXFxV9iTCcGxtfcl2OsMIiyNUi
	MEqCI6gAYqxtWQbfibdr1KTtnJ9k4Uemf/Fik5PyrRZx5nlWeJWbVJdCgvHckhzMDHyaRAjLBUV
	psCWCiKWp9Kg84aAKYQLjMQ37igocPKR9OEDFJSnWHIBowHSmg2jU30KTNZWAvk1VrYPrEcRIYw
	xPo7xyRR8rzOfBAXbLyX2tOTV/mHaBTvu0GrtU080R+SDu8Rb9S/XnWM4f8PqO/H94sd1t35qCq
	DNQSL/EPJ/GDmWCzQ/Gh63GZYI+VlsicLb44eLC7BQy1kA+G+9zGq5TOpwla3LU1QT1keZplDpf
	32FNPy8leDCDOXrVSIYbAZyD1vyBP0Ft0aVMFvHf7m5bcVVsqCjgctc0twIGLqZLRf5IsvfcaAY
	NU=
X-Received: by 2002:a05:7301:1010:b0:304:5b65:5971 with SMTP id 5a478bee46e88-3074fb4a05cmr150829eec.20.1780432016536;
        Tue, 02 Jun 2026 13:26:56 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85e10sm421603eec.7.2026.06.02.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:26:56 -0700 (PDT)
Date: Tue, 2 Jun 2026 13:26:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 iproute2-next] iplink_geneve: Support
 IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
Message-ID: <20260602132653.2b2f4f93@phoenix.local>
In-Reply-To: <CAAVpQUBAL_6A3MPcH8w7+EZyfOG9D0i2X3pu5Vhd+fz8Y0=QBA@mail.gmail.com>
References: <20260523061102.2762452-1-kuniyu@google.com>
	<20260602125951.50492267@phoenix.local>
	<CAAVpQUBAL_6A3MPcH8w7+EZyfOG9D0i2X3pu5Vhd+fz8Y0=QBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 13:06:33 -0700
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> > No new code can use matches(), it creates problems with conflicting
> > short arguments.  
> 
> TIL, so the recommendation is simply using !strcmp(*argv, "local")
> or anything else ?

Yes, that is preferred.
