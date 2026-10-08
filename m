Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40A339365
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480760; cv=none; b=s0tt6/coQ9rxqpZ1jprgtPhdSTmeQ7ZZ1tvjzp9JORxXIfWz8zRwg39H/k0hddAZS+G8Mbk3pw4KVgsNFFADBFwj1tNfUh+NscKn+h1Gb3OgbXggJUR6W6krwgYLbGZHUChgmmx3q7JC5qr4B6us5i5oFGbjZV0QR0o/DAWNO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480760; c=relaxed/simple;
	bh=TQ/ch21eXPY+WZmyTzv39s4Z+1Y5GuoEQk1nP6JnE5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGvaV9HqNqKQEr58zZH6Qw2g2RXRODnHz7WGOQ86vcXGO/jyMb2oRvtPTGLPPGjTQVj79gaRX6kP2s5WPxzRaXjNoHgT5M3pqo0ud2UA8/ZkaslA76C/xrswYFPbvHimD9OUtteAogRkW1WbDvbeAckEOoWjmPNbK7HUa0lOIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7jRSeXV; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7jRSeXV"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-141395927feso5343120c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791480758; x=1792085558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gnTgmXhM99ouuKNHNH0R/xPFTDlK1NqFBl9WK8i6WQM=;
        b=B7jRSeXVshHOqho6h9jLvu9m+8E5ojP3If63oxWFca7nb3QI0Xef3L+BizA8G9Crer
         OHHgM4mpIiziJl11kVzU8zPcUZIkTv/eqZQALsZpejKRiF9Kt1JFaYqiuhk9Vwfc6/FX
         Q+zi2LBTPhv68IcafRUlzSUiO+JSdgbjkDFcJkA0Klg/Ow3kRpbuI7N7If6O2xJnj+jW
         EgnOdbm5GnDk2xihTIfqJB6qlvTF0aI3WufwQaqqgeLyIzw+i1eCku3GHtT3Q7tDBklr
         uq5lQxZjBLzX3h1nYnSp/sMGfompQYH5Et9eeVAVPCztFWkr26nd18l+do3O14X3qZM0
         RcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791480758; x=1792085558;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnTgmXhM99ouuKNHNH0R/xPFTDlK1NqFBl9WK8i6WQM=;
        b=ef9vz6weWYE+PZpIIBDsyRb7lUYP2WmTN0TNtj46SXU+yAFjCCugtztus7mFl9AKxt
         6bcJ0c5NZU2bWirWRhz2HDwlsRACnK7076Y7qZPXgCF7LkMnjvEFTIUOyWsJIps6VeYG
         /y3YDrYkcORHBV2YY5RTGXpe9Vjdk6GK/wreXXXYxYnY0okgJdi5IohdU1+gHYcwsCOc
         AkYgq38t5514P4TVxeBKkGI6kbygOl0UYDK37x0mifkqNyvwP/uaVvRAefrlOHLV35SA
         eV7EDQE/qmabAy1Uf3Xh8us4jxFvpGLdFTWGRfJ6Utg1rs4FKdiKMKLeAobHFL+tBkOt
         x1qw==
X-Forwarded-Encrypted: i=1; AKwUvBxaK5d+vVR0UpLtV2h3uFDpbm/iy8OY3FbzrMpWRGA7yoGxUqlTNo7hYKzP3c4O/IseXOcGu54=@vger.kernel.org
X-Gm-Message-State: AFuF++kWCpsruO872Uq1I0TCX1TDGYAfLrflO/z9z2c6EL3I4ekkndL0
	duZV0fT76nO7HvnnYXuAQ/CHEVRkXr8YWH9ZY+HwnSEPrFT0qmw1Mkyj
X-Gm-Gg: AYBFou1A/Zjcc75FsnzZll12892QI96+WmU5XHn3YEbu+HjBoPaEjCQy48KQl0fAKs2
	CaLSJ/jUlM8RxB4zyNJA0kl6zJDhXwlmlkEvtUIYhB/X6JD/JPumNwzW8oqye/y8JrjipQ1g6E6
	3hspLwZ0yRIJ3twQlQ0L8RPCDY++SgQUd6MGuRd3n8qiA8nw+V9c9jlOd5Mq9KIHNicucrVqdne
	BVnAmHrxDLMctf3Udxe7SQ8HZJnpFk+aUQtUYNLc1zJP/MwWqizF5D5b4IkbFoNtuiseMdTl5gP
	k8ktPk1QLmVzb71UcsiQofDQemWIzWFVS5CeyJPUdmhiupJ84UEds7ui5Z6SdcJ0OvdQP4uicKW
	W/tWmfoDgx9s/IUhiLhsbRc58NJB1EUfwmeIlkgfIE62Xz2ovKcJHTkkQn6TaxIPY0WHC24WH1/
	u1VTaYSqiD/rJLTQ+XAimmP2sJqOm7F9C/LusA0lTQCC0b+/eOe/1oMLqofNAKAwB8+9UTutBrJ
	CLXAe7VXy41XvkNgv2VaNc58S+ZbonbUzktUpn0NHF5FXcOoWORt7zMq2l0SA==
X-Received: by 2002:a05:7023:a82:b0:146:85b9:970b with SMTP id a92af1059eb24-162079a691fmr7578104c88.39.1791480757482;
        Thu, 08 Oct 2026 10:32:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::7:f3b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1691ecde1f8sm346196c88.23.2026.10.08.10.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 10:32:36 -0700 (PDT)
