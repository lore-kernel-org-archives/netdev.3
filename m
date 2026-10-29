Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300351;
	b=D8cVg6rl6EQzq4bJrPyxKqXVnboTBb6R4LcLqhU2re3Be3bg7O860ghXhuU4Jk34xd63
	 iLMw4kx0BrV3biz/kwYy975SJcQCg0LK0Nu5PzoWmV8v5JEQqydo7mfQ/XqRoqTMyU4G4
	 bR3GelSaRKKGR39vsUMHkuJU+PTh70eSb631Lm6sJYtADlmac+NAOYMB58f4ulEUCoSGc
	 x3lmOF52ej37rWeqfBAwWOFaL2I++6sfWOeOfmcMI8YMGnK76YPtp3vTONBvYtlKZKRU5
	 81bQ7rAC6yfXbDZaILJ5UaZWZioARvInA7jsWNA2UXvQe/4PnvqIFtmFJvQs8MU70Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
	b=oUvAT4S5cIR675oHPgICV4YK3+KlS4udE9AiLxEbE0r/ZSddlJWWxzoh2uU9NbgE0g2y
	 USgHTofnnDg6B1rP9DjU5Lazn+W2ZJ9nZm54zXLVPLOrpngHFqvlUowSmGj/eg3ukasjo
	 aiCnVs8yuMyLkM6NSGXGvhhIgK+1QZJKbHcSXIb8iwTHoN1mtKXgFprLoEzg+ANJA1Q/Y
	 ZbIMbayVZg8FeMnVUMnE2XZ54cC5TJdgKJnOmgC52X3xU1l5psuCdxJnnLgjj//xzfWtH
	 pZQkOij5EgdBrH0l36pzZ0auqzYmtJfp5KVDWi1dLUxyZey9r+cdDs9cmHXUMu4YZjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKHfFSVm;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE600606A32E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE600606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKHfFSVm
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so25127365e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300349; x=1793905149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
        b=wKHfFSVmSHenG0U1iwKgtGSi1UOPPzW6SwGJPjDKQxqwGUCxJEvCn1DjSm7x+7dlBI
         tUKS5X1HwuZkVolpmPhJFNwbLcWP4O2Ey+tlKOMSKe5uAIMYifWViWBMbQNK0ytgnkU5
         TxpYpjDnhF0RjngKcgEl1OEsxC/rdKP63x/HzurTG3ZCmbKYurx/pMsgnAebRGdPVULt
         X6kw74+yrE1gmuUM1siaydpKy5zusToKzYM/zlLOoKSiOrcEwuwMelyy8U+A1MF4630N
         +VRIg7uYp5Eams5/R4YrzMxIRDiBSFhS3P/ldIwkkN9aFhmNkbr/qpcLWvL6VVYZuboa
         npsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300349; x=1793905149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
        b=YI8xbS+fkpE0XUsGQCibNdmpX1xMO7kCJ8jeJFr+mhVLDgySizTjBmD8s8KeLhz/FG
         HO8cdym6Yssr97Y2AzGutmazcdiPSxVGbVTMMso1NTjZvHegjZf4L3BVpTRYiig2HzOT
         rFjpCnw6NTZaOnV9tE8F+yUeKkQPmoaNd1RBYjuylADIcXU3RbwzqSVH1StpisDh9y0p
         mnCYqaKGoW0InfSq1/PEzl8rBQSXnz8MhZY+LNdNDJzeI4LI0nzn6DXuh0W8tDQrYZ/A
         VqqycF7HGy1cBiWCSCS2ht1jX5JgALbkiAE+JjrNmQFl8kDLlgtv8xzX8J6nYF7eExZP
         siNg==
X-Forwarded-Encrypted: i=1; AKwUvBxedEb292k/xoE0V0t3cmFmV+38ptxqzlm3S9pjqBqeEoSw0wwQ+LRWdQcRAUhQWr49haqS9fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6bw3Aq2HhCsB350AvsPlYXr2oeU7UFGIrr7Zq+g2xw1NY/mtF
	9/mGPtHDsKlxkPnx9NBbNXbHNXJjBnd3y8tbHYOM88ZEDNvH4Q/RkzfL
X-Gm-Gg: AYBFou0Olvn+uGerYD6S6jhRDas7h98rQ8P/Ay7tZiXKrNpsAiltC1FQFPZdnt9e/9+
	n2krTGj6U3JpU1QpWZeTHMt6zpcAzoJMkFb270XuFbAvIb7OQDR6u+gT6YEItRwCmMr+X6DuXXv
	6Y6VKVS0BxsP9GCKh+PWnMnA1KzfplTTQNiOfk8FAv37By/AvyqJeqJqnPVLCjbcWP84c71qYKT
	UzWbrb7OdX6udzPIwrukgajicOkjuntyExJRnvkUfUnjihBQFP0fFTC3BhvlEedNUO8sQ9GlUoy
	G66OjmsYI60R5reYfNvAj93eH1OD/lzodPV1JOJ1sKr2Umht7tX6L/1ryKqh1p6vVKt2efu1aYE
	DGLN3yIWwnJBUwX+8iPnG/BsQV7nVzh3LtOvt+ZoCDUMpZOre22YR4LvRf6llRc3zPjc28oX5D8
	YYUsNtanBMwA4VY64/KxVX3zukeIqrLLFWZWBwQbtsqwNB7TpdXqlWYB7kBKGtHFgG4k4V523GG
	6hq/Wlef/Hl20UWcF0pop+mPqMjmT3AV4IKMZiXm9cPykUH/PVBJSiE1VwKvzKHv/J9KSW5rxUH
	FnZdEPey59KxzFVHM7oWkkOQOfa+LcGiSd1duGUvmsUoshwWkHaOhf3rNkavHh28z5aUjpU5cca
	l7qY1+lHzEBudAPOsyC3mQnDUrmlMLzHy4mPwFReOeMQslnt/QBAe37MKXn18vy6a2VdLm9Xpw+
	Yq4wm1YQfaaY6e
X-Received: by 2002:a05:600d:4121:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4a96836988amr152798385e9.32.1793300349381;
        Thu, 29 Oct 2026 11:59:09 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm4933955e9.10.2026.10.29.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:59:08 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:59:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <auOXeGVQG0UHeoQb@stanley.mountain>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>

On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:

> Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
>     return now skipped, correctly proceeds.

Pattern C is mostly bugs so this patch should have a Fixes tag since
it fixes bugs.

regards,
dan carpenter


