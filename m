Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C128150F;
	Mon, 27 Jul 2026 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160887; cv=none; b=UWL2TvWbA5OqrJnUecLAXlEMKOMBtnMbKqdEK/ttMXQ50WFhp0DxcPySgA1/bI9XloY5SSjI59pqstqBnPjLv5+wCII5ouERM0nircxdRBW3hHbihCDIJJvv2DDstZ4OHC0KoeLF3A9z6kyBhawO5ECIIqrqKVz0unub3SFW+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160887; c=relaxed/simple;
	bh=0zbRlLGcqwvwnTK8IDDAFbNaJuqvFeAFzOlA5jnFXJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGTeQi/QrOQ8RjP05GVBd1OlDH5jV0jgdVSgrvEEucolSAQmgoXJfb1YQ21fnjRf3BEtuXe5wcyQpqeCvc7BYv+400niv6si5wgPaOh7atYg79MeMKIw8HmmQoqUHgl61V3ltkooJjTir2pAq4SJY1aSxKWwjNrc67uKuBFWh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=bRJGDG+H; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="bRJGDG+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785160673;
	bh=1RRKFbtqutSQALBCUn6Uvt/BonbVMk2Qvmgh0vg2vHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bRJGDG+HPUmXSL5XDGregzXES8P/aqDgayX2oQzmZ4xxSiu6y4F/e8/ux9oxURlIw
	 Wim9LNsc4TP7QZhEHM17VJ4kyLWSg5cFh4wtXIkUUexP8IcD4p3ILwltGFSWmBhtFD
	 XhyaugSARa/r2RYSz+Wau6HjDT5F3y2jQ+jUAz44=
Received: from [129.217.186.176] ([129.217.186.176])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66RDvqhU013958
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:57:52 +0200 (CEST)
Message-ID: <a8dadd41-e2c5-4a6b-bb93-77c3d5eb6342@tu-dortmund.de>
Date: Mon, 27 Jul 2026 15:57:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer
 <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20260709095511.168235-1-simon.schippers@tu-dortmund.de>
 <20260714092506-mutt-send-email-mst@kernel.org>
 <5016ae84-7049-4a5f-91c9-ba0047b06ee3@tu-dortmund.de>
 <5089fc5e-2fb8-41fb-9aab-42b22cc2c201@tu-dortmund.de>
 <20260721105853-mutt-send-email-mst@kernel.org>
 <20260721100715.5b43412d@kernel.org>
 <20260722020611-mutt-send-email-mst@kernel.org>
 <8814700c-7549-4d12-b657-c990dfeec14f@tu-dortmund.de>
 <20260722040722-mutt-send-email-mst@kernel.org>
 <20260722072631.21b57e1e@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260722072631.21b57e1e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 16:26, Jakub Kicinski wrote:
> On Wed, 22 Jul 2026 04:09:25 -0400 Michael S. Tsirkin wrote:
>>> Would be great if you could do the revert.
>>> I don't want to mess it up. :P
>>>
>>> For the re-apply:
>>> I can post a v13 to net-next soon with the flag included
>>> into the existing commits.
>>> Or would you rather take v12 plus this opt-in commit as-is?
>>>
>>> Thanks!  
>>
>> jacub if the revert goes into next what is the process to
>> target a patch on top of it for net-next? Thanks!
> 
> misheal, revert will be merged to net and reach net-next on Thu after
> the downstream PR, at which point you can post the net-next patch.

Hi Michael, do you have this on your radar?

Thanks!

