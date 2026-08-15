Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890B386575
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833789; cv=none; b=F+/X2qc+GgEfyN46BqXebgxGDF+w2leGyeqCfNnSrUdm4VJodkpqqQWY8UZtsD+o/D9/C5QqoIoigBV3BEW1y5QmFpoUPtPD9Odoq5R6jtdFdoUDDvte9+Jm2kaYpBf9lJGOBzMYWV0wu3oLH99we716+Gt+x5gI37tX4Onziwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833789; c=relaxed/simple;
	bh=YDbHe6zDiBlBkCmLPuuwQc6RWcH+Vf80czWNqNhFflY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MflPPwrgqsrPetztce9eUd07uJ2uZoWESq2X6bZFXUJz4LihD1eyquidh8ilUz7OWxKailtfjlX6vEZv5NDoKxwtPyGnOxO4esFhirOR+JRe/DVgwGUIFzYuvQf1scg9uQ/yG+nL/ErlWmLd8bmXYCoZRrtUON16LU+cLx3xWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jzn7nWOz; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jzn7nWOz"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YDbHe6zDiBlBkCmLPuuwQc6RWcH+Vf80czWNqNhFflY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786833784; v=1; x=1787438584;
 b=Jzn7nWOzejwBolxPpSc75H/dLGFTR06CfgmeOzmOjh2JdvDuhoFajeICsmMNG5/YyDbKd143
 /zn+sbcyKP531FRhedLIrXxtvqxuuUaQ16TxXGCfBIl4yUXH75UH+w1KSmzUvKmIazC8FK92+X9
 SajUWDsJ5nD2GZ//pPlRy4dk=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (78.152.211.167)
	by smtp.migadu.com with ESMTPS id 2894ef43e5ff55bc;
	Sat, 15 Aug 2026 22:43:04 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <c68e4423-99fa-4583-a70c-dcf34c54620c@linux.dev>
Date: Sat, 15 Aug 2026 23:43:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ionic: detach the netdev in the PCI reset handler
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
 <20260814-ionic-port-info-lifetime-v1-2-f73b1a06c5f6@amd.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260814-ionic-port-info-lifetime-v1-2-f73b1a06c5f6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2026 01:00, Eric Joyner wrote:
> ionic_reset_prepare() tears down the queues, unmaps the BARs and calls
> ionic_dev_teardown(), but leaves the netdev attached and registered for
> the whole reset window. The ethtool core only refuses to call into a
> driver when netif_device_present() is false, so ethtool ops keep running
> against a device that is being dismantled underneath them, and
> ionic_reset_done() can free idev->port_info out from under one of them
> via ionic_setup_one() -> ionic_port_init().
> 
> The firmware recovery path already handles this properly:
> ionic_lif_handle_fw_down() detaches before tearing anything down; so do
> the same here.
> 
> No matching netif_device_attach() is needed on the way back up, since
> ionic_reset_done() completes through ionic_restart_lif(), which already
> re-attaches once the queues are alive again.
> 
> Fixes: a79b559e99be ("ionic: add FLR recovery support")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Eric Joyner <eric.joyner@amd.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
