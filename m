Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.0
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504299;
	b=GxIvPc/vpgKFy2BdZiUuCrYJYZLQsRtffHeQLhbqgHAitU/8yvtM0oY1WHNIhNQeaJwS
	 Xpt1semADQapwL6fSk9hPCrZ4D8QIv5fxJbJdF7tiUhYin36qj8DfibqdafT7UBMmqhdp
	 SYvzqeBVCCG4l8NDhiHrZJ6qoVphBXIphRmBTF4Br8V0cEHyB/oPWHoBfdiPpp7LQlPJW
	 XTzFehuMcXTY9N4yMTGeY2MQpEM/4fd6+km3Fq+VyGSK5+dCklhv8wltU+eMZYCHx6TYX
	 J7fdKW9evVC4Z8LLnb+1DRGucOxs8FBgvy/FQSUd5NsNy3fz+vqG8KqG8NItQvReHJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UEs+nzWRaRp917aoYI9U1JFVkzp5XZBJ5gUnGKU3NGE=;
	b=Eq7wdKSbzjs/24I10oU/Gb7GysA30IXxeILxhXOB9IlgznVbV3kr8FFbt2E4EKpFOnaZ
	 NzdvQzlXe9UoB4m5KWbb5jR6PVYr6OtRuZtpt4/urKFFAO3f4cQhP6HNgZfiNAohkeaDR
	 8dmZQyV9vHXLcifAdutoM9uQEkoTONUkLI1G+oDjEBQJ89qM2mp7Ht4yD685oyBp+QcIQ
	 C7uxgs78FdFqJZSsp6lrqtvi0ByD/J9N3RvqlQSdfcdjsWq9R6gw2bpYRm9Naivj4bjCd
	 9vtohgO/n/K/WMO+oZkKs5T7m/EDJTKV1EXjPyuwxQ98rhwHuaitzjUuNR6Dopoxezg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S4y2j5j7;
	arc=none smtp.remote-ip=74.125.229.0
