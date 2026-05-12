Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D437E2FD
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599567; cv=none; b=NVwj80S9nwLUUptbDXLgiUw9lcstBTWPDlggXkuu9koZ4RRo6pA0r6/WQBALS7SK5jiRH5XrSfMRM7YqT1psftbQxYIX7t6CIY7MKNDP1Z94c2DHCeGikisfEzlrviwcd4S+d7EcixYd+dA0kwbvfFEvebKzynLYt7VqF6tkrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599567; c=relaxed/simple;
	bh=ffZy2kfNgvHS+JGTIgdWxM4XJMkx2tu9AOXcQklA7ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qgs8mDcdkRNHfFIMsFZRTEdpm1/qYCVf52HIptN/IAeB/TAFCBgztszXe7kCYaSEjwTI7JcSlLIJhUotZoEDNCFVKzVOIYzJ6RpBzFUL9hd6gaJFWzNSMgtDTNaf97uUgeoxV0IVnts6mV1pZlPOgXrbB3uovtaV42v+L01Fnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNcXcrsK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNcXcrsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778599565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZqun5gRgHlzrix+SDru25IWKAwzYxDKCLOMzrieAZ4=;
	b=iNcXcrsKLX5NYr77PSGcaJPKwozCCumek/kVHbaCVYjRf2Ogkuw1JK0W5uWCfFwar9yY0o
	MUZOgo5Zr7BUVpNYR+U7JsNJcSjHhF+CU3g+dY7RIaRVMfjv0iec/NZbz5pJZ+4MOIKNKG
	i2k/dpkOyQfzXykx3kO0PEHn/T++IwU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-A6nTWtYeOXiUjBpkSQpvGg-1; Tue,
 12 May 2026 11:26:02 -0400
X-MC-Unique: A6nTWtYeOXiUjBpkSQpvGg-1
X-Mimecast-MFC-AGG-ID: A6nTWtYeOXiUjBpkSQpvGg_1778599561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAED7195606F;
	Tue, 12 May 2026 15:26:00 +0000 (UTC)
Received: from [10.44.50.38] (unknown [10.44.50.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 586081955D84;
	Tue, 12 May 2026 15:25:59 +0000 (UTC)
Message-ID: <18ca4ef1-3ba0-4a43-8070-844fc6713be1@redhat.com>
Date: Tue, 12 May 2026 17:25:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/2] dpll: align help and man notation with
 actual option parsing
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, stephen@networkplumber.org, vgrinber@redhat.com
References: <20260512135225.167158-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260512135225.167158-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 5/12/26 3:52 PM, Petr Oros wrote:
> dpll uses getopt_long(), which only accepts long options with the
> "--" prefix.  The iproute2-wide "-X[name]" shorthand used in the
> help text and man page implies a single-dash long form
> (e.g. -Version, -json, -pretty) that getopt_long does not parse;
> only -V/--Version, -j/--json and -p/--pretty actually work.
> 
> Replace the misleading shorthand with explicit "-V | --Version"
> style so the documented forms match what the parser accepts, and
> drop the redundant second usage line in help() that listed only a
> subset of the options and implied dpll could be invoked without an
> OBJECT.  No functional change.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   dpll/dpll.c     |  3 +--
>   man/man8/dpll.8 | 12 ++++++------
>   2 files changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

