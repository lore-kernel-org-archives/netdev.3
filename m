Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205641;
	b=yk46Kr/iZQ6ZJ/a14ek1hEMKX8P2GKmQcIlITr9hoJCBtRvlY0ccXxfy97xkTHgvsVWy
	 LVisCfZPCcUm7gH3lV2NknfoG29EonU3NmVYyiDxsLh7B2R/m35EJEMx07zQBz9Zj7CMd
	 l23gm+MYGRu3wSZIe4Kn07VOyd3DwnGE8zXy7Qu/BF2+s9tm9By1RZySd3YrlfjI/B0Un
	 KCaHnto8OQUnDa1LBstD55Qzhhos5qN69AkYovUmxIki3ge8/gsvPbi8WIIEisFVsELOc
	 epuR54p7CSiXSaeNgBmOYxVkWfAQ0QfJ0h46cRUpoiskRS+Bbc8RgstY+2svyjENJXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RrjLlhXlsTBJQvU+0OVHuCcgO374simGYgOAp8wYDYQ=;
	b=CPeKMIY1XapcwEumuegT587EPcocFgpcEXkLA3JdMiKPT3/eyKuF0GTamvK+D6b5eMnQ
	 x5GoZEDd0w1is+wwsPL6bN/z0IHg8cfhF84qBWAIOJXTDF4JZKCD7pSc0D7FzRUbhDMpB
	 NEbXWltlsQryi1hFF+YXUMFTkFZyvy2DK1/KbapEOUgfSOjvd5awXUj7Q07TH8OmLn5dC
	 SviAcgQaf3niDt/k9UEiaNWnqatfmXOl3olzs5RU7YPBd6fONj6YU5OktXnkt1lA2LMJf
	 98G/lmJ8kGAapgrS+VDkM0tLKw/LAFvyoEz22SPPP+bP9WrEt32e3xNYhcKoAOWzsWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gZMgiQxJ;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE95606A32E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE95606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gZMgiQxJ
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so480873eec.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793205640; x=1793810440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RrjLlhXlsTBJQvU+0OVHuCcgO374simGYgOAp8wYDYQ=;
        b=gZMgiQxJGDN7+YwANCrMYij7lOMaNVG06N8VFKlbruMrQvwINHYw6HG4oH8XGTZepm
         aSNjLBbNAcnXG09ZcsjZNP+Zbw8NTALhUdj+GpkqUgYuqRwA9lvHlsFZhqajvtjDvB2j
         DH+MJ+5P7OcfuAFkf2QX110g5Kn99XMFFhgkfiGeyt1fmUbpK4V2bLMOaChxOSTTuLKk
         XHm7qhrHiaEY5e6tJ7zedxdQqrh1pxoA/zlh0ydctBuVqCutz5UoFRqza+GvyviGOctc
         CCLO/OH9goRt+q5Ou73AMJKexPwTVyc7YIw/BXWMQc3SvvNe+aFZiBWYdwZ4rZ1xWW3T
         l8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205640; x=1793810440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrjLlhXlsTBJQvU+0OVHuCcgO374simGYgOAp8wYDYQ=;
        b=v6Y93YIV2pNvfLOQdbLU/uKFTPfbMpwuPKqrfb6HMqYeml+NyIuS+CQQDx8dVsrPgM
         xOhctDk6YaxdbSmmlXR5ipUaRFy/dCxP5bHyRH2AVwi9bjZ5wneSKjOGtb89l8YnLNM8
         hvOmH7bGbGSnxYhTy7anaYiSsvYMTRUwmU/NSmFcLvKvw86RhvK39FdXovFkYHl64TU9
         QYuGbFvgzJSdvk14lEBi5U3WHdxbT+Aw9H7PT+d8IiEq734CPoJPRkoTvrlK2sFOQEcG
         5GFsqPlGx0mrrPIew2oAURS6d7E3fp3C8D1AfMYiIVcf5XYO2xmUtMtzaj+OvvKABa3k
         eatQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSO0ks6T6ji0Dfl5IiUum7qa59SQy6wS0dSpMLb7V5DdtHPrPgqxOFD+yNCAoi/6MsKPZttyE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlrmsqUzUh1cbFDfZhKGbJuSpeVLp3GooXbpL1ecKDIy3jKXsv
	Tei8SwxUq6nkEWAbHoRTDHL3C7AqQCL2s03ADYusMe4PAOMcxj5HJO1x
