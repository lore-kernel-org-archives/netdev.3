Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501523BF680
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957559; cv=none; b=YxQHIEiaQyC4ulU1ULTFLJf7JsxkRujvfsmj3w393fUftOkZi+UjLwl1lq1kNIgvZI4vU0DXUtHllcMhNcHqHqeLiOzyARjOOZZ8pDrJcicMbGhXpXCucng2SO341cIn0/zXZdilcqzzJyRTQ70eAPseIQuttJyuAh0phzbuleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957559; c=relaxed/simple;
	bh=OUYgSyX/AmDPuYbf1y3UWqD6X57Ff9v32jLUL2uOyvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMLLojyKM103n+vk2E71dxkpcnHIKYOimONqD5zHvJFbbg9dkNEEoSq5lK5SLpF1NqzhSWblqN9kHr23NLaj2x5KAup76ZwGz9XP0gVwSbENYW7Df0z1CsLyjBAN/Bjx2e1so8acoMBrzYr/LpjiJqpxfgRIyAM67rWJqpZrxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fkYG71kO; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fkYG71kO"
Message-ID: <a7a044ba-5235-42c5-b6f3-6f23d9724b67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774957555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ReF17fCkadAbkp2YDOZfTTfqawmF9ZRpg/8RnG+xBo=;
	b=fkYG71kOnHTFHNodR2v4naruaqj+qjIgN90zJjNgxNLRAHHRmWPMT2y+0FS1b2LfWLh94+
	ZxA64KxRdIHUKVKzYSeMHpQEx0fViy4F6wYlIxWHhKMCWHRbIfQVkxxPWwHJs4dM0p0Q79
	H/rCAjL0jTOf2sGW3AxuBvcrn+jyOGc=
Date: Tue, 31 Mar 2026 12:45:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/3] dpll: add frequency monitoring callback
 ops
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260330105505.715099-1-ivecera@redhat.com>
 <20260330105505.715099-3-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260330105505.715099-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/03/2026 11:55, Ivan Vecera wrote:
> Add new callback operations for a dpll device:
> - freq_monitor_get(..) - to obtain current state of frequency monitor
>    feature from dpll device,
> - freq_monitor_set(..) - to allow feature configuration.
> 
> Add new callback operation for a dpll pin:
> - measured_freq_get(..) - to obtain the measured frequency in Hz.
> 
> Obtain the feature state value using the get callback and provide it to
> the user if the device driver implements callbacks. The measured_freq_get
> pin callback is only invoked when the frequency monitor is enabled.
> 
> Execute the set callback upon user requests.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
