Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B73A3E96
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500436; cv=none; b=oZ7UmtJmoLLgqIRlXfT1sm1ANzmjne1GTGezCrzxdsjtCqObUtbGyEQkndBww0S9ztJUUN4Uoo3vmRa2HlnUohf5OO4daes46/gHvhox6V9b8leCjkh9KRiHRYND0KjIT5/5DWUaRL++JmmpPKg3vfewcZiH1YiKQ88E1vXPOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500436; c=relaxed/simple;
	bh=vkFKAGAlUjQcGRhmAGd3wNWc7WWO4hyJ8Do0lvHwWag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clZvG3ErTrWx6Uw8ZOQsM7M1gHjUyxs9wR6RKGjBrePxZJERqwY3heisPtqO+vTq0n6Ev9O/uA9wwwYUnlTqSkexSwloIc19JHANVEtcyeRTsYasx27tCbaR//VOUVOMAYHZtTkWdYHbbdNoFdaaHsRK1pYStiRzAmJOF9Ia6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0I2+GGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0I2+GGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7BD1F00893;
	Wed,  3 Jun 2026 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500435;
	bh=M3eqKVq0PrvGgKCNkzHFBO65PqiWzg4JYyfWZTW9qg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0I2+GGD2k4302s2uS0AKoIyRsGIIk6nLnB3m5QztOLVMxW1J8ar4/K0t2Zz2WX3Q
	 Cyuvc62WeM+PpvQABpFVTq8d8e6xs1xxm4aGGzd4zwOg9vUK3qYX3MB/q3ztwg2Zx2
	 LQ3m0AcSwRphRwVTUaAlQx+JX0+AW810sjXCI4zZtd/rkghAYBv9n2f2uK78gJMYNs
	 Mq3BF5Ps+17clKDrcKqT8h0xfauScHwbxNAHMzyAt9LCPmNsmqWUxZ6sE6JNQ2dM6b
	 mqc6jmce2iwZsVV30PsSPlE5qUhLq5I0Kxgt6rxQR3b+0zdzQ4hCllb6Jox0QABpQf
	 GfQjsEhromI8Q==
Date: Wed, 3 Jun 2026 16:27:12 +0100
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 2/3] net: libwx: add support for set_coalesce
 in wx_ethtool_ops_vf
Message-ID: <20260603152712.GC3766816@horms.kernel.org>
References: <20260529075147.88398-3-mengyuanlou@net-swift.com>
 <20260603152153.3795063-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603152153.3795063-1-horms@kernel.org>

On Wed, Jun 03, 2026 at 04:21:53PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, I forwarded this one in error too.

I meant to forward the review for this patch (and patch 3/3)
from https://netdev-ai.bots.linux.dev/sashiko/
As I believe those reviews are more relevant to the
progress of this patchset.

I have now done that.
