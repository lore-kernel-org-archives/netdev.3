Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000106;
	b=EikpPSntlcJnJSOzWa4bUcev2uqhdoGzqZro/YqfXQDZTmmz8pbU7cu50gm0rzNF+VZo
	 /8weayeU5jxXD26V0Osl5vgslYA18WBpu7IHZ9KvFKr3ag0rHyUEFGobnfB4M0IUIJONj
	 OlJZYu7fN73hXfd1hdU8TrdISIuvsLaodaUs31PLkgwnDGji5pV5okrYAY6rSzVnnN17+
	 Y6K4A+x76rqUNKu0hSktufj6umAL+bDommSonlULriX0Cj7M+zWiEdF24G4HIRFgy9M/8
	 sN5zyCAkMXRviJq4Mlg+eJIt8uQtrCCFVXgNdBfcypwQ829tX8/z93T0DFVyKl6SsHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=75ws0aWOAn7zVEkFYFw2d43XUpDpA+pOyY+p9nhXJYk=;
	b=44y0E1FBxrSrH3sN1Ds3yza4BnuH6urMAhysCWSVHRHolXzjYxkxoGM0AJg6FjZmAiM7
	 WLmi6Zhn4pz4mIMO2h+rr/FwcMduVqWa4Ymmi1h/mRZznFBkmddUh4bDO84gXgEytaq/z
	 LikEYETefMRnhzQj1U8W2MpecCr3bC4CnMl2FahC1CvYEWZ1a5F+D0q9Tbnrn6Ga2tsKw
	 I+SqAfFSWW9ULJc8+oUPvMoorXVeRlHF4TMXkJi1fiwFjJObOR03wbY+iTdcZnLiX79Vb
	 2GZ0T9129Zd6FEpjSu337T/LhCiqbfbdIggLvbC3ow+yyFDXnEXhGvsJbEqogwjXzZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.228.133
