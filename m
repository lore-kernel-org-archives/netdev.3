Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78F3CA498;
	Mon, 23 Mar 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289215; cv=none; b=uJT74jIeU4zeDDRKaNXXzBX1d+i1Sxkne8EbtJVoBMSO3hyEQOnzplNyLcCG66CclUw1YouLQTEybPmlPU7jL7MwYwhCZqJ3pSTVvH6WVPPzbrECM50jasFTDUDMaF4QNJjoXpeU6GFmSiTprnQeuvPu16YHXHz5lV3hzR1rK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289215; c=relaxed/simple;
	bh=8S84h22Jw0U+zyxF/KLZ87UES0qgquWYlnLt7kNs9WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpFSg+PaCYzLEnH3iKuw9x69J8gfxHqCNgS7Too6qENUlYQ3oF8U3217u+KUbcdaXairDkQwWKCV48dwB0ABcDARgcfEvxN206kBf+U0UC18ySTD7BHi6rPBY9TDQEndnaBVkQt1ggBGdC6hjVB5p6dLDd4EIDC+gjnbG8dnPBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTQbeyg2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTQbeyg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93641C4CEF7;
	Mon, 23 Mar 2026 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774289215;
	bh=8S84h22Jw0U+zyxF/KLZ87UES0qgquWYlnLt7kNs9WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTQbeyg25tVWL2JzXKPi2b8ymSXyZX/f1HhwsZJsMRL8+wywLAwI+HZjNcv1J7mAs
	 l1HVdSM8/WflnIBHyOiwFtzUGTsObYicusgmS6RGZbctHDEyOq7Tb3oKvvAvfsuSQ0
	 ATtMYxOI4HIcY9FgIIFt6fR8zAPAjuXnq7/VaRTSN2LIosyq3+QzcltBE6AUcV4H6T
	 1DtINNupNLAcpklLclRkiBCCPv40SEQc4qEk0xRleD0+GHnNK7q7k5MsNoLS1rK7WD
	 1xofn3IYKgD6kOkCiX7e+6vtta5sHWzvb3Vku1x9zUwl/9m0ECpD0RCJKDXPX+tgR8
	 XM/8lvkGhkOvA==
Date: Mon, 23 Mar 2026 18:06:51 +0000
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/nfc: bound SENSF response copy length
Message-ID: <20260323180651.GA164850@horms.kernel.org>
References: <20260322031922.57949-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322031922.57949-1-pengpeng@iscas.ac.cn>

On Sun, Mar 22, 2026 at 11:19:22AM +0800, Pengpeng Hou wrote:
> `digital_in_recv_sensf_res()` only checks `resp->len` against the
> minimum frame size before copying the response into
> `target.sensf_res`. The destination is `NFC_SENSF_RES_MAXSIZE` bytes
> long, so an oversized SENSF response can overwrite adjacent fields in
> the stack-local `struct nfc_target` before the result is handed to
> `digital_target_found()`.
> 
> Reject frames larger than the destination buffer before copying.
> 

Hi Pengpeng Hou,

A fixes tag needs to go here (without a blank line between it
and your Signed-off-by line).

Possibly the following is appropriate

Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

This patch should be targeted at the net tree, like this:

Subject: [PATCH net] ...

And, looking at git history, it seems that an appropriate prefix
is "NFC: digital:"

Subject: [PATCH net] NFC: digital: bound SENSF response copy length

> ---
>  net/nfc/digital_technology.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
> index 63f1b721c71d..8147e61c224a 100644
> --- a/net/nfc/digital_technology.c
> +++ b/net/nfc/digital_technology.c
> @@ -768,6 +768,11 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
>  
>  	skb_pull(resp, 1);
>  
> +	if (resp->len > NFC_SENSF_RES_MAXSIZE) {
> +		rc = -EIO;
> +		goto exit;
> +	}
> +
>  	memset(&target, 0, sizeof(struct nfc_target));
>  
>  	sensf_res = (struct digital_sensf_res *)resp->data;

AI generated review at sashiko.dev says:

    Does this strict bounds check drop valid NFC-F (FeliCa) SENSF_RES
    frames that contain the Request Data (RD) field?

    According to the NFC Forum Digital Protocol, a SENSF_RES frame payload
    can include an optional 2-byte Request Data (RD) field, bringing the
    total length of the response to 19 bytes. This matches the kernel's
    definition of

    struct digital_sensf_res which is exactly 19 bytes long:

    struct digital_sensf_res {
    	u8 cmd;
    	u8 nfcid2[8];
    	u8 pad0[2];
    	u8 pad1[3];
    	u8 mrti_check;
    	u8 mrti_update;
    	u8 pad2;
    	u8 rd[2];
    }

    However, the UAPI macro NFC_SENSF_RES_MAXSIZE is defined as 18.

    If a valid FeliCa SENSF_RES with RD arrives, resp->len will be 19.
    Returning -EIO here completely drops these frames. Could we instead
    clamp the copy length to NFC_SENSF_RES_MAXSIZE (truncating the optional
    RD field if the UAPI buffer cannot be extended) to avoid breaking
    functionality?

Which does seem to be factually correct (please check).
And perhaps the current code buffer overruns if RD is present (in full).
If so it would be interesting to analyse what the effect of that is:
is the neighbouring data unused so this works; or has it always been broken?

Also, I wonder if it is possible to expand NFC_SENSF_RES_MAXSIZE to
accomodate all of a struct nfc_target.

But I am also curious to know how the skb_pull() in the code relates to:

1. Using the packet data as a struct nfc_target after pulling the first byte
2. But checking the length of packet data against
   DIGITAL_SENSF_RES_MIN_LENGTH (17) before the call to skb_pull()
