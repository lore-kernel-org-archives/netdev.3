Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E933EBF18
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793682; cv=none; b=YiAVZcwmcHWa2J/E5CiKCrU+1bRFGAkDWtg5Mv1VlM2PbljPBY1IKXgceVUKiXfIrWyxmriOcr7j5oxb2G8PP3G9AHOFIwzeHgjuB1cZaDRvdfVtdo1aMmtXL8QZ7qOauPNh5KMYOwEHw+XuGTUAow2yjls1ERxULqD+XbveYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793682; c=relaxed/simple;
	bh=NZm4HE1t7ovqsimC8eS8IajPVaVSXkWV+c3pw5RpZ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqLt7kIljZ5xQ5wQLreUwG14fVukjK+XP9u6oiY77xyUz+XUmriM6GvD1kI3kL6f4H9I98G5FB1ndY3zG7h6Wf4VR5BRIam9uu9rlW7k9YrAvRjLCma9Ey2D7W9FzPs67hnpxRT62dKUs1aLgAu/JOUnN3236GnOzJIGW2hhjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcphHTM4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcphHTM4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4728c12ba97so155506f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784793679; x=1785398479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5iH+ccPfGwLQBlMReI2VXk3NgL9FBKXNaSd0GoxYN8w=;
        b=TcphHTM4J+Ue2S3JO6qktPC2ire2nBXu2Pbehicv5N5DRsodvxDcJ9djEVxPMqZjgZ
         oZyx0waXUxIGIfe5vwDxTH/+RmyouAZOcDB18/60fZL9JSy7eCU2p4u6i3khHjnsY9+O
         g0teNvZYw3k6wG5YyK8VscKsljBgNhipDgL9igMTgqCluC1bCBuYJx7Yjcu8+2lruljT
         3YbE9KHfD0GdEkZCF+V54h1VRCj9O2hV0/dC/HpzDfiASEjt8jhmaWmdplbb7ca16ax0
         E1l7oii3lI5mV6UcivQBU2SgkT9Yk9wT+FctSPvi4743NHIY7R/ffq3Yq0IRKml7dIX+
         1nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793679; x=1785398479;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5iH+ccPfGwLQBlMReI2VXk3NgL9FBKXNaSd0GoxYN8w=;
        b=mflfN+4yjC7qYEvXW7kz1YjEzCjTxL3inn88W4VqfVXouofWUZzDfvbOc/HjO0c0MB
         ioUIqYcIPLVqfZRUNoIb43bioaCIVQcJT6Nw3GaLHIe0/4hNya4aLktEqe+SFweL3D0M
         y77/+xE6qE5inRrBXX5hem2h7AGYFjJAdUAMSKEYfXMWJHuxZibjpJh5zQ/kSfuTvRdM
         mAEo6VAxRKas0VcLVj9Ra/6aw3/XCQY85dN1H7zIb22d8GQGgw7BlJvXbra6Au1BRAnM
         zcfMMXXlA0EdTiJb1QDx+R9y6JGCVPpxPC/Y1BlmyuENMPaaLPQka26AtN7sYXHEmpaZ
         svJw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9C4LUvLK+03ABc9yeOm2GMKyV3iULKmbAx2ldl/9d/aLPv7ZobeLWZTQr0XrGRbl4ldhANP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUFdiQStHrsAeCUla045xUrChCV85BJZWmLLipABJVRzcH/uk
	UnSSXTs3Cdufr5+BEa4tB74COkeDztU333VZWy+FucO2n5Ilp5gY9xCj
X-Gm-Gg: AR+sD10VGCyTmqF+ZohdySC5DDAhDcHtna+5n8E/NylesqrX/U++vwyvzLyZ4Thn7ES
	Bmdk8Q09CI6MYmHXKVua4JJCdyCXmMdPgYCMB+nxvpyArku+BK8eIbTtUg3i5ifQyam3A3PBTpg
	2LKgP7/ucdBUUXS8POpt47VVJ0EB5emww2htJi12tM0b2xczrzvo27ZSlUdlJBizSPoHVB+1u3Q
	tfZOeL1uRmN4sxQn8O+vLEb0lOFG/YbiZbir0+aOAMnwUaVXKLNqvj6xai+hQmECBD93Io/6zoM
	LeeFZHHQNpXwzPg4lUaUrrp4L3Qtc39Bt2RugNIfIYeftdrgPJ5WJJB9bAiSqdudtqXFDK+l7wq
	BC40ctksN6WJkgqKWLhkjgyKTPzMKIHHaKz1gII15y7X/ouQLEb6X2Gx2efIz39rx9yfOk91JQe
	5ZhaliwjJTXvDBO5qveSpWp/VIlCKOVr0XNLK9tFI=
X-Received: by 2002:a05:6000:2387:b0:47f:6fbd:89eb with SMTP id ffacd0b85a97d-47f8dc936b1mr2500295f8f.57.1784793679031;
        Thu, 23 Jul 2026 01:01:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm12996832f8f.9.2026.07.23.01.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:01:18 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:01:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Hendrik Donner <hd@os-cillation.de>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steffen Klassert
 <steffen.klassert@secunet.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] crypto: pcrypt - Remove pcrypt
Message-ID: <20260723090113.5c2b9995@pumpkin>
In-Reply-To: <d45ed4a1-da22-44a3-9f9e-78041dd338b1@hogyros.de>
References: <20260713223234.24812-1-ebiggers@kernel.org>
	<20260713223234.24812-2-ebiggers@kernel.org>
	<37ecba68-947a-45ad-9ec4-361facc06a05@os-cillation.de>
	<20260721195004.GA3383223@google.com>
	<19613c3e-9756-45fc-84b6-b650ba3723a7@os-cillation.de>
	<20260722194023.GB2118@quark>
	<d45ed4a1-da22-44a3-9f9e-78041dd338b1@hogyros.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 08:30:47 +0900
Simon Richter <Simon.Richter@hogyros.de> wrote:

> Hi,
> 
> On 7/23/26 4:40 AM, Eric Biggers wrote:
> 
> > So while maybe pcrypt does still help a bit on this platform for now,
> > the approach does seem quite dated and largely a workaround for
> > inefficiencies elsewhere in the stack (including systems where the
> > optimized crypto code is accidentally not enabled).  
> 
> There is one additional aspect: offloading frees the CPU to do something 
> else -- and that is where even offload engines that are slower than the 
> CPU can still be beneficial in the big picture.

Provided what is being offload actually takes long enough to allow for
setting up the iommu, the two context switches and the interrupt as well as
the obvious setup costs.

	David

> 
>     Simon
> 

