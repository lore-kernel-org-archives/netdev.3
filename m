Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4438C42F;
	Tue,  1 Sep 2026 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252053; cv=none; b=l3gX5QvAIK1kEKzyY/m65kHSZO8HgtVHqE3vQ0XSHwjIQOGZK1JxaM0bbYfX4xdz3I1IPpnhnwDVuvJP/di4KyNxk//fzobtvaI7vdRb5WFJE3KiZsvrnB2Cz2PXcJpWT8HnKIqgT82SIKgXIItj3mM44/HzU20BI2MssDHG+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252053; c=relaxed/simple;
	bh=XG61fYTYZ+z+MMqRrZHqdwC6snXeWdZqkX/bX3ulsuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQHMCBP12fYOCKkfqHEErmVasnIX17zz6Ot2kAL/F9piz2ohNC6uDs41EQrCy/7VqYVmUyllTXy/e/BhSyHf1nx5uUHhRI4kE32JEiKOhy1FUIGgkrQ1vIbwfkPB/14mxftLFg1/KYD45HtpcmSBlnoVfJLWm2oNWkZgwJe4M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=m5JVgZNS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="m5JVgZNS"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id ECA4F20799;
	Tue,  1 Sep 2026 10:40:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79HTfUNoBlby; Tue,  1 Sep 2026 10:40:49 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 607B120189;
	Tue,  1 Sep 2026 10:40:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 607B120189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788252049;
	bh=VmJXhMCUKxJfTqQ7p0Z4k1hfeIzokvWxFuVWHxN2XmQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=m5JVgZNSHPIVIhhLy7Ko431bWQoI5HJtUpK/k2FT4mDwQ8ffDmbOXNHMwkqIYOPLc
	 np5vEwAo7lTf6NQeOCV2nPZQeuzYVTF3NEjVF+SEWJBAodfK6y5kEIbGf4/J+S00QH
	 FiwYd3b5e9x1KEsDZHgvKezdwO3/RopQFMWXwmymYkXouH+R+siXDX6Ah4ZeTkx9z8
	 Y9HPnHs65IGUQZ3Rp/ztmWD8KoeZpweS42hMVvOuTLT8LkXGCCAinCP6LlAr3mDWCi
	 2wKJ1NjUVeLnbgW9XRzgtwBiNUWTJze+NJwcZ1LBz3mxV6fLsshrtnemPwiaHTfK/J
	 myi6sYeiAxS3Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 1 Sep
 2026 10:40:48 +0200
Received: (nullmailer pid 7716 invoked by uid 1000);
	Tue, 01 Sep 2026 08:40:48 -0000
Date: Tue, 1 Sep 2026 10:40:48 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Maher Azzouzi <maherazz04@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] esp: downgrade zerocopy managed frags before
 mutating skb frags
Message-ID: <apaPkA215hGGd6wZ@secunet.com>
References: <20260817133752.30033-1-maherazz04@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260817133752.30033-1-maherazz04@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Aug 17, 2026 at 02:37:52PM +0100, Maher Azzouzi wrote:
> On the out-of-place output path (esp->inplace == false) ESP rewrites the
> skb frag array: esp_output_head() appends a trailer frag and
> esp_output_tail() replaces the frags with a destination page, both
> referenced with get_page().
> 
> When the skb carries zerocopy managed frags (SKBFL_MANAGED_FRAG_REFS) the
> payload frags are owned by the ubuf and must not be referenced or
> unreferenced individually, but ESP mutates the frag array without ever
> downgrading the skb.  This breaks the managed-frag invariant two ways:
> 
>   - esp_ssg_unref() walks the source scatterlist and drops a page
>     reference for every frag, including the ubuf-owned payload frags,
>     pushing their refcount below the GUP pin bias while the pages are
>     still pinned, i.e. a use-after-free of the zerocopy pages;
> 
>   - esp_output_tail() installs its destination page as frag 0 with
>     get_page() but leaves SKBFL_MANAGED_FRAG_REFS set, so
>     skb_release_data() takes the skip_unref branch and never drops that
>     reference, leaking the x->xfrag page at packet rate.
> 
> Fix this the way every other frag-mutating site does (__ip_append_data(),
> __ip6_append_data(), tcp_sendmsg_locked()) and call
> skb_zcopy_downgrade_managed() before ESP touches the frag array: it takes
> a real reference on each existing frag and clears SKBFL_MANAGED_FRAG_REFS,
> so the per-frag unref in esp_ssg_unref() and the frag release in
> skb_release_data() are both balanced and no mixed-ownership frag array is
> left behind.
> 
> Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
> Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>

Now applied to the ipsec tree, thanks a lot!
