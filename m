Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6593B6C14
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953992; cv=none; b=JaMjn0YjVeOoQim83t3To+jfOrUYg825d4V9EN5bHS7vWTt8Hz5XjTBir5D48k5YFHTPnpPqtdhvjEPdwiHZeaHTCgvbG6fFRhrSF9E+GIjAcL8Ipa8eqxG/Cbry3z3Z5mbz58ltkBPZJT3bPYQn5L+PFV065vG53jIeNemd/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953992; c=relaxed/simple;
	bh=f/rXjySSi5uRPJpLKDv9hpZIFg7DNCLQ8L1n0hDN3cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYvN1lGz97gdduvMcxG2ycRzw6INJTm1OX+ROTQvxYE6xngdLjmdnb5bRgHHj+sP6PpKQCkJe3AIykqqfsrIHPaFxo7Tr2M23ibPuOT/2rkTUj+cknFWVH2hJSSHxvyhKSlMynFwNkOqG9KzllZ/vxiPjRbiqa1QviMNHzNYOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8LWty/8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8LWty/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786953989; x=1818489989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f/rXjySSi5uRPJpLKDv9hpZIFg7DNCLQ8L1n0hDN3cw=;
  b=f8LWty/8/MDpGAG5KD5dsb6kYlxuUhlrx1lx1YiRwcVPl/6Y1O8PfuJj
   mVAVQCZdARG6bxz8Y/CyvHpvYT8Fce9qiCjPVXZTBiEPe5Sk2IIimDByz
   P3q60sjwyDbQ0+2AZdvTW93M2tVZd5Yxhj9tz9OJevstUsa5xMT7/DZ8K
   wjpO1/LKkpuz3UvS6+mRfS9vPMWiVQKk9EtakcLSfKCpdRuc5qcgiEN5Q
   NR6GwGVrXQGFC2sZlwha5w5TbMp6rsMYWZ3Ao9FIV6mlbpTZbFL9waiuM
   mSrR4YsKJAEMa+NmqTS5Dp/XLWH0dXfooHlWpt5DZzVcIsNv4RMSjkVdD
   A==;
X-CSE-ConnectionGUID: ZKzDYJflQIqtFQPclcL0nA==
X-CSE-MsgGUID: 8Ura1lBVT4ae7HetBuwF7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87278718"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87278718"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:06:29 -0700
X-CSE-ConnectionGUID: 5IBla2NOQm2AKJgdRpraAw==
X-CSE-MsgGUID: 7JJYIwm8STGZSrp3DaNFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="268331176"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:06:27 -0700
Date: Mon, 17 Aug 2026 16:06:24 +0800
From: kernel test rebot <yi1.lai@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, netdev@vger.kernel.org,
	ltp@lists.linux.it, yi1.lai@intel.com
Subject: Re: [linux-next:master] [tun/tap & vhost] d00c7369ef:
 ltp.ioctl03.fail
Message-ID: <aoLBAPxcXXG+i90Q@ly-workstation>
References: <202608170325.fbd7c808-lkp@intel.com>
 <bf700b2d-4593-41ee-bac2-6438b65e3720@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf700b2d-4593-41ee-bac2-6438b65e3720@tu-dortmund.de>

On Mon, Aug 17, 2026 at 09:39:26AM +0200, Simon Schippers wrote:
> On 8/17/26 03:34, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "ltp.ioctl03.fail" on:
> > 
> > commit: d00c7369ef24ac8e0383de0fd8ef3384de20bcfa ("tun/tap & vhost-net: stop tail-drop when IFF_BACKPRESSURE is set") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master 4477a78374a57c3809b172ad30cceabda48c47c6]
> > ────────────────────────
> >       TEST SUMMARY
> > ────────────────────────
> > Suite:   syscalls-03
> > Runtime: 3m 4s
> > Runs:    186
> > 
> > Results:
> >     Passed:   2174
> >     Failed:   1
> >     Broken:   0
> >     Skipped:  222
> >     Warnings: 0
> > 
> >  [1;31mFailures: [0m
> >     • ioctl03
> 
> The same harmless report as before:
> 
> ioctl03.c does not know about IFF_BACKPRESSURE which is introduced here,
> consequently it fails.
> See [1] where it compares TUN features with known_flags.
> 
> Thanks.

Thanks for the response. I just noticed that it's reported before. Sorry
for the duplication.

> 
> [1] Link: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl03.c#L82
> 
