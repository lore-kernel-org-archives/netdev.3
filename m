Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885C363C51
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773185925; cv=none; b=T4xePy1a92JhnCyPNSW9eVtZUPlcTJu1GyCwQQCS1NTlKTjowHmql4nAnOkQzoxFDRK8Ya7+2MzMZo7+e9jlOpU9zYrTk0nEMxahiYpFDlBsEZ03RfEOxJTUL5oXBfPk09SBZwd1c81Gke2Vul3QA/Foy9GlpnRvENkUkdHZf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773185925; c=relaxed/simple;
	bh=ojiXvpP7i21cNwmHmFAHmwnvjKQ6gz9OdecP7pefKkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1HlAcTtUNRI6bnexwB0OxXfmtK2Thd7wptBKArNzVV0fAf4nQqkqOLR30VoObmQJ7wd+1hmlpLimW3s/wOJX/FxW8DHPuw4MemFOZAaMHbG89jX61m+RxgnPnqTJnpxk1RGN4OkYA3jFn2d5NTkzNKWQj4FUv+dAKRlZjDbTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj6CyWLS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj6CyWLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A99C19423;
	Tue, 10 Mar 2026 23:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773185925;
	bh=ojiXvpP7i21cNwmHmFAHmwnvjKQ6gz9OdecP7pefKkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gj6CyWLSeQKZc82mFPhnCEowzLLoZ3bd9eE1mHkqjSfHxZPUpD17JglKfTAipTPmF
	 iLtfP5zQwO67XIwtKZ+DXvrEycj/CTetpCmChUX08Im+MewEjlNPW4+wv4Hl6LEaOh
	 VsvO1KZVmgCD7NHCkQ7rFojngetpDiPaMk8YdAliIEIQ4Ezc1+dkb6goSV52eSFB1G
	 b7fio8dWxLGPEI0Qk53zvYGNGYosxh9dGWgD5V9QPfxkBNWphY39q+uazrPdsM/Vc6
	 IroM0dPBznSg0S6flOLxT5P4fhHH5PR1ovxKx/2h8JyivhgEMi4qvSr8oEBz12iOsR
	 S2EGDJ6nBF8qg==
Date: Tue, 10 Mar 2026 16:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] netdevsim: generalize taprio offload
Message-ID: <20260310163844.58f66f93@kernel.org>
In-Reply-To: <52ae15a7e42d7754487bb744c1a1718246d032ef.1773165520.git.dcaratti@redhat.com>
References: <cover.1773165520.git.dcaratti@redhat.com>
	<52ae15a7e42d7754487bb744c1a1718246d032ef.1773165520.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 19:06:29 +0100 Davide Caratti wrote:
> -static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
> -{
> -	stats->window_drops = 0;
> -	stats->tx_overruns = 0;
> -}
> +static LIST_HEAD(nsim_block_cb_list);
>  
> -static int nsim_setup_tc_taprio(struct net_device *dev,
> -				struct tc_taprio_qopt_offload *offload)
> -{
> -	int err = 0;
> -
> -	switch (offload->cmd) {
> -	case TAPRIO_CMD_REPLACE:
> -	case TAPRIO_CMD_DESTROY:
> -		break;
> -	case TAPRIO_CMD_STATS:
> -		nsim_taprio_stats(&offload->stats);
> -		break;
> -	default:
> -		err = -EOPNOTSUPP;
> -	}
> +#define QDISC_OFFLOAD_HANDLERS(X)					\
> +	X(taprio, tc_taprio_qopt_offload, cmd, TAPRIO_CMD_REPLACE,	\
> +	  TAPRIO_CMD_DESTROY, TAPRIO_CMD_STATS, stats)			\
>  
> -	return err;
> +#define QH(NAME, OL_TYPE, CMD_FLD, O_REPLACE, O_DESTROY, O_STATS, STATS_FLD) \
> +static int handle_##NAME(struct net_device *dev, struct OL_TYPE *offload) \
> +{									\
> +	switch (offload->CMD_FLD) {					\
> +	case O_REPLACE:							\
> +	case O_DESTROY:							\
> +		/* Do nothing, accept offload */			\
> +		return 0;						\
> +	case O_STATS:							\
> +		/* Zero out the requested stats block */		\
> +		memset(&offload->STATS_FLD, 0, sizeof(offload->STATS_FLD)); \
> +		return 0;						\
> +	default:							\
> +		return -EOPNOTSUPP;					\
> +	}								\
>  }
>  
> -static LIST_HEAD(nsim_block_cb_list);
> +QDISC_OFFLOAD_HANDLERS(QH)
> +#undef QH

Please just type the code in. These sort of macros are too ugly to live
in code I directly maintain, sorry.
-- 
pw-bot: cr
