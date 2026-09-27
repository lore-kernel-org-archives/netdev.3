Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F53C1D61;
	Sun, 27 Sep 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497281; cv=none; b=LLNd0IHjr/BW6OX15KFsHzs8hgWrXTP5pqMIQ7sMkLZpjKhU0sN21gJy60xRHi35cWDCfoH9GvGtZnieT6CNdaovqFT/XxE9CxloG/yaEduOcudgBJgnOGvX1gBFRZ+Ztvv7psDuAmKEAWlTFNsqxxdqkSERe1UtuVUoVIP6hgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497281; c=relaxed/simple;
	bh=AIH3t5odWzXpYxLCsh3QJaVSHP6c8pjKBIOjj8LD4a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOpZTq72d6bFlbNNtaUjTX5W2IUyjRVKfgTQ+nfSbWFVtcH6Hrcm5a4QqI8E2EAhLUiL157eJ6mLK25HMg22gtPzFW5Y62hQoYIbmyYiKzKnvmDHs3PE6DcSLgoKXViTMy4XSvljk+/WrX51JrduvgHQU+lV2DdfZQQv3hgzJEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2N8Bp1OW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=h7fOisxU; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2N8Bp1OW";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="h7fOisxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790497277;
	bh=AIH3t5odWzXpYxLCsh3QJaVSHP6c8pjKBIOjj8LD4a8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2N8Bp1OWkyq+Havj5OFVf8cGsW28gEu5o0186brEdJ953C0LmY7NyGujG4rTkjzN6
	 vBzhdbGefjQH8GkwPf+osNMMhSdjEbzKnW5x3cLrv5x7HPvFUFO4Y0FT8Ameh0CvNS
	 0arfiekiN3D4wxSBNpauwws5DlZaXpGCZVtVSPXMQUwwi4Ff6y/Z1PFL+WK8LA8XQL
	 b6a1oTn+j4oxfv3nTev3+9UIfySC0aTaD48W+X4e5M0gbN2Jzc+HGfyct/GoTduj2w
	 R4WFP2FztIdP6xwz80k/izqdOLbxmOICxFoHMqfJFUNeKXTbPWqUC1loeGSF8J674K
	 XB18NOm6vO0kQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id BB160412D3; Sun, 27 Sep 2026 08:21:17 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790497275;
	bh=AIH3t5odWzXpYxLCsh3QJaVSHP6c8pjKBIOjj8LD4a8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h7fOisxUnY7APmemGX+FfOWka5UDYD8PUUCaJelK9LCk3jyDH01L1XBYBi7A320Dn
	 tqz0EK6ALQXw4CiGZC3nCn/awZ23YqMxT18JOPJ567E09KSfwgHOoaC+Xpx0iDdnra
	 ukunxkl6KujkQIua0qHQFfHaMcY3mOH16GYGSnWmJskfRcvJLP8px3+WPrITlAOqe9
	 m4BZhqsT7A4oXlkKB5gHj/Cj7giPMeZ8VX9AadNB+dr3E1Wi5LnkBYkDtHkrWTVbx6
	 NSjsIldH+xc05gLsf43Lmrmo8uppEu0k+kOkCLqARYO4L38hageyI0/pgCXV7yjhqD
	 od2Hs7GcXB5EA==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 24D23412D3;
	Sun, 27 Sep 2026 08:21:15 +0000 (UTC)
Message-ID: <ce5a6051-4bde-46a9-b0a1-30d98e66aef8@birger-koblitz.de>
Date: Sun, 27 Sep 2026 10:20:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
 <20260916-ax88179a-v12-6-60c04c9924a2@birger-koblitz.de>
 <20260919151247.1a340644@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260919151247.1a340644@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2026 12:12 am, Jakub Kicinski wrote:
> On Wed, 16 Sep 2026 05:24:05 +0200 Birger Koblitz wrote:
> 
>> +	/* Stop RX/TX for link configuration */
>> +	tmp16 = AX_RX_CTL_STOP;
>> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_RX_CTL, 2, 2, &tmp16);
> 
> don't you want to add a wrapper for the commands?
> To write a cmd from a literal/immediate value?
> Something like:
> 
> 	ax88179_cmd_imm(dev, AX_ACCESS_MAC, AX_RX_CTL, AX_RX_CTL_STOP,
> 	2);
> 
> It'd save you all the temp buffers, which TBH I'm not sure are fully
> correct since you cast u8 buf to a pointer which may need alignment.
> 
Will do, great suggestion!
I added ax88179_write_u16() and ax88179_write_u8() which indeed 
eliminate many of the temporary variables.


>> +	tmp8 = 0;
>> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_PATH, 1, 1, &tmp8);
>> +
>> +	tmp8 = 0xa5;
>> +	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX88179A_MAC_CDC_DELAY_TX, 1, 1, &tmp8);
> 
> Please wrap at 80 chars if it doesn't impact readability.
Doing so as part of the introduction of the new write functions.


> 
>> +	/* Check these packets */
>> +	hdr_off = (rx_hdr & AX179A_RX_DH_DESC_OFFSET_MASK) >> AX179A_RX_DH_DESC_OFFSET_SHIFT;
>> +	pkt_cnt = rx_hdr & AX179A_RX_DH_PKT_CNT_MASK;
> 
> Please define shifted masks and use FIELD_GET() FIELD_PREP()
> Sometimes your masks are shifted sometimes not, makes the code harder
> to follow. Not to mention that this is much shorter:
> 
> 	hdr_off = FILED_GET(AX179A_RX_DH_DESC_OFFSET, rx_hdr);
> 
> 
>> +	/* TSO MSS */
>> +	tx_desc |= ((u64)(skb_shinfo(skb)->gso_size & AX179A_TX_DESC_MSS_MASK)) <<
>> +		   AX179A_TX_DESC_MSS_SHIFT;
> 
> (eg. this mask is not shifted)
Done in next revision.

