Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F73515C9;
	Mon,  3 Aug 2026 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798797; cv=none; b=NlgRtV+VAHzvtdhEd5pqlR1vvVHkrtZLg52gbXLAYNcSBpdoLwcje39xEFd4q2/vioiTKwxsyJVjpHimeexuuvxZT2Ch+/ZqgvhD0cZTknR4veFS3MKxFw/Xc6j/Ocy68mxx2rwfoVT0a9nWiDXlAldWZ4NoFd5wMFwycMVrpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798797; c=relaxed/simple;
	bh=sySkE05hzs9HXf1ZjvI/Qf8yJ/tDfO6DL8UjqZh3Wl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9FFqU8TxcKuB896NJ3dZY8lw1JxyQzsCwmAMf8gyobmg1qKRSkGLUG+pSMYHDfQpTv/HAhW4o0G2HYNdbeW78FFDQIXizHYQEh8zZ3OiS/n1+KBjmfgl/1qRHIVEUlV3ma0bHB2Csofv/PF57A4TwSRWm5YJQETra2wpkVyOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvXam9eA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvXam9eA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1C71F000E9;
	Mon,  3 Aug 2026 23:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785798796;
	bh=H7MIgp5DQSf7LEGFSI/iThrF9g2OEC/R1kuyYte1k3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hvXam9eAv2RGS29JOQqdAXipcSp8D+s1gRENSlUEM3k1NRKodoUMesVqguR2gzHkv
	 SqFib8P46YdSo62DVk/MrsdjYl7azTI2Z5z+9gYZ0aiBgQvCQkgAcpHsEcJv/riqQp
	 RrwEi5ABzPQI0Ne5k9v46Xm7iksL2UZU0DkW9/XYFGCqINQqDKKQ+IwkFBF4LNLkzw
	 C9tWWAUDzzp85mOqn1F8iVHtJBi4NRBar7BVF0o9f38xbjNLAuAMfZvTSjy0uA4y14
	 SsdzW2k92w75r54pgJQ04FaY/7/ADtJpAS9MOvgO+c3m3spS85MfOZFFnBQ17nDf08
	 c+aWT4ouGh/pg==
Date: Mon, 3 Aug 2026 16:13:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: <mohsin.bashr@gmail.com>, <andrew+netdev@lunn.ch>,
 <august.hewei@huawei.com>, <chenanwen@huawei.com>, <davem@davemloft.net>,
 <dimitri.daskalakis1@gmail.com>, <edumazet@google.com>,
 <guoxin09@huawei.com>, <horms@kernel.org>, <hramamurthy@google.com>,
 <ioana.ciornei@nxp.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
 <maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <shijing34@huawei.com>, <tengpeisen@huawei.com>,
 <wudi234@huawei.com>, <wulike1@huawei.com>, <zhengjiezhen@h-partners.com>,
 <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v12 2/8] hinic3: Fix loose success check in rx
 buffer filling
Message-ID: <20260803161314.6d173920@kernel.org>
In-Reply-To: <20260729074450.909-1-gongfan1@huawei.com>
References: <13ebe4e4-d744-4473-bc6e-2742ac0af492@gmail.com>
	<20260729074450.909-1-gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 15:44:50 +0800 Fan Gong wrote:
> > > diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > > index 309ab5901379..389b1c2158be 100644
> > > --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > > +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > > @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
> > >   		rq_associate_cqes(rxq);
> > >
> > >   		pkts = hinic3_rx_fill_buffers(rxq);
> > > -		if (!pkts) {
> > > +		if (pkts < rxq->q_mask) {
> > >   			netdev_err(netdev, "Failed to fill Rx buffer\n");
> > >   			return -ENOMEM;
> > >   		}  
> >
> > Given the subject, curious if a partially populated ring result in any
> > functional failure? if so, then perhaps failure mode can be explained
> > and this specific change be sent to net tree?  
> 
> Thanks for the comment. It fixes a previous review comment of the patchset
> as the following quotes. To see the full review, visit
> https://lore.kernel.org/netdev/20260413171817.1e1eca30@kernel.org/

You misunderstood the comment there.
The concern was not about this function.
The concern is that hinic3_change_channel_settings() in the proposed
patch may fail after already tearing down the old configuration.
Driver should allocate memory and other resources for the queue
_before_ freeing the old memory. This limits the downtime and prevents
failed reconfiguration from bringing the device down.

IOW, when I said "this function may fail" I meant that you can't call
function which may fail after stopping the device and freeing mem.
Not that there is anything wrong with the function failing as it does..
