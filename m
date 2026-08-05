Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54D3D9558
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917917; cv=none; b=exRnsbondSh6+D2fORW+6nCtdDlp0ewcrToAAhd4Sg7CKnGVS3PIEC+eXQ+yaEYsX7LeI2qBWdW7y+Jq7qp5/wgITNge1mHxQLi5TlyeNlYv+cOccUrMyXQhirRibjuYsYzl0PpSrHHyrge/sa9TnE4F+E1zbG94yE3q3OJGXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917917; c=relaxed/simple;
	bh=KOqqkjdORI5E/eYKRP05UWLJT+Qt1zcCdKLl3vpv1mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNcRY+uQ8cO6Nuu5lWsTN4FAzNULJKZhLDMs2BdHEnMRpfO5BeIyf+naBKN5TYlYuq5EojAYIMceUKn8YsRi2nSJPiRCxqfDfCXgktcyQL3sNw2DgLtsC50Hv5S+aUmv69skTS1A5L9K3jtyADafAVdSrlfhc+0q/36n/0aW6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=anHmDcmS; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="anHmDcmS"
Message-ID: <6a49e5fb-9130-4b73-b67e-104130f19b57@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785917913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOqqkjdORI5E/eYKRP05UWLJT+Qt1zcCdKLl3vpv1mc=;
	b=anHmDcmS72UccH+xTtfm6z/QpypdbuEBEVR0NsLqEDHaYzFthvOWXUtW/pfDAmLdKE5pyp
	+0O/qlWLp6SpXRUqTnroNys5/cUdwcxzcjQhNZ4+Tnj1ODOTs7NRQ6XyyyxYnJmtP4muy5
	UKkqukbOLjLUkz04+gIiXSbEtf9A0Mw=
Date: Wed, 5 Aug 2026 16:18:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Track test_xdp_features DUT
 processes
To: bochaolucky@gmail.com, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260805-xdp-dut-process-lifecycle-gmail-v1-1-45984df8d295@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260805-xdp-dut-process-lifecycle-gmail-v1-1-45984df8d295@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/5/26 3:29 PM, Bochao Cao via B4 Relay wrote:
> From: Bochao Cao <bochaolucky@gmail.com>
>
> test_xdp_features.sh waits for any xdp_features listener to appear and
> uses pidof during cleanup. A concurrent test can therefore make another
> test proceed before its own DUT is ready, and cleanup kills every
> xdp_features process on the host. The readiness loop also has no timeout,
> so a DUT that exits before listening leaves the test hung indefinitely.
>
> Record each DUT PID when it is spawned, wait for ss to report that exact
> PID with a bounded retry loop, and only terminate and reap recorded
> children. Install an EXIT trap and signal handlers so failure paths also
> remove child processes and network setup.
>
> This also removes the runtime dependency on pidof.
>
> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test tool")
> Closes: https://bugs.debian.org/1136522


It looks like part of the motivation here is dropping the pidof dependency?
I don't think that's worth optimizing. Selftests already require a bunch of
tools from non-essential packages (ip, ss and ethtool in this very script)

