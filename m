Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB62931DF
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666851; cv=none; b=DqB1uKLSeTviF6fXUn6EOPN1UeYNBVSNTsQKu6vZaQknmDWnso5HNHxyS6mydt0jhx9yB6p2Y0zFUrrU1hCJkXW7Pn2Gf/CLJkFo8/5IvUTlNe9waC3lUNbxsyUhwN7OVz0X34xM9xPeH98NoNbimV8VX4BN0BC/7kBiHZdNcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666851; c=relaxed/simple;
	bh=YUnuQ3f60a6YJ6RuLRBO7uNervaE3suJLbW3tGE6O/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpJt6TpYl2e6w4TMd7MAj9QorC4bqwg76uBm5RmUdHg5+JaBCCXIX+Sute+rpn9/D3zgqaxBmYk5FcFgqR4OHEPBKaAkYzb4upGntyrrjqnMqyGSY+lxiZ08/73wqJrFRpk+ncLsuHZel0RJBlCgwNci94Nqnc9F0oZh4RPRCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F920F8Tu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s/4OB0Xf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F920F8Tu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s/4OB0Xf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790666848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQ/tY3rlz38Kq4kzlU+21ckry9QDtD0DJmT9dp5jInA=;
	b=F920F8Tupb0zAARfmSbUKFYJ+H0akRh1jo4Xl53mtAsyUEX+qRRXl1FCXH5VH90fm4MZFM
	wO8gRQHcPtrkPSqNuijfXYquKfg/kWu1XCRt+67bjNTyp1W9ouu0e1hDRRGVVBvDzk1sJE
	P5pdaHI4pqEVUrN3hdgKPSIplExuG+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-dS6svpMvM7ayRPHGoenyKw-1; Tue, 29 Sep 2026 03:27:26 -0400
X-MC-Unique: dS6svpMvM7ayRPHGoenyKw-1
X-Mimecast-MFC-AGG-ID: dS6svpMvM7ayRPHGoenyKw_1790666845
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6683d48fso41253095e9.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790666845; x=1791271645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQ/tY3rlz38Kq4kzlU+21ckry9QDtD0DJmT9dp5jInA=;
        b=s/4OB0Xfz472z6xGx0BdRiA71rHZFs530+ceqdvTig/W2BVfc5xFofSBokrfvAYXJ2
         DHylERjl6m+eSCp5wnE7ofZ6xCInwmJBbW6STWol4VAA343loePVqe9CRQHvd0IJBtpu
         8uEu1twR5RMLjh3tpMvEd7ou8h70Ky68frqT+MelwUaAO4Zo3yJghxoWaGoI56MDu84h
         cP5hKfhscNxUSRx7KdKrHSSBWDlSqAs2Q8qbm3ftFobf3U0k0xMOcYiDtafNRDSLuLBj
         NKKgAxgtEYlyM8rxd+1NcxlWhNW2PnnGVYev9EnZUcTIm4PT8c6rQXT/S/Mfj6LtTtBY
         LT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666845; x=1791271645;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wQ/tY3rlz38Kq4kzlU+21ckry9QDtD0DJmT9dp5jInA=;
        b=Kxn4a93StaVelcA45wqqb2aM2TND1E3uTdJYVzyek/sNibAONU8f7IJiNq5ISD4BLW
         H6jZIsSdwvU+H3jZO709iYh53Shq9AoLjvKOqt8g19YVqE6dS2LiNakGV4uuukpn4tnV
         oRxEOcDJY73pGUDXnTYvEPZLVtX+MQNpGUDG49YPqrPn7qwmpDUId0DWzMC//8Dqk83i
         Z2GmasWZ2MIEmGGf98528iPUM9wLiLAMTTsilN0AJM1tNEoiRXV3pKC5eNWGsjSCKOAM
         eAj7nZ8wSvWzbupTpjJGe0wO1CNS8M7k5DWGOL+bPxSYeIVLIUHf74NLxDHSIA5p9KLl
         GZlg==
