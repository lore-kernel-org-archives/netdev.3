Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193A23E325;
	Tue,  4 Aug 2026 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808184; cv=none; b=NvB1MIwY/G8Egu2kObVZk5j5gyRao+6K4xfbvdyYAvRroij6bvl4k9CN2fVYr+DEoMzGJEOqrVkdvfS6/FX15F8Ko7hWZ60iBB/y2Pyji1p0YTN473q2yiUnYj+ExHYoZdbJqUW4mAaLvTkUDMPA2x73GAyCDSZz0Q2VptQQWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808184; c=relaxed/simple;
	bh=xmsJAiFfcG2yquXCta4sE42e1WXTNibMrQr0AO9Qlqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hx902q0JF9HKEsuiTrdDhzlnwUYIYPzGt4YRkAKNlAxm0CVg1oREtPR7c66efI7F4oawkWGAQNnZHSH9Z4xaAe4VhkEIJYpE1C6i2sSaZbpTuzlhsohgnyhjGrBfhzyhe8dmIMZ3T0YyLp/f9x27dg+JfeRnoNWgttQvhMER0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deCC7gDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deCC7gDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54731F000E9;
	Tue,  4 Aug 2026 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808183;
	bh=CNpwMHzHoQUCESP3NxMmT0IJZ/0PL3XzyjdQG+C4+VY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=deCC7gDaCVkDsZoFs5iybcr7cbOuVklsEhnMVCxCgCGSnUjb3RK3870+niM6S+Hgp
	 sJZN+dQf+5Dexzokp8UiW14ept7muAENfXJ69pnhBrMaD3MORTtigtH0ijFdYlc42g
	 DcRky33eXWqOazexU7bAr5+vJLqJoLZd/jTsbYtOvWecygAZmcneRDXHcOAA/0s1N7
	 y+50lhbVUPsjUlwpto3phhGQPG1Gxu0YwTnekAJsYJYOGPycwCnteKlsXcQV+1XUpc
	 RqY+l1CD+2swV8lasMvxwgJMqG33UYbWUUnutShZSaxLYkERtBV0fHNfqyaIDUAbcZ
	 mEForsXA3Y2kg==
Date: Mon, 3 Aug 2026 18:49:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, mike.marciniszyn@gmail.com,
 alexanderduyck@fb.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 jiawenwu@trustnetic.com, kees@kernel.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 mengyuanlou@net-swift.com, mohsin.bashr@gmail.com, pabeni@redhat.com
Subject: Re: [net-next PATCH v4 0/4] Add support for XPCS based RSFEC
 configuration
Message-ID: <20260803184942.397a3ecb@kernel.org>
In-Reply-To: <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
References: <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 15:16:25 -0700 Alexander Duyck wrote:
> This series adds to xpcs to add the necessary configuration steps
> for the DW PCS/rsfec for high speed interfaces.
> 
> I picked up the set from Mike Marciniszyn who is no longer with Meta. His
> set ending with v3 can be found here:
> https://lore.kernel.org/netdev/20260527000958.81108-1-mike.marciniszyn@gmail.com/

Since we got no human reviews I sent out the AI comments.
LMK if you plan to respin, please.
