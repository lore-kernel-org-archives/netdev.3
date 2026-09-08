Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8C4B0498
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864976; cv=none; b=SD8k/Lyt6N69ngwVZ1rGgQZqAR1lwTBuFkb4rhswbfsXR2ny/JbyMbxLVJbNOxL2gF59E0A7NP195JF4KYTZM8kpN9IKZZ/buTu0kvg1UP0QuPtUR4ttkF30peWb4TOJ3u2qpjL2Rps3JbPhBDD6iZVxdh89zmWimaiS2+FF09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864976; c=relaxed/simple;
	bh=/8AhwESYyYXwQn4Li5Y1+Xis2fZrk+wATp2c6NdBL00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agOt0bn7sXUjCezvTdwtSunFZ4eOBnPQNVUKcvy+1KpMzzxtcwV+qLEnCQg0WeT911zO5FfZx7khyVxcH3ueWQP37/UIegdNkLDasUtASCVr6hDI6E01MpmCnG8X4o1RG+JO5TvrQrTZUaZlZ+0qcK6I3qz2GT3ISlLikL07XG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9OMEnb8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kXg+zACV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9OMEnb8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kXg+zACV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788864973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaMyuW8KF9F3HFowkh2/WrayeRSxnxHHojYH3W6wWUg=;
	b=F9OMEnb8lRi1PoXQUEhdpYRZqKhBEs19jwzRhLXsGF38dXIowi6InqkoKCcVB9mNiSlCdO
	2iONaLLzJGZzf61/UP+aF6zs+XhYkVXBEUNANnw8Cp3J2eelP8J+kpfe1Il6G1rvhpfO1q
	uN01kaWKjMRqiE0GgXGF+6Ml4nAqhRc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-xGbEXFfcNwuqTSrmlkDqhA-1; Tue, 08 Sep 2026 06:56:10 -0400
X-MC-Unique: xGbEXFfcNwuqTSrmlkDqhA-1
X-Mimecast-MFC-AGG-ID: xGbEXFfcNwuqTSrmlkDqhA_1788864969
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49cced8309bso42577925e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788864969; x=1789469769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QaMyuW8KF9F3HFowkh2/WrayeRSxnxHHojYH3W6wWUg=;
        b=kXg+zACVjJl2mWp0kg4aPgYNXWghhAwglMCkrKSmk6v1Gt9+Fxc7F/+8iL2cYV+SdH
         tVz2LvIWOsmu5+VBYlUnsgQ+Ehzjt5BYun/VJxaDCXAw1Y0mn/fAm5QfoySZAWS7O8uo
         NWBTJ7Q7fqpgpOpmaAsoVzxSjrzaD8shqfSwzE8+kytA71ibVSkLKT4hUWnaZMg0/Iw6
         +oJloW7At97/hJlMbYAPDQ/Gu5vHZ3gML3EnMWjCxOTtKofn+NuMa7HKCcNthAq5AucK
         tBfteheoEDECRo2HCxxiQ1gWMJcDzeGxmvUZeJ7rQfoEUYYWga7Qh0tX78Zhv0AehlD9
         tqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788864969; x=1789469769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaMyuW8KF9F3HFowkh2/WrayeRSxnxHHojYH3W6wWUg=;
        b=mY6+boTgfvleQqQVAY8oNIYO4i+8yoeEDdY3viy+sDqVpCs4FXhcX+W2qX66diaX55
         BVdat+7lELuIuqKQoc3h8Rr26CIt5JLsZR9fMm1FbEDy+rQlZHkQebw/lm0WKkl+Kr4q
         m+EBObWf8cHfAL4kzlu1MyKCP6z8LGcAZByfROwb8s9XAFwefS6SCBrN3uZOla2laay/
         P3LREY07We42Lfwp4OcqtpdE6UwhTOiLf4PbD3v92G4aJHAem5xMbpg2v7TKrWJY4nda
         CdLttu97NUtQm+tAvAqWD/wnYI2s/phwQDX4QSGwa4JsxkD4qNvGQzs2d1dvOcK0TuHJ
         IdJg==
X-Forwarded-Encrypted: i=1; AKwUvBzlQQc6EmKtRjIFeFW6MSUSrI7ggIwYKTJvc4zG0ikB6/HCGxOagdHz02mAInWLx8Q4qrAjvfA=@vger.kernel.org
X-Gm-Message-State: AFuF++nu8tDAF+/E90CsEGGLZZPPGkKjw+utSaJAGKvWGs2jcKwZpNH/
	arJMCgNWES11bC4cwWl6YJkrINMukAniqixrSz9pkgsTxTJxSnjkVs0dXMBp8/IHk82++7bx0yN
	BMBuyC4CsyPM3e+QiCPrIh6tBuT/BvS2Ny31UdysNjGM8Ya6J9uhE7t+7WA==
X-Gm-Gg: AYBFou0ifEIHX+f535VX/TQgM446aUncUNVjPovIPWCnSvr8ZIypLO0I0q0L72zkwAL
	g4QVaYGE7LrwO4ieu++ZejJO7GanxW7AQ2eCqlpYZxf2t9mHd185q6eg1LhQ88mwhVE/xTzca+5
	Xtr1XumcvtR7REBnxbxTtTWD1Zc+gBhjT83tnSqzF/vHA2PpZB7yJIa9odbHT8HHA7KhYA9S+pg
	Fv6Y/yVlbN0GrIzuzFbXh1NA+4CryLc6lAY9zfxfiSl6bpWx6UthSwG6Cn9zdkobZ9LkbLrLase
	87eLBlPLJkgSw9pGVCsxWjupbptWlUbwlpE4nWMpvSK1Uoqb4F/HkEDiznGKm1pZkMTIAOPvyOt
	+ygxttboNGxcit5BWFODzjLu0eQ9JhwK82opmKnxOjVc4QM6ltJ9AzeqvI+zxOql4e8AA0eHGkg
	==
X-Received: by 2002:a05:600c:530d:b0:49c:fc6e:8cae with SMTP id 5b1f17b1804b1-49cfc6e8f24mr227755825e9.18.1788864969339;
        Tue, 08 Sep 2026 03:56:09 -0700 (PDT)
X-Received: by 2002:a05:600c:530d:b0:49c:fc6e:8cae with SMTP id 5b1f17b1804b1-49cfc6e8f24mr227755475e9.18.1788864968962;
        Tue, 08 Sep 2026 03:56:08 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm31013106f8f.2.2026.09.08.03.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 03:56:08 -0700 (PDT)
Message-ID: <ab90f970-0ebb-4c07-b7b1-db3f91395116@redhat.com>
Date: Tue, 8 Sep 2026 12:56:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] netlink: specs: fou: local-v4 and peer-v4
 are big endian
To: netdev-bot+sashiko@kernel.org, kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 kuniyu@google.com
References: <20260904191412.3872344-3-kuba@kernel.org>
 <178880846466.219967.3542374542122357419@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178880846466.219967.3542374542122357419@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/7/26 9:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> - [Medium] Switching `FOU_ATTR_LOCAL_V4` / `FOU_ATTR_PEER_V4` from
>   `NLA_U32` to `NLA_BE32` in `fou_nl_policy[]` (net/ipv4/fou_nl.c:21,23)…

FTR, I think the above may deserve a follow-up but it's not a blocker.

/P

