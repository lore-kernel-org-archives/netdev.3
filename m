Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476479;
	b=B139UjldmWgEFf1Hvq5MH3uH+6DrXMy7ltc5nytqVQ25Sm/dyIae7mEwhoxG1/weASQb
	 S5Y8Sjk4BvC9OPyTYLM0BsKXNuiT9lvPccDgvFLM5/Mk1jgInND/rB6QCdvwlD7tOxssn
	 CQBYy5vUf0UA5ra4BpiTrLplAVV0XIG7eAoivBNm6PAxVqxkQbC19aZ4A30Fignhw38R8
	 laEIay+XNSQfH3BFAqwVFOBOmRr/9mmk1hKFHt5KhjVA6bqAMQUWfTtezzIjflvSE55Td
	 Hesa7VzxA5+Og5f/Dfa0EqV6CA+mDWMxmRpahqWJ4yMXJ592kfA+6YJxIxXrgADlQdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476479;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LYSO9/G+nFBoVNURsqyo9sHLReLzezHi8+C++TTDM7Y=;
	b=i327nTTUBNK99eblUdZdP3oM8CLRakRUVvyG0peR784EDcLMTeEg/XX9SmVxU334oZlA
	 856r+18k9tH/sFKVmlUiRS9HQoEhBvpSrsR1dxhBrWT0lsfZynIyn+O7Mmpxg3A7dCIb4
	 GX2GD1d5tU6a58MpqPHsxSQGT1tCi/q5gHnWbXtOt/2dvxUhnkuogny58UovlDpPKfOzZ
	 0n3LUKXZdMVusa5T4v2HiQfpAvpDrU/o+nTweT8v2wobc9xF2dUPVG0iKFz2Jy8FwdgoI
	 vTcOrVOr3UNVqTINu5CzON11cD8OVm09F0sFMvLvhSeoB08KdKIjtlPMnQgmYEZNaRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MJaPo8bf;
	arc=none smtp.remote-ip=95.215.58.177
Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276860A261F
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 09:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6276860A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MJaPo8bf
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MEFt2EAwBQt77VedDYefJ9IZ2Qype05DO122KbkmEHI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794476476; v=1; x=1795081276;
 b=MJaPo8bfsoa2dlVqkiOwG1Zpdv18+RF+Fdz9rYnNYTs8NS/Ndp8g0Z4zz0p3RoXekXkm/hbi
 qQMXHhE2ZjdfCV6yJns1DID7lYaMkWa2WQsOp0scDWYfQ1hxtillXg1YBYUxMSukZkHYPZ0aIZm
 W4MFAQOc2EaIzAvly8HWb2YY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f85c0bce8482aa4e;
	Thu, 12 Nov 2026 09:41:16 +0000
X-Mizu-Trace-ID: f85c0bce8482aa4e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 17:41:03 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1342116488@qq.com
Subject: Re: [PATCH net] net: hsr: clean up synced addresses and allmulti in
 hsr_del_port()
Message-ID: <avWJrwDyT8HJHWSN@fedora>
References: <20261111060143.183670-1-sunwenbo@cmss.chinamobile.com>
 <avULIJLRzOEoefJI@fedora>
 <avUQ5dAMMRlUTNzq@fedora>
 <20261112064459.81535-1-sunwenbo@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112064459.81535-1-sunwenbo@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 02:44:59PM +0800, Wenbo Sun wrote:
> Hi Hangbin,
> 
> Thank you very much for the Reviewed-by and for raising this question!
> 
> On Thu, Nov 12, 2026 at 09:05:41AM +0800, Hangbin Liu wrote:
> > Sorry. I just got a question.
> >
> > hsr_del_port() is called via dev unregister or hsr_dellink() -> hsr_del_ports().
> > The hsr_dellink() also calls unregister devices.
> >
> > The unregister process will stop a device if it's up. And hsr_dev_close() has
> > called dev_uc_unsync() and dev_mc_unsync().
> >
> > Could you share more details on how you performed the testing?
> 
> Here is why hsr_dev_close() does not clean them up in those paths, and
> how the test reproduces it:
> 
> 1. Call order in hsr_dellink() (net/hsr/hsr_netlink.c):
>    hsr_dellink() calls hsr_del_ports(hsr) *before*
>    unregister_netdevice_queue(dev, head). Inside hsr_del_ports(), every
>    port is removed from hsr->ports via list_del_rcu(&port->port_list)
>    and freed. When unregister_netdevice_many_notify() later invokes
>    netif_close_many() -> hsr_dev_close(), hsr_for_each_port_rtnl(hsr,
>    port) sees an already-empty list, so dev_uc_unsync() and
>    dev_mc_unsync() are never called on the slaves.

Oh, since dev_uc_unsync() and dev_mc_unsync() is never called by
hsr_dev_close(), should we remove them from there?

On the other hand, the comment of dev_uc_unsync() said it is intended
to be called from the dev->stop.

So we need to chose one place for these undoes. I personally agree to
add it in hsr_dellink() as all the hsr info is remove in hsr_dellink.

> 2. Similarly, when a slave is unregistered directly while hsr0 is UP,
>    hsr_netdev_notify() (NETDEV_UNREGISTER) calls hsr_del_port(port)
>    before any close/dellink takes place.
> 3. Also, hsr_dev_close() never calls dev_set_allmulti(port->dev, -1)
>    (and dev_close() preserves IFF_ALLMULTI), so the allmulti refcount
>    leaks even if hsr0 is brought down before deletion.

Yes, I see the allmulti is not called in hsr_dev_close.

> 
> Here are the exact test steps I ran in UML (using veth pairs):
> 
>   ip link add veth0 type veth peer name veth0p
>   ip link add veth1 type veth peer name veth1p
>   ip link set veth0 up && ip link set veth0p up
>   ip link set veth1 up && ip link set veth1p up
>   # Create hsr0 with slave1=veth0, slave2=veth1 (RTM_NEWLINK)
>   ip link set hsr0 up
>   # Set IFF_ALLMULTI (SIOCSIFFLAGS) and add 01:00:5e:00:12:34 (SIOCADDMULTI)
>   # Verify IFLA_ALLMULTI on veth0 == 1 and /proc/net/dev_mcast has 01005e001234
>   ip link del hsr0
>   # Re-check IFLA_ALLMULTI on veth0 and /proc/net/dev_mcast
> 
> Observed results on unpatched kernel:
>   [BEFORE DEL] veth0 allmulti_refcnt=1, synced_mcast(01005e001234)=1
>   veth0: left promiscuous mode
>   veth1: left promiscuous mode
>   [AFTER DEL]  veth0 allmulti_refcnt=1, synced_mcast(01005e001234)=1
> 
> Observed results with this patch:
>   [BEFORE DEL] veth0 allmulti_refcnt=1, synced_mcast(01005e001234)=1
>   veth0: left promiscuous mode
>   veth0: left allmulticast mode
>   veth1: left promiscuous mode
>   veth1: left allmulticast mode
>   [AFTER DEL]  veth0 allmulti_refcnt=0, synced_mcast(01005e001234)=0

Thanks, this reproducer is more detailed. Would you please
add this info in the --- part of next patch?
> 
> I will also send a v2 with an updated commit message noting explicitly
> that hsr_dev_close() sees an empty port list (along with your
> Reviewed-by). Please let me know if you have any further questions.

Please drop my reviewed by tag if the code changed.

Thanks
Hangbin
