Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732841;
	b=cTFvME5UTbmUyd8F5EBr9Kp97jOqDP6pzrECwuRmbTOb7PLPKS9z3oh1h+UabD0j55pH
	 EIu4zn4Qkquzw+xdfKwjlufR7twoLtaCYV+ppFM0rJh4As/CSflG12ijEmHyx/ChKoVB4
	 VT+1v+AbXEDtcyOucnEvzyw2h7rxIu3yjhvBDJmsIsuLk/SAnoC88tRxRAzS+wpZ35632
	 l2pwmYpw7Q+PVbw0xBfsMJG5RF/MOgbU6XLj00On8Gsg1rsv8ljUnIHMp9Pr6ljV4blDg
	 OG8JSJa+RKYELDHZkrbIU7Nk8vVBpXlx6pHgxtu+84UVHlcSHTr8zHVVtouXZELcOMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hpiuf3M094k+eUJB3HjtDKhVz83Nnw8OBVqB4YhqMp0=;
	b=dkLiM2ar0lvYD6CGx33RkPuEp2fbnaTGXI15QYsNq7rhoyz5wkYH1rmNMpDbjbO/hLfi
	 vYqaPSm0nzriI4Y7Gx4QVnVz+1o/dA0PYNc/d2qXNEGKgGABOT928c0YbgAzB6jsrL1qP
	 6Ns6u1CBqy094iFt6uStZIkNOdWHXmgb4FYxeaDNU8YbI7NhT4fj4F7b5ONS9D/JdJna6
	 2AJ05pi9oc3Q31ub71PI66fj487ouUaH0YeJoBZbhYwHuNgFKH8fe0pHUbinOkQgaYSwd
	 5osecDrt2xH8IqLq7WJjyhc9v/R7rm4xVSwaVL4Sj0lOu4OhvUI+aI9dE6MsH4Ylw6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=el8tqfIR;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52331606A32E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52331606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=el8tqfIR
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53634b8328eso40479181cf.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793732839; x=1794337639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hpiuf3M094k+eUJB3HjtDKhVz83Nnw8OBVqB4YhqMp0=;
        b=el8tqfIRmBOBpfzqQWRkw5z4u6KkRBPdUbKJDmidz2ClNKNldsAg02FGBksK9H/q61
         eUGHEJO/xrBnqswZVtjmnvO6AaeX15R9eM4APu5OzPXjDtQm5FBabdgsh1lrDkipaKgw
         aep3NvYJPt+IEH2Nd9n3L1gbH76ELbGMGG2efUPK+b9y9Emq3V3qC8S+LGWqOC78CcRF
         dcp0iIWBDivUPoWQfdJHW6VX114dgA45Zv41dfeKcExEibzJLAdKVarvXVyXOepEJil4
         6UW27tseaFRI6D3/cmRdOMnY/pKoCPkAS7H3W548UNgfNxxRr4FqYzI2E2IStIkrnE2G
         j7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732839; x=1794337639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpiuf3M094k+eUJB3HjtDKhVz83Nnw8OBVqB4YhqMp0=;
        b=IeXURRK0W791mSyEPcgXDSYzAoWvp9cqaWQ7mVbYutfr/bB+ofdc3vQ8dgWpL4Ovvs
         sOs05ELZQae3Lu0HnBpgzzp6s43HNhxJbB+5d3VTTzN8ncmPgbS9UX0Yt/7ynDWYMUO0
         /B0hFlJUjecJhwV4IgclXWcs31XHWm2yy8thYWMQtpcVjwOv8fInxJ0WawVa0npCw2HE
         vzt8+XotM9y5ZQcMmg1uzg/mLmjkBq4Mer8SvLhP7PPRmzVXM5mNH4UD1D4l5H0Jd4Tw
         pTlEZo5zMLfeqWYpjn01iQ9p+wqcJhwLBJ/mHdCdcH5vNSJw6JfTX7n5gxDnNeJmDx/0
         NHWg==
X-Forwarded-Encrypted: i=1; AKwUvByFNokpS/3gjhJ+vXoaKA6cs2yYmkyiGWhquu66NB9mJnmzHdYAv9WM1uqjIdSUc4+ocrwzhYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zFWfbkJx52tgEdMfKPjzci1/iJu2iGp2xZ16hqU9/tK9MI5c1
	wuSK6wTpba25++mvyNJyoQwHpqwB7m689ctz/gPTTEMvolus8BlY8NKpbcLAOKdN9rE=
