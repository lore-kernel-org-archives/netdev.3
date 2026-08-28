Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB9377015
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932284; cv=pass; b=OpxhKY5pRYi2ZAOcEpzgYXSpUChAOCMJaJv4Z7FtAfYGup34iYOxcNyuXRmoHSU5zDOQSKEcZR4ghfLyeqdaFpmac3prXE3S52zIH9vSWIfkdUyiX/9qDWX7WHWffb/SH0QbCvadE8ELtOm1B4GndeTDDnYioZvhEaI84SVbOcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932284; c=relaxed/simple;
	bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjCABp4i8+oMxHER2TGZTj0FdQB1rhtWPng9HmNhtoRr0GdsuelQMfbYBpsn3NxqyfJp/iW7D+rO6Mm0/P9bccVlI2T3dZQPjzGJFGlMBvRBukIOvJZvYVo/O0UNXzmVf95KQLeIPgC4QI8kxeBV7wvqzbMVTuqePi5bIVRXPsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL1ZUpLR; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL1ZUpLR"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e50a650a0so91834285a.1
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787932276; cv=none;
        d=google.com; s=arc-20260327;
        b=RB/XhOAMu5oijSQPn8RNbYES1dEPim3+E9Psc0VxgxV4In84QFffs+lp8qrNo57UH5
         LXl6QCK5h/sGyJN3TRX1sucgriIEk56U5tm7SNX05qEYed4tvL+P77FFJ7SoCc5GVa8m
         8VifVRGZM3KFs2dAJ1/ksOviMt/qxT/rD0KHK4SLhTCKZ9FS8L0r2CC5s9mw1LyI8PSu
         0sySUlDiDlaWULxy4uWv5ism7o19ypDAgSrj/mkR2HmojdTXILx7ljUGAGv+DL3Be0TV
         LjqD1rAAFGo/LyphpnLALdKXGwqCyJOwqRz/QdVgYQpYns0YCtTmCbtx6rRiS5IywSUU
         u62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
        fh=gYdA2tQuW8H9yHGSFLeolUGCyy+df+CvwxFHj1V+GoU=;
        b=nVDcWcD1A8XBOJqAoYHp2Z+f2j99Zbrh2aGtptaR0pnp5z1ebwP7Vd5QcROwM0mUud
         qjGFNY/utqFJayt7KVWPKh4IyTZ3o2bt/9KE+8vCLYWesubm9gELYnQXJwSL1QZPWYBe
         /AJzMhbugIq8OPu2l63QVC8rlRiJA5Ao/6dQQDS4cT5/n/iKsr/RympUTPGR09Bo98hS
         eGKPqAECaoDXB6yYihX5/DPo1l7nhJygAhIK4033OIbpH0QnieUvVwPVNkzkoKmedzb/
         YDIGR169FuRxvNMfVpUHM66Mmi2oO5w10dmnPFAc82XBTzaHlEgJOX8GVWWLvNyWmi9d
         7ILQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787932276; x=1788537076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
        b=EL1ZUpLRjHqSmF/WEANNAsmQynxJHhboORF5W5zsoM2Kwgv71FSjcZVCJUVhkZW6Bf
         T4d0BjiYnRmEc4soprJ+mImb0fKZUX5EQUDoxIvxFcctiY5hKNRd31vXN2sgj8e9OKOz
         afdabFbaAKJtsNVlfx+BgUlmD1AzhQfd7biGoA+KAZZixbPVM4lR6x6c3R7vvFctijGn
         XDgrIjOsqRWr+EMI0OSYd/8BPok6+aCghm+Cts3OOaiL5OJaNK4fttx617LyJwfSTLOI
         /kQiBg5mnADJgmcCUyGsb6r99yDf9YlVe+bRNMWYMZcfq1H9plrCsSd0Q6UqCAcdbYK4
         BGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932276; x=1788537076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
        b=bMoJGgCnIdd/dhzpuZueVdUXv3OliErqS/GC7YSJj23v3m+qm22wpoar86xog0WL8i
         DDhntvzN9ckPJVBb5ofMxvMxcgOEwN5AIKDQsvGuJhfrHxLUYsFigU3eagAcKMCyT00H
         Wrl5+usSvvwe1ATTPS7hR2iKpndc2mRMkWXf3SL5q0f5ZD/hCqDJYLa1ygDRT81xz0AC
         gtzzVK9w5Wvjn9SkNF5yqCIU7+TtA4yhVpMd9/KS4vYm4E0XV/kBwMGffOzJfCYOYy4a
         BltCmAkp4/uLQhKCq/4NiVKnRc6oPNWEeNm4bD90b1yJpmAs3C3o66c4HrP3m6AcJWa+
         6syw==
