Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674185;
	b=P2m/8hgc/aOyhAdTLVG+EsmxGlN0EKm+kMSQDF5/Yx5Upi3WxUg3C0a1dHX+uhcL7EkZ
	 IjBPwl+9mSet36OyPrUKrZQAn7NeM2SddS1FQUz23CrUxM34FV4L1tgrEsHSQ26imTKMy
	 ctUs80fz4JZSXMtnrHoJJvdFnl5Adarl4wSRo1SdmA9mqtmPLqe/KdL1eUDR5hQnl6RLr
	 jba4E632FcLG86EUMKjy4/9eDRDb2z5+t757MItK/kDIGY5siQwdP6U9BbgKXiXKGI67P
	 beeu3WCBdgbEISio7hvwce/Se3WwSZxIc+s1HJ5qbu6o9f7cdxlf+J9uqeCjq26IECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:In-Reply-To:Mime-Version:References:
	 Message-ID:Date:Subject:From:To:Cc:Content-Type;
	bh=H9tx950wW5qpb07mAQg8D6SCdE/j6V/bE1PEPRR7rkI=;
	b=Zb7bQxu299BITcpMu+zxuKOrtxDdMUs4+8bfbV5XPgZHrIiqRFZefiD6eIqsf6ikImi7
	 q4wcMr1XLIZGsIeBYPrle2bbSpbURwV/orSfBoF9vroHEAD42nM/yzKpeSf0X6khVHlWO
	 +7Y2578KPKE11Y/oY7jZJDSRLgrlvuJM9HaVd3b9FdfmXt7gp0jhCy8PSDzQxBHz4bqaR
	 GX56fVvXFC4U3RQGz6XZtO0A+npdpwcwV/HcaI6mrwLK37SOxgfjPA3LlrDdpcoWOScKT
	 sHpyO9gbyxLwp3YRSMQVlZfUMib7uC5ldk+To14bYaYfKJXJU+Vg0Fr/SSNWtkSMpkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N7TFeiY5;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BA606A33D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3BA606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N7TFeiY5
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3552883bd19so50670eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793674184; x=1794278984; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H9tx950wW5qpb07mAQg8D6SCdE/j6V/bE1PEPRR7rkI=;
        b=N7TFeiY5LJLEgZobylanYNUZPEf1kbQVFW6Xlz1kOhTwnaOf8Ax/HEEArmiDDjikx2
         RmO0mnIrrHmQrdAULkzEdEJXb5Vq3BvHytrW2NF9IV3AYPr/NAl9Zg/m5fg6EF7FpShg
         F3BNWlJa50YxFxEQaJ94LDQHs0KYVPutiD8tWnZe5BD+/2KAVI8WmbbZru7OpcDuJm0y
         O2VnfG7oMNTMwznnvTyvkSGmnmUu17AY9+tBWuzyBU6C6zMhsIHmhZhmJYmVhVU2k2Gf
         +/mb8L1bHLIm3gXT0iKjbSrSnpB3JODVdIagqDAGmJ7SUhOAfTG4lfxsm7Yqt/cytcPu
         lWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674184; x=1794278984;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9tx950wW5qpb07mAQg8D6SCdE/j6V/bE1PEPRR7rkI=;
        b=uSAtJggyoo+BxlX3aUdtJg/dJ2dIpWN77fsvpqmMTuF07I+yCPsvpLnbMyUG60R96i
         dm7sed/q0DchrtULDcXqphZX1VMeZVSX8w9ywH6s8aU8JC0Inf8tyG08yJJC+ojgsRSG
         81l7XCyVWi+9GdUQr5cUI/dscFv+g0fkmsoKOlHXULSJXrqB00YwxLvsiYcqe/mi6ZJB
         3uoUxu2+v+qhxRWwzsztHUPbOCE5AOmXLB1NAvYSyath5146Srl3gkOeL48pwN+X3oWw
         3B01uq325HKxq5KF9ObFkEyWOl5HKm5PuFjcBdVh2KetnPE64VxDP9jG0roecnFziz/M
         6Xxg==
X-Gm-Message-State: AFq9FYKuwU72fMD1czxKPrZIqIYEZOYho3zJYmcIoii0jheijuJsfQZT
	u6nRBZlLco2PU+qQEqTYq+FYTxNwaeV9JUSwqSKyrzU65gPs1yKwSveDyD+8bbwHGez7A6ML9id
	gOE7USsIG30ec/F6Q0pVhpJC4FA==
X-Received: from dydxu14-n1.prod.google.com ([2002:a05:693c:894e:10b0:343:520f:7a80])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:42c2:10b0:185:1640:5536 with SMTP id a92af1059eb24-1ac5ab52fa9mr18880545c88.19.1793674183661;
 Mon, 02 Nov 2026 18:49:43 -0800 (PST)
In-Reply-To: <20261031162804.1893-4-maciek@machnikowski.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261031162804.1893-1-maciek@machnikowski.net> <20261031162804.1893-4-maciek@machnikowski.net>
Message-ID: <18e4692aaf1e13b3.3137322e32382e36372e3935.15909c.0000sendgmr@google.com>
Date: Tue, 03 Nov 2026 02:49:43 +0000
Subject: Re: [PATCH v11 net-next 3/3] selftests: drivers/net: Implement ptp4l
 sync test using netdevsim
From: Mina Almasry <almasrymina@google.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com, 
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch, 
	vadim.fedorenko@linux.dev, horms@kernel.org, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 31, 2026 at 9:28 AM Maciek Machnikowski <maciek@machnikowski.net> wrote:
>
> Add PTP synchronization test using ptp4l and netdevsim.
> The test uses the NetDrvEpEnv to link a local netdevsim
> device to a remote endpoint, runs ptp4l as leader and follower
> on the two ends, and waits for the follower to report the
> synchronized state (s2).
>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>

Reviewed-by: Mina Almasry <almasrymina@google.com>
