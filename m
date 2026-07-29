Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760D469840
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344287; cv=none; b=qDU6C3hColL0U0+MV/j8D4s72qp3/S2pGeCJ1oHqhyX3vaIj7x7AopS4wULwE3Vaz9um0H+zNEo/lW7xX3KgXT99GAxFeMCtMgV4kEgVU6KX67EpZpDXmrL9JP8J04tWvu5tO07M9xPPXnDUZgJeqLZVAT8bBzRcJCsq1tXxZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344287; c=relaxed/simple;
	bh=8fA89PK9z5I6GQoA8Pvaip9JaaozQM+Zq5pnMNviiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8O3dRZi3pvZoBiLx4cZMBmf05Tnjju158hL8Z9Hu+XYZS/2S2/lDtwq5JCgeDEjMJtzxqVC6e2u0w3rRL4vP9srIAPVWJDAhO80n8zpw97aP60SPXxZHdA4QAFFxDQ2/JUwU/Dg/BG+DaowyCMuGeUez0abTOfSx9VDUIc0SZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSBp0QsZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r41CYuRK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSBp0QsZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r41CYuRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785344285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
	b=JSBp0QsZICrYgTi+HUkGbH9oAau5Epiesc+41azZQSg3vb3tnh+l/dXBd3YojNh3eYSHLP
	HHY2l/j8hFQ3h62I5yjMd/R3Xjr3XmabGF3W1JEJfeELy9RB6C39Hy/HuNN8BPd9APwpBZ
	9YMLwiHoVSmSXxrZCBwWehP2l4KWIMU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-pi_4uCfMPISCXTEiiZTzRQ-1; Wed, 29 Jul 2026 12:58:03 -0400
X-MC-Unique: pi_4uCfMPISCXTEiiZTzRQ-1
X-Mimecast-MFC-AGG-ID: pi_4uCfMPISCXTEiiZTzRQ_1785344282
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f83a59e5aso1378214f8f.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785344282; x=1785949082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
        b=r41CYuRKR13xPJR2vi0FGOlCCESw49qDF0oAeY+T8Xgf+bSjmUgWXTR/A7/ObnDDT8
         SNLIvEJvjcp5vQsteF4gTjkNq2Tr33AiLlnQq/I6gsJc7nogzqJP6rtJg87KAOE9ojBe
         3A26fpZO9XAOmrlXg3xVs0VCf1DfSsni/383+i2J2T44ReEfRfW/pmW8CXsxWtpDgF2m
         EY94XAdYLZRJEzNmlV9pLjGmZ4uVoQsEp/hSZiGUmEzqO6wRQ1drLn7vyqnXU3RWrlxY
         J8L/yAvvAzfHa92jJoGt8WtWdzJVEEgnVxv9TIWY7NEDX4JZ0ovObInUFJ/Kr83szEfM
         ySQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344282; x=1785949082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
        b=atVOOFD5hZJ0TJKab2xkXNhOZT9V0PaO0ZtP4Wk8egVLxC+nTfy8hAvlijsG1bJiq/
         AiFSqn5abvgwtdIJF21BF8X0vnXWAF14A7BCXEvIog3z2+Av4aZslTWOf3duKDaszVp/
         exAt5TprG5s0/prpAngWFiIPp4ZobQ+Q8viAMU5q96KoO/WhfD7JbVC/V3jeVPeE9lNg
         Eo54XfKE7s07/t42v/VfyIIzE8ucCHPkW49E2QPlmEzV/6GS3CRK3WE0vIO3vNsYV2N7
         5ShH+wjSwHMjdQYn0Bm4fCz95IlM3YfK6zZFTlgx9WgW5s5GomTqiPYeAW/32tvGdBW+
         Sf4A==
X-Forwarded-Encrypted: i=1; AHgh+Rod1YXGZPhBEpp51EXB4p/KkboJA8YRMQX6UmUoq0VG2byJBBZ9cR/3gO8wMAMFfy0qMaXEXVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwycx6SqW7AkKmQ+J8ZiuUhbw6zZ1Q4EVGmaCHrEPi53QqSw+S
	CTPPsgEqmy5JMkRNtxlkQLUCzUOOa4+zX/xIhrUjHipH1nT6sRqlE9n/9lUKCnG/eG9rbEqBmea
	Az73XVB7jQ1ONQtgZ6jwRIxei5nZ2lZWYsuwyo6bCyVtOmaZBJ/Sn2+1xfQ==
X-Gm-Gg: AR+sD11C0lLT6BQVqh8gzDWLEYszFgWN8YwSsIaS/R11mbPshee0803gfEKRwjgTMms
	lkx9UhmIFmkpSfZk8TlUPvPgvWz9Yvt3voSASBZUl2cYhsREtT9v3997+0GA/xZVNEri9MZuzpt
	VBnM8KAswQnTtKPW1eDjr/vXDfjXP2+djAIqAypB66g7MJXcA9FBWvNqdiAFnelXtSTUCMX57Qj
	1pfFkfJoa6HWRQ7mBJ0hcA43rFxPRSQocPW2nsQqZzIUJJswQXjJ2dGxUuLil3a4/zx7uvnhePg
	7vXekcujrDGLEezpR2TxdC3kKeY97i63kUoCha+MIevLGM1HCRBpmVRVZXZ6tTFCU8ZIaU4JLkp
	y5a7At/7dRjDF30+jI+eAsEhYvrGQAPWqOX4g0xoESoQ=
X-Received: by 2002:a5d:64c6:0:b0:47f:7427:8ce9 with SMTP id ffacd0b85a97d-47fb1ee75c5mr9353823f8f.51.1785344282022;
        Wed, 29 Jul 2026 09:58:02 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:47f:7427:8ce9 with SMTP id ffacd0b85a97d-47fb1ee75c5mr9353791f8f.51.1785344281535;
        Wed, 29 Jul 2026 09:58:01 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef1asm9778480f8f.19.2026.07.29.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:58:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:57:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <amow-BG29pG3eSCd@sgarzare-redhat>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>

On Fri, Jul 24, 2026 at 02:45:42PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>To that end, unlike the release path, RESET_OWNER keeps the guest CID
>hashed: established connections survive, and host sends issued while
>the device is between owners simply stay on send_pkt_queue until the
>next device start drains them.
>
>Since the device stays reachable through the CID hash, the lockless
>send/cancel paths can race with the worker teardown in
>vhost_workers_free().  The previous commit ("vhost: synchronize with
>RCU readers when freeing workers") makes that safe.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

I thought I had already reviewed this, but anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