X-Forwarded-Encrypted: i=1; AHgh+RpPCQQaseKpQ3j1dPmaKUIlSoRkuQYAKmN5oftRAgrwBSgpKJjnSgshZitaE//2xbrT/P7FY6A=@vger.kernel.org
X-Gm-Message-State: AFuF++ks6isq8IVEeQBHB9gysq1aqkJnrdsoz3Bqvo/Gy5ZsP/PBiug1
	U8Rmgfu4To4zvZFlPcttHkoKO0/6Zw6IG7a6N8JsmXVo2FG0ABVyFMYhROEdPrn6ATRkd92c523
	FIIr2yJjw+C4/HoAD01x3cVsSgudwPHHG4YCQi72y
X-Gm-Gg: AR+sD10vowXgE6A96YfA8LrBjx5SIdyD0zV5gKCc7PB8o8mA0EObLT/5IPZkbgC51ob
	51xGsB3wz2MU3WY9Xodm7S6ef1fvfLFGLrCgtNHglEKeyOogvU02kU0o/8LxWfhG6NDY9cZhiVR
	QVOzBS7OCjMWYmIMmW2zqOau0j3ApUhtxoWkB1yxee0U+JGAN008Wbnyf/98KpqwOwOboBFF6UB
	Vv4t5ADWxOWw/V2AGrRiA8GcCn6gTsOc93DCbMMvAdyXbOmMJyZEF1zUTV69Xyx2VCduNy5z7k8
	yHRO4BVN7GaDh9tFd5Gjio02mOzV7PRJGZ8HPPBtWUXX/9GyNZd+EynShT8xqClp8i+z1m+jbcL
	Do6fNEzoQeMoJuDEpIw6SZ7KmpKVx/cxYH9AMEWwoJJUVJnlcr3+Mr0htV8M=
X-Received: by 2002:a05:620a:4548:b0:936:e71a:db90 with SMTP id
 af79cd13be357-939138aaf3dmr785852285a.29.1787932274998; Fri, 28 Aug 2026
 08:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828154122.2643578-1-den@valinux.co.jp>
In-Reply-To: <20260828154122.2643578-1-den@valinux.co.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 17:51:03 +0200
X-Gm-Features: AcwNN1UrJtJ6iduqn0ujw97pAkDqT2wuWCSxNAQwH8z3egHVmruiIVqnB7mRr-o
Message-ID: <CANn89iK1U8wzTTQAvGCP8Fff9r4StUB_JFiTdFJZctQUQHE9cg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ntb_netdev: Fix statistics races
To: Koichiro Den <den@valinux.co.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:41=E2=80=AFPM Koichiro Den <den@valinux.co.jp> wr=
ote:
>
> ntb_netdev updates shared net_device stats from per-QP RX and TX
> callbacks. Once multiple queues are enabled, concurrent updates can be
> lost.
>
> Use per-CPU tstats for packet and byte counters and DEV_STATS_INC() for
> less frequent drop and error counters. Callbacks can run synchronously
> in the xmit path or asynchronously from a tasklet or the memcpy kthread.
> Pin TX updates against migration in the kthread path. Use the IRQ-safe
> u64_stats helpers because netpoll can invoke the synchronous path with
> IRQs disabled.
>
> Note that transport callbacks may still complete after
> unregister_netdev(), so tie the tstats lifetime to the client device.
>
> Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi=
-queue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Eric Dumazet <edumazet@google.com>
