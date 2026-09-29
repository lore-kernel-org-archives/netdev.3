Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F34AEEF
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654644; cv=none; b=YtvigkM26hrjok1N5/4E0Qz02ACBLilWscLNPPRp5lmjH5KMPGd7saOHdgiNsXo+QI9eUHHTM/gMrKm7MM6Nk7mXYC0B5Orui/dRr7hIHM9giUTDOLkcuwmcb8vGeypbiWN7HbmDMeteu6IIbCuEpKt1/N/Ys4k7kKvepjP3WIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654644; c=relaxed/simple;
	bh=IIvZdgwC9AnhXHTdbcoHptNLgQYNMlSNRKt2BBJ3DBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BeDUH9ui9JOV/ugJ5ROev5w5KmxuP/bEgsfLxg2XKZgtB75E382jvVHMZ2ni0EhRYOAUOjXKao3cA7FWRE+vpXHiTKBYA196aLvyTXHK2EMg1IzllskBk0QJ0sFr0/IS3jXrVoPfoDGfbizrkqF3Hj4doH2AAB3Ly0gFJ0B3fVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYEIdr73; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYEIdr73"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1474c6b7742so2161271c88.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790654642; x=1791259442; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IIvZdgwC9AnhXHTdbcoHptNLgQYNMlSNRKt2BBJ3DBs=;
        b=BYEIdr73NzxizhVvriA4Ye7mVnuB9z5Ntfi0Hmv6EZ7cxyJVOFg8+k/elMS7zvLzk/
         VUee/RyJpkQ3Tm/XIzICyZ6ChkSUPhZ/nvI6nB4jfvHsteuebYEOcVVUuynk6uYNFE55
         Jb/J4l8tgtj23KZ4Do6H3sZVP1137bsm7r5zIAktIJyw1Nsvsfct2vw3OFTXAcgtUl1R
         drlET9QOzskVDV5LtnGmewZa4aIzugzL0D7iKz6WxURDNUuSKEgMiVLQVMoJwOsa1Axr
         vHe3P/YBvrPgoXwoRviPg09k7sqPG2bzWmugOq4aBItkXgP3nzbYeX0Y82nQeF0Kvz8Z
         wCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654642; x=1791259442;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIvZdgwC9AnhXHTdbcoHptNLgQYNMlSNRKt2BBJ3DBs=;
        b=ervIUkAcW1Xwfj8BqMqfSSvXNAzPAn5St5rUhqtSwdQuPOHDxyMSQ0WIeNzmPBuyw7
         h0tJ7xYorFXaMGBNnauurGx+dnuCRajjilqO89gvbYYHZjPrt/FPIQ+G00K8u0Aybu1J
         21K+2sye5h1feO/Hr55G8GFm42VzqCXq8BP9RDlw7Z8MS+5FWAr8I7p5X6UiGB1eY1Rr
         gsEvn0s2NVcKf4Mnn71kL6YN6AXJ1nfeD/ViPSGpIGq3o9/h4FuDR4J7m46TPe1Nc1f7
         G6lpuZOdZz/CGGVymgPWgbypuus1lWCSv1RpUOcTjFRGTzSQO7YXfAoCkP/remS9zwyX
         AHAA==
X-Gm-Message-State: AFuF++nKe8mTsAgZVvNIY63beQiAg/JnjSxMmUDWEZgwiWmAa6R+p0Y5
	1jXVbq6E5diUO54lxXe9k2o/hZK4x8qBnUsoBCGu1uSRTBe1ZHu7GDjy
X-Gm-Gg: AYBFou0t17TIsjLH/YA2BrKF5opEe4AQg/4EM5/4BlCAF/jqajIukhYxUqw0L86jYo9
	NeIacMry3tmD0jgSCjEQ+ju/a01ehB8VS4iM4qcM6rkXbgXx3CcpjAo0GsMy1jA3VEoErjbmLB0
	nyexpw/coFJkt8nyGQvD2NQ87KDt3g//uvdeUcO1rbYoZmfmvwnx5DvF1r6XlOKdbepwy2eYL66
	FpLoGHZqtzPF3MhwI0vipapuMDJh8A5lG+el1UMY6tJMgz0vS9btOoW9VTKMh2rdES551iVyj2k
	TzAnLAREalrrSKb9nuJ8epEf5z/SiEN/R0XXtoV1NMYXpO5tAPJpwGhZ2OUNRkIgHFVcP+BxeH+
	ziA80+kWf0kuyaT2nUkimj2caTVQdBX6I+q+xy+p4l8NVnmT1dpO63DM6y0d3yKnak1d1pykE2H
	aMD7iGSBDqTVIP3VqvOLl8NMwtEbuueO0yM3AaDxGcf+QA+SumHHni0ArUL9ZiQ7L5UrL7DF9Tp
	lY=
X-Received: by 2002:a05:7022:b048:10b0:144:e658:94f with SMTP id a92af1059eb24-146d0f33db2mr12863370c88.43.1790654641936;
        Mon, 28 Sep 2026 21:04:01 -0700 (PDT)
Received: from [43.242.224.196] ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm20527028c88.9.2026.09.28.21.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:04:01 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, chopps@labn.net,
 shubham@octane.security, robert@octane.security, gio@octane.security,
 kuba@kernel.org
Subject:
 Re: [PATCH v2] xfrm: iptfs: hold a device reference while packets are queued
Date: Tue, 29 Sep 2026 04:03:28 +0000
Message-ID: <179065460862.1915782.13934055353367749026@gmail.com>
In-Reply-To: <179023970333.2160803.2776986020964028023@kernel.org>
References: <20260921084743.817859-1-roshaen09@gmail.com>
 <179023970333.2160803.2776986020964028023@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for the detailed review. The findings are valid. I have reworked the
next revision to keep the reassembly device reference through the nested
xfrm_input() processing. Reassembly and reorder window deadlines are now
tracked independently, so completing one does not strand the other or apply a
stale deadline to new state. The timer is also armed for reassembly created
from a runt.

The reference is released on every completion, timeout, abort, and teardown
path. The code uses netdev_hold() and netdev_put(), documents ownership, and
fixes the style issues. I replaced the mismatched pasted trace with a concise
description verified against the KASAN reproducer, which remains private. I
also removed the incorrect bounded lifetime claim and the self reporting
credit.

I have split the timer correction into a prerequisite patch. The resulting
series now passes the ten case KASAN and reference tracker lifecycle matrix on
both the regular kernel and the lockdep and RCU debug kernel. It also passes
the stale deadline overlap and runt created reassembly regressions. I will
coordinate the timer prerequisite before posting v3 as a new thread.

pw-bot: cr
