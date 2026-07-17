Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B05381AFE
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279437; cv=none; b=fuFyuETlDRL1tolG2ntorDla7Bp2K3qtS7Sgz9QArLa8LSnFaAABDqgHzw4541KvIJrmBM+/8Mc9eAuqTo021zt5vqPxmW3tNIiuKVFcTSc9pIE0bP/LNJH6QJakjV3RKWOvz77RMrOVoQPzsdaRcAExpZit31Mwe6iC6fV6YPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279437; c=relaxed/simple;
	bh=t1ONTKlONATXt4cdDOMB4swG1RCJMvreFRxlParBwSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQmZwbca5ZCj/NFaa0ZByx4DQVrNAJIo18ahrdZFCEVbw/CZIQ+Gp8BFQIDLBLs9T9NbGvi1nld3ZlWIpbEFZY3/yWZJNM6f0AYpvgpTcP9PgOdqvF96HRxsCo1ROMwvfmqbLe6NNg5KEYCBx9N8xFMRsU01WZcHHEnaMhHk8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=fV+/+QIW; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="fV+/+QIW"
Received: (wp-smtpd smtp.wp.pl 22452 invoked from network); 17 Jul 2026 11:10:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1784279420; bh=4njjNxmdqdKQD2Sv7qSJwe/k4x/oy97MONVKplRGPmM=;
          h=From:To:Cc:Subject;
          b=fV+/+QIWpmkliyicNsMcPi21czDITY6ciyosF/RJ/Fr9NiR1/i6mzGJD25V7jC4GJ
           36RzFcbPMdcBAhsfiQYIJi1iPj/FL5lM2OJvegk5tv0BB3jHOmv11G0wzRp9LBkwf0
           W8Hq93QvX7IaSFuT9n9jgs6TarsMuMa3wrKtqDCXQndIXTQiv1ZERdI5rsq84yAPPb
           BQO/pCRyVCAl9eGOTyKqO0H0y76K6CLQRS/yn72iWVDqZj5sgU02IbwFjwW0/tcjlv
           tSfNK/TPId25jTuCYs3R6+1chOMF8VZsVX6xvyb0bVgS2WNgtKaSRllN10TwqaKY3x
           qtR3yHxQCYQJg==
Received: from 77-236-11-215.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.11.215])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <diegomancera.dev@gmail.com>; 17 Jul 2026 11:10:20 +0200
Date: Fri, 17 Jul 2026 11:10:20 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+e62a973f8322b3bbe3ac@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: atm: ueagle-atm: reject descriptors that confuse
 probe and disconnect
Message-ID: <20260717091020.GA13163@wp.pl>
References: <20260717080704.1264-1-diegomancera.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717080704.1264-1-diegomancera.dev@gmail.com>
X-WP-MailID: 83786f0debeb45b06beadd33465da70c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [4ZLh]                               

On Fri, Jul 17, 2026 at 02:07:04AM -0600, Diego Fernando Mancera Gomez wrote:
> uea_probe() distinguishes a pre-firmware device from a post-firmware one
> using the USB id (UEA_IS_PREFIRM()), and stores a different object as the
> interface data in each case: a 'struct completion' for a pre-firmware
> device (to be waited on in .disconnect()), or a 'struct usbatm_data' for a
> post-firmware one.
> 
> uea_disconnect() instead tells the two apart by the number of interfaces
> of the active configuration (a pre-firmware device exposes a single
> interface, ADI930 has 2 and eagle has 3), and casts the interface data
> accordingly.
> 
> Because the two handlers use different criteria, a crafted device that
> advertises a pre-firmware id together with a multi-interface descriptor
> (or a post-firmware id with a single interface) makes them disagree: the
> small 'struct completion' stored by uea_probe() is then passed to
> usbatm_usb_disconnect(), which casts it to 'struct usbatm_data' and takes
> instance->serialize, reading past the end of the allocation:
> 
>   BUG: KASAN: slab-out-of-bounds in __mutex_lock+0x152a/0x1b80
>   Read of size 8 at addr ffff8880470e2c60 by task kworker/1:2/982
>   ...
>    __mutex_lock+0x152a/0x1b80
>    usbatm_usb_disconnect+0x70/0x820
>    uea_disconnect+0x133/0x2c0
>    usb_unbind_interface+0x1dd/0x9e0
>   ...
>   which belongs to the cache kmalloc-96 of size 96
>   The buggy address is located 0 bytes to the right of
>    allocated 96-byte region [ffff8880470e2c00, ffff8880470e2c60)
> 
> Reject such inconsistent descriptors in uea_probe() so that both handlers
> always make the same pre/post-firmware decision.
> 
> Reported-by: syzbot+e62a973f8322b3bbe3ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e62a973f8322b3bbe3ac
> Fixes: e2674dfbed8a ("usb: atm: ueagle-atm: wait for pre-firmware load in .disconnect()")
> Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Thanks
Stanislaw

> ---
>  drivers/usb/atm/ueagle-atm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
> index 4e71ed679a76..4266a0cb7e3b 100644
> --- a/drivers/usb/atm/ueagle-atm.c
> +++ b/drivers/usb/atm/ueagle-atm.c
> @@ -2549,6 +2549,7 @@ static struct usbatm_driver uea_usbatm_driver = {
>  static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  {
>  	struct usb_device *usb = interface_to_usbdev(intf);
> +	bool single_iface = usb->config->desc.bNumInterfaces == 1;
>  	int ret;
>  
>  	uea_dbg(usb, "ADSL device found with vid (%#X) pid (%#X) Rev (%#X): %s\n",
> @@ -2557,6 +2558,22 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  		le16_to_cpu(usb->descriptor.bcdDevice),
>  		chip_name[UEA_CHIP_VERSION(id)]);
>  
> +	/*
> +	 * uea_probe() decides between the pre-firmware and post-firmware case
> +	 * from the USB id and stores a different object as interface data in
> +	 * each case: a struct completion for a pre-firmware device, a struct
> +	 * usbatm_data for a post-firmware one. uea_disconnect() instead tells
> +	 * the two apart by the number of interfaces (a pre-firmware device
> +	 * exposes a single interface, ADI930 has 2 and eagle has 3). A crafted
> +	 * device advertising a pre-firmware id together with a multi-interface
> +	 * descriptor (or the other way around) makes the two disagree, so that
> +	 * usbatm_usb_disconnect() treats the small completion object as a
> +	 * struct usbatm_data and reads out of bounds. Reject such inconsistent
> +	 * descriptors so both paths make the same decision.
> +	 */
> +	if (UEA_IS_PREFIRM(id) != single_iface)
> +		return -ENODEV;
> +
>  	usb_reset_device(usb);
>  
>  	if (UEA_IS_PREFIRM(id)) {
> -- 
> 2.43.0
> 