X-Forwarded-Encrypted: i=1; AKwUvBxT206zfLIx6F1FzoAENk7wYl/KMePjElVN/Ci41/Jz/PxUyiOlwFIGjL41MIzP9oZnSDMKijw=@vger.kernel.org
X-Gm-Message-State: AFuF++mf5YoRNzqjIhiSeEs9kEPHmKKFYnrFIlqK4aUrt95xHOy2FAGY
	TiSl8yFfBKSG5GXfCnGQOZLqISz5g+LzDnNnyVF5vPXr/Bt9kJsOnRHq1mV2Wmtg6VYvXBl+Y+Z
	Y6oMN7s8Jy4NyzGMbxrFIX7igUYz/yLDTlVI72F6/TXvLX4NPT8Yb5AZT3A==
X-Gm-Gg: AYBFou3lpBNicn66ynBCS4uxkKp4fnfTNgljadYQEC4i5f+gXp75AHwCAk2KTo6PogX
	rae3N38iieCex9oGPCUVWesl9nzWl5yB4ME4gWyjN+pflc4igNk43Uu3tSdJUQWitEEqKyRdhK/
	Zp+eLfPOwXN9iTLEytnpMXAKmXWn2j908Kubb1N340pPKLCSA8XcOLNzHQeJ4CZvp0Ntu1xxiFl
	QtQVtMuKAXIprlH2uKURqK6xqzLL9LmBCGQCSP60Sp13M9vUP1kUsO4L3UyFymAmfWQjqqIesv/
	FjB9rvtg9Uo6KwXg/uVYueL4O6kzqrJCEgX2YW+mxfybZ6cK1x/Q4Bp9fgeNanXtG+z83/3Ih5i
	RPWLmDM3AyY44THaMXQl9ABx8gGYCOvNzhsuNUS056kje/C+3OmC2pPu428OaAtVZXkgSJpneOw
	==
X-Received: by 2002:a05:600c:1d02:b0:49f:fd66:5fe0 with SMTP id 5b1f17b1804b1-49ffd6661a7mr152517795e9.9.1790666844852;
        Tue, 29 Sep 2026 00:27:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1d02:b0:49f:fd66:5fe0 with SMTP id 5b1f17b1804b1-49ffd6661a7mr152516865e9.9.1790666844132;
        Tue, 29 Sep 2026 00:27:24 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfe13a1sm55373795e9.5.2026.09.29.00.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:27:23 -0700 (PDT)
Message-ID: <4457183f-a9ec-42f4-89a0-7a3e8e6c5140@redhat.com>
Date: Tue, 29 Sep 2026 09:27:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/5] net: resegment oversized TCP GSO skbs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Wang Zhan <wang.zhan@smartx.com>, netdev-bot+sinfo@kernel.org,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, keyong.sun@smartx.com, Jason Wang <jasowangio@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org, Daniel Borkmann <daniel@iogearbox.net>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Alice Mikityanska <alice@isovalent.com>,
 David Laight <david.laight.linux@gmail.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <179057071651.31693.213200671694715782@kernel.org>
 <20260928054920.1434795-1-wang.zhan@smartx.com>
 <willemdebruijn.kernel.39a32e51cb66d@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <willemdebruijn.kernel.39a32e51cb66d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/26 01:34, Willem de Bruijn wrote:
> Wang Zhan wrote:
>> On Mon, 28 Sep 2026 04:45:18 +0000 netdev-bot+sinfo@kernel.org wrote:
>>> This is an automated message. This series looks like a fix, but its
>>> commit messages seem to be missing some information:
>>>
>>>   - How the issue was discovered, e.g. hit in production, hit during
>>>     development, syzbot report, manual code inspection, LLM or static
>>>     analysis tool scan.
>>>
>>>   - Whether the issue was actually triggered, or is only theoretical
>>>     (e.g. found by code inspection). If it was triggered please include
>>>     the symptoms, like the stack trace or error messages.
>>
>> Only 1/5 carries a Fixes tag; the rest is new feature work.  1/5 was found
>> by code inspection while writing the resegmentation path, and it is covered
>> by the KUnit case gso_test_tcp_limit_l3_proto() in 5/5, which fails on the
>> unpatched tree: a tagged IPv6 frame is measured against the IPv4 limit and
>> segmented although the device could send it as one TSO frame, no crash.
> 
> If 1/5 fixes a bug that is reachable today (does it?) then it needs to
> go to net on its own.

FTR I don't think patch 1/5 is stable material: I would keep it in this
series stripping the fixes tag.

/P

