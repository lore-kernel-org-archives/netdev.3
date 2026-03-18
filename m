Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3C8462
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860213; cv=none; b=mG8DHBRpW+tRyxqMf2CLpapfTETK16oTE19MnyQebrx4L6dzgZKcZ6AdstAddDylrXP7O9YQ2GbM+nGz3v2q3w+MMtzVs0UAJDEvwbnu7zONrnWIBau7xBeSPunpgc6/RejUPfJ1qNOO+ows6QU3iIsd/R/X0/R26pgE2vP9iEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860213; c=relaxed/simple;
	bh=sJbrEl1pTxXEXDgHJMo1Z4R5u31kmTkH6c+QX9al/rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLYinHRosXTGR0I8nIT/7YtcPIuY4HF5IhAZduF83z6dMvDoHikcoumLShJsxhwvzLbfd2aGqaak28s3ZAUHqHOzfwsIvHRM3xwzcNMeij2PIcpmTciQYi05w3npdrwpJeYtwdUB2EYQi2LpymK+ANgjuvb6ymoEQeE+jYwA8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=K0asMe8B; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="K0asMe8B"
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62IIuJEi017320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Mar 2026 03:56:20 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=PfderLH1PeQJs9EdZnKIFcadn6yQyUif1ZtSb/oqtWI=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773860181; v=1;
        b=K0asMe8Bso9Ms0gHC0knLQXE0V905i2fkm+90GcE7+0yepNdl+XmgToKCnGULFcJ
         ng37HOG9o0RqNOvcPHe6FxthSU0ruaSbaOjTjMWc6jrup+ZIuI5+P+nyICZdi8sC
         8uZnLzl58iIgVwVI66oBM6DRvEZrr2hhYnj5fQgAwphdIhNwZT14odCzsFkCLInS
         oZI+yZOjHQqgoWPmT/GG44VKldi9ne0pvv5vaH7TjZZXOhAGgQhE7Wr0QL7Gz4Ov
         XOkoPceBg7+z2T0C/ooHjZexfYMZyTVdZxMDVKuuq9eDwpI/YPqpjGg3cYxrx43k
         V7HbXxXEhU9UckYddlT9eQ==
Date: Thu, 19 Mar 2026 03:56:19 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 3/5] ice: migrate to netdev
 ops lock
Message-ID: <abrzq5_S7p-YjqhE@x1>
References: <20260318163505.31765-1-aleksander.lobakin@intel.com>
 <20260318163505.31765-4-aleksander.lobakin@intel.com>
 <abripOPt4oVu-Ksb@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abripOPt4oVu-Ksb@x1>

On 03/19 02:55, Kohei Enju wrote:
> On 03/18 17:35, Alexander Lobakin wrote:
> > Queue management ops unconditionally enable netdev locking. The same
> > lock is taken by default by several NAPI configuration functions,
> > such as napi_enable() and netif_napi_set_irq().
> > Request ops locking in advance and make sure we use the _locked
> > counterparts of those functions to avoid deadlocks, taking the lock
> > manually where needed (suspend/resume, queue rebuild and resets).
> 
> Hi Alexander,
> After applying this patch (3/5) along with the preceding ones on top of
> net-next, I got some WARNING splats when changing the admin state
> (up/down) using the ip link command. [1, 2]
> 
> Since I haven't looked into this series in detail, I'm reporting the
> splats anyway. 
> I'm wondering why I haven't seen anyone report this type of issue up to
> v3. Maybe there is something wrong with my setup or devices?
> 
> Device: Intel Corporation Ethernet Controller E810-XXV for SFP (rev 02)

Ah, I think I figured out the reason. My adapter accidentally fell into
safe mode. When the adapter is in the safe mode, netdev->queue_mgmt_ops
== NULL and netdev->request_ops_lock == false, so
netdev_assert_locked_or_invisible() complains about not holding the
netdev lock.

Setting netdev->request_ops_lock = true in the safe mode path also
worked fine for me.

---
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9ef258d5ab48..3477c53316ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3519,6 +3519,7 @@ static void ice_set_ops(struct ice_vsi *vsi)

        if (ice_is_safe_mode(pf)) {
                netdev->netdev_ops = &ice_netdev_safe_mode_ops;
+               netdev->request_ops_lock = true;
                ice_set_ethtool_safe_mode_ops(netdev);
                return;
        }
