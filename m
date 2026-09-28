Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12830E0FC
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599699; cv=pass; b=JbfaymM1hluQLMPmn/Td8owwAn+HSAm8kuEHj+ZqEWzfTPSBU+1ftOi18t9nBHmGHDfd0zwp09bJUYYNYuOtDC9hUmKH+Ofosrj60rGepDjfT9dBMii1Kb9xT9p6LnBB40Dji2MXGf5gWrkxsB2W7oLssX7ztaGzNoaQSpOIhSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599699; c=relaxed/simple;
	bh=VtrapI9aSL/wjLNn4f7jDjKgfrQd78FrazJ2iwbjVbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLQUmAvbr3Yo2V8eU6v+SLiwf3wRzUVxVd5PA0H/7wevEqflBB34mQ7v7jLdqouPnVPRRDo2I7KhU77/OROd1ks1A/4VX6bUeaiID5Qyi83nMovED+8r2so6f0ZIhBJWMCZ1y+HF0bi817NeudzTNGMLN/AnOpYnFEDiMCEWpUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUVhF1s0; arc=pass smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUVhF1s0"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-33e630052ebso3509773eec.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790599697; cv=none;
        d=google.com; s=arc-20260327;
        b=IpgHxZMY3ua+Av216kniRSWv8Zq5grcqI8gLxRsg8e4cTk8kvY3bEVoqC3XfnK00Ru
         fdr1wjTM6ZsqAHhoipWBZMYB1mpo2LkNz1cvUQl+yHG3AOf+gNT1t9w2GsASB7Co1zdO
         n2l79L6e48qbkhn5lCdKRoFK2IJ8Ryt/mFAtPJms2qwLPkLPkJA6GAnrtSqFJXEw2zTI
         HD1/1peL8bzC/PQOsfZynE48Rd1kgGY8i0gyCO8FL7AKu8wTcZ4rjt3DdIoU2DZQEU5N
         uEJbpg0DrD0uFd7T9BKhJGDHZWzf2c2x+dEbNU119x/yySyroK9d5dkxl9LePb6sxuT4
         1sXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VtrapI9aSL/wjLNn4f7jDjKgfrQd78FrazJ2iwbjVbI=;
        fh=9kKBe9tMZRT1ffAR2pjBGE0p2KDLHsvy3uXIx3O+Ocs=;
        b=NOD09KJOrpLDl9vEC4w0H4SgSWd+Gcm5qpZAkSwN7H+bD9AvwsFYglFb5/9C3LWKpJ
         iQTI/9CZ9fM+dq7DELGRqBvk0wZvZvpGaTVcPiRa2+lBAI4XFJOAHWh/NVQCJjsHPclJ
         h5wI6fQICPfYrEc9/BgZv6mdPQ9VmACug9YDZxHee3Z+xMzlxnOiqOt5A/RQ+a9zc4vf
         8Vd2wdigZqQa2oAEufmYvLAVPO8GqAX3SDBVW+bTbexBPH+hTkgZfkZxTZaOYXcul8SG
         nGTBUlnrkgY8hah6ZcUyfWrJlnqK0I3yyyXVMkoKuZ15mr9x1cPPnYfUa9Nezo6t1AHf
         y2Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790599697; x=1791204497; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtrapI9aSL/wjLNn4f7jDjKgfrQd78FrazJ2iwbjVbI=;
        b=cUVhF1s0sIPSXtPr9iIeeIBk/cxu/75YRWbbdDzmbe493Ax1gWDP+RFVW62IRBEEhZ
         rwx/BsdNhaeR/dVlEgE1Nqk2zN5zxfch99Zp4Lg3FKSTyrpAzVDRWjH6m68Zkx8D/8HH
         S7QnsQ1gvYfoGXhZkYwxJJ9p4wsNU8gHA5I+8lh4kEkujvl/aEsJObIuKcCj/7bBKdXc
         wjyfPsGH52bXmarRpmhAbt++GVh/Xx+zvA6C1iSOP0IMbKrTSL6ogE0ej63rHx5PWKhC
         FDsxSS0PRB3Yb4a8+YS2FJMcpskCSwgpdt70P5KEhiEBepQazjigT5XvoY1SPpDd/f7/
         W8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599697; x=1791204497;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VtrapI9aSL/wjLNn4f7jDjKgfrQd78FrazJ2iwbjVbI=;
        b=SJcdTcUpusDsLE1xKC9FXAyI8nPS4ec7tLEdGxxB6sZUk6aHAdFp0yf2VU6wc/AtDD
         GZ8T7wTUQyv7+DbKFiu3VgAsrsNinUeOnPj4vaJAUrx4+XAV6+xj/zj745fuHZMrxQOu
         kH9doBOmm1U6BIVd7pZYFZ5bb2Nwlh4jUugXdk/+efFnwAWYNVtarWi4pHogKQoxfApR
         RmJvN/FV+thqnKS3NsApzipaWgwlZGC5NsPUU4Akhm/Krm6JVybJ/XtYt4gUarNGrETV
         cGbLydVIL61Cp5k8ykzRn7/soC4pbxuamD6J7f4FgNzz0QG+ajWDzIeM9jlgXOpr4k+f
         11Iw==
