Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953082;
	b=K6O4+v47VKpykgN94NFvOs62/70kFpNGL/U2kJ4HmXZkWGs0jGoouO1mPEh58suFXBsW
	 YfXSopsOVYNlVDHqd7H24ilx4SGODvxthe8nzfIxFJgm5TfingJsCQC4DOv7WT4CvippB
	 mUg5iGhOSq0J03zAC6yMbv58ojQNpPhe4WTVcOM8ktxmMn1L4+3H7KX8qzh7BIRGx6LPs
	 okcXj/kPtLGswgdWsFrtQvhgwRMVZNY5ShKtC0ZzzshRFGKNH5PL6GyRMkfXZLWxQ+8w3
	 pQDSvhhMMxETK/zIaQdZavmfGm0lJUstxNuiJqVBLjhoy+pxIqQUR7iHKBs4QqP/1KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IhoDejnLT0dqcygxtJi6cYqFmAuk66FRNmBCl2akNUM=;
	b=ySzunDCrhHrvQ9wocPAa7OfIc7AlgkKxiWlkCEyFpYN5KdNxAAKi8AHXE++MIC2bYa6A
	 j/a2nSi9htAF8v8yWz6IGLLsIca/bWMqtU7+wEzDd/m+/Uc8fqZ8eMP9gVINzWqN8VYVn
	 HwaIbejVEIckMMRzvCTmTm88sUVTy4rAn+hiUNFBIniPeJkZg1dlrnM82GMtT02OhGyMR
	 5OpYdhJojdqmEEmIy6ddF/OKWFTmuAgsFG6l3LY+errq6T3vcrBtz6qE6/OPN8ris7rwu
	 yw3eVyx2t5Er5rZWbTN7pY+8S0n9ptMjDTKkF5zYSLeiBsxXB3schgpQP5jYijBNZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urmPU7lK;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54591606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54591606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urmPU7lK
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so2428505e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793953081; x=1794557881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhoDejnLT0dqcygxtJi6cYqFmAuk66FRNmBCl2akNUM=;
        b=urmPU7lKCRuR/zE5gSzypnBu2L7s2A7Am1JVkWuaOrfp+GaQq3jk253zvk1SL0aH0x
         ooZS2EcI9Mpo6733mc1+7mCNDfARa347IINKr+SQfxcxy3dAtN3+8K2HqCJC/+RNIXO1
         MU42yp1Zg6AOKeowdYqXm9G3jzJPpuOvT+g+jY9+QxKoLpsi9M9HhEZ+qrO6jl4m+SyX
         IuKIISK3/jprJuwVbyJBQAo2D/hSVUXrEvuwO9fHjEqhEj4NENAlGHLl4z9IdNL/EwuN
         g8Dwn5X81UuMC9GD/C0vQzi3aMejrGY0taakbzimzFDuC6rXLgoIfg9hLhS3Xcy8LRlK
         SusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793953081; x=1794557881;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhoDejnLT0dqcygxtJi6cYqFmAuk66FRNmBCl2akNUM=;
        b=SdGw/nUoY+FW/ry4aaWNZKZSxeaPr1ogLwCKk/Xfn8+L+mxOd23fZ2mXW6hM5Rw24V
         GNfKCYNM5QHbEddRE4KsJzJEJRzGsuHbEQqDtT6gGdi06jpgXMsGs2gd0PxwcijBvP9k
         nlmG6KRsVTTLwycc9QjTvceIlSZUH+ia+QO4OCVK2dNrSmElLPW+i9t3s0+Uc69cOUmb
         ExtQhUzoGzaSBSVN4RqDSlT2y8J3CCt1tJK7BZz3ZoGouEvKQ0M6fP4rMw7CaPbFRuqO
         rg+d8qAsDg8B+ZUylWmdt21UOmJED7cMu/nbr6tfMUBF/s+WfAwWT6hdR8kVTiwfmFSj
         R2JA==
X-Forwarded-Encrypted: i=1; AKwUvBz37DdwCTBYDPTI9SAvEZr7fetwCetra7sSHFrdssiQb0qzhv+uS4P/8CUPD+Tloes5CqvBQCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ChJ2PG5J+zRDEmzl068Akosxf66obbWEXklqeCFbwRgLUfxIj
	8yGdNWiwDyMoYthSbOmgSccz1BrTQs1cpzOG06lXAW32bZsIs4ov2FGJ
