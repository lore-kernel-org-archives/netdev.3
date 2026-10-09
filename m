Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDB842E417;
	Fri,  9 Oct 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547912; cv=none; b=GBPT7KCAzjmF21NnHdnKoXRVqB2r66/cKIBHSH7vIGs+6QlqlBMGDrpvgtfJXL7h+XBOPc9Wys9G0J+N12iBQ8LUn2tKrXU5dcg+s8aWlEPkk6MDHCrT0gsOenE/XEOgTVoJRPccqdLOk9FqZOVsXsQAVaahjRRocIwy9xR5of4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547912; c=relaxed/simple;
	bh=8LlDW9zIxy1Se23pHYccZWHIoAtaF2N8R5qKXMgaoIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgjGwL/gcFwuJaTc34OhJJBVXMF6S/0CEExsxqJ/MXDhkylDrklA2Rh7IqNpL1m17CnGmLM2A3KmuFBbjDbj0zxzDCHGTsRQKXNLaxUFnF0pjXRyVkk3sdZqAAAbR3TrQuwbUtGrJLIHzkK+8XlODsybyuHorAXhBaZ0fH+Xz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org; spf=pass smtp.mailfrom=phrozen.org; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phrozen.org
Received: from [2a04:4540:1400:4fc:d11e:5f96:365a:8ae3]
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <john@phrozen.org>)
	id 1xF9Re-001Khl-2B;
	Fri, 09 Oct 2026 14:11:26 +0200
Message-ID: <a341d713-25e0-41b4-8588-7771fee7ba8f@phrozen.org>
Date: Fri, 9 Oct 2026 14:11:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 00/12] net: add the PON subsystem
To: Andre Ziviani <andrepziviani@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Christian Marangi <ansuelsmth@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 Gaoyang Wei <yhyxwgy@gmail.com>, Ziyou Xu <xuziyougm@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20261008143249.3439762-1-john@phrozen.org>
 <20261009110428.55471-1-andrepziviani@gmail.com>
Content-Language: en-GB
From: John Crispin <john@phrozen.org>
In-Reply-To: <20261009110428.55471-1-andrepziviani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09.10.26 13:04, Andre Ziviani wrote:
> Hi John,
> 
> On Thu, Oct 08, 2026 at 04:32:37PM +0200, John Crispin wrote:
>> The scope is XGS-PON. The mode enum keeps gpon and xg-pon so that the
>> uapi order stays clean for later drivers.
> 
> A G-PON data point, since the framework thread mentioned Realtek only
> as work with proprietary components. odi-oss [1] is open firmware for a
> GPON SFP ONU stick on the Realtek RTL9602C. It runs mainline 6.18 with
> GPL drivers of our own for the GPON MAC, the PLOAM state machine of
> G.984.3, the CPU NIC and the switch, and with a userspace OMCI daemon.
> Apart from the stock bootloader, the image has no vendor code or
> binaries. It runs in production on two ISPs, and a user has it working
> on a third.
> 
[...]
> traces from both ISPs.
> 
> [1] https://github.com/AndreZiviani/odi-oss
> 
> Thanks,
> Andre Ziviani
> 


and those dongle can be bought on fs.com for ~12euro

I'll grab a couple. Thanks for the info !

