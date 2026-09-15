Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938C36F8E4
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457950; cv=none; b=BAjjRTToL6YEtAAQZMzhopoixzMgmD/F0rfCuE3I7+92wWCxrBE/yl2Wns1PPFjCS1m3HRVdfoMkepyZw8HIYKYD18fSnVmI3agaj0b5Z9drqmv4u4McSBI31svIExmDSsgf05vimVnUJWV834hAfD4tI/jmJixAJz7gS7G58hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457950; c=relaxed/simple;
	bh=qyYfv3enHRq5IMe/KzahdweJnTP5IJtu1/rK0ps4Uwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvQexWDd8OjccJAVxjQ4dsaoNEtSxM+CR0mI/S/r8l2ffWMlfdcub8QShGB6hjQlG72CaurxOBKaSWDrZdEY4EnW9pLMKYucXa0eO4Jq/OTM3hMlBCXORuA34C0nVrNp7NXnnch3R/fPzdEGhYPrJS2nlYP0vsatzO1PoYnQ610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=rgkP6Wjj; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="rgkP6Wjj"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-39dba377357so1754422a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789457946; x=1790062746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Puyr1CggCCaTQw9Yk4E9k5Dv02B8mldFu/PYs2omafM=;
        b=rgkP6WjjdUnAt831SL8C0E4Z/wkeCRvKEU4xmKUnGZElKK5KqTOEt1U9bK8M1BDFpL
         yVAXHmzm3SipYgZHxJvJKRe8PWVIwwxdANkk/jVLMQLWMzmidUmoyHwMEQVMw/kXcSjr
         pvhXO8piB1ZCWdcvJrpatSQpAQQzumMKuTSk2vbE1sjULOUS0ckd5PHzzanBIMpGPZ0J
         DtaqO++N7UQXoDAMSGBpTbJ7y90ZD5cQ2S6zxBosZBPZOty3jhvmkHBjhW3SP6MEuW15
         FbEaWyo9PiORpRqO5BZMvBSyxMad/fdpgg/7sI7qKlZCt6sbJv4wbKNIioh76sHs9553
         Kchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789457946; x=1790062746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Puyr1CggCCaTQw9Yk4E9k5Dv02B8mldFu/PYs2omafM=;
        b=r/PcK1207u/fyfr/osPPre0Q1/No2Vkd3Sv+9bwn+/VGhBnMZyRyund7hhPk8hXA9M
         fim9K2UsIqEAMhMcH2SHjk2huEHgPDx5ezeHEFHpHxrEcX8KUOH1x5DMNi/C3pq1m+uR
         UQo2S6zxh6QzJQuhpe4n+qqd1H/jNK2TF1Syt+a6pkVXLKmM0Nb9zPAT/67i9g32nkB/
         g1MvlzzfEs/y4qMMohmsFn8Kvw4Of4Ha5k/+AWQENZQmxpoX1o9G9+S0ETRkxtPsKI6Z
         +8ii5iEuRUg7i1GVamPzFVmULtAxrMb5h1nJA6j7vZ/0Y8pWiMSgsmosf86SpoDlZ5IS
         MuDQ==
X-Gm-Message-State: AFuF++ltD6uZjIy3T/8DIrX1LaAqYlxglEm4g+0CfDvwO1sX/WOKGYUE
	AerQF3aMBFCa652yNAx9c6JCw7nddFU6z6kKbN74rCjps+Pc2qhrSb9lrE2Qosy4py5t4AbseID
	xI5IlYXMqFjRIWNWaDeWlLb+kEngFjM7R9kBRrI2748PTFwyz/BPO5gdXUZ8hgHxHlOy9AsLo0j
	LXImyf
