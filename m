Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7084FE2E8
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982404; cv=none; b=rBHLWYlcKqxm85UFoWrjMC8+PwOXW5l2OgwDui3KA4G3XU7kDXCtdkss24LiVba5xMyVYlsKHaMfqV0BNUw3tS5iUyKmG8MwoihNqFH04OrCb/x9eZmzRqDvLxMTtcK4tyhlIgrCgQ/pPO5bRBrvQ5/Kn1dwx7tWJ6bN6eetqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982404; c=relaxed/simple;
	bh=JHVx4PXMqJYlp8lW2UAdemmaCWI7bWUZI1+Vxrjerj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ydj6KIApGDMskht8fLAfg3sqxKEI49X19vcsyKCumyTuk6mO9atTIfc7bTcsEnH9oUO071Eu4BcZ0KSZmtMTR4zm0HQe5C+ejCWJ8VfENtU7kgP+1qIf8JY41lLt5tPwenr0ylUpYQS1Svl/V4+alK/v5LPUiK/2JSDTsgDxIKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRcyrkL1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRcyrkL1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a020e65269so26628355e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791982317; x=1792587117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h2lXGRufG/CkzlVDEuwvfDVQ2gYthCpgB+y1GvWyU9A=;
        b=sRcyrkL1QvMCxpmrkoJxmjZrfWjWnmwTp/swz4YF5AxP1FZmlxobb1aVwq2ipFaAAe
         kVbje50RcdNSBXfUzbLDdtMaadvFz/G7KjFSZIOH3jkJR7VLX2aieA56FdJm2yQwGMhF
         5sl04lHWb4Nsh0LTHBmfjklx3grdRew1CVwv8RcsSs9ySYiDzBShO7j+FgMKAPXw6IbD
         oYSXHKv+KNAGpuszTYmtKIID7xdeZ/m6jNhLr5iiSuTU0h6Lc9yes7YgN3cYDMuwZ8xE
         6Q2+O5AER1C+S7NHEADtk5dCySAf1NWqPFsAPCCVQ0g/NjJkd/BvghIEmH92JOHhwHAZ
         +Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982317; x=1792587117;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2lXGRufG/CkzlVDEuwvfDVQ2gYthCpgB+y1GvWyU9A=;
        b=P/BIcJu8f8Ey4vdnwz3mRqguNiFrb67H/lAJcGjqI2aWxrJwDMimWCr2Kypx4ZqDF+
         OlPZsT62jNVQJJT199Th4xDASjDdqqKtysjnFHDYDkxYOYaUT+HLeckLcT74A0DbzJQ8
         CnbOrGqeXSYdeYy5CcVA/QpVWS1p31I/6EoAIg3K7XHDhbFn0Pea/f4fotpAfyf+k1K6
         l9SFVg87KULQ1/tU56MkU6LnYyF4Fo3aLaDYohtguUKeuP+3lCzabtSUSS5Lc6Bg83yh
         2RWE9Uac63dAFGq+8BI+zNuT9Sl7qcSASgrZZAVUPxzSA9h7pWjCigwJ6ji/uLJe87F/
         ghmA==
X-Forwarded-Encrypted: i=1; AKwUvBxcciAO52WtFfsVBDJg39RoG0qbxPe339OYLRtvvYXKk4wGjxuxEE32bE8taSK4TPZM8AigOXE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhJrdcRJmQrkMCUV49oBUFVkswbkKihBbRxlFGtuEGggRDI8uj
	+UX/bDWaTjp4rQjFou6Q4V11rpzSFf1Fc3W2qfX7xS1szHjoTjy4eSLK
X-Gm-Gg: AYBFou2Wtz+xblNUu0RTBUFljzsjnDoM0zrUxVGaBQNo5W68pwZcazN74DZB8fn+X8p
	PBCDtf7gkcpD9qWkmWzScA/ChvVoDVLgS951e3/VHqESPXaVhJwVOc4E8/CiJLHoGuKlErs0D/K
	dE7Jf3H45pIM4Qe6JKJnYdLGZbaj9dnsbdbi6xlErD3/E9HcEWO/uMfi8Bu+A+hqJu4pXsAUnGW
	gr4gKlRJuqTXgArOH69462c0lDrUIToYA/WS0ozbFoh2TPcbM468ZR7jOz5UqfW1P8+l8Ho7cBv
	YvTbocWCbFhhYO6PV7DU/7nnKbk/gPvqNGxUr7o1CQXcmZhGzk5shT7VyWVB/2uPxOfhBbYx+cw
	A8Dtcbw3G7ZV2vCh/OmkKO8LmszDnNuNSs/+Gn/2u5RT07G617Z2UBCJzfNogx7jpoGfXDoMUQ4
	pQpP3tX9Nms3uevsQ8+QZvYdqg0idw2dlnzNYMqyWs8BCX13hliu/sAstJdQwfRWtELfpAIgXeZ
	cYj6wUZcgBzaHyF04T+wAxKuA9Szrkg7mc=
X-Received: by 2002:a05:600c:3e16:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a1992fd259mr236072475e9.16.1791982316612;
        Wed, 14 Oct 2026 05:51:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf35930sm435944885e9.13.2026.10.14.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:51:56 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:51:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang
 <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits()
 report unreadable frags
Message-ID: <20261014135154.05de968e@pumpkin>
In-Reply-To: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 18:02:44 +0000
Josef Bacik <josef@toxicpanda.com> wrote:

> Subject: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report  unreadable frags
> Date: Tue, 13 Oct 2026 18:02:44 +0000
> 
> skb_copy_and_csum_bits() has no way to fail.  When it reaches
> unreadable frags it zero-fills the rest of the buffer and returns 0,
> and since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
> skb_copy_and_csum_bits()") that 0 is the correct checksum for what's in
> the buffer.  Its callers can't tell the copy didn't happen.

Can't you use that fact that the csum function should only return
either 0 or ~0 and use the other value to indicate an error.

ISTR this coming up before with the 'copy_to/from_user_and_csum' code.

David
