Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15B4189CC;
	Fri, 17 Jul 2026 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296639; cv=none; b=m8sRiKX7Qk3mIV44uO7B3xE8ZxOPJagvk8v4F/ZtrYKPEdui4YX9JGYXTxd4w1Yz7sHSTEL82SpAr8/jYCdA+9VpLOyk80xHO6xbyQp10RlrB9OZrSxV+yBDTKL7HEJdo+KG+g93thEfzZ6NJVkSXMHX9M8FQq7w0EPCukjP4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296639; c=relaxed/simple;
	bh=u10Oa9s+HVhRnTygNXPZpXqKyt010C4L31Eutv0GZWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3iaQMwErMxane2BY3utAR53tYLDPTYCBFEGP9Nw5VKRq1YhQnYx1ZEefcTgRVExH9ZZGVqOIeMkixXQbxHe3ZFGyHSbVE2Io/+fzdGgbwHsutJBC3PyBKnTLCZSCqpG/2ls9Os1vxDxjNAlVt+4w2Pc7tKjGCrBNi0gK+vk40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3fqPkbZL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3fqPkbZL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ktGZVR+N71SiFc5sMXUVRWtPPvPccPAHVEQ6aJHh16M=; b=3f
	qPkbZLDkYv+rBsdi41ZpFDP/PvBSuWTZ5IdogEstyTYdVCPmMqEDMeGGVp8qbFnQ0glsJN1NaSXf6
	h6j6O8ZCWjp4C8d7D6MnI0p2ylgOTr9Z/GW5B51bCKxoSFtPqvMzZ7CuhppOrRfQ42ARt0U//fLYr
	6zmuBfm6lGJv5mQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkj3i-00Cowg-D8; Fri, 17 Jul 2026 15:56:58 +0200
Date: Fri, 17 Jul 2026 15:56:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>
Cc: courmisch <courmisch@gmail.com>, davem <davem@davemloft.net>,
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
	pabeni <pabeni@redhat.com>, horms <horms@kernel.org>,
	"remi.denis-courmont" <remi.denis-courmont@nokia.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZTogW1BBVENIIG5l?=
 =?utf-8?Q?t_v2=5D_phonet=3A_chec?= =?utf-8?Q?k?=
 register_netdevice_notifier() error in phonet_device_init()
Message-ID: <080f4047-2fb7-47ca-a4b7-9cd0683756d0@lunn.ch>
References: <3v5ygapsdjgl-3v61zwni6m6e@nsmail8.2--kylin--1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3v5ygapsdjgl-3v61zwni6m6e@nsmail8.2--kylin--1>

On Fri, Jul 17, 2026 at 02:55:54PM +0800, 何敏红 wrote:
>  
> 
> Hi Andrew,
> 
> Thanks for the review.
> 
> > Think about what happens when phonet_netlink_register() fails.
> 
> I checked that path. By the time phonet_netlink_register() runs,
> pernet, the proc entry and the netdevice notifier have all been
> registered successfully. On failure, rtnl_register_many() already
> unwinds any partially registered handlers, and phonet_device_exit()
> then tears down the notifier/pernet/proc that were set up. So this is
> not the same issue as calling unregister_netdevice_notifier() for a
> notifier that never got registered.

int __init phonet_device_init(void)
{
        int err = register_pernet_subsys(&phonet_net_ops);
        if (err)
                return err;

        proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
                        sizeof(struct seq_net_private));
        register_netdevice_notifier(&phonet_device_notifier);
        err = phonet_netlink_register();
        if (err)
                phonet_device_exit();

If we get here, phonet_netlink_register() failed.

What exactly does phonet_netlink_register() do:

int __init phonet_netlink_register(void)
{
	return rtnl_register_many(phonet_rtnl_msg_handlers);
}

And what does phonet_device_exit() do?

void phonet_device_exit(void)
{
        rtnl_unregister_all(PF_PHONET);
        unregister_netdevice_notifier(&phonet_device_notifier);
        unregister_pernet_subsys(&phonet_net_ops);
        remove_proc_entry("pnresource", init_net.proc_net);
}

So it tries to unregister something which was not registered. That is
generally a bad idea.

The general pattern in the Linux kernel is that on error, you
carefully unwind everything which succeeded so far. Often you do that
at the end, with a series of goto statements and labels.

Calling the "mirror" function on error does not work, since that
function assumes everything went correctly in its peer.

	Andrew
