Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD3347506
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450976; cv=none; b=YxW0hWvWP1nsf0piU4JALIKrZbuTHErx2kkVxC5aTV3RkwGBqKadfWejdCc6zNgSXo/0M6rrzgz8zdd3zEp+MLeAQuXX6iLXhapn0AGSxR5qfQbaX4+WzEx/cAqmF/mxtfh9ycZXjxhF+BK8709jgtNOZ9tP/ZqrriyYQCHxDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450976; c=relaxed/simple;
	bh=OXjwWaAHCtJe/l1tvo90Y//Wq15ugOpZvjih3gIWlgg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kwExyUFJNVqfMuBj+loRQeLaYUiCDRaACuHlJS+yK0erZ2y3okdk+YPVc0y2Ftr99aVAlCDBm82oj2ea8h8AKLPW6OMnpNkjTxhJD9arMC4tLdgunU7SzSUYD5LEZ8Q4iMd9pV2Tbl65dOVkGGYY3DSNfLJLsxN9Wz7FUu1voD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVwmLBiG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVwmLBiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786450973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXjwWaAHCtJe/l1tvo90Y//Wq15ugOpZvjih3gIWlgg=;
	b=HVwmLBiGKNH+YZBup25Adc4kdmX/MVADFluo1KEfc1ypsUmSiSrMQJfGkLYrRRXFRARSZb
	qTU3V2btGKQXpygwmxMCQ2e35y5mdIcfbmFLkB5U+nObL1JZw4FtTC2tZ3bhVoffqNMtJJ
	Hbi9txqVPhQdjEw3ytK19RKUqf1paFw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-h5trJIUWN6WM6DBYAzrkbw-1; Tue,
 11 Aug 2026 08:22:43 -0400
X-MC-Unique: h5trJIUWN6WM6DBYAzrkbw-1
X-Mimecast-MFC-AGG-ID: h5trJIUWN6WM6DBYAzrkbw_1786450961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BA341800984;
	Tue, 11 Aug 2026 12:22:41 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA8EC19560AB;
	Tue, 11 Aug 2026 12:22:37 +0000 (UTC)
Message-ID: <2a02b878-d605-4db4-a9a1-7323beb35e4a@redhat.com>
Date: Tue, 11 Aug 2026 14:22:36 +0200
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
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sashiko findings and replies:

 > Does capturing the post-timestamp here degrade cross-timestamping
 > precision? [...]
 > Should the post-timestamp be captured immediately after
 > zl3073x_chan_tod_ctrl() issues the command?

The post-timestamp must be taken after the semaphore clears, not
after the command write. The hardware latches the ToD value as part
of processing the command, which completes when the semaphore is
cleared. Taking the post-timestamp before the wait would risk the
window not containing the actual latch event, which would be worse
than a wider but correct window.

 > Could this retry loop exhaust its budget and fail spuriously [...]?

Testing shows that a single iteration of the loop body (two ToD
reads) takes approximately 17-19 ms. With 20 retries that gives a
budget of 340-380 ms, which is more than enough to outlast the 20 ms
margin window. After the 1 Hz edge crosses, the next read returns
~980 ms of margin and the loop breaks.

 > Is it possible for preemption to cause a 1-second clock shift here?

The 20 ms threshold provides sufficient margin for the write
sequence. This requires ~20 ms of preemption under a held mutex to
cause an issue, which is not reachable in practice.

Thanks,
Ivan

