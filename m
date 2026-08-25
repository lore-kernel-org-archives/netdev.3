Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEA3F9A04
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654709; cv=pass; b=AolMz2u4lYBk+Dm0MDCqqQdG2j9PrDwPDWjYmx/uTQ8a2BJAMCvrESQSD25JElgvkKfdl+RSD75lcV4HfFRFzEV8+XAZuPzeWh8culgTxvumA1SLmaxgrjiGaHPZwibR+puxkAyX3P4D0MBmle62rpEeyJJV883fW10pyrH6gmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654709; c=relaxed/simple;
	bh=b7tRcxQ9uqlAYxU73ScNDdxC2wVeUQWIqGoczNzFSXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9QVD0Cp838GWO8tFWhNZ7xteykYubuH232oLp6bWsLxIjZhENgZTZ42CRVeUV7z4eZilQ8I/BxnALElrirw6UI9IxbAmmNW9WKyRehMlXdV5bUL3yb0J+QjVggHqPHYZZkEAv6z6B+JFbaTzDR3Uls6fegeNuLZsYlZeIApPsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY8PtG62; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY8PtG62"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso5732738a91.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 03:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787654707; cv=none;
        d=google.com; s=arc-20260327;
        b=QLpfUcLxzHbd6kjugeT2qhrrqM1XPNQ+pK7+hT3rEeAFAPlkt7CC7PkT0x44GWLIaB
         8SXaUvQk3dfvTaUeUnNurX/HKhJzgv4H1h+5lKjHezxVjSg5/Zi2nQ8HcwDPg4QgQOL7
         WpmZhDPYl01qReEcLZyJeH6702zzgDJFkEzoEbVaft92p/iwWaUgWgnCHqOsc2BE4SfR
         lVLeCe/kSAneW0C374y1juJAccgDRhoGEfmhLIist6OHx3K5JkOd6xQuhsWZUqpBxF6Q
         ccAIL3ipWE76z1IDqHO4yrgUyV2BiECt09/fkX2j81zy/evdgkjDuVaaJ1h+xJyibMOq
         yNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b7tRcxQ9uqlAYxU73ScNDdxC2wVeUQWIqGoczNzFSXg=;
        fh=9B3OdFQmK78NQNyRRxjf6yxrewEr/ghTBHdPPT82PRU=;
        b=OuCmrV1HKa8OQEKpyojYEqF4cPjGpk5dmcXYhD7FUfuvf7MI5nkhSX6P/oEySNfied
         YL58SveK260dtjwMekYf7tB+7mwaQmYh61/muPt2XGDIbGM2vdBiQAH28rgSAzbJBGpj
         SzyiMmq03o5FMbGgHZZMhQ2fLexZW0ViCiE+3YHh/OnrLD3Y0oHVCfiIktiY0AKpg9tE
         YppH0Nz84WXw3O6dP2mp6iXVsoSqD/q/0OrWOxbRU9grFelSMkfRa5fFFYKQ2U26WSxr
         LNrlFWUtIBg85/eseuzFCqpE6HFEzh9fZxUlu2+S8BR/n1bYjMe7tsgIyas+VspFl1Yy
         xJkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654707; x=1788259507; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7tRcxQ9uqlAYxU73ScNDdxC2wVeUQWIqGoczNzFSXg=;
        b=gY8PtG62HC07pYeZr0jrfB3w27BSJbnAsGexAhLGJAu+GmLDQSDfbsgcgF35MJh4pd
         HGC6F73haG6EF+ue4i6pdgyAjqPnTo2PRHi6CtBlzSRmPkj+ODFLwqjVXXSDqzgTT98y
         pdOrYZRO9TZfhC0deg+JrdgylrifcThXorkIeix7XUUuB4HNJdJxxLfKijZQ5KF4PIe5
         cSD/CjJIjYAo1IVoxTvIVXBCpnuRqDQdXBVIutPDE9FddbHvR2J4ZMEtgJ1UdqoJDuMj
         lLjOVqkGPMXnUbQD/F9jj2ztN/9Mn2+EHw5MXQK9nPylfR3nly/sCIY2JUXXif5jpVnl
         ugYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654707; x=1788259507;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b7tRcxQ9uqlAYxU73ScNDdxC2wVeUQWIqGoczNzFSXg=;
        b=QV1gq4YqnIb/eyyXax8cK/M5cDI1S2fvoer0HKtw3Cvnj71w4yEqb85BEr7f3JD1we
         nVM4lTZvsDmvKFh9Gi21iYBw5qu93HixrquUrR2qmk7fDSuWt58DQUhwIwmBaRej60Nd
         i7xs0CqRhyjuPmC/01ncNoVvHH5SrGTxltUz+pt8KLvypoLQes1Ya0KvfxFbbClgEG4I
         R/dPXjRm9kNOxPsQ3amAPW3OuFj6fdUObmf5SsAZn/gQlK55fYV/rgnJ9axYWPvTsfei
         vwQXDrwgwOHmoHWkDwNt7GWESU8QpC3PgXd3Rack+fUR4ehdkKOdp/UYwfRJowdKyMUo
         It1g==