Received: from mail-ej2-f5.google.com (mail-ej2-f5.google.com [74.125.228.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD670606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 21:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD670606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f5.google.com with SMTP id a640c23a62f3a-c46c4bbb06fso63925066b.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000098; x=1794604898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75ws0aWOAn7zVEkFYFw2d43XUpDpA+pOyY+p9nhXJYk=;
        b=avLUNoP/0mGQDa9n2tUDRUgALD8TkKdkdCBOeoRvyiDf52Q7vEJlZib1bBZdhuW1gv
         NKc/9lXikFMgz5ISJxvSdzNoqCGivMBwW3jh1+D3gl0UxRa/zSU8az086+qw0OkFkqQq
         oahgwUu5/8sBeX1ZJH1R2uuzCmCihHnyhOZOvQxI58zji5DPmvTv1nQpHpvxGD6XNecj
         P/H7ZYYkBWEt0eCYOXRTY2S5VvoJZtYWmVsy9+gpdmmulG1XObgwOCAS7QOIxw33gxC0
         Hk5e6o8Xuy9nwKX5rhHn0Kgb9HVAVIN+KAKjvWncgtlMEXRx7HRRL9HEfOwmNui8I/im
         O2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000098; x=1794604898;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75ws0aWOAn7zVEkFYFw2d43XUpDpA+pOyY+p9nhXJYk=;
        b=1KT2LqqBf3oiY9Ql8/rLw5zbpzPOPre5PPhZRwjHnJ1nGdxoZhKXSMzrrJmUzh0URg
         xIy9vWFSvI7oiDU0J0OBXgbmp9YoStU1mBt5UVeNHx905VURSgFT3J9dOZ7vzRgJOUFK
         5x6ye7kLzxKCSY6WfDolXrp9wXlYMP+d55tErzih8SDz3P/kSh7tkThlSu16U1YFg1vj
         NJWvWmkYKrEq8omukL4QruRNhcUU5RrTr4lBwSRYGhWefcaYHCoFqrTNz91fjONAmLBm
         8IMovTKqTRDv21EiLvBZxMpws7VAT/1VWOakvlBh12J5Ql2j94Hrn4zaMr+bK8rvCq7p
         aL1g==
X-Forwarded-Encrypted: i=1; AKwUvBxgRu1wO12Pb+ZNY4JtH9CdGloufVouVxT+nCXehO/Wi9ubUjBC4c955Aq4diQeNkyGacXf7nc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eVWBkdwYlRHX3Hw+fLYudVnuxBr/UJ6TUVwqPoByqacrV2S7J
	yra8fzLQWKt/a8O64LjRggiScGMfa8GVLEFOwDGoNigJPmJ0Vu6y0nIB
X-Gm-Gg: AYBFou3p2Kwie2RrohI4BAmla49iz7a1ey81woYbaiXOPZIwyTb29rB2T+xBTxqzqlg
	PB/IgPw/LesHZqiTqwJhbunF0CyVPj/4AYSLS698jP/C5XkSNPZ4SQbNNk+VuuBZkoEPEJx5kVX
	XseGEj3wUH5VNdZ2zUzc8tSMtRSy+gHB/axdpnxC8YPa90DVCH5B6XP3ODN8wrlpjc2mz3cjyom
	Mr7gxGM/FbK17krJ5Gfa4JRMqPZ/xK+6G5HCMG+VBKYV+PFHUwGMKNpnZ0EKfvq/3+JBQenQqi6
	QEhILOtnX4Hpd+klNFjycIu+FeG3xG6EIrTqCZqT40UQLgZrGau1q1frV8yzg00+R9fHjSBsdk1
	3lDhMP5wcF2yUqmYHhNjFuvZhWP4uO/68b3pCDRPf0jtD0rf3vc0KiiY56TGzgXE2ziu15l1BTr
	r5UKmsBr8IoE9eOgK1iXMxfeXj9WRK+6oCK/Ih7hyReel6YW2tsPpsUI1hdwADHSk0Lr7kEfQK4
	57OyNqfELhhhS1DYZLqEyRVJIfFkMQpi8gszg3K1jwg5iC9k7UbAewDBs3E1eghYMBptk/i+jTK
	TGnBm3kUpgJiFRYXFGwLuyXyNFkAEFhGXydgNQ8rEgkFNXPLOpauRlRzcDNda8dnxSNj7Crc+pO
	CseVcWY6sTnNYlvL4V0pSdZIKQQAk0rsbX8l8xmgcXGfXTBOub0NguoY=
X-Received: by 2002:a17:907:3d94:b0:c2a:b1cc:158d with SMTP id a640c23a62f3a-c4d35554748mr318528866b.32.1794000097799;
        Fri, 06 Nov 2026 13:21:37 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b6e82bc5d7sm849953a12.13.2026.11.06.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:21:35 -0800 (PST)
Date: Fri, 6 Nov 2026 22:21:30 +0100
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: phylink: keep initial advertising
 settings
Message-ID: <au5E2qilAsVuUOgx@thi-server.fritz.box>
References: <20261104125509.3221743-1-thi.zirnstein@gmail.com>
 <fb28453b-9df6-49a1-8c01-543e7bfceeab@lunn.ch>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb28453b-9df6-49a1-8c01-543e7bfceeab@lunn.ch>

Hi Andrew,

Thanks for your feedback,

On Fri, Nov 06, 2026 at 02:51:18PM +0100, Andrew Lunn wrote:
...
> > The mode of action is as follows:
> > 
> > * The link was not up yet - no phy connected
> > * the user configures the advertisement of the interface
> > * the mac driver delegates the call to phylink_ethtool_ksettings_set
> >     * here we are not configuring the phy - it does not exist yet
> 
> If it does not exist, it is not possible to validate the user request
> is actually supported by the PHY.

I think my description was a bit misleading.
The mode of action describes how the phy is attached by some
net driver and what the program flow is and why there is a problem.

Typically the device driver does not set/clear any advertisment bits
during device bring up. As least what I have seen so far.
It attaches the phy and brings up the link.

> 
> > * the user set up the interface
> > * the mac drivers calls phylink_connect_phy
> 
> At this point, is the previously configured value sanitised by what
> the PHY can actually do?
> 
> Take the example of a MAC which can do up to 2500BaseX, but it is
> connected to a PHY which only supports SGMII. Before up, the user
> could request 2.5GBaseT, but at admin up that needs to be reduced down
> to 1G.

Good example, with this patch applied this will advertise 1G,
if the user does not configure exclusive 2.5G prior attaching the phy.
If the user configures exclusive 2.5G (2.5G only) the advertisment is empty.
I think this is fine because the user missconfigured the link, but maybe
i am to restrictive.

I wrote a little table for a better overview. I am not 100% sure
how your example behaves because 2.5G uses another interface then SGMII.
I have tested with a sgmii 1G half/full duplex link.

Without patch

without phy (user):     phy caps        link up advertisement
1G FD+HD                1G FD+HD        1G FD+HD
1G FD                   1G FD+HD        1G FD+HD <= bad
1G FD+HD                1G FD           1G FD

With patch

without phy (user):     phy caps    link up advertisement
1G FD+HD                1G FD+HD    1G FD+HD   
1G FD                   1G FD+HD    1G FD <= good
1G FD+HD                1G FD       1G FD

> 	Andrew

Thilo
