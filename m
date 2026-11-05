Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887436;
	b=C7jcf+l5C+DH5yI4Gmy4p+RgdI6atI9JyE8TTRrsN9mJKr+aHWquvoxBZNxcHrWqU6Hh
	 4rsGS1bRZ3O1qlpyIF8gEOyIn3WsZexOL6RqAyEothvCeWx5FbRcAUrcQsJD0la7NdOvx
	 Z2BBH1r6/Do+xAEzUUqRh3cSGTHe7aqtF6mCEsBAs2W72OCazQqKkBPeB2Tn9AYc6Rv1e
	 7TMRSxB23MnefC5fEm6JY3Fw2eYtCS5ZEer32Yvpq3W9U7fvfnWo5FyiYT1pCmIGHINlJ
	 SRFo0H6AnbH+wmcgHtinwBfbLGuR9XOsDprcDfTJWUvONeLgScn2uTDlhX3YIj/dPXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
	b=zqqhZPiLPe1Gfy39/eN/d+xZdSdwnsC5Xk0jzsq15x6FxF6kyTsRIwyjYDMkt3j/EEkU
	 X6kuzFPniVJlDYPX0ksE9FLzqKtXQ54jpIvYnZoSaZPf2OowqGmQ5KaIqqdbieYyGtUI7
	 PTBYOqRkkp5hhwBdMqHYMrqIxSxZj/Z9CsMsNkCD6rP7Ba7UEJjvsU4BRUJPNHAT6XuLJ
	 i2/+KHsQR7cOcPkg/cFZ+Cz8tRmntDY2F0k0jNldmHl68RUwAJQsknM4fwfutDH5J7yMz
	 d5KDsz8/7lnGiAVC5kDbFFwaagnbybvAlAdsW9iFYv+lZRFaNKL60Wk1hcmbqK17BLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57279606A333
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57279606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so1174502241.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887434; x=1794492234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=kz1XgIBbrvBVV82jfLwzl2boDjAIVUbeNVQas9Wo1Dk5Xdi6H+C3KcpCevzEdclNJ0
         lzsSeS+uRFo6w/gIJIYGLA5nYX/ZA7GDEfg8ye+MEqBYoDAQ+XWmrXIScd3vjjxi3P0s
         TM9V8bmM9C1gt69mu+eIyGDX/aC+cI4xa87K7AUD6ZNwyr7bJjPSJ34eRy3oL+DhO4T4
         z9GIW8q+b2I5fYq6rzeAUUwY6D1cOnVfqLouPYFCQGVgJUGlc0n72Hhgr3e5/i+LRsW4
         Jqs+IOHbUmP6UlpI+ifiIR6Yqw/evL4R0NFbQH8ocPPe+5gcxWg4oty37gZrialLDEod
         LNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887434; x=1794492234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=Ew64id9ktIzFz3fn2eRhqkzT9yxvN0rfBMKIelLUW9N1AYsasobHDElyAl5JeUMct8
         il+x7zxpO6y6uGhRpkzndqWgI33dFuWuZfbqXEu7DnOcZEYgrjwPpPp+xQVp2zj/KAoE
         mduk6i+/f7YTQ6FRf/3pXalNhdeiPbJQFtoMoAn6BAiSBaQ9YSzpA2ycTtEgogw5bylA
         SJfuotRkNKPYDzDS0AQYXaFXkfmTot7AVxR7rZuL1DY2w5vKriJ+1b6PX51aZvv75r0h
         PVmyoCtzQTT+9zAFWDO/YD0iDdmAP6zi9OItuMNCn3laOuYKUmZoWG1H3NvQLq0AQo4o
         qazQ==
X-Forwarded-Encrypted: i=1; AKwUvByusu7wHqCiEndUZmL7B1aQ/S20WB6R0BshKrteMG3eVazmCCp858OA0r7GxU9Qi1lDp2c9Jgo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UUnuKfK3/BCj2tr4MujoGkq5X4lI3P1zw3rODGDoE9R/NcEau
	HXrT5sYR9e0btNrG5IYYlmeNTVSYKihHjz2A/hFx21E7m86UxP6jFYG3PGX5SFEI0Sk=
