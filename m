Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620C3264E7
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786834162; cv=none; b=JQpFdWko745wQKPg0hEyEKYtRY8DKwP7OnCzNDaLvGfQlefiZWVZJWj70L8XzAkl1ildDVJu6/2E2/virbrpPrYIjCLpQffeXXT5fvPiMlxZDODWF+fnEhyPaRmxt+q45J9xQ4AAuT7UwT7mf2giPJmr2JU/7Quci0LFgYKiE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786834162; c=relaxed/simple;
	bh=lokDz0IxypaSITp5u4H9xLmiV3b+vRQnek1sOczsFKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0HwwJ74PCMutaT2N7sKhuDE3WB4tj8MF0KhHdkJFihC8gmU2fDiZ8raOHqQEfXOVRVflZXElmQMrqV4Vgnei9Lq4GQOdmS/5LYydcuD8AxZidBZxcS2UOudF7ao6y07b7kB/XB4MpkbIj+bFCGLW9/DJzuKW7IoXCukOtOAeaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LczCxTB5; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LczCxTB5"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lokDz0IxypaSITp5u4H9xLmiV3b+vRQnek1sOczsFKY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786834158; v=1; x=1787438958;
 b=LczCxTB57516hGWRUS4y6Gu3hhubT5a55tWcutEQP1plMdGGHGecaTUquSQN1LggaW8daJDX
 ZHotlO2WlghEF8z7LavNJktX9n3YQNpWs9FcE2U4IKCmArSF8TreoYgIgt+zZQRTec9uRJkpEMY
 tgGygMKyAEhcyj9qrdXSCcXo=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (78.152.211.167)
	by smtp.migadu.com with ESMTPS id f3b09c7522b52819;
	Sat, 15 Aug 2026 22:49:18 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e2e7b8c6-c729-4c31-970a-21ddc9f0e7f9@linux.dev>
Date: Sat, 15 Aug 2026 23:49:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] ionic: free port_info when probe fails after the
 port is set up
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
 <20260814-ionic-port-info-lifetime-v1-3-f73b1a06c5f6@amd.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260814-ionic-port-info-lifetime-v1-3-f73b1a06c5f6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2026 01:00, Eric Joyner wrote:
> ionic_probe() allocates the port_info DMA buffer via ionic_setup_one()
> -> ionic_port_init(). If probe then fails anywhere after that, it
> unwinds through err_out_pci, which never calls ionic_port_reset();
> ionic_dev_teardown() and ionic_clear_pci() do not touch port_info, and
> so the buffer is leaked.
> 
> Since ionic_remove() already frees the port_info DMA buffer with
> ionic_port_reset(), call that on the probe error path too.
> ionic_port_reset() returns early when port_info is NULL, so it is safe
> for the earlier gotos that land on the same label before the port was
> ever set up.
> 
> Fixes: 04436595c435 ("ionic: Add port management commands")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index c15c4c705155..2fb8795189b7 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -397,6 +397,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   err_out_free_irqs:
>   	ionic_bus_free_irq_vectors(ionic);
>   err_out_pci:
> +	ionic_port_reset(ionic);
>   	ionic_dev_teardown(ionic);
>   	ionic_clear_pci(ionic);
>   	ionic_debugfs_del_dev(ionic);
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
