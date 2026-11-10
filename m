Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322126;
	b=vrnTAoX4E5zuT31VfpefNMwwDUACH3ggVdqeBXFFOeo8R7GPZXD8OoS5mdPceYpysoRY
	 oab5qqQyiILUdJ8OIg6O9Fz97x/x3UPFloWpJSbMIO9Rwa1b3p2qYFTf5tAfXQkgLPbtz
	 GaLW22gVJ8sDulboC0y2YFSIxXZ3aA4eWqSnQ/idQ+wwgkFI2y2SOCHzzZyMInrhbZuna
	 pVhg0fFO+OOOq9xCmOaZ94Tb5DCq/Y316//8H6GPak06K52uEZyKfbCrMBGNvEoDLHK7m
	 ZIj/1xzr4XYLEPnsRqLh497XOU5mAyq+QnjVa+WZDVXCZcM/nKK3lTu70TzL6or+y+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322126;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=YHOWSzBYEeT0XkyHE5eg98zTT/FM3f1qF9Pogxz7NlM=;
	b=bMnEbOe5J0Y34GejZCUGv9QQI+wgYDfxPELLPM2C5Xl9tDLFInQo5/ZeWjXEHvQ3682g
	 SyQl0GKGmNUQGN2H1wvbKA2TAfNmd4ywjZZrqEZ/m3jTqWtI4U41atnW2YAdgQkjm8iaZ
	 0Z6LEfW0GeZMJJmwNmq6i1cDe0DyIvEdDGYEX3HbCPGEJFmmXIq2J9Kla7FlFRDSpYWYy
	 c60qm745tjCnrSIwkl3iZHTbRu5k3h0S+U7wYIOsEb1zTOWZe2AeBs7avkwm4sg5fewFQ
	 UQpDiogENWyijDLzmdgZDWQAPdkI9CoxI2UMwLRycq1s/F41VQ0FrtOAioxvXfzLg8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+sBCsiR;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29D60A382F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE29D60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+sBCsiR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794322125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHOWSzBYEeT0XkyHE5eg98zTT/FM3f1qF9Pogxz7NlM=;
	b=C+sBCsiRGQ8YFndxB9NLkTKhDwHYz1iurkPktBnlU14h5X3BV+uTtWiwBU35X6EEx4C+91
	KPk3M7b1/kpNYqxmV9V0cLGMwVoh2I6jWBqtKeMq4PluMmfr9tfrdanAJ/IuFIIe62auEI
	1N/1yffTTd6MNtuIlxSJX8Z1h7ooUtk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-vC-TTDbwOza7AusNkcychA-1; Tue,
 10 Nov 2026 09:48:40 -0500
X-MC-Unique: vC-TTDbwOza7AusNkcychA-1
X-Mimecast-MFC-AGG-ID: vC-TTDbwOza7AusNkcychA_1794322119
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 668D41956043;
	Tue, 10 Nov 2026 14:48:38 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57D0F30000E7;
	Tue, 10 Nov 2026 14:48:34 +0000 (UTC)
Message-ID: <e16342c4-bfb8-489c-9785-f78a3dfdfc17@redhat.com>
Date: Tue, 10 Nov 2026 15:48:32 +0100
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
Subject: Re: [PATCH iwl-net] ice: dpll: refuse pin states that are not valid
 for the pin
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Milena Olech <milena.olech@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20261110143119.2313907-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261110143119.2313907-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/10/26 15:31, Petr Oros wrote:
> The DPLL core checks only that a pin may change its state, which states
> a pin accepts is left to the driver. The ice callbacks turn the
> requested state into an enable flag by comparing it with the one state
> that enables the pin, so every other state disables it, including the
> one that has no meaning for the pin.
> 
> The inputs of the EEC and PPS DPLLs are enabled by selectable, as these
> DPLLs select their reference automatically. A request for connected,
> which Documentation/driver-api/dpll.rst reserves for manual mode and
> for pins with the state-connected-override capability, disables the
> input. On an E810:
> 
>    # dpll pin set id 1 parent-device 0 state connected
>    # dpll pin show id 1
>    ... state disconnected on both DPLLs
> 
> A recovered clock pin is connected to or disconnected from its parent
> pin, and a request for selectable disconnects it:
> 
>    # dpll pin set id 2109 parent-pin 2094 state selectable
>    # dpll pin show id 2109
>    ... state disconnected on parent 2094
> 
> Add a helper that translates the state for a pin given the state that
> enables it. Disconnected disables the pin and anything else is refused
> with -EINVAL and an extack message. Use it for the input and recovered
> clock pins, and for the output pins, which already refused selectable
> and now tell the user why.
> 
> The SMA pins have the same problem. It is left out here, as the rework
> of the SMA and U.FL pin control that is queued for net-next refuses the
> states these pins cannot serve.
> 
> Found with the pin state selftest of the dpllsim series running against
> an ice E810.

;-) good catch!
> 
> Fixes: d7999f5ea64bb1 ("ice: implement dpll interface to control cgu")
> Signed-off-by: Petr Oros<poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

