Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543823;
	b=HazysiWkY0FZimhRq9y9emk41Sf3irnMXFAercsCiui6K8+OvN6C9Z0z/iKjzrMvDeU7
	 3QgCBc31qQ888sjb+IDpfzG8AhGvotZ6ukwP3BlvP0hfWxTuhduabBWcMCIbK7WY3QajN
	 RIC5EuaJzR1rr7U52zwIcTZcUOcLF/MinwcFd/3qS+MFLZDS+ZKakGWlGbLf2uk1dJ63c
	 ud6MTYhMqsNon9l09qSKav+iGnp3fWlIajtBaKHvlrL98wF/69L5FL6SRUxfL6ScLLGVl
	 KRLWfceQ6leaWIoBymPYpX6qEJh8ENe1OhSzsBqxQoVB2zMYRUw2OlLvWH/NLpq+92A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yMHE95pUPP/EOIjcXoAF0R036TFogng0aJVMQGZcU1E=;
	b=qIV9/PHXDmkRn+Fa42WU4V3c5YG1o55nb2ZcbgVXWxTmUz2A7ae3Lo8j9ax4FKiDxN+A
	 Ww9UBuHHc8EKLWZ2Ielo9G71lJ5qvXncEqfNB9yW/2iIgQ1J20YqnQaDk1E08ohcHckZK
	 43lNkGqGBZ302EWQLkB5oDBRV89QuRO4ipc5LC1FQohvtiA5Jzww3Mxj+puvoBkd5Xokb
	 QQjIkEetImW92sbGi2lkDTDW6WeGb7uXLwT2F7VP4eip3YWvkXkIJUIhEMR+cAH9gOSLs
	 zLFFe+jteDnoc8/84V8z88DaFBknKgOiKvsrKs1WiWfxUaNnSzC1crJf8zGT+fdc+PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VybohiVC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F1606A319;
	Wed, 21 Oct 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VybohiVC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCAE1F000C9;
	Wed, 21 Oct 2026 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543822;
	bh=yMHE95pUPP/EOIjcXoAF0R036TFogng0aJVMQGZcU1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VybohiVCeC/7XX4TL7VajDp/bJcxARoyWxLyFQtX1/8ZB8MDoi0mQ/xwXIgksjJfs
	 hMC/tLwP2mtLS9WeDrIWUKU8PPcZUexX1gR2HNRI6Uh9/MXEM0oPOf0jcGN8PmmkLj
	 bNwcut7IH4IwuchlmQx4GSPfgJC2ThlZMczeysP92NUAoslWENJO2UBB/H4Jf6ZuXz
	 R9WFNWbwShm33OpdCzBS9p22ItnBOXCRsOlkSEgHcaGdMpQjJX+G5vXmSJd13wg98D
	 y81OKxsZy7n6FaMjf0rSXZ+EL3zCmZWGLtvWcRhNAbRyd3U06PN+yH8NoyQdT6g/i/
	 bcXQAjBMkaxeQ==
Date: Tue, 20 Oct 2026 17:50:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>
Subject: Re: [PATCH net-next v15 1/2] hinic3: Add ethtool statistic ops
 part1
Message-ID: <20261020175021.4989ee8d@kernel.org>
In-Reply-To: <2b4a6fad842e0a2ea6c5ab7555916f970b78b599.1792053295.git.gongfan1@huawei.com>
References: <cover.1792053295.git.gongfan1@huawei.com>
	<2b4a6fad842e0a2ea6c5ab7555916f970b78b599.1792053295.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 17:55:43 +0800 Fan Gong wrote:
> +	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),
> +	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),

Isn't the 1519_max_good just the last RMON histogram bucket?

> +static struct hinic3_stats hinic3_tx_queue_stats[] = {
> +	HINIC3_TXQ_STAT(gso_packets),

Isn't this the standard lso/tso counter from queue stats?
