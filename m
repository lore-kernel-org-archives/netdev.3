Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A89287247;
	Wed, 25 Mar 2026 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422678; cv=none; b=sOTbNU43PwUHdigX59hFgZGk9DBIr4vrgbtkxDqkJLi33D5jvcbcag4pTLjND1pPWgudB3wNaFma80X2Nnno27NmhcnRd39Pw919ffMpLRL0efssQl/yiHbCwxhF2BmJyW/4474b5RywV5FUFcKhvQcza6uv755LYstKLTK0wDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422678; c=relaxed/simple;
	bh=sQ7nWEiakocS+buPtMUVAsLAmLNsEzZHf9uuHLljolI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEoEl7oMzF+7Uyh9pmcg8pNH8UEkXmt6xJgDu0uRn04pvsJox1VqZcej1EAH5o1s0ccDn2Mooy3F4bkGEVGfHUaewY8v9UccWgY0ahobGKQYmJjZHJOURy1zin78fX0BxPrQLOXPrnCCmP2+TMzM6Pq/pub1ID9NfJ2YkMEh5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=lR+VBjYv; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=jjcJKck8; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="lR+VBjYv";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="jjcJKck8"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62P7AfJP026754;
	Wed, 25 Mar 2026 08:10:46 +0100
Received: from [10.102.162.121] (31-131-247-74.ip252.fastwebnet.it [31.131.247.74])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id D30AF122966;
	Wed, 25 Mar 2026 08:10:37 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774422638; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtHr0mlAZWlS4uzhBz4o05EFXCNhnd52KDmF7pDcJOw=;
	b=lR+VBjYvyUsKDY4Sksj04Q7F3HRMgnyPGKrkE6Z/ePXxlf53WGBTBXu3+ONV6zKzW8RFMW
	mE8gvDP1bk9jLdBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774422638; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtHr0mlAZWlS4uzhBz4o05EFXCNhnd52KDmF7pDcJOw=;
	b=jjcJKck8rY/nC70GwNElfxHYd2wbPj5if6tYo9xjlcDsE2qRsM6iHwq/Huta/0lGa6G/h7
	/qm0hn74IJeD407GHP6R/QFTXa4UJXSVVOW0B/J0cdG/DBHJQxwpdI1BezEvT6wj1Fy294
	LR1BVS8fzLPRG0wW/4iwm4qB9EUbkOIBxRFrUAoCtjbuAjWk+dYPaJY338P49tVduQGKGG
	YoNKOCjQ7Iouy0QZluR8VwLiT7FiHaBASFEMlmC7k5t7PtMTLGopluk1u2JasjDFxfb7GS
	8b6xZ/wZvCpT5MGe7nJtbtt93jL2J7VzUaxK13wBs8m6Rsy60+NhX3E2PN2Zsg==
Message-ID: <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
Date: Wed, 25 Mar 2026 08:10:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2
 device
Content-Language: it-IT
To: Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <CAOY2Bqx-ZmBm-o-BoUYCxJjGQn31WF8V2u7gbnB52gOSYvG5Rg@mail.gmail.com>
From: Stefano Salsano <stefano.salsano@uniroma2.it>
In-Reply-To: <CAOY2Bqx-ZmBm-o-BoUYCxJjGQn31WF8V2u7gbnB52gOSYvG5Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Il 24/03/2026 17:00, Justin Iurman ha scritto:
> On Sun, Mar 22, 2026 at 12:06 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
>>
>> Hi all,
>>
>> this RFC series adds support for the SRv6 End.DT2U behavior and
>> introduces the srl2 Ethernet pseudowire device, together with
>> corresponding selftests.
> 
> Hi Andrea,
> 
> Thanks for the work you (and Stefano) put into this series! As
> discussed offline, there is interest in such a solution.

Hi Justin,

thx for your interest!

> A general comment: I'm not sure about the name "srl2", as we're
> talking about SRv6 specifically here. 

fair point

> I would personally love to have
> "l2srv6", although I suspect we may end up with "l2seg6" to remain
> consistent.

I'd like to keep it as short as possible, our initial idea was seg6l2, 
very close to your last suggestion, then we opted for srl2 losing the 
"6" concept

now it comes to my mind that l2 is somehow redudant in an interface type 
name, as an interface is an l2 concept per se, so my preferred option 
becomes:

sr6

(short and memorable...)

as an alternative seg6 can work but I strongly prefer sr6

ciao
Stefano


> 
> Cheers,
> Justin


-- 
*******************************************************************
Prof. Stefano Salsano
Dipartimento Ingegneria Elettronica
Universita' di Roma Tor Vergata
Viale Politecnico, 1 - 00133 Roma - ITALY

http://netgroup.uniroma2.it/Stefano_Salsano/

E-mail  : stefano.salsano@uniroma2.it
Office  : (Tel.) +39 06 72597770 (Fax.) +39 06 72597435
*******************************************************************

