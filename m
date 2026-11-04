Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793007;
	b=Vn7O0UYmk6wFJWhvx668EC8cLSST/bS5cJPYjG2wN0N01095jbCXNlsPxOGg40E/NSuW
	 xdZJEshmyF4rew9gu9fOuh10Tl7kjbFN1prs/OffXEoF+fEQ5UTsoXifAxqDn4D8pLER8
	 5ZRslEhrFY9CvaxQBKMTOM+8bgz8VkofXbt/V3qMJl1JSLwGW0lzfPHy/ZmHPgYO6UEji
	 szhMKTmUKXqEex90YA9w/pNphPzj2s3OGZASRb8sgzTxDW+5i3MI2VBfJcyEocGGSyt7W
	 OTMF5pWnNZgyRz2uQps9vMNR7wGMk0MAi23Ipe6UZRyxhJCsNO1mrXno2O97+FG6CPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793007;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=xrdukEE5x0BruRmnp8ZvJKdz19vdELS/yZxP7w4IOww=;
	b=lWnPsHmcpM5+ro8j+jIGVYCi0/Uyck7adPWmbccod3uxUd3SZ831eJ6hIzEOplxb2vlJ
	 jcX3igtg4dut5HurGpTT/CGF1yPJLQsvwBRqLWrLs/RvbGABmTf01QmpnOhyTEGG3eNXK
	 609+11kbLRo8XP6M7TaDgFl8CCG+0Lixpcb8eEVmcauz+J4LJV3buSRgW2ueb6FVFuZxY
	 7gOEPp5s5hhYGKaGp1nsFJxSi4INsMUOvUT42FS0obup5DPhiENamTs/Yi32AkY5XZ7S+
	 CTC15FSFyoyG1rUPLww2QluKF1VnqJ7YYlzy4Pdlf5TgO15MPOdn8Cj3lk6LrAnmstQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dszx0BA8;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E95606A334;
	Wed,  4 Nov 2026 11:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E95606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dszx0BA8
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xrdukEE5x0BruRmnp8ZvJKdz19vdELS/yZxP7w4IOww=;
	b=dszx0BA8TeHy45+59xvZNih4m/AuO6LzIyPANSAL+TPUiSDQxzCnOObzSZSP1IAU+cG5K8WMk
	+sDGdEGnUuNJwttmuNkgNYwxRK0EdpAtK2WCRNqUBYtebEluEBkkY/3iEKmtKr9SNk3PURXapVN
	xMhqynJJtfE5spxMnBvdJ/U=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jKNz25DGszKm4V;
	Wed,  4 Nov 2026 19:49:50 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C9514056C;
	Wed,  4 Nov 2026 19:49:56 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 4 Nov 2026 19:49:55 +0800
Message-ID: <db8134db-5e14-4669-ba16-126b45e77cb2@huawei.com>
Date: Wed, 4 Nov 2026 19:49:54 +0800
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
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net 1/4] net: hns3: fix vector resource leak in
 hns3_nic_alloc_vector_data
To: <netdev-bot+sashiko@kernel.org>
References: <20261030095633.377289-2-shaojijie@huawei.com>
 <179370110586.488856.5999411563039166781@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <179370110586.488856.5999411563039166781@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/11/3 18:18, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit message does not give the real reason for one line of
>    the fix.
>
> --
>
> net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data
>
> This patch fixes the error path in hns3_nic_alloc_vector_data() for when
> devm_kcalloc() of priv->tqp_vector fails. The new path calls put_vector()
> for every vector that get_vector() acquired, and resets priv->vector_num
> to 0 before returning.
>
>> Call put_vector() for every acquired vector before returning the
>> error, and reset priv->vector_num to 0 to avoid a NULL deref in the
>> subsequent hns3_nic_dealloc_vector_data(), which iterates
>> priv->tqp_vector (still NULL after the kcalloc failure) using
>> priv->vector_num.
> [Severity: Low]
> Is this the right reason for the priv->vector_num reset? As far as I can
> tell, no path calls hns3_nic_dealloc_vector_data() after
> hns3_nic_alloc_vector_data() fails.
>
> In hns3_client_init(), the failure jumps to a label that comes after the
> dealloc call:
>
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_client_init() {
>      ...
> 	ret = hns3_nic_alloc_vector_data(priv);
> 	if (ret) {
> 		ret = -ENOMEM;
> 		goto out_alloc_vector_data;
> 	}
>      ...
> out_init_vector_data:
> 	hns3_nic_dealloc_vector_data(priv);
> out_alloc_vector_data:
>      ...
> }
>
> hns3_reset_notify_init_enet() works the same way:
>
> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_reset_notify_init_enet() {
>      ...
> 	ret = hns3_nic_alloc_vector_data(priv);
> 	if (ret)
> 		goto err_put_ring;
>      ...
> err_dealloc_vector:
> 	hns3_nic_dealloc_vector_data(priv);
> err_put_ring:
>      ...
> }
>
> hns3_client_uninit() and hns3_reset_notify_uninit_enet() both start with
> test_and_clear_bit(HNS3_NIC_STATE_INITED, &priv->state). They bail out
> before calling hns3_nic_dealloc_vector_data() if the bit is clear.
>
> HNS3_NIC_STATE_INITED is only set once init succeeds, so it is still
> clear after this failure. That means the NULL deref described above
> cannot happen, with or without this patch.
>
> The reset may still be useful for other code that indexes
> priv->tqp_vector by priv->vector_num while the netdev stays alive after
> a failed reset re-init. One example is hns3_dump_coal_info() in
> hns3_debugfs.c:
>
> 	for (i = 0; i < priv->vector_num; i++) {
> 		tqp_vector = &priv->tqp_vector[i];
>
> Should the commit message name the code that actually depends on
> priv->vector_num being 0, rather than hns3_nic_dealloc_vector_data()?

Acked. The NULL deref in hns3_nic_dealloc_vector_data() cannot
happen because the failure path jumps past it. The real reason
for the reset is to protect code that indexes priv->tqp_vector
by priv->vector_num while the netdev stays alive after a failed
reset re-init (e.g. hns3_dump_coal_info()). Will adjust the
commit message in v4.


