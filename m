Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804680;
	b=jo5i4Bvhnzcb/fs3qB1sG1/Xu5iT0n+l/T3rBYSQr7pyUlPjxURrHdUszEZzKhhPMy0D
	 hsJ1iF7K6mv5YQ7TM0JV+CY1Wqlv5A8zFblpAIb/dfj5knX0urcZP41R4IGlnw4qwxOEi
	 hRvgAtpdsyRDjwcpsfY6pRm17KKJqfPbKrYrA/mYeRGcGtgISvhyYwUSLoo0AAGi3Xutl
	 YyjJa2FJRWhScYLmUr+m7FS+IGcYBP4JJ9TfYqGZ5LZccboS5wc+hxqQ+K2sHO3XI1kWd
	 x3W8pt7T6y08yLQv3CSiymn3aBJjKiEJ8Uh/ZHUHO62hzR3uHoxnHN9/l+k5LvBr5Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/kXFui2Y6M4wWVfeKvuvI3OBKJ8D0ABBqlzGf+qKuD4=;
	b=NqfK8hC7b6qybSFh053uw7WbXr+Z84/jJI+ZYrSPJB+/B9/ZAk4Oy/NfTZEqsYEgk5c3
	 gjx+NGCI+zUTkFjqH4sJdchgRVnBum8MP9OAydSRKIsAOtJfSJwjXm+Ab29QEVVPX5pz7
	 WVbCzMIJR5GJowvNpOjm/WV270HyzHQE64eZ8bwUcKk/nNX/Th7cBgDCUqmHkANI1YZl7
	 VFPeTHvnANBSt2JpZ9yIQmQ7O9htdoPpOXNfl/gUZFyc4EPe6kHHsfj7j8ZOkj+2LZSpc
	 SGqU2YMntTglPWNH7guenetkrQM5nX/uu8GqIt5JWGYDTD2NPyeDRkfNf/MfiyP6YSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Bbfx10kC;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E33606A33A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73E33606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Bbfx10kC
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9441591aa5cso227296285a.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793804678; x=1794409478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/kXFui2Y6M4wWVfeKvuvI3OBKJ8D0ABBqlzGf+qKuD4=;
        b=Bbfx10kCLfB9Uhm6lrt1rASCnob60LxOUXr08+90qVn/ASfAZ7xASqarH1RPSS/b1s
         /zS4ijokVuFqt0K80Dw0r+/+KRN66qPWpcC97F7iSBe8FKkJ3TrwTnx95Tn1IqIO3CIx
         giaWBGS0ELPf2iT48QTnJRKhsKsNy7Epp4hs3ZDwjOjckm0vf5qJw+5WvPruFn8JNCSs
         QnHB+/7zhmCxv/cXfZR44mYrmYAEdrc8SzIM/JyuokKOmkLZEQZuUHqCMsiWa2m0x8/d
         Vd8gSS7Jum+OqYaPUK2Ba3sxi3zybKpj3aCPRG7j0Yp2pixsIWcHM6UgJ4Lcmp07ZHIW
         EXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804678; x=1794409478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/kXFui2Y6M4wWVfeKvuvI3OBKJ8D0ABBqlzGf+qKuD4=;
        b=gDBINpH6+3O+Vku3HuLTsGb1iSWB9OvVlfE1JXcmnlP0ZKlltiVfgP7ZswYOLBj6Gn
         1l/iUPbPc0RVqo1qszwXXc86EFbu8Ec9TdPXJNMMu5IJHju2NsV7eL6mFCuogQRcrLks
         Z+NIF2DSdISc9G+11jhsGOv7XKcd7lZDStpZ0K/ip8Z81fNmtRxR2g32GkORwyZBcZKo
         jCXRQC8pp/wyEtCl0JJDh1BfOV7PZNf88u4YCkM0ryZoEh8evO6vWMmREpw8al9lXfjS
         nHwG9po1kb5kza+tdVs6DV/Wh7p4ufnCR/MJzIfhu/Y8qg5wFeZyU2ur2bDdkSCf0xGi
         M7VA==
X-Forwarded-Encrypted: i=1; AKwUvBzjmkA6P57AGf/WjwowZZpW+PL/LNXuPF33qTvwSdwTyGWDZVYEbfQDnDgian8y5bcJRsgU3RA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Q+aiVvdo+yT0v4iizTkP7GvvukSCCqg7+4hfS7q5HszLzfash
	WdvP+l7R+YWlCjcd9wapbtETMZSD+RSZjX0Y9I1RhfyFpRo2OqfoVnlclVgG+X5EW5M=
