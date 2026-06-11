Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2334D4F9
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164709; cv=none; b=s5GT2aRIWzzPYSq3jiKJudC44/8Nl8lwMFWPifWduRlPfK48RFyp9FVKc6f12NMYvwo770DmXfQEeD7aBkHHtvzH4OW8oX8jEHJbrVYe9h90ibe7k8LfV10Zw+wZnHVKk13M00LxwfPXjyl8bA4LsA2vWQq86AuMbRksrfncIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164709; c=relaxed/simple;
	bh=ZEy+ssPgj7fd9v3cExsjBXsdFe2eDfx6ZME1ev+0piQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUW9SiT2RaGZh5c8EFT+izmS9t2E59eELqrpT+Ff4svLzHnmqgJYD38rP8AWQX0laVxfkYJ/xVqeImRIeRsl2N2spBrKE1F1FAt5bnp34BP0X22hliFy+0PKY2y9dAkVCDcL0uxK+H4bZ6mQb6DW7wFHfRiWSkWoQ44eflhxexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGxh6ZjI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b06r2i0n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGxh6ZjI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b06r2i0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781164707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9weTyP7JI1bIVxhUTkM93LkL12ISvR/eoJ6k3ozVeI=;
	b=RGxh6ZjIrSIml2pV9UjBi9b0dKwnwUCxc2e3tuba2SYBfaDFo3Ok3kV5Cs7D02eZCUTgOL
	79UD69q9BXVAdLJcGmIAGoKgoHRPqO7hq1+LVnYqBVpxKhrTB7wwW35xZsEiHV57t4vZlW
	5NZS0Sw6FwW1unvuSMcmoNPx3iWK0Ps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-8bQ-v2dsPr6aoceuZYSS7A-1; Thu, 11 Jun 2026 03:58:26 -0400
X-MC-Unique: 8bQ-v2dsPr6aoceuZYSS7A-1
X-Mimecast-MFC-AGG-ID: 8bQ-v2dsPr6aoceuZYSS7A_1781164705
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef2bd566bso4309299f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781164705; x=1781769505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9weTyP7JI1bIVxhUTkM93LkL12ISvR/eoJ6k3ozVeI=;
        b=b06r2i0nLtjInGwgX0GoRDhkJNUJ2xiy3On7lXrC1w4O8s4+IMrSRvRbUvdqcksg3T
         ShyRfvOvqiG8vP9Gr/gqtKVJokQYhwoAfKKEcL8xWxUgsrDpuZYohcd0fuxldZzSjykZ
         u4NduGjEYPAtduJHGLlUtfOAgaVMeNcZRj6c8dIWgmU+K7tHYvcVALP/9GprDVs1qXGg
         i1nNyR16uxd31gH+AJU0B9Q0gCk97UFZE37jpEEBxbCguQIdny8g0PSYbjsbpMGgXO4d
         cdeOE9lwdFvqcy3QLabduJFaVO3yldynZTWes8s+c1kl3QLBNHGo1YgBhQwYimiq5fVP
         ncZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164705; x=1781769505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9weTyP7JI1bIVxhUTkM93LkL12ISvR/eoJ6k3ozVeI=;
        b=OwvwpE4LEO65moB1QMmPLqRyPOF2FpG5ZeEfwMI5TqjaXwiNnb6kjC4tzHr1FEatfG
         R2tZJrRjacfWt+e1YMt4RvP6tmu4wGVPbnmfoltNksHuojiU20/t8XPZImUyeRj/PWsU
         SyoSbGV+Ztx8Q1ir9/wC252gdtjt6FfuTMz/tKHGYrV/F4/2YbkIaq9lyhetp849H4SH
         0CVrXrUtE5kjjREqQpP3lLz/zr3yFhxp/4CHP/1aURjoLIRmw7gQXFFubWcwYAsxMK5K
         rFa1p9afzU3ZNIkbmfuciP1v7TMyC0VdJeLTLPJFgKSA4qNLaeE0uhg83806AV8FEObP
         lfxg==
X-Gm-Message-State: AOJu0Yzapo1belE3Ko3BjmtmdsQRffj4Lcdp3XFH6zzBEbhRPWng6R9/
	UGFmezDeXOfkSND552H/KWXlNyH2zktz48RFf4fRc3vHhTBtzMVXZg8FDXbp+0gBZSg3qNR/dep
	/4wK2BxfakPMv3O78VJkWelazbpjjoRFTvHMnAANq2lcuXFyMJqj7/S9F7A==
X-Gm-Gg: Acq92OEyur9r+fhqAeOZJI1EZ/SmXIJGj8BNAlr9eBF9eLJsLU02QKoVl+WMm/CFVqa
	61rLIqa6a3hNy1UeWe71R5QHdbqvJ6MP/V/q45klWdEBAeZ6d9erX1W88IhuIWaPXsJNrm/8XP+
	IUmYRPm2OHrBGw58GBkG/bDz5M+wb96pBK49gvowPlZV6f4hBvp7aqdqwWIc3Te/kTtQ0D9HuBE
	JchvoZD0yc83M1Oc2zLv2aHOoVZUxUFwDE5dajCd56oDJ0h6Hf4v8BWMyLwzYZzIZMujiJN2cUg
	kKPFnSiXhM6r6lRXN5l3W42YD7V957EXTGBO5yAVi9SluNr9tT+IFf8qKp8awDklbF/sWFD1dpi
	WGr94H2ruUcjMMovGncHTU2ZvWgPFohJR2FC/qMiSXGSDZ4rY4nQe/uakC+oh0Sf0AySDxQ==
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-460677d03dbmr2238677f8f.32.1781164705332;
        Thu, 11 Jun 2026 00:58:25 -0700 (PDT)
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-460677d03dbmr2238634f8f.32.1781164704969;
        Thu, 11 Jun 2026 00:58:24 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm86374521f8f.24.2026.06.11.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:58:24 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:58:22 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aippcmlliXpO0BXM@leonardi-redhat>
References: <20260611023830.106259-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611023830.106259-1-rafdog35@gmail.com>

On Thu, Jun 11, 2026 at 02:38:30AM +0000, Raf Dickson wrote:
>Replace the open-coded backlog check with sk_acceptq_is_full().
>The helper uses > instead of >=, which is the correct comparison
>per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
>backlog changes."), and adds READ_ONCE() for proper memory ordering.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>

this blank line should be dropped
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/vmci_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 91516488a7..56503bee31 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1010,7 +1010,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 	 * reset.  Otherwise we create and initialize a child socket and reply
> 	 * with a connection negotiation.
> 	 */
>-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
>+	if (sk_acceptq_is_full(sk)) {
> 		vmci_transport_reply_reset(pkt);
> 		return -ECONNREFUSED;
> 	}
>-- 
>2.54.0
>

Thanks for the patch!

note: according to patchwork [1] you forgot to CC some maintainers,
please be more careful next time :)

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20260611023830.106259-1-rafdog35@gmail.com/

