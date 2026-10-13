Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323033C3C16;
	Tue, 13 Oct 2026 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870676; cv=none; b=cIbELy2Hw+8SsB59CUZmHkjvT3GNJp4fgbqynS4isRzsPFjtpNsc0GsZOWk2zcuVcpRMnU2O8Ikzz7KSmhdr+RsQh8ngOzIcE4A1uWEjaXJR+TF9ixljn1Ms8c7Lyp2aTw/EJ4lCgcIm7zYZyeH19SczDJNEEm31fUHf0SSyRxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870676; c=relaxed/simple;
	bh=i9+fooia2DgtkTvjSDp+TBeVNrA12jcPkhDHO1/xAQ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4JsLjzm/QZutMOSqJQYpfkz5385OPg/XirgzVfRD6HaYyrubq2Xb5OaUrUjagZRUrT2B3mUnWNUaCHogUkO8HNxQHSWIeRzuIE8FG71dxjTDm34Zkfhi3y56p6+5PT9RbMAtfdjvkvjBn8fbkLPGOCxEdl//OBeRAbgxj1s9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNpqUk+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNpqUk+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D146E1F00893;
	Tue, 13 Oct 2026 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870675;
	bh=5lKjYh2cMM6S8ZPayvGpCsHYlLA6nMPRcFjg2e/vTg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNpqUk+A8uKZTP5ZUErbEiq+mylHoRY/nBJDhapTuKgk2jElls9J6OJlzZtDouIZI
	 Ho7brP33IIe3e/qyx4JCIVlYmltCMcedx7SObsl7EFcr2657df9zbIq2wQMXNZ1Uao
	 T2oFYuVro8hUFpcwaIuZxDtz3weZDTxpie41yDYvbpOOlSzzBJgKI8MqGgrqiBasOR
	 bXZ9dOERRPAj0fUWJGCsl4zEuxByE708CRSTVZcLdKEmN3OK9XtwLHkFk5w6oiBV7r
	 zymqFAWZq/3rtlINP732MLu/mZhbSYeot63k8jb3BvVhGSv9eloO1VJo04TqIrN8O/
	 zbchBwj/GwJpg==
Subject: Re: [PATCH net-next v4 6/9] ibmveth: return the error when
 set_channels cannot add TX queues
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, brking@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, jmaxwell37@gmail.com, zdai@us.ibm.com,
 marcelo.leitner@gmail.com, ksiva@linux.vnet.ibm.com
Date: Tue, 13 Oct 2026 05:51:13 +0000
Message-ID: <179187067343.434549.13620281833326474487@kernel.org>
In-Reply-To: <20261012050518.88858-7-mmc@linux.ibm.com>
References: <20261012050518.88858-7-mmc@linux.ibm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "ibmveth: return the error when
  set_channels cannot add TX queues" says the bug was "Found by AI-…

--

ibmveth: return the error when set_channels cannot add TX queues

If ibmveth_set_channels() fails to allocate a TX long term buffer for a
new queue, it falls back to the old queue count. The successful
netif_set_real_num_tx_queues() call then overwrote rc, so ethtool -L
reported success. This patch saves the allocation error in alloc_rc and
returns it when the fallback succeeds.

> Found by AI-assisted review of the ibmveth multi-queue RX series and
> confirmed by code inspection. Tested on a POWER10 LPAR with the TX
> buffer allocation forced to fail by a test-only module parameter (not
> part of this patch): ethtool -L tx 8 now fails with -ENOMEM and the
> device keeps its four queues and passes traffic. No kernel selftests
> cover ibmveth.
>
> Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>

[Severity: Low]
This isn't a bug, but should the trailer block carry an Assisted-by tag?

The message body says the bug was found by AI-assisted review. The
trailers only have Fixes: and Signed-off-by:.

Documentation/process/submitting-patches.rst, in "Using Assisted-by:",
says:

  If you used any sort of advanced coding tool in the creation of your
  patch, you need to acknowledge that use by adding an Assisted-by tag.
  Failure to do so may impede the acceptance of your work.

Documentation/process/coding-assistants.rst gives the format:

  Assisted-by: LLM [TOOL1] [TOOL2]

Step 6 of its "Procedure for finding and fixing bugs" section also says
a fix for an AI-found bug should add an Assisted-by tag.

Could an Assisted-by: trailer be added to this commit?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012050518.88858-1-mmc%40linux.ibm.com
