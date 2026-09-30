Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9642882B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751498; cv=none; b=oeo/zjuSUNQ/VIzpAJJzCIPGsP8+K3equvwotOoi1qTq2wWEK7kL6J5hJgltaSVQTdam6Oo8ZBQZrHsCaLUqMpQEdBaK2vF6e/lxz71dfp0VCH89uEw8J7mai11UwOFwhwOc0RLlDESsbi8skraIYnA9deElqjcR1zVZ0/VXkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751498; c=relaxed/simple;
	bh=10ygnyDXLsbMzBOxxQz4gF9lLGk5DMAr5mE+JT8uSWs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Bxu2nTy8MJhuiYAUuBQE95+FMWbk9TGXrfcMYXertOX+WFEuYIEjRoevNJSfVaoInDZqhzfTNz0N0eYgP2QuaAA6BaSHaHj0Z5ChN6ucPfurk3N1cwNrGIqnpdbKEdYl2sKO8RchLEQY6BxlV7owbVu/qj5JAnsKTqhokUBqA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=oHpleDkU; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="oHpleDkU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD073A3839;
	Wed, 30 Sep 2026 08:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790751471; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zWPK2Y3TKmTZrht9/1CRYUXw6ygVs3ZjMmi+AgaKhmI=;
	b=oHpleDkUZkpycehkNZLHanM86ePJdzn0ggndQTeeygmp58sqpYlTO3gHmcVaOABYyaA7IE
	V5f726sLjcKPpfvj5rB27axJfU5gN6ClX0iw9wNfruyhmifkHdgQtyRsRWAz1lAU5Qkk9w
	C0AG9YYkvPQezqlLe5x3ZcvPwcj4Ym9kXJN0tJJ4AbvnfOAia83qo5jqr+GYFfjtv5wVjD
	kvzsPWSUeXlr05WMyqB9qaLA0xvYTnmf9k60RmvxR8lXa7bAverWihNW1keiSfPqTCLF8x
	LqMYxRtpep7tLLmovDKkULATlTPzn0z8N3kvoiKi7uLqAhplJ3JAgarB/Pa4Ww==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 08:57:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next] docs: netdev: additional info requirements for
 bug fixes
In-Reply-To: <20260928184904.2496960-1-kuba@kernel.org>
References: <20260928184904.2496960-1-kuba@kernel.org>
Message-ID: <a4dcd1e19fd79772281974defbd3fb97@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 28.9.2026 20:49, Jakub Kicinski wrote:
> Knowing how AI generated patches were tested would be a great help
> when reviewing them. Explicitly ask people to describe the discovery
> and validation process they followed.
> 
> I posted this as an RFC a while back and there were some concerns
> from developers that it will gum up the process. With Linus's
> recent complaints about the size of our PRs, we really need
> this information. I launched an AI bot which complains if
> people don't explain how bugs were discovered and tested
> (look for netdev-bot+sinfo@kernel.org, s=series info).
> We need to document this requirement.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> rfc: https://lore.kernel.org/20260727204724.2787038-1-kuba@kernel.org
> ---
>  Documentation/process/maintainer-netdev.rst | 31 +++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst 
> b/Documentation/process/maintainer-netdev.rst
> index 1739d9f856c3..d46011a9b4b6 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -283,6 +283,37 @@ as a patch to the list with a commit message 
> explaining the technical
>  problems with the reverted commit. Reverts should be used as a last 
> resort,
>  when original change is completely wrong; incremental fixes are 
> preferred.
> 
> +Bug fixes
> +~~~~~~~~~
> +
> +All bug fixes must state how the issue was discovered and validated,
> +and how the fix was tested. This should be done in plain English, not 
> with
> +special tags or annotations. That said, the information does not have 
> to be
> +provided if the existing trailers imply it (e.g. ``Reported-by: 
> syzbot...``
> +implies the discovery method and validation).
> +
> +Example statements describing discovery:
> +
> + - discovered by a non-AI static analysis tool
> + - discovered by an AI code review agent
> + - discovered by manual code inspection
> + - triggered during code development
> + - triggered in CI testing
> + - observed on a machine in real use
> +
> +If the discovery does not imply the issue was triggered, the next 
> sentence
> +should describe the reproduction. The commit message must disclose if 
> kernel
> +modifications (e.g. inserting a delay to widen the race, a loadable 
> module
> +with the right sequence of calls) or error injection were necessary 
> for
> +reproduction. The reproduction steps should be included in the commit
> +message if they are short (roughly 10 lines or fewer);
> +longer reproducers can be posted online with a link included.
> +
> +The testing statement should explain whether the fix was tested 
> against the
> +reproducer and against kernel selftests. If the bug is in a hardware 
> driver,
> +the testing statement must include information about the HW on which 
> the
> +fix was tested.
> +
>  Stable tree
>  ~~~~~~~~~~~

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
