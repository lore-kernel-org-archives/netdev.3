Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F463B05A4;
	Mon, 17 Aug 2026 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952395; cv=none; b=HLnbX7gdDN3C35qHWE+vIGv4I+lCf3eig2Pa/53NUQJeK5TX8NNveUdrS29eFCM/+IeIab3XLA3nW2XaIMeAI2euSh15DUxzjfRq/iL9bxN8silTSQ4KSKujNnLgTmQFJSN3fyrTdZByt1nqGHtT2jb/MYY84KI89xs1nwh4Aqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952395; c=relaxed/simple;
	bh=yRVZYM07SpU6drH14+FKixPVsfCTG+92VC2VXOXrMLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkyIDGozGUvJKr1KOYXPeqgM+dj5QUZIWuCYcb9bEzh8pE8XLaSN/d6hbEQFSvbYe5/xp1jmiGvnGGmbpe8+/qxomjuNQyfDp6S3byTNg7hWUsvNe3k0hzhwp34yNHCrZBzOTqryChFMcnKx8xs5tpETN9gtMQqe0ODMzNoSn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=JgLUlk6M; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="JgLUlk6M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1786952369;
	bh=ROzgelHjCksFRXJDoTZHiYQsqtaaq51sCU/RNJh7IHs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JgLUlk6Mgi5YGbiqn8SE3p1CNXspBPxjXoIHGQyUEN+a7lI3NXvx4SH+WuEqmaflc
	 KTH5JTY9IeLOI2+iIo+TYe9vixkBcLF4fIRFBz2AqOgyfFPdwqOFUIpUKLGwuV4Iz/
	 oQXe571laVEojptT8QqQkbcDC7CC/xzcxKO2JXmI=
Received: from [IPV6:2a01:599:a01:b5ff:b10b:46c3:3de0:9273] (tmo-068-246.customers.d1-online.com [80.187.68.246])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 67H7dRah002056
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:39:28 +0200 (CEST)
Message-ID: <bf700b2d-4593-41ee-bac2-6438b65e3720@tu-dortmund.de>
Date: Mon, 17 Aug 2026 09:39:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [tun/tap & vhost] d00c7369ef:
 ltp.ioctl03.fail
To: kernel test robot <yi1.lai@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Jakub Kicinski <kuba@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>, netdev@vger.kernel.org,
        ltp@lists.linux.it
References: <202608170325.fbd7c808-lkp@intel.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <202608170325.fbd7c808-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/17/26 03:34, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.ioctl03.fail" on:
> 
> commit: d00c7369ef24ac8e0383de0fd8ef3384de20bcfa ("tun/tap & vhost-net: stop tail-drop when IFF_BACKPRESSURE is set") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 4477a78374a57c3809b172ad30cceabda48c47c6]
> ────────────────────────
>       TEST SUMMARY
> ────────────────────────
> Suite:   syscalls-03
> Runtime: 3m 4s
> Runs:    186
> 
> Results:
>     Passed:   2174
>     Failed:   1
>     Broken:   0
>     Skipped:  222
>     Warnings: 0
> 
>  [1;31mFailures: [0m
>     • ioctl03

The same harmless report as before:

ioctl03.c does not know about IFF_BACKPRESSURE which is introduced here,
consequently it fails.
See [1] where it compares TUN features with known_flags.

Thanks.

[1] Link: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl03.c#L82

