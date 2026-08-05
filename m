Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3B33343C
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949806; cv=none; b=KV6lqkCUTle2pr9J/WItCHw7xXztfm3cjK/ZtGJO3kOfAMvD0xMdq85zDV3pxaRS5IBafOux2EuyESgnHh9A1FqrDYd1ORwp0Ouf6+cmDLWeUM/HgNWvAILxQXcZU9/30FtQDRFkZuS3vgXlLylPQMssjRarUMDK8M89JAn0+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949806; c=relaxed/simple;
	bh=tF0EKbgjTheWjUlqMU31+GpVMednOPdUKCKGwuQIJYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJOZT7ej7xlnDreolQWK5QzhCONZkK53y/I8TXUmHCyinuVi+LNDzRz9o6GasnK3Qi154e5RVWlp+lYM/AdF6hejooilJg9vzB6c09D0th+B7/lPE0SsDR6IBY0E+MDycSYf67t+/u0uexJe+lNHT49iqIe2Ag0mXDrgLJ91iRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEew4JNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEew4JNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3521A1F000E9;
	Wed,  5 Aug 2026 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785949803;
	bh=yJuPdWKpg6DI01dcIMeirgIgZSJ/HkE2qiavwodTEbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEew4JNPYzNMOzC2XWuHghhje6euHPrlUAsHDdz8bgzlCbzND4FV6aA/8w/HVW27z
	 P0NO4WFIMKKts4FcFZFy0I9PsDMzt2pLsVQbMWedD2gZdUH0Jz6JFEalne+QjPUbUF
	 LCXvt7/XVOAwdthlIOxlTVi4rrAsF/2YN/GtSWuMQHi3MlbqB/6Pe0JsinM1Qzu78m
	 9y9i+Yy8AwJ8tyH52KVdMILhubhxK2TMA6B4o/CP3HoV17RMvbFEJvJvvyXGYBov5t
	 HhAmI/ZfW0gN5KRqvUcUVpJBY+Eh1XXsxHjS16EXlcpp/cv0M0PK5YIivHsJlmJ5rQ
	 elQWMXTAjUk9w==
Date: Wed, 5 Aug 2026 18:10:00 +0100
From: Simon Horman <horms@kernel.org>
To: Ronan Marchal <ronanmarchal29@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: niu: fix potential buffer overflow/truncation in
 irq names
Message-ID: <20260805171000.GY51943@horms.kernel.org>
References: <20260803211149.10585-1-ronanmarchal29@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803211149.10585-1-ronanmarchal29@gmail.com>

On Mon, Aug 03, 2026 at 11:11:49PM +0200, Ronan Marchal wrote:
> Building with W=1 reports a -Wformat-truncation warning on
> niu_set_irq_name(): the "%s:SYSERR" format could be truncated
> because irq_name[] was one byte too small for the worst case
> interface name length (IFNAMSIZ-1) plus the ":SYSERR" suffix.
> 
> Increase the irq_name buffer size to account for the suffix and
> replace the remaining sprintf() calls in the same function with
> snprintf() to avoid possible buffer overflows.
> 
> Tested:
> - Built the kernel with W=1 and confirmed the warning is no longer reported.
> - No NIU hardware was available for runtime testing.
> 
> Signed-off-by: Ronan Marchal <ronanmarchal29@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, I will list my feedback to the AI-generated review of this patch
available at
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803211149.10585-1-ronanmarchal29%40gmail.com


1. -Wformat-overflow is the correct diagnostic rather than -Wformat-truncation

   Yes, I agree. But I don't think a respin is warranted only to address this.

2. Suggestion to add a fixes tag

   No, this is addresses a theoretical concern rather than a bug
   that manifests. It should not have a fixes tag.

3. Claim that not all sprintf() calls in the function have been updated as
   the commit message seems to claim.

   This appears to be true. But I don't think it warrants a respin.
