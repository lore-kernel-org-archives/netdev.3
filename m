Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329894;
	b=a0xS6hfVOZ8zNOzy6/H/ihoYdz0geJcu5jyh/HDXq5TAR0ifdwGewjmLCfH++f+OhAoW
	 BHXj8+kUS5vG0PZaL5oeiI35/ooS3CY7Oo82OcL89WMvdyU1UafI6UHkNuG7hFeNkZaEF
	 NPTcbfJOAtN26agV80jm0MqURSS8SifKJL3XSw+GaIGh2fS1rXNmzzSp3k8YdhNcy/HkE
	 Iah4YNwMb/HFC2T/egEln8rFMfChA0s87WsdC5RxI/dFnZEOjiW2+bK1KD0jcZuwMlJti
	 rZfX1nwSt6ogEPNl5oz8mIJcIw0XB9RJtxtmUSUmq/tVCEx8INzslLd8u+BAX9I+DnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329894;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s3ZpsLefq0PS3uaqYJOnZLAzmDkCm1zInxr8ygQtDk4=;
	b=Jahf6HYpQcaUaqNmGYOpUd8xoGyf93NHrzz9imXj6VkBrb2bRuMANinKVFZfwBVYZHQC
	 BDe41oQlmud8xCutj6uUx6lmJhRwt87DNxjdAxfvJb0NCNEJ0arV7uz+iLX8cn+7wbN67
	 PXQ1ysETW3nQs39buwu7b4GkJuiHYeOsFZtAocxIk4Bg8pKAWMd+JhyLO9sfMbq4h94TS
	 ga7tFAlExToWl8W1FchdU8G86qvPcheQRt4bcnDZ5idZlrXeqpiMPp6kAZmmgEoTBqL+b
	 mAwFu4Q9VLAQ4yd9kI0UaYmgcVJRkMzQPux2eN3UXZfoFTtpspcyq0WNou9kXEuVEbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=riiQUoNY;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=aAkSBjnr;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C8606A326;
	Tue, 10 Nov 2026 16:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 173C8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=riiQUoNY;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=aAkSBjnr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1794329892;
	bh=lwXpiQWNsd10Fs35VIZ488kyDttlHk6T6F9tVKnC+TY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=riiQUoNYeaWTF5rnjmzgAPzYASJAB/80t+W5xkpyo7ivzIHRDEI74VqMDs/1HSPeb
	 6AdInDHlo7hIYfFFOmfr23olRAJ57aBfU/zJNS0qRLU/smMzvgrn0K+Z6Z+DAcBwFp
	 9epDPX6PaCn+hH1nZ90eig9U5dn9iOO6RuJhB4/T2TK9enIfXtFIMw3JfHgX/ouyWj
	 igLpWMo7sEeUanrOJGuhD4yzAYD51dxaNa3njqezVdGuhjzV50XVP1Ng5gkVnfYoX0
	 N6wIpPDAJIAVoXnGDrgXwb+WDFQOwZfY6JEyzKD2mCoVWufjtkXSPXGpQ/Z+pt6yCk
	 +ChtT0BaDXNhQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3A2EB48C38; Tue, 10 Nov 2026 16:58:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1794329891;
	bh=lwXpiQWNsd10Fs35VIZ488kyDttlHk6T6F9tVKnC+TY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aAkSBjnryZUzF5b5kst1ruM6mNj04NduSil4+W11e2bQwS0JgiH4A+Il+RgtVwgmb
	 5sO+jRGkEbVTYQQMh0A76Lw4f8cA1fBvZ+AzdAUa90HempNLeWV5cRymmnQ8pyn8Hh
	 JIB7tm87jEYKsA5gC9PB9f/lkjoo0/nIIH11k8AaY/hygravG5zqGDM2fx7DMvt5Wt
	 hxlinDt5rkZXX54LOThio+AIgY7El5nhKOl395Al2moYBsgJwKH384EbjHY1Aj8mcb
	 3JBSqzWB1a89N84UGdTmsh1vxDYmZG7Vbugyb94zhglopHua8+5F3BJcZtvlPQoIlI
	 yPg6glaMJnclw==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0D6AC48C1C;
	Tue, 10 Nov 2026 16:58:11 +0000 (UTC)
Message-ID: <b1aba44e-754a-4968-873e-d7db88fa70dc@birger-koblitz.de>
Date: Tue, 10 Nov 2026 17:58:07 +0100
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
Subject: Re: [PATCH net-next v20 01/13] phylink: Add phylink_mac_interrupt
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, hkallweit1@gmail.com, chenhuacai@kernel.org,
 kernel@xen0n.name, edumazet@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, neuromoments@gmail.com, beganovic.emir@gmail.com
References: <20261106-ax88179a-v20-1-37b5a1189983@birger-koblitz.de>
 <179427470922.994134.16776316201780098943@kernel.org>
 <64d05861-c4e1-4506-ac2f-4109f1062932@birger-koblitz.de>
 <7c78c868-efe4-4b0a-b09a-c196210644e7@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <7c78c868-efe4-4b0a-b09a-c196210644e7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2026 5:30 pm, Andrew Lunn wrote:
>> At this point I am asking a human to intervene and tell me whether anything
>> really still needs to be done.
> 
> Do any of the patches not have a Reviewed-by: from me?
> I thought i had given such tags.
No. They are all reviewed by you. Many additionally by Nicolai.

Birger

> 
> We should merge this code.
> 
>     Andrew

