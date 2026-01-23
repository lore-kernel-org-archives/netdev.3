Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AE263F5E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132482; cv=none; b=iEVl9jjI9pqgQrfSAc/wobfbvfhCIEkgNgpvwyT47rLH6qJooFqfBbfjym1hEUeTU3wq9yOlGkVidi2RqKV8Vt582snQIRk3nGd4GBr4RCkk+hGkaSI3AkstgRTVCiVJlrHWx508mpa8QFD+ZK0mMpKhLcy/7PUDhiSEXChW0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132482; c=relaxed/simple;
	bh=B79u61vM5umjZpRwtxb8N3r+xztvcEFvzkTjGaq8rpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKep77o3shZLcvdrgZOCyPW0vC8v0dN9AW15/qPvOtrhxcQ5a4zihafyebVL0mOLNPDfuBPj0Xb+bG4b8hdYXzkICFxJ69zdyJwCQ2jjFIjBMDlL09fwf9ExruLNn1eQlf/Q/NRHGT6q3SfZlSChIOPEuqjoTb3wgdz95qLs2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhDjNvvq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhDjNvvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC4AC116C6;
	Fri, 23 Jan 2026 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132480;
	bh=B79u61vM5umjZpRwtxb8N3r+xztvcEFvzkTjGaq8rpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhDjNvvqcceBfT+6Rk+hOHLCJaxUmz+0XXxPEGDAi//ps2FzCUy+EghiP2wr+f8Ot
	 DAgkJdezZe+gkhwh8QuxWWUdWW9YU9hCrsxvqybqJYy4lEbd10JVCNkdwAxMh0Sk4P
	 8Yiw6dDYKjnJcZRVtIMzS6M5skIzge5yas6ck1ELU3jayL4TYX9oD4zHNf6enoV6YS
	 wqddr+7Z5pV+ovRfUbMbHEHY8OHkAQZJmefIe0YKP+1QyCu1jrP838VuNZWxxRzyrb
	 5p9iQtOD7Oj+3bqX5khcOoL3lItlgJsSoV0F6LWx/PbSCas3jEKoTZ637otnSh7jS7
	 bhbcVtXdWjl3A==
Date: Thu, 22 Jan 2026 17:41:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, sdf@fomichev.me, almasrymina@google.com,
 asml.silence@gmail.com, dw@davidwei.uk, daniel@iogearbox.net
Subject: Re: [PATCH net-next 4/6] net: use netdev_queue_config() for mp
 restart
Message-ID: <20260122174119.64bb4a91@kernel.org>
In-Reply-To: <42c80a14-3d58-4e5b-b776-ffc31d70082d@nvidia.com>
References: <20260122005113.2476634-1-kuba@kernel.org>
	<20260122005113.2476634-5-kuba@kernel.org>
	<bb985b09-fe29-4fc9-9c06-310ff3abfad1@nvidia.com>
	<20260122074602.3c41e8c1@kernel.org>
	<42c80a14-3d58-4e5b-b776-ffc31d70082d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 17:28:02 +0100 Dragos Tatulea wrote:
> > FWIW I think something that'd be a major usability win would be to make
> > MP presence imply per-queue HDS threshold of 0 automatically. So that'd
> > probably be first on my list of knobs to extend the "priority" model to.
>   
> You mean to set it to 0 during MP queue lifetime and then revert to
> previous value according to the above priority list. Right?

Exactly. threshold=0 and HDS=on when MP is attached (assuming driver
has the right capabilities in the queue ops struct).
