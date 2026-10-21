Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575372;
	b=WNITPPBz/fhCD/N2otXVCMhI4SWHsTDqEnpWDl2LL9gS/PDfe1ndLKp0YTp0CBsHiCII
	 EBt2ADv2VvKFE3Vo18qmjR65/hiPX2KGCzHpD/5hkQqmgFRPhvzb+KlxmdAYAERP56mIb
	 0dvsCtYD/FTTj2+bo2sDtsY3OuHq9teeYlePymVw2A8uB63oCrLW0rBfI0wkG+snAOu7X
	 21yoFYCTdwqV2SBl48YJEM0YFxugkfVeKqAci4md5xUsTx08ek5RSRAaUAz6NTehS9s/C
	 Nsqy12dixleqlDIscbmQX0JS1HRyJhPomG6qOyKGpyktSidWQipZ4WshBz+jF2TOV8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575372;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cYn3RNb6sZTF5g4zlzB0KoIbKyBPsuwon0NlGTXggxc=;
	b=vubJ/D5wGY05YEq0LvVjssDqXPY72LZLkeif31gMcfoGit8vrlg2uzDjWK/6q+WBY5qe
	 APcg+ds4Pd8NaoVE9IRKY2dgTbhoeYShcsp5z209YVPdR2pwRG8dYY+nSbHpbB37ykISZ
	 oPzkD2OR6MPiz/YpfxZy6lApTmF4PUw4DSQdcIq8sZlksH4u9IY0fovdTAD42e5YLl9yH
	 xN4qRamGubdE2HDbkVDwtip6qnrLPlZn6mjbfB/j8/9IxbBL3HxYPnvrD5BZ4gzUdclPC
	 Gd0GiPahwLV+hmhKJWVRPp4tPZdRPJC58+brEskN1ppb3WIpqgyZuMknaXGhUEuYeeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JjTEMDlh;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="qhRLRo/M";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC4606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DC4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JjTEMDlh;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qhRLRo/M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792575369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYn3RNb6sZTF5g4zlzB0KoIbKyBPsuwon0NlGTXggxc=;
	b=JjTEMDlhceFtrzqx4NkVQH3aNgYe+JyMd+m44jvREOu4qW6WdJnv6QQxe0zjdLrSSXc59l
	Tq//zjrmdFm4XWSD/Y3fPrzYLunXH3bcoeSCx+9mJI6QVbFkJ6jHr7EtOd0+i1X4RoQbJh
	pbqSNja5GnsjAo01S0SakuGKhYAGFGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-KVeT7Oo2NDS8Bo5WR7i2Fg-1; Wed, 21 Oct 2026 09:36:08 +0000
X-MC-Unique: KVeT7Oo2NDS8Bo5WR7i2Fg-1
X-Mimecast-MFC-AGG-ID: KVeT7Oo2NDS8Bo5WR7i2Fg_1792575367
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1de9dac94so4884465e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792575367; x=1793180167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cYn3RNb6sZTF5g4zlzB0KoIbKyBPsuwon0NlGTXggxc=;
        b=qhRLRo/MfxbP8EPkU8684Xy4stEf+aPg7UB8MMYR5PU7qWgtsUIPI4kOhzmA9e2eU3
         jrVwI5SOESH1p8p+sJxJSMYfaXPT0+VWQyC6npTZg3KoraKTwMMyR1DkaWirqKycHJ3q
         ery6lU2vBOJ6e2o8uKYWNVkbE6ouKEUljaBaejIMcwVjt02/MzWcyo/tzycT8Iw9XTbN
         BbadZHemJz7rVICcuAp35gFl1rQkhnljnztcu6BpZnLOp9rLkl/Qy1aLluhexFv+CNMD
         e9UFKTXLSN54OXkdgeY1RFKcq2fLdnGAwdz9tnLnpiRkKDIUooctkaHfwQ2oQ1xcbzUZ
         Z6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575367; x=1793180167;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYn3RNb6sZTF5g4zlzB0KoIbKyBPsuwon0NlGTXggxc=;
        b=uwWkaTw2VONgzhANdcX++j+aAaQDaJN4ZwJ6kKAFEt0mN2M0RQzG/jC+Lyo9+jGmiB
         kF5irvLqFpmibqR2EnFwpPJy6CYypK0pzaMlwQO8ajP2TWQypu7exjijHqpgspdwmYCv
         bRdY6cT81NU1p9T8OmZPdMic0GHbypEz/suOjlQkC5a/PmFRCQa98iCQR8JGzigWsy/d
         pga97hJ0J1HbLB8VgNF8tpvEquwF6e514XNf59ZVlVRKQdJctbp+vgqtuVkrq3ndHzlO
         uPF27nnWxELUiWNDUTWgK2OT3WmFFG8x10AvQxv5N8jXmerBCt2/8pbFgIOAm5mg/nz1
         IgpQ==
X-Gm-Message-State: AFq9FYJvTfAK1gtQBliDTgJ72Egau2Fz56afbs4pCyE9UNjHKLAL8sLB
	C65gl6wMR7qJ/NKRLizQPzzUwLdqpmGKLUZEiHMt93caAnvV5jyk8e5SZFM8aecx0pG7rWixqD3
	YmZovJIaETGD3t40UGhAMgIu1jgvufHH3KYBUIcGBlD/QyxRhvi2stpdBXg==
X-Gm-Gg: AYBFou1kSmxJgBhEkaAjsfRgqZl4VBFZ+Jn6W2NzGNObZ9soSPHzr/OyaAPgXrI5CNC
	drOkmvWEew/08sHYDLGHNMhfly99KkLGnUT/BmzI8wdsYd71kdE+vYdFE4uaGhcIKauyA6sD8o3
	h/HugcEDspAucvSycWONrKm8FthAOjUK6nRsdxHjk4Phf1qWgspFHWiMlOd3Xg6Hs30Qvz1HrZ8
	sTJWWc7YAu9qSvp+YACnai9JXVMHqDHTK/CVLd2YbRJmsmJvpQ2GxwfX0pv3rhkRO8SnlnLrERu
	zEBA+eZls962pbqLgfXD2YSmJG5Xj3kTls0HOaWsNDzRfBF1byMgV9ORL8sLhP4z2upuciZhwRZ
	pgfagFg==
X-Received: by 2002:a05:600c:1c09:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1fdb1f0demr32976615e9.15.1792575367129;
        Wed, 21 Oct 2026 02:36:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1c09:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1fdb1f0demr32976135e9.15.1792575366576;
        Wed, 21 Oct 2026 02:36:06 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d569d4sm145262265e9.10.2026.10.21.02.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:36:05 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:35:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bobbyeshleman@gmail.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] vsock: move SOL_SOCKET options to
 vsock_sol_socket_setsockopt()
Message-ID: <atiHbzuo3s6efCxW@sgarzare-redhat>
References: <20261016132716.272018-1-devnexen@gmail.com>
 <20261016132716.272018-2-devnexen@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261016132716.272018-2-devnexen@gmail.com>

On Fri, Oct 16, 2026 at 02:27:14PM +0100, David Carlier wrote:
>SO_ZEROCOPY is handled inline in vsock_connectible_setsockopt(). Move it
>to a helper with a switch on optname, so other SOL_SOCKET options can be
>added as new cases. The value parsing goes to its own helper too, so each
>option can do its own checks before it.
>
>No functional change.
>
>Signed-off-by: David Carlier <devnexen@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 90 +++++++++++++++++++++++++++++-----------
> 1 file changed, 65 insertions(+), 25 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

