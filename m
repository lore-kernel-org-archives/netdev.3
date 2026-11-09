Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210584;
	b=5ZCItnWVB9iifMB9PAfBERW40rwjrhHHzK5ZloAIiBeoPbrGWZvn+MGBWptRmZHhvKGj
	 5j+BGik8jVQhKgW0ZP7t/hZwwOGN8yKm4GCfe8izovMygMuM0ZbAFmBOOY+7/Ja64Lova
	 xToWWarfhhXznGBa0FNWc8SENCobdLR2+9b3w0CzMy3ZFH+FGd8G7/MPc+Lua8xXfeXtF
	 vJfY988M1Ijaiw9LeGX65TTr/ert02DXAN7om0MTzHIk/uQ9DgeVt/mcmRX0hRLPQCPwv
	 3TL+mkZdbC2W5J3H5iNPu30yFcJkLDjR2uUYoyKRp6JSNnVDreu3pRODpdEX4xiRbqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210584;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5bFSw0rIpHU1hT6wK3Z1EV49ZLe2ZYK09NEQ3uViHBk=;
	b=HJlnVtdgaTHtFeyOzaK82hy+NwXQrVBa0oAjmNkv0FBv003FLx4mjfzZH98juD5rrjha
	 VC8X7iRAkoosI0INee5TAjzb1jdPTZu1XueYe7z4VLthJgyfDMVfn2amxNWCqZJO9E+ro
	 3WHwqyEzSY03wL8hq3FDs8rkjgx+C7iw6nkXzoVZYksp5v8hguqflajpqojO489sc2aOz
	 bOZOJFFoKR+jrogCPUkGD2fMEPnlasE5A5whrvRPOLDJkrjtJaNuuxf3PnAKjOrtRkEg3
	 ycd6Qn0zb6OCOvHA9QRShQ1X7RfM/EMC603KUUqVzuIyH8P9qbHmjoyPJYQH63R5MTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFEeiUGE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C62606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFEeiUGE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC021F008A2;
	Mon,  9 Nov 2026 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794210583;
	bh=5bFSw0rIpHU1hT6wK3Z1EV49ZLe2ZYK09NEQ3uViHBk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QFEeiUGEghol2IjRYRS16zVSF1rXxaBVucC/ZEZ2uxACQjT18vLhJbjea3/iSeouW
	 0RhHVItf4iSLRpdfZcg/Ds2lBHII9COoKFvSC4dS6QbGaHHJw+G88PrXrocw/njlnA
	 k9kGUY3TNNNYYOXyZ4NdXxiQKe/sxuV5Y1sZ2Y9kFFl5Gh8XfFsrnB8ylY2zzCKltF
	 rzny3LMC9jB/lsG8XPtuk7EyVe8d7Dby2Plbbno07n1P3bQDeZm4mWtxKbQtwX6TJ5
	 QBXVY4Nh3/nKqOLv0mO7X9bLh5kqNlcGP9SLZdPjjgB0lZUWBy7Bgh8uMcfnqfYzHN
	 7v+3G5KdCELmA==
Subject:
 Re: [PATCH net 4/4] tg3: Fix heap overflow in unbuffered NVRAM write path
From: netdev-bot+sashiko@kernel.org
To: pavan.chebbi@broadcom.com
Cc: michael.chan@broadcom.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 andrew.gospodarek@broadcom.com, davem@davemloft.net, edumazet@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shravya.k-n@broadcom.com,
 vishvambar.panth-s@broadcom.com
Date: Mon, 09 Nov 2026 07:49:42 +0000
Message-ID: <179421058284.994134.5773030258623536643@kernel.org>
In-Reply-To: <20261108065526.710152-5-pavan.chebbi@broadcom.com>
References: <20261108065526.710152-5-pavan.chebbi@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On SST flash, tg3_nvram_write_block_unbuffered() still overflows
  its heap buffer and still corrupts NVRAM on multi-page writes.
- [Medium] The new expression `size = pagesize - page_off` in
  tg3_nvram_write_block_unbuffered() assumes page_off < pagesize.
- [Low] The commit message understates the impact of the second fix.

--

tg3: Fix heap overflow in unbuffered NVRAM write path

This patch changes tg3_nvram_write_block_unbuffered() to clamp the
per-page copy size to pagesize - page_off instead of pagesize. It also
advances buf by size on each iteration, so a write spanning pages takes
the correct data for each page.

> This was found by an AI code review scan.  It has not been triggered, so
> the issue is theoretical.

[Severity: Low]
Is "theoretical" accurate for the buf += size part of this fix?

That word may be fair for the heap overflow. Before this patch, though,
any unbuffered flash write longer than one flash page reprogrammed every
later page with the first page's data from buf. That includes
page-aligned writes.

