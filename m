Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63E41A4E8;
	Wed, 23 Sep 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145241; cv=none; b=UM9TREWD2yraXTgBxHVmZq8tZDC2uBhb+9gVdMdcd3rO0LqqW8rp8PaCk9zLj/bvdgplGW0lxWBUzV0+NrFAWDOiBiRq9HXbefzMFGrwQJ8+zuGdzjJRtdFCgZSoF7UY4kgQT9l1SEQLRGwskPr3leZzDgsLu+pq6ksPWxHlhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145241; c=relaxed/simple;
	bh=iXopXUy4/hhCXw/Ru6dU3UPGJt7FzxpKWFjnAjJnaGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FttuMI9l9Bl58j5UHv1L520Lu3b1fgzOC9Ofixync87pxOkWlW2LyT6ZHPW67nr52mXbiYcLBBmdwKESavSoBvktVlsPC6BsTvBdpzHx5q2xzkMvg8ACzPCgR/hI4DASxrklJVJBSLn0QGo5tkjdoTuhiSrutacy9Tq2v8Yg3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=UCz9Lrah; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="UCz9Lrah"
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=UCz9Lrah;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.2/8.18.2) with ESMTPSA id 68N6LTiw612847
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 07:21:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1790144489; bh=h4VypXSX3AHF9Xh3CYHFmLl7jFwM/+C/gBK8qDtIQ0w=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=UCz9LrahzQYxscbpMO2jz+oXcpTLItuQ2kJphsjLg3P65+Ikx8JRfy36eUq37et5X
	 V+51+ymj7nH1stvvmcmO1FFV5OIllCaUPQtlyR/T/DZY36KYSlVXWsJFqSQxq9CVt7
	 R7aoC6FP8j238Hqm0JX8iVXSypmPGkaxprfLH4Gk=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.2/8.18.2) with ESMTPSA id 68N6LTv42135606
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 08:21:29 +0200
Received: (nullmailer pid 1064332 invoked by uid 1000);
	Wed, 23 Sep 2026 06:21:29 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: jackyphuti <jackympoka22@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Copilot <223556219+Copilot@users.noreply.github.com>
Subject: Re: [PATCH] net: usb: qmi_wwan: add common Huawei modem IDs
In-Reply-To: <20260918193645.59374-1-jackympoka22@gmail.com> (jackyphuti's
	message of "Fri, 18 Sep 2026 21:36:45 +0200")
Organization: m
References: <20260918193645.59374-1-jackympoka22@gmail.com>
Date: Wed, 23 Sep 2026 08:21:29 +0200
Message-ID: <87h5jgpjx2.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

jackyphuti <jackympoka22@gmail.com> writes:

> Add common Huawei product IDs to qmi_wwan fixed-interface mappings
> for broader generic Huawei modem coverage.

Why?  Does your patch fix something? How does it make the coverage
"broader"?

The choice of numeric constants instead of made up macro names was quite
deliberate in this driver. Did you not notice the style in the other
entries?

Most of the numbers, including your examples, have no meaningful
descriptions. Many of the vendors, and in particular Huawei, have reused
their device id numbers for a large number of products. No matter which
arbitrary product name you should choose, it will be confusing and wrong
for most of the products using that id.

More importantly:  Macros in source code are used to make the code
easier to read and understand for developers.  My personal experience
with device id names from other USB drivers, like option.c, was and is
that the effect is the opposite. I have to go look up a macro placed
somewhere else to actually understand what device some entry is pointing
to.

Most entries have a product name in a comment instead. It's probably not
clear to anyone, but this was intended as a hint pointing to the source
of that entry.  In any case - it already gives you everything your macro
would do without any of the drawbacks.

Did AI tell you this?  Why not?  I believe I've explained it before, but
maybe that was in an AT free dream?

> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -216,10 +216,10 @@ static int qmimux_rx_fixup(struct usbnet *dev, stru=
ct sk_buff *skb)
>  		if (netif_rx(skbn) !=3D NET_RX_SUCCESS) {
>  			net->stats.rx_errors++;
>  			return 0;
> -		} else {
> -			dev_sw_netstats_rx_add(net, pkt_len);
>  		}
>=20=20
> +		dev_sw_netstats_rx_add(net, pkt_len);
> +

This change is unrelated and not described.



>  /* map QMI/wwan function by a fixed interface number */
>  #define QMI_FIXED_INTF(vend, prod, num) \
> @@ -1024,23 +1031,23 @@ static const struct usb_device_id products[] =3D {
>  	},
>  	{	/* Novatel USB551L and MC551 */
>  		USB_DEVICE_AND_INTERFACE_INFO(0x1410, 0xb001,
> -		                              USB_CLASS_COMM,
> -		                              USB_CDC_SUBCLASS_ETHERNET,
> -		                              USB_CDC_PROTO_NONE),
> +					      USB_CLASS_COMM,
> +					      USB_CDC_SUBCLASS_ETHERNET,
> +					      USB_CDC_PROTO_NONE),
>  		.driver_info        =3D (unsigned long)&qmi_wwan_info,
>  	},


Why did you change this whitespace.

Sorry, but this is the sort of garbage which gives AI a bad name.
Please do not post any followups.

Thanks


Bj=C3=B8rn
