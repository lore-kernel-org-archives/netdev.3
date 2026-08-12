Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD3376BC6
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566950; cv=none; b=ftzr2+8o5O+fFsEAO1yJqEK8AqDXco0ieIySCqxiTwWMGBvfcos7GBD8Bf2mNzl4/poc3pE7VxhDh0hPUrxRQ3PttV0PAugwMFpaLJ15YteOZwvJ6Oj/u4CcOPBpzQdizI6+9JxYEeM0l/xUNLsfnVe1LY7NxBJWpGReD7LjxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566950; c=relaxed/simple;
	bh=7wrNKiguH9KPsfjgR2KfWpTmphocP1mOYMJY3WtuWe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqCkXaA705g+K5xJtzUbu3L9dglXWfoLWd2sYO2Wjtm2BU2Xwr9eUVCQ0T4UFxWS5grFQL3RV0gP5ztZuARVrrOM7zRMVR7+ms9+NGwUzWrCdejbv51uBDnggCfBuNrBM+Kymt4mg4lVYjZSZ1zk9zRdiWuS1VbhTbvNqsZKwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XZUExnFu; arc=none smtp.client-ip=91.218.175.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZUExnFu"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7wrNKiguH9KPsfjgR2KfWpTmphocP1mOYMJY3WtuWe4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786566946; v=1; x=1787171746;
 b=XZUExnFuq7qJ2J/0o50O7ozeLCy8dnp4tVu4EOIGa2/lFtj0GoAqTy0Y+5BI31cRKX7zsE+4
 PSa3x0hh56nf1mfaPBuXE4RYI+6/cQySkfJm9UVXT+cN2CGzj0M+kcZsviaV/+RMZssor54s1Yu
 Eatfb6QfiBbH3qU8F9S0l5lQ=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.45] (109.76.184.122)
	by smtp.migadu.com with ESMTPS id 96f1cfbc45ca19cc;
	Wed, 12 Aug 2026 20:35:46 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <b6563314-125e-4fa6-bc1b-cdd90187ccb6@linux.dev>
Date: Wed, 12 Aug 2026 21:35:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 1/3] ptp_mock: Expose ptp_clock_info to
 external drivers
To: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org
Cc: kuba@kernel.org, richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, horms@kernel.org
References: <20260812183708.312412-1-maciek@machnikowski.net>
 <20260812183708.312412-2-maciek@machnikowski.net>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260812183708.312412-2-maciek@machnikowski.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.2026 19:37, Maciek Machnikowski wrote:
> Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
> Convert spinlocks to SLIS to allow gettime to be called from the netdevsim.
> This is a prerequisite for implementing ptp support on netdevsim.
> 
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
