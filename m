Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EBF5187E0
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571006; cv=none; b=C90uUIpMgsIht3WraHb5hIqdzvOdXiiVLzu7MB5r5+McDfCTGxk4xGG032H85lTEuKNat/A2xODnji3lkAYNTValhmhpYSCSrbdITIK1TR01OrRNfcV1tt8C2hGrbk/HzvQv6sJSUfACCzrUOGRsVxopb2X6b8nJ00vxbMiSocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571006; c=relaxed/simple;
	bh=Olfv1cEj/Q2V2EfL0TClOBsolKlcE/xB12H/kkUWGJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUXw4XKfK2RZ3wVrWO86EQw854OjuJwlSy+7N+nkixzZHGjemuWMLrzny7cHal2BidQSWvyb7HRm2k9HVjsQtf1J4ItPo1T8yt35DpVcNZ+qeIPxlGcBfHJ9Gvf9nGIDqDB+shgvBLHj5dUDw9IiDmVeK8YSDwvBmge5xmkdTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MqZnMWBh; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MqZnMWBh"
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-30b6dad2382so3927eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571003; x=1792175803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j5KFGHzmm1JQcpIgDGRE5WvyzYcpsU0vk5ld62/+7O8=;
        b=VBluiEAXtgVtzwagwt7eKRI1ufhAC6tZc6ctBkFPs0Okll+IGJyoAgz+ARu/9cdR51
         msbzzzBJ8qA173u/jwzw3x6BY4Ygph7z+sKbJLZvHLrp89VF+vgRp4soMDCvtEEtDa7m
         5XP84NDqLF/5C8HJy2cpd5/s4+r4Bv7WBB8LPNHus7sWJbyrSFVW2Cim8ir0MgzlQDia
         lIrkNbQdUS2U2T+tffHVrc4brXWS1Xp0FnGBpjUjEIWOisxfYc2SCCP79u9QcD91QwdM
         mhthj7qCuD5RvgZqAELp3Y0j8JYwQNoaVd/0LImSrTOjk6M2MmFCcBrFpkmlRiQdOZcJ
         +0xw==
X-Forwarded-Encrypted: i=1; AKwUvBzzArui7ajR3WfEexqGKfmDqOum1mOkimdwaouIM0NffngcHcHZ69MVRKXgmwnNHCAGYUYG0vs=@vger.kernel.org
X-Gm-Message-State: AFuF++lV+6MrcJm6D8ZMVliIE/Q2jyMdjGxiyKTu34HvW/2EyWcpvilr
	EMhNiT79tL2H1Lla0prUO7u5MU1R9ARTHRFdCXeYA1vUNfqrW4RCkOW4zIDOC0qPsbQniVPoQ/s
	k9Uda+hHochHWzmZY4grHJdMvVZPWkOA21s4Vs9zE92Zr3cKPIaYGzbsgATCUl6eYt0qQCcYygD
	L1UUyDSmPoDDehHk2MzVhdXNcp8GKkZ4dI97toDIkJ0nqj7PrXHH2hsWiXb1DWx+Vjv/OL0PxhR
	fvottGGOQ==
X-Gm-Gg: AYBFou1GbBM8mq6zIDpYXK8E3opbAYgjnoOsG5N4charzM/fP3LWWGUqprAoo27kiXd
	xBfQervm9JyC2Q5znsELtrejp5sIu6h+BVvOPLM0zbEJqS4HkT/f7muQj9oCJoKH1/3VJlcDWmE
	h05RJastIdVs1+GVGoa9iWNsbLE2YlnLMmKdQghZ26Q2vFrgSLn2vWIRuXzZgPiVhOlKmbQKtU2
	rBYW6tXaCPRDYUo17TqiIp+TxI2UbLO43blPyym2LCx03lPpnUN6eU9l8f36HZq9Igbwi460yUM
	oQ4SAy4MeB8iGf+aGCGE/EpxUHrxzJY4BH3YZfbdqZDerbqpvuQCwsB4eFmpy7ERZF3mtzxKZNZ
	6O+nB2l/0T3Q2mOb8rGxI4nxvensYV2gKNFPY1vUX/0KRX9kxwaF9pLMKIBLJ0DxBRDX03vjpEj
	xDU5GkakrA3z1unNpyNNacBySgUA0zEktOog7u
X-Received: by 2002:a05:7301:a0f:b0:315:afc1:72db with SMTP id 5a478bee46e88-3537e046a1dmr3320284eec.9.1791571002518;
        Fri, 09 Oct 2026 11:36:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3537cb29558sm61037eec.16.2026.10.09.11.36.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e832c03576so336505ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791571001; x=1792175801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5KFGHzmm1JQcpIgDGRE5WvyzYcpsU0vk5ld62/+7O8=;
        b=MqZnMWBhFqLZowapV+6rlOE9Hegh8ses07klmtGIzk4ARZ142g9KRKzHoODnFUULn6
         UIXjuwfcSsYQH9gnd+3Hqkx4Qsb92Rtpg8NGEzCSa1cDqBMNV0MhTezj+/97MvHEDjSB
         cmgmBBHchVjGS6jwmRjJoucRAzh1r5fOw6Nzk=
X-Forwarded-Encrypted: i=1; AKwUvBxxU+QupX4c1a0e5dTs+vAs+mFcKT79l9Ddif2kzyFDJy7ph93vLhXcU3EvlhNdLQU91XndN48=@vger.kernel.org
X-Received: by 2002:a17:902:ce0b:b0:2e6:2868:e572 with SMTP id d9443c01a7336-2e84280a97emr27659385ad.6.1791571000870;
        Fri, 09 Oct 2026 11:36:40 -0700 (PDT)
X-Received: by 2002:a17:902:ce0b:b0:2e6:2868:e572 with SMTP id d9443c01a7336-2e84280a97emr27659235ad.6.1791571000435;
        Fri, 09 Oct 2026 11:36:40 -0700 (PDT)
Received: from [10.14.5.199] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b298dsm14968885ad.33.2026.10.09.11.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:39 -0700 (PDT)
Message-ID: <5e07aaae-b9bb-46db-ac22-bf8af3aee5a8@broadcom.com>
Date: Fri, 9 Oct 2026 11:36:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/6] net: bcmasp: fix OF node reference leak for
 phy_dn
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261008210621.1374785-5-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261008210621.1374785-5-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/8/26 2:06 PM, Florian Fainelli wrote:
> In bcmasp_interface_create(), intf->phy_dn is obtained via
> of_parse_phandle() or assigned ndev_dn. of_parse_phandle() returns a
> node reference with its refcount incremented, but of_node_put() was
> never called on intf->phy_dn in bcmasp_interface_destroy() or the
> error unwind path in bcmasp_interface_create().
> 
> Acquire a reference on ndev_dn for the fixed-link case as well so that
> intf->phy_dn consistently holds a reference, and release it with
> of_node_put() on teardown and error.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Assisted-by: LLM
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
