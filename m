Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157160;
	b=ekyviG11i87ELPV1Qq6lxYMzW6m4t1mHvI0obmYfHi6ooyO/6V1th1+9xt0ns4Gnb/UJ
	 +nt324gWzGnUXIXrUbavnn4TiE2GL3MU6VjBNqf8Y1gC0cKB+s6YdJCIrYPY08uD7HIxl
	 c5McHUR7MpJnb4YF5TU7Nnbfx0nafn9JIp0F+uD84jlK7VmhGe6vG5VF5ft9C2iE7iWKi
	 yMubn57J61K4snppuob/emFyIS66E5hW16iYFTXrN39/G/F3XKCbbA010eDEJCh9XRLNn
	 eB5O7MJJAkmCdL/TZFeuB57nvs/3gF+hfrMkQ07p7uGqSgCdLzdOrZBO/Twdis+FJvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
	b=Qmv6pGF1Lz2+0BQw/1sXBnOldM3NtfxiWMKR32pIDXGCe8Kt4aDf76KThRambVaA2hkt
	 qurPE0Xu/qD2LvZei9A9pKL5iM76QgFTVQNKoxd9Jtg37NLPDrISPbEuvrxORttk43FhN
	 5XvdUiG0UevX2C9Y0wQu+VeeXL5pJC+yLJdXXdiA9CsE3HfFrXpVYl6OsfkNITo3qxxVo
	 ZpJLUzA3v7tySCjBPjo7PHAylFYRbH9H3iAKlVSsazXD3O1ro5xOF9T1M3j45a2Jas3cq
	 BwQ7kPlVmblnD855E6m+1mImry30JhvcRK+F1X7VglNwUPOGr7xNggJuch2T8HpJXOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ECF606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1ECF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ec2d42231so2161936d6.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794157158; x=1794761958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=vVWQLNs+Rnn6NOsMpjKSpUM9H3gRT4E/HZTt53PMAZ2SXIz+Low080hQm0r2oKAsG+
         HZ5TLknOMUGXKR3KUCz20FyQXU1Y7n4k67s/O97MTY2HciAv7W5/XWWVJI3wnxiYTpJN
         gDPuohXn6LbvsrECp0/Ji6cvN5My5wm8EgfEsTmjv66hd/4pZ3HhjPBADrWO+gshRLZX
         1w4cJtE0RQlZSB1u8qCDumnVcL5w0oR/W9xf8l09re306PAWvYklsReVbujjFSq7ckfb
         ysHxLPgUuyjzLYLRPYb0BIszOUV4j3JsJcseKz7sg4xVYz+KH4V8tOVQekOfo5kBRIRc
         SzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794157158; x=1794761958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=zaRtMcriKqSO0IZ8WRs2d/VCqAFADWJm9LanMHopSQo8AeAvZZQgDd7sj9N51CCbqe
         RiJLq8Z61Kyr9D0bLwN2p3DtPK544UnWgT00uRTp5rRVbE9MA+KKzOQF+ZAefsGyYcZu
         AvGTXNynT1ejSZQofg+mVbnNTO0Xa/i37f4Mj6Z2cqycMq1TDbZ/EeqfGAH41PS+n6ik
         gtQ3mVSYo/ko0FKqklMi/OSiU7XsjyPI5yiEhxl1J/uC6pC+terr6BugAfNXLnaPEvtx
         6JYp/Lj+25yWESLZpcby6lRir2XZ8UAz9ebeDspS3pfwE4NC0bgMcMV8pV137+unNRu0
         e8ng==
X-Forwarded-Encrypted: i=1; AL+hErFrgYw/4vZYBuwEY0DzGrdsd7ZxX5haaghX7Xrwz1mIL3Z+cUo/EvoWFfnr3Suu8eKjpbT1muE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SZB6jE6ckQeqOUSHO2npDe/GfqMQwlYToD0N1/9lcMWsWLGuV
	EhIxzx8cxhFaAsdYlMTTBBAgUIbVSBHO6eRcBG/MdXvbhTC4xo3O9YJhEraP2XFyWQ==
