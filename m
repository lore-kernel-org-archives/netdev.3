Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288691;
	b=rQIQqaZ+8GtTR4qYyTwkxzWCO8Yt3ukvoS34i5W6WGJDW/ZFKY9Dm2jQnOk0Ok8AbuHB
	 f00BSeoWvmWOrshpH+kF6Ma2SVMdJ6jiMIk30neyauqKoY+lsxmui+QfSw9h9iChH2CuC
	 KIb3kKteTf4+qBUBd8B9gpVWHVuE2SJAHvfgZlEO4OxHRKI2yWSWuw+X3nw9KZ3fHhqu9
	 LudRlZ5tiob+Ss27Yn/NC0wvo1qh4qnAG4oKTsyUf7/03Gauop9LhW448L8XT9OjFT415
	 lIEcj6PiQTQYDF4i8cQWWlahIlWEKvBFZmNA5NU5zGd8Vx7Ob29gzOp+OcDyxf3ucxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ER2y3dWOiovf6F9A0olmy29Jmgyf+6P1MJIOyxbksLA=;
	b=KVBxahwnujYtDQJfwHt/tcxpByg0UrQZ+9Y50N/KfT9Mr7WtTl0HQMYLL1qNkT/9nRlv
	 sw85tlIWTrBWQNMXePo8daAYH8eApcWDLZmGTxv6F8J9KU29V1Zl+ZeS2I6Xcm6cbgNfj
	 x+KLx3VLRk2pBVHFmNL0Aa8pF+5Oj1TOxSmMpIpHDorb4l2H/201ZJtMQv+kkLkOdSDuf
	 s2Sr0l+t+sds4eAMYRBCBYUZR+Ka5K0UN65jd1USfEOWkI3ZpDawjpJMt40AUi6APF0ZS
	 asT95f05cvEIi8tYsuYwU/hBBlo6YsJFcG8Fs3vp7MpCFbEEZnJ3pHax6UIu1AcFw+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=AAAbxfPh;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C7606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 537C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=AAAbxfPh
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6aa046a99c6so472689a12.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1793288689; x=1793893489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ER2y3dWOiovf6F9A0olmy29Jmgyf+6P1MJIOyxbksLA=;
        b=AAAbxfPhwUsSIjVYyAQzQSjlJ7yc1F3sIQgkiBFKAsay2Tcm9cwzgM3Ny8yfdbgk9M
         xzlbNBpCU2dDDYGzdNmuEyG+Ek8Y5S2kwTx8KutOTRPVS86HQJ3sjdUEOVtL4oerk7+x
         aK6gMgohcgc9N3Fgli/cu3wRNdy3JZl5Na9hah/kCJgtTp8UB79m47q0ghWGrBekgwia
         EWIA0XAdSxJEHNtAt8AlpfSNBApmAwh2/85CP6Z8WR+c7n+iyPawHnk9/T1RtPi/Ef30
         7t9qg5UdYWne77oM5GenAUaIXi+w/6/fcsVIkycsZPFoomGif76NlMRD5P8gxEGzZ7lz
         JEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288689; x=1793893489;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ER2y3dWOiovf6F9A0olmy29Jmgyf+6P1MJIOyxbksLA=;
        b=roIivFnWrfNrwgf5FoN+9AaRnKG+xM1xsGstrHFDyZBD/uLFQ3H8rnk82N5Ss4zAyK
         CsPQRppZ5fEwzfyC0ziMAbxiAgFwBUt/8gpCXgSCOi37ni3LpOOxLEQTjtPa909UlpiW
         aO5SPhFzRZ36zWO4x9hzS8f22oJdlyTZDra2o9RdeNavu47Q9hTvqSWXRsIhDN4Els8P
         XkW4aL9+ursLYnwrXOoNB6A1MygwBcS6gHUmDKCDYGpmdDRlGXgjyBdrVG9dySIPtV2V
         oMOKU/858kWQF4u5PTkJfLe9I9WR8Zq93PT0Do7LKrfiWO7rVrqmzXseyT0bJ6EBImmd
         MZYA==
