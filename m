Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FE156C6A
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660033; cv=none; b=rKqj8f4wc5rFzcjyM+HBptcoFKqjj+49IU8IOsrJfLKW9SbSKwrPSLCnpnEJJKMMfC4xISgntQc6NyolzKNLKulanHx4ZuFflVSnS9tQijvh+o8oIEyig+8xr9ia64WaVvTMFS77iWp+d0UixSXN1P2NuhmGBB/t/aU/CpoEr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660033; c=relaxed/simple;
	bh=AiDqvZM4Opw399RRTuLJwTkBR8+qFeVkub1HyMGcKfw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uT0w9O+p9sy4WTnqSDBaMn4p/ne33D3Z9WPnY1IFxr3LnwGfKcyRi9JtQjUJ8QzF+TkvmJayVV115IbSYq+Za+TXwkaJ8eVhJqyq9JRK4URU8vjghGT+baXblSUreB6E0/XWkAXu61IozcSG/W+hKZjrJ2GDh5kt5P32yGc9QLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KamR11Jr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KamR11Jr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-861feb6d61bso22785597b3.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 19:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788660031; x=1789264831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N7bxiLcDMMwOcWzIcQsSLnnRghtM4if1RLcmXcHJRos=;
        b=KamR11JrfS9LaYsalftwfm+7CR7TFSUKwpeyVNODFlNkxxoiPFckp4jkcJyWKiPbRE
         vacq9orlS2XOKyE0pzbm5WA5K5o8TGrcackiQuidFa25z/Bo/DczML+S1tqQsy2RKUQb
         0bAIGtZLjl2M65sqOvBpXaShFRRw2AR8r9fu28zvjtYpJX6oRvhPfqc/daKZ0e2tev6y
         ikgsRUmwMark8OVQ3BWVQHkgtqBhRV0YI6nfbABglbK3yrsZDEpxOP1hTIISrgLJfcJ1
         ToNybxCIgqN2pdLuezk6HEmO96Wt/oGAv6FxPGmJaCa5Idrd9MhiV65gWTS9XNgooSli
         sUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788660031; x=1789264831;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7bxiLcDMMwOcWzIcQsSLnnRghtM4if1RLcmXcHJRos=;
        b=RcJYhUJTm7OHC91vrEhQzJrlE7NfIAVtzU2Ix3A4JhVdaSDQQNWykTNlDyDnrFxzee
         MYmdUFATNnX2Tw6FsrB36aCB7ge6oOBXiwguWH0/E/56LeIzINyE9i7dMu4vsQz9Si6h
         jYMr6TQw/Y9PkKSVZHEIBZ7emBo6slsaUOLXuq/PKVCzaFpzfiUACEyNBbQxWJFOVkxO
         oD9Tb/MEgYvpTX3lAoJDftTD8Hxe3Pi/6WQpdx8qT4gsqDnCI7rVw5Hc2JEqXonX4MnQ
         ZmRImyRgIWCsU5/eYi/fcc4D0rOtaHWIbsC7eiAMVFj9RGPg1zpWKf2FHIBK1eaPQIMY
         6gpQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7kbeRaZB5SZvV7VTv1W/YeooZ8kRsw2zr4Oq17CX0Bo4kDbJRwmpreobh15psS3vwg438iUE=@vger.kernel.org
X-Gm-Message-State: AFuF++mnCPOJHq4ARRv7X/5iPrM4vlZw1KJZUsj8sJctpGz/OKKfTqqZ
	+wCUSaR5t+RDMAaHYCrVpH9TKHuPFwey+FOLFgm2lFRABnO58h5uihC/
X-Gm-Gg: AYBFou1yt3qFtE4vh2ccxQuYlspNBbpFGdgI3PVZv7IXmxe29wiA26mOhJ6Fx5PycJm
	9RXvwWheDJ6ntBmIgnOQpT4eP95S1BDvVjvAZuHnNhopyXddYvKRuyYofhQdzgUagu7bh716UyG
	nvaO1ruuFOuHKlTKvTyYsbi7/FIbCu1uy8I1u0yfxka8tikbaGHl35P4ncoz1hEjVR55tN1i2VT
	YgkRmJKr+pkocJyIit2rTPywwKWmDkw6qP6UbjczblVgsxKQLSGWSj8tr+WNDSHP+pjGYbvwE2J
	0Yeg0jCUYutXWlZmE4IawJ2IksKU0xvfHdwl9SyEvUxP1a1srRtCARl9XFNs2iI4LOQbjLUe4e9
	etOrg4j4cX/rfiABzr6fV8IFQ9E+Y3gWdwI1PgiE0l0XxyDueIBpcebsQRV3dxOwQrYgC8G9W83
	5yX0oStjNe1aO7YdbsUWSlKkTF9ShS+PL1QeDUNLU1j4FjT1PMHGEOnt2xnRfoGhBm+a+lyoOAQ
	pcoI/P6KwC4xTYdQSKpOgSZ7Lpd6OcDLmMadlDS3w==
X-Received: by 2002:a05:690c:c3b6:b0:820:1014:526a with SMTP id 00721157ae682-8712a9f5a84mr58152287b3.29.1788660031462;
        Sat, 05 Sep 2026 19:00:31 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bef8930sm48206607b3.46.2026.09.05.19.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:00:30 -0700 (PDT)
Date: Sat, 05 Sep 2026 22:00:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, 
 netdev@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <willemdebruijn.kernel.bf1538959d32@gmail.com>
In-Reply-To: <20260905100608.42539-1-kmehltretter@gmail.com>
References: <20260905100608.42539-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the so_txtime selftest path in SOCKET
 TIMESTAMPING
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Karl Mehltretter wrote:
> Commit 5c6baef3885c ("selftests: drv-net: convert so_txtime to
> drv-net") moved the test to tools/testing/selftests/drivers/net/, but
> the SOCKET TIMESTAMPING entry still lists the old path and
> scripts/get_maintainer.pl --self-test=patterns reports it as matching
> nothing.
> 
> Point the pattern at the new location.
> 
> Fixes: 5c6baef3885c ("selftests: drv-net: convert so_txtime to drv-net")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
