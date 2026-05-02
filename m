Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54B30FF2A
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777715115; cv=none; b=ke0uB60HxtDQzqWWO4IR/WRyrBh0DYT3cM6MHZ7JFtERVa4QeE3YNQKymaD4K/We3l4ny9zJRq4zaxw3tBE8h//iH7IgGApd6D1ZHt24/mJediq0Qx1+2mjPDi4+4NOQsxk9FyAjiIZWH4UusUNQyKImQOjsld7si6efk7rXfZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777715115; c=relaxed/simple;
	bh=tQaOSTmRG8h+Q60TQrv4Ps1DXYna/JcS4+Wi1K4sznA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO9rS+PJUNU8e8i6KJgXnBA13OPUtds38zblu3amEWW5Wf021NqApdC63XF6dUDRrubAeKIloWKS0VJZkMAV8usGEes+IMSD1WDjncwIt/s6BuqS8IdpzlueU65+NfciF55l5Uv2qNrv9Eg3oW1z/iK/km0YH6wWPZ/5/w+bS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3RIta4S; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3RIta4S"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d4f78fc9f6so288549685a.3
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777715111; x=1778319911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQaOSTmRG8h+Q60TQrv4Ps1DXYna/JcS4+Wi1K4sznA=;
        b=G3RIta4SbEe728iWpoGF26UeJ4CJffYNebybl7tV4EcJGxvlXG2CU0ykufo1lv4RHS
         xqZdNXiMMYrATW/wfKUkM7dG5YJNeizCgssMicfmz4VKBxO/Nna0c0LWRHhSzNA36G2A
         a8KvKAO4ezzGiymHhiK+0bEzQlZqqHv+WdsX6wzLhdGM0rSAKBMjcewupv/C/6aCwT/A
         YzASZcMxQ9B3KAfzvzh49Q7Ar1iDbpZGAhGlVJYNSQ32i2WTNjv97/D7nIn355VDUrs1
         wuudXFa54UkyDHQz9pvagFbvkWLvCxMPeOBSJRBZCb7BIKGu712rhENsmz6EAX8M14m0
         W58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777715111; x=1778319911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQaOSTmRG8h+Q60TQrv4Ps1DXYna/JcS4+Wi1K4sznA=;
        b=b4B/ZumOlgpnQGU8uQaNdT5o+mLgYaavQjg4J2P0d3vb98nXyAAkJq2ddnzO7KYiyX
         fnp0ySEDNW2bRy7wPzoKHW1Qlk2X4zQ30z76AD/DLuH25O+3RQB6S/bqS4waTHzngKRf
         Q3gg5GDe/9o4ebf2NKBcTxWo04+JyNnTe3SrwKWEPNgIwjHtQhhHYBhMMuxBuTicYZQt
         xswojSslPSQ83HFt/V+7YfJG7gxAv+yPbgIBUz2Z2wFgKe8pamKS3IBE6DIWQB7l+M+2
         8xepb5Katyg6LGCyeTxZvPiaWiT4CDiRKZXfV3q0gWk8eddFxgLXJ7GbAJaik2z7yv3d
         SS9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+hYWO8V9FTkZJ17Falb7Pd/R1BnN6Ii29lgMVB5vJdrHgFzyV8IYJE503QVhdPuYNnkupEGGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmYJOin+Ht/7uIgtbB+51raUjjo3bqvScJDNt+kYBiKf3HA8x
	8Cu1H5RKs0j9oSWl5kVRVMvTBdL4kfsY5oJREjQLVuSfQ2r7Kora8Hdd
X-Gm-Gg: AeBDietx/A4/N00+4zIh2/WQ4YWc53GN9zphwswPUEORrEtSivxzX2wwj5SBgl6tiZs
	w9MQxvTq1+bBXDuwzCKMtVnNBkLEB2J4ERIFWpbaFlnV5MKjX01rMjOgYG1MX5PAkS8EjB0SNk6
	EaRTkO6BLp69Bh0D/B9mnfjZrFKMVg1zxDpHBg58OHxADmYFlvkZFFNH1rAUnRbXUfRg+F9h+9q
	gH23apZaBkTRpzd/YF+ndYnpC32Fo/3WozY8+glX/B7Ygdmu6neuCCKm7s7GgE5ynlXF2iFiBab
	pko/sjdUuocqI4QcTyIrA0seXn7Ud9v7PVQC9r7i+tBfd9rCgIg8tKZtTJXxIBhalW1gsdUKCwn
	8hCaP1c4AkTUsRsMKORvxuBuQoVC7XzqkBy5ZGq/sPlAaEAhSD33iw+6LlDYIXzQYVylFfQM06Q
	Hp1yuWnHJ/+ucwAzFOCeVUfZiJvmFokYZhvqFUEVyL9KihUQ+p8mkiSipL9Dn9KKNt4Qs=
X-Received: by 2002:a05:620a:371a:b0:8ee:7dcf:ac75 with SMTP id af79cd13be357-8fd15dd0b63mr450795785a.18.1777715110658;
        Sat, 02 May 2026 02:45:10 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm475713985a.36.2026.05.02.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 02:45:10 -0700 (PDT)
Date: Sat, 2 May 2026 05:45:08 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Message-ID: <afXHpPPKhayawr9x@PF5YBGDS.localdomain>
References: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
 <20260501134636.GE15617@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501134636.GE15617@horms.kernel.org>

On Fri, May 01, 2026 at 02:46:36PM +0100, Simon Horman wrote:
> On Wed, Apr 29, 2026 at 11:00:49AM -0400, mike.marciniszyn@gmail.com wrote:
> > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> >
> > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
>
> Hi Mike,
>
> I think this warrants a bit more explanation: Why should addr 2 be
> accepted? What happens from a user-perspective when it is not?
>

The DW IP part has two distinct PCS address ranges cooresponding
to the C45 PCS registers.

The shim translates the PCS mmd/addr/regno into specific CSR writes
to one of two zero-relative addr values into one of those two
ranges.

This patch fixes a one off in the test that could allow an invalid
CSR write if an addr == 2 was called.

I can update the commit message to reflect the above?

Mike
