Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5A4DE715
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070461; cv=none; b=qK/+eiE3DAjyERAkKLfoV+AjjR+kANyAWZ5p2NtLuwHk03oAQbkgRm5B2/nxPsKIfTsyIbg8uh5LW9bYxmW3QXjNGXidJYALI3IYloH+E0JR7rVPAdf2mpRWesb0KdIVhPtjKZjU2TYY6j0XSvMzhWJNomeUF41u8HhLoJByHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070461; c=relaxed/simple;
	bh=2CUH3YGiPlXy555Q9SI3ZYnCZbH8YDJQaUSBvfvqZ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rfyv77v3l0thOtGykaNoH1n8vSISsmTCpu8JNfacp103JYoERiTZTg/QG10jEMRNff8k0gnG/oD2ZpFDgDAXnVjk4LDEWpOfPV/iE4OEzTXqbssAQE2Ne/cZXzkY8J6CpiiHdM4z1iFdSpzp9QnUuQ0oKsoFK2EwgYArdp2CVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvNBStGl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvNBStGl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd78so2166557f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790070458; x=1790675258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1mHA714llFxRbL4YpV3zzI7qdHUQEj56NbS4Oyhz2TE=;
        b=UvNBStGlptbsfoizP0M7WPR8TBH+UhYLVyjoEPDRLeSoLNQuh7GLHz3T5/m0+UmBNZ
         RHrrzsLV0K/1tL1nA+hHnjigNFBMWMqOHkC2hAp9rehOuAlFe8SvIs8Z6CpW3d6rTbbu
         qUN4yFety6ERn2Pq27SISc97Qgyi/FNkA/2oV0hESNH3CrGFm1JB7EYRbfKMluJjr8oK
         ttR4FN9+EvyTCRmk7aGWOVeyliElH3Fme+P3KYATNqyFatLBn3k0NH1gwluMVxzIirTx
         DTowTIQwxpjvhHhSZOLcG5y2+hQWEt9qDuVNyafBzvAUvmydtwW4n5iPhqIUqR/Rgbej
         XPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070458; x=1790675258;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mHA714llFxRbL4YpV3zzI7qdHUQEj56NbS4Oyhz2TE=;
        b=aUsHCXRO1HYUlu+9L+ZtNC0bhQJnPcUBi+gglfKV+iE+s3P2j7GywYRzTQndFW6gQT
         8+OS8/mqB0xV5GCWFEKnVhZxqz07uvqbE75C5lb5HplROt8oBH4qKM0V3WRRCNL9SlCy
         ATgi7M6W+HND37FqBbx9t3G0brW6xzpWhZaesqhqlJVuEHG2b0Bx2a0ierEMi+0ypy5/
         Pwa1COui2MGIdE5WaDk0dMIftzmYF5Fegp7NLZ8J4LhnF6zpsSONTj9Am9qlgFeApidk
         mbhlPF2SJuksdHrROFJfluAUVPscU8fV10HodAE5jij4FRXb+jbg9jU8Lh5occH3Z6CJ
         dkCg==
X-Forwarded-Encrypted: i=1; AKwUvBzynBVUvF1BkI4rOnb74Nhmu4JuC19d/J/ANo5l8gnv+9wr8aBDIe5lf4U893fGeaUBr5rIF94=@vger.kernel.org
X-Gm-Message-State: AFuF++nAZi4b9ciy/ZqnYyhWZi0RflklTIsQPlDTXkBrtQEXjrG0g0ws
	+IjB+tyEvzcMByHQNKUrBmydxmbmz35zczOhJzpiXFK2WKhP2g/c33MlBH7BUOXY
X-Gm-Gg: AYBFou1GWCZUejgrAVA/tA7hvx0OKJ463GF56/aVlCJid1BQe0Afe0o/URh5u/c31UT
	ep59lrpWONi1BtYW4q7ybm9/JLPR3fj8N0pvsOB9w9LQXBji2/G1K9XFM0hICnD/8x/OEu416uA
	PILUPNeNievetW3Z+OAoM1pKyPAq+gRhMk4Z4UQhE9tBmPobxmrf5SBgQuUgxRsOv+M4BjI/9DE
	vELU3kSKfk9nXnZ+bfRbk56pJRig/NNPXvRUJ7nJhvt/oY+Va/4NRP+1CjmJV4XdSUqF2ExseTS
	FvX2qF0cwNMkRlGp9WivYb1pmxZqXTfZQp3cR2ePEwoVzJSiIjgK0c4NpZveZdefVl06sweaW4I
	+BBb0OXJMuwz1Maafr9FCqIw5zfq1GNw8y1SGmx5idvmNrFmq/feDLRh5x9VP39S4Gjie4rIIyx
	f1eGotxTa7PzfV67O7Lidhlakn0xLinA3FWJPsNoVlny2tvP9WvDApkGxYdOpvse1uCXgeo5d64
	1MuiW9h1+FdXHmKJFOJXkxfpdbNPtcvDLs=
