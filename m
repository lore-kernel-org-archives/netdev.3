Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142D4477E7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855167; cv=none; b=nH1ApCyKsuewXEPqMN9AZzC6UYf3E2RdHVCThQMGp3t/dFS/a5YmcKL0S3mopgTlJq85mqjsFOXt+OYG/3yk1i7cyXgUHecxlr1j/Zqm/GDLOuec2CEzIUu33pvdFRwBi8Yn73TUj1CDBmV4V3VaYypB9O3JYc6/8Nn/L1w3ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855167; c=relaxed/simple;
	bh=BFT937ZpdM34J9PwVju7/yLS28Bo5/2Q+X4eLCQB59c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l69tFWLbn61CXDzELBbDNBP5EZlxD14qyi6j2ieVniI37HQfaUZk/9X+RXc1HYm7CJ5AWIgIzF0b/Tog9Ay8ptj8HMnVwpFx+bp9CGO5VUfU3kUSpSPhXromBpxpsG0ei6aoxPL29TLQWhAqDTQ29W7TLG262CODOG5JKjKFFS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImStY7tK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WikupiJf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImStY7tK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WikupiJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790855139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DXvxeQkPqG5Nev8eHBMp9agYe789sbTvcF7+Hpom1i4=;
	b=ImStY7tK+v2OSMjxemHyEBM/0UTI36Qya1sF1tX3BkuHL8t5RzYzjEP7D4IrN3t/k2paVI
	CRgrC07F15A30dvHjRlCxKOLx03WWtu8LKp33gCVlBiOHcQsS7Jq+rgTtaoz/F60dyc9Ts
	rjkQJ6Tk6qFx8v18eTl79eG+iaZwB54=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-87v5niFmOXuX3fMQzLndZA-1; Thu, 01 Oct 2026 07:45:37 -0400
X-MC-Unique: 87v5niFmOXuX3fMQzLndZA-1
X-Mimecast-MFC-AGG-ID: 87v5niFmOXuX3fMQzLndZA_1790855137
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2dd399f761so430066166b.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790855136; x=1791459936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXvxeQkPqG5Nev8eHBMp9agYe789sbTvcF7+Hpom1i4=;
        b=WikupiJfNETO5TXgTLBqyUR7APbuZ8iITJ71HpgcG6qZXdZP6dYVmbrZaThGnFsXMb
         +VJ4SY80DVAuGqSsXtVdU+ivK9GjPy/Y/fM9IDEHDiHLHmiDkY2u/SwQh9++Jlc/ledR
         1ccSYBe/RVa8hEyUn7jNcgdtJhINFBuwdQJV0ouI9DRHamJwPA9GuHrFk8rD5K/7l3UZ
         R0Q8OsKPExkD+DOEncr4Qk+0JdGbYHlFKfC8kXPcKV2VcQywm+hG1KsuwZrx2OZ3gWAa
         1Dj0zIHQE/Khr3eC4Fbs5jM6in8gTC48xpu0I5ktsHUMXDZDngdx+x2FK+tO6+9otF20
         XjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790855136; x=1791459936;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DXvxeQkPqG5Nev8eHBMp9agYe789sbTvcF7+Hpom1i4=;
        b=PiOmOsXKyi8dvS3JdWyUQdqkepFTHepXm3JpQJGjFawBuY6K37ahQnfunaQMNzDQmM
         azaooFyQxSXNXt1VASV44EG3nnKiwaiq0XYvcGehdp0WIccR7LVrpo2vgW5fx0j6gI77
         j0wbM8p3a843d+nG0m72iYJGP0neejyyTCOwNnxe6MOHVqP7wpeyi7hWdEUE+83lU0V4
         d+5BChWnPO17WIho3CvA4VLeD4Du0JLrRvL30ybf96fgMC1zSLJ9WGUhXYWBIY3Db2UN
         wJWHIEgFR73D22jzhy/1Ym8Dlh3rJsFzfWlFau7+xt4D/blXWgR2U0/rP52mb8MkvK3d
         1bmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzi351I1DTLQihQ1leKn8xxXZALHa1QEEeGP3Dw/MaaB5wvatS82g4EuSK+9YO2ctIqdLAAsVs=@vger.kernel.org
X-Gm-Message-State: AFuF++nxLFIPyR3BzQpziw9UrE/9zbEtxm0BZm3cMTqj4t+kNZk0NI0/
	d40/z8POEP033c2nXxEplltDDEXWJXLGOiy400yrA3BEZFZ4qSLT/4XaSH0XZ82XMtkeHugnR8O
	yUmLq10X9ccqGVRo4Zrcou/Aka5me3Ty+dktL5Td5pyHJbtQt/eOe1s2Tlg==
X-Gm-Gg: AYBFou089ZhrJ4NHYdpPuN+RBwfeGaySn2Kx4TiITX86C7du2DWqjzgmr6auv1WpgDE
	5XpcERSspJYJV+gXfs06QkIQhB+SDvzVURRvmLoTdPDRb3XUQzpcE78xBSGAJ8ltXzaxg8MTEi/
	a0IVxUgNUcf/hgsWLbqqGE9foKnog7vvYIFIjI0LuEAlv07eirRyxopdjGHhhWknnL07GWcaDkg
	L3DMDAN9E8txSJfsORdoFDTkmbiuGpyRSMySBG3DPUVU7lBLl5PjEGVOkNRFqigKWxYfQ37i+QY
	3fYMhCJj/XDdXmtusFI0/ISkN0HkUkf2xDyFq5p98QZUeUSACd6yYR9eCoOM9wOR69cB3lo7dcW
	PEp8M9uBPEu0XaoYbTP90WnPAT3AiRihNHCJuqH7a4HUPmVvTJ7RaWqTx60Q7DsGsvaK767gupw
	==
