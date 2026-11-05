Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887594;
	b=4wvdROB4DuAvATH9aKKIY043MzpiqMMlLLpr9V4iBqBM70qlKU6PggFhEWfZqAwXUPMP
	 yFJIQCbWUSbU+zMiuk/03prH5aGer2z1D7rHwqvUB+EGuH6uQ08MV4w36sHTJClHpLR09
	 IFBhbWNVMsS9eZxsSAQ15++Vx4ixV1M1H487BI2/cK25LNpVD0z6i0eB9cWXm3tWZJfA/
	 xp9Z0LdfO+doNc2xvDnMyl6PD81bSqhHvR1KIFFRbvM0/5w1LA5cM8sRsZq44NDeRzRTY
	 ZJgNxwOVL+iXEB9+c7pzl7ZtaL8hOzaziLOBnILNEGohoCLhg1GrqCSdlefgzAQt3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
	b=vf/d33tYtxtx+3qoQzWwFsepsSFHLOqzUwv/6BkBScGDaPLwq/o4lqAFW35m/mfEVtWd
	 w1j8Ye7uO9cNHAJxpgCARbWn7CSJskIJsXcb9LixaUiaTwhZk1YUM4Q1nJODH3lcSja9g
	 tMHfCktk4tsNCXZFfa133NtisEPvkCsVmrULA/MAQ5c/fQ2g+BNGKQyVKNSlQbnIpMR1z
	 AAQHoSY32jWM4NbYHRKpbCuG8fOjB9qqOffEcTSCMZffvsWz5XFGgkWquD8WvEy0gH35k
	 XMFR9F9H2S1xoGJP5Wn4vkeV12rAhrU8/2xYZbKLDsxDdGZmpohgcXcQvDa9HIMFraw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D05606A33D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09D05606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99ac154431bso113580241.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887593; x=1794492393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=RnR9WnLw6ZCMoaFK9OfD+Z3SyEdhvj+uf0rMG8hHCJ508GqyJ6ANwZoUk4+aGiOUw2
         /BkiFTe3GFbXdlDhgGNTyo1p8KbFcLTeuViDrXT0G8rPqBzVVo12Ao+p4Nr1qmRZcl61
         4eaArBRyBLbC70PWW9D8DSwCjUpFcwxnrtfrVG8awSc3G2DLBl7ue9/tyD5BZlfo0PwR
         zdxT7MPa5WtJxCqrk+LMM1B4PGIKPha9YDx2d3ZgVPNqHnLfPw9K0SbdoIeozyBU6kJV
         fXJaMOJT5b2NTv+4F4NS5Cw1swAwWPhfu1r6zxddYwAc/lzTbX1ed12Z3pRWm4FFq8m7
         OBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887593; x=1794492393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=tB+xL2qBySWPFqGn9o7tb9zf8lotPeIUUxYrmNFW0YV0tWS+KGiERKj/4HDcXhFlam
         mtq+7s7cfVG9CO8UR8rxVl0bugDlM16s5QubBAu+51w5WUWQgsEZoXFdGA371JUaJabV
         vNPn+5C6xCjdTE8aSjasiNk+2mGcZXAGuvIKV26kkfdyTFJCUDgC/sFSv9l5ncm0cbba
         Z3UyjQ2wNeyfWUNEF+0d62+OfoaPvoaPRcZsukaQpvbID93RBPJ3Qg1sPZWNztuugIW7
         aRGGsWAz1OAGa8oStoeO5dXctpS8znTIIrUSka3FCNacKTC75QNFqAh8M5i2yaSOvSAu
         7AQw==
X-Forwarded-Encrypted: i=1; AKwUvBwnpNud6dFL2X3T7I2Fsnp4eV6PHm7SVGMaHqddUwOrSattO2kKenqcsimhD0YJrV22rh1Mj3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ydOLYJUkgrWC0SE27gqD1m4ThHS9fLyeTtiLayqU7H4oeGnWy
	9f5lao9/XxzCZcTqrr97CopOjQu2voYgLBCiE53BNPOORi6NBQqzzcWwfWQK/Dgmhuk=
X-Gm-Gg: AYBFou36BQo1HfThyPiR5jhaxCZtEe3aAxbsJoxPffapxCRzodK+gaBwXEs+WkWWn8p
	eTxZ6gtcs0SdDKtVQoNlAkmGJkUfWzlJg3ezes8jqSHT4W/StTJX9A+1io8PYtlqk8qgGwY3+k6
	EEdyzsFe/Bn5pcCoKu7ZrJARF5wUN7tvXUpoRVNaKgphu+9EbA8NtpPSHYtzhc4AU4tDZS2WYzl
	Tvm9KK9m8pyREJuXbsl8efgmrmRr9YGhpfSz0gWzcpS/ioAyU6er66QUXKDfSZvkrKtgN3f0JwJ
	IpqyCbRJOE8LtYnModul+ndz/DLMHEjXaGCcJpdT5pQdCFHB5tXjQ6g50p1LQwJotJ+kzW5k+Du
	JNvfOA7wwXl8ahfDShkIEiaFI3PABO5Mx47SFze9iqHbzw/+56fJ5UzDZiYyEAg74LcR3tABLNx
	jjixGvs2yshxyXdVlm2uIJgJwtoLZOs4fgSho/11GJuHJd9qG3lYW3Irjzh1nzEOLuYZMDmNRTE
	XoC3dtiL9rhLSWBN60viEkTbwCPcf7sKjoB1nCmy8256seHST43s4Ab36VcCTtRNaue4I2OJOZE
	tiR/0dF4btXAYDxRh44hxzN9n08oxkXHUQgI8ITkAqcZlyaL0xcs17tDvbBMSO2CLshlefPe2Ud
	1nyyIaZpeaQ==
X-Received: by 2002:a05:6122:4f9f:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ec68949c50mr9274698e0c.17.1793887592873;
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm4161881e0c.8.2026.11.05.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy6p-00000002ezu-00ao;
	Thu, 05 Nov 2026 10:06:31 -0400
Date: Thu, 5 Nov 2026 10:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105140630.GG3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
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
In-Reply-To: <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>

On Thu, Nov 05, 2026 at 01:59:20PM +0000, Robin Murphy wrote:
> Yup, and that's true even in the PCI TDISP case - there's a major amount of
> "communication" and "configuration" involved in that. The principle which
> should (hopefully) generalise is that a bus/host controller driver can
> always interrogate its child device to perform whatever attestation and
> general configuration is appropriate, but we won't hand off any _control_ of
> that device to a specific device driver (nor enable potentially-impactful
> bus-level features like DMA, interrupts, etc. if relevant) without the
> requisite agreement between the bus code and the user.

+1, I think that captures the idea very well.

Jason
