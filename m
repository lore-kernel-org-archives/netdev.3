Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB23AE1A0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194777; cv=none; b=iV/vwSKHgNval76Kef0qhE4TrUsm+lL304tQErWzodz3JOIQtVwR3kRseWk1qr7DBBazvjNavgX9oRML4Y4Ly6r9dbmEXzl56b/JW7jAe2xvrr8a9nlESbhgwMUqoyPBdtGOlsm67dvPIORPsGUi74tASM4uydzQAiaoP9IRENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194777; c=relaxed/simple;
	bh=meA6MsQGL4r+3NWB8mPcZgx3ZsEQbioVKTri4hnL4O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcNevwg3zUUStopESUiPP9rCagJ6j4eDFTwPkWpfSl31tgd67UtNqoXIjnp6voNFcYgXKDyQwuBP88tNH5ppehichX/65r32jB1/ujhAbDUTyQwQ37+chxDBsadftPGYznV1PxFA772KGw8o2LDVJ+85mo6GZ5Tf98xQHQ3q6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPe5AK6Q; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPe5AK6Q"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so1234088eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792194776; x=1792799576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJzMPP3FpZ1Vumfeo71j9PoiRQb0nGjd9sFzsJIM0NY=;
        b=GPe5AK6QjV3Cnc+Y5GEwsyK7FawTgaK0F/bNA0PT0XOfvjfWBB3qq8WBi029HFkRVD
         cD5J68YMSeU2rWI13hOSoSo7ezB/tAchX9TQNez1ktgdBZFagCeuLfNLA0V7Hf2Oi8i0
         +27WLU1EXX6slI4CSysQ8qZS5aOKi/z4Q8+KfTh4HEWf6W5kOlGjU7VGPgWg4qSOQuPe
         UNTvvJfVWNLFgLk/qwrIPt+HnTUgRAILOrQDa8I2RU+utp+zPw4bnTgDLQGtBVQ1Yxuz
         mJGRRC7bNxFQ/s9evc++PyEE3CJzV0OxvEwonmNH5hLeo+lhq25kNe/zH6ioArxiTmgR
         c2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792194776; x=1792799576;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJzMPP3FpZ1Vumfeo71j9PoiRQb0nGjd9sFzsJIM0NY=;
        b=fHsnqesXxvM7cTu7QB2k3+Qajh2BGuWTDH4WD66XdvylyqZOOoWjIf4cCVczH+rBV+
         kcNtpEfJG6HfI+iT7TdUAj2DVUDalI2fda7SRD6JVXvn2yOLqUuUrgjaWebts7We/cPQ
         8PDWxtMqzmopcZ4EqfrooDC8dnxaPJ1frHdAE+SZvgSUm4+OVPI5jzDz3H4uhG8WbrQj
         ke1I8YG8YnSI8gZ6HBka4YkXxYzxN04RDeEuC+Vn3A9+X1oObwGr7kLP/AaV6xkhtiTn
         Y2Fwa7p8F+8uHbwl/7UYjCFsavcvm1gsCWdFbpH0lIGE4IsSAkzrVf99JdP4o28dBEBT
         yXzw==
X-Forwarded-Encrypted: i=1; AKwUvByTPRMEMK7te7zhU8YuvHi8t+utb4bLk7ffMZ665aXL6fmdSG8c5/rlRxOgyw/vqOzqUubq06Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO/gUO/CLse84Cate8wyuM3ixa6j9QR0hiIo+gTOGUU0zig05v
	Xt5SuPrEu9rM91Ki8o0q7khqWp7pUaPg92b16jtVe813A4D/NSr1JdI8
X-Gm-Gg: AYBFou31uVN2n+lQ814WR6quCFAMynjEOgxvIn8naGirFKSTnQJbG7V2HwVPywSCPnP
	2ACKSveVfdO/LPrAYAVAupSsBhLPEd+W29inPyl+SBxMd7gMliXjHVIMcK2VPC1c8idJu2bSiv9
	yH6cu/HmXoIVWarX9o1OKVDT6cWolT0LKeNQh1OmcofWvlPSKhX5US7BCWznuiFPXQZjb3rkdOj
	KCRZFmrO6j0UYiJLryYrsjGXkA2CMRUvjaOmiCZ50bCGLkQ3ck7/e7YI4OtbPmTtj0bePICBAJq
	Hwx3X8zpHWvkAB/ClwgQwaDrnVxQMF+q66gkprq6Ae7SYiJUaD0AbyldLxOojLR69R6Doul5w9n
	Q66JUrJQLvj5AfvCU3Z4wJxk/41dGMpZGL6f3ZJuEuBefTdX6nCE5KJWRmEg+D5GbJASDnb2ACY
	rXfDrMjcdiyzu2LByhS7GcUGy7q8LmKIqbyEITkCqdxEZiuAhGJsccS8euw1/58c37E+MFm4qrX
	b3LGwt+4R7Oec1uloPiMAxjgziSAVki8/+SuHyehDwVoh6XuulWsPIlcmQ8xywdPFs=
