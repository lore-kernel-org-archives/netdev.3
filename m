Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB933A9C1
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338438; cv=none; b=K1gTSOsoZBJXstSjoYyzdhSSM2uggGkTftkezVYuLq+Mi1uq7PoLnW9jnnL7rEZw6dry2ykyy96aLtvOAL296sCaJqm8cJeiKzbree/ALTKj0oXjyA5YN4P3dxzX5TmMuOBVOwM4PEeaxZIrRz6UupyQSOTu2zrYhuvmc+WWBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338438; c=relaxed/simple;
	bh=UXTIo9/padBfKT08CETd2El8sJe6ny6hQkAfQAnVr28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMqlV/LwxSL+R+QnWKZ30K6osgB4RNivpuLiSkgp2dHN0ufJoxII7/hjXmT+eKCfvR8nI/W0D3c+RF8x8oeH9OuEbIRABFmgHtOCFoJxe0792v+1mTKzip27er7dub3MZc4wJx06bIUR8c1TkS28RYiGJbcXXrXaaSiK5auUtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gQJt0jjt; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gQJt0jjt"
Message-ID: <b9d0506b-76f4-4d6b-9044-49e474baa144@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783338434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uVOp50wQNseU2ateMqyJO/VWBf4s7zsEypfE7I4Lxw=;
	b=gQJt0jjt4P5bc3AeX/Nc7aT/27Bu5QV0jzteZ9xZQV02Po2jNZtWFPV76Vg3qYthIi6HVV
	BAYhcggNP8JT79EUAmi4m1Jclqa0HavW2fds1vCS+54vONOfTl+1cbR7EtL/odNiTgSW9b
	haxcbBaNNRt78x8tIprLFRf1a0+G5rs=
Date: Mon, 6 Jul 2026 12:47:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 2/5] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>,
 netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Michal Schmidt <mschmidt@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260630125536.720717-1-ivecera@redhat.com>
 <20260630125536.720717-3-ivecera@redhat.com>
 <455c46ac-25cb-45d4-9cb3-5330f7b553c0@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <455c46ac-25cb-45d4-9cb3-5330f7b553c0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/07/2026 10:31, Paolo Abeni wrote:
> On 6/30/26 2:55 PM, Ivan Vecera wrote:
>> Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
>> the NCO mode of a DPLL. When connected as a DPLL input, the DPLL
>> enters NCO mode where the output frequency is adjusted by the host
>> via the PTP clock interface.
>>
>> Update the fractional-frequency-offset and fractional-frequency-
>> offset-ppt attribute documentation to note that for INT_NCO pins
>> these attributes represent the DPLL's current output frequency
>> offset from its nominal frequency.
>>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> @Vadim: it's not clear to me if your doubts over the design choice
> raised in previous iterations are still there. My understanding is there
> is reasonable agreement vs the new pin type, if you have very strong
> objections please raise them soonish.

@Paolo: I still have my doubts here, but the patchset has Rb tags from
Jiri, who is DPLL maintainer as well, so I think it's good to go...


