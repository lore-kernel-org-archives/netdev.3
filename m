Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED71292B44
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259941; cv=none; b=XRHR5ot6oZabJ4VpzifYW16LGLDWVW/Fw7VRVHbqYHMpXXRBaot+krb9M9gvSLcvwZ036I7TjDawi5kDNuh+3PYRmdQtl5XNW7Ow9GevlJZzW70IxrrrOKUlTZzVbSPc7rup5LNIc3Wdwwa7BQed38vqujzecm56j7eXjIZGTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259941; c=relaxed/simple;
	bh=xBksNd+11EkDc/wBpvcDrPzbR2fvjDgIQxoGo/vEOcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZsuMMgbwUoHRpOB90aZFybfq4nOPbNzkbqrZgP6ATVZbwewo8jyOleg7MaF2CRQp34nFgfc/+n2J7hXzggznxzAnqx0wE6EcXmdrhh6HYTGxlps5XqxyFdd0Z5QGJNKsX6XL5K7SZ8fXf172KXts5lWy2ambReO5+YZ4eyGnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHByAGmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHByAGmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07065C4CEF7;
	Thu,  5 Feb 2026 02:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770259941;
	bh=xBksNd+11EkDc/wBpvcDrPzbR2fvjDgIQxoGo/vEOcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AHByAGmOGAZAdY8HkcbSp6BTNey9nZiAhPqYIK24UAaajk+nhhk8ycp5qJu54oPhl
	 EtJ2b5fK0yVmaT2lHk+hFMe+S35bVjdqEUlPjrgEzXY5hk0eO/6eASVEHW2vKmUaq5
	 9XUL+ge6BZXTSoCCAqJfN2jROecqf+j/Fqw2y2UtvbCRQSsxLBV3ZqplmZC0JtLDgJ
	 ct6EOUi5LdNJAM610AKhjUX4DKvuo5xChfSxENadW2S1fspGHPqfDtSjf0wxc3MV9S
	 r3HUvf0nb0ZyAe1JET1z8okmahw46RjbKpxvdzS6ESYnHcrErucOWR10a6il5qKabB
	 SZc3YdVqF9c+g==
Date: Wed, 4 Feb 2026 18:52:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v6 4/4] selftests: tls: add two-node hardware offload
 test
Message-ID: <20260204185220.0ef1aed9@kernel.org>
In-Reply-To: <20260203184835.3619101-5-rjethwani@purestorage.com>
References: <20260203184835.3619101-1-rjethwani@purestorage.com>
	<20260203184835.3619101-5-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Feb 2026 11:48:35 -0700 Rishikesh Jethwani wrote:
> Add tls_hw_offload, a test program for validating TLS hardware offload
> functionality across two physical nodes. Unlike existing selftests that
> use loopback or veth pairs, this test requires separate server and
> client machines to trigger actual NIC hardware offload.
> 
> Features:
>   - Server/client mode for two-node testing
>   - TLS 1.2 and TLS 1.3 support
>   - AES-GCM-128 and AES-GCM-256 cipher selection
>   - TLS 1.3 KeyUpdate (rekey) testing with configurable count
>   - Verification of /proc/net/tls_stat counters
>   - Echo protocol with data integrity verification
>   - Configurable buffer sizes (fixed or random)
> 
> The test validates that TLS connections use hardware offload by checking
> TlsTxDevice/TlsRxDevice counters, and verifies rekey operations through
> TlsTxRekeyOk/TlsRxRekeyOk counters. It accepts both hardware and software
> TLS paths, reporting which was used.

I appreciate the LLM tokens spent on this. Please get this rewritten 
to use our existing driver test setup instead of creating your own.
See tools/testing/selftests/drivers/net/README.rst and the existing
tests under tools/testing/selftests/drivers/net/hw/

Please switch to posting as RFC until we get a review from Sabrina,
the merge window is soon, anyways..
