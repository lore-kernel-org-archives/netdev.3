Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67626461F
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786202004; cv=none; b=XOp5YZEL1y9XGicg26ocDq2OTryKFU1J1JkhTwMadmy3xXPQq9x1kBKwIlaks6nbhiHi6qGhelAGu489MnYaY9ircTqgnH7ULYWK838E9yDapnN71KKjNX99SKnSSDSKh64Mxbg+70QMZSD0U2IAp/8z1TT21cYmzpRct5T7lt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786202004; c=relaxed/simple;
	bh=WJH+8IqmNtscHm2WyRAf0sCTvIhfQqttwIcZRtgObcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLPqCmi5oOa5oDWH/AExkmdaiDTAz+Z8uGGB4CJ7t7w8VyaLfnf67BtVkqv//Nc/h0RphHuXe5HHOeLABmMHYBx4r7aed9+z3otFhbNnhQ5C8Erf7yI1/cw90k4bi9GVpGg/mJIKZXIuy9zcj8j1ldebPQVSPH2Uv1uexvtmz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=AIPdSLIM; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="AIPdSLIM"
Received: from x1 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 678FCVZu064188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 9 Aug 2026 00:12:33 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=TjlojJqpqwFBXJccLpfHW5A7HL5tc1lsm4KFxaoLpJE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1786201953; v=1;
        b=AIPdSLIMrRGjJTKSYcEQr2lhWm6XhlxNCVHz80VszqlWMfoESsQf2PHqKSIDQMwy
         fcXsw2g3YL6JEsTHcpPQ7Z0wUlxhDoQe3Ezqkpw09ULOGe9wpppACDbxbHvuUjnd
         c3BXXO9JJKg9LpKLx4dASklq9dRTOVZslFKlktvkDzFKfHkBXBD98FMHvzihMAdi
         WO8ciQqmNxxQ0rSUAeKRRqvpHg7GsO3ciI6tWrSa9ABwtOEjQSGXSZ1ieXyzsTVk
         8Zdm/hl76j7qcUq3G8/mCtnCOLKWp76bFqdEFAa+F44kEKe6rcvTqqEokBvb97kh
         516vWAiMtUHXsDfGWQERPw==
Date: Sun, 9 Aug 2026 00:12:31 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: pavankumaryalagada@gmail.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
Subject: Re: [Intel-wired-lan] [PATCH] e100: prevent shift out-of-bounds in
 e100_eeprom_load
Message-ID: <andBqsDhcLG9vDmn@x1>
References: <20260807145626.52692-1-pavankumaryalagada@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807145626.52692-1-pavankumaryalagada@gmail.com>

On 08/07 20:26, pavankumaryalagada@gmail.com wrote:
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> 
> When reading the EEPROM address length, e100_eeprom_read() can return
> an invalid length (0 or >= 16). Passing an invalid addr_len to bit-shift
> operations causes a shift out-of-bounds, triggering a kernel panic or
> UBSAN warning.
> 
> Validate addr_len after reading it from EEPROM and return -EINVAL if
> the value is out of bounds. Additionally, use 1U to prevent
> signed integer overflow when calculating eeprom_wc.
> 
> Reported-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Tested-by: syzbot+e0abb1d45ac291ebebeb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e0abb1d45ac291ebebeb
> Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> ---
> Tested using syzbot c reproducer.
> ---
>  drivers/net/ethernet/intel/e100.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 29960762e64a..1de5cd41ea0c 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -744,7 +744,12 @@ static __le16 e100_eeprom_read(struct nic *nic, u16 *addr_len, u16 addr)
>  		 * complete address.  Use this to adjust addr_len. */
>  		ctrl = ioread8(&nic->csr->eeprom_ctrl_lo);
>  		if (!(ctrl & eedo) && i > 16) {
> -			*addr_len -= (i - 16);
> +			u16 len = i - 16;
> +
> +			if (len > *addr_len)
> +				*addr_len = 0;
> +			else
> +				*addr_len -= len;
>  			i = 17;
>  		}
>  
> @@ -765,7 +770,15 @@ static int e100_eeprom_load(struct nic *nic)
>  
>  	/* Try reading with an 8-bit addr len to discover actual addr len */
>  	e100_eeprom_read(nic, &addr_len, 0);
> -	nic->eeprom_wc = 1 << addr_len;
> +
> +	if (!addr_len || addr_len >= 16) {
> +		netif_err(nic, probe, nic->netdev,
> +			"Invalid EEPROM address length %u\n",
> +			addr_len);
> +		return -EINVAL;

An invalid address length here appears to indicate an unexpected
response from the EEPROM, rather than an invalid argument. Therefore,
-EINVAL seems somewhat misleading. Would -EIO be more appropriate here?

Also, e100_eeprom_save() seems to have the same pattern. Shouldn't we
fix that as well?

> +	}
> +
> +	nic->eeprom_wc = 1U << addr_len;

The commit message says that the U suffix prevents signed integer
overflow. However, after the validation addr_len is in [1, 15], so 1 <<
addr_len cannot overflow an int. I think what prevents the out-of-bounds
shift is the validation, not the U.

>  
>  	for (addr = 0; addr < nic->eeprom_wc; addr++) {
>  		nic->eeprom[addr] = e100_eeprom_read(nic, &addr_len, addr);
> -- 
> 2.43.0
> 
