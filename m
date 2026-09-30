Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF04E80BC
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773497; cv=none; b=Rxnig4TbL9GNtczZMPdHNEaJ2qG8sCgfJ01Ekt3trnvIf/j6b3crYsqK4bW6MGbofbrEE01nrPnQl3MBlotcx8ZbeiBiCMfyufPtrCF7YOuCAXonNAe9NjP/gB71CMOX5c/+eEiNTCUI2NnI2NgAgIDFj3fuKyXsFKBYQXUtvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773497; c=relaxed/simple;
	bh=oxZiTuR2Id+eSkbVoP8hkGx6rui7jsikVu42ZGlSRFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMM5bwHuOM4B+EGWL8f8dCz8ZSLehzVZ08g7K+ls0Vypn7cL+kbiCjpDO3xxQ6CvasLHE3K57Zj/8rNC3d1xXNgExdZGPKIcaVcPb+fEvThruKJYbBc3SV3kjf3cKSO5xhLiidgDcefE2DWGNAb25EHvdGIdUvJW6cHEX+lp4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=AwFW2UVF; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="AwFW2UVF"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b03ecc019so48758f8f.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1790773482; x=1791378282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cdMdvjWVLIDEVS1UUHPgTOR23ut4C2R+qU5zRynN6ZE=;
        b=AwFW2UVFDut0KXcQby5r755V4y+wkBed/xWk8s+Cmq1sIBMuJ88qlBDia90lktIt4m
         Cb5Lno14zl2pcc9//aY1+Q0sBoBrXTOIlSG/qVHo6NUyzR604zuemIJz8XjrqogvmHLf
         zV/gcQdpRTiGj6BnfzdWIps4wFphkDBQzMAL5aVAOsfuDJYGx8P4/cwypOsL2oY3vAL2
         qTkPcibOojxkncb0cSphmUSFLyeFAfarGwUcQnN0z3vcUsh3ntILlgS5bzQFBszq6ZLp
         3dJsCbggGUzDgqAkJ2PM8NIdt09mexIQuCzPGg9CJALW5QrvP5ypLuw18MWczKxiAM96
         PdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773482; x=1791378282;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cdMdvjWVLIDEVS1UUHPgTOR23ut4C2R+qU5zRynN6ZE=;
        b=xZb8ZQSpQC1rR0/BMOBRvnTrIk7n9K+n/iLGvWr/EWytxc2QiO6b8C8mDPdF+zkD9O
         yH46ORilW4yUWPEGOvwmUuz/Nt2D0YSnXzG5yiNYF5/qJyTgRTGMmI3lWNjvvJiy4U9o
         AC9q20baD3UZ18mImsixdVV8i2s6f2fD08ghGEndmms+KP7+voAUx8wUP6pG3o2bLtoF
         Lbkjoo8ySxvzpUtSXZXcdj148ZTBmpIQIZPxSgN7NCGtztzRTsirZ0JcuUYzAZdP0hu0
         sr2DtuMrO0n4GjCQXMV4OtreJ//ptbutmYV8QhmJa0exq8Yjn1i3BvRJeKe84CQLDNiP
         ykzA==
X-Forwarded-Encrypted: i=1; AKwUvBzAL4gAZvDX7UjvBLSXQitYyD/SQ/aaN1eXW7m6g00IBBG5Qe5ABjGU/fHt80bStnlFvLWCy3s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg8I2FymVBB8Gzcf9DEsGrPsUtbkqe7XA9PLuF5LpnJQo4/uyP
	9rTpLEhpu/5DiusPjWtM2TVrCvzwLzDhmARbdWOs7LytazxLy1JvqpbGQiFYc+cHPzk=
X-Gm-Gg: AYBFou30zpaZ3CpKxJ1/2gmsKSZobn7DBXS76i3HEjkr7AWkWln0oHL0poSkllouuE9
	mrMBx/iJkkc+YKYBbmbRfY/IvlNnbd+NDovwPz8SKVWAL9Ya7OADScpjVWkEAW/AoFycHXfrSRW
	650GGb/xtxHz1JbPxAcekX31eun1TT9sa4rcCc1wJE1D2EZUZ4lUp4O0e3ayGRITNJ/FzU2Qmpq
	r2OlcQohYtPhNF2TCZMRFNq3p1y2m3N1RSMDGUf76AcW0U5aOYvvzqB3fcSJPZERjBHQdNMG2o8
	E1GUc+B191nd/2oNdqfTYnmhfHqnMsw0ewFM2wMy5LlkLHNvhLneoDBeuobjYWXlzOeL/f2d5Ou
	NO5mMKFxXJItqi1sp4qTYx3/rt/5oWEzeAtQN+3br/GGeIkwGvyOcTLs4RBUp7NciGNEvAzijaT
	gjNa2td+270fHsen7PWkRuvOEZIAH6wQ1nDJm2msKUujpmBfHDyDYdN1Rd5H1UBi+ayJA35a2r1
	DVLgMmcwQEKOHlB0wPP5emYsusX5BtX5kc9ioEm+utorna6I/A=
X-Received: by 2002:a5d:5d85:0:b0:487:8ba:8b4c with SMTP id ffacd0b85a97d-48b024297b0mr3902212f8f.1.1790773482052;
        Wed, 30 Sep 2026 06:04:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029be7cesm3805401f8f.8.2026.09.30.06.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 06:04:41 -0700 (PDT)
Message-ID: <3019f327-1ea1-42f6-b133-597ca1cc524a@6wind.com>
Date: Wed, 30 Sep 2026 15:04:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v9 3/6] net: add a generation counter for dev->mc
 changes
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Kees Cook <kees@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260930112842.21323-1-sigefriedhyy@gmail.com>
 <20260930112842.21323-4-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260930112842.21323-4-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 30/09/2026 à 13:28, Yuyang Huang a écrit :
> A multi-part RTM_GETMULTICAST dump of dev->mc resumes by position, so
> entries added or removed between two dump rounds can be skipped or
> repeated. The IPv4 and IPv6 dumps report that with NLM_F_DUMP_INTR by
> stamping cb->seq from a per netns generation counter combined with
> dev_base_seq, see inet_base_seq().
> 
> Add the equivalent for the device multicast lists: a per netns counter
> bumped whenever an entry is added to or removed from any dev->mc. The
> list helpers do not know which device a list belongs to, so give
> netdev_hw_addr_list an owner, set for the lists of a device and NULL
> for snapshots and other standalone lists, and bump the counter of
> dev_net(owner) from the count helpers when the list is dev->mc. That
> covers the dev_mc_* helpers, both lists of a sync, the hardware sync
> helpers drivers call from their rx mode callbacks or their own workers
> and the reconciliation after an asynchronous rx mode update. It is
> atomic since the writers only hold the address lock of their own
> device.
> 
> Used by the following patch for the AF_PACKET multicast dump.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
