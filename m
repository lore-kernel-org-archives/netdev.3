Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C604F85D6
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724852; cv=none; b=JGIoltCP+f9DChnWrr2lt8DRy7LGKIsHm1/UMibs2di3KM9GOK7n2pi3chBbGhsc7SPOlQRKVu+HiRTiKAxSrmXokVNWw/VSUQXzxMd972fI8JoqrjIGP7tq4XYKUtweoXOHtU61PIDWC+6yNisa1ueOS9lAqfkt+Lg5I0GHYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724852; c=relaxed/simple;
	bh=TSFedrkdsAHaN9aejTdWtXWyUH/Srv+1ePO3zcjFvCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaS1TiYy0M4kYp7aNxyreghY98+/huYOJkOb4FPYwI7H7iIQfonediRTIEy/0g8U1jaABPapMmozipwBL6aEHL4JbuvwlPZ8jrq9BGX6Y1wOwRY9dI2XbhtKH+sBYVa1JDKlDY5lpaLC5CghNr/4jsrjQDwbutOj/7AG63CQ9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL8kiCpp; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL8kiCpp"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2dfa34df08bso15360365ad.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724850; x=1791329650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9DSKh0dbyMhLQzORvY3t9iqgHHDfHJLJlZzXZ+x7vpI=;
        b=jL8kiCppM4U4HnL+R2A9Zfwm90tIwiUdTOx8lBShTYX8C/SQWViQD7mP7U9MAUdGBk
         iJXqxMj6xULPnfzINm4WB0HB9KG6gu036lMb3E40ThBXZ4Nhx1qF+DzVmtfJLEbbmsAi
         3WVh2NEnyMl8PvM0v/uknCaZ/DWViVPWPoneN8z8jh/zGdEJyJq2j/QI+yopfR+MYOWy
         3PiLWaiWXZCUeua3a895mdqFAzbu5z8rYclWnSd8wYWY8zBk6X2DLCrAIXjwp/8ycTK6
         C7njUsgCpYfzQJVqGKsK0ZZoGDgbWk4uv8O1Kv6Bh3eOqJal2iFRqa0bHVLmm4SgO+T4
         9reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724850; x=1791329650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9DSKh0dbyMhLQzORvY3t9iqgHHDfHJLJlZzXZ+x7vpI=;
        b=oNBCRSvs0HK9kJV93BhGzZAMuLpws+gh3Hmkx7ihrcktRQ+gsPD/Kpki56QI5WO84S
         DVgYGed8UY5Yv0F8ICgDGPabCD2mLoDE1iDlMRIzsQaRDkExYkCJyTc4YlYVCm4CNT+z
         n/E3z+JgfYbAoQwOyLK+JybEYXO8lhrHHBINsL5Bp+YI8+sXMoYDpJ3mz4LTBcVWa/sL
         ig+iq9UJvLhRnMSHS+lH79dnRYO2AQU6uquAwfeWf7WyEck7iPlBSKV89xDHR612/NXv
         y89jVmWPRRRlKLsYCBFW6hCthAwgOK7ptBppfEjDRPdmsQiXCj7L87lT/YBQmApTZdU6
         VLWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKgqj8Ld0vWvGqKqxH+51ZvBFsDbbZlGDOEDqkSuNuydUofmoxrDPIHxCUJZDb0/WJiBEjjX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJU8DcEHwipzCDL/TZ2ai89fVUamDM+ivrIuSaeGcAzTwR+bkcv
	DVzIGC87qtlqdYA2CLfSwOcUQ77CW+DPLSdi2PUvtnUWxoQIF8vOoHSO5Cw7LtGb
X-Gm-Gg: AYBFou1xSI4RqlHbCsEuE+vQxrs4arz4nT9IWcJIsQQ9hDl47jtf+dkHvV11fx7rmAk
	H/3Cvjt4ElLaUUPcs8VCnVxByNB4L36Y+Pum1TRlku6cREUwCWxPCBTFJUVtZkqqCgydncf8xxC
	SidvKS9uWJpBqVbROyFLdsDzrTicEvXC/WjfjEw5Ya51eL77FzigZ5dwpUr8XoBPzu31HKEM1P/
	fP/9Lt6FQ99BM97To383cT4qmgqHiTlBEdFBSuhH5waZMQWXfKCU/3DUX2a1L6nGTLhLbA8g7nz
	VdTzxc1l47zrMIxl8U0m6WxKDRf/u1lxwWihrrqkUgnY8YByJmksUqtOisuea+v2DcjGyHMej/U
	URYPjt95mvDiPHWGAHvyrCqvyqRub8vPb2LBIFtr0BEZmcUY3P7+twOecejRoLfxUsjzg+K2TY/
	hmwGJky/n6gn9yaHxCExI7U4gmkChUEDWNc6DGmXUMeqmILPe9vvxnMpGF4ey3P1QQ
X-Received: by 2002:a17:902:f650:b0:2df:ab73:7e94 with SMTP id d9443c01a7336-2e2de587119mr4694255ad.51.1790724849971;
        Tue, 29 Sep 2026 16:34:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2dd516cd9sm1984695ad.30.2026.09.29.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:34:09 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:33:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next 5/5] net: drop GSO skbs instead of handing them
 to XDP
Message-ID: <arxK3DhmtyQ97Ewq@devvm7509.cco0.facebook.com>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928223648.2739371-6-kuba@kernel.org>

On 09/28, Jakub Kicinski wrote:
> skb BPF paths have a number of helpers to fix up the GSO
> state after packet modifications. XDP has no such support.
> 
> "Real" / driver XDP runs before the SW GRO, and drivers generally
> disable HW-GRO when XDP is attached (with the exception of IDPF,
> story for another time), so this is not an issue. We also try
> to disable HW-GRO and elide SW GRO when generic XDP prog is
> attached. These precautions are not 100% today, and IMHO fixing
> that is impossible. Let's explicitly drop GSO skbs on input to XDP.
> 
> First example how things can go sideways today - bonding.
> We only disable & elide GRO on the device to which program is
> attached. Nothing reaches the devices below it, and for a stacked
> device that is where the packets come from:
> 
>   ip link set dev bond0 xdpgeneric obj prog.o sec xdp
> 
> leaves every slave with GRO on and no xdp_prog of its own, so
> netif_elide_gro() lets them coalesce as usual. bond_handle_frame()
> then returns RX_HANDLER_ANOTHER, __netif_receive_skb_core() loops back
> round to another_round with skb->dev switched to the bond, and the
> program gets handed a packet which was never on the wire. HW-GRO is
> the same story - while netif_disable_lro() walks the lower devices,
> its HW-GRO counterpart never did (this is largely the point of
> distinguishing between LRO and HW-GRO).
> 
> Example two - veth. Generic XDP on a veth gets there by a different route.
> veth_xdp_set() takes NETIF_F_GSO_SOFTWARE away from the peer so that
> no GSO skb is ever built for a device running XDP, but generic XDP does
> not go through ndo_bpf, so none of that happens.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
