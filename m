Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666483;
	b=mYhxTEhY4mkoGGcVd8o4WdUUSy/4QwMesZHPCX6uJ7CEtZTOpjBtW8biSnhP/BdiGkZN
	 9H7KEYCVF5rPL4VjwhNtV5Dy/rVumQ6WA+ldIs/rWx2uhG2tI7LhQmh2itshF32SZQFWH
	 M2C6ZSohvD4RUAaud2kIUrf+jn8Tf/bIOHlb9Ugk0VvhxfSuQRSqAWXlAmQ0Ttz5NnnK5
	 9FUDrqFSbSrVlA6cKiUjxGcJcL4WpLoUOITfN4bqynL+BJdF8yRbkNi0NSJmv01Tb7SQq
	 mXN/mh+5tKw7bqgiYM21IN5OWqGBNTgQNYyDkddTAndHFDb/aRwO2H9wp++Wbcl4hLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666483;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
	b=09ERXrR5VBlbNIhlgbYeqdb9WbY9a8VCY04ZrPobgPq7gJcdgH1biU9HjukAdwWKYUzi
	 B5cbK5hB+y1FhWtRqzE+YiRBRlUAVWYkFSwGa/cpcpD8dMJ+VKadmyABHnev0QuUID0hQ
	 OjhI0o3R+0SwyYo/8Lvjkozq5wMtZiJC/pJ2U6gyY3SM4Gs2gu9adv8nA1t3A5s2hOUFc
	 wzTOrUJVtFU7roziJH9st0effOOWkSgw1dwlevfOLy/9liSEa4xuIAVnlg35Kl8EOhXPy
	 FIN1Hk3Lht5WUD38WWStSTZHNudA3vdr5RQLdJureDnqH0sTip8/1QD2Q0690BsFPPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBX3mvG7;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y9wiS6va;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB1606A33F
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BAB1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LBX3mvG7;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y9wiS6va
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792666481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
	b=LBX3mvG7g7OyDDbsLQCriwcr5hbcMKhb9N8o9PFxwac6tQAEhVUQyupVoE2DY44uxIICPc
	Zk4qm/4AyKxw2MXbwAcGa3upY0dDM22i0DfdmfDkNuG6gHepTvzCxUBPISbQi5J3fNHlSL
	qIN34D6wg7CRp7U0R0Tpawqoql9/yWs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-a_LcQE1NNPK-vTpeYxa2pQ-1; Thu, 22 Oct 2026 10:54:40 +0000
X-MC-Unique: a_LcQE1NNPK-vTpeYxa2pQ-1
X-Mimecast-MFC-AGG-ID: a_LcQE1NNPK-vTpeYxa2pQ_1792666479
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e011829easo1199759f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792666479; x=1793271279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
        b=Y9wiS6vaFVrz3SOJ3vWMnVepwefZPmmzv5KVC6o63au9Sd3K/FYAeGDPQDdbBUT9m0
         jj05j8d0qE+ClJ/rcmCtHLR3ArC1Vz18I6kKMWW43tAqocpoT6wGfd2ekdf5HVhgnqiV
         OCk5tqL8FNUSdDYZxTeMg1wMq3mjEiKwUkTFTjINkcJuhaovO5DtDtf54LRKSc0EQlPA
         HkSrQlINBD1xc5kS44zKEKAIeCGFKm3WYH5xawoH1C0on+wAqG92a3QrONm6aKx3Dq85
         uEYCBu0Wx1TfKWeNpMIQDyrHVxGqdACTvn5tol5e4pILgTyOy2rCv8rmtLloH95mVMTn
         B2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666479; x=1793271279;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
        b=LgmkEU0yUkRoNzfDtTK8SP+ltyJEhnqIkPwOR/UqIGy07XEeF9XZlCXqX+Sk29TX2u
         vxM3wbT/CxPB5QKHQv6n3WQorj6xtWsH0fpAz688epssDk/NkOZDl/LoLauqlEiafyd9
         rD3lLPn0sXynDFViivoR0QJhYYjk1eyA0meO+iMNuZoAW5ru9mHOMSXfMymcXw80h5Cj
         McPVNedV+FKzPVHOEq1HxiulyAZHXxyvvd4gXR7kUYQduVrourTUblZLFSqgzJXuniBN
         5WulaMz5f4yamK1PdWclNuP/LYgQJuIHryB3shEM9F0SDP1N58MGP0FNvzdciQ4KtHkO
         Ue1g==
