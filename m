Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0824A92C6
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363930; cv=none; b=vARCAcugBfEgoNLzJ6ywnMMIgZwmAOszfF5gjeRwG3U7Es9kFjRZtrcyQ80f1TFx2mwk6GFGuxY3JWXO7RNsH8xZFlWNjSAiGe70VGBIuOhcdZRoINIerI9Ui9D8hrDs78jXcjoy6WHP2mLIyhPZ1jHHhY4rMk9yKtoF7TZJba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363930; c=relaxed/simple;
	bh=tZxktGjB8YTGA9I9GQVRuK/o1xjHaIuBgU1nERYNMdI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L5mI10PFI8ZVW9nzbRlH8en3e/vEP+JLQIyiZTvlFGc6bKjLV3+yHoPvyMvow65NhvbP46Ub0Tj1K27x7OC/LBdHSzqNz+416riftB/aR3pcv1BMAiHae1E3SadYrMhMxMHnFDgwQ6QSBxVo1YIcIOrnGjlvsFdPZOZYQnDLSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 7CC5B10042D1FD; Wed, 02 Sep 2026 17:45:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 7A8E31100AF010;
	Wed, 02 Sep 2026 17:45:25 +0200 (CEST)
Date: Wed, 2 Sep 2026 17:45:25 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] man: remove libnetlink man page
In-Reply-To: <00pr87n0-6234-r200-osnn-npr6o662snn8@vanv.qr>
Message-ID: <p078ss31-9417-p588-73n5-567rnn8q2ps6@vanv.qr>
References: <20260427172827.300214-1-stephen@networkplumber.org> <00pr87n0-6234-r200-osnn-npr6o662snn8@vanv.qr>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wednesday 2026-09-02 17:37, Jan Engelhardt wrote:
>On Monday 2026-04-27 19:28, Stephen Hemminger wrote:
>
>>The iproute2 libnetlink is not a public and stable API.
>>Having a man page encourages users to think it is available.
>>---
>> man/Makefile          |   2 +-
>> man/man3/Makefile     |  18 ----
>> man/man3/libnetlink.3 | 200 ------------------------------------------
>
>If it is not public, why are the header files and static library still
>getting copied on `make install`? (What's the "secret" user of this library,
>if any?)

Found an answer faster than I had anticipated.
It was not iproute2 that installed it, but openSUSE's own .spec file.
And it seems mipv6d was that user, but a long long time ago
(2014), when libnetlink was used.
