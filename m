Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7351EDF7;
	Wed, 23 Sep 2026 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167857; cv=none; b=V1Yn5r5XoAdB55fV7mdpw3k0rb2UDIIH/rHxBjT2CI4XuEozqkDE+fSF4T3RuhasYhS4+laqR9IOMwaCqZi2hUfmDftlJg+dwh40WwK8fGxwJeoEINYEvOyTumQW4ffzrt3KD1RUpaaXq4hN79KaE9nCWuEwc0jbBWdnjHoAHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167857; c=relaxed/simple;
	bh=j1lTbxY9DY9zBeybvKWKFOvt5NnOUI+YBT9gMIa0CZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKsf/v1QJ+e8C2VElWSpSnSaLguXFyCAcDE1AqQoK60SETvRIixVc0MRv5z29yKiV+lxIBGq/OcjwHBySfXI18CtdXK7JfpbvbmRAt//SXy8wiJgOW7GewYu35mJkpowi945WhL/F00JnJRjB4A0MjJCPoVa6NZRPBNQniCJ06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xoCiV1Yd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xoCiV1Yd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=15dX0WlwKL5bcJMOivsSURnwdcljPC6/Eyv5kiJGgNQ=; b=xoCiV1Yd8jTY6caTFeswdyRugj
	h+2ypVn+EzOauLmoSBxXPaiBS0ngaPMZjo8tp0P+rFdnqKX/6zWzCBeKth+pAfQ3s+lHBlHTrfR5K
	vkI4ueuiM24bdfOFVh4CDL71kurS1Ibp9kRakgvIlRVn/1TkpPWgD8Tu7oxhpxwyEOZc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9MQq-006nyx-7X; Wed, 23 Sep 2026 14:50:40 +0200
Date: Wed, 23 Sep 2026 14:50:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
	mohd.anwar@oss.qualcomm.com, maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Nord ethernet followup
Message-ID: <aa9f1765-ca8c-445e-96bb-4c768ad55623@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>

On Wed, Sep 23, 2026 at 04:49:18PM +0800, Zhangfei Gao wrote:
> This series verifies Mohd Ayaan Anwar's patch set:
> 
>   net: introduce Qualcomm XPCS support and add Nord Ethernet plumbing [1]
> 
> Tested on both IQ10 RRD and Ride
> 
> The full test branch is available at:
> 
>   https://github.com/zhangfei-gao/kernel-topics/tree/next-9.23
> 
> 
> [1] https://lore.kernel.org/linux-arm-msm/?q=qcom_xpcs_nord_emac

Please don't submit two overlapping patches for the same driver. Wait
for the first patchset to get merged, and then submit a follow up
series.

Qualcomm has a number of Mainline Linux mentors. Please talk with
them, because these two patch series are not great.

    Andrew

---
pw-bot: cr
