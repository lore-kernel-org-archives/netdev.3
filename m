Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2082E372B41
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505163; cv=none; b=IsVSo8xW+mq1btwg7StQoq8H2z50ksQTPCxJQRmPxuLnE5YJ02ohZ4as1sGp86vek1XsC7kjNcoM9DVTsE8aOC7/YuNBcKKSWrBflBXJ4TduZUXQvlDw7djC+rxwCQzbbT3Brc6SaLAlp1spRwlPt42O3nGK7fvzS0fHsFCaXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505163; c=relaxed/simple;
	bh=NIzL5Oh9zkJnEn+7zaKead3IPoj5W/cjTIERjApR6c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/qAFPvEuDmGaWfbXyauMzbLNRPCIc+RodyLl7oH45C6BUpWbA59JoavZqO7y3KSPhkkjZE/yqHm7CRi1/duXU5RvjlozeWYRMUGgsY0hL95OJKO8z9qw0FPwnqyVjbEdZTftS2enQk1vUtuPkJAzEap1JtGQvWIgKcdJXsgDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q4ATyA7n; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q4ATyA7n"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NIzL5Oh9zkJnEn+7zaKead3IPoj5W/cjTIERjApR6c8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788505158; v=1; x=1789109958;
 b=Q4ATyA7n9k8qECisbPn+tl7L6/0sMAeaZRRZmZa7GDfvGz04p0kXMKABeJv0tUM/eFJpZ5IH
 FgDCVLDqkiLVR4br52gLKqM30q8zs8KRv2DTDgXp/QJ7H3yr7pHosOPQz6gNbTo9n8FQqJTeio3
 6IhJDjnmCRKpljcUjj+RhuCo=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7a44f7c5038bf6a7;
	Fri, 04 Sep 2026 06:59:18 +0000
X-Mizu-Trace-ID: 7a44f7c5038bf6a7
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 14:59:13 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: [ANN] Containers to run Netdev CI tests locally
Message-ID: <appsQWUIC9-5Nze7@fedora>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>

Hi Matthieu,

On Thu, Sep 03, 2026 at 06:19:25PM +0200, Matthieu Baerts wrote:
> Hello,
> 
> TL;DR: containers are now available with all dependencies to easily
> execute all static, unit, and functional tests in an environment closed
> to the Netdev CI one:
> 
> - https://github.com/orgs/linux-netdev/packages
> 
> - https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally

Great! I've been struggling to set up the local NIPA docker. I'm following
the steps from your git commit description. Now this article saved me.

Would you please add the article link to https://github.com/linux-netdev/nipa/wiki?
I could not find it and assumed there was no docker setup documentation yet.

Thanks
Hangbin
