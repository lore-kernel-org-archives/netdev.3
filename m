Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062252C21D9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017654; cv=none; b=fkNdXR4QmbEo4EeqephVAmdIiRXNn2zmxwQdo7VaS+PWDg1PfeUvqxvTMi2FC1bg09Y5dEIFIKf01xYquo9PP9FbuoSQUhL7izm1If7lh+euuJj/yiH09t4GzicPk7h4LFu8vRf9bT5E+FYeJVYezZ+FmPvAouqGzPnN27x6r5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017654; c=relaxed/simple;
	bh=6fuEfU0/Ukgv4x0xWP4LYF4DEHVlHv01Fmw+jlPsMLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uQhjSjjjG7mSf6HmHc8wqdybgJ4gR4/zPWZi19yVfnekxsKF91en+si2TM13qXxr3ObwO74hqbW12JnLVBsFJ3/7nrZYYEz5SbiQjqRbFoRJU3Vf2MJdT0EVB2Ot+JvA2njQE9tCpXA3yYX2esWh2SKLZxIOv9GVdBnXIYi3zhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=KOVmxHkh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="KOVmxHkh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-527e352a167so13203141cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786017650; x=1786622450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkD02WTTEu18RMspRyHICu7K/uEUJ/k5kywBPTDqeqQ=;
        b=KOVmxHkhsGzVI7osAMrMBFH9tENP0TO7BoXy2cDu8ltsl+jdNtEbI/ZTrqzUdAotwY
         6sKbCgH5FNEvF5VqiTCX7niuCHYdtg50PzKxenVyCOpKgvAyuKF0X2AHzzsVm0bxKji6
         Kuwsyrr55Z9+5JW4aiRHqqo8hruKyO2Z6PKj/Tb8RajjGfr10Y+YmyC5Iqd3iiQ1gYOX
         Jd7RRqQWokSZFoA0W77p11LXefbxGRaE1agZhG5yrYVktK1qZ+NElY9a02fb6aFBzlRz
         Qy+3AIFM41wIRFt5HSrC4SLXZ0NqR+Fd8kv8UNgIyo52sgnhZmicg4TJjdkUB4n9OoRV
         j5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017650; x=1786622450;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkD02WTTEu18RMspRyHICu7K/uEUJ/k5kywBPTDqeqQ=;
        b=OUIgRH88iZTY50hLw3ZcbHk30rgXVNJBSb9+KEFuhOnIArNkHsXfsTbmz9HINPFEsn
         GgkvfhQQjVP9OZqPAWNsFyQUNHwl5GIptsT/Ka5HOBi7fSGDjexBYJBPKB+lIhtoHmcH
         8eeSDVHy4UiYpesqxR8Z++0oNK9fpY6tZ35YPWVMO6+tnDJaMEdkp2pctDfcBI1EboiQ
         EsNOp92RBazAJinFAITcTuMQxgVbH+KuNHTsFgr48kc9C9Mv/sSIZ7cRu2MvvwV9MUd9
         qBxckdUToSnFXJInw/Ullne1x0JOYbTa2+9agR07V2lQmpViCex9xKdAHF074ujqDMjO
         52Xg==
X-Gm-Message-State: AOJu0Yy4PykCLI2YiaTT56plOCb0L+iMHTVLQm8tPG+i5ZVLGU2af9Bx
	RNVU7hAy/Bk0JJOTB3xIKC5ZuHwcVpF+nZLNFI8sA24skZ4RbKhL2iipchLwsMvwxe1s7/mbNId
	CYjSOOW9rpg==
X-Gm-Gg: AR+sD12feVi9W5NfPMlsGxHtRdoZWLW8Ohtzjpc/u8S71RcEJzy/e/sPD2XAvOtGioz
	vKRunv7iGjZtoPjIm4SgROWGAOxsTcGNrtDs0/DlaNqby9v7lIXnjY/V8yX0RZkL/SEDjnABLan
	Bw9jbmOqstqZjYzvamLGx3k7wF0vE9WVv3LpzCH0eUjFcD4W9+ji0y+HkpCf44IVrZgPfC1+32C
	PdCXDA6qNAO2cpe0LWkRxe1fI16FFxk1G1ScipyKJzjwk+ORua9mNmNesxG9kGsIvfq73y1Tk7d
	8xu5vlDNj65tPdmJFDCqOqGQVSjMPAhPvcRmS7x/eWtvEFlIMEDv4Voh1dCbQhwjMmrvMSZfM3Q
	NRznLx93gbiwkL627KSFZhF+wfV3S38bI2ysYwOoQWxV1jtpD5ZulaPoJasZ6IbUdDEYYw1beQI
	aRpYnE8NEkJkWe612d5vsb3VI3X03vsGoDTZbr28mQFLBEFOzba2qJfVvm29/DpgNXlv49JmxO4
	Zylcvfa+zyZ3IUXC0YItUrSZyYw4u6I+bRrG7uMz/U=
X-Received: by 2002:a05:622a:5905:b0:517:7e26:36a9 with SMTP id d75a77b69052e-52ce62036d0mr157950541cf.39.1786017650200;
        Thu, 06 Aug 2026 05:00:50 -0700 (PDT)
Received: from [127.0.0.1] ([50.201.37.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce9b0743dsm34630821cf.29.2026.08.06.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:00:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
In-Reply-To: <23ae94da6725cac660652781b3533a20d0a1ad34.1786016493.git.asml.silence@gmail.com>
References: <23ae94da6725cac660652781b3533a20d0a1ad34.1786016493.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring-7.2 1/1] io_uring/zcrx: fail non-qops netdevs
 early
Message-Id: <178601764913.2132084.3867669701970816639.b4-ty@b4>
Date: Thu, 06 Aug 2026 06:00:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 12:42:33 +0100, Pavel Begunkov wrote:
> netdev_get_by_index_lock() might return a netdev that doesn't have qops
> and also relies on rtnl. We're going to reject it later when opening a
> queue, but netdev_queue_get_dma_dev() warns before that. Reject non-qops
> netdevs earlier for now.
> 
> RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> WARNING: ./include/net/netdev_lock.h:72 at netdev_assert_locked_ops_compat
>     include/net/netdev_lock.h:72 [inline]
> WARNING: ./include/net/netdev_lock.h:72 at netdev_queue_get_dma_dev+0x52e/0x660
>     net/core/netdev_queues.c:43,
> RIP: 0010:netdev_assert_locked_ops_compat include/net/netdev_lock.h:72 [inline]
> RIP: 0010:netdev_queue_get_dma_dev+0x53a/0x660 net/core/netdev_queues.c:43
> Call Trace:
>  <TASK>
>  zcrx_register_netdev io_uring/zcrx.c:831 [inline]
>  io_register_zcrx+0xe94/0x1d30 io_uring/zcrx.c:983
>  __io_uring_register io_uring/register.c:942 [inline]
>  __do_sys_io_uring_register+0x1193/0x1bc0 io_uring/register.c:1040
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: fail non-qops netdevs early
      commit: cf7aa48151deb629022a8b0c61c139dbfa579933

Best regards,
-- 
Jens Axboe



