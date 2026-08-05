Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46793D566D
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960171; cv=none; b=g7f9I8n+hWTwTQNTd/VBlPxidh5tBjnBTykTB9v38vs9l1kd2/eSKTfRlq0IfEbX2OFFMZqjNCQwYEOlYhVAj2Zlze9JCURUz5j65sIor/ydwgypl0g24/rKUe0st0cjQxUvh5dcTk7VkItPuGjBhR15FdpvIA1XIeY59ZTzJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960171; c=relaxed/simple;
	bh=PzZRcZhQFmV4ewefRXZ9vDashnRjjc8Kp9zauHFIrHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk0QEhElUYUF57wQUuTDpE5QnzbSY6Vh8LbEe3lCwZiFw7QUEfHc3/X1RIpnEPTzAMNSyJg331YRyRIxdYBDOsuMb6QM6CQcrXU502DGRCLTPFIfUkieYtBpLTwYnBklgmUWBABcyzH2h2IykS8MfVvHysdhXxrTYkWaYqacW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxiV+ml7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxiV+ml7"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso299513b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785960164; x=1786564964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EbrTOXLeVxsWo074U114gwpQMfyignFAZDFVp0G0ZTc=;
        b=QxiV+ml7n4mskTtv0GsqHyJCQEhWIQEAO0Rkjy/7tQrd0cS4wl/kfFGbOECh3q6jHQ
         LAXGvdT8gmwHOSsyZJP3sPAgH9XUKlJDpxrydaC6tgA2AEvLaWUxeC8e70Lz2zsnyPFF
         g4h2IuctOSzsePJineZaDI/uRuJGVVQzH5qrriLAja1xdsoE7+fnFmGTfoifIi0XMVZ4
         nQJv7VuqU6OD8Wpiio4zwv0LVZfUpeCLEXLm9uY1GHN9BxQoUB7yz94k9yl5Sr0fI9dp
         gWXegW7uimiepAZEWUa3Z2W5k0MVRWBHXnqaAN2nedSxuGOwJXsUZdY+g6ysD7w8n1E9
         ttYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785960164; x=1786564964;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EbrTOXLeVxsWo074U114gwpQMfyignFAZDFVp0G0ZTc=;
        b=Hf0suHrXz1Fxnzz4ZGzziiDxWk1NI4bnBciEwrz5MEvWpz5u6T8/ubkZRjWmt5Xg/V
         4Pon9p1FmBeT86ocru51IaxyCKU/n6VgLyAsxoQnpm2tS5IE/HxpxycD/BtjXtu/6EXj
         JwYDYz6QlQpnZQVIAJYUOeGWiM88f5vjRvjHZwk5ut2fdmFlbJJ7LDzkDx26qCX4N979
         JzcvufFdKlnvJ7K+IXCPDbaXuKxDqAEwNf//iEpRV1z1WoGQCR2SK5Y4+C/5tT4oI+Yr
         5kwUvgd0dj4eDAyD90hbPBzvwrS5MU0LdBq/42B6f5PGjOGZZcPoOAggX2ZlxzD+lvnE
         QAeg==
X-Forwarded-Encrypted: i=1; AHgh+RpMAVSrNW8vgzFw/MBpr4N4VqQwCxKxQLRHwsbMQHbp99zdCHEdBKUKq6TakQr6DG5kwq8K1Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qJLHfZKZrKkGkhFgTnkZA7GhWZG8TtBHesrAjBRGJW59ulG1
	01nhlDyhBY646S3YRWplPt2ig0yfuydPSuD8li9nOo6tkgfyy/k/pkKG0trByg==
X-Gm-Gg: AR+sD10h5JgHckbVVpwr7MRQBko42w7GyjVOmJDurHux5nlwkzipL1Xq20c4U781T5f
	GrTipfKZpDO5rixCsGTV8TM5AZlMtduuXYUbHH0SC3twMYpjDg2Z5I1wRipoIlIGhZD0bJfNHXR
	/g3vrMUsl6Lpy85ztCbDxYUGTcglCoNRZBWE7iDXApL8Yh67RxQqdi0sRG7G3rPgbh+f9vaFvAU
	H+x7Gbqss5TLl8qlcipyyYhmyI9TRIPAhTDYGzSLz6f6hAK3IQ+0KaT3qOhjp8arl5axoWkb5VM
	qIx66s+tv9ztRDZQEt1yKxepktY2m6r27MWNDquES/uxmj66D8u8oTU0hklpRJJfGq7odJI8tWP
	RDL5GSUOu4tgt61J1I8WV+z7iS3nMw6ZdtRid4Jw2WYkBSHAQ/2bPdXSF1FSIJLEYKJSsghfWhK
	Zmu114XRjuxgeTD5qA06Rv9LnIHf2eacLHu0KdlwULppnMFSq62QB6X76lECgu63bEaFjsVbr/b
	Mdvj2BH
X-Received: by 2002:a05:6a00:1827:b0:848:452d:9a14 with SMTP id d2e1a72fcca58-84f41e50e61mr1757709b3a.16.1785960164251;
        Wed, 05 Aug 2026 13:02:44 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708bfae6sm2204233a12.20.2026.08.05.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:02:42 -0700 (PDT)
Date: Wed, 5 Aug 2026 13:02:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, bobbyeshleman@meta.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: hw: reset HDS mode after
 netkit devmem tests
Message-ID: <anOW3YqpLw1iAIZw@devvm29614.prn0.facebook.com>
References: <20260804151040.2755153-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804151040.2755153-1-kuba@kernel.org>

On Tue, Aug 04, 2026 at 08:10:40AM -0700, Jakub Kicinski wrote:
> HDS mode has confusing semantics. On GET kernel reports
> effective mode. On SET kernel expects explicit config.
> Effective mode on GET means that we know the current
> state, but we don't know if it's a driver default
> or user setting. This matter because driver default
> can change automatically when e.g. XDP is attached.
> Explicit user setting must not be lost.
> 
> With that in mind, we can't restore the HDS setting
> like we restore other NIC config. We should always
> reset to default ("unknown").
> 
> This fixes an issue with tests running after the devmem
> test not being able to attach XDP, e.g.
> 
>    Exception|   File "./xdp_metadata.py", line 105, in test_xdp_rss_hash
>    [...]
>    Exception| net.lib.py.utils.CmdExitFailure: Command failed
>    Exception| CMD: ip link set dev ens9np0 xdpdrv pinned /sys/fs/bpf/xdp_metadata_test/xdp_rss_hash
>    Exception|   EXIT: 2
>    Exception|   STDERR: Error: unable to install XDP to device using tcp-data-split.
>    not ok 1 xdp_metadata.test_xdp_rss_hash.tcp
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: bobbyeshleman@meta.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/hw/devmem_lib.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> index 0921ff03eb81..4e6316c7de96 100644
> --- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> @@ -37,14 +37,13 @@ from lib.py import (bkg, cmd, defer, ethtool, rand_port, wait_port_listen,
>      rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
>      orig_rx_rings = rings['rx']
>      orig_hds_thresh = rings.get('hds-thresh', 0)
> -    orig_data_split = rings.get('tcp-data-split', 'unknown')
>  
>      ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
>                       'tcp-data-split': 'enabled',
>                       'hds-thresh': 0,
>                       'rx': min(64, orig_rx_rings)})
>      defer(ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
> -                            'tcp-data-split': orig_data_split,
> +                            'tcp-data-split': 'unknown',
>                              'hds-thresh': orig_hds_thresh,
>                              'rx': orig_rx_rings})
>  
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
