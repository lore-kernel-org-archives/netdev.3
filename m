Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A448987E
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542271; cv=none; b=CZQmhw6MFWDZ95iYegoJg/BwScNJSU4W7gYNusEHzy5VprgfOsk68hc5lJvdWfDbySxXBm3acmPitwrLt+lOCJgSQXip57sdh3rLx5hueLrUR2e0ukhjEh4BgznT3m5OVPaPmyDFl4WIvLfwpc8uphbpvz0NOzaKVvnUL1NZUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542271; c=relaxed/simple;
	bh=2yPy2lwImdzXlnaIIADxQvlhSpPsElLYfLNDwONh+9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oat2b3/haxTnS2TJmo7iSvkR7jCOaI1PMQkM5hWKAL0KTIYNlRUol2OLLGAAbFimjeg+7+pzcvuac7XdxlrenOZWTaOJE4YYSLf761iHOrYlNlUN0LFlX3YGFiLdhRZzNN8LPjP5SUsz/mScwXwC7Dsfy9736/69GnyccNYFir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjV+uYRP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjV+uYRP"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1224077a12.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785542269; x=1786147069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I0b5Ll4iU7DLkvHNP8rAK1aY82cSAlE6Ck3PhBMpbkM=;
        b=hjV+uYRPwcicrzwF/gqN6Z4SH/hTRFIMUy+WWSAIdWNVGE1mn4ZfBY/GU69daQfdo4
         SBj4FLMyx/mz2zunE+VlraGej5t+YpM3cASWJJGwX50pP9MY2LBgSRDpu51aI3GC+1CS
         TkPCautH2YQcz8nc8t7RXld8sdSjbSw3SdP/MFVAU7pxW3yhRuh28cas/E9ia33fnuEG
         /pDipqos8+ufMaKuAbT39RQ4TFIBS9TXOdRnK3/x8BlEZ9zVV75dPWYL+F8DKNx00Jmh
         SLZHHv3O1PhRuuU+kwETDm8JkA1o+z7HGJuzwoiRuhGWWE4MPWevUHXVqr13TMKQ3kGY
         mFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542269; x=1786147069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0b5Ll4iU7DLkvHNP8rAK1aY82cSAlE6Ck3PhBMpbkM=;
        b=WAWAc2ya+kIAAEOUGoT4/H2kW3QwFj+tDTGV7pAwfyeyOSTVI61/DUbAse8e68xRup
         Orhn93NcEXBQ6w4AERZT3pkga1tw0TzpO8x88IALjU3sxm6qFndDfbd1iccFou05yVsp
         0hl6Ru/kDxnSgj7zNd2Mt6xYdqFRBhDAvCFxocOQWttjElbSAcerut3y6D+7LNXyB5Mk
         mcWlshovR00WEYZ3LBrVynT/AkHun/iP78TDMtC+GHN1xFl7VOZ57itSpq5J5szlMySa
         Pfgrdy9t/fv2a0eDVKTMFntQg60KMzmvuKoe/JYR0dNAK2IqpZzWtcuTZEFse/5JJ7Ht
         jzzg==
X-Forwarded-Encrypted: i=1; AHgh+RrMLPDfmdoJ7e3WxG9BFjQFhtjBvpFGJ35bu6S5nAYL90b9XlDFqwVogu6iADk9vipbLZetC+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9yW+KsywYQg0QlcGeDHSfuJxmI+iORlmE49Qh113OLytsF1V
	XycvxpzkEgj0tKG2RbWJbBSD3vnlHXTknCShxVkNYrdL9PXQz0M4+WS0uc42oXbX
X-Gm-Gg: AR+sD10QS8J6dC53r3s8DV2B9T5KYnetElDGR/JaSgGD2K/fWN87t3Unh8Ag4GyTvIK
	oiMZD5Y9kVFRSZr9mRKI9qI2lY3eSUJNrGk5BSKDfEKDPq9FQ0WFp2C79mUc1WRM0cPm9RjwKi3
	smd6MsoJY2XzL0UoZaZn8W5xf5DO+o7o3YRHmz/sBkQEsLho9bTinKBKv7/NmOvLHShvrQgrOHC
	q02jEf76lANcN0MLzhHaOBwENn+T+7bILqzG4YK0llPNOijRhDbweLBnZJatfrxMi70TUC0ZELQ
	g8aD8cIeSVI09Pe50jyVHnlsyr4PG/W0btHNFT7K4G+byyrMpVXZdcZ42w8CwaKVEjc2KMprZe4
	LI4oT3xGuB3GPwDi2oT0zLoBJIoq8aTpVHVnT90vO82vaBFrRApx/Xt9OzcaOs8o/Ew6IbVFYLU
	uldwwTOvDZ4MzydzOHGc1jg6KoGY562GD7QxFe69CsxC8tTUVmEGFGQic=
X-Received: by 2002:a05:6a21:2d44:b0:3c3:7edc:3103 with SMTP id adf61e73a8af0-3c92a8d1636mr1387023637.62.1785542269013;
        Fri, 31 Jul 2026 16:57:49 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39eb13dbsm1157909a12.29.2026.07.31.16.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:57:48 -0700 (PDT)
Date: Sat, 1 Aug 2026 07:57:41 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] bonding: fix skb_under_panic in bond_ns_send() over
 stacked VLANs
Message-ID: <am01LskdPIN8yU2C@fedora>
References: <20260719232153.1405569-1-xmei5@asu.edu>
 <2820549.1784570299@famine>
 <CAPpSM+RkHO7uEVrEbqgfundSbiLU67enaSXhtk6mL8bXzC17xQ@mail.gmail.com>
 <amrIbBqpw9Ol5wPJ@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <amrIbBqpw9Ol5wPJ@fedora>

On 30.07.2026 11:50, Hangbin Liu wrote:
>Hi Xiang,
>
>On 29.07.2026 16:30, Xiang Mei wrote:
>>>        Does adding one or two more nested VLANs move the panic into the
>>>above call path?
>>>
>>
>>No, for both of the reasons above: there is no room to add more
>>(-EMLINK at N = 7), and skb_cow_head() would absorb it if there were.
>
>What about the scenario that involves nested VLANs? For example:
>
>vlan.1 - vlan.1.2 ... vlan.1..6 - bond - bond.1 - bond.1.2 ... bond.1..6?

Oh, I just remember that the MAX_NEST_DEV is 8. So there could be only 1
VLAN slave with this topology.

Thanks
Hangbin