X-Gm-Gg: AYBFou3nnJQkmfuh13XvcQRrctqpjqrE1RrpkG96OR1X3RHa8eRe6E8mvnDIAlougi8
	YhnEudGQ4kwxepYDULSEwj513Gi8h7pUGVXuB0bldxYQD1tezidYez5hEZvAZnQqu68FvoN68CB
	jZTRWyjEnuOE2H7Uc6w2uUN++QHxiAGKVRVHs322AopN2+7KlAEIZ8X1RYZ4/7Mh1MkaDZBvqbT
	dv141y5cIBtL5tGwridZfD1suakPoz852o26jOKYlzoiZFi8+W4ewmUQyh+u9DX+SafpKUUNtLJ
	HdAWu57oLm6hU9D0IdBU4CsEA7GY+X85Iit09ZgymJhtwrDsjeG834umrtkZmTnJ3hOgTEPqVd+
	qUbzcEAf6fKZrKY2GvxKETJLAXpTc5z4D6aqqQmZWJDZ5KA9HsEy4EQaXDW1qFgBxpYm4Vz9tB5
	73P9oUIVwrPFXUTuxL98E4BVbDohKY7PAq3oISLsnSdSp7qWxgfhaGVOj+dv3bqGfiHCDjY2QuH
	qWgMWw9NS8TFarj6K/RJ5g=
X-Received: by 2002:a17:90b:440b:b0:39d:e784:3e1c with SMTP id 98e67ed59e1d1-39dec0f7193mr12889359a91.19.1789457945782;
        Tue, 15 Sep 2026 00:39:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm31160473c88.3.2026.09.15.00.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:39:05 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Wang Zhan <wang.zhan@smartx.com>
Subject: Re: [PATCH net-next] openvswitch: raise internal port TSO limit
Date: Tue, 15 Sep 2026 15:38:48 +0800
Message-ID: <20260915073848.1263154-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <bceb850c-dfbd-4fbd-af85-e764bdacb6aa@ovn.org>
References: <20260910131635.780802-1-wang.zhan@smartx.com> <bceb850c-dfbd-4fbd-af85-e764bdacb6aa@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/14/26 11:16 PM, Ilya Maximets wrote:
> On 9/10/26 3:16 PM, Wang Zhan wrote:
>> Set the internal port TSO limit to GSO_MAX_SIZE (512 KB), as for
>> loopback and veth. This allows the admin/user to set a GSO limit up to
>> this value, to use BIG TCP for traffic routed through the internal port.
>>
>> Only the capability limit changes: the IPv4 and IPv6 GSO and GRO limits
>> remain at 64 KiB until changed by the administrator.
>>
>> Validation used a same-host test with a temporary OVS bridge, a veth pair,
>> and a network namespace:
>>
>>   TCP client -> OVS internal -> OVS bridge -> veth -> TCP server
>>
>> The veth endpoints were BIG TCP capable throughout the test, and only the
>> OVS internal port limits changed between 64 KiB and 524280 bytes. A single
>> iperf3 3.19 TCP flow, run separately over IPv4 and IPv6 with six
>> alternating runs per state (`-t 15 -O 5`, fixed CPU affinity and port
>> tuple), increased throughput by 18.1% for IPv4 and 34.7% for IPv6:
>>
>>   protocol  BIG TCP off  BIG TCP on   CV off / on
>>   TCP/IPv4  65.567 Gbps  77.420 Gbps  1.12% / 0.37%
>>   TCP/IPv6  55.355 Gbps  74.568 Gbps  1.20% / 0.68%
>>
>> Assisted-by: LLM
>
> This looks a bit strange.

Do you mean the "Assisted-by: LLM" tag? I used AI assistance for
building, testing, and patch preparation, so I added the tag following:
https://docs.kernel.org/process/coding-assistants.html#attribution

> Please, add an empty line here, it looks awkward to glue the call
> to the feature flags block.
>
>> +	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);

Okay, will fix in v2.

> The packets will be segmented before sending to userspace or ports that
> do not support BIG TCP and all the functions that check the packet length
> supposed to use gso_size and not the raw length.

Right, and that's mostly fine. There is one catch though: when a BIG TCP
packet goes to a port without BIG TCP support, it currently gets segmented
to MTU and the GSO flag is dropped, which can regress performance pretty
badly. I'm preparing a follow-up patch to segment to the target GSO size
instead. Not a blocker for this patch.

> But, please, CC all the maintainers while sending patches.

Okay, will do.

Thanks for the review.

Best regards, Wang Zhan.
