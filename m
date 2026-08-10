Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED12594BD
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375988; cv=none; b=I4yKYUpSCWoahM1C9kBEgW9THNrTsSP7QnKbXfa35QaX43TOhHb4y43SH82vuYSaFBDVODNEFgxP3TY2/X0zGykbXF0r9+9Wth/1DfKJN2JZQUkq02wETSDRtI3F3QFT0kj8xJM+z6crZ23gkIxFzH04yEwSprVPIbEV+wF+jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375988; c=relaxed/simple;
	bh=FLAVg3jBfNRSDF/zBVKGKqYckKhzF97qKqgPXAfK0BY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1u9ZUfanLB2iAsEwA4QoQXCGWhnckTahhx665RXwajsauWX6byQwPaE73dOETp3rZAMMpHseismd8huVsHlTH9rOVYOJUEmMNV9lY6RbGI/1WllkurFJqjVHhnNJ1H0+ZlEGON9LgXE8H4m/qN4SiSEWkUNnkYVsieGLUC6WN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljyfKe2V; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljyfKe2V"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84eb992a881so1455656b3a.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786375986; x=1786980786; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLAVg3jBfNRSDF/zBVKGKqYckKhzF97qKqgPXAfK0BY=;
        b=ljyfKe2VEPkhgsOQC+qD0BBJr7dFZgdiSZsvjyZmJD4DHNBiqMdY49vW5aNv3ieE8t
         V4MRDvZHAGNziATPZB2ky8K5nyNZUx1+/fj34gYVUFcJmXnJI0aYAX5Qax4lDaHwiQNN
         rTnAs4140AcMb5xZ3BdEAnxF98oL5ZyzStnya+tvsdd/02kTJp66GYYAl4RvMA8ZuqeC
         QDtuBWA8fXnkFlGwfWAUVHVWozAhN44UcnLhqjyqdTmHICNct+ehpVglowLxvYDgX94L
         wqJRs8pO+bVceI4plZ2KRbq9l0lMpBGc8HFP7XEkHI5bJuQmvih8P6dzziKcidQtgkUd
         6wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375986; x=1786980786;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLAVg3jBfNRSDF/zBVKGKqYckKhzF97qKqgPXAfK0BY=;
        b=D+hviwz/XnpyXSjX7qku0DURC0RIz1H1RuWvpORbS1piAG9xhHYYPfC4kGy7edpXmR
         tAZB+o89c8+0hyninHw6ViWRbGuSA7AHytaA8b0BOrTzphCyRCtl2/ssqrymhDdaB3Co
         8f6uGeVXxrdigg/dSYtlNI8OipFFk/F4Z/Hcm2at65lQiJvM1GNbcIUkutAoxKzvsJpS
         U25W5BH/9qC8GaxWdEx4659Elsg2TCyH3oAR3EkiLc8ZyJdcoODAbuTX726hDR2J/phX
         9Azq5/6kt0f4b3djKbOTn/IsEqWNM3YrxpfVHRcJO31vmhpcVhyHHTSzH8djgRmpRBPw
         cmQg==
X-Gm-Message-State: AOJu0Yzcia9Eex7jhOUAseBOaxi8NsAZGWDJkdCdSKcCmVJ3fflHKm4B
	8piETUtH8qsprnqHU1SSUArUw7At1JdW/80mbmOgl7QiAMQiZr1MsDN6
X-Gm-Gg: AR+sD13iOzKygRlPN0hLRsXo0AK+5wKzkEFi/n7ybOIBkGSRmG1zclwv4852EPIib3Z
	lZk2kuhiZcw8Ng7OdgFK9BQGs4kclFARBZrRYhk6jcHjZrC63lTD9Mh30brr+dUr4wnW2/DY34F
	i12P2K3sKOgLotH7+fXDT60MRYbD3zheGR8i+iWMUgC/FYd9/cGA6jAUq/JTaBP8vyVzGA7K0aD
	PeAbDVSUT92kfm4FwNgYsOEP6oImbsDncTjLqm5RC5McoV5rDMRj0lsGaBnfil5hCTneRxDi3iC
	jyP6UuFxHwUw+Bh9xFTzjIRbqZ28bJ3SfUYHDHyzKwa6GKrbTYqJOjb/LPaNvmJFCFKSOxjuImO
	lrfJlRbqekdj/XjPBcaSHwbU7OYtXvNVh68T1sEAqgCUAgtH+oFpuoL5JzHOydCcu2gtzroboGF
	+SMy4bdSv3A7pXhxgZSyITSsYxDmG+BtyeMZKNgWa4ZfNrvZf+eyuvWw==
X-Received: by 2002:a05:6a00:90a6:b0:848:6447:e0a6 with SMTP id d2e1a72fcca58-84f4fdbee2emr36383215b3a.9.1786375985604;
        Mon, 10 Aug 2026 08:33:05 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a1911sm4052860b3a.3.2026.08.10.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:33:05 -0700 (PDT)
Message-ID: <6a79ef31.30c2cbf3.689dd.8412@mx.google.com>
From: win847@gmail.com
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v12 12/12] net: airoha: add phylink support
Date: Mon, 10 Aug 2026 23:32:57 +0800
In-Reply-To: <6a79e6fa.332d3c56.21a33c.bff8@mx.google.com>
References: <6a79e6fa.332d3c56.21a33c.bff8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Aug 10, 2026 at 10:57:59PM +0800, Christian Marangi wrote:
> If you are ok, I can integrate the change in the next revision.

Thanks Christian, please go ahead and integrate it in the next revision.

Either the `goto err_phy_stop` unwind or moving `phylink_start()` after the
GDM VIP configuration so fewer error exits need teardown works for me —
whichever you find cleaner. Happy to review the diff when you post v13.

Best regards,
Wayen
