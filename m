Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729915CD74;
	Tue, 17 Mar 2026 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773723878; cv=none; b=gCYLzj3wEkFMoZQ6B5hVnORVldsGAk8L4eP3r84Peham5G09mW+7XsvlSAyZI9kmujWzRuHC4oXvdm2KpTFuthbc6kmN8sty2BiP/zC8zH9gbOAtOs0ueIjH5yogGM1wCeC8CbkHyRRddEytfQ3/sd0Mn3oiJYrz2TzOecvyOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773723878; c=relaxed/simple;
	bh=mNAYW9Fe7YUzgxnshTuESfZkC3fwpOoO/+69Tb1++gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bG2SrVGVwiHLc6aDOaNHbOpmmP3NpPnvwZNyvpD+WsPl3bD4zZKYD0FcI4e9S6ljKAbnGD32gZOcEcz5QujpOl3zGPLpIx5CbuMxXJN/BPxtWBFTDYSwxUt8G1E6sRE5STHv/n6nS1pcoGYFeQXisCpGv8NLfM53xJhrhq04iS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WXMqun0V; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WXMqun0V; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WXMqun0V";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WXMqun0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773723875;
	bh=mNAYW9Fe7YUzgxnshTuESfZkC3fwpOoO/+69Tb1++gA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WXMqun0VGWUI/idVfEsYZiBxz9By2oalpFLSOcRTEYYblsnDBkanlT4gFon72qenS
	 UtJMNdKu/CXOnNQhAgEAI/c4+T70cFVK65nos/x+JBLfbgLWVKZkhfGa4pXyqEeCmY
	 +9nF2j7aaMNf2OjNnsiTmLEDmpErdAemCYEZB/ilL3ekzXMpPMZaV8ObInAuD5LAA2
	 ENTTD/XmZ2eWsu1sVvsGzRNm2MIu5KO9jR2Fb5kSg4DZ1TqX9BhcmbdxsFt8/nAhha
	 jGua58KwtoG81MuBwdoHmzEos6md794iFCs3cyhbXFT+ZyZ2pOYEFGJRkQpK51dZu8
	 6Kpc6S7A50GeA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D162D3FDB1; Tue, 17 Mar 2026 05:04:35 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773723875;
	bh=mNAYW9Fe7YUzgxnshTuESfZkC3fwpOoO/+69Tb1++gA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WXMqun0VGWUI/idVfEsYZiBxz9By2oalpFLSOcRTEYYblsnDBkanlT4gFon72qenS
	 UtJMNdKu/CXOnNQhAgEAI/c4+T70cFVK65nos/x+JBLfbgLWVKZkhfGa4pXyqEeCmY
	 +9nF2j7aaMNf2OjNnsiTmLEDmpErdAemCYEZB/ilL3ekzXMpPMZaV8ObInAuD5LAA2
	 ENTTD/XmZ2eWsu1sVvsGzRNm2MIu5KO9jR2Fb5kSg4DZ1TqX9BhcmbdxsFt8/nAhha
	 jGua58KwtoG81MuBwdoHmzEos6md794iFCs3cyhbXFT+ZyZ2pOYEFGJRkQpK51dZu8
	 6Kpc6S7A50GeA==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C04A33F5A6;
	Tue, 17 Mar 2026 05:04:34 +0000 (UTC)
Message-ID: <2094f5a3-e692-4d8b-9b66-0368e5142b98@birger-koblitz.de>
Date: Tue, 17 Mar 2026 06:04:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] r8152: Add support for RTL8157 RX/TX
 descriptor format
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
 <20260314-rtl8157_next-v1-1-9ba77b428afd@birger-koblitz.de>
 <20260316175123.45b8d6e1@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260316175123.45b8d6e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2026 1:51 am, Jakub Kicinski wrote:
> On Sat, 14 Mar 2026 10:31:37 +0100 Birger Koblitz wrote:
>> The RTL8157 uses a different packet descriptor format compared to the
>> previous generation of chips. Add support for this format by adding a
>> descriptor format structure into the r8152 structure and corresponding
>> desc_ops functions which abstract the vlan-tag, tx/rx len and
>> tx/rx checksum algorithms.
>>
>> Adapt the previous functions for the first chip generation to support
>> abstraction and add additional functions for the second generation.
>>
>> Replace all calls to the descriptor functions with abstracted functions.
> 
> drivers/net/usb/r8152.c:9646:12: warning: unused function 'r8157_desc_init' [-Wunused-function]
>   9646 | static int r8157_desc_init(struct r8152 *tp)
>        |            ^~~~~~~~~~~~~~~
This function sets up the V2 packet descriptor of the RTL8157 (the 
RTL8159 uses the same). It sets up the function pointers for working 
with the new descriptor format, such as the new checksum algorithms 
r8157_rx_vlan_tag / r8157_rx_csum and getter/setter functions for the 
packet length. r8157_desc_init is only used in the final part of the 
patch series when the RTL8157 is initialized. If this function is moved 
into that final part, all the functions it itself references will also 
become unused and need to be moved into the final part of the patch 
series. Having only the new descriptor structure without the functions 
that work on it would make it very difficult for humans to understand 
what the differences in the descriptors are, and also the abstraction of 
the functions working with the V1 structure would not make sense. It 
would also mean that all functions used only by the RTL8157 will become 
part of this last part of the patch-series, making it huge and difficult 
to understand. Basically, the patch series would be reduced to small 
initial patches where new registers are defined and a large last part, 
where all the new functionality is added in one big patch.

I would prefer to have individual patches in the series adding support 
for the new functionality of the RTL8157 in parts that also allow 
developers to understand the differences, even if this functionality is 
used only in the last part of the series.

Birger
