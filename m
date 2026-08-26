Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074613B95F2
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735646; cv=none; b=gjOap7KMM9a/iZ8vP8sXjTR51z4VWNIxP5fUoXgWsGolWfgf2TsiY/zJqFuORbnmQGhssPeKQpnF9gBwho9k/VVZgmhcJ9gFaGQguvRokiPS+mlTbpmnfFYnoNWHlR1sUKTmM421C65cEbn3YuTmoUzs1+6JGUG7scD0Ocvtj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735646; c=relaxed/simple;
	bh=8cNcQmSBEQa/bqsTILDfnq+twu8/JgZiX/XoG+xyzZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fs6k3t3dOUdblqAAd7W/05RiHH4GVXHUFgPMnXzJj52I0di+eej2aILm+OEO1rjN3BpemoHyRKD6sEkr0e+t6vFn8RIDCxOERq3QiHhNcPZtHlj2fhpdWZTUEfEcpYJJWxmHciuSsexNQ827Iuddb5YkBWrWwkkGPxWM5teWdck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=g81E7ixI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="g81E7ixI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so948643a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787735641; x=1788340441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6kHnb1LiNoLhJZjgOJ2+mjeSBKbJsOHUehEEF4uHAow=;
        b=g81E7ixIip/97XOEsOpVP332iOUIXvs9d0udYahQJNLlXyV3c93XgMSTTzMVi2orNU
         2EYlcMz961cEuv8bCMElwqMNr8teYtmfiVdMRHdbjJU9C8D6O0JpW/AJijxqDL6ztdJF
         NH8EincPcMW9VTgKXmf0RRS+5qQRdGet43x7FEYp437rcrkUEu5ovBq3fPYF7gLnB+Cb
         CvG5QxDQx/pwe74GDpUBmYVfGkk/VOKm+cLL1qbqrG8jSk/FU9dwokUuw2qIYJHtqXYD
         xp5ran27EGdw4E27wnoJPtb63QFbzxWS65PVSvM/3AusiRayl7JSxTaiMJHGl+m8Mwdm
         2OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735641; x=1788340441;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kHnb1LiNoLhJZjgOJ2+mjeSBKbJsOHUehEEF4uHAow=;
        b=r14w6i2Q4sLwNMjMoSuu9l1bYNlxJmOX3UrZ7ma4CwV5KKLTzb10Pnk3TUBR5OZj33
         36/l5of2vu2JC3eHqrRd7T8RxQBXZsjfxtQ1UqbgShxS20tqiCS9OdjquGQQ4SRgU2dj
         95oWh9G4QB/B/8A6u835jIaU4zkwm7a++dqO2QuClYF+Q63znsJPpxirejWu/BMgdhT8
         aanyL33LLqr2VSOz/N8EcSAxdHBoQ5fBwNKpJK0R4E4Z/yO9Re3bWKidJNeEvqnJcBwO
         EfKekHgxrUtGhQTKIuiz1A5btCE15KREJHIRpJVHoAFTNiXnehAE+OV/8Zocdb/UaBof
         U/IA==
X-Forwarded-Encrypted: i=1; AHgh+Rpq/71jR7ICFlldVhcziAe+WSug6yRsXT71uMlwypQzjncJO44iqBcOTxGgrrEHDN9qsxCrL9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nv+xgAbsiSpsbCsvxO8hT+GbN4tZaotGCRJmi5qfIp+KZyD5Pr
	4i58JDeb/XBM2JCv8YT0KFd1b/VR7LllzEoosrTu3W9iUZMgfhikrPDEaco6szNUOI0=
X-Gm-Gg: AR+sD12wmlQ1XtIq9GKXs05SbjUkAA62Y+/zzkJ4xmwyzySTHqiKAJ13pzV3+n8U5a+
	VSUJQoUcFpbziYp4um2LpnVnx7n3KhZ1MlcOwS6lEQ4fdGeEk371ogfrckxSp5ql8Wf5xQQKEOK
	b8yiTY2xciFZ7bu6DQNzATIoDQc053Pwwu7KD1wPnxoEsrM+/14M1CMJl0P4TtE9j3DAJm0NrWJ
	Rh7pyQEAPIIFJlMeTxf0F3pet8nGbP7944gxUppqe/ikmhspCQ4bIRuhfQjh89YaPtjSBvP8Z64
	hr3oACbVjL3MBB72WYPvGsuqlZkHk3/Aq0m9Px3c4cU/2PS9dIORiSNhoreWBC3/0wvV0J26DZ9
	uiWiyGTY2xFZqYvONPdeNaDA37pRzz1CpBI2rKQGLUvwdcy869QQSOqRO8YFfgm35o2YpIwzM7o
	YVeRrj91J6NE8rzFg+4yrWMDtfPE+C/VxvuqV1XZm2RUclke2l4POwQNN+9R5rW3SSYEeUswTSq
	3v500Ebicc/fDugK1I=