X-Gm-Gg: AYBFou3TZr4dqrJE3lpPKeX+4h1aOfl010hCN8q05tf7/Ej/IdenNRGO6aqCOKP2j0K
	DjA28ODDbJ9dPsm1zPPSQcllGX0Ur4SPaDZInKfsWVQ7G/NpX6nEIFus7bu2+tW/mpacy6DZVOT
	Q+Zq0DvbI/ceu2t3yX91cXL/yF+HZxU1Pz6tV0APS3INfogbSp+eSCEfJ26Vdz5Y0ud4Bk2oEdS
	jlCROWsUwXoTZwOVrtV33eDE25UNx0cWwOPoaLo1PESnzgeZSIFTTc51qMQJci8qSlLOI8xM4yL
	gDiw4q19HdnNkQL4kSMnVBP44QIwbmmQmzMz0G7XcSrDyoF6gfudjEaUKX4bjwo5xMXv9YoN5dL
	drRjdwhcBYXESFnGeGw3WSmI6+0arEm8wdy/qxYGl3HSR4eFa5N1z1ZB+n3Pq07v8g92Ycyn4MM
	d1NebyzD3AqzIvjXRRlZc3YGaS6TVZtM15X/hDVKIRzv6LTQ9yZ1LJ3XvKgcf8s5lLqf1AYLESJ
	xHY2A2iNju7O5Q3TnCxsHvm9IsmFKJo8Joi9haSHElotaqjITYD0Gd6jSRgyK9R/lRYxMPrJiRz
	lUjU02QQaymwBimjanYSQXsL6OaXts+ai3ZO0RM=
X-Received: by 2002:a05:600c:6992:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4b6de4a6c7amr23740735e9.16.1793953080551;
        Fri, 06 Nov 2026 00:18:00 -0800 (PST)
Received: from [10.44.66.133] ([86.127.229.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7402d84a8sm23501215e9.5.2026.11.06.00.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 00:17:59 -0800 (PST)
Message-ID: <d909ed3e-8613-4a9d-ab59-f59187d734df@gmail.com>
Date: Fri, 6 Nov 2026 08:17:58 +0000
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
Subject: Re: [PATCH net-next] net: phy: add driver for the ZTE ZX279128S
 internal Gigabit PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20261105-phy-submit-v1-1-eb382681a76a@gmail.com>
 <b38a7a97-c88c-44fa-ab0f-89d1e809e21e@lunn.ch>
Content-Language: en-US
From: Agustin <isasmendi.agus@gmail.com>
In-Reply-To: <b38a7a97-c88c-44fa-ab0f-89d1e809e21e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the review.

Before sending a v2 I went back to the bench, and the result changes the 
picture, with the generic PHY driver and only what the boot firmware 
sets up, the four LAN PHYs link and pass traffic at 1000, 100 and 10 
Mb/s with no errors, across cold and warm boots and repeated renegotiation.

The TX DAC registers already hold the values this driver writes, and the 
PHY adjusts them itself with the link speed. It turned out to be a bug 
in our MAC driver (frames were sent to the wrong egress port), not 
anything in the PHY. That leaves only an LDO level and one undocumented 
register, with no measured benefit, so I'm withdrawing this patch. This 
is also consistent with Navid's ZX279128S series, which uses the generic 
driver for these PHYs. If I find a case where the vendor settings make a 
difference, I'll come back with data.

Sorry for the noise, and thanks again.

On 11/5/26 15:07, Andrew Lunn wrote:
>> +static int zte_gephy_config_init(struct phy_device *phydev)
>> +{
>> +	int ret, i, ldo;
> Given how minimal this driver is, there are some potential traps we
> could fall into later when we find out more about the device. To
> reduce the risk a bit, please could you add a test here:
>
>         if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
>           	  return -EINVAL;
>
>> +static struct phy_driver zte_gephy_driver[] = {
>> +	{
>> +		PHY_ID_MATCH_MODEL(ZTE_GEPHY_PHY_ID),
>> +		.name			= "ZTE ZX279128S Gigabit PHY",
>> +		.flags			= PHY_IS_INTERNAL,
>> +		.config_init		= zte_gephy_config_init,
>> +		/* The boot firmware hands over with BMCR_PDOWN set. No
>> +		 * .suspend: powering the analog domain down and up at runtime
>> +		 * has not been tested.
>> +		 */
>> +		.resume			= genphy_resume,
> It looks odd with just resume, it makes it look like a workaround.
>
> Why not have config_init() take it out of power down?
>
>      Andrew
