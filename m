Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210B3BADB1
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933006; cv=none; b=ITnYtHlyidEDwCIbaoaDnhKg8mtZnnkqpGH2Ia6wZn+cVPT+ir/Mn1q4amC73+LM5WJdhEGizeAdLsCz5n40EtJvXNoDXWm0vjeoJR7YFYYDaEfAQrrMNRg7WfS96uYUAxAiwHfv0Ro8HJXGh4qlXQAaxt2XV6y2D5K3TJHgQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933006; c=relaxed/simple;
	bh=AvM3Cgy/Ra73nGrF9esWzL68qEBWFII09uJw1zMVULQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKRvioC3G3KWNWhb30Yi+KNPbixF/Pd0cyHbuyBvHnrLgjb0anpVFp2TgfVhdOrFsnWnSVl8G9YZIdjU3y11VtZ4tnkczGsxaiziJ4Yq0b+NZvBi3uUGoRzlX7NYr7hQVDDH9/RX8ZS2vnNqcTTqpUkAx3xaMZ0w+TbdzMB2Dvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Sb3YGq+6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Sb3YGq+6"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so27173981fa.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783933000; x=1784537800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1nIX3sdRj3FebWw4JZT1K0eCGVCwy9cixatVxw9QSU=;
        b=Sb3YGq+6+VLMioEzFI76UWcYJ+j9aqpJyA06pp9/iYqwgAeld3dwSQ60rL34sD8zZz
         iDOgEmllxEV5xMQluyr2xMZG3ZNrFOffg80O3AJv1EMSdyWop7vsSWpEhC7RveAk1b7c
         70i7VEe1DEYElCNevI1fP9u0LEeHUtm7GfPeY6dM6y7BCmcNw9dIlLe4SUisOE9AzbS3
         QZEbP6P6AEi1g0KiWhH4m3TlFk1Lj+hNsYPX4+ozxbSUEiZ8Yl8vQ+Pu3n3DQqwNDDBJ
         Povh2qd3WDt2/RMKSoWSwywYgcfGV1msrW8twwr5ID/4mvVfnr/+wooGIK4MvxMMHt8T
         RhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933000; x=1784537800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1nIX3sdRj3FebWw4JZT1K0eCGVCwy9cixatVxw9QSU=;
        b=H4wqw300rJCKcNx0HmvDPIcArC5Bi8WXEbB054v6Qf8hZcpINGVCV03eZub5CyNHdV
         D/37NZTe/96MgYoD8G1aWp8hSyZy8g7L2n+Lur9REJyK+eMFUjHav+dH8wcTFMxW3wVi
         MnQ0Tmd4SxLn/QfTRi9leWcvEDy78wu1lToXGTYKhIK/UIs38eGin6xZYNsjI3rKEHa8
         QE8KcV8rHGk6NJhZcZr9fzvvTJfSkLvsnDcVlAn56ByhehUcKaVUxK61/7mHWZD8ezqq
         MevIn9ET6i+P1KrXX1pnJZ59cZ3txg3TQPPANpIseljh6aJbeD3xkNw3/S8KrpH4G4hx
         CNdw==
X-Gm-Message-State: AOJu0Ywd4BXBU9BFprnaGvEoJoiHQuLthQLPcppD6vBrDaXze5WNgr0P
	tdcbEp3kjOEbDFr04iSWK8LaZ6IpYVxbqdCeqDOVTisGGRxsr6VcRWwf98dJRuGwaxg=
X-Gm-Gg: AfdE7cnEk7jZ8YEo0w4f5Ubch7j1KPSL4MqgV42xMxzcwWZ2SWGg4ZPFpI/xa3i0u18
	sJVD0zxHexBSddCyK9vb8M5//j6FGgFf03g1P5TjFNvsUGq/BJ33j6yvZmZDl6c3ZcY2IBaOB7X
	APojCjiEN6XbhJgOBTZS7rpBiibr7CBnf565PmormN2nGpROVtnSDaKGrhJnfqftnryF0li2wh0
	KBrU8eEKnXDCjwzNMXm4YkSzgY6ae5VaqOevmgP6c+aCeWJxQfQlMvO58VZ8zyEUQ44cz+QmpVc
	3ApUwD6cGPnCezp82usFoGdbB8GM9tPJvPjZCLYuTsM37F1H+3p2KFmC1bIydIOdfDSydEoQIaT
	YVAx0SjZY5l4H2xVMM9dN0Ulb+2aaZIDzS4PSV64ObOEwArC+RrRNDJbSnp2IDvzgAnTzpcpZAB
	dH0aSQD07ffKWVy0h+Fi6pfQ==
X-Received: by 2002:a05:651c:b28:b0:393:d6dd:e8a1 with SMTP id 38308e7fff4ca-39caa807641mr16871121fa.2.1783933000242;
        Mon, 13 Jul 2026 01:56:40 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84bb0a36sm26676391fa.41.2026.07.13.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:56:39 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:56:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Milena Olech <milena.olech@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: fix NULL pointer dereference in
 dpll_msg_add_pin_ref_sync()
Message-ID: <alSoPTmMA8Ge0HAX@FV6GYCPJ69>
References: <20260710193625.1378822-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710193625.1378822-1-ivecera@redhat.com>

Fri, Jul 10, 2026 at 09:36:25PM +0200, ivecera@redhat.com wrote:
>When a dpll_pin is shared across multiple dpll_device instances and
>those devices are being unregistered (e.g. during driver module removal),
>a NULL pointer dereference can occur in dpll_msg_add_pin_ref_sync().
>
>This happens under the following conditions:
> - A pin is registered with two or more dpll devices (dpll_A, dpll_B)
> - The pin has ref_sync pairs with other pins
> - During unregistration of dpll_A's pins, a ref_sync partner pin is
>   unregistered first, removing it from dpll_A->pin_refs
> - But since the partner pin is still registered with dpll_B, its
>   dpll_refs is not empty, so dpll_pin_ref_sync_pair_del() does NOT
>   run and the partner stays in the pin's ref_sync_pins xarray
> - When the pin itself is then unregistered from dpll_A, the delete
>   notification calls dpll_msg_add_pin_ref_sync() which finds the
>   partner in ref_sync_pins, passes dpll_pin_available() (partner is
>   still registered with dpll_B), but dpll_pin_on_dpll_priv(dpll_A,
>   partner) returns NULL because partner was already removed from
>   dpll_A->pin_refs
> - The NULL priv pointer is passed to the driver's ref_sync_get
>   callback, which dereferences it
>
> BUG: kernel NULL pointer dereference, address: 0000000000000034
> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:zl3073x_dpll_input_pin_ref_sync_get+0x73/0x80 [zl3073x]
> Call Trace:
>  dpll_msg_add_pin_ref_sync+0xb8/0x200
>  dpll_cmd_pin_get_one+0x3b6/0x4b0
>  dpll_pin_event_send+0x72/0x140
>  __dpll_pin_unregister+0x5a/0x2b0
>  dpll_pin_unregister+0x49/0x70
>
>Fix this by skipping ref_sync pins whose priv pointer cannot be resolved
>for the current dpll device.
>
>Fixes: 58256a26bfb3 ("dpll: add reference sync get/set")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
