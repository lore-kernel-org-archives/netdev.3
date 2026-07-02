Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0147ECF1
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985038; cv=none; b=S9Frrn00UnC7TagGV46GvcC2CoV9+pP1Z+RK1JFwLk/BOiLWUS4gb9BYnpKq151aKtIudGQypY2JsOk9VCYxBLGIMjFdxzNX/haTb9B7UdnqtOYHuabjIKREtO9bbVFNdl4Z3fVcsLS+JQLufSAuu+wboWv6YMExOOdz/ICTAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985038; c=relaxed/simple;
	bh=3wUEU9rIx91HtytBtj0pECdrw8Ab1A1Bresw6piV7bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNzRvDjEPc84mYLqRL54MZXeB8eSlNgJx+IGgzULP6zzwzSWLZPixv+XA+DHp93IGAicZ8IGmza31uvKqxo0agNADcsa9vu9TVGUidBkvC5btbyt4uo270vApItnQkOll+CZ0imbP0wnwmy8ZWZQeLcUItFaEl1s5AD3vO0RWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=t6NWmPxC; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="t6NWmPxC"
Received: (wp-smtpd smtp.wp.pl 44199 invoked from network); 2 Jul 2026 11:37:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1782985027; bh=zkwar8iwJsP1r3aAhyZaEddZf6ajbV8tsabdNEJcjUw=;
          h=From:To:Cc:Subject;
          b=t6NWmPxCLKfqGe8mUnAAnf74IKaVhMS7zyWUSnn6xfLbiaV3mSEYhC4u0sAO47CE6
           S8OfRrLyaYmoY+Eyp0VfYV6tYMyO9/6BQ5qOyHywogG33bnnkcjIg37NPuZKAxp9e+
           OEhWNLnGZoWurjGInC4D7zqRapR03wQnj1P6/nWN2QziBQFTRccoEmZP3r06IzGKMn
           VJ3Hg6CuEYZrE/hjDTnQaAgWBxf9i4jNi9l/Rj6nS4dT9EZRJtg9llrmHYwM7Buex/
           +jyD5M8nJv0k3hMTcoZqme6wbVaKVbcJwamBo9JtJ9DYAsDWvkMheBgw9vphHB7RKw
           Glhkm/R0eCnSA==
Received: from 77-236-11-179.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.11.179])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <kartikey406@gmail.com>; 2 Jul 2026 11:37:07 +0200
Date: Thu, 2 Jul 2026 11:37:07 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: castet.matthieu@free.fr, 3chas3@gmail.com, gregkh@linuxfoundation.org,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com,
	Mauricio Faria de Oliveira <mfo@igalia.com>
Subject: Re: [PATCH] usb: atm: ueagle: fix use-after-free in
 uea_upload_pre_firmware()
Message-ID: <20260702093707.GA6804@wp.pl>
References: <20260630041716.97102-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630041716.97102-1-kartikey406@gmail.com>
X-WP-MailID: 83ee2a829d4fe14e834cedbb5bc320e2
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [seOh]                               

Hi, thanks for working at this,

On Tue, Jun 30, 2026 at 09:47:16AM +0530, Deepanshu Kartikey wrote:
> uea_load_firmware() calls request_firmware_nowait() passing a raw
> struct usb_device pointer as context, without holding a reference
> to it.
> 
> If the USB device is disconnected before the firmware workqueue
> fires, the usb_device and its usb_interface objects are freed while
> uea_upload_pre_firmware() is still pending on the workqueue. When
> the callback eventually runs, it accesses the freed memory causing
> a slab-use-after-free:
> 
>   BUG: KASAN: slab-use-after-free in __intf_to_usbdev
>   include/linux/usb.h:752 [inline]
>   BUG: KASAN: slab-use-after-free in uea_upload_pre_firmware+0x8d/0x640
>   drivers/usb/atm/ueagle-atm.c:598
>   Read of size 8 at addr ffff88802b0710b8 by task kworker/0:2/1664
> 
> Fix by calling usb_get_dev() before queuing the firmware request to
> pin the usb_device in memory for the lifetime of the async operation,
> and usb_put_dev() in the callback once it is finished with the
> pointer. On the error path where request_firmware_nowait() itself
> fails, drop the reference immediately since the callback will never
> fire.
> Reported-by: syzbot+3d45d763d18796f97412@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3d45d763d18796f97412

I think the problem is not lack of usb device reference.
request_firmware_nowait() does get_device() and after fw work 
finish - put_device().

I suspect the issue is that syskaller corrupt descriptor such
the below condition:

 else if (usb->config->desc.bNumInterfaces == 1) 

is not met for pre-firmware device.

Adding Mauricio, who has setup for reproducing syskaller bugs on ueagle.
Hopefully he can confirm the diagnostic. If it's correct, we could
either save flag to recognize pre-firmware device, or separate driver
probe/disconnect for pre-firmware and post-firmware, to fix the issue.

Regards
Stanislaw

> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/usb/atm/ueagle-atm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
> index d610cdcef7d0..686cc58fb89f 100644
> --- a/drivers/usb/atm/ueagle-atm.c
> +++ b/drivers/usb/atm/ueagle-atm.c
> @@ -663,6 +663,7 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
>  	uea_err(usb, "firmware is corrupted\n");
>  err:
>  	release_firmware(fw_entry);
> +	usb_put_dev(usb);
>  }
>  
>  /*
> @@ -693,12 +694,14 @@ static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
>  		break;
>  	}
>  
> +	usb_get_dev(usb);
>  	ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
>  					GFP_KERNEL, usb,
>  					uea_upload_pre_firmware);
> -	if (ret)
> +	if (ret) {
>  		uea_err(usb, "firmware %s is not available\n", fw_name);
> -	else
> +		usb_put_dev(usb);
> +	} else
>  		uea_info(usb, "loading firmware %s\n", fw_name);
>  
>  	return ret;
> -- 
> 2.43.0
> 
