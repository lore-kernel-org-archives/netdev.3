Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445558;
	b=0KhzQT5TT9vA6FXw6wWYqaKKN/rCSVEa3CCntpgastgsxvEOeGDamlSC9MVu6Hdz96Br
	 lXwgXXnPDhLy7mDErVbpW12x5VFRXoGUsRPeDb7mVAnzaHjBvfY1tE1GZ0qKc8Ykfg0xx
	 NyQojBbm0gCxsKenWZsHGtnUKvUHzMmaM6NDflc9R2CTZOB++GmLsxjsSWID3vCtBaNte
	 WWIbfQXrtDjxY8/o4aA19UqUGRN2bIeB4gPmPm/Y3XFK0NkMJ+DZZCVXm2JKSX0SjgSY5
	 CoFJSbfI24LI7IqHbnZZSg8aAsH/KOb7Wlco0wGzUIRhlanK8Q3hUmA7oyjHxCs1wTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445558;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eYwsRxOsEMHA3DkX0f0CV+Z+v0W7uUrlEZM5+4lXwUU=;
	b=0mFUFtfduPFQDwcFlesLSuVWiPxqgaykFJLUKaCgh2LjoiqneZOVSAvWLpDXj9tkMM/R
	 c4vciUfiUU/HqwhGooKdLrJzLnnkWxwHcLNClZhOzvlPNnn4zVA6w3XgCpgmohGWghU4m
	 AUOTmJJaRD4DPZXQuBGaoxnJA32owqdT29dWhUVpWCgcIP1n9lASmiJ9yOQ62wRQMU0B+
	 q972bdu5wOVCaaylAy8Fmro6D8uE2RmhyEGsjhmAGxJJ7Jt6Va+U0Ewis2mCf2JPUBjXl
	 5/hRsL7YWEo0QEm4MfriTxnyUWoxuU229sPpnvk3Sdlj589q3h1e/TdddCtcxBWcTVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RmRbPnJA;
	arc=none smtp.remote-ip=91.218.175.40
Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7172606A33D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 01:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7172606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RmRbPnJA
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sW31Mhk6Zdi3FsOK//N9bHRAgzlVLc7voc1yH7U/NNw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794445554; v=1; x=1795050354;
 b=RmRbPnJAhPUwyMgzbUXtctYoxObMDMxIBvVAgdIKgsXvIqE4kMqtXpRAoSHHd0KJ/mwEPZaC
 bcsEBY1RSCCYMf72KjgfLGFjfvTWjMTKuvfv4KhNVMaCfGiyJWJMuHb5OGAP70gbqPM3dhPxFeh
 mKl4waXK6BS3ltWdWX3G8ACc=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 27b18086ca939e00;
	Thu, 12 Nov 2026 01:05:54 +0000
X-Mizu-Trace-ID: 27b18086ca939e00
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 09:05:41 +0800
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
Message-ID: <avUQ5dAMMRlUTNzq@fedora>
References: <20261111060143.183670-1-sunwenbo@cmss.chinamobile.com>
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
In-Reply-To: <20261111060143.183670-1-sunwenbo@cmss.chinamobile.com>

On Wed, Nov 11, 2026 at 02:01:43PM +0800, Wenbo Sun wrote:
> hsr_set_rx_mode() syncs unicast and multicast addresses to slave A and
> slave B devices via dev_uc_sync_multiple() and dev_mc_sync_multiple(),
> and hsr_change_rx_flags() propagates IFF_ALLMULTI via
> dev_set_allmulti().
> 
> However, when an HSR device is deleted via hsr_dellink(),
> hsr_del_ports() removes all ports from hsr->ports before
> unregister_netdevice_queue() invokes hsr_dev_close(). Similarly, when a
> slave device is unregistered while the HSR master is UP,
> hsr_netdev_notify() calls hsr_del_port() directly. Because
> hsr_del_port() does not unsync unicast/multicast addresses or restore
> the allmulti count, the slave devices permanently retain synced hardware
> addresses and a leaked allmulti reference count after port deletion.
> 
> Fix this by calling dev_uc_unsync() and dev_mc_unsync(), and
> decrementing allmulti via dev_set_allmulti(port->dev, -1) if
> IFF_ALLMULTI is set on the master device, when detaching slave A or
> slave B in hsr_del_port().
> 
> This issue was identified with the assistance of an LLM-based code
> review tool, confirmed by reproducing the leaked allmulti reference
> count and synced multicast address in a User-Mode Linux (UML)
> environment, and verified in UML that both states are properly cleaned
> up upon HSR port deletion.
> 
> Fixes: 36b20fcdd966 ("net: hsr: Add support for MC filtering at the slave device")
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
> ---
>  net/hsr/hsr_slave.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index a546f70f9cc8..bab0c27dd06a 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -245,8 +245,14 @@ void hsr_del_port(struct hsr_port *port)
>  		netdev_rx_handler_unregister(port->dev);
>  		if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
>  			dev_set_promiscuity(port->dev, -1);
> -		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
> +		if (port->type == HSR_PT_SLAVE_A ||
> +		    port->type == HSR_PT_SLAVE_B) {
>  			vlan_vids_del_by_dev(port->dev, master->dev);
> +			dev_uc_unsync(port->dev, master->dev);
> +			dev_mc_unsync(port->dev, master->dev);
> +			if (master->dev->flags & IFF_ALLMULTI)
> +				dev_set_allmulti(port->dev, -1);
> +		}
>  		netdev_upper_dev_unlink(port->dev, master->dev);
>  		if (hsr->prot_version == PRP_V1 &&
>  		    port->type == HSR_PT_SLAVE_B) {
> -- 
> 2.33.0
> 

Sorry. I just got a question.

hsr_del_port() is called via dev unregister or hsr_dellink() -> hsr_del_ports().
The hsr_dellink() also calls unregister devices.

The unregister process will stop a device if it's up. And hsr_dev_close() has
called dev_uc_unsync() and dev_mc_unsync().

Could you share more details on how you performed the testing?

Thanks
Hangbin
