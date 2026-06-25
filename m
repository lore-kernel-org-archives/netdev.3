Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3841383984
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377155; cv=none; b=FDNDK5F58KyjHfoIbj5l7PgVeuwwb7PDqIA11GzX+TiTRVoUc5JmFTy3jVxlv5bYn5YNIrKi3Wn6n0j12F7dI+5xy8fnkiymc5rzDddvlQ2VcUq+0orLNOMCH5vuYC0NxMrVxvh4yHWjf0UczoI6xmBBixJ0CZgIgPUY+8z4dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377155; c=relaxed/simple;
	bh=qR4A+m766w/c6ewO98NEv5b2pIqO2z9SA5O/ySjWWVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfNaPkCN+PnMYr1Ne78DniGqeUn10uzcr2YySdOiZBFPtaEZRgz6Vun4qHOzl6seNIfBn10P5n+Qbe+ofAuEkoPw/GEl3efwIvL+Btnr/T9KwC0Sa+REt9z2aR+1DH5LJyvetubu2kMwj+Yjn8CXaxQTUyXs33FNNNjv7GKxof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=w+UnEQ9N; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="w+UnEQ9N"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cdae130cso11081755e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782377149; x=1782981949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jjzeGJ6UjAoFVnlOFZBR/ApcCgu66rueAWjixl+vBgI=;
        b=w+UnEQ9NlC0qEf7tb6N72Gt8WO6G5RAGY8JeanAoL4pUDfQhC91KXhVdwciXQWNN60
         Gc843fVAawoW735rfWba+1AGAhwlFuVOXJVqWB5Ua28XMud6s/ZIy4+odHked2DSjc6l
         PFeMyI4X9asgJ8IEsPxyPvrDeS7rvOAcU4GiTp/kzpuMNag54VOIahBb8RVYG6UHSz07
         15jeiBVuX5qf7C1uPWs71mLr6H/MMZo99cdqlm1ZJnMRhLKIE160INMWBP1WCi0+5ZlB
         fFWdw3D8GaWTqVTL7qOuHCIzAp0osmr+ltF5WuDEIOmfq3MBH5AdrPspY5oHTcbBEmFD
         +0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782377149; x=1782981949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjzeGJ6UjAoFVnlOFZBR/ApcCgu66rueAWjixl+vBgI=;
        b=eyE9TSEKJCuppgCqAo5/GLYy/jzpq3qdHAAYW17tewmiq7SHv6DG7ZmxDaMDdF6fnO
         Z+1Vlo2ghopV+vJWrxsloulHxjdeC8f6/7PdHhEQZ9SUQ8fXAULrFTrIyPqIcawSCbyw
         K1f/tstlRxe8M0q0fTuit3CNiwH+Y7VroGW7WMm+I5s1CZ3vLp1Ow9ZTEqThlxyu0kVQ
         p7YtQRZFVs7R/sUNixCM4e/+p2F7FFe1A5YPnu0N5fZCzCqNCEuBSFyK8a7DgymSZc5T
         bAFLK5JfXvFZdABWkBpnsTQo6/Ejtw+pD4lpmfnQW/CScn7qc2j1ga5FWaG7SHXzOXfE
         9eqg==
X-Forwarded-Encrypted: i=1; AFNElJ/E82kK+yyoi5K3KlYmLBUUaPCFJAXoyXxCOLCcteGPl6uDTb7IVCDXx0CB8yDaZYZmuy8Ddfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TVUbNH//LIaPN56qrYQCgpOkAS1XlUlHcU0wjso+FWBIbara
	1+pihhZno8u4PYOTUwi0tF9GHCr5b4NCMMI7Rukx+gvvyC9U5rNEGmyKEv4i6BkVYWM=
X-Gm-Gg: AfdE7cln5F+8MWVYekyyX1eX36KcKfqfsDbAiLpDrDCtppSC2ecBDXeT/PeLpGrdNjq
	7NNObM/jPob7gfplE+E7UBvZ2Zt6B4SNbwNk7zOFJZ9g5JfnCdy9fLemrKG2MfD0wExhZW9lUK7
	pMTe9sKbO9rE5bMItRIOVRB6zPxEgz06mYa3ImvGKZD+PHhf3+H2/Brzj47te6YXJsTd8JjGInl
	HCc7TfP9EykNkOGuw+flgFbM8ABbFuRJdFF/cat1nW1YXu+UhU5C1TkpMEcHgKQHm8CGmg7YnAU
	mw3cWG7+SYaCStHrpk19JcQL8PY8gls/PQM3lCK/DOH+/JgqP9k0jTYfRWm2iFpsH/INS2dqDER
	qM24BRxULuE96nspAiwW5bFuZ1zWGXF3tSugif5R2UPjhkJfvetK4VNTd3T3YihRTKrUPv/V3m5
	DwWpniEzJJKZ9DyIXQ+FEX29mDAs36C/I=
X-Received: by 2002:a05:600c:a0d:b0:492:6487:a87 with SMTP id 5b1f17b1804b1-49266893009mr20193815e9.32.1782377148642;
        Thu, 25 Jun 2026 01:45:48 -0700 (PDT)
Received: from localhost ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926544dfaesm32135595e9.2.2026.06.25.01.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:45:48 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:45:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Ivan Vecera <ivecera@redhat.com>, 
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "Schmidt, Michal" <mschmidt@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, "Vaananen, Pasi" <pvaanane@redhat.com>, 
	"Oros, Petr" <poros@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Simon Horman <horms@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Message-ID: <ajzqUTuHDtMRvd1P@FV6GYCPJ69>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f8fe4e0-72d8-48a6-96ad-d1650919d2df@linux.dev>

Wed, Jun 24, 2026 at 05:57:35PM +0200, vadim.fedorenko@linux.dev wrote:
>On 19/06/2026 18:07, Ivan Vecera wrote:

[...]

>> 
>> Proposal:
>> 1) new pin capability
>>     - name: state-connected-override
>>     - doc: pin state can be changed to connected in any DPLL mode
>> 
>> 2) new NCO pin type to switch the DPLL to NCO mode when connected
>> 
>> 3) automatic-only DPLL
>>     - should expose NCO pin with state-connected-override capability
>> 
>> 4) manual-only DPLL
>>    - does not need to expose NCO pin with state-connected-override cap
>> 
>> 5) dual-mode DPLL (supporting mode switching)
>>    - if it exposes NCO pin with the override cap then it has to support
>>      switching to NCO mode directly from AUTO mode
>>    - if does not expose NCO pin with the override cap then a user MUST
>>      switch the DPLL mode from AUTO to MANUAL to be able to make NCO
>>      pin connected to the DPLL
>
>I still don't see good reasoning for the pin. Even this sentence says
>"DPLL mode" which keeps me thinking whether we have to move it to a
>special DPLL mode. All these items look like overcomplication of a
>simple function of the device itself. DPLL can be either in the closed
>loop when one of the pins provides a signal to align to, or in the open
>loop meaning that software can control adjustments to phase/frequency.
>But it's definitely a property of the device, and it's not a pin in any
>kind...

Vadim, did you see this:
https://lore.kernel.org/all/aiftnkuT9IP31qUm@FV6GYCPJ69/ ?
I very thoroughly described what you are questioning. There is 0 reply
to that email so perhaps you missed it? IDK.


