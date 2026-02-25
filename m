Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD02F9DB5;
	Wed, 25 Feb 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012360; cv=none; b=A3e/HzwConaK4ZxEFV0JyZReLLaoHxJAu176aVajhO0OAa6TXUQLVjfM1y5YK6KIETjTtyIBCjvyvBbLp2iHnOAVEIDFIMFl6Iigp3uvWfgu2kFnAly07BqFzYZCKni00xLxdoLBF8lRk7/m8w8IlWRv9cEj4gin8tDOe2dmNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012360; c=relaxed/simple;
	bh=XKrndo/1cMwH6tCT6HfP08LRvXxrccDdJg19PqAQ//U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGRXqCck7OMPRHWK5Z6/b2LxkX+hHCaWoKulPInRagWGuy4BcWD06VgzZOoe8JGLsCnhE8lkhhL/KeWfsbTxz9essh6yvlnnFaIYPyCgN8aFmW5e6f9sNUQJxLF5qwyZKQ1R4ml09asgcZPViViXSakXJhfoarwrQptNkh0kWHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf/MBbdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf/MBbdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61675C116D0;
	Wed, 25 Feb 2026 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772012360;
	bh=XKrndo/1cMwH6tCT6HfP08LRvXxrccDdJg19PqAQ//U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gf/MBbdql4ZpBiBZu7GT+iuSbJHPKpFahk4gPDYXRnluxyT6BAVJ8hE86zJY1vTVc
	 YytF2mrccI4wnTW8y/YyoqU+DcdD7XlUQCXJw8rmh+kEAQcCXVBDWwDZUW04QbHcVV
	 hxBcN2iCr1KdqJuH1FSwjn/jaHgfPodxv6RmrX6AyB745PnZie1CWKuGBbk/jOyKge
	 tScOCFg1L8nAYd3gVxyj7OiGwHSqacUN83rPfyB9zs9eCah5qRE97Bee6cxErZVIzJ
	 EbmkbvpudtrFsTTn9bzAx30YOILymmV4DQ62My0BJfD9cW4aYxqRhSzogMEK3kf5TQ
	 Koq3XMlmLzYvw==
Date: Wed, 25 Feb 2026 09:39:17 +0000
From: Simon Horman <horms@kernel.org>
To: tomasz.unger@yahoo.pl
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: pn544: i2c: Replace strcpy() with strscpy()
Message-ID: <aZ7DRf4U7urXmmAE@horms.kernel.org>
References: <20260224072242.32551-1-tomasz.unger.ref@yahoo.pl>
 <20260224072242.32551-1-tomasz.unger@yahoo.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224072242.32551-1-tomasz.unger@yahoo.pl>

On Tue, Feb 24, 2026 at 08:22:42AM +0100, tomasz.unger@yahoo.pl wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> strcpy() does not limit the number of bytes copied which can lead to
> buffer overflow. Replace with strscpy() which is safer as it limits
> the copy to the size of the destination buffer.
> 
> Compilation testing:
> - checkpatch.pl: 0 errors, 0 warnings
> - make drivers/nfc/pn544/i2c.o: compiled successfully
> 
> Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>

I am wondering if this is more of a cleanup, or more of a bug fix.
IOW, can an overflow actually occur?

Assuming that firmware_name is derived from user input I would suspect
that this is a bug fix. In which case it should be targeted at net.

	Subject: [PATCH net] ...

And have a Fixes tag denoting the commit that introduced the problem.
It should go immediately above your Signed-off-by line; no blank line in
between.

Otherwise it would be best to explicitly target this patch at
the net-next tree:

	Subject: [PATCH net-next] ...

AI generated review flagged that this looks like a bug fix.

> ---
>  drivers/nfc/pn544/i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
> index a0dfb3f98d5a..7261e12aa6b5 100644
> --- a/drivers/nfc/pn544/i2c.c
> +++ b/drivers/nfc/pn544/i2c.c
> @@ -526,7 +526,7 @@ static int pn544_hci_i2c_fw_download(void *phy_id, const char *firmware_name,
>  
>  	pr_info("Starting Firmware Download (%s)\n", firmware_name);
>  
> -	strcpy(phy->firmware_name, firmware_name);
> +	strscpy(phy->firmware_name, firmware_name, sizeof(phy->firmware_name));

phy->firmware_name is an array.
So you can use the two-argument variant of strscpy() here.

>  
>  	phy->hw_variant = hw_variant;
>  	phy->fw_work_state = FW_WORK_STATE_START;

-- 
pw-bot: changes-requested
