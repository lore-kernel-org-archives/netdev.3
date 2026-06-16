Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDE3E1682;
	Tue, 16 Jun 2026 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649611; cv=none; b=HuVLZFIX3kW+2u/Wl8D+JOXhmVSeKw20zJGLe025ueqEhypmhMXwvKRVL8WaVbf7OeXdC7O+o9FDxovhLpJ752oRglQYTAVcahcDlshQQ2bQ6H6ZY9olOtzlKY6gDhBVm+3Tes/PG4JWAjC3tPzscox7HHG6tjEmKKilGee/cOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649611; c=relaxed/simple;
	bh=NUYjqR6sR5srieQsMlyK4PjiDVO0qcPJpXizvfJzKzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1mUb5lu3NR8IuKE5h3EHCs0q0X4I+fQU65W/+sQT+5IGjhyQp58kMzLoly9dTTll4HpNtqsByzC3Ajz0VvSu21dPj19Mdg4SMM/VvPxEOXKAmA81qLyVKqbtRTVI1o8IXksvOe4efmZ/2V/TSLxrjZZHBo0E6ADSIEDLfVGp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EifnjJ2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EifnjJ2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D531F00A3E;
	Tue, 16 Jun 2026 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649609;
	bh=3AVIqwiOf2ilwfObX2BqNzPwAgSeltapZaaNIUL0kXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EifnjJ2ZWjjRJjjxKvHYcni84M0WTOCYZ1oiC4t96p7d0RNHiwpy4l+7rZtHlKwmd
	 Yth0wIEqDD9+YXfKvja/OWljwTPZjWyKQIyWWP0GpGjXfOV/XEJLZyTaYot1tJIMSw
	 NLI63Jvv0CAhXD/9vxcPR91N7pJ4ENgqC+HqoQBc4x2XZ1tDgrY7Zbuc+Xti5XnohT
	 PVROkVKFzue0wZQvC+IDQUFXPALiu8McgPaZvf5gaOOYNppzwwPqgeRCDhcV98ofDk
	 v+HoFUAk22YoOnRPYf7GSh8OVFbEICTICP2dnjGwgBriCs3PhA8/mckAWwc4GhA6HK
	 kvajRB3/6d4Tg==
Date: Tue, 16 Jun 2026 15:40:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Subject: Re: [PATCH] netdevsim: Fix deadlock in del_device_store() and
 nsim_bus_exit()
Message-ID: <20260616154008.0804ea70@kernel.org>
In-Reply-To: <20260616222644.41344-1-mokshpanicker.7@gmail.com>
References: <20260616222644.41344-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 22:26:44 +0000 Moksh Panicker wrote:
>  	mutex_lock(&nsim_bus_dev_list_lock);
> -	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
> +	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
>  		list_del(&nsim_bus_dev->list);
> -		nsim_bus_dev_del(nsim_bus_dev);
> -	}
>  	mutex_unlock(&nsim_bus_dev_list_lock);
> +	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
> +		nsim_bus_dev_del(nsim_bus_dev);

How could this possibly work?
-- 
pw-bot: cr
