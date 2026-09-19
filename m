Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE922EEE96;
	Sat, 19 Sep 2026 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789861660; cv=none; b=gv3AARcbrIai3+gzo1kHND3FGob+MIsNUW8YglzxKIxzPdMWbJ3UCt16eyE/kvHBBXNYUuAnNStUSJkJ41Tb3Ayp+WSSg1s+usbtaWJdpek4bxwWotQAArlM69ASlssRvLIKP/hgp9GinDkC3B2PBpLzXeI3YPxIzS1ye0/cumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789861660; c=relaxed/simple;
	bh=LYW2s0jhrCHMmfNFgh9+/BgoDZgEbzmtPRub0+Hpx+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqp5PZF1dW/bbfR9h7vDFmwZDIGF0wC0HCRcgAqED5ORmTvFDjD7qJmUHFS7e1JDM7horqDczeRf+W6cC/UiNyl3b3yOmop/LhCMbejAH3fOoBVZDvA8lIgyqcSId6ArYEi4QQ4ip57yE2WQLl4DPpzvxsR3NyFqByFNY9pg9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAd3rMlh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAd3rMlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E081F000FF;
	Sat, 19 Sep 2026 23:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789861658;
	bh=RxS96s5AGIbh/qIixzJ1BalDEPH2c28QN15D1BigQAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UAd3rMlhm8L06QmC1sMVsbbmhSGxxDHhI+96DR3UOC5WmoOzE63w8a7UUY1vzayp7
	 TXnHEPoQHFoJetToQZmSYKtomh1CUaTA+mLzXUCj6E86JwLicYLR5TWiXtnpvoeW8p
	 xJ5LAwYKQ3a9LAcJk/R58aOcleUd05+anvJJaLyjZoAjded9nXK4DfQ+1t3SB2zaVS
	 B7oiF0RAbqSiyUIrj8Ym2S/Ok1EGRPKrBIvidJSwjXaw0Yfw8TM3Xl8UjgTEeUIRaJ
	 9iERh2N/OltbC8HFYawwky1N3oyNOkytJ4z6XAfVvOzbeQNEvzCXZ5/flmvGr73Tv6
	 Yk7kIUDwTmTDw==
Date: Sat, 19 Sep 2026 16:47:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: hns3: fix use-after-free in debugfs read
 during reset/unload
Message-ID: <20260919164737.57b74cd7@kernel.org>
In-Reply-To: <20260915132434.1141742-4-shaojijie@huawei.com>
References: <20260915132434.1141742-1-shaojijie@huawei.com>
	<20260915132434.1141742-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 21:24:34 +0800 Jijie Shao wrote:
> @@ -504,22 +524,16 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
>  	struct hns3_enet_ring *ring;
>  	u32 i;
>  
> -	if (!priv->ring) {
> -		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
> -		return -EFAULT;
> -	}
> +	guard(mutex)(&priv->ae_handle->dbg_mutex);
> +	if (hns3_dbg_is_device_busy(priv))
> +		return -EBUSY;
>  
>  	seq_puts(s, "QUEUE_ID  BD_NUM  BD_LEN  TAIL  HEAD  FBDNUM  ");
>  	seq_puts(s, "PKTNUM     COPYBREAK  RING_EN  RX_RING_EN  BASE_ADDR\n");

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
-- 
pw-bot: cr
