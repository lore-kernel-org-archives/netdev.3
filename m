Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93B1624C2
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744773287; cv=none; b=AEhv0A9TBrMzDNqWSyhWO3+amY1tO7wdJPVHIpPe9S8efmYkXALpXDEIvsB0Yf9FndeoHbYHJYPKHWh84q+8xE7uNheS3TGAatOEaWzT8P9V+Hw/F2VJUBuk7BkGCFuFMmEUJrbu8CaUBEp7QXoWPk7Ju19lxgxGDieYnmtcT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744773287; c=relaxed/simple;
	bh=P+V9H7OxDQFCx24xoaX/D1gCzBkD8vFIc44yAX4Hyrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9kQt9WDwfJQ59cTCixz7wrNxe/WHEhF0Sl0NEYOOvF+rbWGi6gCdp6WHFzQQIBZK7oMJ1PS9PQujWKavSoRxWyAp2XRO7ZHN/xwyF2WR01Ys5uV4+AeY3aOsbMnrgSHCgUMcrpHMe+FqdVYwI79hokCHWMTftfR2GgsiEAI/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcnSQCMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcnSQCMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6EEC4CEE7;
	Wed, 16 Apr 2025 03:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744773286;
	bh=P+V9H7OxDQFCx24xoaX/D1gCzBkD8vFIc44yAX4Hyrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XcnSQCMHqXsPJnmLP44jKx+qxrvElFkd5r47irQkS/AC34aL0imLORDo0IilxGJE1
	 N1KnnJvBj/bi0kXKcTjMTBzQ0reOxDxrP6XdJLCH9YOnJ/N26QjG2uus2dUxusaFON
	 DErvwjp8fEiWmumIRvxpEPeK6IGWg0SV7mlyU08AISww2m2NYcX7Whr2/dT4qBBJ+d
	 x1MWbNAohL+T+MaY+0J+RAJGkRUNIlLjM1Hmt9F6TSv54sR/cZTJjDhvVRClzveLOp
	 Qn9XZwklQnirNLq66fTLz3NU+3pfYYyTd1DLmgzAlR819GuK78B9xHQBmtOTk5JzE8
	 h1kMvHtTCLxFQ==
Date: Tue, 15 Apr 2025 20:14:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 1/4] bnxt_en: Change FW message timeout warning
Message-ID: <20250415201444.61303ce7@kernel.org>
In-Reply-To: <20250415174818.1088646-2-michael.chan@broadcom.com>
References: <20250415174818.1088646-1-michael.chan@broadcom.com>
	<20250415174818.1088646-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 10:48:15 -0700 Michael Chan wrote:
> The firmware advertises a "hwrm_cmd_max_timeout" value to the driver
> for NVRAM and coredump related functions that can take tens of seconds
> to complete.  The driver polls for the operation to complete under
> mutex and may trigger hung task watchdog warning if the wait is too long.
> To warn the user about this, the driver currently prints a warning if
> this advertised value exceeds 40 seconds:
> 
> Device requests max timeout of %d seconds, may trigger hung task watchdog
> 
> The original hope was that newer FW would be able to reduce this timeout
> below 40 seconds.  But 60 seconds is the timeout on most production FW
> and cannot be reduced further.  Change the driver's warning threshold to
> 60 seconds to avoid triggering this warning on all production devices.
> 
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
> index 15ca51b5d204..fb5f5b063c3d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
> @@ -58,7 +58,7 @@ void hwrm_update_token(struct bnxt *bp, u16 seq, enum bnxt_hwrm_wait_state s);
>  
>  #define BNXT_HWRM_MAX_REQ_LEN		(bp->hwrm_max_req_len)
>  #define BNXT_HWRM_SHORT_REQ_LEN		sizeof(struct hwrm_short_input)
> -#define HWRM_CMD_MAX_TIMEOUT		40000U
> +#define HWRM_CMD_MAX_TIMEOUT		60000U
>  #define SHORT_HWRM_CMD_TIMEOUT		20
>  #define HWRM_CMD_TIMEOUT		(bp->hwrm_cmd_timeout)
>  #define HWRM_RESET_TIMEOUT		((HWRM_CMD_TIMEOUT) * 4)

sysctl_hung_task_timeout_secs is an exported symbol, and it defaults to 120.
Should you not use it in the warning (assuming I understand the intent
there)?
