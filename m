Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471109;
	b=RV29XVTIlnuQVzmIm0TadCF4+JrreQwhICmThSw4+beuGHSFl/uCpiPKPzV4VFBRyP+E
	 YmqVDDOxqsXgGFJO6i90h8T0WXFvqwOgABj4byX+HKYPlx0pcCXdOTKSWgDCoFrI77p2q
	 1OAGGLEspCJGTdu2/Px8imnRu+Q6LzOOSZk1P7RsBjkowcapAzo1Aw2FgcTA9gX+6/i5n
	 qz9PdlKmNBrLoVOqMlz+0JSw0W3k5m97Rk1cWsT6ejbF5pMxSjcLlxth20OD/B9GPm+aK
	 LTcV1LRXFDra2DDrDb+B50IzG9Mb5XcNQUlwSraxErzRm7bEurV82Ex/aO+Uoysy5fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471109;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QMay69m9e+PN97EQ07hYciKvE0ipjl6puZ6OI4gJg7M=;
	b=ZMsHYPE5zlliGy4koOnIMWRuVkJAoED4YGPJNlpZZrQo2RI+XpQE5ORRmonI2uHQgwSC
	 B744HG+bHl0KVtbaZnPZAjpRTTRXDjUfUG6UTo+iidcOuwfhA/sBQ7SOnsiTzuaDM7MC6
	 FrYBpwm/bBzB5SmJXMIyLiLza6SkvxeWXc8tCmTWKsU4o1ZGvHKaZd7f3oEvXEWGWPiYZ
	 l2uEgH1yRVloy+Wd7KpvArUxfQ8YAfsLmQk2t+skii7vQ1uLQTWVttG8piIY/HPVKcx0M
	 fz1snSnhtj76aD2mJlLTwRIMsGylNe+7Z+pko6zpAYpDsqex96ZXN+pWyuqHv+UbL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XW7JVmqu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6830606A31A;
	Sat, 31 Oct 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XW7JVmqu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4891F000C1;
	Sat, 31 Oct 2026 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793471108;
	bh=QMay69m9e+PN97EQ07hYciKvE0ipjl6puZ6OI4gJg7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XW7JVmqu/umZKgHGxNvjGk37jCoUwEUctUwGWRXInLHNswLzFceGJ+3Inx1b1RadT
	 ZKFEnj1wXw6TlrvjqZ/rAjPRNZAOGGGQE0XnN4BGTc/T+R2s18TTLrvtE3980p/aUl
	 /4bVvBk0NzJfZkKhBHCwd661PQBLY9f/fA+lhvKeZ+8NE3tj/Igo0fXVxtuf5Ns8v6
	 z6Mbobywxi83QyWG+a9wNDzpN0rvMqKd/Nv8tQejAYIOaOgBf9io1x+6pzjdVViUMa
	 nPhQPQDDq5ltn13TFFdSi2z8i7Laoxdoez+7Vo/lR0dhlur/fv9U30+snELO++4jdX
	 cVketYzumlz1w==
Date: Sat, 31 Oct 2026 18:25:04 +0000
From: Simon Horman <horms@kernel.org>
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fan Wu <fanwu01@zju.edu.cn>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: st21nfca: complete a pending SE APDU request
 only once
Message-ID: <20261031182504.GW257209@horms.kernel.org>
References: <179332800288.52644.8728400883396719965@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179332800288.52644.8728400883396719965@gmail.com>

