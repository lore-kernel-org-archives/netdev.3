Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8B4A384C
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344197; cv=none; b=GpXJm2Q5Oc1YRNP4dvwucJT/pEDxHO7W8g/HYVYgGMsv2GZTvRxGJxvuC+vpTr0v9quPa3beCxesm5t7jzlhvLIr2RfOLTlcmJY0rZxNd6nMAm2QptmbwJA3F3axFTJZin8gqb12oHxSL8ARrv5RdsawXg3UhCxdCBtMFXYRsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344197; c=relaxed/simple;
	bh=2CSpOUqAoMn3Wk6Dbx8Vli/X8sKhgmiCfHbDFyFz8ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfHF97SRzqTOU3LlDNoSjQDwYG29vwkIwv43TPgaFhdZINzCwe2mRJl7PmHa0zoqtuMuh8bNY5dTc/O7UxcSVKYv4HpICvgiLd6t7T7vq3aOii4Ol3fnDIrR+QvqizbG22Li1AzWz/P+fdQGNkGLHJWuQPKwLqr7y2TUR3usA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om/bzKyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om/bzKyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5071F000FF;
	Fri, 25 Sep 2026 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344195;
	bh=VKB1SF636qHPQGXN9YgDIt9KwEP6VjZlvmkHYt5E6u0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=om/bzKyvOeRhcGA0/RbMDS6CBe2UGKfZlzn0S6MQm3W8KgFgvqjxZrE3HoiVXDzLc
	 ZTjAJFQTsUCBbQCJz2ZW5ACg9fw1niSGVZvbQBSwzpOH6XfifDogm6gMKkK2vS9ksI
	 kttEqm+1Pdl3aiQfSw32066Uy8Q1wiMjzGtP0RnoXXZEqa+cBiNR+PKBHD0qF5ISLC
	 zqXceMqhX9WO0cmuzOHwX+7PZnsO6uX9mP6O+s6UgBbnrNfZCGWCjAwNNo04tX+86m
	 8WDWwGAM1wPIbuT3PaoFt2IrZnhRNJw9nUCbYiv99ajnpHOAoIOvKRDmIbBnL4eI+F
	 /2t7RBidrMybw==
Message-ID: <347e8fd4-ec24-4d45-a53e-88c933de10ad@kernel.org>
Date: Fri, 25 Sep 2026 15:49:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 2/2] selftests/net: add SO_RESERVE_MEM test
To: netdev-bot+sashiko@kernel.org, edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 weiwan@google.com, horms@kernel.org, caixinchen1@huawei.com,
 netdev@vger.kernel.org, edumazet@kernel.org
References: <20260924123602.1979090-3-edumazet@google.com>
 <179034054266.2160803.16187930067723490774@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179034054266.2160803.16187930067723490774@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

Thank you for the new test.

On 25/09/2026 14:49, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.

(...)
>> +static void check_non_tcp_rejected(struct __test_metadata *_metadata,
>> +				   int domain, int type, int protocol,
>> +				   int val)
>> +{
>> +	int fd = socket(domain, type, protocol);
>> +
>> +	if (fd < 0) {
>> +		EXPECT_TRUE(errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT);
>> +		return;
>> +	}
> 
> [Severity: Medium]
> Should ENOPROTOOPT be accepted here as well?
> 
> MPTCP can be built in but disabled with net.mptcp.enabled=0. In that case
> socket creation fails here:
> 
> net/mptcp/protocol.c:mptcp_init_sock() {
> 	...
> 	if (!mptcp_is_enabled(net))
> 		return -ENOPROTOOPT;
> 	...
> }
> 
> inet_create() passes that error back to userspace. As a result,
> socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP) in non_tcp_rejected fails with
> ENOPROTOOPT, and the EXPECT_TRUE fails the test.
> 
> The test doesn't unshare the network namespace, so it sees the host's
> sysctl. Any other environment-specific socket() errno also becomes an
> EXPECT failure rather than a skip.
Typically, we try to run the tests in a dedicated netns to avoid such
issues. (We also force net.mptcp.enabled=1 because it is still disabled
on RHEL, which is really a shame... but I don't think we really need to
support that here in the selftests.)

At the end, I don't think we need to care about all possible cases, but
using a netns is probably a good idea, at least not to "poison" other
tests. (If that's easy to put in place.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