Message-ID: <74fdc11c-6e2b-48b3-a29b-392faedddc27@gmail.com>
Date: Thu, 8 Oct 2026 10:32:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5e: advertise tcp-data-split support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, netdev@vger.kernel.org
References: <20261006225925.568263-1-dimitri.daskalakis1@gmail.com>
 <87se2grw3d.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <87se2grw3d.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/8/26 9:33 AM, Björn Töpel wrote:
> Dimitri Daskalakis <dimitri.daskalakis1@gmail.com> writes:
> 
>> From: Dimitri Daskalakis <daskald@meta.com>
>>
>> The ability to set tcp-data-split was introduced in
>> commit 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
>> This commit dropped reporting from mlx5e_ethtool_get_ringparam()
>> without explaining why. commit d347b28c492e ("net/mlx5e: Add hds-thresh
>> query support via ethtool") added support for ETHTOOL_RING_USE_HDS_THRS,
>> and modified mlx5e_ethtool_get_ringparam() to report an hds_thresh of 0.
>>
>> Between these two commits, the hds selftest helper _defer_reset_hds()
>> would skip the reset because neither hds-thresh or tcp-data-split was
>> present in the ring config. After the second commit this introduced
>> a KeyError in the hds.set_hds_enable/disable tests.
>>
>> mlx5 couples tcp-data-split with rx-gro-hw. Users can currently disable
>> tcp-data-split then enable HW GRO. The kernel reports tcp-data-split
>> off, but the HW is presumably splitting.
>>
>> Add back tcp-data-split reporting in mlx5e_ethtool_get_ringparam(),
>> and de-feature tcp-data-split disable. Users can either enable it
>> (if HW GRO is enabled), or leave it under driver control.
>>
>> This is not a fix since the feature is still functional with
>> HW GRO enabled.
>>
>> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
>> ---
>> Changes in v2:
>> - Leave kernel_param->tcp_data_split as ETHTOOL_TCP_DATA_SPLIT_UNKNOWN if the
>>   device does not support HW GRO
>> - Prevent users from disabling tcp-data-split
>> - Link to v1: https://lore.kernel.org/all/20260923230521.1267511-1-dimitri.daskalakis1@gmail.com/
>>
>> hds.py before:
>>  # Interface: eth0, driver: mlx5_core
>>  TAP version 13
>>  1..13
>>  ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
>>  ok 2 hds.get_hds_thresh
>>  # Exception while handling defer / cleanup (callback 1 of 1)!
>>  ...
>>  # Defer Exception| KeyError: 'tcp-data-split'
>>  # Defer Exception|
>>  not ok 3 hds.set_hds_disable
>>  # Exception while handling defer / cleanup (callback 1 of 1)!
>>  ...
>>  # Defer Exception| KeyError: 'tcp-data-split'
>>  # Defer Exception|
>>  not ok 4 hds.set_hds_enable
>>  ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
>>  ok 6 hds.set_hds_thresh_zero
>>  ok 7 hds.set_hds_thresh_max
>>  ok 8 hds.set_hds_thresh_gt
>>  ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
>>  ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by device
>>  ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
>>  ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by device
>>  ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported by device
>>
>> hds.py after:
>>  # Interface: eth0, driver: mlx5_core
>>  TAP version 13
>>  1..13
>>  ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
>>  ok 2 hds.get_hds_thresh
>>  ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the device
>>  ok 4 hds.set_hds_enable # SKIP disabling of HDS not supported by the device
>>  ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
>>  ok 6 hds.set_hds_thresh_zero
>>  ok 7 hds.set_hds_thresh_max
>>  ok 8 hds.set_hds_thresh_gt
>>  ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
>>  ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by device
>>  ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
>>  ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by device
>>  ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported by device
>>  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:9 error:0
>> ---
>>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> index 261c466a4d36..f08a968acec4 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> @@ -378,6 +378,10 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>>  
>>  	kernel_param->hds_thresh = 0;
>>  	kernel_param->hds_thresh_max = 0;
>> +
>> +	if (priv->netdev->hw_features & NETIF_F_GRO_HW &&
>> +	    priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
>> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
>>  }
>>  
>>  static void mlx5e_get_ringparam(struct net_device *dev,
>> @@ -403,9 +407,14 @@ static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
>>  		return false;
>>  	}
>>  
>> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "TCP-data-split can not be disabled");
>> +		return false;
>> +	}
>> +
>>  	/* Might need to disable HW-GRO if it was kept on due to hds. */
>> -	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
>> -	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
>> +	if (dev->cfg->hds_config != tcp_data_split)
>>  		netdev_update_features(priv->netdev);
> 
> Not directly related to your change, but is it correct to call
> netdev_update_features() here? What if later changes in set_ringparam()
> fail? Shouldn't the update be done when we know that set_ringparam() is
> successful? Seems like we can get into an inconsistent state?
> 
> 
> Björn

Good catch! This can cause the kernel/driver to de-sync. I validated this
by setting rx-gro-hw on -> tcp-data-split on -> rx-gro-hw off, then running
`ethtool -G eth0 tcp-data-split auto rx 1`. The driver disables GRO, but
the subsequent mlx5e_ethtool_set_ringparam() fails, so the kernel still
report tcp-data-split as on.

I'll move the netdev_update_features() call to the end of
mlx5e_set_ringparam() to address this.

pw-bot: cr
