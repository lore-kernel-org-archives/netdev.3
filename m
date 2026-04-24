Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027941C71
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994298; cv=none; b=EOUE6Y0O6H526bZqFpG5cFzCt+cpEzJUXjdW+4apyAAp/u72sy+Loxgs59F/HWslLKYpbQdnZTSixTKkLeLGeHlypMqVRvMdnvABPODI4cO3wtr8P57FTIVL11nQ5Q5ayVxtUdY2bBozW4G8gAZIvuFXeTQmxAdsiXl5d+qgLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994298; c=relaxed/simple;
	bh=/CZsYzL7FiUaap0Zezv0hM4EPym3OQbyrrCdLMfTuYw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=JtOCUtjMF+rGIhssZN7xs7pUUQb468BeBBfIoFE6hTC3FhmOMYq6QZ0DpwEocCQ4VinuhOzs+puWX54QAVxWmLktWXf4OazY49MXVWaOCIMNP8bUo4p5mPLXxjRE5nbBihND3pCGvnBvyW2cgNggCv9+PfxYf3sEHYi4R7W2+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qh8aY4EA; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qh8aY4EA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776994294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=/CZsYzL7FiUaap0Zezv0hM4EPym3OQbyrrCdLMfTuYw=;
	b=qh8aY4EAjYKRn+jdJkra9YnQNlON6MFRdoUjFONw5GtDaz0N9we2LhzquYENy3I/RDeawK
	foNbED3nr9c0F/wLq8vnhn68F9HE6vUXhedBPrOxZD6URTFUYtLawCwN1hjCu68iLILAmq
	YD24FHiSmPlWIzCzkKmFpOZPy+1ywjw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Networking deletions for 7.1
In-Reply-To: <20260423235422.1541768-1-kuba@kernel.org>
Date: Fri, 24 Apr 2026 01:31:00 +0000
Message-ID: <7ia4se8lb0vf.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


2c on Sashiko:

1) I'm working on an infrastructure to separate pre-existing issues from
new issues. My current thinking is to stop reporting these issues with
reviews of new patches and instead put them into some database and give
maintainers access to it. Sashiko will automatically deduplicate issues
and index them by the source file/subsystem. Hopefully it will mean that
maintainers will see only a limited number of issues in source files
they support. But I have yet to see how it works in practice.

But I'm somewhat concerned that this way many of these issues will
remain there forever and by reporting them with new material we actually
have better chances to get them fixes. Maybe it should be configurable
per-subsystem. I'm very open for ideas here.

2) Re false positives vs finding more bugs I had the same experience.
It's easy to tweak it to be more conservative or creative, but it comes
at a price. It seems like the real answer is simple a better model. We
saw a big improvement internally switching from Gemini Pro 3.0 to 3.1.

Thanks