X-Forwarded-Encrypted: i=1; AHgh+RoqVJhI1XEANSlv7GapOquy/75Te3hFjPP3Jb650xE4wvedrLY0lcBxujC6H7MAgbvXxsbBe6E=@vger.kernel.org
X-Gm-Message-State: AFuF++nGpRYWe18TDOaOpV3QbDZ/aOjZqTTjQ0dmvt73EgwPzaQF+1gw
	eR5gRL7RmL+0utl9StKcwNgl+wzZpuXtteYxMgCz2KCg1bnvyP8/s78h3K7DSw4cZv9kx4jvivE
	jzr6D+vpA16bxsZxUOR63weqg5sgfX9c=
X-Gm-Gg: AR+sD11Hxys79P2cnpWvxcXrsL4DqJcgICMF/NatKKoi5TAAGvsrvhCFVnfttUrVH6p
	sht4gRRA4KktX7vYjh6KjfPWoLWxqChjDvGwQnFXAXd1yJhPuwf3SsZOI8kafJXTJNLbd8GmYqJ
	tIjsWq+ZTXo4runc8RGl/6Rv9LLjoXKbnB/BfJHsSKzra4BrXhR7+tEyo8LjR/FqPiKzEMiOCWq
	rQnLRGpyFr5tgeC0AlRhVlASSdEyrCgOZEDQzR6+6biIAJCtqO+G9/7/8oUHRMRAa7BDsl3kGaO
	4s+I4Rjd/D+QDCNVbVtNeYa6UYf9hFS8xWecOVj/9C9VN5tf4ncec1DUTOrFxLKYkpMBkpT7Hgm
	MUJQEFl4Y0cNEFfOkQ0Yl16d5m291R7WhKu/3IVhVLgyu1og5hChyupHWHf7Izplb5b8=
X-Received: by 2002:a17:90b:3b48:b0:393:1cf4:d972 with SMTP id
 98e67ed59e1d1-395dee55f7emr43701740a91.3.1787654707353; Tue, 25 Aug 2026
 03:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824100901.31675-1-phucduc.bui@gmail.com> <95b5fee4-70e8-4b2d-96fa-bce267ff13f5@arm.com>
In-Reply-To: <95b5fee4-70e8-4b2d-96fa-bce267ff13f5@arm.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 25 Aug 2026 17:44:55 +0700
X-Gm-Features: AcwNN1XpjoADkpBZBVR3Op1a_LHVleiZBaqWEnQq1TuYD8o94K4gAQB13ZUSpAM
Message-ID: <CAABR9nH0jv--f7nBSKy7RDapiCcr2BrZbOG=CVwMev15iBO01A@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: sun4i-emac: Fix IRQ error handling
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Stefan Roese <sr@denx.de>, Maxime Ripard <mripard@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andre,

Thank you for your review and the Reviewed-by tag.

>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>

Best regards,
Phuc
