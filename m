Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC60411680
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574828; cv=none; b=V50UJASa4+bBu3eUuatNPCVRDOd8cZBTQYKjSwx7xshbVoBRXofIgvc9Idm4AhTVrq0ZbHLslGEEwguWWMSPpqdlinmIJru1ayZAwXU+ZBzLqxmrap+5Ztcv2+XDtqIUARVxheIvO6/sVqiLq4YGzoMa+NBVSVIYDWDZlkLGpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574828; c=relaxed/simple;
	bh=bw8kYtOO5U+FYmtTM1M9KgNeI5l95N1tcJQbU4Owl4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERf00plnKZYmVf66DEYzlyMLcNOtYHuKHy/mnTl5iozQkWz6PlQMBbele4FutScKynn9nzAr0jdrIS7DJVJcD5GDbddpwTkNzHryl3EXCduN4dh2lbGBDtf2QVcPjmPKa/ILHtwWV0F8223YDLwMNwwel36v9Pumyi4/hd4KG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za; spf=none smtp.mailfrom=ffroot.co.za; dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b=s73KDYXY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b="s73KDYXY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so5731716a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20251104.gappssmtp.com; s=20251104; t=1787574823; x=1788179623; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LYsstLUHA4+O8kBjsO8+8kq4A2q37DKWSh7yXTB84NU=;
        b=s73KDYXYmcNSZni3/cRIO5TzgwI4Bv+WHRKXFvFKzsYI6QXJ2NQyVmy4lk0Nkkrvuk
         EjncP+mqsJLvlXGLLmf63Cvj+Q8JLUaOUrgZqELm8cgSYgWC/Bld2F2ogtODEgC2wVJd
         ZCYfsQYS8uKfozewxOXBjeKtC2upV6hAIorm2di//nvHXE4g6Hm3BwOLyRhjCI99er3M
         60xEafpGUo5JQfCv4GS48+FAVZPlBt8okuZtlQlZJIZnVUgjdFyoea9ubI7pXpqLsb8R
         7pnrm+2UGLF2OwAV4DpdFHDp/eDihMPfTYiqIrhsiHOxI0rIaTjpHIzCplQwngSGmzi9
         vasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574823; x=1788179623;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LYsstLUHA4+O8kBjsO8+8kq4A2q37DKWSh7yXTB84NU=;
        b=W7x5NetZa7Ig/eQeBK5dzei/k4tnnCqTGj6hqQooWSE7XiBCpdtSB/b+I0tXzW/4wi
         pO5JKAiIH0dyN6YtiQbXwFz5CxyDFcSx8PC3gJkU2fCE1YBK1bO6DCN8lWk3CC2cPEyZ
         f7Hc/RMWwxVdY8n22ek30fdqcFEymXB2FsrC5dB3khd4pWkkRLmd1tZnTsF8IgBluWEU
         /9pLjr18HVZoKjDRfZV/nI/V+M5ByG5ZHA77PIzakMSA2Qb9GzaIQiIE1ZwRYak/tvaG
         6gHpdSjscYCcz6D7HPG5Qx/2G+Y9jkzK2kbPGn1UeykrgSKrX/a3XLuIVKVTSpqrNBSJ
         zewA==
X-Gm-Message-State: AFuF++logXCCVmOK09a4j0VyXDIF0b69k0rUrHl6a5UZaFBORKsLhCmo
	baTJiliXWuGnLGqaOnJGKURlfqsR3FYpertV2M5h5ZsDpR/S8K5j6PtICPw+fM8n4gM=
X-Gm-Gg: AR+sD10WAx+15C92h0mNwMBN0bQX6w3M1eypQ6MudEYjgxFlfg4wffLkIaSN6ir89dq
	jMSbkv9+b0hR4+1lGYr4bEgfF/jGm+XLr4vg9RpCIhZVrO/C7keCy7kDzbwq/jqsJa9fibwle5Y
	YsKqUvBZn5IixU9YeveQPHHNPU88kw6cV1NvcPAw4B/VC8IS4eY/JtSTSyG+85uc0tL/Fl0Lqi1
	DX7yhQV8yIlwes1BPjiQWhG5J6cL2AXZ5B8NuUfNQbQKLYwkXM2DFLAFbmasbSsVkKDuGDxF99T
	lLggKhhpXIyul1l1pjeAph721xpAfZfLh7ojAkvyDwy1DnnGoFbcoQjwQLnva4BMrE0FoptG2LF
	0hnqcmUgqk16pu/NXMQFEWOxLVy897eJP56Cn5ZwfYKXJSOAc2a7kBAW0hqD+47P7M/p2jBoofo
	OkKVMwztNnRmDenFo4sAd8K8GMXDiTt/38ZDQjHsazMqzPIXstXdlt7TbZr+cF3II7So2QqkVuF
	ieujxB5BLdWfDQG
X-Received: by 2002:a05:6402:24c8:b0:6a1:4458:7f2d with SMTP id 4fb4d7f45d1cf-6a42f172088mr22058897a12.5.1787574822559;
        Mon, 24 Aug 2026 05:33:42 -0700 (PDT)
Received: from dev-ag ([102.33.165.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1d741asm8342424a12.27.2026.08.24.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:33:41 -0700 (PDT)
From: Andrew Gaylard <ag@ffroot.co.za>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  wellslutw@gmail.com,  andrew+netdev@lunn.ch,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: sunplus: fix tx_poll spin_lock missing irqsave in
 NAPI context
In-Reply-To: <20260822135103.6711ba25@kernel.org> (Jakub Kicinski's message of
	"Sat, 22 Aug 2026 13:51:03 -0700")
References: <20260820130159.1584806-1-ag@ffroot.co.za>
	<20260822135103.6711ba25@kernel.org>
User-Agent: mu4e 1.12.14; emacs 30.2
Date: Mon, 24 Aug 2026 14:33:36 +0200
Message-ID: <sa67blfpujj.fsf@dev-ag>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 20 Aug 2026 15:01:59 +0200 Andrew Gaylard wrote:
>> spl2sw_tx_poll() runs in NAPI (softirq) context and acquires
>> comm->tx_lock with plain spin_lock(). The hardirq handler
>> spl2sw_ethernet_interrupt() acquires the same lock, so a hardirq on
>> the same CPU while the NAPI poll holds the lock would deadlock with
>> IRQs disabled. Use spin_lock_irqsave/spin_unlock_irqrestore.
>
> Please explain how the issue was found and how the fix was tested.
> I mean - this is an ancient driver, if you don't have a way to test the
> fix you should not be sending the patch.

I'm testing on a Tibbo LTTP3G2 board:
https://tibbo.com/store/tps/ltpp3g2.html

This work is part of getting it to boot, getting it stable, adding a
couple of missing drivers, and sending the changes upstream.

I found the issue using lockdep. At least, I though I did, but I've not
been able to reproduce it, so I must have been mistaken.

Apologies.  Please drop this patch.

-- 
Andrew
