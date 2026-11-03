Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674971;
	b=W5e5dSwnIaxV4JJ7H5IR2WTjojS4te0Rtc9U74Yq6tnXaGnHzwvbmpI5mNjm3zBV+R7/
	 6nX6MoQl6MdHDwjdB6CML+mcaZRnGn8NtGY07SwovcJd9wH6XQAKS4PfxwakP9hMgo2C6
	 FAOtG8XCdWOLbCnaEXHRtKHVd3wRjVb1OXlFxi7Llr/JEm4W/aYBLWTBGAQMdmjET+xiQ
	 6cdMpBVtZc4Dj0WDi68jLUviISsY+SqyKoQbGLk+07DEeOjAuFWRL0cxBDAqQDab8GYq7
	 jcWOCRITt0vDAcTjkDon7FnY6O11ag/U8YKRIwr4sm4o5QpVA73alinZpmv5YiNG7nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674971;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6uWrHIdQA4/I/nNEbaoqtIpWv2r/6R+u8p9kDzTlgDQ=;
	b=AfT0QEri0aaZjuF73vr3f+K7DM0pcWdb4wFgUnxvSQOcXAKxIEw9JuGWSdAuvU/ckNLE
	 D8/lg8Ly38WV0IRwrYpQAk0y+EQG6NoVO/PsyduWtEcSm4MVRRuHAVB0WAErjSjFIWMVr
	 aQMhR0bbAuvDzoUYCgc+HWwixHO6y1zq6svptyHtjnguJG5R5BZZtmTybrqWe6QeuIOGZ
	 MOwJowdl/cnUWKpIv1kfTj1nJA0rEs4aYLtf4TKiabb5L0HWNZt81BByQmePeo1biZf70
	 2g5/1shjnmIvHJ57v4Es7CS7b40RbL3WkjDTLhzHEbf5lqC32ei6w2pXGV/SSmIWu+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oimnZTFG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF25606A33B;
	Tue,  3 Nov 2026 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oimnZTFG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AA61F00A18;
	Tue,  3 Nov 2026 03:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674970;
	bh=6uWrHIdQA4/I/nNEbaoqtIpWv2r/6R+u8p9kDzTlgDQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oimnZTFGTeJE43fq6q+zP9zhnnO569FfyCYBDdMi/QUj+r8PCev/2tGuRQVgJFyi1
	 zNn14mwrvWqixU2DGDV9iwX8h4ArR0F/sHQ55MnbFRBseHFWtbO8YSGCiLMK6F0kOT
	 lsVgCgkYevp8m5X5EnIDj9/XrO3+ARFuwJqjhrTYoEvbzowm1UpQ5yNuZMuBw0FYHL
	 Z8hN9XmbCKL7t/FEeqTeHmeoBQMTXdYcLspH2sCuPv0OnjVTFpPWNw4v2X7lQn6M+m
	 SojdJtXleZQd0k3P6KPhdySSYA3MdqRCsKFQJ/3tYVfc1TeFXbM8p3cV/I6aUiYcnh
	 xt65wV6HMoMjg==
Subject: Re: [PATCH net] nfc: s3fwrn5: validate the firmware image size
 against the firmware file
From: netdev-bot+sashiko@kernel.org
To: joasantonio108@gmail.com
Cc: david@ixit.cz, krzk@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 03:02:49 +0000
Message-ID: <179367496942.488856.4052477180493084885@kernel.org>
In-Reply-To: <179332800288.52644.4206885352837613064@gmail.com>
References: <179332800288.52644.4206885352837613064@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete because the signature offsets and sizes in
  the firmware header are still not checked.

