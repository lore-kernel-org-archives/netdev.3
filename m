Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF84B04A3
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786891686; cv=none; b=WeEztniaPnumHiRPvoPi0s8s2FaMclsdMShuCHmZ8LEV5W6WcuABQ9Nrn40wEJKi61POCtdCHcXayByjcmU0YnL+fskw3liKV1QTulwWuyWCi6xSI0pBdSngjru/VaLYJlSv1/yrg0/+XabQXp0aVrs997djqEToGvmA3Z5mJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786891686; c=relaxed/simple;
	bh=g9o4fmsQQ0ZYb51H9mi3ELNVu8/0tt7RS4X9ffMDFw0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NC0ki3pq8E7iIL9bopyBFZQvJ83OYtQcd4O3isecR17Ko/A0IuTcaBdHJ9MYaHABxByUeYjIdkjuEaEJaB4fQaQslp7obN2KeWsETxUcqCYfMVj6U9X2iUEWxTYGm5Hl3hJNqSMqazQs9Jw4QpiD8X5ugkfHPeaElkvdBxMoNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q65g+cLv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q65g+cLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786891684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9o4fmsQQ0ZYb51H9mi3ELNVu8/0tt7RS4X9ffMDFw0=;
	b=Q65g+cLvl6z2bdqgPiuxsRqN6PlOYGKzWNsejx6H2xeERevzv3t70Jbu5rlwBULHpPgkNZ
	TBtuEi4BXKRrAvM/jhtUkCKfPOd30B1BSiO2SPYO/007BwmhWAqGnKNVqXJwbL+ooHr5Sn
	LYYDIGrrMSCiZr8Vt/iQzTdnKbS8q/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-q09vjwjjNfu97Yc-p_tTcg-1; Sun,
 16 Aug 2026 10:48:00 -0400
X-MC-Unique: q09vjwjjNfu97Yc-p_tTcg-1
X-Mimecast-MFC-AGG-ID: q09vjwjjNfu97Yc-p_tTcg_1786891679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 379431956095;
	Sun, 16 Aug 2026 14:47:59 +0000 (UTC)
Received: from [10.44.48.13] (unknown [10.44.48.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32FEF1800346;
	Sun, 16 Aug 2026 14:47:54 +0000 (UTC)
Message-ID: <9c89e4e6-8dd8-4353-9354-1f85eb17fbc9@redhat.com>
Date: Sun, 16 Aug 2026 16:47:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260814082656.306534-1-ivecera@redhat.com>
 <20260814082656.306534-3-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260814082656.306534-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sashiko comments with my replies:

 > Can this loop spin out its retry budget without ever giving the
 > condition a chance to become true? [...]
 > On a fast bus where the ToD command completes before the semaphore
 > is re-read, all 20 iterations can finish well inside the 20 ms window

Testing on I2C at both 100 kHz and 400 kHz shows that a single
iteration takes approximately 17-19 ms regardless of bus speed.
The iteration time is dominated by the device's internal processing
of the ToD read commands, not bus transfer time. With 20 retries
the budget is 340-380 ms, well beyond the 20 ms margin window.

 > the kerneldoc for zl3073x_chan_tie_write() states delta_ns "must be
 > in (-1s, 1s)" and nothing in the function enforces it. [...]
 > Would an explicit range check on delta_ns be worth adding here?

Both in-tree callers already bound the input as you noted. The range
guard was intentionally removed in this version at the reviewer's
request — the internal API should trust its callers rather than
re-validate inputs already checked by the PTP core. The kernel-doc
documents the precondition for future callers.

Thanks,
Ivan

