Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BC4119E5
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450923; cv=none; b=Z88vwAarL64wyGZyHVZWFT+K9qwapA2X1xaDsU4JNtiiNJzb69c4xYbqzqwP+FN0P1x7cmb6KpsoQmH46ydK8riDgYSV91IUj11dkdH8caHQ1j0yl8KL59aqAOIYcnp298ZKUDm0wXaRmdzF5w1G/YYrLasS9+cWPXuHXa+PxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450923; c=relaxed/simple;
	bh=fEYU8xAouRfc5ZCZBLiJjh8Oi0+YJlROnuSe5mT4XOM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z1bVpQrRYFNZrq0bbQMBhiQyQxQ4y2tzOThI4NYVMUu2mBlNnUdZcgQ4+WWMeN5V9Z5dvcu97yiufMh74lrvtxwJWxVyY+z6TT4RCjDHRjLQ6SqtYY28PArLeWzqGwwgo7rR/Hi5SU/JLSgg9tfbHIEV4rBRCYeh/eEpfO3+d8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jF37Yqo2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF37Yqo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786450920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEYU8xAouRfc5ZCZBLiJjh8Oi0+YJlROnuSe5mT4XOM=;
	b=jF37Yqo2nRoWICeqeJjsF9r+9o9BSivEEVfQ7VE2zeOA7qpy5k30SacFGHo8m94gJ3ZTaT
	oOE6kpfEKlc6DX5muiOncizZ4Fa/0UIMqFukBQnJAMCINJc9LO74C+mgQyyZfdeun/zIvK
	ebUovh/RYEd0h3sSHYkui8UUOEFBkN8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Rk6wPaOlPh2cJrNE34ARsQ-1; Tue,
 11 Aug 2026 08:21:47 -0400
X-MC-Unique: Rk6wPaOlPh2cJrNE34ARsQ-1
X-Mimecast-MFC-AGG-ID: Rk6wPaOlPh2cJrNE34ARsQ_1786450905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1964F18002F8;
	Tue, 11 Aug 2026 12:21:45 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9967E19560AB;
	Tue, 11 Aug 2026 12:21:41 +0000 (UTC)
Message-ID: <4713be61-9c2d-4799-a88a-db8e3eb33021@redhat.com>
Date: Tue, 11 Aug 2026 14:21:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
References: <20260809182340.1081610-1-ivecera@redhat.com>
 <20260809182340.1081610-3-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260809182340.1081610-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sashiko findings with replies:

 > Should the kernel-doc match what the function actually does here?
 > [case 0 returns without testing SEM]

Will restructure tod_ready_wait to check the SEM bit first. If SEM
is clear, no operation is pending and we can return 0 immediately
regardless of the CMD field value. This also handles the unknown-CMD
case from a prior boot stage gracefully — if the semaphore is clear,
whatever CMD bits remain are stale and irrelevant.

 > The documented return list [...] does not mention -EOPNOTSUPP.

Will update the return documentation.

 > Can this loop exhaust its 20 retries on healthy hardware and return
 > -EBUSY?

Testing shows that a single iteration of the loop body (two ToD
reads) takes approximately 17-19 ms. With 20 retries that gives a
budget of 340-380 ms, which is more than enough to outlast the 20 ms
margin window near a 1 Hz edge. After the edge crosses, the next
read returns ~980 ms of margin and the loop breaks immediately.

 > How is the measured margin guaranteed to still hold when the
 > WR_NEXT_1HZ command finally reaches the device? [...]
 > Would a post-write confirmation [...] be worth adding?

The 20 ms threshold provides sufficient margin for the write
sequence (ready wait + three register writes + command). A post-write
confirmation would add complexity for a scenario that requires ~20 ms
of preemption under a mutex, which is unreachable in practice.

 > The kernel-doc says delta_ns "must be within +-1s", which reads as an
 > inclusive bound, while the guard accepts only the open interval

Will reword to clarify the exclusive bound.

 > The ToD ready wait logic fails permanently if the hardware control
 > register inherits an unknown command from a prior boot stage.

Addressed by the SEM-first restructuring described above. If SEM is
clear, the function returns 0 regardless of the CMD bits.

Thanks,
Ivan

