Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF330CD89;
	Tue, 23 Jun 2026 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206098; cv=none; b=NEP0FJT0RoYXuGx2RFx/Pcr9hZizLTIJzsqg12VxbMx4IEACCo+sI+ykcbMOYz1c/yfC18YF8j/aWI0mfK6SU4yShfD1yloYVbAvGVeybCEHno6Ut3qJXnPIHVO6TZXxNvebNAzgvxBHxyT+UT2GiXDesuVTqt6gcYDGSrfIOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206098; c=relaxed/simple;
	bh=ExgVCt1CCPYVVSXX87mcq1UZuQEJGtt5QQwC44gLNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILlcE/Oi4gkngWgvGJuiKVhkcCS6PazPGCSbl5/V31VZGbNQfSkGTPA5mynBqAcUj04PGr+6WCaIwH2s2PErpCQz47JGw1ShnVysDn0FBt0qOmg4uocWrKLBDPP/S5A0anrD+Z5iQHqge2kfwqn8DFZmiuTvCWxPePJj+icJb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=Hb2s/4X/; arc=none smtp.client-ip=45.254.49.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="Hb2s/4X/"
Received: from localhost (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1bc217c60;
	Tue, 23 Jun 2026 10:24:43 +0800 (GMT+08:00)
Date: Tue, 23 Jun 2026 10:24:42 +0800
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yue Haibing <yuehaibing@huawei.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kyle Zeng <kylebot@openai.com>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dst: block BH in ipip6_tunnel_xmit
Message-ID: <20260623022442.uyq5vtciwidezl45@yuangap>
References: <20260622033118.244651-1-yuan.gao@ucloud.cn>
 <CANn89i+hKw-G3jewJoEPgGu-BOWUNuUn0RMdGh5L3B1ubD+OMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+hKw-G3jewJoEPgGu-BOWUNuUn0RMdGh5L3B1ubD+OMw@mail.gmail.com>
X-HM-Tid: 0a9ef24b52aa0229kunmde27a96423c337
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUxCVhlDGkNMSB9MSBlNHVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Hb2s/4X/YHffyORINucWEpcBB40pIywgWk/xqqlCU6oc3bnAWJdpBxieqKp7Sf/V/0vRydWGy7CeCQs5jHr7HzOibYyG2ZvDNlugewBdk975dKKYBQ0aq6hn33RpI/jNuF6pIJZI9Es3nOjEmMNRavPnSp+6JRDYhqLzNrD4TzY=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=aXCiHqlT8yz5PIFvChdkyURa/aetmPB2ZOsvzGXT3LY=;
	h=date:mime-version:subject:message-id:from;

On Mon, Jun 22, 2026 at 01:13:30AM -0700, Eric Dumazet wrote:
> On Sun, Jun 21, 2026 at 8:31 PM yuan.gao <yuan.gao@ucloud.cn> wrote:
> >
> > Similar to commit 1378817486d6 ("tipc: block BH before using dst_cache"),
> > the dst cache helper functions must be invoked with local BH disabled.
> >
> > This ensures proper synchronization and fixes a potential race condition
> > on SMP systems.
> >
> > Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
> > ---
> 
> All ndo_start_xmit() methods already run with BH blocked, can you give
> us a stack trace when this would not be enforced?
> 
> You forgot a Fixes: tag.

Many thanks for pointing that out — I completely missed that detail.

Cheers,
Yuan Gao