X-Forwarded-Encrypted: i=1; AKwUvBycwBISUXmJko8gmPaqNK/Km7i1PPRjmOq9p4wygQHAgJTxXqxkIfG0kzmFJ0BYghgylkbtXBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQoAkPQWS6scZcjfpR9GE2Z65RAFUHDF1kfqG6n4WIX9YGGBZx
	M/bRmtUZSdTNU7DQ+H/RiFg4vdl7v+uhDGnMRzMtCzzspTYe81qAqXntRs8RsCB8vt8=
X-Gm-Gg: AYBFou1+JkZooc+yu2UJKOLLiIi034jzf4xZKKed2TviJZ8Crc+E0i9GKFOtRzXzuoV
	GO58Z+X9p2gfE2oJdo13qX9gxHbtLv/KRTveb0ktIzx1qougo+Lp2QXo9peI96hJvS0tfa5Uadr
	/WOCjaARlzN/YpkENZHU8Q/whTZqql29xDPIM6XyFdj/vGN7zASdJmG3T60xwK108iTo4l1mB8o
	iv+EPPRx/TYfBXvwLnUQkzq4mjTGy82wtlQ/Ib3sN3cp+vuaNnFNbLBvGTWWF06kZvt3RlCRvcP
	//IOJb6j62kXCzi2idxATDNB0aJ9TJCmRIKZx5LDFPhNGIBw5QdR3rIolFl6DH9EraknR/tvPbu
	GOimKZ5nzs5mYIiuLwOakPVB9Ve6lomhjLcn+1zG2JRmcy2Z23KVvmptW6+N71SWWTN1nrSraq/
	bag7CG9sbqQLskskmjbWV002ccBcbh4yrnCadT18yY/13wn62qVHL8RtY46Aimarwthh2Flzasl
	V1p6UNz+k8HUE3PFE+ti7lmIK+a5CiF5R1m311Pj5lGpWx5wlHC/CmqVFH7m9gB2GtrZKAnuneB
	iJbTIb4cjf116b3QwNaLg0NGU9T3iWSMRpnBKeLH7G/9fBJ15InFrT2VhSyWXWVYpu4x9bEkjik
	6j1Jr9w==
X-Received: by 2002:a05:6402:a2c7:10b0:6b1:bc2e:5d52 with SMTP id 4fb4d7f45d1cf-6b49cbea455mr5233462a12.3.1793288688626;
        Thu, 29 Oct 2026 08:44:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b497cfd6ffsm2575185a12.24.2026.10.29.08.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:44:47 -0700 (PDT)
Message-ID: <7fc6fa79-af42-49e8-8b41-00ad4a4d9b74@6wind.com>
Date: Thu, 29 Oct 2026 16:44:46 +0100
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
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] genetlink: Reject joining multicast groups no family
 owns
To: Anil Kaushik <anilkaushikwireless@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, XingWang Xiang <v3rdant.xiang@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org
References: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 29/10/2026 à 07:22, Anil Kaushik a écrit :
> genl_bind() checks the GENL_MCAST_CAP_* flags of a group only when a
> family owns it. For a group ID that no family owns, it returns 0, so any
> user can join it.
> 
> A family registered later can get that ID, and the socket stays a member:
> nothing checks it again. An unprivileged user can join the free IDs, load
> a family module with CTRL_CMD_GETFAMILY, which calls request_module(),
> and then receive the notifications of a group with
> GENL_MCAST_CAP_NET_ADMIN or GENL_MCAST_CAP_SYS_ADMIN. For example the
> drop_monitor "events" group always gets ID 1, and is free until the
> drop_monitor module is loaded.
> 
> Fix by returning -ENOENT from genl_bind() when no family owns the group.
> Nothing is ever sent to such a group, so joining it has no use.
Moreover, a user should retrieve the group index before joining it. It seems
weird to join it without this step.

> 
> Found by the Sashiko review of the gtp multicast group fix. Tested as an
> unprivileged user who joins all free IDs, then loads gtp and
> drop_monitor:
> 
> Before:
>   joins: ok=62 EPERM=2
>   gtp/gtp (ID 15): member
>   NET_DM/events (ID 1): member
> 
> After:
>   joins: ok=19 ENOENT=43 EPERM=2
>   gtp/gtp (ID 15): not member
>   NET_DM/events (ID 1): not member
> 
> Link: https://lore.kernel.org/netdev/179324692107.3134.14443689892607921337@kernel.org/
> Fixes: e03781879a0d ("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group")
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