X-Received: by 2002:a05:6402:a0c4:b0:6a5:d7cd:fb9b with SMTP id 4fb4d7f45d1cf-6a5df327ce6mr6566059a12.0.1787735641083;
        Wed, 26 Aug 2026 02:14:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8ea6d0sm4038428a12.13.2026.08.26.02.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 02:14:00 -0700 (PDT)
Message-ID: <4e6fcd1a-779d-4777-ba39-d8cacda0862b@blackwall.org>
Date: Wed, 26 Aug 2026 12:13:59 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: mcast: fix use-after-free of a master
 VLAN's multicast context
Content-Language: en-US, bg
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <D400F6C7-543A-4B79-9E5B-D1D8974DE5C9@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2026 12:12, Norbert Szetei wrote:
> br_multicast_toggle_one_vlan() clears BR_VLFLAG_MCAST_ENABLED under
> br->multicast_lock before stopping a VLAN's multicast context.  That is
> the teardown handshake: lockless readers gate on the flag through
> br_multicast_ctx_should_use() -> br_multicast_ctx_vlan_disabled(), so
> once it is cleared under the lock no reader can arm the context again.
> 
> For a master VLAN the handshake never runs.  __vlan_del() clears
> BRIDGE_VLAN_INFO_BRENTRY before calling br_vlan_put_master(), so
> br_multicast_toggle_one_vlan(masterv, false) returns early on
> !br_vlan_is_brentry(vlan): the flag stays set and br->multicast_lock is
> never taken.  br_vlan_put_master() then drains the context in
> br_multicast_ctx_deinit() and frees the VLAN through call_rcu(), while a
> reader still inside rcu_read_lock() sees the context as enabled and
> re-arms it.  The port and port-VLAN branch of the function has no
> br_vlan_is_brentry() test and flips the flag under br->multicast_lock,
> so it is not affected.
> 
> The reader is the bridge transmit path.  For a master VLAN
> br_multicast_rcv() selects brmctx = &vlan->br_mcast_ctx with
> pmctx = NULL, so IGMP sent to the bridge device re-arms the context's
> timers after br_multicast_ctx_deinit() has already stopped them.
> 
>    BUG: KASAN: slab-use-after-free in detach_if_pending+0x412/0x4a0
>    Write of size 8 at addr ffff88810ac39918 by task brmc/601
>     __mod_timer+0x51a/0xc50
>     br_multicast_host_join+0x25b/0x390
>     __br_multicast_add_group+0x468/0x530
>     br_ip4_multicast_add_group+0x1a0/0x260
>     br_multicast_rcv+0x2cda/0x61e0
>     br_dev_xmit+0x6c4/0x1540
>    Allocated by task 610:
>     br_vlan_add+0x111/0xb40
>     br_vlan_info+0x370/0x3e0
>    Freed by task 0:
>     kfree+0x1a7/0x4f0
>     rcu_core+0x7dc/0x10a0
> 
> Only test br_vlan_is_brentry() when enabling, like the
> br_multicast_ctx_vlan_global_disabled() test next to it.  Disabling then
> always clears BR_VLFLAG_MCAST_ENABLED under br->multicast_lock before
> br_multicast_ctx_deinit() drains the context.
> 
> Fixes: 7b54aaaf53cb ("net: bridge: multicast: add vlan state initialization and control")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> Changes in v2:
> - drop the paragraph above the splat, per review
> - no functional change
> 
> Reproducer available on request.
> 
> v1: https://lore.kernel.org/netdev/B41EB55B-E5FC-431D-956C-503CA7B95C30@doyensec.com/
>   net/bridge/br_multicast.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 75e1e2a8fc83..3ef5d8bbf552 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4377,8 +4377,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
>   	if (br_vlan_is_master(vlan)) {
>   		br = vlan->br;
>   
> -		if (!br_vlan_is_brentry(vlan) ||
> -		    (on &&
> +		if (on &&
> +		    (!br_vlan_is_brentry(vlan) ||
>   		     br_multicast_ctx_vlan_global_disabled(&vlan->br_mcast_ctx)))
>   			return;
>   

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

