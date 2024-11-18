Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A21863F;
	Mon, 18 Nov 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943016; cv=none; b=ShD0DFr2LPgWCbdwDjrJD+L9tMrCH91z8DCeKV8OIksTjcQV2FeG6N4Peh073mjxvgPeQ+APMQD3BUTQiMxUqZYoM8KqO3sySoHBhDmJKXmzSpvRdQRlJCGMhLlbjEZbNYzOdhwTK2adCGceplGOfGkLU07pYmo616bojIRLzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943016; c=relaxed/simple;
	bh=m5roiYQkgEHBTQ/bOsE7f0iUIvENw+Ej0rV5UEh3z7s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=NR8Fw4Kve05zwk4HIByhon/N9Lj6GcJngOjxjCfX0k/qLoiE6fl9z3x3ddLvJvaMsemeXTKU8EIlDg0utIWyrxJri04vIAMRjLUxnK9DDOiG3WoAqSVvrynKR64oRVBqGO2b24hJ4m8SHKDbCuEWY0h3Z6w151gafEirJnpDG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOxwU8aL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOxwU8aL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F72CC4CECF;
	Mon, 18 Nov 2024 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731943016;
	bh=m5roiYQkgEHBTQ/bOsE7f0iUIvENw+Ej0rV5UEh3z7s=;
	h=Date:From:To:Subject:From;
	b=IOxwU8aLrpszzuceAwrX9TQoKFOUoKxrQYSxW5Sa8Ol2DGkzjT043RS4P2buG2dUD
	 8X7qIv8JLNYYO07IL5mDnyMJ4rnNMFJdlmzGy6j5lzyYilYYj11+2nT7jV0fEsN07t
	 tmciaF++3EJ7sXb3PnJDeztGNVm2bOdKNNvuKshQWIOzmeRwMsaO7tSeV1/3nYsZVx
	 QE1ZlF6HEd54pzA6aOaKQGohsHrb6ZFEFzLCOENKoS2uHFDalESF+YUaEStgn5Damo
	 K2NxFhm5pSLf+Iu0lN0+XgWCDjl/XAt+dRZKas7gkIRwdSBncd8AkzuZHHdvDxQaKO
	 G4/L2AHbgdzOQ==
Date: Mon, 18 Nov 2024 07:16:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20241118071654.695bb1a2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged v6.12 and as usual net-next will be closed for new
submissions for the duration of the merge window, until v6.13-rc1 
is tagged (on Dec 2nd).

We will still look thru patches already in patchwork.
