Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5173A8FEE
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252532; cv=none; b=PRLSwRQGAc9kSpfOMXvw33YmU2yxN0yUHj3Cre16vuhzxqsWKjj2RgF0dlpZuRWtcg+OXUS3QueKU4m1MZKQSN9lmXgoW/5LTNnoCAYP9lT+yUx/H87oidF0yGknDVHA/53xCqkW0zWYGOW2+D0D/N1U42UZJclNZ8An1tSltOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252532; c=relaxed/simple;
	bh=3pyT+YdpjS2XysUjWOV9STmcUoBSIxn/+89jRe06jnk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EiF517dYQMdMF5aB/sAYKbw12/g2BNusjXGvF8Xfyjxl5KeQiyDZgSVDR84c5K3UriRXYDrIqEXrRk4GSt0JZeFOxYPHCuUeX9hmMwJVodk+aQqI2Z2G/GHCYVRtahGNgWuHu2HKivhXxK9pEf18hm5If/osa/lBQO1ho0TNvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7ToiXn0; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7ToiXn0"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-98ff53fb739so472712241.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792252528; x=1792857328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7HIUZNWScATpZDK2J5WpO4C7vVI8kel4WHjrh6jwWL8=;
        b=G7ToiXn0i/t6APSVy+8u2t+72tFpMJksLnbvqKyMSTlk3qVvKIHFSGw2uPZUOkPm4I
         Hm+ts9U4iFu5QQ/XBuyn/MczBVUTZixb5ehTpN8qGaObjxnf0Bk4s0dgEMFG86WwEaYo
         Yst2qWY4tYyg89Qmwuzq27+q28Lt7E7svaQcj4bIfvnfxL3+XlUFG9m75/ZkhmzYXb9O
         uzADpV6wyKfZdJB2NwF7r5D54+b7E7JXBNTN+hylAKh2r06V57YWPgoGAXaW2Um0oLsj
         xI+lR1N9387AbNFAzef1Mj2aDpcT21XgdIlIKdCB8vdAYHnAe/0NsbvQxnW/OZi8Ozwg
         2Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252528; x=1792857328;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HIUZNWScATpZDK2J5WpO4C7vVI8kel4WHjrh6jwWL8=;
        b=N1h5u1AptUyOISC46hyeavi8VeXBoOxEyDINeI6n6FHinERqiBcbmbs4Zanj2fnQI4
         MC1Rm7qEuzNNCLSXhAOdAOe1mlLb9cupptQmvCOZIwrfWa6RjYSFy2YlS+92KUD6YDy6
         XMNicSv+Pv6dxe/uJKcv5u7uYL/vtvy3A6m1MVekSmdmujuC3aHJe8b4JjMXFuhy47ej
         2lDs2nmuSrfUgNv7zh8zq0V6lbIFL/EoFmJ76SesfPphHBluPjr52Jm13J1/+SYcGOp6
         giKXiZaWWhUZZCQz61NnbfqXZf3TfaDhn4x18p2XNwRi77+jblsD0+h85iIgqo8Osqmj
         rXKg==
X-Forwarded-Encrypted: i=1; AKwUvBysttJNBU4P+IxXgnuFCTeewgNd7A0PfxUHjQtxj9ugORuQFN7ErKoftdEk5hMwtizlvtbBkfY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAGqDO5g4ETSrFBjy2lNJD9QXFgQSb/wuRES6GAqEfefszPHCb
	Kkx+QXOdYihjQYy++gXO+PiM8+rFuMAaMeC4Qy+gar7BbQ+UYJs99TtU
X-Gm-Gg: AYBFou3PkIq2lX90xWy1SvoE6zNbmxTgwCOdR1lbfHM9O+FWX+NIthS2EXLN2elR53U
	iZ2rwZhDqly5d0X+BD7Ex4EXb3f15slmJ2jp6Ka2Y2Gd9en3cCO7kIS8Bfkewhfqa1zN28HtISl
	BoZuO5xM0EIlWFJakvE8aCR7v3AHD9tleC+/4Ed+x9MLu4QWLBqb5XGZPVTXSYmAdagDcbMS5os
	uBfKndPyrmvMZGN24p2Ma5isUFA7kNlL3LcUtmNA7216xGOjO/ah3n/+fqO31ztU5Wk59S+mrVZ
	mPHJzEmp5jZ7h1WIikyQ7OJYAZTRiTtiUbP3kKzSqQV7hGSkfA+J9bc0UnSjG1Kcpz4/+WIPhcs
	ntqOpivSG7JCyuDK9PDnufVUAcwKa5Kh99nKizrImQOu8si+Ae9RJXU835vg6EXCxNg/8FqGZAz
	rnPYvb4P1ZSYS9amjGN5loCKUei6lafCQ0Wkeb0Q1wZwkEwIzRj+RTUvOQtUc+alTFgrUddOJ/B
	2Znslt2TfJp7LfNTAeahZ//gCUkMRntl/038ee0ZuI0NqEZBzXKmgQdMqUaGwL/FjBN7aYh2TOT
	hEuqHcA2YOG97qkezsjgG7s6JelGTOubcZbClg==
X-Received: by 2002:a05:6102:441b:b0:7c3:90db:ed50 with SMTP id ada2fe7eead31-7cc369c0e9bmr910776137.17.1792252527694;
        Sat, 17 Oct 2026 08:55:27 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm492984e0c.2.2026.10.17.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:55:26 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:55:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Megane Hebo <hebomegane@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 mst@redhat.com, 
 virtualization@lists.linux.dev, 
 willemdebruijn.kernel@gmail.com, 
 habte.yibelo@gmail.com, 
 jasowangio@gmail.com, 
 eperezma@redhat.com, 
 xuanzhuo@linux.alibaba.com
Message-ID: <willemdebruijn.kernel.eb0f6ff37e8f@gmail.com>
In-Reply-To: <CAJPVW+nstfbagm9GxQ=i-5J6Xi_aZ52-YiQZeYrzmPD3OmDNiw@mail.gmail.com>
References: <CAJPVW+=XcHDV4aoXt5oAHYh49kX7m5wUxf7TucrcBy+q6MdXFA@mail.gmail.com>
 <CAJPVW+nstfbagm9GxQ=i-5J6Xi_aZ52-YiQZeYrzmPD3OmDNiw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] selftests: net: exercise virtio checksum
 ingress outcomes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Megane Hebo wrote:
> Correction: Gmail Web rewrote tabs and wrapped some long lines in the
> inline diff I just sent, so that copy is not suitable for applying.
> 
> The attached format-patch file is the authoritative byte-exact patch.
> Sorry for the transport noise.
> 
> SHA256: cd11c3970f0a23ac039cdfcdc6338c20c79dbff3db8fdc93ea53b4b8996437b8

This is not the way to send patches

https://docs.kernel.org/process/submitting-patches.html

More in-depth: with AI it is easy to generate testcases. We now have
to consider which ones are important enough to submit. I think we all
have reproducers for these specific fixes offline. If we had thought
it worthwhile they would have been included in the feature series
itself.