X-Gm-Gg: AYBFou0BWSdQVe8OSTcgd/0cpr0jFX+AMZRNclS4Xik6LzruvXhMoria2HbGNvdJV5w
	QXX6Go6/IFB7tXTUT6SPIvSs4zR113EtyByYgHo/ytYCPdFmLnOgrk2W7xL0VCGuTUKtj8MBZGX
	7yJn2IW+3WX+m3WBbCbInNk5RdHtUwDWKdOpX4in55xnjcMFSYS6ZYJA1RHrzVKs+qQwfsKsTn/
	yYZ/sFOsPm+Yzd0WYF4dfZcEOTW2klWrQymTw3BGD2df2Q/QPww2/5bj2BKZIF4DYCVBE6iIBe+
	vPXtkvyMrud0B2UyR/h3L89WdMONIIx5cB3WWv/HOFJAexWnFmLJ1Zz7STcVBuL9d6vEreP4IOU
	LTpS7Gmvpmmlp4ATQdsDcLgMUOoeTPtkIbY6+CfPEBjiDWzEsBjhIqJDuFQHGNdHRopNX8JECOH
	ZlfRtqHVLcbfBdmHgf+SxuaeewsFHNUGl6cKf/sKt343LCGJANQuRbNMGv19dWtDcFjvdJ1M/Cm
	4iMLxQIe+nPFmxDQqPZmdIC6dYVZRDunNnbZAXPMaJQFpdU/4jNmAir80k0hXxyNXMTS7i5ND2X
	FwjGVgRh0i5CduWZMMyB8SGXieNKhju0dICu+OID18tDD75tqJKzw2lyqTgYmOAcOH7OHkjmbyD
	wEk4cPu8l5g==
X-Received: by 2002:a05:622a:4d1:b0:536:34db:e7c8 with SMTP id d75a77b69052e-542b781ef12mr235987701cf.33.1793732839094;
        Tue, 03 Nov 2026 11:07:19 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a6ca24sm3525731cf.14.2026.11.03.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:07:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOJqn-0000000DiZe-48Es;
	Tue, 03 Nov 2026 15:07:17 -0400
Date: Tue, 3 Nov 2026 15:07:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, leon@kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch, dtatulea@nvidia.com,
	moshe@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH rdma-next 08/23] RDMA/core: Suppress kverbs_provider for
 adversarial_mode devices
Message-ID: <20261103190717.GM3889730@ziepe.ca>
References: <20261103163949.1554-1-yishaih@nvidia.com>
 <20261103163949.1554-9-yishaih@nvidia.com>
 <CAHYDg1TnFq3EnG+6ej5SosbN02C_h5tobDtrqy5XQBk+g914Jw@mail.gmail.com>
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
In-Reply-To: <CAHYDg1TnFq3EnG+6ej5SosbN02C_h5tobDtrqy5XQBk+g914Jw@mail.gmail.com>

On Tue, Nov 03, 2026 at 02:03:22PM -0500, Jacob Moroni wrote:
> Hi,
> 
> Out of curiosity, is the idea that these restrictions will
> eventually be lifted once the ULPs (and I guess the drivers) are
> hardened? Or is it considered infeasible? I am most curious about
> RDMA CM.

I think it depends on people's interest. This is not easy work and I
would insist any attempt be "complete" in that it at least
architecturally defends against a remote compromise.

> Even if the drivers are hardened (no round-tripping WR IDs thru HW
> from WQE->CQE, sanitizing values from FW, etc.), I think it may be
> impossible to protect against certain bogus payload scenarios such
> as a NIC reporting a CQE even though it never wrote the data (or
> wrote bogus data), but this sort of risk seems like it would apply
> to untrusted Ethernet devices as well, IIUC. I can imagine it being
> very difficult to harden RDMA CM for this though.

Yes, the verbs user is exposed to some of the threat as the
completions are no longer reliable. The user can assume the wr_id is
correct, and they only get one completion per wr_id, but the rest of
the completion information can't have any effect on integrity.

Jason