X-Gm-Gg: AYBFou11mPp5WmoVFTGhXXYpWBiAcokcv4gebUFmfqc/DBKqYWPvOeUBQm21B94zeYg
	kZFGtSkZSPwHAXfzcVHYe/MYHWOsme8sIxGe0bjYzpJbwj2TaTx7JIJ1xuwPvFWMzaI0F8p4JG8
	G9Az7U5OMPjFp8c4FdeIwFDFDr1XUF6I1oFYPDEcR2aQ21cXK7hDomLqpUtyYld0kGkQfWzUCO4
	3BFFWn6eHgrDPK+5qr3GxVVSwM92fRufrPVW9rjoXhvw+uYknQ4Q3zYbfum4uA2KSyu0oQQACFr
	Dhpr23rW9NW4W95wKq7aT7vgdpMYVl/8NjKrf51eVkDrwgxyxXGR12kk9PBJkod8v4DPMj5RSA2
	cFJLqMufJ6OXxiyg1BAM0nqP0pZC4iMt2q1VhNi66Px4MzIlUg4oxwTWiiggnkEzuDSzEIe/Ouh
	kkMx5kkbt8kGEeA6Ukcd6CHBuCqfEJwI98wq+5oV1E2QfQqOgzZewAaHo0joq1enhdilJRSRkNh
	NbLEke3aeRr6AC9jVMAAxyavCWvL3OAHP5gGtXDaUAnBMfiw9+2/IZiPg4ebI35mBnQpBdUx8bi
	Z4S+NxKjzH0c3NpvE8iB58zFdwaUXISB8Urp50VGqtJK1GLgV2R8aeOHIUmUk6UFMS5Kc4S8O1F
	22BeultIoRQ==
X-Received: by 2002:a05:620a:6486:b0:93e:c12d:4ecc with SMTP id af79cd13be357-944134066famr2851022685a.44.1793804678031;
        Wed, 04 Nov 2026 07:04:38 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d47e72fbsm219471885a.18.2026.11.04.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:04:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOcXT-0000000GNdO-1REH;
	Wed, 04 Nov 2026 11:04:35 -0400
Date: Wed, 4 Nov 2026 11:04:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Doug Ledford <doug.ledford@hpe.com>, Jakub Kicinski <kuba@kernel.org>,
	Slingshot Open Source Team <slingshot-os-team@groups.ext.hpe.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Sandeep Bhoot <sandeep.bhoot@hpe.com>,
	Iraimani P <iraimani.pavadai@hpe.com>,
	Mamila Santosh <santosh-kumar.mamila@hpe.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 00/23] Subject: [PATCH net-next 00/23] net/hpe: add HPE
 Slingshot NIC drivers
Message-ID: <20261104150435.GQ3889730@ziepe.ca>
References: <20261030-cxi-netdev-submission-v1-0-8c2c391cc283@hpe.com>
 <20261030151121.1f232b50@kernel.org>
 <7d4583c2-e8dc-4ffb-bc45-e2121f824b14@lunn.ch>
 <bde936b5-1b3f-4987-a3e5-36ec5c4710e6@hpe.com>
 <2f831f13-58ff-40ca-a76f-3aca647012b6@lunn.ch>
 <b260f39e-2ac0-4899-90d9-3e9dbadfacc4@hpe.com>
 <e9937650-1354-4d66-95fa-3492e3821823@lunn.ch>
 <3418b0f9-d053-4be1-81a0-fc938fc5a7ac@hpe.com>
 <52b6596b-385e-4ed2-a6c8-d0774b4be127@lunn.ch>
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
In-Reply-To: <52b6596b-385e-4ed2-a6c8-d0774b4be127@lunn.ch>

On Wed, Nov 04, 2026 at 03:48:58PM +0100, Andrew Lunn wrote:

> A bit of an aside. Do you have the complete history of the driver?
> What did the first 10 patches do? When bringing up new hardware, you
> start small and get a little piece working. 

If you are implementing a driver from a datasheet, sure.

However a device like this was almost certainly co-designed in a chip
simulator along side the HW and by the time the HW was done they had a
mostly complete driver ready to go. The actual baked chip probably
never ran a driver like you are imagining.

> I'm assuming you did something similar, small bits of code you could
> somehow test. Those small bits of code, step by step development, are
> generally easy to review.

When you are co-designing with a chip simulator things work
differently, you'd focus on the more risky parts of the IP and do
partial driver flows and so on to vet things out. Lots of carefully
orchestrated shortcuts. Then you take that and assemble a complete
driver to run more complete sim passes. As this progresses the HW is
changing underneath and the SW is following along.

So it is completely understandable they ended up with a completed
driver at the end of the process rather than a bunch of logical small
steps.

> Generally, none. We just want a plain, boring netdev, which looks the
> same as every other plain boring netdev in the kernel. OS 101, the OS
> is there to abstract over the hardware so all hardware looks the same.

Yeah, this is a reasonable place to start. I also discourage any uAPI
introduction into any new drivers. Start with the basics then we can
talk about why it needs new uAPI point by point.

Jason
