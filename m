Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95D433033
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888572; cv=none; b=E9EvOP/jOoSxVlh2s957tDF03wPiQPzaos4n5mqKrnM9qqBZ+nSMD1qcNAVjWyQHckOTf07xGGVHDeskPVxY6BjUKSMqDXX3MBV6NR3A0bZk89XV7XgFTZcfSiv6zueXtzY/0y4tjkSbjZX2bPhd78UvGJcwY4J3QafZavXY2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888572; c=relaxed/simple;
	bh=Xp/gRKXyt7/mIRcpTUFZxAcYW7W7CWF1cmp6RtTiLIk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=F4S6YTIJlYhn2PU5FsOGJiPqqw5l5D5IWBv4zIpepIfiuDAul4L1r5vc9ry62yZcmNWh1XYrj4qPSwye0ob1+iTFTQ8uuCEJZEjxopAQYnvRtqqHgr2a4c2TAQ1d4Rta4bVsj+3gyiFpcct1A3cFnnluHNxM0ukRNllXB/kQzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3wVL9vRT; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3wVL9vRT"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75D54A38CF;
	Fri, 24 Jul 2026 12:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784888567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=81PvFk0hfFBRVnH5okMYqtPAGB+87iSQe6tZ1Io90zs=;
	b=3wVL9vRTjPCMWG12yDhJNUTAMVOe1TyXsBgP97sBSptIKprbxyaUzNGlLMzhVU4SygnHjg
	wak0tAGJUFSlY8ct4wnEkVXjn4M2PprB9Z7cprW7IkMUsRQ/3lMzm0NFfrAJ3gobjEWcOz
	vonSwhEfVWKRaHURdlTYjaKpf7fJw6OwiD9Vch85x2a1P+d9kA5b/EouNunhNLJsoc5HYH
	JpzDKrcpD8v44v3crxXqBMHsbil3CqmpuxIjil+DP5j6yQpAOYLuJNsXoXgE81Hu/F/y9E
	JsLUMbKLn04wAbK7cR+VsvrBd1RbMzRqiPi+VpXOLjI8CGtmj7LABCo3Q9vz5w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 12:22:47 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next 1/2] docs: netdev: clarify handling of idle
 patches
In-Reply-To: <38b75373f813354ad0ee8bfde12ae5a42e9a11b6.1784884817.git.pabeni@redhat.com>
References: <cover.1784884817.git.pabeni@redhat.com>
 <38b75373f813354ad0ee8bfde12ae5a42e9a11b6.1784884817.git.pabeni@redhat.com>
Message-ID: <d9f57f7676bb223438298cf349359f49@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 24.7.2026 11:24, Paolo Abeni wrote:
> Off-list pings are very bad, but unfortunately too common. Explicitly
> state that, so that at least LLMs could learn it.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  Documentation/process/maintainer-netdev.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst 
> b/Documentation/process/maintainer-netdev.rst
> index ec7b9aa2877f..e58f541c29e0 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -210,6 +210,10 @@ landed - describe your best guess and ask if it's 
> correct. For example::
>    I don't understand what the next steps are. Person X seems to be 
> unhappy
>    with A, should I do B and repost the patches?
> 
> +Don't reach out to maintainers or reviewers via private email and/or 
> other
> +communications channels: all the discussion must remain public, and
> +requesting special attention is unfair towards the community, at best.
> +
>  .. _Changes requested:
> 
>  Changes requested

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