X-Received: by 2002:a05:7301:2710:b0:360:b8b4:840a with SMTP id 5a478bee46e88-361a2747820mr1915199eec.39.1792194775702;
        Fri, 16 Oct 2026 16:52:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::7:ec14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm9181665eec.26.2026.10.16.16.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 16:52:54 -0700 (PDT)
Message-ID: <a0eb0511-fe0f-419c-adec-159dc16913ae@gmail.com>
Date: Fri, 16 Oct 2026 16:52:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v16 1/2] hinic3: Add ethtool statistic ops part1
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>,
 Teng Peisen <tengpeisen@huawei.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
References: <cover.1792149958.git.gongfan1@huawei.com>
 <3cda990995ccb002019f147b7a0c004c542229aa.1792149958.git.gongfan1@huawei.com>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <3cda990995ccb002019f147b7a0c004c542229aa.1792149958.git.gongfan1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/26 4:13 AM, Fan Gong wrote:
> This commit adds per-queue TX/RX software counters and firmware-backed
> vport and physical port statistics to the hinic3 driver. It implements
> the .get_strings, .get_sset_count and .get_ethtool_stats callbacks so
> these can be read with ethtool -S, and adds packet/byte accounting to
> the RX and TX hot paths.
> 
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>  .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 294 ++++++++++++++++++
>  .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  11 +
>  .../huawei/hinic3/hinic3_mgmt_interface.h     |  37 +++
>  .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  64 ++++
>  .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 108 +++++++
>  .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  64 +++-
>  .../net/ethernet/huawei/hinic3/hinic3_rx.h    |   8 +-
>  .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  70 ++++-
>  .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   5 +-
>  9 files changed, 649 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de9..bb6094d61196 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -13,8 +13,11 @@

[...]
> +static u16 hinic3_get_hw_stats_strings(struct hinic3_nic_dev *nic_dev, char *p)
> +{
> +	u16 i, cnt = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(hinic3_function_stats); i++) {
> +		memcpy(p, hinic3_function_stats[i].name, ETH_GSTRING_LEN);
> +		p += ETH_GSTRING_LEN;
> +		cnt++;
> +	}

Do you need to manually add/track the offset? Couldn't you let
ethtool_puts()/ethtool_sprintf() do the hard work?

> +
> +	if (!HINIC3_IS_VF(nic_dev->hwdev)) {
> +		for (i = 0; i < ARRAY_SIZE(hinic3_port_stats); i++) {
> +			memcpy(p, hinic3_port_stats[i].name, ETH_GSTRING_LEN);
> +			p += ETH_GSTRING_LEN;
> +			cnt++;
> +		}
> +	}
> +
> +	return cnt;
> +}
> +
> +static void hinic3_get_qp_stats_strings(struct hinic3_nic_dev *nic_dev, char *p)
> +{
> +	u8 *data = p;
> +	u16 i, j;
> +
> +	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
> +		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++)
> +			ethtool_sprintf(&data,
> +					hinic3_tx_queue_stats[j].name, i);
> +	}
> +
> +	for (i = 0; i < nic_dev->q_params.num_qps; i++) {
> +		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++)
> +			ethtool_sprintf(&data,
> +					hinic3_rx_queue_stats[j].name, i);
> +	}
> +}
> +
> +static void hinic3_get_strings(struct net_device *netdev,
> +			       u32 stringset, u8 *data)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	char *p = (char *)data;

What's the purpose of casting here and throughout the patch?

> +	u16 offset;
> +
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		offset = hinic3_get_hw_stats_strings(nic_dev, p);
> +		hinic3_get_qp_stats_strings(nic_dev,
> +					    p + offset * ETH_GSTRING_LEN);
> +
> +		break;
[...]
