Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BB2E0938
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105247; cv=none; b=On7OMtPv/eRK0GuvDdiqywOYoBMn1H7uTCRzBChJL9bOUdcJyNkA7V39L0+91rwn0QRogHJHCB/YMybJEyAtK36kQIe8pFO1mQSmY3nNI/xFlJOMrkKcTgN2IGJ8L4yT6yFU07B9R++SAX26gdI04lr/LptkQryhamT8baFEFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105247; c=relaxed/simple;
	bh=C/ayCCznEXYLF4PVWAUxQtgAMDfoqmcwfHaUmsYKDCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCQ06+zBnJPi+GD3bA+xCyMddEj1eC+TIbS+o97T2Uk2jxIj/Q4VwmAnrF77g+/0xIMzHIyrwxufCfkdGeS/IMPt4mcfuZk8Ws3jRteY/ehyIJIvU2iFbRKTS7OnpqLRXehyJQvmq3tMdn78hE/Yu/oR1z3TySUXgMjXgI7n9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi4DG7WF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi4DG7WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C29DC2BCB0;
	Wed,  6 May 2026 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778105246;
	bh=C/ayCCznEXYLF4PVWAUxQtgAMDfoqmcwfHaUmsYKDCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vi4DG7WFKhJun/BHbY+BemXXfyIsoZDYGPSOdPMhFWrhrNduPMk4X17yA+hbA+1Qc
	 QZTQVvxBM/GLwx4VcS7oqF7XCKuuvrIqdrPzS9689UzzZNs+q1/VY74DUbk+VDhOh4
	 pKCQ1rUnVnh4PJkC4lejiSTrPlFg0Xm5NfcRRqoIkXugcNFN8b1X49Yq1T5DLcVyBQ
	 ppkM0ANgCa5umSeRWeGzOOHGXVY2lvgNhGaGk+W9WGBlvT479tt7DuW8WykqgQXVmF
	 jVlwofRHlG+9XDPta4sximTuWIHQ0Ugp9d6YT2toI/qk97OPPsLWBFjaOEKxo0cRRc
	 jOpVvzveCnh2g==
Date: Wed, 6 May 2026 15:07:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260506150725.14c82e23@kernel.org>
In-Reply-To: <7fc0a457-7153-4b22-b3c9-2c6298b75d73@machnikowski.net>
References: <20260503074747.1321-1-maciek@machnikowski.net>
	<20260503074747.1321-4-maciek@machnikowski.net>
	<20260504100753.7cc193cc@kernel.org>
	<b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
	<20260505172234.3348a81b@kernel.org>
	<20260505172317.089fb380@kernel.org>
	<7fc0a457-7153-4b22-b3c9-2c6298b75d73@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 13:18:01 +0200 Maciek Machnikowski wrote:
> On 06/05/2026 02:23, Jakub Kicinski wrote:
> > On Tue, 5 May 2026 17:22:34 -0700 Jakub Kicinski wrote:  
> >> You have to add it to the relevant config.
> >>
> >> Please read: github.com/linux-netdev/nipa/wiki/Netdev-CI-system  
> > 
> > Sorry, wrong link, this:
> > 
> > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style  
> I did follow the guid, ran the test on the vng environment and it still
> passed the test. Is there more debuggability on the CI system? Can you
> share the .config file it generated while running the test? Or the
> commands it tries to run so I can verify them locally?
> 
> 
> The commands I ran were:
> 
> make mrproper
> vng --build  --config tools/testing/selftests/drivers/net/netdevsim/config
> vng -v --run . --user root --cpus 4 -- tools/testing/selftests/net/ptp.py
> 
> The tests were done on the ARM64 Fedora 44 with the default kernel
> 6.19.14-300.fc44.aarch64 running inside the Parallels Desktop VM.

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/631241/config