Pre-existing issues:
- [Low] struct s3fwrn5_fw_cmd_get_bootinfo_rsp is 12 bytes
  (hw_version[4], sector_size, page_size, frame_max_size,…

--

nfc: s3fwrn5: validate the firmware image size against the firmware file

This patch adds bounds checks to the s3fwrn5 firmware download path. It
checks the GET_BOOTINFO response length and rejects an image offset past
the end of the firmware file. It also checks that sector_size *
image_sectors, plus the 4 KiB sent per sector, fits in the firmware image
before the image is hashed and flashed.

> diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
> index 9145deec7f6c1..159afb8de7491 100644
> --- a/drivers/nfc/s3fwrn5/firmware.c
> +++ b/drivers/nfc/s3fwrn5/firmware.c
> @@ -93,7 +93,8 @@ static int s3fwrn5_fw_get_bootinfo(struct s3fwrn5_fw_info *fw_info,
>  		return ret;
>  
>  	hdr = (struct s3fwrn5_fw_header *) rsp->data;
> -	if (hdr->code != S3FWRN5_FW_RET_SUCCESS) {
> +	if (hdr->code != S3FWRN5_FW_RET_SUCCESS ||
> +	    rsp->len < S3FWRN5_FW_HDR_SIZE + 10) {

[Severity: Low]
This is a pre-existing issue, but struct s3fwrn5_fw_cmd_get_bootinfo_rsp
is 12 bytes:

struct s3fwrn5_fw_cmd_get_bootinfo_rsp {
	__u8 hw_version[4];
	__u16 sector_size;
	__u16 page_size;
	__u16 frame_max_size;
	__u16 hw_buffer_size;
};

The new length check and the existing memcpy() in
s3fwrn5_fw_get_bootinfo() both use the literal 10. That means
hw_buffer_size in the on-stack bootinfo in s3fwrn5_fw_setup() is never
filled in.

Nothing in drivers/nfc/s3fwrn5/ reads hw_buffer_size today, so this has
no functional effect.

Would it be cleaner to use sizeof(*bootinfo) here? Or a named constant
that documents a 10-byte wire format?

>  		ret = -EINVAL;
>  		goto out;
>  	}

[ ... ]

> @@ -307,6 +308,10 @@ int s3fwrn5_fw_request_firmware(struct s3fwrn5_fw_info *fw_info)
>  	memcpy(&fw->sig_size, fw->fw->data + 0x18, 4);
>  
>  	memcpy(&image_off, fw->fw->data + 0x1C, 4);
> +	if (image_off > fw->fw->size) {
> +		release_firmware(fw->fw);
> +		return -EINVAL;
> +	}
>  	fw->image = fw->fw->data + image_off;
>  	memcpy(&fw->image_sectors, fw->fw->data + 0x20, 4);
>  

[Severity: High]
image_off is now checked against fw->fw->size. The signature fields from
the same header are still used without any range check:

drivers/nfc/s3fwrn5/firmware.c:s3fwrn5_fw_request_firmware() {
	...
	memcpy(&sig_off, fw->fw->data + 0x14, 4);
	fw->sig = fw->fw->data + sig_off;
	memcpy(&fw->sig_size, fw->fw->data + 0x18, 4);
	...
	memcpy(&custom_sig_off, fw->fw->data + 0x24, 4);
	fw->custom_sig = fw->fw->data + custom_sig_off;
	memcpy(&fw->custom_sig_size, fw->fw->data + 0x28, 4);
	...
}

s3fwrn5_fw_setup() then picks one of the two pairs based on
s3fwrn5_fw_is_custom(&bootinfo). That depends on hw_version[2], which the
controller reports in GET_BOOTINFO.

The chosen pointer and size (truncated to u16) are then sent to the
controller:

s3fwrn5_fw_download()
  s3fwrn5_fw_enter_update_mode(fw_info, hash_data, SHA1_DIGEST_SIZE,
                               fw_info->sig, fw_info->sig_size)
    s3fwrn5_fw_prep_msg(fw_info, &msg, S3FWRN5_FW_MSG_DATA, 0,
                        sig_data, sig_size)
      skb_put_data(skb, data, len)

What happens if sig_off + sig_size, or custom_sig_off + custom_sig_size,
runs past fw->fw->size? Can skb_put_data() then read up to 64 KiB beyond
the firmware buffer?

Depending on how far the read goes, it would either oops on a guard page
or unmapped address, or copy nearby kernel memory into the DATA packet
sent to the controller.

The commit message says:

    Check that everything that is hashed and sent lies within the image,

The signature is sent in the same update sequence. Should both signature
extents also be checked against fw->fw->size here, for example with
check_add_overflow()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179332800288.52644.4206885352837613064%40gmail.com
