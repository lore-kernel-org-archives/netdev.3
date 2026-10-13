Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C23D1CB2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886240; cv=none; b=mc5YoMQ7yPa3RwfW2GopAIMVD49uivjA+0vSj5qBdNOVHhpI8lEIrXS2scYSV4TJc/EHqCNGxczve4xc94isEA1/dx6BiZvrArUAjyP1A542py00ZONxotDrfB1ErQIKG79nVQ8FSUlypJEtQ2vqGHorfrhlEOBV+PoRLEW8rIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886240; c=relaxed/simple;
	bh=rPU66RTkPOm1XDuhtTsXUMgzuLrL8zDkGyJKBwoH8qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGOp1qq19nFn0G+RElZI3yqfGaIVLTSTsRytwVmk+whJgqGkXS3BpzOyU97qmPSVj9og/I++Z4cd5yL28tOlljigBX14rOe2B6rT9jrmYYAZgv24UlnvkzbM6dBQnvr8ToRgG31eOvHxlF1eniEPpjnI89YHxxCpk24d08uH/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4mTkuxs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4mTkuxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791886237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1p+nu/hoPn9auVbQdjmwrR26tibasmC89HS5LmsL5A=;
	b=T4mTkuxsyzsFfMGgkExIZ09ZaD71AS/5z8meiBfiwXFkJ7lUCOTKIR4No/F56xkCqbUjf9
	uty6UzzoiCgSmI9lNXXunWs5/2Qdh7pFHnFZRx/PXMTPROGxl2ipxmYn7fT18PM6DOnEm2
	rjvlJpYEC4StYGRmNjd1bdJDhVy+LDY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-ZF0yr0d4MZuGG3faoNCPiA-1; Tue,
 13 Oct 2026 10:10:34 +0000
X-MC-Unique: ZF0yr0d4MZuGG3faoNCPiA-1
X-Mimecast-MFC-AGG-ID: ZF0yr0d4MZuGG3faoNCPiA_1791886232
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84FA1180B5DA;
	Tue, 13 Oct 2026 10:10:31 +0000 (UTC)
Received: from [10.43.2.199] (unknown [10.43.2.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 637BA1956086;
	Tue, 13 Oct 2026 10:10:28 +0000 (UTC)
Message-ID: <1772855d-e738-495e-abb0-7f064a3e3700@redhat.com>
Date: Tue, 13 Oct 2026 12:10:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/12] dpll: sit9531x: add support to get
 phase offset on the connected input pin
To: Ali Rouhi <arouhi@sitime.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-12-arouhi@sitime.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261009183151.78497-12-arouhi@sitime.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/9/26 20:31, Ali Rouhi wrote:
> From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> 
> Report the phase difference between a PLL's reference and the PLL itself,
> which is the loop's own residual error and therefore trends small on a
> locked device -- that is the measurement, not an artefact of it.
> 
> The value comes from the on-chip time-to-digital converter, read through
> the debug window: unlock the window, point it at the converter, then read
> the trigger register, which latches a fresh sample and returns the
> previous one.  It is read three times per sample for that reason; a single
> read hands back the sample from the last call, so a repeated measurement
> would look perfectly steady while saying nothing.  The offset keeps the
> fraction of a picosecond the converter resolves.
> 
> Only the input the device feeds a PLL has a phase offset against it.
> For any other pin there is nothing to measure and zero is reported,
> because the core abandons an entire pin dump on an error from any one pin.
> That pin reads zero too when no sample was taken: the PLL is not
> tracking, drives no un-muted output, has no usable VCO rate, or the
> device moved it off the pin, or the lane lost its signal, between the
> check and the sample.
> 
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: LLM
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
Reviewed-by: Ivan Vecera <ivecera@redhat.com>

