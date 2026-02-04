Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211123EAA3
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168311; cv=none; b=c1rl4l+R6vcIxv0afx3VgrPJ5xOAzuc1gfbtEQRQ+nFC7JgdD14/qfOCPvIU/TJ9+b1k0/Ie5KwTy6uhvLVT69nlTiVzLIYAxaF6L2RzTydrZJ5Cv9GDY1LfF4TD/fOM5bAFm3/PwR3Ml4GN5V+OT+tfdLSrLbSxBxMZVy3b1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168311; c=relaxed/simple;
	bh=c7aeB/QS2qFgzPwDIkzKlqnzjLiQt8WK9x/ukRB8PU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKZZ57Y95AZqvph6uF4RERCkrBHZYWyh0M3Qog4clSH9pYkaPP/HcCT0+Gvkj1CRro/MCnjuNp41htKxiUPXW6jHt4XUy85j5lXsHkL58vzzGNH7CNril6VZU5b60bZ6YaLNSjX6b8zDXxj3gJVzsIxPBikrm7aeEtySTAW4SCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PuMupIiX; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PuMupIiX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770168300; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=G8/348ui3HzddqsBmoqkOGcLspSo06MZdbxXPEemx7s=;
	b=PuMupIiXunlIQTKuoxolX2hSnx7+BeGytyzVNL3twlueIbo22+ZN9QHuSWH6sFtAu9D+9Uk8gXqNPfyZ8P9ZPKxMQgxRkiMtN/0LVWI2dBng43H+ym+wQWiXjMA/S5GAO0FoG/Qov8wAAJdlHqipEaQVElKM1XgU+O7ojItdLDA=
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0WyUbZw-_1770168298 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Feb 2026 09:25:00 +0800
Date: Wed, 4 Feb 2026 09:24:58 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Dong Chenchen <dongchenchen2@huawei.com>
Subject: Re: [PATCH v3 net] net: add proper RCU protection to /proc/net/ptype
Message-ID: <aYKf6icX7ZGNqrVq@U-V2QX163P-2032.local>
References: <20260202205217.2881198-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202205217.2881198-1-edumazet@google.com>

On Mon, Feb 02, 2026 at 08:52:17PM +0000, Eric Dumazet wrote:
> Yin Fengwei reported an RCU stall in ptype_seq_show() and provided
> a patch.
> 
> Real issue is that ptype_seq_next() and ptype_seq_show() violate
> RCU rules.
> 
> ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> to get device name without any barrier.
> 
> At the same time, concurrent writers can remove a packet_type structure
> (which is correctly freed after an RCU grace period) and clear pt->dev
> without an RCU grace period.
> 
> Define ptype_iter_state to carry a dev pointer along seq_net_private:
> 
> struct ptype_iter_state {
> 	struct seq_net_private	p;
> 	struct net_device	*dev; // added in this patch
> };
> 
> We need to record the device pointer in ptype_get_idx() and
> ptype_seq_next() so that ptype_seq_show() is safe against
> concurrent pt->dev changes.
> 
> We also need to add full RCU protection in ptype_seq_next().
> (Missing READ_ONCE() when reading list.next values)
> 
> Many thanks to Dong Chenchen for providing a repro.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 1d10f8a1f40b ("net-procfs: show net devices bound packet types")
> Fixes: c353e8983e0d ("net: introduce per netns packet chains")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Reported-by: Dong Chenchen <dongchenchen2@huawei.com>
> Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686f9c50d
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

The issue cant be triggered after 24 hours testing with this patch
applied. Thanks.

Tested-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>


Regards
Yin, Fengwei

