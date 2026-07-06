Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2B3E0C4F
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320852; cv=none; b=hNX5/0Rd1n53x8RzOu/Gv4rGtI/y1VvfScuwoOSgTlfjl5l6/oB8DKlrurOIutBoYLW4q8b4FsorUTN+lvWjDOm6ULizfRwTsXkAH+T+ZqgbUvjXTTkVl65HCCW7OL9pbvP8dI2pr+UUiAMzuLjRwU+BdGl9c71UQsuQkQzw+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320852; c=relaxed/simple;
	bh=CW1QrPZ/84Xc1S5fxWfdrxrRFouH1TmDZbxVYwQgotM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEs8DyyZNdHtWH4VXhpqsv/mCqN3Mg4rcz4CgkyJnVh3cFfU8XVtrl0QlxW45xmtgZYxrgbgyeL62+s2EqNH/V29KBXYkhICvL+M+idrix5g63L2oBOPle0FNhhzkZ0RXZcVNAnS3UkBltkVUKviHOgNrRNnz0aYEbjeuvcy/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EF92860288; Mon, 06 Jul 2026 08:53:55 +0200 (CEST)
Date: Mon, 6 Jul 2026 08:53:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Dharmik Parmar <dharmikparmar2004@yahoo.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: netfilter: conntrack_resize.sh: fix skip
 exit code
Message-ID: <aktQ5kLLtdG3pn3W@strlen.de>
References: <20260705204252.630729-1-dharmikparmar2004.ref@yahoo.com>
 <20260705204252.630729-1-dharmikparmar2004@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705204252.630729-1-dharmikparmar2004@yahoo.com>

Dharmik Parmar <dharmikparmar2004@yahoo.com> wrote:
> When conntrack sysctls are unavailable, the test prints SKIP but exits
> with $KSFT_SKIP.  lib.sh defines ksft_skip instead, so the kselftest
> runner did not see a proper skip.

Acked-by: Florian Westphal <fw@strlen.de>