X-Forwarded-Encrypted: i=1; AKwUvBy/SeSkYgbweeYeTW6JtSl0qdCM683GrFXy+PtGwzgBkwN1+P1NXRs/mzeAKItujhzgaesvZlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZb0tPdQZ9fUR3sed/uoRyfcpg1veVHBIsg6e0++psYccwqqqu
	DWIY2mjbolpToZmAmI00wGZ4RWb/BFLND7pDibTDuM0hWuqLBb15ROstWmjHMNQ2w+ZzQ5hTKdK
	03w1Y1h7oXWF7JpxWErdE9GT4y1JReg==
X-Gm-Gg: AYBFou0ywqitqe4pHILecPcy1cI/WV9fdLUR5eNatFT3F+OFrNTaGqc+Gr2piED6XTY
	0Xg9FRBSACLgdbOtWzih864xgm6L5p2AT7DYYHhX/CEFA1oy1X+LP9Y6vo5/eju/SGLFygeReHM
	McExzVYCMe4XcVicFtgM2X/QBz6ZBFRVb/+bmAuSFKe/uT8XYFNGNan0JjbEVHXcnicHsrfK7qB
	DKht3je33nMf12ZjtzmPTZ+pNIz6kzggZ2IXqgZGXDfpKWJS5N8jAcVEKUXLydmVwXjcR1edMHr
	q+nH/jeJRQUPahr9eMlkcvCzREBcieu/UGmls4uH96TxTsCB0pWk4tPEfVA47hKneiXBFretXBA
	QVXmB7/9QDFsPRhEJM0/by9rKj8kQCZ4CLsNBIQ==
X-Received: by 2002:a05:7301:4d0b:b0:331:89d6:80e7 with SMTP id
 5a478bee46e88-342703c0860mr9551616eec.13.1790599696571; Mon, 28 Sep 2026
 05:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>
 <CAM6_QD_xAyTFVvYKvCrrZmS+fV5DBBje9V=VdkDMMSpt2ussRg@mail.gmail.com> <20260928120343.49e02c07.michal.pecio@gmail.com>
In-Reply-To: <20260928120343.49e02c07.michal.pecio@gmail.com>
From: Dane Linssen <linssendane@gmail.com>
Date: Mon, 28 Sep 2026 14:48:05 +0200
X-Gm-Features: AclHuK8J3gRe-Q81xAxIPGhsJgUx0Z58Tt46aX_83uRYAf_M955FV41pJ0HJWPE
Message-ID: <CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com>
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in endpoint
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	Mathias Nyman <mathias.nyman@intel.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks, everyone, for the quick replies.

Andrew:
As far as I can tell it isn't a regression. The adapter is new
(2026-09-17) and has only run 7.2.5 and 7.2.6, which don't differ in
r8152 or xhci. e765ab012f73 ("usb: xhci: Improve Soft Retries after
short transfers", v7.1) should make it rarer, not more common.
Bisecting isn't practically possible, as the stalls are days apart.

Michal:
> Out of curiosity, what's your xHCI chip?

Intel Sunrise Point-LP, 8086:9d2f (i5-8250U), so not ASMedia. The
other host with the same adapter, which hasn't stalled, has an Intel
Comet Lake-LP, 8086:02ed.

> As a bandaid, you could try increasing MAX_SOFT_RETRY or this:
> https://lore.kernel.org/linux-usb/20260905101837.4b7849c5.michal.pecio@gmail.com/

Thank you. Would you like me to try this to gather more data? If not,
I already have a userspace watchdog that rebinds r8152 when the LAN is
unreachable and the bulk-in endpoint shows virt_state 0x40.

> You mentioned using dynamic debug. Do you see "Transfer error"
> messages randomly during operation, or is it only one burst right
> before the failure?

I only enabled it after the two stalls I reported. In the 19 hours
since, including 71 minutes above 5k rx packets/s (peak about 29k),
there hasn't been a single "Transfer error" message, and no stall. So
nothing random so far. The next stall will show whether it's a burst.

> This should be visible with usbmon.

usbmon's debugfs files are blocked by lockdown here, but /dev/usbmonN
works, so if I have another stall I can send a 2 s usbmon capture of
the bus as well.

Regards,
Dane
