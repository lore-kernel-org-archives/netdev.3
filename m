Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADC36A369
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401895; cv=none; b=W89dkm2VIGb3d0JL1RsvloI6jEnu0HhT7m96ZWRbHvE/hNQd4i/2VKKz03U8OZMu9KFXd+B9lqcewk1ykwR8LqLYydVaClRuhXwuusC2DU5odX5K4vLHUIkf1e/2QejPSy66ZrtR3eMnchpSOwaKF2fWcZGpyovyB9TtCenzbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401895; c=relaxed/simple;
	bh=Sgn87V/ffdQ0Mw2u0QtttnnD5720T1tTrgEBiXpaGcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe+wtmXu4uh0NMBiuSi1g+ykc6jk+vpwRQeL93u4hsKApG7RBnHeLsnhspnOuKD3sBnZa+a+tvTZs+8udmH27bc9ONEQoLknFSY9hIvPaXseM77ot+PKEmygTnoEGOx/9OlMp3O9f8wnfGN7vmCyiQmwrBHpv4L3qNvvRVlde1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XzkbyW0i; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="XzkbyW0i"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7cd09b36so341745e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1789401891; x=1790006691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c2e/oQkBlRuHGocwCZrcUxkwTAc0GxvFf1MGdOjknyk=;
        b=XzkbyW0iKKz9d9PcJHOTcSIob/MlbyKvGe+ZoDPvMtkwwmacU2JdDY9recjcpaOQ7h
         5pu6SGEDKVamOzoyR+0xkW8N66anfEntWbVcxiYwkM8tyJf36EwXrnJ+fqg3j1IlWu5T
         hHSyEymKM7mtizy6MSXOoBchAloasbUMrncWHzaxx5cz/+EAzDz6CHJwS9VmgKdcmKAO
         uLEqCPdAUabWxhA8fZ0JP3PxaN4Nll/7kth5HYohg+oVIlEeJ5UsmpuIWQ9sGXC3xIkL
         0dRzB1nPv4OX5eRhHsWkLbmh8YEryB41Yweu4EbesKuEwR60pHr2R9Og9BDskNmB7si3
         jAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401891; x=1790006691;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c2e/oQkBlRuHGocwCZrcUxkwTAc0GxvFf1MGdOjknyk=;
        b=B9eWoQ9sBbqqu5CVMktA2kX5Ff+5O5qT53uicQV8FsD7QlEycNjLs9UOu0o6cVDAwW
         ALkS8667LzcIx63/tOIKrhci6+vqaz0ijEVihkrKYkcf0BnS0G8F5K/Qw8JU4IWy6RTy
         2VjFhnolF6EbtVXgcMB7y8VhKJ+XaSPCWl6bqaYxDkfT1zITOJJixQDYzr8uVIOB4hec
         wGDhwvAzyC7XVgtGe2rEanYNmvmb76fMIDlsCaUiIXcgPjs0NhDvv7lotyxKKP6yVzWl
         1ltkfmUnn5medZwfLXGyIrTzpxVGcBLJDPjg76oKNnXCEjKu4PV1Bjx1Gt04IByaQj5h
         tjJg==
X-Forwarded-Encrypted: i=1; AKwUvBx0d/TrQg1SmxD+vTNKeJK1MB3821GshY4daR0A7Bbr0btSPt8Xk0srA5y/hlhX71n4YnpH/AA=@vger.kernel.org
X-Gm-Message-State: AFuF++n/lSnKzXadyW8gI2/Zsq4WxTSj5g7q1HiThCe3ZusXadsiywjP
	MnBIJ/1Q8PJ3HgcaNIFK2MNPzhIlU8D7B92Jz74SWxG1LCWHW7FyO/UwDwJreI4KYEY=
X-Gm-Gg: AYBFou1jxRSajQqt9njORRmjerxpSXzsFYEzZFP046SprFi3Okrj6dY0cbWNOHAsknb
	9ETdAEmy0l3Y7TkROzD2jqos1bPdfanrzu24mD9Di8p+St6K4JUsg283t/gitqtPHz8k4Rud3vN
	knA1/v63TGXI10Ko7ivjl+dkw1/trC8qdrJlSQjp16hZA021EMdcBo92wfgsm8AEOgp4LfAc8lP
	IF7xxM0001/pB2oJVP30Y+Bd7KcDUn8q4s7dE01mDBcp+T1XMGLXK3SYtXvNaTIaXGHJjuVC9po
	Pta9HAL0ymGI1yh2B8VmQkv4XRX9IM8u6pasiJ6PS/ZKreRMlV/0SAyg7+lVOih1DkgMIIOgoxn
	YCfy2q92CAhXMFmhYPyPwjhUFtsj2zlstAYqVIe68KggTJW8HVFHR1ehwZExUiF6IOHp1Ay+w4B
	H5qAba4pYdQuByC49xcuGPZFxFXclLrmnswyZwLJbjGDtS5FiYxJccv9pBsljbywPdjlA0jt4aZ
	Qq0doukvzx5mhRTs+KYRec5WUVZ1p12q9gj9UM4FCU+xHUFM0gl
X-Received: by 2002:a05:600c:19cf:b0:49d:1da4:511b with SMTP id 5b1f17b1804b1-49e7a6859e1mr35897685e9.1.1789401891025;
        Mon, 14 Sep 2026 09:04:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bed0sm28874405f8f.32.2026.09.14.09.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:04:50 -0700 (PDT)
Message-ID: <29afa1c3-b1db-4e98-9640-104251cdfa2e@6wind.com>
Date: Mon, 14 Sep 2026 18:04:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v5 4/4] selftests: net: test AF_PACKET multicast
 dumps
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260914014539.5015-1-sigefriedhyy@gmail.com>
 <20260914014539.5015-5-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260914014539.5015-5-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 14/09/2026 à 03:45, Yuyang Huang a écrit :
> Dump the link-layer multicast addresses of a dummy device and verify
> that ifa_index restricts the dump to that device, that the all-hosts
> address joined on link up is listed without IFA_F_GLOBAL, that an
> address added with SIOCADDMULTI is listed with IFA_F_GLOBAL and
> IFA_MC_USERS, and that IFA_TARGET_NETNSID dumps another netns. Skip
> when the kernel does not support AF_PACKET dumps.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