On Thu, Oct 29, 2026 at 11:40:02PM -0300, Joas Antonio dos Santos wrote:
> st21nfca_hci_se_io() stores the netlink callback and its context in
> info->se_info and arms the BWI timer.  The request is then completed
> either by st21nfca_se_wt_work(), when the timer expires, or by an
> EVT_TRANSMIT_DATA event on the APDU reader gate.  Neither checks that a
> request is still pending, and the callback, se_io_cb(), frees its
> context every time it is called.
> 
> So when the secure element answers after the timeout, the response
> calls se_io_cb() again on the context the timeout already freed, and
> frees it a second time.  The same happens if the controller sends two
> EVT_TRANSMIT_DATA events for one request.  An EVT_TRANSMIT_DATA, or a
> timer armed by EVT_WTX_REQUEST, with no request pending calls the
> callback on the context of an earlier, already completed request, or
> calls a NULL callback if there never was one.
> 
> With st21nfca on a virtual phy and an emulated controller answering an
> NFC_CMD_SE_IO request 4 s after it was sent (the default timeout is
> 3.2 s):
> 
>   BUG: KASAN: slab-use-after-free in se_io_cb+0x2ec/0x334
>   Read of size 4 at addr fff00000c5277da0 by task kworker/3:1/59
>   Workqueue: events nfc_hci_msg_rx_work
>   Call trace:
>    se_io_cb+0x2ec/0x334
>    st21nfca_apdu_reader_event_received+0x1ec/0x248
>    st21nfca_hci_event_received+0xb0/0x300
>    nfc_hci_event_received+0xb8/0x30c
>    ...
>   Freed by task 59:
>    kfree+0x214/0x498
>    se_io_cb+0x2bc/0x334
>    st21nfca_se_wt_work+0x14c/0x1d4
> 
> and for an EVT_TRANSMIT_DATA without a request:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>   pc : 0x0
>   lr : st21nfca_apdu_reader_event_received+0x1ec/0x248
> 
> Use bwi_active, which st21nfca_hci_se_io() sets, to tell whether a
> request is pending, and clear it in whichever of the two paths
> completes the request first.  The event handler already stops the timer
> and waits for the timeout work before looking at it.  Also complete the
> request with the error if sending EVT_SE_END_OF_APDU_TRANSFER fails
> rather than never calling the callback, which leaked the context.
> 
> Fixes: 2130fb97fecf ("NFC: st21nfca: Adding support for secure element")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
> ---
> Tested on arm64 QEMU with KASAN, with a test-only module that registers
> st21nfca through st21nfca_hci_probe() on a virtual phy (LLC nop) and a
> userspace controller emulator (DEV_UP, ENABLE_SE, SE_IO over netlink).
> Without the patch: slab-use-after-free in se_io_cb() for a late and for
> a duplicated EVT_TRANSMIT_DATA, NULL pointer call for an unsolicited one.
> With it all three are quiet and a normal SE_IO exchange still works.
> Not tested on hardware.
> 
> st-nci has the same pattern; Fan Wu's pending "nfc: st-nci: drain SE
> timers before NCI teardown" v2 already makes bwi_active an ownership
> token there, so this only touches st21nfca.
> 
>  drivers/nfc/st21nfca/se.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
> index 7154bc1d6..4261ed1d9 100644
> --- a/drivers/nfc/st21nfca/se.c
> +++ b/drivers/nfc/st21nfca/se.c
> @@ -264,6 +264,12 @@ static void st21nfca_se_wt_work(struct work_struct *work)
>  						struct st21nfca_hci_info,
>  						se_info.timeout_work);
>  
> +	/* The timer can also be armed by EVT_WTX_REQUEST while no
> +	 * st21nfca_hci_se_io() is pending.
> +	 */
> +	if (!info->se_info.bwi_active)
> +		return;
> +
>  	info->se_info.bwi_active = false;

Hi Joas,

I'm unsure if it effects the correctness of this fix.
But I am concerned that the use of bwi_active is racy.

>  
>  	if (!info->se_info.xch_error) {
> @@ -383,11 +389,20 @@ int st21nfca_apdu_reader_event_received(struct nfc_hci_dev *hdev,
>  	case ST21NFCA_EVT_TRANSMIT_DATA:
>  		timer_delete_sync(&info->se_info.bwi_timer);
>  		cancel_work_sync(&info->se_info.timeout_work);
> +		/* Only complete a pending st21nfca_hci_se_io(), and only once:
> +		 * the timeout work may already have completed it, and the
> +		 * callback frees its context.
> +		 */
> +		if (!info->se_info.bwi_active)
> +			break;
> +
>  		info->se_info.bwi_active = false;
>  		r = nfc_hci_send_event(hdev, ST21NFCA_DEVICE_MGNT_GATE,
>  				ST21NFCA_EVT_SE_END_OF_APDU_TRANSFER, NULL, 0);
> -		if (r < 0)
> +		if (r < 0) {
> +			info->se_info.cb(info->se_info.cb_context, NULL, 0, r);
>  			goto exit;
> +		}
>  
>  		info->se_info.cb(info->se_info.cb_context,
>  			skb->data, skb->len, 0);
> -- 
> 2.43.0
> 
