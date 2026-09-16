Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D094CB8D7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557156; cv=none; b=ftG9JlwdB7nmQ0Cz++aB9DJzRS3ZIFxVwWzoTjNTIl38ydxW42ebS3RL3j1gEJgwSPqPW5l/TRx3RkQmDh0WUthDGbH8H2IXxhSjxVlyS8N9cOnRsoBkYgnvleTKUW1pOTIrlZRAdNqMp9oYuB1wlbd3losJsGtPqS5lygQ0XEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557156; c=relaxed/simple;
	bh=qMHs98b+lVyCyWf1Q4DpkaJQOn+HVVXoxcEPhmY7mKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qd66QFwpXaRzbtT+8m2W7NLMU5hloN+GS53jAGMM0TIUkey231Hh+WDl4cxD9mqOwVMHqoGiRlw1ENtMDgTUpvQGCyp5tdjkAyLPFd9QofIhgSxifoeprK2/sIS0RMH9SZWrLlCSCxh7HsUm1xgPUHt09vnkHttOw+bpXEjRUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoAGvj7m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMjDytaM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoAGvj7m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMjDytaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789557134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeaJ5Y5/oBBIkCxBW+vtdLO7jvDiY+4qR7G8oQAbdE8=;
	b=SoAGvj7mP5QhecpmEWFqLvwCPW+ry+OYc+SBzK4hofCecN44j3uZ3+E3FquzD9AFMW/NhW
	Xh5UVtOQKxxxR3OYloII+FAs5faDJTRmVec9HQQLaYZtH3li4Kgpfvcr6vVV0AGhOtmdiq
	8tFEs4SXTp6Gs3SEPPxWeycWY+qdGCY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-r8OVm-toPDKCDCT7aajgFA-1; Wed, 16 Sep 2026 07:12:12 -0400
X-MC-Unique: r8OVm-toPDKCDCT7aajgFA-1
X-Mimecast-MFC-AGG-ID: r8OVm-toPDKCDCT7aajgFA_1789557131
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c29959eb71fso377909866b.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789557131; x=1790161931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GeaJ5Y5/oBBIkCxBW+vtdLO7jvDiY+4qR7G8oQAbdE8=;
        b=UMjDytaMoyE0KSDPwum95ZMcMokHVQZ1JhweXasyKEMpx3I+IZaFC1VC1AGADggUKB
         sdHb203Lb3V+9khmuvtGv+xVEmhVjZaWG5ecvQV7V3Bp48LX3mXvPpqsGHeqcfuwg8Nb
         Gnr6u1L98WsNK7weyY7IByq/Vv+xVCOBSwbv7E8pfb7iwuJM9p8eQSFhTLjRi0d7e0Jy
         V096mM0k6u9Tadp04fj8Py/4mNsZTz5sbMBzMILdszy6rjOtqmoVN8ZIqRgTdi/tIbj4
         2WuBCt69XhjnLnypG7LCm/SrsBlvYUHMrxsnziEJVka9qyDYQ5Ae70Hnfdobt/vRwEyH
         YHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789557131; x=1790161931;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GeaJ5Y5/oBBIkCxBW+vtdLO7jvDiY+4qR7G8oQAbdE8=;
        b=shm85fBWCJuR3lYGkhrI4xz5a0cm0gnhkSRWfjwFCr4zJrvgBWAdsenEcf9ENUTcXW
         4QeX1/5RlXe7dmqZ2EWPI2M161wilyYlZ0D6ZYSOU+1H4wuWTyrjFOLIVFwnJ3ipRvvz
         YwThknE0cSO0UsmlfPcmzKDlWV40gzmzAQwwdJTGXimnaveHxIUh5S4VHcW7X+sLbrb2
         +UGo1mdED/fbkJD1eMVxgw/ziOEmmLaylNIURDn4BmZUElPYce1uFEveOjrU8snb/ykA
         9J1lwD7NMw6cq92RqH1ewQOLQVzgRRFVlIrO7YzXy3oZKYdATH5o+RalD2ugMILlcI1M
         Gr9A==
X-Forwarded-Encrypted: i=1; AKwUvBwTNXT63V9yXs3BqFAr5emZ07d/ZttRLFMS0JwydO5fF/PGozsYsArykvxyauEQfaaRD4jqEOU=@vger.kernel.org
X-Gm-Message-State: AFuF++kmvW21UbNP+QX8sHsZGHPoW7v5iAzVAVO4x/YFlHKlgz1c7sv4
	gDo7hXQqIFH0YTZmnLnYTYlYzHOu0P7O9iClo3nrRGEa+oGiI51sfBfXpIvPA3Gh/O3x43Roxf3
	z90EQ8FydICZjeKEm8kHulVLuxTeaeJDIt7877YF4HVhPNfJbtvRZhfmq6g==
