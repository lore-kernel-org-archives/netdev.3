Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210883BED7D;
	Tue,  6 Oct 2026 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318916; cv=none; b=IU7Hj4inZMIzRFaGuO6xtCaRatjoo6ETXiqys5jFGqUOOG+ufGW3snspi5Ai5eS4PTtF/UlE+ZwtIIDr75qero92P0dGhBelYYAEKZlSD92SvF2gH+r3BwGf0snOFfCbzIcSZnn7jfTh7EpEBe4qO94wGaWHNz3s9L2wi2XF0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318916; c=relaxed/simple;
	bh=QA3fQbLQ78R3dfOORKjeTlrzwpLrcaatYor7wBsWz5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU1V54ssGxgHv/QDQdo3ze3OeIOXuRu5ctRYmVzPqCSNxnpsy6EaBFLGMlHercXU/UjXNg/48ub8t4BKpf7amvJH5icPi+HzGpeeUWNnUDWdneY5JIDXP1oxDc40wFu6G4I0owTQeN78KAI5j2LtTZnsaT3OHoQDBMwOTzlceDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwGwtFSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwGwtFSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BC21F0089B;
	Tue,  6 Oct 2026 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791318914;
	bh=5r7PPAyd8oCWuOmPAyTmj40kUBA5HNxIdcgppOWP7CE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cwGwtFSwy7fVY2WKO8yGvqfv58cfgjzJDaBQ3GxwtiLSaED/pQboj8ZFcNNc8AHbI
	 WUNcjD5abrkJJya0i7Wrj6ze3xbmiTnT0F+isuut38IbX8DOkc8zZP+ndHN+rIgqeI
	 8jKBZg1ze9Z/BPpm3xmXoUuaCFcLaER/s560hzVMnQO/YtHQVWpX3AEpqces1w2rbQ
	 rv+CWNzlXeNxpXWdyRVIEc3CAaoLEaYLIs7dlQxIRwXZN/C9q53+PiPbbyqtsbDSpE
	 o7+eZdKkg1YQBB9j/X9JjfJ+KVzj8SKglIPD7RfGXkSrK2b00KvQ9V+Ub4pdiH7W1x
	 9HgUkgHZz5BBA==
Message-ID: <afc14b81-32b3-4f91-8b0c-0152889f80f6@kernel.org>
Date: Tue, 6 Oct 2026 22:35:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] netconsole: avoid printing partially updated
 target attributes
To: Gustavo Luiz Duarte <gustavold@gmail.com>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <netdev-bot+sashiko@kernel.org>
References: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
 <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/26 20:58, Gustavo Luiz Duarte wrote:
> The configfs store callbacks all serialize on dynamic_netconsole_mutex
> but not on the read side, so reading an attribute while it is being
> written returns a partially updated value.
> 
> Hold dynamic_netconsole_mutex on *_show() callbacks to avoid racing with
> writers.
> 
> The dev_name_show() callback can also race with
> netconsole_netdev_event() writing to np.dev_name due to
> NETDEV_CHANGENAME. So it needs to hold RTNL in addition to
> dynamic_netconsole_mutex.
> 
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>   drivers/net/netconsole.c | 62 +++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 267254f046de..188beacb308d 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -859,7 +859,19 @@ static ssize_t release_show(struct config_item *item, char *buf)
>   
>   static ssize_t dev_name_show(struct config_item *item, char *buf)
>   {
> -	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
> +	struct netconsole_target *nt = to_target(item);
> +	int ret;
> +
> +	dynamic_netconsole_mutex_lock();
> +	/* Hold RTNL to prevent racing against netconsole_netdev_event()
> +	 * changing np.dev_name.
> +	 */
> +	rtnl_lock();
> +	ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
> +	rtnl_unlock();
> +	dynamic_netconsole_mutex_unlock();
> +
> +	return ret;
>   }

Please do not add rtnl_lock() in a _show() sysfs handler unless there is 
no other way?

Something like:

     dynamic_netconsole_mutex_lock();
     strscpy(name, nt->np.dev_name, sizeof(name));
     if (nt->state == STATE_ENABLED) {
         struct net_device *dev = nt->np.dev;

         if (dev)
             netdev_copy_name(dev, name);
     }
     dynamic_netconsole_mutex_unlock();


