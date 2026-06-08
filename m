Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8A339863
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918472; cv=none; b=PQWCloKo/F7Zpm8epkhLjUd4Lo1kiS/5HjpvKiJsoFRhBJ20ASojRG2CKwn1jm3460o5iXDbZhGrcpo4BusDkmDWuewcVGP4qGcDYvFNU8oV33ln278xj6USPy7GVTmn+3yOMdKZnU/mVuU27/AVJeevhXl78FX8ZZiFPmL5F1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918472; c=relaxed/simple;
	bh=FCH0sIXEqc6FhNN3oY4Y+BglCAKyhyqMbIEuvXso0lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxcosdKTEZ60l73UgbocQmXc5rXIhF/SMFNWpVZlu+VeJTUctrH0SDgSuV1B/hC18WNnYnSDhjjGaTs1Wy+3xEcy7lYuIPPf06Y8s8SKRLbSVHhicmv5+45cKoTj/452cL1f8IJErLC+AEmiXld6J7XZAW0J671B83SvNeQsgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i0BnB9BY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i0BnB9BY"
Message-ID: <d6b69d21-4542-498d-8253-7009a56634cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780918468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLAlmfrt7tvd5vck5fHi8s4cGNcakYsO3vM/U+wc1Ig=;
	b=i0BnB9BYJ1rijbP8wYP24A805df+yheXwyzLpW1w7/EGRCrRu/aqTgfAKddF0Ojs5+qr+7
	aMyXOR7zetAwOPW4pQvcLefc06z20wu2kMA7qFamFc5DMma4Qqq7KYAcR5EQaO/WC+xGag
	YWeBTrVWG+Q503blg7CfKlniNML7Z6Y=
Date: Mon, 8 Jun 2026 12:33:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
 <20260603185037.05f8c6a0@kernel.org>
 <be19bd30-0bb0-4a22-8932-e62f7678ccc5@redhat.com>
 <20260604081649.1ae5302d@kernel.org>
 <3c5e01f5-8563-41a3-964f-13fcb80383b7@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <3c5e01f5-8563-41a3-964f-13fcb80383b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/06/2026 17:42, Ivan Vecera wrote:
> On 6/4/26 5:16 PM, Jakub Kicinski wrote:
>> On Thu, 4 Jun 2026 17:01:36 +0200 Ivan Vecera wrote:
>>>> Purely going on intuition here but feels like NCO should be a mode
>>>> (enum dpll_mode) rather than one of the input pins?
>>>>
>>>> More acks here would be great, Vadim, Arkadiusz, Grzegorz... ?
>>>
>>> I had a long discussion with Jiri about this and we agreed finally
>>> that dpll_mode represents a reference (input pin) selection strategy
>>> mode and not a DPLL device running mode.
>>
>> Long discussion? I see 2 emails ;) Let's hear from others.
>> (thanks for the link BTW, _if_ there's a v6 please put it in the cover
>> letter)
> 
> I called him... he explained me 'why?' in detail.
> I also appreciate others' opinion.

Well, NCO mode means manual operation of frequency tuning. Does it mean
that different tunings may be applied to different out pins of DPLL
device? My assumption that it's not possible, and in this case NCO is
property/mode of DPLL device rather than single pin.

@Jiri could you please share your detailed explanation on "why"?
