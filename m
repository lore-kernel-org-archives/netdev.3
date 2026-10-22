Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792641155;
	b=pHOH47gIYZYFRgBpCVBOpNZoOgNDohqlRBVlc3v9QF0UuTVCk3AmZkPEEooX00Ze/1n8
	 JSFHpcdNtAjRfttWlZqk/pQL5l/jkKQV0LpUU8PCiyhxSfn4KaBWv4Mmhc0ka/Up/J1Jh
	 YrlYKm8BrlhmejeEyRXkUYvYh48112WV20RFrqPZQ/IVobp6wHSxHTKsZI2B31dcK0sv2
	 pvLJu1Y1nqLSPL+k6GNzSO5Sp4ZQ5QWPfm9Fy5uc0EBKmQOAN+q8vjxYXD9P8CaLzEkx5
	 QANBIOJYN55TUHuyn7WRSL4u4GsP39R/AZn+OkouuQau7cXl5MeObR1bI1TW2/YVUMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=m55ckm2hWwRwlWXje/91Y/X/pTafwYoOrwnzD1J7sek=;
	b=e8pAdOCN8FKUWMEPshtknP0x2hS0eNti1co5tN0xE++qrgutD+kpfD7bGbKVqAfmpP4h
	 LLXpoouIgdPKTCm/HTMefGMUGZIQu5pOOEDqvkhdNpLiPOiVdfqy3ubfoUm8ulK+0H7WM
	 CbjTGjOwhGRFNQ+IoIu2rDHM33JCLgj1WVHUl7fLByeU3lv0er+WD7jjmsfv/u0PYCXQv
	 gP5Ap1yDpNMmSjxTuVr7MPoCl5QgNu5uAzRJKKAPDBgwVYjds3TZ6S9oFRFdT3Bu9RTX5
	 LTvNHemS6CoU/8zvhl8DcwPpVRfUBrPZnopbYMWNebbVyW2uOuJoh9WTs5tcNzbaeoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=o4jg0qH9;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B80606A325
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B80606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=o4jg0qH9
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso830984a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792641154; x=1793245954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m55ckm2hWwRwlWXje/91Y/X/pTafwYoOrwnzD1J7sek=;
        b=o4jg0qH9RepSu7e+y05SP8CWFOwSfBHhQlE487zCf4bGf4DUd4KTlCdlvc+jsQYlJx
         +QWa0e1dnazLwmK/hO+1aYt97hIIMszuKmFqEl4YtuUI1LySb7wUyNC2QRMfefBv6VQw
         Ipmlf5A+0CFM+Lk8VlxOTV2zQujONn7z//HXM7/s9Z10y4Y1EBeXI333ziO4dD6lMZJc
         UqYDwlvcfI7OXBkp8XxxX93gH88BoA1gA2WWwexXH4pnjtrmAFiVDX6uA8h5Y09OtIhY
         OO2aExVlI5/f214dwqGz5j0aEXTFe/aabGskJZK99bBaNPV3AhzRqtsvBNHIrWw+fGqb
         mMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641154; x=1793245954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m55ckm2hWwRwlWXje/91Y/X/pTafwYoOrwnzD1J7sek=;
        b=hc9xJR5sQNuCBxvvCHx1pJMUTJ4KocOHhTG0dr93bKAhOQTroloOHJum5j7nu4fhmb
         pmWbjcQj6P85mutVP9+W8WCzvfASWDo0upwShslUGKu/gXJYnZu0DzGtMoLTwFB+5pAo
         3jii9oBVyfWAS7hhMafJMdYZv0tq0ihXIwSYIVY71W1wT6M0tGDymz0tH85ohKGnCMx6
         EI+rQxzptn7LB3T/H6vvjBhdHYkUrLVapMs80KyylqevUZEWEWlGrBzgKfMcKjB3jSUy
         p7cLzN0AMeV8xxDP3ncEVNp1A6VLkh2EAGDKjYPD/egtTzwUSpqMXJxyXstaXY79DyaU
         qptQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPJ5KJ6UcEvJB7Nb/phWL/bR6VyA4ojQm8pJwDb0rxQ5TRHWikJwooIxj0OBiIzPO9/PPYrD0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAYSYWBHXPbFPy4QsAfgicTshJ1EbSe+pFSGzufe0K4ltWyUDx
	jqapJHKZWpKe8ZdE1k9fHWiij2KAeqKXIKU2j7a1Vm2G6eATF90dmAoyeqF8HfQ+eA==
