Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63B431A40
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888557; cv=none; b=V4x0cEKec3lBEJAkTWc9WLMiclhf/nFgx8wygpe8f2Jh23TRR54TMHCOyl7d3rNJFIgBG2n+fP9oT7E9Gms9zsn0dYPDh8mLYhQAl3PGEPjtIEC9fIAGOPaVaYh1pE1vAXn/2ATUBjkKa8i7CYq8M2MVGvQ6gaPDreGjGwgUqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888557; c=relaxed/simple;
	bh=SyvagFmvZ5lnOm9Rwsl0MKMPhbRx/RdmElepEdAaKRQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g4dCeZQm30pMF3Icv0Y5L6rL/wFlc1S2CoGAwVQSVa43C7wtBmL9iwXqr+4lU0KSJrI5hzHKUpXBzu4ZjFHEv6PgU/9EMTw7n33Ceryd/H+i6wjcdA/GU+40NEVjmLEQOSQUd2sHcA86yd3S4wf5rkRH0yXFciyk8lWlvoT1nrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YjDMqpXk; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YjDMqpXk"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46704A6935;
	Fri, 24 Jul 2026 12:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784888543; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LNmmfCd+qbXRdBRb70IPu5Qh54v0j2foyeCy+tiKJqg=;
	b=YjDMqpXkHlOhM9H2nduabFX9VzxQrz9tGlbaHRod8OV0uZrBGKATCcR03UwGvLv0isE3v7
	7jAM9zLdob5lbUd4LgN8XLM8bVaZCCEIsK2M5gpNSHyoFYbvKfnU5iYbNL9XFeWmX4INfj
	ZgJoJ2cKPZTaelxuolk/bXyyIeJ3rNaUatJ6fWU2oPIqn985rNGIiMt0hpEWvzsf7tam3y
	DB8+RnWIxIOtX/IV7i89dmxPEo1vDRdz21BJ06UB+o8YsqTI5/YDyqZP3fB2F3L1VF15s6
	HyMEUzThLNLxGP3grS3XY1qJt/5haR6Qo6iajQlEvoMduId25+ZuXHgUj5a5cQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 12:22:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next 2/2] docs: netdev: clarify expected interactions
 with LLMs
In-Reply-To: <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
References: <cover.1784884817.git.pabeni@redhat.com>
 <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
Message-ID: <4ac691b42bd2a8568014d680e21ca90c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo

On 24.7.2026 11:24, Paolo Abeni wrote:
> The official documentation has not captured yet the current impact of
> AI-generated reviews on the patch process.
> 
> Explicitly state the status quo and expectations.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  Documentation/process/maintainer-netdev.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst 
> b/Documentation/process/maintainer-netdev.rst
> index e58f541c29e0..1739d9f856c3 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -203,6 +203,22 @@ For RFC postings specifically, if nobody responded 
> in a week - reviewers
>  either missed the posting or have no strong opinions. If the code is 
> ready,
>  repost as a PATCH.
> 
> +There are 2 services actively providing LLM-generated review on posted 
> patches:
> +
> +- https://sashiko.dev/
> +- https://netdev-ai.bots.linux.dev/sashiko/
> +
> +both use the Sashiko infrastructure on top of different models. 
> Reviews are
> +available after 24h. Patch authors are expected to proactively look 
> into the
> +AI-generated reviews and handle such feedback as any other kind of 
> review:
> +either debate it or address it. In both cases a reply on the mailing 
> list is
> +expected.
> +
> +Authors are strongly encouraged to run LLM reviews on the posted 
> patches in
> +advance of the actual post. Large series triggering a significant 
> amount of
> +AI-generated feedback will likely get little attention from 
> maintainers and
> +reviewers.

Is it worth to mention Chris Mason's kernel prompts [1] as an explicit 
example here?

[1] https://github.com/masoncl/review-prompts

> +
>  Emails saying just "ping" or "bump" are considered rude. If you can't 
> figure
>  out the status of the patch from patchwork or where the discussion has
>  landed - describe your best guess and ask if it's correct. For 
> example::

Anyway:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
