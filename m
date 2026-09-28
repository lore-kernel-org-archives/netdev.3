Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01529484891
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587969; cv=none; b=lSvFmG85+2v9qQUl6AGAC80v/+PeANH5QJq1sP6jp8IyE+O/j0OIUTQTifoo66+ZplxznTIeH6gVt5snZA/wAEPebALhv/cxwaHbOQBpFx4coHs3USfR7Rg48xtrjN3AbIb8cQmMd+KJ5jCwbpjASDM9z1gC8LR8ZxYI2NtB/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587969; c=relaxed/simple;
	bh=zdJp5gtsU5DvDRTqlp8vonxzzYsjXW/bAR+j6GHZVzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9zYyxHgT5GfS/C5oZHKyGv/Cf7C+R9f+y2XLq0OlNs6UDHAjBi9ew1sIRJPppiFf3TPAz4vwa1Efqf0wr1SxL3rr9A4PuAgLSxxlb4WrARuAm3GfHJi4As4g1bCSzKHVlCEw63Vdt811EPaZOOm8k+plI1mP+bAq7HBEOfXSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8O1jlje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8O1jlje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075001F000FF;
	Mon, 28 Sep 2026 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790587967;
	bh=stnLv+OO4KhyOCg158vSx5tj8F3uOZEn246mtjwMQDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y8O1jlje+uy50yTg6ee3UMoIBKFvXReU/sn1lipyYmKYXkWh85lPbCxodJVpAJjZq
	 vocvCXR4JR5Z8/foIiydufedF5MOqaoKmfeO9XshuPeXjNXxCN4eLRFjl87v+QCHaE
	 +9Y9tJS+XYBWi1p8yyWNkc2FsNmZBvuVO6ZSM43KBX/UXrcDsEikZ8J/WqC9I0c2VS
	 y4OttU0TIjBKp3xvbzdooTzaAsxfiyeLgP5wh4evbuUgUsLYTcL/U52fRrQcY3GdUS
	 g/cgC/kNLiUZEVtkF1NmKouVjb5ttxHshZpHwJBhEdOAyyJXXgBL8P4oDVZTsycdmg
	 okU1v2I2m+Y7A==
Date: Mon, 28 Sep 2026 10:32:43 +0100
From: Simon Horman <horms@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: pktgen: reject out-of-range node indices
Message-ID: <20260928093243.GL13925@horms.kernel.org>
References: <20260924053752.1442623-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924053752.1442623-1-4ncienth@gmail.com>

On Thu, Sep 24, 2026 at 02:37:52PM +0900, Daehyeon Ko wrote:
> The pktgen node command parses up to ten decimal digits into unsigned
> long, then passes the value to node_possible(). That helper takes an int
> and tests the node bitmap without a bounds check. A value beyond the
> bitmap can read the next node-state mask and be accepted; larger values
> can narrow to a negative index. On 32-bit, parsing can also wrap.
> 
> On v7.2, an initial-namespace UID 65534 task with no effective
> capabilities reached pktgen_if_write() through user and network
> namespaces. KASAN reported an eight-byte wild read. The read can cause
> a crash; the proc result exposes a limited one-bit outcome. No broader
> memory disclosure or privilege escalation has been demonstrated.
> 
> Parse this command into u64 and reject node >= MAX_NUMNODES before
> converting to int. Preserve the existing OK/ERROR proc results. The
> fixed v7.2 KASAN VM passed nine input controls without a KASAN report;
> the W=1 pktgen object build was warning-free.
> 
> Introduced in v2.6.35, the unchecked call remains in v7.2.7 and
> v6.12.111 as checked on 2026-09-24. The read needs
> CONFIG_NET_PKTGEN and CONFIG_NUMA (MAX_NUMNODES > 1). The unprivileged
> path also needs usable CONFIG_USER_NS and CONFIG_NET_NS. Tested
> reproducer source is available privately to maintainers on request.
> 
> Fixes: e99b99b471c2 ("pktgen node allocation")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Thanks for your patch,

I have a few questions.

1.   Does this problem also exist for other callers of num_arg() ?

2.a. Could this be addressed by using kstrtoint() ?
     That seems like it would cover all values that currently work,
     and thus wouldn't change any working use-case.

2.b. Or, if not, some other standard helper?

2.c. Or, it not, could it be addressed by reducing the maximum digits?
     I am skeptical that 10^10 - 1 is a sensible value and thus
     reducing the range seems unlikely to break any legitimate use case.

...
