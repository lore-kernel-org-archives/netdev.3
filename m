Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B613644A4
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695110; cv=none; b=Ogi3RGpD3saTdZ1cIj8kZx/nw4mHAf5mOXW+DZTp/9Q3HHgMMn4LgDCOUGggWwvibU5JpwNJZhmsY3BBj1YVgM4/Ak3MBrQSbbSA/pZE8BEcB2iud/L3wJ24wpDD+QCPKV7/jSgv5/H2/sSjypFE9ls9VqeOt+wjLW7aOfIiT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695110; c=relaxed/simple;
	bh=9Og5jXYfO/MTFbbigamKhkKrathytUs/AVf/7SK0Kfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCErSDl5F22UEKtOa0j6L1SXpYU18zq837oO3Edx+B8D72TjOjMJKqXmyx4tIQsPw9NEAK1N5h3T4ycEbCRDNl4N0GxIXcmeGBgWh87IvHkX1GOa0dnrinJHRBK7KB34vtAmOdxmpFoMzWvCzhhnKDsLdd7GCoRFp5MSsed6SrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lx9f+DSF; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lx9f+DSF"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9Og5jXYfO/MTFbbigamKhkKrathytUs/AVf/7SK0Kfw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788695097; v=1; x=1789299897;
 b=Lx9f+DSFvqHw+lgdYbOXKwcLzUJD+skPqH0eBLv5aE7HcGIdIcwaACzostApEL/Ih+tc+p4h
 i1W/DBKFGhRkD6r0xYm6jMtzv/tjGYEEzdIim7GfU/JmNYs2jEQdoHEn2MZ0aKaX7kAOT7vTCwb
 bWaW++IFgL0GfNwv7pcdAIZc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 676414f334276134;
	Sun, 06 Sep 2026 11:44:57 +0000
X-Mizu-Trace-ID: 676414f334276134
X-Migadu-Flow: FLOW_OUT
Message-ID: <0503f189-d91c-4334-bcd6-0dea795db0e7@linux.dev>
Date: Sun, 6 Sep 2026 12:44:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] netlink: specs: dpll: pin-get has no dump
 filter
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, arkadiusz.kubalewski@intel.com,
 ivecera@redhat.com, jiri@resnulli.us, donald.hunter@gmail.com
References: <20260904191023.3869690-1-kuba@kernel.org>
 <20260904191023.3869690-4-kuba@kernel.org>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260904191023.3869690-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 20:10, Jakub Kicinski wrote:
> The op doc promises "dump request with target dpll - list all the pins
> registered with a given dpll device" and "do request with target dpll
> and target pin". Neither exists. pin-get uses attribute-set: pin, so
> the id in both requests is DPLL_A_PIN_ID, not a device id; there is no
> reachable "target dpll" attribute at all (DPLL_A_PIN_PARENT_ID is in
> neither list). dpll_nl_pin_get_dumpit() does not look at the request,
> it walks dpll_pin_xa from ctx->idx and emits every registered,
> available pin, and there is no dump start callback to consume an id
> either.
> 
> So the generated dpll_pin_get_dump() sends an id, gets the full list
> back and reports no error. Drop the id from the dump request and the
> two targeting claims from the doc.
> 
> Present since commit 3badff3a25d8 ("dpll: spec: Add Netlink spec in
> YAML").
> Same caveat as for pin-set: sending DPLL_A_PIN_ID in a pin-get dump now
> fails validation instead of being ignored.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