X-Gm-Gg: AYBFou2VkKjxSYcNS1qp4yHz9KORVcfuaRZxOzTwiVJcPqW7EVGxcYGSg8EL3s9NDt/
	HsvI/SHns3q+w5eifw176NqLtX+Bn52isGHvaHLJoCtKPVIciwk/joArGz+BB9aSQcmpKznkcc6
	nzXoiEGuHElqCXXk8sg3tCwDT5TzTfpjIotRvQGYLKw1+IOXRj7HAlSbufE4zg6mys8AieAQEqf
	K2xlPK8QFRC1qcMTb0vtJiuccMJjI2cWKLu7OHx/VRJyaq8oueJkQVSdbBGE9w1Dha0WO9vHfqq
	qHJVlY+RSYsQoGMHSjw2F9i/iAoqvci6V7gT8gUoUAOujLlGcWU5H/t2X6br2Mjp/+q++8Vrp2M
	+A9Ypjq5YC8/6AQgrQPOBjHHdwEt8lupsF3p04mOkdjGQl+LU
X-Received: by 2002:a17:907:9707:b0:c29:3b7e:3a94 with SMTP id a640c23a62f3a-c29e5308b18mr138254966b.38.1789557131318;
        Wed, 16 Sep 2026 04:12:11 -0700 (PDT)
X-Received: by 2002:a17:907:9707:b0:c29:3b7e:3a94 with SMTP id a640c23a62f3a-c29e5308b18mr138250766b.38.1789557130755;
        Wed, 16 Sep 2026 04:12:10 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de48755asm114171666b.24.2026.09.16.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 04:12:10 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Wang Zhan <wang.zhan@smartx.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, keyong.sun@smartx.com, Aaron Conole <aconole@redhat.com>,
 dev@openvswitch.org
Subject: Re: [PATCH net-next v2] openvswitch: raise internal port TSO limit
Date: Wed, 16 Sep 2026 13:12:09 +0200
X-Mailer: MailMate (3.0r7032)
Message-ID: <672C72AA-AAA3-498D-8233-00643B563CA7@redhat.com>
In-Reply-To: <d92e90d0-437a-45eb-9803-726bf7c088dc@ovn.org>
References: <20260916065844.1380155-1-wang.zhan@smartx.com>
 <C381651A-DA84-442F-8F75-577946A0E437@redhat.com>
 <d92e90d0-437a-45eb-9803-726bf7c088dc@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow



On 16 Sep 2026, at 11:49, Ilya Maximets wrote:

> On 9/16/26 11:37 AM, Eelco Chaudron wrote:
>>
>>
>> On 16 Sep 2026, at 8:58, Wang Zhan wrote:
>>
>>> Set the internal port TSO limit to GSO_MAX_SIZE (512 KB), as for
>>> loopback and veth. This allows the admin/user to set a GSO limit up t=
o
>>> this value, to use BIG TCP for traffic routed through the internal po=
rt.
>>>
>>> Only the capability limit changes: the IPv4 and IPv6 GSO and GRO limi=
ts
>>> remain at 64 KiB until changed by the administrator.
>>>
>>> Validation used a same-host test with a temporary OVS bridge, a veth =
pair,
>>> and a network namespace:
>>>
>>>   TCP client -> OVS internal -> OVS bridge -> veth -> TCP server
>>>
>>> The veth endpoints were BIG TCP capable throughout the test, and only=
 the
>>> OVS internal port limits changed between 64 KiB and 524280 bytes. A s=
ingle
>>> iperf3 3.19 TCP flow, run separately over IPv4 and IPv6 with six
>>> alternating runs per state (`-t 15 -O 5`, fixed CPU affinity and port=

>>> tuple), increased throughput by 18.1% for IPv4 and 34.7% for IPv6:
>>>
>>>   protocol  BIG TCP off  BIG TCP on   CV off / on
>>>   TCP/IPv4  65.567 Gbps  77.420 Gbps  1.12% / 0.37%
>>>   TCP/IPv6  55.355 Gbps  74.568 Gbps  1.20% / 0.68%
>>>
>>> Assisted-by: LLM
>>
>> I think Ilya already mentioned this earlier, but the LLM tag means you=
 need to
>> fill in the LLM model name you used.
>
> It looks like the rules changed recently, see:
>   816d9992d9ed ("coding-assistants: simplify attribution")
>
> So that's just a new acceptable format, which is fine.

Ok, missed that change :( So with that

Reviewed-by:  Eelco Chaudron <echaudro@redhat.com>

>>
>> The rest looks good to me.
>>
>> //Eelco
>>
>>> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
>>> ---
>>>
>>> v2:
>>> - add an empty line before netif_set_tso_max_size()
>>> - rebase net-next/main
>>> - cc all the maintainers
>>> v1: https://lore.kernel.org/20260910131635.780802-1-wang.zhan@smartx.=
com/
>>>
>>> ---
>>>  net/openvswitch/vport-internal_dev.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/v=
port-internal_dev.c
>>> index 125d310871e93..77a16d5ebd543 100644
>>> --- a/net/openvswitch/vport-internal_dev.c
>>> +++ b/net/openvswitch/vport-internal_dev.c
>>> @@ -117,6 +117,8 @@ static void do_setup(struct net_device *netdev)
>>>  	netdev->features |=3D NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STA=
G_TX;
>>>  	netdev->hw_features =3D netdev->features;
>>>
>>> +	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
>>> +
>>>  	eth_hw_addr_random(netdev);
>>>  }
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

