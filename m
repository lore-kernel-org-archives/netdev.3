Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898C4EE872
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788796; cv=none; b=SHE4RT8H9wdGqC9zU3+GkEh/IECFrG7SgtabUrFyOv0vCiDz6pzFtKN/dfwYCA1X7iRKoG1g7/xC5mEN3dZfNgvDjJvF8HeReNtaNNb4aBHATz+gMnFDcVfclGT1LaB3BuxIAxz0L/562JMWUkPhB2+MeeypJL68SHUx6CKaU0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788796; c=relaxed/simple;
	bh=ey+ea/XaUzKmLSSv/fmRwtg/pqMjVi9RuYBhFPeenHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcXUv86WiAwWjxbwV7yKAxRj124rPWuAlwjsi1YBIQrgQOeK58f/0G7WgnWhYZTz2+6S2gGmXt3b22aUoVjCzWViaTE9RqxvkDu3U70Q+DLo3ubVoe3IcHxku6S4TXxP2yzon3Y5SSyz9GZpLr9i1HOl5Ur5nIEpjTzV93LS4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=O4lXPVCH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="O4lXPVCH"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4859b45abadso163323f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788788789; x=1789393589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HmOQIAWcEZHB6gZrTF2GCi64OHYKHOStwvoinD4q/34=;
        b=O4lXPVCHheDL96euIFGBnf3Jf4VqPZqM7eyu5evF9lOuR2HIZ1Qkd7CGohCuokaLc8
         KdVt4Vi2Pd7yLpFfydUGpZcJ2zPBSjjGvDN6OfGUtkW0R5fb3lNlzWq3hAW1io+xWq/u
         Xrk/SIZKKaxJg08MTAjnKTiGg71ojlExT8Dj7pfsQBhcHO26nIH+qNdeyMO02pI7uvcc
         i0eVdwQfTmkf9/BQowH1DaPckg4LSavEQ4ZeQEjsL0PFlZegsifHXF7cxAS81+LVSDrc
         fzo6gIVoF1dheV41cW73bbkky8f+T+PH3TXrvqntBtrpMUTUQh3cY3cZwJdr6n9sy0HW
         nnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788789; x=1789393589;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmOQIAWcEZHB6gZrTF2GCi64OHYKHOStwvoinD4q/34=;
        b=KDZJQCwcW6vJWSpu/metw5BDBzJv9aZc9AmE7ygQOqyFUB4nGFGpSTzp1SYIMTj6/c
         ZVKK/GUyp4bFweArPm9GO7kQfcSFFN/+08EcZbM33MZd+dL50N6jSv1rgWIoIreoMr29
         Fkj4vXEdcLxjUgtXHHUyV5HQ963Auid4octCWbRrtp0Oo8WQqXpnQFD9gGxrxrmqPnIB
         I4FCbov65Nt9erOzA8qO3LPp4JPAAerkH+ajvLM5q560Ozm6u8Qd31IjU0DkULgD0uM0
         SzwSf9YNlze6vBtB53HlQ8BC0+d2fv++ydxkOK26ZVwUstlkYn6WLe/3yRLhVxbwXjIV
         7fyw==
X-Gm-Message-State: AFuF++n7O/LxeWYbs5QDRm3QB1GVbDiVgo94jWbx/mpSZ4CcI9omW0uB
	oNvtvIej172bkWmrV5uscpRM72TbHlVmPSN54I57DjbXscwd2+ySGm1RfvYdt6yLgW4=
X-Gm-Gg: AYBFou15QXGulCgTSOJ3E1+TQIvCq9oYyQMbdeYu92TMseTUbWn6I45B4Q9abhRgh2N
	3EVGPh6RbTZkUVs+R+EODWtKMVArODp7d4RHwOVWY14Js48WAH59gn8YNs/RwQt1memcMom0WDY
	7+WlP9TN28A9JxsiUagOXeQ6gZL3VAdx0k3wUK8W155L027L7Vg+ePwJQ1S0SmeMBk9mGgZoYP8
	rVIwMsxcbI1AnvRizxagcbncwRIN6NfiBE2qP2RTDA6Iibo8XBE2wXddA5E81bAN67oSFUKFwHB
	yn8vskrTHDfx8i74WAh8lV+7a5wWp5npfcGRl207V87gBoTtpRSGySOTfrngTdBxsS8LmQj10oa
	2fLNmyFZYR2MCz0CIjxKXmfmIzHbNATs3M1FR+kmIZ/I2whE9gGu734EMZkWkPrazmGLafPExuU
	jM2Bd1LeEFco2uVT0bkKFVFKeFrz2fI9G2ZFKW0qeclmN2hlfFy/ILa3GtlcmMUvCVGGrweIVTG
	nD//2ejUnFOpzMY682k
X-Received: by 2002:a5d:5d09:0:b0:485:8a46:b3cb with SMTP id ffacd0b85a97d-4858a46b609mr22977040f8f.51.1788788788535;
        Mon, 07 Sep 2026 06:46:28 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm17273193f8f.37.2026.09.07.06.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:46:27 -0700 (PDT)
Message-ID: <76e98b59-9371-4700-92bf-20e41aaf0210@blackwall.org>
Date: Mon, 7 Sep 2026 16:46:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: bound the port VLAN lists in the
 IFLA_AF_SPEC nest
Content-Language: en-US, bg
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20260906224246.21719-1-iprintercanon@gmail.com>
 <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
 <20260907133505.5291-1-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260907133505.5291-1-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2026 16:35, Artem Lytkin wrote:
> On Mon, Sep 07, 2026 at 11:47:24AM +0300, Nikolay Aleksandrov wrote:
>> I prefer a more explicit path - return error for both (RTM_GETLINK and notifications)
>> you'll have to plumb down extack but then user-space will know there are too many objects or lost
>> RTNL_LINK notifications and it should resync (e.g. use RTM_GETVLAN to dump the vlans if needed).
> 
> OK, v2 will do that: br_fill_ifinfo() fails with -E2BIG once the nest
> would pass 65535, kept distinct from -EMSGSIZE so the WARN_ON in
> br_info_notify() still means what it means today and the error goes to
> rtnl_set_sk_err(). For the dump, rtnl_bridge_getlink() can turn -E2BIG
> into the extack message itself, which keeps ndo_bridge_getlink() as it
> is; or do you want extack plumbed through the ndo? The size clamp and
> the doc text go away.
> 
> Artem

I'd prefer to plumb down the extack so the bridge can set it itself and be specific
if needed. Others might want to fill it with something different, there are only
a few drivers that implement it and some may decide to return user-friendly errors.
Please make sure to split the patches well, don't do everything in a single patch.

Thanks,
  Nik

