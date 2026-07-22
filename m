Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B700415F32
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749432; cv=none; b=H6s0nh7DoMfTGXE3I2nI4RxrGaIUNCemBt88QbQDXgyAMQB8aL6G3NFlwuG2OE5FVkg37Y8Me5w0v1wSmSd6BZQen34OoOKn+zfLt6j4uB43l+IrsrYXN6nyd8N+ceZdURaTr1GKd/LdbB2RbPIq0cmUg366qGDtN58Y9c9v9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749432; c=relaxed/simple;
	bh=nL2LqjPyCZ6DR6aRJ3MJaq6iVPZ4jmmWNH0hBTxpcYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiUDFXFO+Y5Wo/HDIXzFgqa6NbAg6J3kCefS+HOg8Mz5VrTtP+qoeE/G7WHMzfYSPzvsTBezbF6vxIeDLw1PmRPY1GRzVFKj/HLQgfqSXe7boySYrNOA+aZnaIk25Adgr4SBplthiy/QhNMF+Lqwn5yLqPsbdYTKSqD1FzZdOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPdNbnqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPdNbnqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F2B1F00A3A;
	Wed, 22 Jul 2026 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784749431;
	bh=/qGx21HpgEeq8nsU5nYgZs8GN5XOYH9oiYRmM/+Pwkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lPdNbnqc1c76AO881jAGg6mHDOYA158BM42PzLfFySQaauG8DyXvzmbDZOvZ5WaVu
	 e6cSP4iLcWRF1tv0kmEAeH8SSG4pPDwzdeudo5t5Ov4mZhoryAbvNaCha3LAZDngoA
	 4fGPi6/q/HOzG7084qwcdWk0sN4ZX7Se72y8z4Ow7EqGSRMaWWKXNJzJfBWxBmEyPc
	 umPfpvOIvMuELN/CdVMW6szYij7tSQuvDdUkHY3sWWIVl/zNB+a8S7+BLCgIIrrcUR
	 ZduCuH2BZKq5/B8AB9MDkQB+YjvuXYT/21kiZJ2NBNVECqUNUB/rrTr+USMMSNE8FH
	 76eZI+Mh5N6rA==
Date: Wed, 22 Jul 2026 12:43:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: luyun <luyun_611@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 01/13] 8139cp: fix DMA mapping unwind on TX frag map
 failure
Message-ID: <20260722124349.0bad10cd@kernel.org>
In-Reply-To: <43379065-5916-42a7-8ecc-4b875ea53d22@163.com>
References: <20260717103724.13971-1-luyun_611@163.com>
	<20260717103724.13971-2-luyun_611@163.com>
	<43379065-5916-42a7-8ecc-4b875ea53d22@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 15:37:02 +0800 luyun wrote:
> A gentle ping for this series, the number of patches is 2, not 13. I made a mistake
> when generating the patches. Please ignore it.
> 
> Any comments or reviews would be greatly appreciated.

You must describe how your discovered the issue and what HW you have
tested it on. We don't take LLM fixes to Orphaned drivers.
