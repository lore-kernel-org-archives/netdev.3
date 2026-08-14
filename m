Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00087472F94;
	Fri, 14 Aug 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727651; cv=none; b=TWJQHtad7PwE5gUsPCzyT/pEo7xtTq9NBKxjUwl1Da/0PCE15SEEqVc/H9zjs3fh9J9NIFIPeXSopewY9slGTK6VxOnRviBHlvoDS/bMp8QPDgA7fJYbNOAE48mCBo1cH17CHb9ygabL0dWzT8cCvagNgSowygnqMnVwt5+HqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727651; c=relaxed/simple;
	bh=hfmNAPaB0xgScPVWi2h9ylSfp2F+jC/4yNmMJ3GCt9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hau9Qeex/zp/COLCRtI8u2WwGEuf8zkXAGvKXPKptbn+zHaKeVvGJih25gFSENIiy93feNrkm1c1wODi8EFcOtHAVCSEKyICpIz7dvKksCxES5PT2gZQ1Dob/vkkAGhg5nLnNhv0IkKoYR8fDucP3kqA2PVVZ6RlnppWIsJaTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnZ648if; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnZ648if"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1A41F000E9;
	Fri, 14 Aug 2026 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786727649;
	bh=QRfZt8uE7TxCfJc5bF3gpVJpBSTZcFh7gXpTwb9Mc0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hnZ648if5i/hMwtSIEt3ApkaMatOXcFmCK/whRi+8z33iJ/AddOPdu2i1tSSZNk6T
	 iCwkIJ4fU//3ms5UZ3xCxuxNpGVjKEpGmiRu3ctpt9vndZj43/oLKHKTjXWjr6kAH6
	 e2jP0prYJ5pDjXDjAvffaeD5bycw3/g3bgelYE4xJorKrV0PB+yazNzOj/HJbe2yE8
	 uetBfFI2DCEq2TNTjh1TrR92dtj26AvuX+BFPjox0WXkyJaRDL9b6oaXsUtCJpHwlS
	 7Mcq3ACEEGgEduiOaGQ/fN91y0isSqORrKASCvOfqg0FbKQLmhgKcBJfUtDe1yBQFl
	 IFLoX2pKllu9w==
Date: Fri, 14 Aug 2026 10:14:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] net_shaper: fix net_shaper_ops kernel-doc
Message-ID: <20260814101408.13bc8cc2@kernel.org>
In-Reply-To: <20260813192131.21254-1-kmehltretter@gmail.com>
References: <20260813192131.21254-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Adding the missing CC of linux-doc

On Thu, 13 Aug 2026 21:21:31 +0200 Karl Mehltretter wrote:
> Everything from the "Driver ops vs uAPI" heading onward is dropped from
> the rendered net_shaper_ops documentation. Older Docutils versions do so
> silently, while Docutils 0.22 reports the nested headings and adjacent
> list as invalid.

Isn't this a problem in kernel-doc extraction / how we embed it for
rendering? Heading are quite useful and IMHO far more natural to use.
My understanding was that kdoc should be able to use basic ReST
formatting.

Ack on the list indent fix

> Use bold labels and correct the list indentation.
> 
> Fixes: 16812d9674d4 ("net_shaper: remove incorrect comment about group leaves")
> Fixes: 26bc4cfb1737 ("net_shaper: clarify the kernel API / comments")

This is a doc patch, please don't sprinkle Fixes tag on patches which
don't fix bugs.

> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> The omission is visible in the current linux-next generated documentation:
> https://www.kernel.org/doc/html/next/networking/kapi.html#c.net_shaper_ops
> 
> Tested with Sphinx 9.1.0 and Docutils 0.22.4:
>   make SPHINXDIRS=networking htmldocs
> 
>  include/net/net_shaper.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/net_shaper.h b/include/net/net_shaper.h
> index 05cb625b0fe54..a2eb616a19fd0 100644
> --- a/include/net/net_shaper.h
> +++ b/include/net/net_shaper.h
> @@ -73,20 +73,21 @@ struct net_shaper {
>   * Each shaper is uniquely identified within the device with a 'handle'
>   * comprising the shaper scope and a scope-specific id.
>   *
> - * Driver ops vs uAPI
> - * ------------------
> + * **Driver ops vs uAPI**
> + *
>   * Members of the driver ops mirror the Netlink uAPI but driver calls do not
>   * map 1:1 to user calls. Drivers need to be careful when assuming that calls
>   * disallowed at the uAPI level will never be made at the driver level.
>   * The shaper core performs automatic reparenting and cleanup, generating
>   * additional calls. Notably:
> - *  - @group calls in the driver facing API may have nodes as leaves (user is
> - *    only allowed to construct groups with queues as leaves)
> - *  - @group calls may update leaf's parent if the parent is about
> - *    to be removed (re-parenting nodes explicitly is not supported in the uAPI)
>   *
> - * Implicit creation
> - * -----------------
> + * - @group calls in the driver facing API may have nodes as leaves (user is
> + *   only allowed to construct groups with queues as leaves)
> + * - @group calls may update leaf's parent if the parent is about
> + *   to be removed (re-parenting nodes explicitly is not supported in the uAPI)
> + *
> + * **Implicit creation**
> + *
>   * Shapers are created implicitly, meaning that @set and @group operations
>   * are called both for existing and new shapers. The driver has to infer
>   * whether the operation is an update or a creation by tracking the handles.
> 
> base-commit: 3205699d79f262412c1be7fc1c04066610d3cd52