X-Gm-Gg: AYBFou2XK3PMANkFkXdWvfZdRmjVy/HtlMHx0T9weRv59HDZOW7dVkBoxe3sj5olxW9
	2WH614hPH10iG4JXmTeR9jbjx31qfs3vSOWM1FmjUPX3YOZZHcisLPhCaQy70j3kTuLxAQcdHGx
	qXX1bnMNArGwYHBFsxQY3eGMLO/MJsr5BPSM8VaJ/eQhLe1TlEH4uslZmXYU0W35DyHukg5qo4c
	txsmA7S4J13oixRZLW9o+xonCwtJSxdwfvYM47PmOqeH1jO0JvWIBx11rIUMVVyOR5AY5KIJh78
	WeHnd8XwUJMn4FkOCBcX1gDBc4IWA/litIpYPG83c6s50iXqgc5lE33ZN7aa6kiIFRnVInyI744
	TdXuO+UPQLUfQhuFbOenciZkMQgwUbHKcPGsZFJEs+whQLT2KlGlx8ZhZudtpw2hO2zxMTHqT96
	cNty4WOxsXeC47xnfqZHqSUu5BKNl3pMny0gXMVcUumFmDqBLH7iwlmtwA/e3yANfgviZ6RdaPk
	G/toOw+WlJ7mx/7LeiodCs2IWKf8QRu8TT6fuLFx0kqEGs6I9Q2IAhodJJMG41VhNBUTTuK3gpn
	5d+NUxejEoXE4/ioYatBvZh8AsPTqJmHORyp+RPCikhXmIZGBsfBN6n5fjnz8X7a0LWd4/NpzZ/
	8t0Z3809l6Q==
X-Received: by 2002:a05:6122:8f88:b0:5ea:cfd9:8fbd with SMTP id 71dfb90a1353d-5ec689b0f30mr9760208e0c.17.1793887433885;
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8de4908sm4235128e0c.15.2026.11.05.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy4G-00000002ecj-0pCb;
	Thu, 05 Nov 2026 10:03:52 -0400
Date: Thu, 5 Nov 2026 10:03:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261105140352.GF3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
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
In-Reply-To: <20261105131856.GA8298@unreal>

On Thu, Nov 05, 2026 at 03:18:56PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 08:12:51AM -0500, Greg Kroah-Hartman wrote:
> > On Thu, Nov 05, 2026 at 01:42:30PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Convert the PCI specific untrusted to use the common device trust
> > > level. Adversarial means the same thing untrusted does.
> > 
> > What about for USB?  Will that "move" to use this common trust level?
> > If not, I don't think it's very "common" :)
> 
> It supposed to work for all buses out-of-the box, at least this is the
> intention.

You mean DISABLED/FULL should work with this patch series on USB
right? Meaning the core code will not bind a USB driver when DISABLED?

I was wondering if some of the broader things we are doing on PCIe
also apply to USB, like device authentication. I don't know alot about
USB, but I got AI to help me find some relavent spec information.

 https://usb.org/authentication

This looks like the parallel to PCIe SPDM device authentication. I
would expect it to work broadly the same way as PCIe if anyone wanted
to implement it:

1) USB discovery discovers authentication support and creates an
   attestation subsystem device for it
2) The struct device starts up with trust = DISABLED
3) Userspace runs the crypto flow through attestation subsystem. This
   is extremely similar looking to PCIe SPDM:
    1. GET_DIGESTS -> device returns a hash for each certificate chain
       slot it has.
    2. GET_CERTIFICATE -> device returns its certificate chain, read
       in pieces.
    3. CHALLENGE (nonce) -> device returns CHALLENGE_AUTH: the chain
       hash, a salt, a hash of its descriptors, and a signature over the
       challenge and the response.
4) Userspace inspects the above and approves the device
5) trust = FULL, driver is probed.

But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..

Jason
