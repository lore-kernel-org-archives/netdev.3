Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC233AF666;
	Mon,  7 Sep 2026 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800883; cv=none; b=SHxuC0eSIYQyqu/095wtEjAMU3LV/jBSo0OUANjulHeVbjBm88X60yicciXigjiirEzP8+ToEKvNojwU5jzb7oQX820YleJE9V8ijBR7Vx4DcqpV/k/h61Pfkzah4FIFSohXlDbKXjQMoiXferfrRCG1cPsmJPV0/MDVoUCQVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800883; c=relaxed/simple;
	bh=oFMzoHc6wsn0F9CSxGcMSq2JdF3BliB7CLDIKejfMBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giiLjSXgKbLcRn928v6MRMqYqsf4j+YCnuZYRjF3VgZMQH3bXig3c0NS9kp/1DWnSwrk3rRSwmUAqBC7jyS0WHnEKLazJvAQBMlGRhptdYnTMqAPetn3s6CNTEM8h57cOwXPGzIF0BJ8sUP0sMstlEzL6eEgaBfvyOTS7uCWfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WTzWqTdy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WTzWqTdy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tUA4k8R2t1QpHAGgeyT0ZKIm7T5VVZVvcJldkkde15c=; b=WTzWqTdywnsEwqjXCxEQTDsw2S
	S0GF02yWDOz/17M8o03Ohp0ZWpez/vaC4WRDHIdPsxPCPdCQt9y9sgjFNgtTaPektuda40Bf5/FfF
	6sdeMfTnS2nI6S1Nxp9uVKKD1PZgbhUkOKYqN3glIn/acrrSjFRXe8982InOs9xpKId6JlAOt7Sfs
	dpzwPxjregJkSAwu5TP3UbfgCzvkL/rBvbv7NSS13WwGu8L0PSGw+Y9qkLc2dA0vfKcN0GU0ryFSj
	pkAKlDUUxC+Z5nV5MoCF6w3E4iUf32YHRZOyWT0VEhvjaQdZjfuVCMt5hL7B7O3dL3sYmuh/+MX6k
	mj/33REA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3cp0-00000007RIP-364Z;
	Mon, 07 Sep 2026 17:07:54 +0000
Message-ID: <c2f439ac-ca0e-4532-b649-c32c4e474436@infradead.org>
Date: Mon, 7 Sep 2026 10:07:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation/networking: fix repeated words in
 comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260907064528.6602-1-hemanth.selam@gmail.com>
 <20260907064528.6602-3-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907064528.6602-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/6/26 11:45 PM, Hemanth Selam wrote:
> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
>  Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> index 53d9d5829d69..e01f0adda3f6 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
> @@ -692,7 +692,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
>  16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
>  number of queues for all tcs is 64 or number of cores, whichever is lower.)
>  
> -hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
> +hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
>  offload mode in mqprio that makes full use of the mqprio options, the
>  TCs, the queue configurations, and the QoS parameters.
>  
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
> index eb926c3bd4cd..5840569917f5 100644
> --- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
> +++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
> @@ -171,7 +171,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
>  16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
>  number of queues for all tcs is 64 or number of cores, whichever is lower.)
>  
> -hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
> +hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
>  offload mode in mqprio that makes full use of the mqprio options, the
>  TCs, the queue configurations, and the QoS parameters.
>  

-- 
~Randy
