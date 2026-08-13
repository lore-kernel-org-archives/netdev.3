Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC635202B;
	Thu, 13 Aug 2026 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786597221; cv=none; b=KyUuFovay9Fl0EHG//++FWtUfGmAiUm7/SrheNYdziJV4zi6CHi8q8OEXT9LG8llIhTAgwxosyfvoFLcAqxwdpMAEVuZzt4GqROuD06PIz2LtLQjDTPHKv8EWIKUQ2+2GGcLuajnOehAT9L2hbxwRDfLGxLwUUihHRDrj3rRKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786597221; c=relaxed/simple;
	bh=X/xhT8NU2HEliEZaLWJNAyvStvS4f7Ev0OFfQlIAQNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoBp3paTmzx9j+cU2eaxK9DZrzy8rhgtCBfrMwH4w1fUZlr7fB3D9IcAr9VBcfGbxrezdbew9Lv2sKHabrJdkPCVwAUeSXg/D7rb1Hk3H2r5ZoAUbjngV1UGQSmryBwV6Vfh9Wq5G5JmZC6SXDzSVDgZSgVEbmlBM0YZgeZYsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNPUQMgZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNPUQMgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9549F1F000E9;
	Thu, 13 Aug 2026 05:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786597219;
	bh=Zfjp3uqASrdxkYH3QywYeYmXZcUDPqkuBgcvRhWkUMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MNPUQMgZ2hjY7x1xI6uy13/eksKlKxN6hh8EB/rpJ4ZDlURHk657jM0Rm7GrBs7aL
	 qNrFYuzk3YiTGXN7x5U3urpBAVlh7cELTd6LDg214HWLRQZIFEU2I5SwLnWBieJQ3R
	 2AGTb1UUYYiZPlFK7Z4CjeN+IKbxM5dW3hK6OmXZJv3Cq8Pou6KKIXbUPV0P/amjLt
	 TYnqQNBfqpSubVpXlSQD4iKpjbJ6wwocTi5YAlj/7TMzz7S32lO8KERKgMxNWTBqUb
	 +5+TwPtx+enZAwEUO+NzrlCO3fN0iZjuGyDp52oia9RIknDXB2BzuP81tTt3YahI6K
	 Q8EjocMXli64A==
Date: Thu, 13 Aug 2026 06:00:15 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Adam Young <admiyo@amperemail.onmicrosoft.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Huisong Li <lihuisong@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v45 1/7] mailbox/pcc.c: shmem map/unmap startup/teardown
Message-ID: <20260813-opal-salmon-of-promotion-0eff38@sudeepholla>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-2-admiyo@os.amperecomputing.com>
 <7089dd34-18e3-4b84-a01e-361a4ce6cc43@amperemail.onmicrosoft.com>
 <CABb+yY1R7E8WTv9wHMqu1JSA9p8oQXavncNLi7m0bWH52h68tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY1R7E8WTv9wHMqu1JSA9p8oQXavncNLi7m0bWH52h68tA@mail.gmail.com>

On Tue, Aug 11, 2026 at 10:34:15AM -0700, Jassi Brar wrote:
> On Fri, Jul 24, 2026 at 10:59 AM Adam Young
> <admiyo@amperemail.onmicrosoft.com> wrote:
> >
> >
> > This will have to be rebased on the changes to the base PCC layer,
> > specifically to add the signature check.
> >
> At this point I would think you have Sudeep's ack on this change to the code?
> 

Not really, I had some generic feedback as this series has been very hard to
track and review. My last response is here[1]

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20260722-quantum-efficient-loris-adb10e@sudeepholla
