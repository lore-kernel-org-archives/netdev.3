Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BF2FE0F;
	Sun,  2 Aug 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785687639; cv=none; b=V1i/lgkjj6AnyCGTWaLUsbKU5TbKdWKwT4nLj64oPYgBIw+b99BaFxPDF+e2F87VtWtOHN+1wDovqtRG0XgsGSGB7KjjAYwtc4+vdbkzNbXsJG1MynDNXtn1t3il/HRyuQstp9zuXd9ilWc1NamH8zBA5yBhGhnDT8EcfERQYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785687639; c=relaxed/simple;
	bh=cDQQi4V6veozg9h1n4Ech+AFvVJUkYZwoKs+1f7pFK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6vzJYr5zIqMKA6AeGfwU9j4U1hMYYaPKQTONS1hVW8NhiZpac08QHZvF3cuTNq4gvZ6noY5sWkdoaUgFrzDPnEHZtGC/IX1UT1OLW05DsZewaKl3k6xoZrvz2s3pVwF0q6VMWc0ra3CY53k1iSGp4ttyJ5XDaecj8AQ4JWHRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NIZhP+pP; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=bH3A5YjT; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NIZhP+pP";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="bH3A5YjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687636;
	bh=cDQQi4V6veozg9h1n4Ech+AFvVJUkYZwoKs+1f7pFK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NIZhP+pPomon5YNj6JJUbc26AOodNEg7azc8wojPSxazjB29x+q6JKGQLI/Fj/uP9
	 ahbvnXc6oNJVxB1CDXomANNbYJrutK2EygKFbCj9XgzeryhanMgpOmiw2UuuEjbRrR
	 UoRsEiXHIPLqgPNjMn81ZNgTFNDPOo3EVvXgBx6P2oREM039CEVyHQRdBkYZ5JN2q9
	 sQrO1pauR8+7te5zNOvk8m4l1XgrLRaD1AfufZu0Q3dKMbsC/z2C60/Q+h1NzTGUkU
	 ex7fxLAYVsmR3IPNFf+beDgod+klxv2RlLWIjZhSWeNoRx6ovmt50z4EDA/m4o5IuJ
	 need2MBVy50iQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 17E4E4964E; Sun,  2 Aug 2026 16:20:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785687635;
	bh=cDQQi4V6veozg9h1n4Ech+AFvVJUkYZwoKs+1f7pFK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bH3A5YjTvSD3Furgk66tVWly+R0BxRdCMYYk1hlh6WAiPzqoNjTAQLl0QcIu0/ZXs
	 MMMQ93PJNgF573CHyqXaDB45lfLhA2B7CfAF+4lH9U4RedoFQ92XccWA4YeXHayreJ
	 bXJ7jUM376C7tFTWHOgYw8n8RAMh/TfsTD7gmFUnmBjwdeWps5Nj+wJEMfrijvJRok
	 ziu26wV3cu6X1e9iVm2MM2MqJA7SlxqAERNVi8p4RpYW3jfxeWXiPc7X9b5PzHagMK
	 e7BksHZfmF24R1re7lPdUGb97hbueYt72GNp/uaUbayPDvtBfHRFrPVXt/Ly2VilN1
	 4hQP5i5ZGAobA==
Received: from [192.168.1.146] (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0272C4949C;
	Sun,  2 Aug 2026 16:20:34 +0000 (UTC)
Message-ID: <d9ed1f65-0c67-4016-abcd-077327af13f6@birger-koblitz.de>
Date: Sun, 2 Aug 2026 18:20:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 05/12] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-5-2cf1f71b1dd2@birger-koblitz.de>
 <db165350-ba06-474e-9635-81c2083921ef@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <db165350-ba06-474e-9635-81c2083921ef@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/07/2026 21:41, Andrew Lunn wrote:
>> +	if (!data->is_ax88772d) {
>> +		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
>> +		data->phylink_config.eee_enabled_default = true;
>> +		netdev_info(dev->net, "Default: EEE\n");
> 
> Please drop the netdev_info().

Sorry, debugging relict, removed in v5.


