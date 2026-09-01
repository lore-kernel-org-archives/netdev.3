Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB872C0303
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244291; cv=none; b=IyfY0lzWDRyhv8PEbBpT9qou06EeuJx8xSlVWpcKNOytspAlLcs4grjFROJRv/bLHsOKY9aVnjn8PNEHbUBrLLEgp834VcietuCM1iJD7+2puDS66VshlhRdOm5YgQKyeMm8R+nRMoVP3f1Npva0YmG1ktJLyMFHBnDhkdK+2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244291; c=relaxed/simple;
	bh=jwf8WmkbwBdcg/b7Qk7yq4ug2VUbkvCrJJWEgI/fq2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+aQlh71Snn1GkB81rR78qiKTb71s5hlfoNT+1X9ZbBGfLKo8DbCfse8aw6dO/WhRY6RDa9CuVB0PADFy30YpdBEYlYZ3ldRcdbMdfC33SIKbHZxDP3cllXdsU4k29DPXMzHA7U8WbtYjhl7wiva955Dv/mWiDAkYR1/5NtFDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eaiYeO1L; arc=none smtp.client-ip=91.218.175.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eaiYeO1L"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jwf8WmkbwBdcg/b7Qk7yq4ug2VUbkvCrJJWEgI/fq2A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788244288; v=1; x=1788849088;
 b=eaiYeO1LmOzGhWri43kkzgOpuelayUsCS/PJ3RkkBTMZIXCeMcg/oPkyk3yZmcz8/nNjyHbp
 IgLf4MqbNnMRceO+QKiSSXuNAXEPmVKh0FagThM9lY7OmD17/n5hW33+w8W9SAHTLZyD/ZhXVy2
 T5SfkCSb0xGPk42HqiJ/8PjI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 77e0f26e5b15dcd1;
	Tue, 01 Sep 2026 06:31:18 +0000
X-Mizu-Trace-ID: 77e0f26e5b15dcd1
X-Migadu-Flow: FLOW_OUT
Date: Tue, 1 Sep 2026 14:31:06 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net-next 1/2] netdevsim: add link speed support
Message-ID: <apZxKhKJbopty6wY@fedora>
References: <20260831-nsim_speed-v1-0-7a651ee65738@kylinos.cn>
 <20260831-nsim_speed-v1-1-7a651ee65738@kylinos.cn>
 <043abd17-c896-40a7-901d-a3fc943151bc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043abd17-c896-40a7-901d-a3fc943151bc@lunn.ch>

Hi Andrew,
On Mon, Aug 31, 2026 at 02:24:54PM +0200, Andrew Lunn wrote:
> > +static int nsim_get_link_ksettings(struct net_device *dev,
> > +				   struct ethtool_link_ksettings *cmd)
> > +{
> > +	struct netdevsim *ns = netdev_priv(dev);
> > +
> > +	cmd->base.speed		= ns->ethtool.speed;
> > +	cmd->base.duplex	= ns->ethtool.duplex;
> > +	cmd->base.port		= PORT_OTHER;
> > +	cmd->base.autoneg	= AUTONEG_DISABLE;
> 
> Here you hard code autoneg as disabled.
> 
> > +static int nsim_set_link_ksettings(struct net_device *dev,
> > +				   const struct ethtool_link_ksettings *cmd)
> > +{
> > +	struct netdevsim *ns = netdev_priv(dev);
> > +
> > +	if (cmd->base.speed > NSIM_LINK_SPEED_MAX)
> > +		return -EINVAL;
> > +
> > +	return ethtool_virtdev_set_link_ksettings(dev, cmd, &ns->ethtool.speed,
> > +						  &ns->ethtool.duplex);
> 
> but here you don't appear to block enabling autoneg. I would expect a
> test and EOPNOTSUPP.

ethtool_virtdev_set_link_ksettings will check the cmds and only allow user
to set speed and duplex. If a user tries to set autoneg it will return
-EINVAL. Do you want nsim to return -EOPNOTSUPP specifically?

Thanks
Hangbin