X-Gm-Gg: AYBFou0//51gIFO1JK/T1lA2PJ3kZbA71k+MVsGuY5GqyR2aL3cZce6CNGp8os1eror
	LDWrgo2dg8itFeC/KjIgpBg9+Pq+HDMnUn96qMObEFDwLF02YOf3ee9gXbudXNVqqWr9QwasjO6
	vrJV6oyV8s0yAfchcrsQgp67zwzrpAZsRWjlp9jAVBY9FQSJ1w1HLUGgpnGGorDL9G7t5YBV7o9
	wTXZl9RZXqHw41g7rNwZrG263BnfkpL8p40P7IUhrlF7egjt/Vax9i3wT+uAPjYJZiaLMM8i0Gs
	PpGXlaVsIaSh6vW2mTHxoqQEL9jc9Apc/SsvVuFICU9LTstsI5fDR/ftDx4LWXEDeQHGGsnNIZh
	sXvDSG8dNKGVShAWQU+XLsFPpw0EfBAEPlJMqqArpv9/gfLIexdSJH1qUJSGRRx0uaB8kCtOhrk
	681MxKEMd2GYRy7eWLeVlquyKpJXwMLO8rkHBZh1yr+qOas1dWcgrmDj/uU08twyKO4pQi8tXNE
	PAd1T0d2VZ5pntx3jIls2LJUK+QgKj6npCEhYpsPckvkdTt0l7tQPrZ2Qtfa7Rx3ZZLF+r9lHqR
	u5S7tlDM7PZUgz/niySN4cFtVFdh
X-Received: by 2002:ad4:5d62:0:b0:91e:9d64:3294 with SMTP id 6a1803df08f44-91ed240d34dmr24616736d6.30.1794157157397;
        Sun, 08 Nov 2026 08:59:17 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecedbefb2sm22431036d6.17.2026.11.08.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:59:16 -0800 (PST)
Date: Sun, 8 Nov 2026 11:59:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
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
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <647f3199-909d-425f-b485-b598a18844d1@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
 <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
 <20261105184442.GF8298@unreal>
 <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>
 <20261108110909.GA8635@unreal>
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
In-Reply-To: <20261108110909.GA8635@unreal>

On Sun, Nov 08, 2026 at 01:09:09PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 03:04:18PM -0500, Alan Stern wrote:
> > >  it ensures that the lock is
> > > acquired when the driver is bound.
> > 
> > That may have been your intention when the patch was created, but if you 
> > read the patch you'll see that it includes a whole bunch of material 
> > not related to locking during binding.  Namely, this part:
> 
> Once I added `device_lock()` to `bind`, I had to add it to `unbind` as well.

Obviously I'm not making my points clear.  Let me try again.

The entire patch description, as you wrote it, is this:

> Interface claims hold the USB device lock, but device_bind_driver()
> requires the target interface lock. Without it, trust-policy writes  can
> race admission.

This says nothing about holding the interface lock during unbinding.  In 
other words, it isn't a complete description of the patch.  It implies 
that the patch changes nothing outside the device_bind_driver() 
function, which isn't true.

Furthermore, the patch does not change any of the code in 
usb_driver_release_interface(), which is where unbinding takes place, 
because that routine already takes the interface lock.  So to say that 
you had to add device_lock() to `unbind` is not accurate.

Instead the patch adds a new usb_driver_release_refused_claim() routine, 
plus code in usb_set_configuration() to call the new routine.  The patch 
description says nothing about either of these things.  Not to mention 
the fact that your other changes make it now possible for the driver 
core to delete an interface claim when the interface is registered, 
something which was not possible before.  This is another inadequacy in 
the patch description.

I'm not saying that any of the code is wrong.  But the description does 
a very bad job of explaining the new code.

Alan Stern
