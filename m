Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044721A8F97
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504132; cv=none; b=uxMrMseRPRPl2W2p3aLBttYeQDD5DNlOE4rWoqNU605tnAVrMryHnsvmupj7OYSDY/T6GdKgSSip+gkFnu9CfeVKrUJzUSEEvdtpjgUynx5kyhzu5IcbQoWd9qJiHVXnOndToq+OPwVOKHvH0PTjWLlU0hjH9YkBI3OSAxzPKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504132; c=relaxed/simple;
	bh=Smcm86Ij1wsWitZt1z9fSB9bWtP35J/tCMhsdyLFYDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J212A1hzEHyu0niCH5G+t74rziZj7nMZAca3jl7lqoxMCYC95y8FMtQpHfB4vQrlDihhLmyB6ucRhFdHy6ZUuH+RJHF+j/3boBa4tuAt6RpnUne68U4BoznxcMaV8kLrjYxkerJEB3eYaOsCmwCdLjHWAfnCjjFnmDTU1+E8wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7Z+BVyB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7Z+BVyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5280BC2BC86;
	Sat, 14 Mar 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504131;
	bh=Smcm86Ij1wsWitZt1z9fSB9bWtP35J/tCMhsdyLFYDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7Z+BVyB9shwymR5Y++VcuaD03uITEu/0nRBYKOGXX/8FzxvwhFrYIz6TOAjflTxF
	 v8Ot8Al8joDc3MJVkK/B0Pn2YJs+vMC09xA7r5Vvl199uu3x9Gye6Zr2NutHX5j/wT
	 eS7wUUVkUuz+6ndeecq7vFtOTCpW8xJAS8XcVrbgBUkAFS5/K5r8EyWYSOOzz+ka41
	 w17Jx17rgsookS3pw9qnIgHprbPmqJgVJkuEt3NRj1cyTTUPSIYyzRBBoe+U/9qisQ
	 AJu8UYiWG9x5x/4HAjj9ruISs6Z3RhAFk0aQCYdtkd7A8thcbahcmaO1iNCappXd7T
	 Uhz9hdvF/y8sA==
Date: Sat, 14 Mar 2026 09:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] netdevsim: move TC offload code to a
 dedicated file
Message-ID: <20260314090210.0b7260d4@kernel.org>
In-Reply-To: <b9c3cab13359044df5e8fe52f47c09cf37754e92.1773411667.git.dcaratti@redhat.com>
References: <cover.1773411667.git.dcaratti@redhat.com>
	<b9c3cab13359044df5e8fe52f47c09cf37754e92.1773411667.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 18:23:56 +0100 Davide Caratti wrote:
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index f767fc8a7505..fdd35ab29d98 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -470,3 +470,6 @@ struct nsim_bus_dev {
>  
>  int nsim_bus_init(void);
>  void nsim_bus_exit(void);
> +
> +int nsim_setup_tc(struct net_device *dev, enum tc_setup_type type,
> +		  void *type_data);

Put this above struct nsim_bus_dev please