X-Forwarded-Encrypted: i=1; AKwUvBzHse1N6DpcD0GfKLpJy78tmq5Ifb5xVrLG8QjpvfdoqhrxTAUZB57Udqcy2SB1DnxC/1++abE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJo0tMZukQ8o+GwdMNbmzwZN7I1moigvR4/uu99jnqUeZ133SAe
	XXY08UUELdNUhz9ctdz/HxJ7fRfdmwi/f2Mu5DqM3ixvHHkbmfxMRqEAeh59fMql8+a58W9P/6T
	JOe0/4HiBpo6Q0p3ZXhpxUQCntqMwEXRiE1oxVOLddjxgfA58cpXtc69AfQ==
X-Gm-Gg: AYBFou1yLFA2EOsKjYzozIek1l0UtP8AWwTt5BaN0u1rbUAO5jcP1gkikVdOimZc4KX
	rOIlWxrmhTSQlRyxOP1WULMVbao6M+V6G5Ng4K6F50HjDXl7Iq8LQmB+3dnPFi1SV23IdZ+P+68
	ySqfU9bWVvmPzCwRCujYZ+Rl0YeZqqCqj7uv76oyLwXXj9tt7m4ROvH6x4WSWt1gd6po0XvqAJq
	kxQTDLqYJpW7dFkWZxtzA91L+6bDECVkuv61TEGmJIw4i9vgC2u9OHOhElE5DhmvWtMbRuEJGzV
	SqMsmG4iSGE6L32eOs/9QQ0kffHJyziizZXIYMTM2rnAFXDwHwxWJprWbifDs3a2KeFN9IHXzQ=
	=
X-Received: by 2002:a05:600c:c4a1:b0:4a1:f0bc:90b with SMTP id 5b1f17b1804b1-4a1fdd3d407mr99476215e9.29.1792666479363;
        Thu, 22 Oct 2026 03:54:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a1:b0:4a1:f0bc:90b with SMTP id 5b1f17b1804b1-4a1fdd3d407mr99475815e9.29.1792666478965;
        Thu, 22 Oct 2026 03:54:38 -0700 (PDT)
Received: from [192.168.2.75] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f02f1sm12856807f8f.3.2026.10.22.03.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:54:38 -0700 (PDT)
Message-ID: <8b9bc610-777b-4436-98a6-2428153cc5f2@redhat.com>
Date: Thu, 22 Oct 2026 12:54:36 +0200
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
Subject: Re: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
 ndo_setup_tc
Content-Language: en-US
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Ertman, David M" <david.m.ertman@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 "Maziarz, Kamil" <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 "Schmidt, Michal" <mschmidt@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-4-poros@redhat.com>
 <CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/26 1:22 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Petr Oros <poros@redhat.com>
>> Sent: Monday, October 19, 2026 8:53 AM
>> To: netdev@vger.kernel.org
>> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S . Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Ertman, David M <david.m.ertman@intel.com>; Shiraz
>> Saleem <shiraz.saleem@intel.com>; Leon Romanovsky <leon@kernel.org>;
>> Maziarz, Kamil <kamil.maziarz@intel.com>; Rafal Rogalski
>> <rafalx.rogalski@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; Schmidt, Michal <mschmidt@redhat.com>;
>> linux-rdma@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Sebastian Andrzej
>> Siewior <bigeasy@linutronix.de>; Clark Williams <clrkwllms@kernel.org>;
>> Steven Rostedt <rostedt@goodmis.org>; Mateusz Palczewski
>> <mateusz.palczewski@intel.com>; linux-rt-devel@lists.linux.dev
>> Subject: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
>> ndo_setup_tc
>>
>> The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
>> device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
>> runs with the RTNL lock held. This closes the same cycle against the
>> RDMA auxiliary probe as the two preceding patches.
>>
>> Use device_trylock() and report the device as busy when it fails, with a
>> distinct message for the same reason as in the previous patch.
>>
>> Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index edb62606d2aae3..7b251136149615 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -9448,7 +9448,11 @@ ice_setup_tc(struct net_device *netdev, enum
>> tc_setup_type type,
>>   		cdev = pf->cdev_info;
>>   		if (cdev && cdev->adev) {
>>   			mutex_lock(&pf->adev_mutex);
>> -			device_lock(&cdev->adev->dev);
>> +			if (!device_trylock(&cdev->adev->dev)) {
>> +				mutex_unlock(&pf->adev_mutex);
>> +				netdev_dbg(netdev, "RDMA auxiliary device is
>> busy, try again\n");
>> +				return -EBUSY;
> You return error here, but it looks like being silently dropped in mqprio_disable_offload() isn't it ?

Yes, mqprio_disable_offload() ignores it, the same as it ignores the
existing -EBUSY for a bound RDMA driver. Blocking there brings the
deadlock back and skipping the lock races with the probe, so v2 keeps
the refusal and warns about it instead of netdev_dbg().

> 
>> +			}
>>   			locked = true;
>>   			if (cdev->adev->dev.driver) {
>>   				netdev_err(netdev, "Cannot change qdisc when
>> RDMA is active\n");
>> --
>> 2.56.0
> 

