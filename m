Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F2307481;
	Mon,  3 Aug 2026 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739312; cv=none; b=IayEaWiVlzgDLLB3D7AUos+gmj+tz20fAAXD4jp3CxXrM4hqCtXoH1ihrmpbvIPmNVkDJnC3AIoahdstU8Ud757hkGmMIU0FBe3PhAf68HL12pZJ2lj9hTGgll7l029oLmB++Pw9O1InvlYMF1k9uYptCNTJ7gw2q2AppO5FIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739312; c=relaxed/simple;
	bh=lDBS9h3dd0NUqqcXF/N814xxu3Aup7oyLe7Gsrr74nc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3DxJv/EhFxbZqA/rNCNS6FXwwq+b5d7fqHCgAVnl27tpdesCjkWD8bZ7rBQhlWvpdrCH4liIybFCNJkO/YGiCFkEZtwTJLKbfCmjO3OgDUcvNcjBQNxI/AnVl0U21Diuo/Uu8zxF6yvy4K8pinAkt50X7RMa91IDy+iak4xVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nZ4kEZKC; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nZ4kEZKC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lDBS9h3dd0NUqqcXF/N814xxu3Aup7oyLe7Gsrr74nc=;
	b=nZ4kEZKCo+Tjq45/FaqtnNjEloVj9XgLzRd/EgSxwgMncAqGT7Zsb24lQpNieRxkKxbJnab3F
	BGoYgnJrLK3DQz9IKzvskV1DPZeaAhXcndKP0KTEnTgFXkm8BLuiBX56+LgV/quxVjkiexZXmh9
	6Qc7/euBDVDfSIKOsVtS4Mw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hD6Kc3c1qznTVd;
	Mon,  3 Aug 2026 14:32:20 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id F29BB4058A;
	Mon,  3 Aug 2026 14:41:44 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Aug 2026 14:41:43 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <gongfan1@huawei.com>
CC: <andrew+netdev@lunn.ch>, <august.hewei@huawei.com>,
	<chenanwen@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<guoxin09@huawei.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<larysa.zaremba@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shijing34@huawei.com>,
	<tengpeisen@huawei.com>, <wudi234@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>
Subject: Re: [PATCH net 1/2] hinic3: Fix skb_checksum_help() failure handling in Tx path
Date: Mon, 3 Aug 2026 14:41:39 +0800
Message-ID: <20260803064140.1930-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <16ed10bb3470f17fe78b0803a8a550c2c720f3e6.1785727595.git.tengpeisen@huawei.com>
References: <16ed10bb3470f17fe78b0803a8a550c2c720f3e6.1785727595.git.tengpeisen@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> From: Fan Gong <gongfan1@huawei.com>
>
> hinic3_tx_csum() falls back to skb_checksum_help() for unsupported VXLAN
> packets, but ignores its return value. On failure, this can cause packets
> with uncalculated or corrupted checksums to be transmitted.
>
> Fix this by returning the error status of skb_checksum_help() and marking
> the offload as HINIC3_TX_OFFLOAD_INVALID in hinic3_tx_offload() so that the
> packet is properly dropped.
>
> Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")

Oops. This patch was mistakenly sent. We will send a new patch after 24 hours.