X-Received: by 2002:a05:6000:1a8a:b0:487:62d:37dc with SMTP id ffacd0b85a97d-4871e269cd3mr21320913f8f.32.1790070457566;
        Tue, 22 Sep 2026 02:47:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862773ee0sm3708938f8f.6.2026.09.22.02.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:47:37 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:47:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Harry Morris <h.morris@cascoda.com>, Alexander Aring
 <alex.aring@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] ieee802154: ca8210: prevent stack buffer
 overflow in hwme_get_request_sync()
Message-ID: <20260922104736.0e7e20f2@pumpkin>
In-Reply-To: <20260922093126.141969-3-benquike@gmail.com>
References: <20260922093126.141969-1-benquike@gmail.com>
	<20260922093126.141969-3-benquike@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 09:30:24 +0000
Hui Peng <benquike@gmail.com> wrote:

> In ca8210_get_ed(), an uninitialized u8 lenvar and a pointer to a 1-byte
> stack buffer (u8 *level) are passed to hwme_get_request_sync(), which
> unconditionally copies response.pdata.hwme_get_cnf.hw_attribute_length
> bytes into hw_attribute_value without checking the caller's destination
> buffer capacity, overflowing level on the stack when hw_attribute_length
> exceeds 1:
> 
>   BUG: KASAN: stack-out-of-bounds in hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>   Write of size 16 at addr ffff888001907780 by task init/1
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x70/0xa0
>    print_report+0x153/0x4c6
>    kasan_report+0xf1/0x120
>    kasan_check_range+0x125/0x200
>    __asan_memcpy+0x3c/0x60
>    hwme_get_request_sync.constprop.0.isra.0+0xf3/0x170
>    ca8210_get_ed+0x9c/0xf0
>   ...
>   The buggy address belongs to stack of task init/1
>    and is located at offset 48 in frame:
>    ca8210_get_ed+0x0/0xf0
>   This frame has 2 objects:
>    [48, 49) 'level'
>    [64, 65) 'lenvar'
> 
> Initialize lenvar = 1 in ca8210_get_ed() and return
> IEEE802154_SYSTEM_ERROR in hwme_get_request_sync() if
> response.pdata.hwme_get_cnf.hw_attribute_length exceeds
> *hw_attribute_length.

This function is silly.
There is exactly one caller, the only valid length seems to 1 (is zero valid?),
not much point using memcpy() either.

David

> 
> Tested in QEMU with KASAN enabled by passing an oversized
> hw_attribute_length response into ca8210_get_ed().
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v3:
> - No changes.
> 
> Changes in v2:
> - Split out as patch 2/3.
> - Replaced the temporary stack buffer in ca8210_get_ed() with lenvar = 1
>   and an upper-bound check against *hw_attribute_length in
>   hwme_get_request_sync() as requested by Miquel Raynal.
> 
>  drivers/net/ieee802154/ca8210.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index a990a0f..8aa7ffe 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -1677,6 +1677,9 @@ static u8 hwme_get_request_sync(
>  		return IEEE802154_SYSTEM_ERROR;
>  
>  	if (response.pdata.hwme_get_cnf.status == IEEE802154_SUCCESS) {
> +		if (response.pdata.hwme_get_cnf.hw_attribute_length >
> +		    *hw_attribute_length)
> +			return IEEE802154_SYSTEM_ERROR;
>  		*hw_attribute_length =
>  			response.pdata.hwme_get_cnf.hw_attribute_length;
>  		memcpy(
> @@ -2027,7 +2030,7 @@ static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>   */
>  static int ca8210_get_ed(struct ieee802154_hw *hw, u8 *level)
>  {
> -	u8 lenvar;
> +	u8 lenvar = 1;
>  	struct ca8210_priv *priv = hw->priv;
>  
>  	return link_to_linux_err(

