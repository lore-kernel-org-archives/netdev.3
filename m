Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5512FF69;
	Sat,  6 Jun 2026 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780704843; cv=none; b=cL68QmfbJHoz8Z7V1PyANnoASdlMJWB5ffAgU+tkPu9J98MIADW8syezcSkVyCEKe2gvPFPU7be63bE5WFplmpunR0jKS0RbT2hpqlnIu3TFZ+ujXsvc+GBeg2hjgonmQYJPaZ0qz0TRcZ+f7qJfvGTbvZbLCdsmpHs7KrFv3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780704843; c=relaxed/simple;
	bh=T25UxFVpAsTAV7mOYStO0y+btYY0B1jLKjLpes3J068=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQUU9yVqxiNBqkzpkeO9Yroj6CJ+gGbOCM2r66CIZIBJ6SpxWl6fFVDOo3GNLFc9UM3L7sOORMswYZAr0idJGskWLQSwABFGRisyCxmRm1oeTa4n2FQWFvuRX9ZVhk8EowdBupu6qrT1cIbOXWQWuBy4uyfz9fenUybiItVwFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUSa6dnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUSa6dnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C778E1F00893;
	Sat,  6 Jun 2026 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780704842;
	bh=1tBS+PWRltVDR7TbiiZO1ZJyqTFKJmsVHy9CohoL78E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BUSa6dnLHWKD6eKxzJESSROrOUHuY4Zchhv79FpJPyvwkFLaiZcVgFJQUzM+FCpSx
	 UFrbEwLkgYDRnoprzHN22Au9DVxYWvb9n9+KWF2p8JnQBtlNYoZSm9ZYy5FAldsb6J
	 JSTxYKzUR+ud7WDbF+/NT7Tp5pmaQea1rTfAhCUskqDKe3uBLjHXcTpvO49Pe4zjHM
	 v67nhm6EcoB7eA4Upmaf9SrPN6bVV2sKSuPyfAWPbAFA/AeNkxJFc6z+jht/ehtCC1
	 q2vUqQt+BA50rQKY8Iyp1aA1CUbsTQw2UUU5PCQ7UqLc0zup0tZQ2hP02/ZejpQATE
	 KcjlweVd80rtw==
Date: Fri, 5 Jun 2026 17:14:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "[Ko Han Chen]" <urbaner3@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Simon Horman <horms@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document: Fix missing reference pages
Message-ID: <20260605171401.0586831d@kernel.org>
In-Reply-To: <20260605084130.13363-1-urbaner3@gmail.com>
References: <20260605084130.13363-1-urbaner3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 16:41:30 +0800 [Ko Han Chen] wrote:
> Subject: [PATCH] Document: Fix missing reference pages
> Date: Fri,  5 Jun 2026 16:41:30 +0800
> X-Mailer: git-send-email 2.48.1
> 
> Today, my friend and I are discussing a wwan driver produced by
> Mediatek. I am reading the related document and reference link,
> then I found the page is missing. So after a short search I am
> giving the better link and test the two pages with my bash
> program for more dead links. It turns out only this one. I check
> the page and the following documents. Details are covered in
> this markdown [page](https://hackmd.io/@Urbaner/lk_patch_doc).

Nothing really wrong with your commit message, but the narrative
format is quite unusual. Please rewrite it as if you were telling
the code base what to do.

	Correct the links to ... in ...

> Signed-off-by: [Ko Han Chen] <urbaner3@gmail.com>

And please remove the brackets around your name in the Author line and
the Signed line.