X-Gm-Gg: AYBFou0HL97AoWbhR6o0qKwDGOPyfCdvBNTWkSLXyYcRObiWcTxKEe+jpz9rXYlh3KC
	jg5I2waRN0RLGVcUPQnzR4P2rIG/qy0HoKWaU/NO91tYH9LVKC4gXXmw84gkIoZXKA+7PhHdjn5
	RX8Nnfg5U3Dmlo9ekDlRbjnhTpNCwRC+xwQBEbRt74BBjH7nSTYuAJHyJ9B7zA6zjUOzleUrzvI
	fGTOdot6O/NQP6qhjaHouTAC9QTKVRefxUBbFRB7cK5RL2mQE9JX2RAzK/oZWTyP2yNfjLOwY43
	8vic/4k27jscB+gmvF9ouhzwT9JOx/DRbH8JsnDerlMVjpyT5mM1keNjelPX7MJoiLI9EAGZwj+
	792nKwqK6eWTC4tYXc1d63b/XW1rQoLeLSvAFQBoZrz0jhlud5EoCdZqA9CxNGpz4WJxllRW+dZ
	URoAzU9RAcHpEtCSp/p84jYHHqnA0J+auiG7+PdwzG6qUewicZzEeut1rhAhkRrS43PIMCeBQ0V
	Pc3pF1GQiz+BDpyGWuw9gv3aInu2EBLDRi0Un2W3OhLE0QnBwE85eXpkWoEjcN7QTqT1qQQYfhI
	C1xaA2sPzW+ZiBbN4IDMxg0=
X-Received: by 2002:a05:7022:120f:b0:165:55e2:2d69 with SMTP id a92af1059eb24-1a6d2743a74mr3689932c88.46.1793205640184;
        Wed, 28 Oct 2026 09:40:40 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e5c6d4fsm12238602c88.14.2026.10.28.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:40:39 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:40:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Xiaoguang Wang <lege.wang@jaguarmicro.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, lorenzo@kernel.org, alardam@gmail.com, 
	memxor@gmail.com, hawk@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC net] netdev-genl: skip DEL_NTF on NETDEV_UNREGISTER
 rebroadcast
Message-ID: <auIlSW87EVjBfnha@devvm16445.scu0.facebook.com>
References: <20261026063743.1797-1-lege.wang@jaguarmicro.com>
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
In-Reply-To: <20261026063743.1797-1-lege.wang@jaguarmicro.com>

On 10/26, Xiaoguang Wang wrote:
> While netdev_run_todo() waits for the last references to an
> unregistered device, netdev_wait_allrefs_any() resends NETDEV_UNREGISTER
> about once per second. By then the device is no longer on its netns
> device list. Since commit 8a4fc54b07d7 ("net: get rid of
> rtnl_lock_unregistering()"), netns teardown does not wait for such
> devices. So cleanup_net() can run all pernet exit handlers for the
> device's netns while the device still points to it.
> 
> netdev_genl_netdevice_event() handles every NETDEV_UNREGISTER the same
> way. On a rebroadcast it calls genl_has_listeners() on dev_net(dev). If
> genl_pernet_exit() already ran for that netns, net->genl_sock is NULL:
> 
>   CPU0                                 CPU1
>   unregister_netdevice_many_notify()
>     unlist_netdevice(dev)
>     NETDEV_UNREGISTER -> DEL_NTF sent
>     net_set_todo(dev)
>   netdev_run_todo()
>     netdev_wait_allrefs_any()
>                                        cleanup_net(netA)
>                                          default_device_exit_batch()
>                                            (dev not on netA's list)
>                                          genl_pernet_exit(netA)
>                                            netA->genl_sock = NULL
>       NETDEV_UNREGISTER rebroadcast
>         netdev_genl_dev_notify(dev)
>           genl_has_listeners(netA)
>             netlink_has_listeners(NULL)
> 
> If a later cleanup_net() run has already freed the struct net,
> dev_net(dev) is a dangling pointer.
> 
> The splat below came from a 6.6.119-based kernel. The test kept creating
> and destroying SR-IOV VFs on two PFs. It also kept binding and unbinding
> the PCI devices and moving the VFs through short-lived namespaces. The
> VF driver is out of tree:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000388
>   RIP: 0010:netlink_has_listeners+0x5/0x60
>   Call Trace:
>    netdev_genl_dev_notify+0x42/0x120
>    netdev_genl_netdevice_event+0x2e/0x60
>    notifier_call_chain+0x56/0xc0
>    netdev_wait_allrefs_any+0x1ac/0x240
>    netdev_run_todo+0x101/0x330
>    jmnd_vnic_remove+0xb1/0x220 [xline_nic]
>    auxiliary_bus_remove+0x18/0x30
>    device_release_driver_internal+0x19b/0x200
>    ...
>    unbind_store+0x9d/0xb0
> 
> Current mainline has the same code paths. This workload has not been run
> on mainline.
> 
> The first NETDEV_UNREGISTER is sent while reg_state is
> NETREG_UNREGISTERING, under RTNL and before netns teardown can pass
> default_device_exit_batch(), so the device-delete notification has
> already gone out by then. netdev_run_todo() sets NETREG_UNREGISTERED
> before it starts waiting, which is how the rebroadcast can be told
> apart. Skip the rebroadcast, as caif_usb and mlxsw already do. This
> also stops a duplicate NETDEV_CMD_DEV_DEL_NTF going to user space every
> second while the device is stuck.
> 
> Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuff")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> ---
> I'm not a networking developer. I hit this crash in our SR-IOV stress
> testing and am mainly reporting the bug. The change below is the
> simplest fix I could find; if it should be fixed elsewhere, e.g. in
> netdev_wait_allrefs_any(), I'd appreciate guidance or am happy for
> someone more familiar with this code to take it over.

Note, same patch has been reposed here:

https://lore.kernel.org/netdev/20261026221306.3151025-1-namangulati@google.com/
