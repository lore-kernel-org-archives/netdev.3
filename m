Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517B336897
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559641; cv=none; b=qiv3Eqdu6Qauna7Av7egwqo4N+vzdXidHb84hYdrd2WTYfKoTYw4SMlvBWPhaJMf4MnMYHtR++SRWVB993LM6vUIaH2E9da9m8SyomMCwsjsIvc+Fum8iVl6ytik7hHrLkHLyTHHmZS8Up2m+E536cSMoyt0tSoqkqU1i718s30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559641; c=relaxed/simple;
	bh=fSwbFF5J20s2wFY0Hdz3ckg8kcRWrerizNdWX1h9AKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXL6gEluGSAM7eh0qrV6X9Ce+CK/BYZhL8byNNU1VNOTl8oZPqITuhC0T/kd7/LS6NP3q6Z42oTveE2d8ZFmBLyDC2dFJc3QZKJ6QbJ0RCTg5eVCzCfsPiwEDv8YRaakeS3aTVaSVvP3HASXvn1GPejYUOS8TEJRDsjQMKMHZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MG9tfMLg; arc=none smtp.client-ip=91.218.175.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MG9tfMLg"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fSwbFF5J20s2wFY0Hdz3ckg8kcRWrerizNdWX1h9AKM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790559637; v=1; x=1791164437;
 b=MG9tfMLgK7hjIkE2XKqaWaNooH6GV6x+BHHRo4vSD+rPBdB+T0hg/2D/Fv4pZVhb7rw0b/Zs
 j0a/7fFiIYslACnmQEfiNRXo/N8fYRKay4vUUWCxg1AR0wPthhnkmdmns4N7X799kJlGiJz1jYh
 AeUPIPxjQweSl9wFig9Q31mI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 298b0f888c0bd511;
	Mon, 28 Sep 2026 01:40:37 +0000
X-Mizu-Trace-ID: 298b0f888c0bd511
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 09:40:25 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 6/9] netlink: specs: ethtool: re-align
 module-fw-flash-status
Message-ID: <arnFiazPHNUKul04@fedora>
References: <20260925213918.204767-1-ast@fiberby.net>
 <20260925213918.204767-7-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925213918.204767-7-ast@fiberby.net>

On Fri, Sep 25, 2026 at 09:39:09PM +0000, Asbjørn Sloth Tønnesen wrote:
> Correct the values for enum ethtool_module_fw_flash_status:
> 
> - ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED is 1, not 0.
> - ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS is 2, not 1.
> - ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED is 3, not 2.
> - ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR is 4, not 3.
> 
> Re-align the YNL spec by explicitly setting the first value to 1.
> 
> CC: Andrew Lunn <andrew@lunn.ch>
> CC: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
> Note for Sashiko/Clashiko: Targeting net-next, so no "Fixes" tag.
> 
>  Documentation/netlink/specs/ethtool.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 439bf24e7c33..6868eb473478 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -47,6 +47,7 @@ definitions:
>        -
>          name: started
>          doc: The firmware flashing process has started.
> +        value: 1
>        -
>          name: in-progress
>          doc: The firmware flashing process is in progress.
> -- 
> 2.55.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
