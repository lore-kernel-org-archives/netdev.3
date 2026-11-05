Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896023;
	b=X3uBosCh2Gl2EhL3NtEemOmkZUj+TWuLIjR/bgX3uoKU+c0psDI1uMiG5v4SbU0h5GgL
	 4fUgjMgy2hQEMVYZ3UdfhaxPywTm+bNSdiaLPiqpWrSjXRsFWB/mo2fdIlwqd4meLKwYh
	 S2941Ko1yy608BQnjTHP0MNzHiL1CzNvdwIc3syeAxf9F3g+4wCt/TrK96pcs/Wwjp51o
	 S9i9gEs8x+cazQ38SLuB/Zk49eQH/OSKfTX78RkHqBzwFo/mKqBywJiTxk8fMgI1YT2Yp
	 tkgasiYWEXPM7QKjhpmzjOJEZXeU9WyCF2aUrI7iohv/XNW260gvBJ/JHQQHVnEKqaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
	b=GYtAtZCcfvDJqdTPfzwkuBUo85ZnGZAz1xEBDgCe8r6xIXJ9YJ2tztw59aRRZDidviTp
	 yRy6AZzbr14zkjWMrBvR3e9j5+vtXV2vGfJKvNof7Or2/91iZOKp0Wg2LRzSV/rkv61y1
	 +X27wnf2budlVqaSlp9egQyhy85LgiYHQvYP/vGhzYHbladgirFR7kzk1x6MXRibQrKxB
	 rMQ+6/eAMLBQmOGaCfackAC98w0BUkeaF7AvpGb6cyJDzysPsBdZ00vQdkTynfvl0HMrt
	 WAXNOSxSjtANwlnsgDIGSkNYUiqYkG49Isuld9qIFc3ajyAijfvFNxUCuYheCgFGotQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111C606A334
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8111C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so738085137.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793896021; x=1794500821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=TH080M2b2W5GU83fC4bkAl8rc89cXnFJ2JUZ1DQM2E1G7nxV0uZ+iMHWJDX5M/hBR0
         v8Q4S1dZz9e+Wy709/pkQPJoJ382ui88GBuCa7YwB1Pwv+V08ySzbQGdCs4et9sFRxVX
         1a78LWa2r/qDmkC73yn92WJjnMydzWl2HaDmNekF7y5RHwsZB7YPGLTTr3xjjmuI4LbR
         sgpTrG1DSTm++FzIJZEq0knZSmQ9xxE9IezNyVfi/1ZtU95O+iPlQHI5LWAc3/YmXStT
         Vgy3IZE07Q/+XWoEa8k60w3BygO7yb8zhuyYBqBwOLPUaUevbalW8R2MAA5wjUpSFz6r
         zz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896021; x=1794500821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=QfFZDtQs0vZMkj8LZdqs7905yZvGxjUs3fXutLMSc9fHXO2yzuq7TjDKa0ZY8+Xb4B
         VuO4x4DgBG50Bj1hNvsfzcWcRQlmFahGhNHQMHVtfYhiCEM1gx2DwT6evNN8zAI2QKfG
         MR4PAvaKrJg+HrXPeENY4B+gvVx7pR9SvVavgh1NnkZNOdI5Uph/RlzkkyqkZTohiRAi
         y+gZuH8clo3AzRGeY852ZvVrPSRc+EoavJsKwBpqTNsoOlxom3f8T101sXVnPJ5OTgnw
         aA5+CVl3IweRlp2Hql6cb2+qdBGTK9AXbRGyUkoGU8txwgXIELd39HnXYFEtGu5aglMd
         aJdw==
X-Forwarded-Encrypted: i=1; AKwUvBwK63X7hZB+gwY1cj6uMCHrHib6IiwxxWiuPgfig3ZuQXthwWMd+dCgzH/x5XdDpmMdLEauLqA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IzPHJfWvbDZodJpZY90633bE8lEWoRwuDqeXLLTBcHJcI6NIh
	7CWYlv3ABnpyoqsarAzGzjakg7d0oxPmotJ1w1neakd8+xA94/rWdi0D5wi+AC/PjlM=
X-Gm-Gg: AYBFou22uD0kvhSzY9/zrRUYIYiknZAGfFyB+n2SsSvU07sQYQXYk5hTW+MH5Zgzyd4
	WADu+B/wWADiItaJ4kiOHwE+pgcRc+72QCcjo7ikas9lSUxrgeooVkhUl+6KXP7yz0ye8M3o6Qj
	ytD4eXdLgjUV3lMdAqrJ6ANSzArdDy3fFd+++YvfBCmM1ylPR/rzLbJmA/OBassiMSCzvbvhZHM
	8vmj4gv1UhhHUggEGE0f+es8BNW9XNXLW8xzsWwYypPaKamEii+xq7KppDHMidi0cvUvZIFMdtM
	AM47vstCH3Cw8zJG+xR9kjw1M+hgFZ6lfsmiKa/YQLyDabBB/fV1wtHKIjic9yIJRqdjttudCST
	O26OZW33HZdKAMVoxrYJfwioYvW279fexfCYRoGLE/0e5TRnfXpQAKi4nLWNJeLvk9EKn3FzpT5
	QPXEh5hAfoNfiJSA8ArLMV3Fjx/toI6NhI4jv5hIXnuBxr7ELYRgZ8KUpDaOeSpJBwefM6SY7/0
	k1vvaXoiW1Zuo/m7klS9npwFTtQtH4hVKEmSXn1Pa0JZsCCtEvFbxiXhgGkFs6VbP+2Dq3zJ+pn
	JcjdO3zz+Z3ZzD9bgipezRrbWeht47KKjKV7mwTPpxx1HPwYio5XdoHdglzmFZPuY3Fr0Ly3ggI
	trmgpwSksB1xXKiFurmxTAQiVVagGlAM=
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr29296137.15.1793896021174;
        Thu, 05 Nov 2026 08:27:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm4667110137.11.2026.11.05.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:27:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0Il-000000032XP-37xT;
	Thu, 05 Nov 2026 12:26:59 -0400
Date: Thu, 5 Nov 2026 12:26:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20261105162659.GB663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
 <20261105140352.GF3889730@ziepe.ca>
 <2026110558-tartar-juicy-036a@gregkh>
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
In-Reply-To: <2026110558-tartar-juicy-036a@gregkh>

On Thu, Nov 05, 2026 at 10:43:00AM -0500, Greg Kroah-Hartman wrote:

> > But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..
> 
> Yes, that is exactly what I am asking about.

It looks like that does the same basic idea of delaying driver binding
that this series does. Hopefully Leon can harmonize it to use the
shared trust level flag instead of a usb specific flag and retain all
the uABI around it.

But, even with this v1 the user can choose to use the generic trust
level and ignore the USB specific authorized and get the same
functional outcome.

> And I know there are other types of devices that will want to use this
> type of thing (i.e. SPDM seems to be spreading to other new bus types),
> so it's good to have and get right.

Yes, we are investing alot of time right now in trying to get SPDM
uAPI right when we bring the general framework into the
kernel. Everyone needing SPDM should be able to re-use it.

Jason
