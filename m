Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DC3B47E9
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643740; cv=none; b=pwa1ONFmF+WGAzDn9Ut01XcSXBX7jVh0lJKTAWVNh9Z2ss6nljI98GheRRwjT5CMraRo/ua0OwpRToShjqxy/RbeXPHLvPw0SqVAg0twTKeiMf3EjjdfUvS4OsFhLGUDYVYPfYT9uwbbtNktHuE6GlRydDMVez/kSQ4ogXP3zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643740; c=relaxed/simple;
	bh=YCNfIT6HdGLoX+wG5B69NdFLjWniYDocQcIg3+WOlhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcHXnDKSQ+pu164Bf2oQdJPnJlCLEZrsnUwteLgx9P3KmkvPdEQ9HHHSJnh1yIsEC07Jp14Vvrt54o5vRSeL5O5uWRStdF/cRQS7wgpwO02b0ORM7u+jq0MS38ez7WkyaMWypzIN+cFX6I4iaJkLeev1sj81ucDEgj14pB1xhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so395405e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643730; x=1787248530;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWmJoprOWyHEjuFsBj/3VQ/n+OdsSl0XVIZ6JSv5c4U=;
        b=fw+T5ORniHIYdfrxS977gEneEIrt9sAm2Yia6R7Hh3URdURBqtf6h2ql/xtytyTPfn
         PIVnxDwCNW02El/mX5g9ZsnA7hCwHNJ3Kwk0h2+RDRL15ex7DuDondfcomTrIr6igIui
         Elzg7bTRTOfvGlvmoHJwDCp3kwtgAYEQVPR2TwVYMXq6FVlBXIFqQv5Hnk+E4GPpUNEd
         dhJVZxBJnGsdqPOck7Mnu2XTK7Ci7JSH0G4Wqw3sADS0qNbaPmFQD8mCBIDn/q/8neJZ
         0Yn3nd3bNHxmU8o48sT0zZInLX97ry8REA2dIVbnw3OJXaIvwwKhCOtW69W2HDDfA08u
         4Scg==
X-Forwarded-Encrypted: i=1; AHgh+RrtlNlL0O05LEaSPn21gyoMsYD+oWNsyPR8WrY7rthyNvIg5gYcSAL3XDU34rwflkuLHyS4sDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/9cr+QbJgOU7LBQb3UPDET1ROV4lP3iGdLgR1ld2pqvBNBb1
	ST0HvT8Rebaaf3g/KfFRvoiR+nedi11KbwdSSl4e/anOdRpjIulpDdKS
X-Gm-Gg: AR+sD10unMWTBM7P/qL8JJL39yDPvW90eoAISeIoLcDuA8P4PH/gZz/YkitHPPMRofq
	2HOlsM2j+Mo+VRhq/g6lUFNGCyhU5FPWwAmwfIAMK3d3YhIxJ0TpOV29dVQLSrMwRFq/JFmfWB1
	nd5VRu5Ji6UP1eHTEbJf5yBsGmXRwyQv5RfZRWuGqTrVueOtIngQztHZiM2jiSyEN5ofMco93Ud
	YmvY51n9sD0c9L9h9tJxTm05Slga/mjY7yPwRXL8V3Kz23Z4PmWfpYdgTA9b2Gg6moIf5VqPqjE
	RNYK//kZN6PVPKpt9ThIFGxnY75SWoHUbdFRCdo/bv4/CfQGQ3BHsBt7cfBwwP6tGe/Rl+fM/3E
	O2hphZhYMEXOC30tm03Gc0dgFGpYx9GKw803JlTydEY3dNHMTfDyc6YNHI4hRUxZk0Ae86jyfc2
	DC/1wrWa/lhSI5Lenqh7MmLMOFn4WYEkC3k5KiBq3CB8ha3QLCnVU/h/K6M78ebQpkiN+bTBsYu
	xR201nhALQ+66Dh
X-Received: by 2002:a05:600c:a4b:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-49987944162mr2927655e9.2.1786643729658;
        Thu, 13 Aug 2026 10:55:29 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b631c1sm165878925e9.14.2026.08.13.10.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 10:55:28 -0700 (PDT)
Message-ID: <9f1d9db6-a39d-4c3b-aa94-9a70e979ce71@ovn.org>
Date: Thu, 13 Aug 2026 19:55:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] openvswitch: enable ops lock for internal ports
To: Wang Zhan <wang.zhan@smartx.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, keyong.sun@smartx.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <20260812123003.3634034-1-wang.zhan@smartx.com>
 <20260812164156.6bde8f4e@kernel.org>
 <20260813074007.3669651-1-wang.zhan@smartx.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260813074007.3669651-1-wang.zhan@smartx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 9:40 AM, Wang Zhan wrote:
>> Why are you sending this patch? Do you have an actual real life need
>> for unlocked get_drvinfo??
> 
> Yes. The use case is broader than unlocked get_drvinfo.
> 
> We are trying to reduce cases where ovs-vswitchd gets blocked waiting for
> the global RTNL lock. In production we saw ovs-vswitchd repeatedly report
> "Unreasonably long" poll intervals. Tracing showed one OVS operation waiting
> about 500 ms for RTNL while node-exporter was collecting the speed of an
> mlx5 interface. The node-exporter process was CPU quota throttled, which
> stretched that RTNL hold time; mlx5 can make this easier to hit because some
> queries go through firmware/mailbox paths.

I'd say this is more indicative of the issues in other places, like mlx5
driver.  IIRC, it can call synchronize_net under rtnl many times in a row
causing any other application that needs rtnl to stall.  We've seen this
behavior blocking OVS in ovn-kubernetes setups many times in the past few
years and it needs to be addressed in the driver.

While we could avoid rtnl here, it won't save us in other operations that
do require rtnl.

> netdev_linux_set_ol() is one OVS path that can take RTNL. With
> userspace-tso-enable, OVS uses this path to read ethtool feature information
> through ETHTOOL_GSSET_INFO, ETHTOOL_GSTRINGS and ETHTOOL_GFEATURES. For
> ovs-internal-port, these GET operations do not need RTNL, but currently take
> it because internal ports do not opt into per-device ops locking.

This doesn't sound right.  netdev_linux_set_ol() is only called if userspace
TSO is enabled, and that doesn't make much sense for the kernel datapath.
But also, userspace datapath doesn't create internal type devices, it creates
tap devices instead.  So, it doesn't look like a real use case, unless I'm
missing something.

All in all, the change itself may be fine, but I'm not sure it actually helps
with anything in a grand scheme of things.

Best regards, Ilya Maximets.