For writes that were not page aligned, len -= size also used up more
bytes than actually went into the page. The tail of the write was then
dropped without any error.

ethtool_set_eeprom() sends chunks of up to PAGE_SIZE. The unbuffered
parts (ATMEL_AT25F512, SAIFUN) have 256-byte pages, so ordinary
ethtool -E usage would hit this.

Could the description say so, to help stable and distro triage?

> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 16f8368874e7b..5b5b21d759a63 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -3399,13 +3399,14 @@ static int tg3_nvram_write_block_unbuffered(struct tg3 *tp, u32 offset, u32 len,
>  			break;
>  
>  		page_off = offset & pagemask;
> -		size = pagesize;
> +		size = pagesize - page_off;

[Severity: High]
Does this fix hold up on SST flash parts?

This clamp, and the pagemask = pagesize - 1 it depends on, both assume
the page size is a power of two. tg3_get_nvram_info() picks a page size
that is not, and it does not set NVRAM_BUFFERED for it:

drivers/net/ethernet/broadcom/tg3.c:tg3_get_nvram_info() {
    ...
		case FLASH_VENDOR_SST_SMALL:
		case FLASH_VENDOR_SST_LARGE:
			tp->nvram_jedecnum = JEDEC_SST;
			tp->nvram_pagesize = SST_25VF0X0_PAGE_SIZE;
			break;
    ...
}

drivers/net/ethernet/broadcom/tg3.h:
#define SST_25VF0X0_PAGE_SIZE		4098

When FLASH is set (from NVRAM_CFG1_FLASHIF_ENAB), tg3_nvram_write_block()
sends writes to tg3_nvram_write_block_unbuffered() with pagesize == 4098.

tmp = kmalloc(4098), but the read-back loop earlier in this function
still runs with j == 4096:

	for (j = 0; j < pagesize; j += 4) {
		ret = tg3_nvram_read_be32(tp, phy_addr + j,
					  (__be32 *) (tmp + j));

Doesn't that store 4 bytes at tmp + 4096, which is 2 bytes past the end
of the allocation? This runs on every call, before the memcpy() this
patch clamps. The write-back loop then reads that same word.

Here pagemask is 0x1001, which is not a real mask. For dword-aligned
offsets, page_off can only be 0 or 0x1000, so this new size is either
4098 or 2.

As an example, take ethtool_set_eeprom() sending its second PAGE_SIZE
chunk at offset 0x1000:

  phy_addr = 0x1000 & ~0x1001 = 0
  page_off = 0x1000
  size     = 2
  offset   = offset + (pagesize - page_off) -> 0x1002, 0x1004, ...

phy_addr then steps through 2, 4, 6, ... while page_off stays at 0x1000.
That is about 2048 iterations. Each one erases and rewrites sector 0 at a
misaligned base and writes only 2 bytes of user data. The function still
returns 0.

In the write loop, j == pagesize - 4 (4094) is never true, so
NVRAM_CMD_LAST is never sent either.

The commit message says both the heap overflow and spanning writes are
fixed. Is either true on this hardware?

SST25VF0x0 sectors are 4 KiB, so 4098 looks like a typo for 4096. Should
SST_25VF0X0_PAGE_SIZE be corrected? The other option is for the
unbuffered path to reject page sizes that are not a power of two or not
a multiple of 4.

[Severity: Medium]
What happens here when tp->nvram_pagesize is 0?

On 5750/5780-class chips, tg3_get_nvram_info() sets FLASH from
NVRAM_CFG1_FLASHIF_ENAB separately from the vendor switch, and that
switch has no default case. For a vendor encoding that is not handled,
pagesize stays 0 and NVRAM_BUFFERED stays clear, so writes take this
path.

In that state:

  tmp      = kmalloc(0)          -> ZERO_SIZE_PTR, passes the NULL check
  pagemask = 0 - 1               -> 0xffffffff
  page_off = offset & pagemask   -> offset
  size     = 0 - offset          -> wraps to a large value, clamped to len

For any non-zero offset, the memcpy() below then becomes
memcpy(ZERO_SIZE_PTR + offset, buf, len).

Before this patch, size stayed 0 in this state. The loop never ended and
kept erasing NVRAM address 0, but nothing was written to memory.

Could this change turn that hang into a wild kernel write, done while
rtnl_lock and the NVRAM lock are held?

It isn't clear whether real hardware ever reports such an encoding. A
pagesize check at the top of the function (non-zero, power of two,
multiple of 4) would cover this case and the SST 4098 case above.

>  		if (len < size)
>  			size = len;
>  
>  		len -= size;
>  
>  		memcpy(tmp + page_off, buf, size);
> +		buf += size;
>  
>  		offset = offset + (pagesize - page_off);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108065526.710152-1-pavan.chebbi%40broadcom.com
