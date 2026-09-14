Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A73914FE;
	Mon, 14 Sep 2026 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429020; cv=none; b=QlLUT2u+PrLVsyd802w/BfiWJHEZFXQIiHbQRefr+5I9iwasQfpG0RQ5oHOkJImPTh1z16XWX/keUG9rCa0lcuCQCxS7IsscW4NlkKPVmDNUV7CymWUBdRJZJSgBfCY3c8241W+TTWi7NAnDfhSBnL87a5w+W39VxPhw3d6dBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429020; c=relaxed/simple;
	bh=zChASyt3c4gbOlGfP0flNC4hW93w+vYYOw4HlhzpcVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG5RW4+FmJKaH29t/3yo3ywZ8zigblI6h0XnUEcutgI9BOIci05L6n3s8MD1D2+XNA53VqMaFRbP61REFliRQQggmFLGLjWsmF4yNduoJERyTFWcFnpIhVpx+Yh2lVHQn/I5HVcHi6NNxP+WcqgbIA4dNeGP+/bJXnEXpoTHhR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWcYaacy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWcYaacy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE871F000FF;
	Mon, 14 Sep 2026 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429019;
	bh=DpRQcQ1yh6Ro17NbHd2nqARNl9jC+rX/Kbcw2AVgXJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dWcYaacyJ3ddoGso3kMjasMschxmd0u4/EWkC7f+W19V3iOYKXYrMcSlwXDPkPmWZ
	 xW2Kak+8u8ts+n9Vsk+rDb9A7YCC/88Z4u/4CTXBuX9Z9QRjm6EzOvIAl9m7+7LypC
	 Oxbus/ocXfIBX55+0s8TT8LzJRp/QcFt8O3ZQhsrBnTedKFX3Eq9JR2pjRDW6o2sEh
	 s3QiNqBzJptmzrfDwwc0isuOeJjZ6YFuntD09dEc4qyeRWeYsX50dmicQVLkM0Tpk9
	 MrvBcv8y2uCaR8Md+jUWolCOavkHwC5rBQpOSpS2o6/xO8VMX6c0rCNO4AC4N6kZQa
	 PdRYo0oI9hDag==
Date: Mon, 14 Sep 2026 16:36:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Murali Krishna <muralikrishna2444b@gmail.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: qrtr: fix coding style issues flagged by
 checkpatch
Message-ID: <20260914163658.13cff637@kernel.org>
In-Reply-To: <20260913180342.8948-2-muralikrishna2444b@gmail.com>
References: <20260913180342.8948-1-muralikrishna2444b@gmail.com>
	<20260913180342.8948-2-muralikrishna2444b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Sep 2026 23:33:42 +0530 Murali Krishna wrote:
> Fix several coding style issues in the QRTR subsystem detected by
> checkpatch --strict:
> 
> - af_qrtr.c: fix missing space in pointer cast, "(u8*)" should be
>   "(u8 *)" (ERROR)
> - af_qrtr.c: move trailing "*/" to a separate line in two multi-line
>   block comments to match kernel comment style (WARNING)
> - af_qrtr.c: add missing parameter names to the enqueue_fn function
>   pointer declaration in qrtr_sendmsg() (WARNING)
> - ns.c: remove unnecessary return statement at end of void function
>   service_announce_del() (WARNING)

You seem to have ignored all the automated messages telling you to slow
down. And we do not accept checkpatch fixes, please see below.

Please do not send any more patches to networking for a month.


Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
