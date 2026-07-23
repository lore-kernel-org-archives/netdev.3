Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E343DC4AB
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814748; cv=none; b=lT8Ado2+BDOQL6PNgFlklWAkGPf2GAnkg0eUoA/YGyn/Lfu6NV9ygNRIFB07oqpFv/xx/Kh542L3qQd4OxOBUbVcAhmeRRcHXzi/cXjeJk09GQPzWJ2B+Df/6GS6kewIh5HYtqe7gjXcoj39ebTuU+M95M1fJUrGQQWDoRa9kmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814748; c=relaxed/simple;
	bh=de7dOstIqMJQbn+dT9ZEOkaVyDkt6E7mCY8CcAf09UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPAOIdhmCgaEVY9n16Mv3dRB0sykVzabx0iu/9N5vxEvlGG4X7NchiVq1OShg+GlWsvCoZhbSb33j6w+d+89fBjXrSsqtggQBoRBJnt98L4rtJFIHlTzuFe6DxpE4f9S6nMoh0r+pQyl1zv6bxhSJAHrrCDBPqs6knF7oDSwHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3CQalkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3CQalkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21991F000E9;
	Thu, 23 Jul 2026 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784814746;
	bh=N0TIOvOZxY2Woi/BJQMWwmtG5mgKXsIezjCQxlkKBJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q3CQalkCe+5H6D3psio36tlQiWfXrTaGKxXy/YQBhxk2fkLSrDlgMHE4kUpEKEsz5
	 r2Mf3BWn9r6wJmPEuqfu93A1//LwKYQWILle4EWROAC4Mv251SCwgtQv8yu5mFrl4a
	 FoM4JGOmuo9Kh6cbT7X+0kUfP7S+cOiyiaVSpgdcMEH6pyt+/uWKidpkD0U8eiOgl+
	 p1880HaJkW/WW+zoJjc4G2YOPwkytkrulQ09OLN3Vpl609LDfyOk2+eslu23WdwYa/
	 zlfQUG2g8eFBwlhHsdzhb4yQKZ8vM1T8ahnabcFFw/VqCkwUGs/1v0BYNjMrIl8YgC
	 SHCxbIsT6VnKw==
Date: Thu, 23 Jul 2026 06:52:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v5 00/15] bnxt_en: Add kTLS TX offload support
Message-ID: <20260723065225.62d3b15e@kernel.org>
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jul 2026 21:23:45 -0700 Michael Chan wrote:
> Subject: [PATCH net-next v5 00/15] bnxt_en: Add kTLS TX offload support

FWIW I think Paolo dropped this from PW but replied to the v4.
Likely just an error in reply, the comments apply here.