Received: from mail-dy2-f0.google.com (mail-dy2-f0.google.com [74.125.229.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E1606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S4y2j5j7
Received: by mail-dy2-f0.google.com with SMTP id 5a478bee46e88-3117f9b9e64so13992eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504298; x=1795109098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UEs+nzWRaRp917aoYI9U1JFVkzp5XZBJ5gUnGKU3NGE=;
        b=S4y2j5j7eEmQWSOHqnVtpeUI9RpdBZ9lvLBNkDHNvYXEWFRQI54XWg0Sn7wz79Z77m
         8UoX7W2fsYxj0wFOX/x4blpkW928Nrfc2rxLxYYgIVg0hUedDAxEOyPPaF+kUUcwXne1
         VKjWv1ftJ/6FOBxqdkqKcGhWBgqNzf/niatC5R2jQ0k0LM182TbJl8yVoIREQZTOA0yg
         ZnDLmeH53vcMnOG5FYCoZUlrgWBTitOgd5+q3vY1ucXWdvZ7zd4Wrw1e6PufrYqPfy2Z
         lA/N9rAxMfBlARwHcg09FhIr/jidSK4fhxoennVOCup+lc/pPdxqSkByl4HRPJ5pY2x2
         +jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504298; x=1795109098;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UEs+nzWRaRp917aoYI9U1JFVkzp5XZBJ5gUnGKU3NGE=;
        b=0eBX3K1wht3hpThCXTK2S6kJkvOvVLmP1sYwzSPadyoEXp1ZmyAqYyBYi7wf1lCyPN
         Z5k+W8LrDs/Of5Bl/FJoW5bDa94Iuo+lCHF3Vy69v0JG6RvM1VE67U9WH2w+KwmOH5AQ
         vbfptNICa6KcS/hZK5BsId4dJ5v4iuCKJRwQRGYGxvda2s3zI1vrLZa3IsHvHE9ENRUC
         wTFHeXCFF04IY+TEt/SexyK1BMlPrvu5L9WHzYCgmjbDEHCuC0qXTLxZRvGM0lyoVqeW
         aky13VJg3r3aYfjKDrUo40KNQKvMFI/86xuTBuU3Er+DY40H31P9uVKFrfp52uwjrV59
         5ubA==
X-Forwarded-Encrypted: i=1; AL+hErH0EgiJGo9obGOoAIMBaORd41c2n5c/kpMsX/KkSNPY+Y1SAV/STeThTXZzbbSn4ZPnPzy82fQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SmApEqFOIohuJ0QxdbvsE0wmrBISWuCXOHl9HSMR8h/48pv9B
	Tc8uZc2mglsMw8yuQsrkmZslWUm/RBGCb9zRB7I9RhfC7Gt0dtVzPq3k
X-Gm-Gg: AYBFou1+QXHisgyWY3obhzXVLH9A6KpH4clu5pcdmheUa0ttMDGDoMNTEYCQD91K5jc
	ZFWfo2YR1+vF52OdV7Mh85xKkf8C6yPP9hSgqRKIrx2wocqO1NJ9GwZIYVsUhYJ0XgtmC7XWi0i
	mT3pk3B9sC2iY5Cn4k3X5pL1Lj24YvVH73eZE65xi00Yhl9qlMJbkv09uu4ENz0xz1YCrxgyBYv
	zjYvlEdCfh7BxPu8JFpjo7iEMeTL9Ic5Cd1hyuZnNxFqkxaYaUJ4Tpv0ICzsRP/pfF/3cl0IMp9
	qyA+bhCD+LuJmfxJDe5ITb3lqETfdhNMhJoVVFnyLSe0tnKmtewAZk21U0RFVI0yVDncpxpBTm3
	119haVh+bD0VrViva32hVL+3ZjNz93LvhrwaFa2dbps3WD+K4E9PonKcVi/vxbtytYevpvmNdlN
	XfQ42MbRIXAosDVDy1o7AOSoVq/VqgCqMyTY7q/gvFqeEXB2pvq1UDhO179vDp52bXrwvJl7cA5
	+QEBfXe87lRwHLehy0mpamVy9/u+f6Vt3R54OAQEz0IJWfQ3cestoedb2Sk0JbkiAsCjEb2yIZ6
	1F1V09N8sdmnkVTYTxRM/CQ=
X-Received: by 2002:a05:7301:dd81:b0:36c:dd3b:a3e4 with SMTP id 5a478bee46e88-377deaeab9dmr2596773eec.3.1794504297384;
        Thu, 12 Nov 2026 09:24:57 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:71::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3792624fe41sm1107451eec.22.2026.11.12.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:24:56 -0800 (PST)
Date: Thu, 12 Nov 2026 09:24:52 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	jacob.e.keller@intel.com, bjorn@kernel.org, alexanderduyck@fb.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net-next] net: ethtool: request rtnl_lock for
 ETHTOOL_MSG_PORT_GET
Message-ID: <avX2MdTZePW5ssrq@devvm16445.scu0.facebook.com>
References: <20261111072724.3295527-1-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111072724.3295527-1-xiaolinkui@126.com>

On 11/11, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> port_prepare_data() resolves the requested port through
> phy_link_topo_get_port(), which requires rtnl_lock to be held before it
> reads topo->ports:
> 
> 	/* ports in the topo are RTNL protected, but may be accessed under
> 	 * netdev_lock for ops-locked devices. For now keep them under rtnl
> 	 * protection, as no ops-locked devices have phy_port capabilities
> 	 * yet.
> 	 */
> 	ASSERT_RTNL();
> 
> The dump side honours this, port_dump_one_dev() takes rtnl_lock()
> itself. The doit side does not. ETHTOOL_MSG_PORT_GET is served by
> ethnl_default_doit(), which keeps rtnl_lock only when the device is not
> ops-locked, or when ethtool_nl_msg_needs_rtnl() asks for it:
> 
> 	need_rtnl = !netdev_need_ops_lock(req_info->dev) ||
> 		    ethtool_nl_msg_needs_rtnl(req_info->dev, cmd);
> 
> ethtool_nl_msg_needs_rtnl() has no case for ETHTOOL_MSG_PORT_GET and
> falls through to "return false", so on a device that opts into the
> instance lock (request_ops_lock, queue_mgmt_ops or net_shaper_ops)
> PORT_GET runs with netdev_lock only. Such a device that does have a
> link topology trips the ASSERT_RTNL() warning and reads topo->ports
> without the protection the xarray is documented to need.
> 
> Add the missing case. Like TSCONFIG_GET/SET, PORT_GET has no
> corresponding ethtool ioctl, so it is Netlink-only and always needs
> rtnl_lock.

[..]

> The bug is latent as no device opts into the instance lock while also
> carrying a link topology, so it cannot be observed yet and the change is
> compile-tested only.

Then why fix it if there is no bug? And phy_link_topo_add_port has
a big comment explaining the expectations?
