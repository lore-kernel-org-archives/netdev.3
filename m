Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A126738B
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878840; cv=none; b=kchTlOxr9uqNuywyqdskifHdQenHJu3gf7cCXUqfDezUiDBvgbqQAGFsu76An2NHe4rNnQN9GZ9mIdudpAZigixqQkBtu4NagbI0mkXNFKhWIax5Olei0GhP+z565RgA4QZHohm09zi/BDhVvNgodafxfLnJzuL8Oaz/6f4hzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878840; c=relaxed/simple;
	bh=qNUPS+a3BrFb3/Kp7YfjMtsVYSxnvEkGQM52t/E7DfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CX2U5KBh0UzvqZV6DaXlNCerqasO20VtkpDBQe10DnLMs5i6Yvr/wxSDGF6zmaIm26nIG8ZD5WL1K0g6wzimOazw0cmYko2NE5FgauEvKdtcivGCHYsWfP4b9pS2k4PpPXoSi9p4EAAwBb/Y4aWrFsmnk+G1gsf7/hMgyKn9xCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0fyett/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oNYV2syZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0fyett/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oNYV2syZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784878838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RU3UY4EQSRuskKiXSUK7GU88ZgZpccmu35eGION+JXU=;
	b=J0fyett/FfOIcNJASJP+3llTUtxw81m8Ch8FENrhZ8GlwISvCvE4hQs0k98dmvYr6WqUXv
	BA0wNnoz+CB2qDqo+5aAJK6IYKOw8RorhJOVHJSYcxfGwSly8GZL7F9sjtNAcGPMLka2AV
	+cBYd9AqhKQJDccGIsVFq+Kp1RvmtKk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-DPtTc2_pP8OqkEtoFwUszw-1; Fri, 24 Jul 2026 03:40:36 -0400
X-MC-Unique: DPtTc2_pP8OqkEtoFwUszw-1
X-Mimecast-MFC-AGG-ID: DPtTc2_pP8OqkEtoFwUszw_1784878836
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f7700ffdeso68894f8f.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784878835; x=1785483635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RU3UY4EQSRuskKiXSUK7GU88ZgZpccmu35eGION+JXU=;
        b=oNYV2syZ3s7JqQdUZQ0RE1+/9DA7KcVBix541SOctt6ZoDJQh82R7wEubeFvtaQGON
         Y9pUI6Tm4v5E3bIZ09RK0GNAN2fyu0G/FaRZpndo/yCB+b0Tx7XugH76l/f1ijZ8yGRd
         t1svGvA6xWEgZuQaSAvdTEC3YVOsOZzMiYgrzVRnrl6pGL03QO6HVy/3QIpHUyW40qZz
         N9buNDJF+UirTR7JjBc+ajY/CpXWMZty4iqCIsvBh38mr0On5GMNi+TLvzh5pRDIMCwO
         kAXlm1SlwHYIMp/WXyUMVM9JplTLhu7p3KDfJRCHoAp/EwnhsHFBwqH8XW518AMQXZrx
         3Y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784878835; x=1785483635;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RU3UY4EQSRuskKiXSUK7GU88ZgZpccmu35eGION+JXU=;
        b=FXdG6kNYqEe9K37alYD0HSa9jyTsTfpSP/i4vhO95QJd0aU387qUVr4L+PgsjaCdMw
         3MgxlWlpR7foVwR13dNA9huyEDPrcPh0kNmEPb23zC7mhGiNP/NqV36lkxnD2JzTzLTp
         VM8uLOHo+qI95Is5C36AwV52n9D6BkgQ5305j6K+/Ob2blfiQ/4bT21UxLOASllF9T3V
         wc1CX0Xz4enSrzmhPw6KzBzk3SeNXuR32IANU9OkF3UKCS69G7M9uclQPnC7UXezjGTr
         Lw3EyQa7LtEAQZegjq7p0qsMnAEdAmqrS1wbZVDFN5zhmWMNubdkkopBecyijA5haHkI
         XheQ==
X-Forwarded-Encrypted: i=1; AHgh+RptcG93rX7XSKr0yynn1edzro/u0Ernrf16KddudTo+rL9t8TQjJ36vtFo515Nkc2m/gl4T/U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkHwqHUcYI5RAbvkpb9Nus/w0BRFZyl6K2gzUFxYKdzhuh8oY
	yfECBPrEiGRgr+UOOkCtCF144D5ytwLkfVHhdGIkrtyMU65jfZCyax1n/4n2OrXAv+a/PFsHFRe
	+FOPZL4Xr4/JWLZPWv5s84x0OLw6hWA1EpPkYWUshqFWQRwySrcULWHYgnQ==
X-Gm-Gg: AR+sD13H67KJBgaBfz6ZYCbknmw6QHqiwPVzBWz+X1vDXaYynESnREt1Vn1DdyTykkg
	HzSS6MhmsSnERxED74QKrKQDnGey7nY9UiFMf61KhUtHRMw38lNaISe7F6n4nk+/VClm8iZB1KR
	LggEvG2oShf8fanH+BLz37UjHqYWmHBgfJpbLHgV1n/oBOc/1OvBmoZG1PHXes5Vsqvbis7f7CF
	bv1bR4oy5QSzt2KhRPQpGtVzV7ZysND8mgqzL4cNCWv0s1NMfFCBTAOHECXeevburkhwbVl7lih
	gCZvGmxVMIseVnJtskCLoz5vjlj/zm+J0Qc77pyJrdRF48Tx+Eldm7oXoEhsicsKLtv9FfjNZKb
	NGVCpPech0Moq2Vyv9r62KtI9YjKgjxCUToXItDcrDfn3vuxZpDamgmPW/Oed6ln1au8YNaZ+5g
	eMog==
X-Received: by 2002:a5d:5e93:0:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-47f8da69f5bmr8371513f8f.14.1784878835512;
        Fri, 24 Jul 2026 00:40:35 -0700 (PDT)
X-Received: by 2002:a5d:5e93:0:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-47f8da69f5bmr8371475f8f.14.1784878835063;
        Fri, 24 Jul 2026 00:40:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm20232925f8f.29.2026.07.24.00.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 00:40:34 -0700 (PDT)
Message-ID: <fa33ce0b-d040-4c4f-9bcf-4ccddb127b92@redhat.com>
Date: Fri, 24 Jul 2026 09:40:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tls: don't abort the connection on signal-interrupted
 sends
To: Jakub Kicinski <kuba@kernel.org>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, bcodding@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, svens@linux.ibm.com,
 brueckner@linux.ibm.com
References: <20260720090940.1334523-1-maxbr@linux.ibm.com>
 <20260723092630.1a1c9b4e@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260723092630.1a1c9b4e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 6:26 PM, Jakub Kicinski wrote:
> On Mon, 20 Jul 2026 11:08:47 +0200 Maximilian Immanuel Brandtner wrote:
>> When a signal interrupts a blocking send, tls_tx_records() treats the
>> resulting -ERESTARTSYS as a transmission failure and marks the socket
>> errored via tls_err_abort() with the raw error code. Later syscalls
>> return the kernel-internal errno 512 (ERESTARTSYS) to userspace, as the
>> signal it stems from is no longer pending during syscall exit and thus
>> never translated.
> 
> Can we just add ERESTARTSYS handling? I never heard of the other codes
> you're checking TBH, can they actually surface?

FTR, I think only EAGAIN and ERESTARTSYS can be observed in the network
stack, and the latter only after sock_intr_errno() translation, i.e. on
sendmsg()/recvmsg() return path.

I would not add additional error code handling, until we have some proof
that it's needed.

/P

