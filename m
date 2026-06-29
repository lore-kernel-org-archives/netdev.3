Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C73FA5E1
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725813; cv=none; b=qn5jhhJohd8uQS0JUu27cBYn9anRkqXjz59WiNGzyt6xiTxnWL5+HqrLOXK7ZMh8HBDDZdf5i0lLFT2NA4XEWMxWEJ4CcwMOAPpD61xjioDeg8+YCh67eB+4FmwFT5e8FMFQelYvDUeFIUWAdgJy5o1CIuaB9RB0TofqQh24GLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725813; c=relaxed/simple;
	bh=EXLHRzoiR1IFkDqSBsN4tYaadcYf+sRL4YQiTh51vSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yg4tQLodXbuJP5kFNZMys7xJoAGisFfSrmc1dJRWcIyeAokdgGL2gHTwUNAXmCiVYLeB3p7cqqjZL20YjgSamGWq8/QaMBZhkB1UAYl3jrlwidY6ryXvBPkIG3AsxS6GfKVOznaxTODjAWGED03yyIz8zdu97gESgtnSUZ+OMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjHwZcQG; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjHwZcQG"
Message-ID: <473a9335-495c-4cef-a63a-598deb29b140@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782725799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IACjqBQhCF+N04IXEwCSuxG0xE27jtYRD9ORQAzwMlc=;
	b=mjHwZcQGJ2RR9NijjxYtZ6pJvje5Kg5tDY/gUYJmdeIIo2VlhaSobc93hOrBLx8ZMZ9LVr
	Q0EM1gsSlMPpeRmsXNGB8kn/Vgm0fPooC163UPlSHRviCz3GSHfJfOWgX/SqHXHMXf/0m6
	LXVO2uKXxI+xiNX57dJb6lPXP5Pyzbc=
Date: Mon, 29 Jun 2026 10:36:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ivan Vecera <ivecera@redhat.com>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 "Schmidt, Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 "Vaananen, Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Simon Horman <horms@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <aifTFMZtWBgLzhCS@FV6GYCPJ69>
 <CH0PR11MB5394DA86D0D2CA45FD3DBEA79B1D2@CH0PR11MB5394.namprd11.prod.outlook.com>
 <99cebea4-156a-4379-922e-07c50f766fbe@redhat.com>
 <BN9PR11MB5401F6BA29CBA6F0C78FDB119B1A2@BN9PR11MB5401.namprd11.prod.outlook.com>
 <fcaa184b-f9e9-44c4-bae8-c4a9c6c41239@redhat.com>
 <aiqkZhNdt-WhglDg@FV6GYCPJ69>
 <ca33b9b8-aafa-40f0-9943-a6b6736af4e4@redhat.com>
 <CH3PR11MB8749910F17977B951A8B12CA9BE42@CH3PR11MB8749.namprd11.prod.outlook.com>
 <23e47140-f69f-451d-9154-29071130c11c@redhat.com>
 <0f8fe4e0-72d8-48a6-96ad-d1650919d2df@linux.dev>
 <ajzqUTuHDtMRvd1P@FV6GYCPJ69>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ajzqUTuHDtMRvd1P@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/06/2026 09:45, Jiri Pirko wrote:
> Wed, Jun 24, 2026 at 05:57:35PM +0200, vadim.fedorenko@linux.dev wrote:
>> On 19/06/2026 18:07, Ivan Vecera wrote:
> 
> [...]
> 
>>>
>>> Proposal:
>>> 1) new pin capability
>>>      - name: state-connected-override
>>>      - doc: pin state can be changed to connected in any DPLL mode
>>>
>>> 2) new NCO pin type to switch the DPLL to NCO mode when connected
>>>
>>> 3) automatic-only DPLL
>>>      - should expose NCO pin with state-connected-override capability
>>>
>>> 4) manual-only DPLL
>>>     - does not need to expose NCO pin with state-connected-override cap
>>>
>>> 5) dual-mode DPLL (supporting mode switching)
>>>     - if it exposes NCO pin with the override cap then it has to support
>>>       switching to NCO mode directly from AUTO mode
>>>     - if does not expose NCO pin with the override cap then a user MUST
>>>       switch the DPLL mode from AUTO to MANUAL to be able to make NCO
>>>       pin connected to the DPLL
>>
>> I still don't see good reasoning for the pin. Even this sentence says
>> "DPLL mode" which keeps me thinking whether we have to move it to a
>> special DPLL mode. All these items look like overcomplication of a
>> simple function of the device itself. DPLL can be either in the closed
>> loop when one of the pins provides a signal to align to, or in the open
>> loop meaning that software can control adjustments to phase/frequency.
>> But it's definitely a property of the device, and it's not a pin in any
>> kind...
> 
> Vadim, did you see this:
> https://lore.kernel.org/all/aiftnkuT9IP31qUm@FV6GYCPJ69/ ?
> I very thoroughly described what you are questioning. There is 0 reply
> to that email so perhaps you missed it? IDK.

Hi Jiri,

Yeah, I was traveling a lot lately, and looks like I missed it. I'll
reply in that thread.

Thanks!
