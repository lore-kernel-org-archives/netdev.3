Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A513F4100
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807269; cv=none; b=fHrS32aB1kWhk0fjSrc72Tv44hYPcDXL2hsy4kHU1fI8e5YHzcg80FXcWcZtnNIs1TIiuAmHDlz0k6KHSk3GE6LHtnp9Q5EwA5Z0U49RlMAZCTJpYRuD99CT7jDCUmGjjanagWfHxtVcNHmk67M7OTiJpmXWWs8auFI+nofU8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807269; c=relaxed/simple;
	bh=i/QWSMozynqryjWo/KOuPiAM0mDpRUXW8SIwUc1XYZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEcZZkCNGUpCSTni8jhJ0sFoxXccY6XmTt6WdxkegnhWDY5ISH1E0dkMvQGdDx1VCId6ZSuvnxAZeuyq0HXKipcqPyweuNz6ERffh/4grwRT4FK5UxTc4feNpOsdaljpdGwG8egbJMGObRo7M3qsV1oYi09Blpo9exOaNcP1O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqAc19zs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqAc19zs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so53936405e9.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788807264; x=1789412064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i/QWSMozynqryjWo/KOuPiAM0mDpRUXW8SIwUc1XYZQ=;
        b=dqAc19zsd6MKYWD7s6Gywe8uw+ikai1be+/x+g6YUL+Lihse5eEllxe2JzfTaKX9QK
         OVoBxKXdpYYc4X0rN83JIVFwVibAFknrTTsnmPn+7Wybsz/It7fHlYeI1HSUgR4LU/CB
         BBPXjz4PXmHgNWXkYm/K1YbuN6JUGcUt0pfDyylyS5SK9AOBq5W/o4T8OarU+YRHlVk+
         ci3UFRX9nnLICxFfF1LEU3OtlxjsW0f34cU2IMLvmgpuPn05Kfmj65rmQvLqnDUVVf18
         zGksrEF1mCbdkVdxUAltrWt0c3fHn86J7VjXbPGWGiLOuTnmqyVEBvZqoCc8furtz8xV
         Roww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788807264; x=1789412064;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/QWSMozynqryjWo/KOuPiAM0mDpRUXW8SIwUc1XYZQ=;
        b=AlNcKVviYH/+jQJQhU2xkoh33sAgblIte7aHZFFWbHFDuOO38AThdQwI+KWJEk1e6D
         P6ojvRWyuZT5wKgphgwVu6FycTD2QRI2mrj6e0ixzLoZTS04ecAlaA9Onsr0rLd8MhXq
         jfDxy94j7vLubsOOg89mdA5HGVYUGluJDo7MwdwDYsH4DIfydNT+px+6BOdXlKaNSLro
         rg0ubs9qHyxxKFltHUbetWuqVIRaU2bAPLMt9l/GasHUDrk0J+BhcvhZ9jV6ReNcXgHD
         i5WnyGaJJz9NYIDbd/2wq9mHceVkwDjIhM7QhQgCZ8QQNFMxuSVzVPvJ5GFC6Eboysd6
         mBBg==
X-Gm-Message-State: AFuF++lDoKg5+dKlGSJw2e8g0RRSx9QkeqEVoVYq2YTLzDDeksOb1IWs
	mE9afWLEseLd/WkByMiKs3XBPNwD9GyrDTi6FtrzfLra/jltH2oXddGd
X-Gm-Gg: AYBFou0BdJXXTOMc2ci8/cCD57b9vzhbcNgvs+rebEHOGXowK2wAkNUkkMbLT0lq0Ao
	/8cqCCGsO/KNk3x9KdICVJ1a9PPc6GtMoNO3/QdMv6tU494zQ9Nl5OwfifxHsYJdKd7Wn8kgauz
	StC3CRjTkmozWFo35f1Br59xTmzefUM92NVX68bL7NYg1i7kyPz1beneHrq+XMn/jVHIOkcN8Jq
	I53o7nR8R10cySHg7HFBUqRVmopzKEguNyWu+tCpV4QoSHWpHi6hNVcCE4Rid15gNiaaYYgv9Qm
	56EuRAiqXjbbkO5WNiz5T6jaaWrVG88ISDB4BLJDYiMJ6eDp/wPfSmb/vUqar+3ErQ7DZe1Yx8Q
	yH/5iE9if0TAETZFXM4WMhM2jkrs2Xsl/gZ48xKfO7CpBOzcN8+dfMmSM2NpAQI9fmZj/FmiS7z
	Uup4YoNE2aI1ZHnWlyc4yN1fKD2ucOv6hKNlKNVBZSWV6AfatiW8tSd3gYCQ==
X-Received: by 2002:a05:600c:628c:b0:49c:e1cd:536 with SMTP id 5b1f17b1804b1-49d17a8745bmr21185385e9.12.1788807263643;
        Mon, 07 Sep 2026 11:54:23 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00031c95sm295060555e9.11.2026.09.07.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:54:23 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: oneukum@suse.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: Re: [PATCH net v2] usbnet: fix smp_processor_id() use in preemptible context
Date: Mon,  7 Sep 2026 21:52:20 +0300
Message-ID: <20260907185408.660755-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6e0dbfed-cadd-4274-8165-886725413d0f@suse.com>
References: <6e0dbfed-cadd-4274-8165-886725413d0f@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

Thank you for the review. You are right.

I used local_irq_save()/restore() thinking that softirq writers could
race on tstats. After checking the tstats update paths, I agreed that
preemption protection is sufficient for these accesses.


I will send v3 using preempt_disable()/preempt_enable() as suggested.

Best regards,

Ömer Mete Kaya
