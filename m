Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3233DC4C9;
	Fri, 11 Sep 2026 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093607; cv=none; b=QkoRmxD2I6Gyk6zesAlu8vJMyDqqltEuvj8f6OYfjWH/kaACeZjPkUVAJqQaGHr7P+Qh0eDnSPTnxnQRGyjtNwaxU2RwDGzV4/826N+Bi3hNKJlcrzvd1T99m3U1te/cL95WfTic92HQ0gwoOHQqUX9xLSFNctADzCVEYWa2FUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093607; c=relaxed/simple;
	bh=5aaqp5fVuY6dIuUBWGfBPc6TjbN25Gy4VugA9H9uegs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8pT9ASxrGL/8sYQDzqNRHMUXQHkVZy3Cnigu4PWD7rJNBx5+u26y6BziqGYVbUWqB15UEczwf8hw68RASf8BS8v6Iq1JRSv350qkftpdH6ECdnOhnPq2OxyP8dQnqLyZcDVJTDRgAqs5wh6o7qFIiLU/6Ty8nP0XCEuWucvTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzMnGUbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzMnGUbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC4F1F000FF;
	Fri, 11 Sep 2026 02:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093606;
	bh=5aaqp5fVuY6dIuUBWGfBPc6TjbN25Gy4VugA9H9uegs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BzMnGUbi8Hc37Rf0vE1XR/kYT/ySUlXsc3sl8UGKblNqZa2RgkFxkYgfn1SiiouCF
	 0Yw5YjPBkMTLUoRbGDLcP5meLECSQBUVE+QvkHQjXHBEI6wbPiecUc4kbwf/SimTut
	 sv6pd9Vb+ZjSko6NhM9hIvikYjkjF1jqysxLdLo+CEEfJDI55YCXjB7/qeWHqvrlJg
	 lc11QDUdNhzbROfzocPikjzxGprM9pNvGpu3CLifG3hZEm0fH1+RZQI7Ww6AWpcLGv
	 Vqxe8izfx9IT/qUT0UHxNSl+962UkoSZW+1N8dKXausrqIwYA+CF1CMDGZk7A/eu8q
	 O+Imq8RE/6lWA==
Date: Thu, 10 Sep 2026 19:26:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taylor Bates <tmbates12@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] tools: ynl: stop find_kernel_root()
 spinning at the filesystem root
Message-ID: <20260910192645.3fde5e50@kernel.org>
In-Reply-To: <20260908-ynl-robustness-v1-3-f255214c0f30@gmail.com>
References: <20260908-ynl-robustness-v1-0-f255214c0f30@gmail.com>
	<20260908-ynl-robustness-v1-3-f255214c0f30@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 19:45:09 -0400 Taylor Bates wrote:
> However, if it is run out-of-tree and does not find a MAINTAINERS
> file in any of the directories, find_kernel_root() reaches "/".
> Since os.path.dirname() is idempotent at "/", the while True: has no
> exit.

Not our intended use case, why would we care about people copying code
out of tree? if they do they can patch the generator as well.
