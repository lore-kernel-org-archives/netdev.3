Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E93CC337
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780545; cv=none; b=jhEcK+w30esvenVj60dKZ+gJSX+CZqyQvCau2AuHWjcez6kBEvUS4ewwlXGew+j7VjTX/CcparBtbVNml4CeYokwuBhW45JdWhfm/0b7kpUmRmJydPbiY6vV4WoMPGEXqT1mKRFZnHHoBpcNgqw9Jf9k+MJwcQohAXynFBYOsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780545; c=relaxed/simple;
	bh=et+Drx6YdkA0OmFZ8A5zPCscUG0WQh2QP4yccQGJySk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hXFRkBEWlDgJYR8s+p7yZq1RXqI/kYKNa7HYtv1Geb8rUQsXVNpI9vFz4eVb+jBtN+qQTKnYqvlh1tW0pu4wKOsP1Gwu9j/UxW4L8ckRBMy5IM1s921mX/EghhfTvx0oiQr1WQShaxeJSxMxWgLCESrvSOn0A+FKVcvdhlCGzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1WuR4gz; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1WuR4gz"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab408a38bdso8979717b3.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780535; x=1791385335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e6/kYvub5z3tYxzJGmlTCicIu/qxHQ3oYOee00hBbq8=;
        b=l1WuR4gzmgiQp30ee6KF8BYqyFF96ZmkB+3/3lWNwvvKcf0bxtmN6msaEKAf/7HYC3
         858AbfaQWIDCpZprxRxQ6faNtyZvIt0Wn+F7gwz66AfHujgZSKYw/7RCophZmxjuE/34
         G9GeYWl3KG+gAmDEfNm480qjJMMjVrsfQv83o+jLfaPG+KLL4KHkbNnGWlAPUXEE+OI1
         reG+qXXArC8hf1GbPmzvoho7a9XXTJIFy0SGMhY3zFURHTN4C1ebnNn9zxY8HNtTsqN+
         g28RKri9SxygDE2zbzXpTNJcqWT+Z3T8NBzW2F1P3cwwA1Vr1unlYMjdj3I74Fc6UByL
         BZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780535; x=1791385335;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e6/kYvub5z3tYxzJGmlTCicIu/qxHQ3oYOee00hBbq8=;
        b=duQgwtZVmbIChgO3L3DwEQdVD4hKyuXRyvnIMECg9cc98EyqM+nJbMqejhnhsND/dD
         DE3ruLje/gdX9LciwRC6VO44vWoko0Y6JL+yFpZ/wZyFdX34UrLr47tHtpI2cSijWpV9
         C2qYDa//AXZQNnMlgGLvY70difklW/5XAVpm+bT97Kur0OjEnMc9plpG3xj1dM2Ogmas
         h/BThHcs74PdNzpwaLK8CjJeI3rDpnqcoe21/d88mhCdZevWDTbQO4ZBd4MaACxZDgH2
         Il9jS7k99Zxf32S/TkvuXDyo7DaEPthTKgLqog+nN0SYJE7f3d3jaX0To8wZ/NCHYI1c
         2Ruw==
X-Gm-Message-State: AFq9FYLLF8ONq/rNvO8S0wv6RPAbCY5spw4U8cIlfm+8mil4oNDqmTxJ
	A/icnnCpIaHCphfspxEHQHdliP5P/kZrAfXvBnlvp8N0YWspPbyOQSWd
X-Gm-Gg: AYBFou0dgScwu8eRZKQDLII3nlNYFt/p3hQJkRE0xjvFj4xXWhry4TbIX+kGWnpIbrE
	XvEYnrKFgA59nLydaTr9SUPFs8l2n5Y6CC21KzStGOgAyvyBGkH/Bls4a3XeDhLfqP+DKaysrG9
	5Q3raNX2B1d46KH4tCkoDiQNBJGRPAPvQYp4BlV6jf9eyxCrcJ0gejY+ERuu+jTZyme1XvAHK7F
	sqWm0yF5qQoBWIRhaYnpdTAq2i0GC+cYiTniqrlOUCkblvyucfjYSE1SkUlEpqH4VqAa5JJngrA
	Dy6R8rDJutU2vLdQ4UKbdgqx2xWQ7nrojNGhiMHvow5LKgyOSryODuNytscuPtvoJLnelNdaGSj
	a/aRnsZhECpNCROEqEKG8KEFl0DUWgb5pwQChfuJtBpQXmIT9Ix0vQcy1N5HtFViE/W38axSMRP
	jp4HQ6qMT490NKSJWFKta2fvaCv5N0jH+q/S3b55rF/kSCR967uZFbYVWGi9YIYxfDlP5qJDxBB
	f4263GEYPBOkWt5cZSbcAeIoBMK5VGY8GoW39xWyXN6s+H+m+k6gg==
X-Received: by 2002:a05:690c:38b:b0:88a:99a:6ef7 with SMTP id 00721157ae682-8ac978ff21bmr5593247b3.29.1790780534647;
        Wed, 30 Sep 2026 08:02:14 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ac5438bd45sm7210827b3.41.2026.09.30.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:02:14 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:02:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Umang Pokhriyal <umangpokhriyall@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2082eadbd651@gmail.com>
In-Reply-To: <20260929142238.41742-1-umangpokhriyall@gmail.com>
References: <20260929142238.41742-1-umangpokhriyall@gmail.com>
Subject: Re: [PATCH net-next] tap: report IFF_DETACH_QUEUE in TUNGETIFF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Umang Pokhriyal wrote:
> tun sets IFF_DETACH_QUEUE in the flags returned by TUNGETIFF when the
> queue is detached, since commit 3d407a80b62f ("tun: Report whether the
> queue is attached or not"). tap_ioctl() returns only q->flags, so a
> detached macvtap or ipvtap queue is reported as attached.
> 
> Cloud Hypervisor ran into this when checking queue state on macvtap.
> 
> Report the flag from q->enabled, as tun does.
> 
> Assisted-by: LLM
> Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
