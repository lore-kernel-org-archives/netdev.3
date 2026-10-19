Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F813A48ED;
	Mon, 19 Oct 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417172; cv=none; b=nJs0glT9ShfTHU6kxQ7Rkc+vvvZzbcMXa7r0pIlz+5m6TPqzLOtrqQwMKMuFmWkdeLg/O73vq54uOIXgYVB+RPWb6XZAAj285GC0awYyQ678zAkjcEkcAzZzGPhcU78Be8pWf3PA8MFsHfJQ+PqwYlXz75LwUsKRkXnYJiKUNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417172; c=relaxed/simple;
	bh=ngUBoix9dtKSnZkI0CS0G87uTOxA5tC/jiZ1VTHUC+I=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iVnUIhViDXoDHKOp0AcESgUVRfD96O9EUHAeKO+mp6glWIchTuS4+Y2ZsdoTbjWrh+WESNdm9b/4a56FIvE74oaunQx89rf6KfSjVdg6SxV0vKGRv4bkePQppbekEUzzacd95xU+d8WlfAl3i81q/0jxtHtq5d/JQbymBByVnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UVeuBwOR; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UVeuBwOR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=czbkqsq2pcEM/rFQZWf8Jk8Y3M/gHEHgTQVhxW29WYE=;
	b=UVeuBwORIcpI+1j7MdhnhLBiIlwt9/I1Cn7XwqNK9939zWEycsaPMkbmIwHrpFQ2kkOBlvdhG
	e9l6RLWLTkJ0VO/qLnbfy9A7eqE9q5rKCv7qmbJiQQ48FMz0wfyhcrsYZd1ds1lRnMRFD+eCATG
	fMH2ox8MkTDb+AFOos4tds8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4j7c8g5WmtzLlT6;
	Mon, 19 Oct 2026 21:39:15 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A36A40586;
	Mon, 19 Oct 2026 21:39:19 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 21:39:19 +0800
Message-ID: <e5715cfc-f116-43ab-a117-38b913b2cd69@huawei.com>
Date: Mon, 19 Oct 2026 21:39:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: hns3: bound debugfs queue-name sprintf with
 scnprintf
To: Haoran Wang <haoranwangsec@gmail.com>, Jian Shen <shenjian15@huawei.com>
References: <179241616311.5916.9868151766207198451@whr>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <179241616311.5916.9868151766207198451@whr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/10/19 21:22, Haoran Wang wrote:
> hns3_dbg_bd_file_init() builds one debugfs file name per queue with an
> unbounded sprintf into a stack buffer.
>
>      char name[HNS3_DBG_FILE_NAME_LEN];
>      sprintf(name, "%s%u", hns3_dbg_cmd[cmd].name, i);
>
> The only two table entries that reach this sprintf use the 11-char prefixes
> "tx_bd_queue" and "rx_bd_queue".  i is a u16 loop index bounded by
> max_queue_num = hns3_get_max_available_channels(handle), a
> firmware-reported u16 with no kernel-side clamp on either the PF path
> (le16 tqp_num, ext_tqp_num, pf_rss_size_max from the hclge config
> command) or the VF mailbox path.  When firmware reports >= 10000
> queues, i reaches five decimal digits and the write becomes
>
>      11 (prefix) + 5 (digits) + 1 (NUL) = 17 > 16
>
> so the NUL terminator lands one byte past the 16-byte stack buffer.
>
> Replace sprintf with scnprintf(name, sizeof(name), ...) so the write is
> bounded, guarding against a potential overflow.  Queue counts below
> 10000 are unaffected (no truncation); in the firmware-misreport case
> the name is truncated instead of corrupting the stack.

Thank you for the report.
However, the number of queues on our hardware will not exceed 10000,
and the driver trusts the queue count reported by firmware.
So this issue is not practically possible.

Thanks,
Jijie Shao


>
> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> index 1347edac7..e186ec940 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
> @@ -860,7 +860,7 @@ static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
>   		data[i].handle = handle;
>   		data[i].cmd = hns3_dbg_cmd[cmd].cmd;
>   		data[i].qid = i;
> -		sprintf(name, "%s%u", hns3_dbg_cmd[cmd].name, i);
> +		scnprintf(name, sizeof(name), "%s%u", hns3_dbg_cmd[cmd].name, i);
>   		debugfs_create_file(name, 0400, entry_dir, &data[i],
>   				    &hns3_dbg_bd_info_fops);
>   	}
