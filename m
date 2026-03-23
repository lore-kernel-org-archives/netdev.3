Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5535AC2D;
	Mon, 23 Mar 2026 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305155; cv=none; b=B/QqdlJ0f9h0KY26yOECqKkoCGtXqJRQmiQ6wT1GQYZhl5nckrs6S1eT+JPOfAwBhrhVn5e3/kF6BKE85yr9GKKlEECfQa6mZxRFz9H6cJ0lf9DGTfxLN9q0QX+V0/DRr3CmaGiQJJBMMvWhfpxuizWjusYtm+9x6n3oHr2SRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305155; c=relaxed/simple;
	bh=TWBc2VswkxrIugCmPUsSjvAQATsEjGyfm2GbdqMcisI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZaCndbiYgX4l+722koXcZIR/dMt9SCCsm0iwZGwB4Q8H9sxFiqfn0v5TS9zZOYLhubHbi0UnTZv/XNBaWYyQ1qhQFhLlhsHTNDLZq60AOc9+kdMv2qtMzW78KvOwPZ4nKbLtoTcF+rWBvuJpoguQtzZnDXy9zbB6rYo8xFUUT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE3wkJoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE3wkJoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444DCC4CEF7;
	Mon, 23 Mar 2026 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774305155;
	bh=TWBc2VswkxrIugCmPUsSjvAQATsEjGyfm2GbdqMcisI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UE3wkJoQu5IBL2+lvYpZMIL1ReS2cmqQWndNlC4/IkejYebe96jAtR+XgYgweBi2k
	 8jwwmhq6ksAQXF2eZfSk8g9B8jF7+TsBwvBWz9MPuhNsdoUNamvZ/Ja4JODLh9Iqrk
	 ZEPDkVdc2vBV72ELk760ZPFeXDTH+fQI7Fbguij44OgD6X5T2mDs0m+scSZt1jriOW
	 avImKHWsaUKiSq+2w1C/zOu7/EXUP7fgGXyRFEiGrxH/6dXOZAaAAuYrsYilFSxnWU
	 dLWU+9gQiMKDJUmtCk9lxUPa4CyiZevrU5vwWGrlPplDnwfa105ECpRu6ImguffHft
	 3Vh3X83YKdwjQ==
Date: Mon, 23 Mar 2026 15:32:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk, netdev@vger.kernel.org
Subject: Re: [PATCH io_uring-7.1 00/16] zcrx update for-7.1
Message-ID: <20260323153231.415f7172@kernel.org>
In-Reply-To: <cover.1774261953.git.asml.silence@gmail.com>
References: <cover.1774261953.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 12:43:49 +0000 Pavel Begunkov wrote:
> The series mostly consists of cleanups and preparation patches. Patch 1
> tries to close the if queue earlier at the start of io_ring_exit_work()
> as there are reports io_uring quisce taking too long leading to fails
> on attempts to reuse a queue. Patch 5 introduces a device-less mode,
> where there is only copy fallback and no dma/devices/page_pool/etc.
> Patches 11-12 start moving the memory provider API in the direction
> of passing netmem arrays instead of working with pp directly, which
> was suggested before.

LGTM, FWIW.
