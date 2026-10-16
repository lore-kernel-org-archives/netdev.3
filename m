Received: from mta1.migadu.com (out-165.mta1.migadu.com [95.215.58.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FD175A9D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150472; cv=none; b=lk2sppWhk+AjJP8KWwepfoSDMbybnanJSLYUBjuFmt7ETfs5HHeo3ah1/pdPoMha6IB0gMS+gEOMKBm2T+kn9pilJARXLNSn0Oj1UExZvo+dwjQzwuw/T71bpxe8ykNlEZyrKuuAoABZTJUt5aGHRx+f64+VMGmAmpvdGE0ZlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150472; c=relaxed/simple;
	bh=E28xc10AXBaouq/B1tCfQGvjp/UVGM39AN6oYjARyXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drTSBWaCFBfTivMtIjNep7Tb+RkcT/CPQ2Zv/fg/sIJwT4XDNAi6dRJx9WXhpadFxu4NH1RTbRYAwd91m1CRAcXds4vYn9ikHr06yF/cr5PzgA+b9J99WFr4buu0EbO2h4V48F27nzHpD4nv6ReHBDPKN1dDm+06xbFKV+I/kbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mqs9vLjK; arc=none smtp.client-ip=95.215.58.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mqs9vLjK"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E28xc10AXBaouq/B1tCfQGvjp/UVGM39AN6oYjARyXk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792150468; v=1; x=1792755268;
 b=mqs9vLjKzITgwL5iNR7agF+yOCWM5YyiActlgcdoBcgfTL06uhINSDJ47BUS5Vie0VP1vVKG
 6PkztRsPUwf3yOKOAM8V4/4ijVtAv4pYMoqFycaVB8AxXutVm8cnmy34TWo75ugN7cVFjdQ50Zd
 Yg18CNZXs6gTJgQ3ZoneT+Zg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 644e95254bd8df8d;
	Fri, 16 Oct 2026 11:34:28 +0000
X-Mizu-Trace-ID: 644e95254bd8df8d
X-Migadu-Flow: FLOW_OUT
Message-ID: <84d3e516-2e3a-4f0f-bc8f-b1be267f1bd0@linux.dev>
Date: Fri, 16 Oct 2026 12:34:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] ionic: free port_info when probe fails after
 the port is set up
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
 Eric Dumazet <edumazet@kernel.org>
References: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
 <20261015-ionic-port-info-lifetime-v2-2-57232013fd79@amd.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261015-ionic-port-info-lifetime-v2-2-57232013fd79@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 00:03, Eric Joyner wrote:
> ionic_probe() allocates the port_info DMA buffer via ionic_setup_one()
> -> ionic_port_init(). If probe then fails anywhere after that, it
> unwinds through err_out_pci, which never calls ionic_port_reset();
> ionic_dev_teardown() and ionic_clear_pci() do not touch port_info, and
> so the buffer is leaked. The call was lost when the setup code was
> moved into ionic_setup_one().
> 
> Since ionic_remove() already frees the port_info DMA buffer with
> ionic_port_reset(), call that on the probe error path too. Every path
> to err_out_pci runs after ionic_setup_one() succeeded, so the BARs are
> still mapped and the firmware gets a PORT_RESET before the buffer is
> freed, the same order as in ionic_remove().
> 
> Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 05f19489ec5c..68b3bceedd99 100644
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
