Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72BF507;
	Sun, 13 Sep 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789310801; cv=none; b=R2S2GaTbo9DhVlmIAGRhRyXXwWhk/1NrYp2Ouxc+xAnrpCzNOUsW/w7vSDs6tv+Scvh8AVxHJhR8lL04dl7iJQv6vntxuX4PRuC3jxGYK6Nn1ou8i6+siM8SZ7zk4CVgALl+9mFRVpYoLW2r1eM3qc7a3kadz/hX55+PJEoJFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789310801; c=relaxed/simple;
	bh=JggYbqlXbzrHtfkl5iLip74CdwdQKR4dgDsOB7wSDpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPQrwlZyAyNyTgZpJayVy1Sz1ev4cIBpWsVQu7hcwdJufq11xjHtXD0STw6CQ3ZsNsa4Qsyci7S0rh4EiBLaT+d6RFKl6jczJPmXCX3uZ/NAky73r8YGg/zMueIlbYnxmKXrC73wzpSMhBo+rQM4K59NpGoRmDHj4qC/xhOKcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fykgIAum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fykgIAum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2286A1F000FF;
	Sun, 13 Sep 2026 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789310800;
	bh=9KoFmEkZD8/d2j0++0UYIJMQf79SW1ZZ6EwnJAhoeRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fykgIAumkYjFiCZ8pSnfPaUv/c85QpvA3XrXhlYHd4E5sntgeGn5gekmzEkw7MXHi
	 RGmeS7+Rzm7sFOc8Xy0Z0xMtoo3gGCPQj4TIjlm+Db3rpE9q6jUxSP++imdOA/pVOw
	 nHY8EClY4002r8GTDicHvaOCTMTacu5yn7b/xhbAQaudei4ch6QcJf+eX5NCdqjWXA
	 BY3ybDFrJG6WYO1elc5j1YNdsggJH/WLEGQHNF8Zy6G/MOKJIUPNhQv6I1G2J9NRrK
	 VfaHKBU8/1d54PNsSNMbjdU9nJztId/Yj2NTi6IKX5/m1yGmyycPD+Od3YniJOEGmw
	 fmVM7uIVFdvtA==
Date: Sun, 13 Sep 2026 15:46:35 +0100
From: Simon Horman <horms@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net/qla3xxx: Use managed PCI device enablement
Message-ID: <20260913144635.GK48209@horms.kernel.org>
References: <20260911033219.34566-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911033219.34566-1-mhun512@gmail.com>

On Thu, Sep 10, 2026 at 11:32:19PM -0400, Myeonghun Pak wrote:
> ql3xxx_probe() enables the PCI device and balances that reference on
> probe failure. However, ql3xxx_remove() releases the mappings and PCI
> regions without disabling the device, leaving the enable reference
> held after unbind.
> 
> Use pcim_enable_device() so the PCI device is disabled automatically on
> probe failure and driver detach. Remove the explicit disable from the
> probe error path to avoid disabling the managed device twice.
> 
> Keep the existing manual cleanup of register mappings, PCI regions and
> the netdev. These resources are released before the managed PCI disable
> action runs.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 5a4faa873782 ("[PATCH] qla3xxx NIC driver")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

I think that rather than introducing the use of managed resource APIs
to this driver, which is not encouraged in Networking code [1],
the preferred approach would be to add a pci_disable_device() call
to ql3xxx_remove().

[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

   "Using device-managed and cleanup.h constructs

   "Netdev remains skeptical about promises of all “auto-cleanup” APIs,
    including even devm_ helpers, historically. They are not the preferred
    style of implementation, merely an acceptable one.

-- 
pw-bot: changes-requested
