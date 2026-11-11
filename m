Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411335;
	b=D1iWLPY5WvQ1h5ydKgEgY+reasmNVi21KqDHci7m1MqLmtTehrpkbmssQSGI6D3rCD2x
	 1XK+46ADyNmuYxs5hyG1lyWDPXLPexSjg7nA6QL6zthTu3uEE0FZKIZRviaSn7VEXDjYB
	 OY6TQqqsjBqel0tGjDfO83hVG+LS1JOMLaLmr6zMVjyOn/N3jCMuH7QemkmU4EmRFJMHw
	 QsIhQTJWplIH0neKpfSiuMcsHYgYYMeALqtJfgaowLF2llRGulEY+LsiABjy9mGwynPbS
	 0JXK82ALHFSzVmQPIDharKVCvnYockm4Rv1bV1onKO9gcr+7W4ysLIq6Di5AoR5BkEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411335;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=eyAJwUXldOFiID1lt8LpzD8hOYLOWfNlSGMR02veMHU=;
	b=rOdqp5g93O4msIB5pggw0L5fUrBpywr6lk61XUTyARHJHPji8vFxS4ZCmi5sDko4i6KU
	 bDqHQ5KizLY1Opnp2lF4I2ufdx0bFPVcxdLf4dqLrImSixEtsJk9/IMK93LYzSENAmX2k
	 a4slx9uZEO5he3vJlxbzxjgsZuYsaNpgYs6h4JldeYeyGe2s8Huz6CU8RKcFvXPQIA3iN
	 Ky+ubabNIm3DTmCECcTSozu6sFmC4Q1JTGsU+UJbnkqoHX8xY9mo6mw+2A1vUZ6BXLq/T
	 vWJuy6p6y3O6jZihUG3nzw4+ya54aNAwz+RvgTujFZ4fcRHxJqy21cC1dCLkYECLe0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RnHKV9WW;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FF60A260C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8FF60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RnHKV9WW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794411334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyAJwUXldOFiID1lt8LpzD8hOYLOWfNlSGMR02veMHU=;
	b=RnHKV9WWj1Fa7ts0CRzG2MiQvsrBkwMjvQc3cv8ITSrekf5FbE5RqiujKCtlOAXEdYI+hS
	cBlqleS8TcJTGio9wTbTe1xtozIWNGTSp8ZYHOKgwiM8bARaBZxB/dReV8owWLInkhJuPH
	AJ5AEz8a4Aue/qsbCi7AEQAz+a9RRH4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-o0S3b9heP5iY-9-aCziosQ-1; Wed,
 11 Nov 2026 10:35:27 -0500
X-MC-Unique: o0S3b9heP5iY-9-aCziosQ-1
X-Mimecast-MFC-AGG-ID: o0S3b9heP5iY-9-aCziosQ_1794411325
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7A418007F5;
	Wed, 11 Nov 2026 15:35:22 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 105FD180054B;
	Wed, 11 Nov 2026 15:35:17 +0000 (UTC)
Message-ID: <88ed35ab-0e35-44b7-a74a-fe8db58755b9@redhat.com>
Date: Wed, 11 Nov 2026 16:35:16 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 01/13] dpll: omit pin phase attributes the
 driver has no value for
To: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>
Cc: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "prabhakar.mahadev-lad.rj@bp.renesas.com"
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261110202607.55744-1-arouhi@sitime.com>
 <20261110202607.55744-2-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261110202607.55744-2-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/10/26 21:26, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi<Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> Let phase_offset_get and phase_adjust_get return -ENODATA for a pin the
> driver has no value for, and leave DPLL_A_PIN_PHASE_OFFSET and
> DPLL_A_PIN_PHASE_ADJUST out of the message in that case, as
> dpll_msg_add_ffo() already does for the fractional frequency offset.
> Today any error from either callback fails the whole pin dump.
> 
> A driver that measures the phase offset only on the input its PLL
> tracks, or whose part holds a delay larger than the s32 the adjust
> attribute carries, has no value to report for the pin, and a zero
> cannot be told from a measurement.  A phase adjust request on such a
> pin is passed to the driver without the comparison against the old
> value, so the delay can still be set or cleared.
> 
> Signed-off-by: Oleg Zadorozhnyi<Oleg.Zadorozhnyi@devoxsoftware.com>
> Signed-off-by: Ali Rouhi<arouhi@sitime.com>
> ---
>   drivers/dpll/dpll_netlink.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

