Received: from mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08C420E71
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971771; cv=none; b=KuOjqsnwpeHzT08fCLucNziAdeYb0Y3ZiUUgo+H+PtqTNt3Mh9dPBZ8YA8XimYUvLkFOHc731uZB/tcFP4He3o7syvlzlchdT+tdFr21se46FXsZ+uqrrdhnO4gTbROtBvbvB1yo3kAn7a7IRxBUwQNdsL6GMZoL14M2jNf1d0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971771; c=relaxed/simple;
	bh=x+uL/qquAcwtBTF7xYVOFDMeHJgdjaOzhlBTnS0m4Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pt7XTkbB47oxT88KGwBmWsZkVsjtP/P6wAfDJF/SKjYxxehu0a4vpRvs/vMOwx8QTUxpzKedwcDrHc+zQn591BlgB05n/IiiutbO2vTpaqSYlvilUQeokB/Ntg3TZb45OMRiYM6DnC9oe1HFZ9mR08YzRTqGsMnnauSdsbMuhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iVAaC8tI; arc=none smtp.client-ip=95.215.58.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iVAaC8tI"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x+uL/qquAcwtBTF7xYVOFDMeHJgdjaOzhlBTnS0m4Ow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786971764; v=1; x=1787576564;
 b=iVAaC8tIqccwiMrAko1pyiYHCV8BODkWyZRO2HUMDuHHEtNzVghofw/YgESIWB/tmHG2RIm1
 ihwMR2UNE4kLcf+h2qExTPC8Zvz23RNrNNjfgWn5Vp87iraExd7iIznIkiCZEVM7KtogjZOF7Ei
 dYQoW23wnDgofjmNdFHvn/oA=
X-Envelope-To: netdev@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::6:5429)
	by smtp.migadu.com with ESMTPS id 1d2c3f875899bb5a;
	Mon, 17 Aug 2026 13:02:44 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <6f8c545d-bdd6-444d-a548-11901ba6dcbe@linux.dev>
Date: Mon, 17 Aug 2026 14:02:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 1/3] hinic3: Add ethtool statistic ops
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>,
 Teng Peisen <tengpeisen@huawei.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Dimitri Daskalakis
 <dimitri.daskalakis1@gmail.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Chen Anwen <chenanwen@huawei.com>, He Wei <august.hewei@huawei.com>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <cover.1786774752.git.tengpeisen@huawei.com>
 <dfeeb94c9025b96a02078a0f87ec4d204460b8c3.1786774752.git.tengpeisen@huawei.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <dfeeb94c9025b96a02078a0f87ec4d204460b8c3.1786774752.git.tengpeisen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 03:04, Fan Gong wrote:

[...]

> +static void hinic3_get_drv_queue_stats(struct net_device *netdev, u64 *data)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_txq_stats txq_stats = {};
> +	struct hinic3_rxq_stats rxq_stats = {};
> +	u16 i = 0, j, qid;
> +	char *p;
> +
> +	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
> +		if (!nic_dev->txqs)
> +			break;

how can this happen on registered netdev? And even if it's possible, why 
do you check it on every iteration of the loop?

> +
> +		hinic3_txq_get_stats(&nic_dev->txqs[qid], &txq_stats);
> +		for (j = 0; j < ARRAY_SIZE(hinic3_tx_queue_stats); j++, i++) {
> +			p = (char *)&txq_stats +
> +			    hinic3_tx_queue_stats[j].offset;
> +			data[i] = *(u64 *)p;
> +		}
> +	}
> +
> +	i = nic_dev->q_params.num_qps * ARRAY_SIZE(hinic3_tx_queue_stats);
> +	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
> +		if (!nic_dev->rxqs)
> +			break;

the very same question here

> +
> +		hinic3_rxq_get_stats(&nic_dev->rxqs[qid], &rxq_stats);
> +		for (j = 0; j < ARRAY_SIZE(hinic3_rx_queue_stats); j++, i++) {
> +			p = (char *)&rxq_stats +
> +			    hinic3_rx_queue_stats[j].offset;
> +			data[i] = *(u64 *)p;
> +		}
> +	}
> +}


