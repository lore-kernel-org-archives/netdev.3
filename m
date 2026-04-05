Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CC2FD7C3;
	Sun,  5 Apr 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775425578; cv=none; b=X5TQLu3RKkTtI9zLhHbMWmY3T0fSrt+m2Zve5sQ0HJBM3Y8GR8AAsC/c5N83u9xF8FiKVUf0R0wm8Hu4r+TkTaq93aSQwbkCx2ha+cZHJQgwtXzaCOaPwh1+XJGWtrWEAYDSCXx9WVhwAcDNilWRzi183OqD+9E4an6cQXOW24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775425578; c=relaxed/simple;
	bh=+lNfPX2K6HQ3gv0sUSD6xBnk8GW1HB4zGmZX3ckHLnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbmtuoESDNU40rXVH4vSdViohBITvJrwEaos1j8q3ist3RnEQ2RHNPo7ds99jcS16MecT3wW1fS6G1fk49VcssfD55mYDEvvLPpzN/3uyn+grf4+ifC3xvlpZ9yJWeYWVyHbzaxdS9odhdH2CDSy5YYwd8HuDLEfGNykVRMlod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yo4Xq/tN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yo4Xq/tN"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fpmHS6GSzz9sl4;
	Sun,  5 Apr 2026 23:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775425572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViSD9T8wY0rWxKnon3lik3t60je7yr2NF7lyf1uJ/1k=;
	b=yo4Xq/tNKoD/FInTvOV2ZRfvvA3A83fWzItVEtmHMiNqVqdZMB4+pkYudAPNI2HmlxUnsd
	7eDLWaWJOD0vLRpvfL95tMILB1JKr6t0YGPiyLACkJGjqOoGzjJK+V6rIOA+fS587yUkaF
	DlGyKyNCz4mH5rGqipaquLXvt8EaivsndHSTpZvyLnSrEwaw/eqdFgEeltbi0/zz7wMKDh
	dDDebTsJFOADe/b2R4A2mKb1mtpZyffqVfr3npXQBC/2lVnQSvkjFjgwY6BFNAJ3I1c7cy
	kXjXI126OVLpOqACM78atRrPsyZjHio6658zyiaNkc3trZt5sqCccfdize3wKg==
Message-ID: <988c0026-6b07-4e74-a6de-6d0f10a61443@mailbox.org>
Date: Sun, 5 Apr 2026 23:46:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v5 3/3] net: phy: realtek: Add property to enable
 SSC
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
 <20260326210704.58912-3-marek.vasut@mailbox.org>
 <20260330185721.4b94ed30@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260330185721.4b94ed30@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: beydxittk4s3jjk7k5qbbde9tu351uou
X-MBO-RS-ID: 13b065b312191b8f39a

On 3/31/26 3:57 AM, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 22:06:35 +0100 Marek Vasut wrote:
>> +/* RTL8211F SSC settings */
>> +#define RTL8211F_SSC_PAGE			0xc44
>> +#define RTL8211F_SSC_RXC			0x13
>> +#define RTL8211F_SSC_SYSCLK			0x17
>> +#define RTL8211F_SSC_CLKOUT			0x19
> 
>> +	/* Unnamed registers from EMI improvement parameters application note 1.2 */
>> +	ret = phy_write_paged(phydev, 0xd09, 0x10, 0xcf00);
>> +	if (ret < 0) {
>> +		dev_err(dev, "CLKOUT SSC initialization failed: %pe\n", ERR_PTR(ret));
>> +		return ret;
>> +	}
>> +
>> +	ret = phy_write(phydev, RTL8211F_SSC_CLKOUT, 0x38c3);
>> +	if (ret < 0) {
>> +		dev_err(dev, "CLKOUT SSC configuration failed: %pe\n", ERR_PTR(ret));
>> +		return ret;
>> +	}
> 
> AI flags that this, did you mean to write to the SSC_PAGE here?

No, see commit 650e55f224a5 ("net: phy: realtek: simplify bogus paged 
operations")

"
     net: phy: realtek: simplify bogus paged operations

     Only registers 0x10~0x17 are affected by the value in the page
     selection register 0x1f. Hence there is no point in using paged
     operations when accessing any other registers.
...
"

Register 0x19 is not affected by paged operations.