X-Received: by 2002:a17:906:478e:b0:c25:2a78:15ed with SMTP id a640c23a62f3a-c2e2376115emr403162466b.6.1790855136682;
        Thu, 01 Oct 2026 04:45:36 -0700 (PDT)
X-Received: by 2002:a17:906:478e:b0:c25:2a78:15ed with SMTP id a640c23a62f3a-c2e2376115emr403159266b.6.1790855136230;
        Thu, 01 Oct 2026 04:45:36 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31dd955bsm139895666b.70.2026.10.01.04.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 04:45:35 -0700 (PDT)
Message-ID: <7913b40f-f7d2-41ec-acb2-1edc7f2b833c@redhat.com>
Date: Thu, 1 Oct 2026 13:45:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] vxlan: vnifilter: bound a single request
 and account per-VNI memory
To: Ali Firas <alishmery18@gmail.com>, netdev@vger.kernel.org,
 idosch@nvidia.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, razor@blackwall.org,
 roopa@nvidia.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260927215209.2581830-1-alishmery18@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260927215209.2581830-1-alishmery18@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/26 23:52, Ali Firas wrote:
> The VNI filter interface accepts a START/END range with no bound on
> either endpoint and no bound on how many VNIs one message may ask for,
> and the memory it allocates per VNI is not charged to the caller's
> cgroup.
> 
> Since v2, Jakub asked that the VXLAN_VNIFILTER_ENTRY nest be linked to
> its policy with NLA_POLICY_NESTED() as patch 1:
> 
>    https://lore.kernel.org/netdev/20260921150904.65a704eb@kernel.org/
> 
> Patch 1 does that. Without it the entry attributes were validated only
> as each entry was dispatched, so a multi-entry message whose later
> entry was invalid had the earlier entries applied and notified before
> the message was rejected. With the nest linked the whole message is
> validated up front and a bad entry rejects the message as a unit and
> installs nothing.
> 
> Patches 2 and 3 bound a single request: patch 2 range-validates both
> endpoints to the 24-bit VNI space, and patch 3 caps the number of VNIs
> one request may add or delete, summed over its entries, at 4096. Both
> add and delete walk the span one VNI at a time under rtnl_lock, so both
> are bounded; that walk is the cost, not the memory.
> 
> Patch 4 clamps the dump. vxlan_vnifilter_dump_dev() coalesces a
> contiguous run with no bound, so a device populated by several requests
> could dump a single entry that patch 3 then refuses on replay. Patch 4
> clamps the merged run to the same limit, so dump output is always
> re-enterable; the selftest installs more than the limit, dumps it, and
> replays what the dump reported.
> 
> Patch 5 charges the per-VNI node and its per-CPU stats block to the
> cgroup of the task that created the VNI, so the memory a device grows one
> VNI at a time is accounted the way the device's own queues, ethtool
> state and NAPI config already are (commit c948f51c1654 ("memcg: enable
> accounting for net_device and Tx/Rx queues")).
> 
> Patch 6 adds the selftests.
> 
> The cap is symmetric, applied to add and delete alike, which is what
> Ido asked for when he agreed to a 4k limit. Patch 4 is what makes that
> safe: because the dump is clamped to the same constant, the kernel never
> reports a contiguous run that its own input path would reject, so a
> device holding more than 4096 VNIs can still be torn down by replaying
> what "bridge vni show" reports. Device teardown itself
> (vxlan_vnigroup_uninit()) is not a netlink message and is not subject to
> the cap.
> 
> uAPI changes, all of them:
> 
>    - a VNI at or above 2^24, previously accepted and stored (and
>      truncated on the wire), is now rejected with -ERANGE;
>    - a single request asking to add or delete more than 4096 VNIs, summed
>      over its entries, is now rejected with -EINVAL -- "bridge vni add
>      dev X vni 1-10000" used to be accepted;
>    - a request rejected by the entry policy, aimed at a missing or
>      non-vnifilter device, now returns that policy error rather than
>      -ENODEV or -EOPNOTSUPP, because the nest is validated before the
>      device is resolved (patch 1);
>    - "bridge vni show" now splits a contiguous run longer than the limit
>      into several entries instead of one (patch 4); the set of VNIs it
>      reports is unchanged.
> 
> This is a policy and hardening change, not a fix for a crash or
> corruption; it targets net-next and should not be backported.
> 
> One pre-existing semantic is worth review: an entry that carries only
> END and no START is treated as the range [0, END], so a lone END near
> the top of the space is a whole-space request that the cap now rejects;
> whether END-without-START should mean that is left as an open question.
> 
> Not addressed here:
> 
>    - vxlan_vni_add_del() still leaves the earlier VNIs of a range
>      installed if an allocation fails partway through it; with the cap
>      that is now bounded to fewer than 4096 VNIs. A fix needs a
>      transaction and overlaps a separate rollback change, so it is left
>      out.
>    - a lone VNI 0 dumps as a START-only entry the input path refuses
>      ("vni start nor end found"), and a stats dump carries per-entry
>      stats the input path refuses; both predate this series and are
>      unrelated to the limit.

Sashiko complain WRT partial accounting of patch 5/6 looks legit.

Also it would make sense to reword a bit the commit message of patch 1 and
2 to reflect the above.

/P