X-Gm-Gg: AYBFou2ntd8RTcJHrlFXZXTm6NKjfaXmSMkJLJ7bi6IhTsXpaZs2sdJlObXWaZwvA7M
	ywUsKcGgzf4vPS9gtq9ap3v4GvcUHTij1ne0b09jyimXuQ4KAh2CV7Zg/FhCE+9JCUoFQJ8q5lR
	toe3QwJHdyi9glbYLkKxQm4RzAJYAmMS1hO77SGHWQZ6S5utpPXCp8Yfdo7bzfrlGZ9U3/gudik
	FRLUXbpfs8X2UsOEdybCpWqk14FTfYyalEoG7GW+YF0uHPjLBjA5wNMxRbjMRm8+q6cymHOsJ3f
	RRqlox7emmQLNhXRvC4AvFAKFHAfKzFLVK37iKqAyjOacMHJI09JEqOoa4RPZFvvHj+sPeoawzX
	j9cL9YVGsmtoj5JaJ8qHMD673+zNEa1QHRySEQ3mEPJEGiBvtMIPsjo6+7AgIL3p2Y1WitQa48R
	Kq8E79SV0f8lzzbz/zg5p0BIj7eh4/nSu46rss93VRF51npq4ojCe+j0DEO03ouaQxS4oBq5+X6
	uFoCNT0xggc21ctcbuQD8O83G4a196MIUfqdok8RLGSbbgIP/pgYzNxshQFjzEnfbWWYN1DaHR/
	a90jTADmAo22/lTEELR89Fvz7pjwPGJn28lI27eJZx/M
X-Received: by 2002:a17:90b:2886:b0:3ad:818f:3daf with SMTP id 98e67ed59e1d1-3ad86ee2eecmr3201690a91.14.1792641153683;
        Wed, 21 Oct 2026 20:52:33 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b85d56c4sm588649a12.16.2026.10.21.20.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 20:52:32 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Chintan Vankar <c-vankar@ti.com>,
	Aksh Garg <a-garg7@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl
Date: Thu, 22 Oct 2026 10:52:26 +0700
Message-ID: <20261022035226.1388675-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179264023362.3135.17895429756190814680@kernel.org>
References: <20261020003525.1237742-1-jjc@jclark.com> <179264023362.3135.17895429756190814680@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 22 Oct 2026 03:37:13 +0000, netdev-bot+sashiko@kernel.org wrote:
> Before this patch, supported_extts_flags was 0 for am65-cpts. A v1 request
> with PTP_ENABLE_FEATURE | PTP_FALLING_EDGE, or with both edges set, was
> accepted and reached am65_cpts_extts_enable(), which ignores the flags.
>
> Now the mask has PTP_STRICT_FLAGS but not PTP_FALLING_EDGE, so those same
> v1 requests return -EOPNOTSUPP before ops->enable() is ever called.
[...]
> However, the commit message says:
>
>     Only the PTP_EXTTS_REQUEST ioctl still works.
>
> This suggests v1 behaviour does not change. The patch has a Fixes: tag and
> is likely to go to stable. Could the commit message say that v1 requests
> carrying PTP_FALLING_EDGE are now rejected as well?

The sentence that Sashiko quotes is part of the paragraph describing the
state before this patch, so it has no such implication.

With this patch, PTP_EXTTS_REQUEST rejects a request for PTP_FALLING_EDGE
instead of accepting it and reporting rising edges. This is part of the
purpose of 7c571ac57d9d. The equivalent bcm-phy-ptp fix, 3200fdd4021d
("broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl"), made the same
change without mentioning it.

I don't plan to do a v2 for this.
