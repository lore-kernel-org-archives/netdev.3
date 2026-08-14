Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E8416840
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698276; cv=none; b=ZipkPnslnGARJivs7Ax2w4vwlNl5UKeVndKlp7M65gbFvFSzslwBK68fKtTkE3AEN/95aqpfG9YxiUfs14MCpYIuj+FeO6xy/oLAUDWTaIgxm7TnOJA968E2kS6OUkv5FtzpkucN8tPjgY7uCqr1mI6QooCWAACsamm6/9THnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698276; c=relaxed/simple;
	bh=TVKuU78In4WxRZQ7vl+bTB0idxpevDUhM2Pvt8vSg4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv2UXijpPAc+jLQw4+QGcIpt7DEGwvu9uIZOrF+1qkbnEHt5AFw8XZ5cLwXQbSS1j+NRBRejxL9GPRcELJay3rIK93G75wUaAyUsl+dCjgOcClz5Q3fK7LUuBO4u7mXZBjYsik8kHlVeg4oUVJ5Z6tRNA8yooVDaywLlCzQLxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eI49kWAq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pmHbEXj0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eI49kWAq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pmHbEXj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786698273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=331Qtlk7U5woKtN1s72ENWMljrsHjQpeFCMNumZM9Pc=;
	b=eI49kWAqbIn0sjcXgtUCJR+MK/Vml4miDbdezE6qz3ea+o0W/LF4K5Q1+NVHIpkTYZFqT2
	0GVUKEenvK5R1H+eKCd8bvlZbNGy7Txbjt2uUzVJRFTxmsElvo4pCg/A74mP52LCG6oOUV
	M1ka1R8i+ic3ZE8WY/KQgaglpCDBoms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-csBkDI57OhKnhFTtUUa3yQ-1; Fri, 14 Aug 2026 05:04:26 -0400
X-MC-Unique: csBkDI57OhKnhFTtUUa3yQ-1
X-Mimecast-MFC-AGG-ID: csBkDI57OhKnhFTtUUa3yQ_1786698265
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f753a0aa0so440919f8f.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786698265; x=1787303065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=331Qtlk7U5woKtN1s72ENWMljrsHjQpeFCMNumZM9Pc=;
        b=pmHbEXj0rtNnhq3Uyon4atBLWSgsIhTI9OevS4iLiJ+VDtkqM2FIBK8h9JIB1oLwlr
         Em29m3yuM2FOg42GBLUbg1uVwTIuPa2oW6pTe1xZHXSzDQZQTsaYmrMDOHdDxT2Kl7Px
         dznd/nlY6bcNOUQurWaX8dsDHLQN1fL5WKj7/uWj6S2j4E/656v+2qiqHbrSs7lZtC90
         MmHCMWpGvWcxNtMevAJ1NBTysVu1nBX3KzPYv2bdH2cUTGl61l17vz9IKW7PNEfcEysu
         KPVMcAAGhJlRK4Lu3/QNmD3PPkuWd3zo9t28C96E/FWwlte2/B8p/pYJBR5EGy62DfJd
         //Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698265; x=1787303065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=331Qtlk7U5woKtN1s72ENWMljrsHjQpeFCMNumZM9Pc=;
        b=AWSTHaGuM5PK9IyqbW2NuL8K53qOi9bg3CxBSBy1Q/CAnAZ+Xm8pxGQj1CX+zgyxlc
         9n4hWP2COUp7fKkiAg5seisp8bjZbIUL3Si5XHc/ZgF0k1gPTn2UNBJSExcQlNvKx6rR
         acTRlcCI9a10x9h2iP3kLqJjTuFxT0IcdbK92AXdzFHdEcqltLQIpVSrHX+cVvDrsE9H
         Yqfzy/1/3/9Cdg3UDKDBWOZgq84X62BO0PcxaZHFQXBmlOdzuCpy6zox+IElbTYt20kQ
         4wMQ8P9NuH1rP69GGCz0buYroWjg7iMcYUPPufh7oUjVqPwxNQ+ckVg1gJHlWIURgatL
         ckJQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWWCXr/waaCIEeOjOo5sDWeDSvadUqtCfPFfdmG0ob7ugDrE/IlbDMOaBHOmhBxmwRsG/8wXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hvvJbMDkDqoN3KOgb5HO1bMnEZCqoGyyCRh3XPzW4JAHnrgY
	pwatLG/WJRYY3PwiNJFJ9JG4BHMyfDyuhyFPudtAWG3dl4GZ2P6xzoIFKC0mM+FNTimEqlEMode
	62hqGS59rTfhZTgK4qzfgdr7khTZ0O1KVU0DiBQSyh3qyl3MWPr+37fBdLg==
X-Gm-Gg: AR+sD12OupxD9BYjf504penMxLm6MkY8hP+Pf0d8XcuO/bF21ZmJXDoyMj35M9gUKSa
	dGU+hKWFQ24DFyC4Fc3WX2P0Ja6iinhh7vDZCwXpZLeh0S0beIS6v3R0166FLShYTx5cq2vI9Ho
	aDc/Cu4Hck3CmthwBqbBwAKmu0GDK/NirnP9J8Plh7EsUzimAnO5lAo1z90Qa5pwXPMcEm7Tte7
	ue0btWWF5jG3Uk2JrW4YCMQvl3/7miXymrYPCUXLW2vlBJXMHkiovcy+5GBWnki81nP5clJhljc
	Peh5bRMhELg6+BoJeyQRN0SKT8jh1kbp+GaeSC4rqEDoDz/4H3XjzHkaRfeRNZA+2n63lO+8Ydc
	o/cFLkZxT5XOOKhVfP4ja+iGndDnkj/C0/e/1BxgCgQNfIfa55qxm
X-Received: by 2002:a05:6000:250a:b0:47f:7e8f:d62d with SMTP id ffacd0b85a97d-48160732f09mr5564490f8f.10.1786698265196;
        Fri, 14 Aug 2026 02:04:25 -0700 (PDT)
X-Received: by 2002:a05:6000:250a:b0:47f:7e8f:d62d with SMTP id ffacd0b85a97d-48160732f09mr5564376f8f.10.1786698264582;
        Fri, 14 Aug 2026 02:04:24 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f1fff25sm10217805f8f.3.2026.08.14.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:04:24 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:04:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] vsock: remove the now-unused rejected flag
Message-ID: <an7aAsvcpoRd00ya@sgarzare-redhat>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
 <20260813173024.2362935-3-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260813173024.2362935-3-phind.uet@gmail.com>

On Fri, Aug 14, 2026 at 01:30:19AM +0800, Nguyen Dinh Phi wrote:
>After previous patch, the branch marking a socket rejected in
>vsock_accept() is unreachable, and nothing ever sets vsk->rejected
>elsewhere.
>
>In fact, since commit d021c344051a ("VSOCK: Introduce VM Sockets"),
>where `rejected` was introduced, there has never been a path that sets
>sk_err on a listening socket, so that branch has been dead code since
>the beginning.
>
>Therefore, we can remove the `rejected` field from vsock_sock structure.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> include/net/af_vsock.h   |  5 +----
> net/vmw_vsock/af_vsock.c | 46 +++++++++++++---------------------------
> 2 files changed, 16 insertions(+), 35 deletions(-)

Thanks for improving the commit description!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

