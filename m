Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983A533D6;
	Tue, 18 Aug 2026 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073141; cv=none; b=MFI3X0gOwOP6NgTKxQQAOYWmk9xMlUGiiP85SQjQTgylTyAJ7sldHLp0We15m5yy6DDUSe2qkeq+sw36ak8A4VqU0F5GvR4MmYi1zziJ9sMkhqLbMlkKNDU+gZcHG296xyfv+RDdskqCHoYZ3dEGoXhwrBJk+n3scWaHQj4fqFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073141; c=relaxed/simple;
	bh=9CgssD2o8SLxy6cwQQyG/FLLjqzecSUCRmdf/HHDN1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFXKU93rjRfiVrcH5qPvqe0/+J48wkRolyqJSjVWHtKtxGB0taWEz5hLtLQYPh4zwwaN8Y09s4PKgMi4Ta3Lal0u9YLJ9Vh+WSGkHuYLiMnPTwSTekqSCG6Fj9ARMrb2/kxX0fM5SGlGvOcp6dLtLYqUp7toD0wLyGM8KLCnaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOdcjof/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOdcjof/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E1F1F000E9;
	Tue, 18 Aug 2026 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073139;
	bh=8QuYg2OhV5tAkY3Ps04pwg6r0t7//7lxGbem/AeOpbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOdcjof//6N3io/fcfQhQQ+hq4GUXGPd7WU9Bm8g1oJpQRAaZS7qQjlpHR6n3OkcX
	 bpjb1N9Gyhhnwp8lWsDZ008nCH01wL/SE/kktvkOrRfqxEeujV/hltFBPqzDgLPHDb
	 XxnyDBCw4KNqhvBzkXOG/0GzmG9967fSL2LjmG/+5EucmaB+pMq0t3voV2oBJj6uUu
	 qBFCnXhvGPaw48uP9TW3vJdaxOFdvVJPMeM8q7d+qrNgnVKRJUYkxDKp/kHkzmz0s3
	 CMH35/I3AarKnDmVnwcp9kodR/Jv/TgQnlKwEDG++E1SRr5K8SveUFZNE69FBUcSZw
	 Xr3wG44FOXaUA==
From: Jakub Kicinski <kuba@kernel.org>
To: mehrdad@signeen.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	oliver@neukum.org,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] net: usb: cdc_ncm: add Apple MacBook Pro USB product ID 0x1902
Date: Tue, 18 Aug 2026 10:12:17 -0700
Message-ID: <20260818171217.4021591-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816040426.57132-1-mehrdad@signeen.com>
References: <20260816040426.57132-1-mehrdad@signeen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: usb: cdc_ncm: add Apple MacBook Pro USB product ID 0x1902

This adds two cdc_devs[] entries for USB ID 0x05ac:0x1902 (interface
numbers 0 and 2) pointing at apple_private_interface_info, so MacBook Pro
models presenting that product ID over USB4 no longer fall through to the
generic cdc_ncm_info entry, which requires an interrupt endpoint via
FLAG_LINK_INTR.

No Link: tags are present in the commit header.

>     using the same descriptor layout as 0x1905: a Communications
>     control interface with zero endpoints (no interrupt/status endpoint)
>     paired with a CDC Data interface, at
>     interface numbers 0 and 2.

[Severity: Low]
Is this description of the descriptor layout what the hardware actually
presents?  Read literally, it says interface 0 is the Communications
control interface and interface 2 is its CDC Data interface.  If that were
the case, the second entry added below for interface number 2 would never
bind, since cdc_ncm_bind_common() notes:

drivers/net/usb/cdc_ncm.c:cdc_ncm_bind_common() {
	/* only the control interface can be successfully probed */
	ctx->control = intf;
	...
}

and a CDC Data interface carries no CDC Union / NCM functional
descriptors, so bind can only reach the error path.

The pre-patch dmesg quoted in the changelog seems to say something
different:

>       cdc_ncm 2-1:1.0: bind() failure
>       cdc_ncm 2-1:1.2: bind() failure

That string is only emitted from cdc_ncm_bind_common():

drivers/net/usb/cdc_ncm.c:cdc_ncm_bind_common() {
	...
error:
	cdc_ncm_free((struct cdc_ncm_ctx *)dev->data[0]);
	dev->data[0] = 0;
	dev_info(&intf->dev, "bind() failure\n");
	return -ENODEV;
}

usb_driver_claim_interface(), which is how the data interface is taken,
does not invoke probe/bind, so interface 2 must have matched the id_table
on its own.  Pre-patch the only entry it could match is the generic

	{ USB_INTERFACE_INFO(USB_CLASS_COMM,
		USB_CDC_SUBCLASS_NCM, USB_CDC_PROTO_NONE),
		.driver_info = (unsigned long)&cdc_ncm_info,
	},

which a CDC Data interface (bInterfaceClass 0x0a) cannot match.  Would it
be more accurate to say that interfaces 0 and 2 are both zero-endpoint
COMM/NCM control interfaces, each paired with its own CDC Data interface,
as with 0x1905?

> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 0223a172851ec..35db38cb3e4a2 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -2013,6 +2013,12 @@ static const struct usb_device_id cdc_devs[] = {
>  	},
>  
>  	/* Mac */
> +	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1902, 0),
> +		.driver_info = (unsigned long)&apple_private_interface_info,
> +	},
> +	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1902, 2),
> +		.driver_info = (unsigned long)&apple_private_interface_info,
> +	},

The code change itself looks right, and the two entries appear to be
needed.  Could the changelog also state the post-patch result on the
hardware, the way the precedent commit a5148bc2fa27 ("net: usb: cdc_ncm:
add Apple Mac USB-C direct networking quirk") does?  That commit ends with
the netdevs appearing, ip -br link showing them UP and DHCP working.  Here
the message stops at the pre-patch failure, so there is nothing recording
that apple_private_interface_info (FLAG_POINTTOPOINT | FLAG_NO_SETINT |
FLAG_MULTI_PACKET | FLAG_ETHER | FLAG_SEND_ZLP, without FLAG_LINK_INTR) is
the right driver_info for this product ID and that both entries are
required.  Including the /sys/kernel/debug/usb/devices or lsusb dump would
also make the interface layout unambiguous.

>  	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1905, 0),
>  		.driver_info = (unsigned long)&apple_private_interface_info,
>  	},

[ ... ]
-- 
pw-bot: cr
