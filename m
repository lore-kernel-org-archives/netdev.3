Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71D2D5937;
	Thu,  9 Apr 2026 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702395; cv=none; b=QEZi9crd5EsyvRtEobeWcRWWJtMytFFTymAhPSPHVspIM67NS113ReN25T9EmvrP9urC6AYXTBF3jwxi1Asf7sM6GcCEKj8HPff8ZhToOVHbOQfpHknMu/ycy7Cs9Qw+lMIGJYYPmuud3MC2Z1EBJkTq0SIIO4VQbse5ZlCattI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702395; c=relaxed/simple;
	bh=xQJJE8QvmgVGNOhD8sQ6ckx/Dcp6WCc+xBwXwcaYVwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ah2Ut/booru7NKj61sgOsaVlvHQBc7hqR+XL5cDb14kEQpsw+Vz5+4qH/xSLrhHjLRmKPBkPy3K+wB20oL/SJ5qP3KgaesgASbM6lhwhQ63PBBxR/h2CZnrytn9xbcjHCrX2FmUAmCdd6AS2+klQt68rfOk0Zfp1YDrsYmn090U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgpGW6R+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgpGW6R+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB8AC19421;
	Thu,  9 Apr 2026 02:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702395;
	bh=xQJJE8QvmgVGNOhD8sQ6ckx/Dcp6WCc+xBwXwcaYVwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BgpGW6R+ik0WazZL+C8To5nK1E2zWtC4NsRmz99Pf62FOnjDQteZMPzAHu5/1PcD+
	 CR1QaSwzqsxpDBSIZ9GsaUEXZUtms3JbaiDYDK2QPmayElVE+s2C0uM9TUslGwWazg
	 qzYNDeF01NVX9lAQ4kc1almnFSOBgOm9IKYrnNEA2KwwVU/Of+NLXSVfxbQZGbgMHx
	 ctkeI1EA1uZTTInMRR7qRF9B0AxCZpgKGU5V/+xaY3j1Wb1SXnL+LRTuBd9vmjra0b
	 6fBsjbhrGfse3F3mqXcLzfExQ5AgbSf1udJJzyNn5hQfncLO0aoYCawNnIbuL/l66M
	 uZ5cXOqutPc0Q==
Date: Wed, 8 Apr 2026 19:39:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Tim Bird <tim.bird@sony.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] keys, dns: drop unused upayload->data NUL
 terminator
Message-ID: <20260408193954.6e69be8d@kernel.org>
In-Reply-To: <20260406175810.1018681-3-thorsten.blum@linux.dev>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Apr 2026 19:58:09 +0200 Thorsten Blum wrote:
> Subject: [PATCH net-next 1/2] keys, dns: drop unused upayload->data NUL terminator

This says net-next but patch 2 never reached netdev@
-- 
pw-bot: cr
