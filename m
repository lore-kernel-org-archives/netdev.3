Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3263E2771
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430726; cv=none; b=rAlE5jq0jF2rkbJ1Hd5FpIqfhqxT7eDfluYInmTXFANNfW4AYqpL/nw84JNRHpyEN2iXrRHOHwuwpOVDE7CNi1ZpD8k0hwD/4JnAR0vOz6SepOZd57aO8VSIhiQnuXccHDrVmW8Pfh6Atk6M9zqILo9QZD/WDrI4diN1AxdkQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430726; c=relaxed/simple;
	bh=8kmCzMqYsy1gFckNG7kyIjqm4GckpFiUDwQuuvR8SbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwepF310lWcXXZ8ou0RQtTv2u+Krsv+hSON9Vvae1gdHHd1Tf8sPvjNmOy9hju3u7X6pS8rcPht2tRlIMkQjqlL+y0WYAR7NNgA/Ew4r8fD0Xc2ngqhiBV0xelUtD9byrBS0vaf/6CED4onkj985IbsG3PzQqHyjQwrHaG3kD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOv/2T3U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOv/2T3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E77C19421;
	Fri, 13 Mar 2026 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773430725;
	bh=8kmCzMqYsy1gFckNG7kyIjqm4GckpFiUDwQuuvR8SbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sOv/2T3UfkRsOuoWI/j8+MTDiQc1DOHxTdV4ZbdGC2rt5HDRu0j+CXqOGsFXNBRO1
	 +r0SgIVq16fR1s8s8rHL/muWW35KhDtQlrmQqedHGQzTOzUofQdAp1bhiQplAsmFnG
	 Y3GGYtBuxr8ckRobg8woM28E+3XwI5lVb39aIyaGsCAVFGR/B+gjfVry1R5rlN7FAD
	 3syauTzg469A6ZTPfOv7lw/v14QlCd+ghC2ssyh20PNbMktoo4ababYRIv5GAqw53l
	 CLMIYXBiX/g8IXABnzcZ2sxLtMxizNs5CmKSPAi0zjypf+GdOAk/RoBh9UGbQBm5Bh
	 5yiMIqsx+oqBg==
Date: Fri, 13 Mar 2026 12:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 00/11] net: sleepable ndo_set_rx_mode
Message-ID: <20260313123844.4a3a6c13@kernel.org>
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 07:51:02 -0700 Stanislav Fomichev wrote:
> This series adds a new ndo_set_rx_mode_async callback that enables
> drivers to handle address list updates in a sleepable context. The
> current ndo_set_rx_mode is called under the netif_addr_lock spinlock
> with BHs disabled, which prevents drivers from sleeping. This is
> problematic for ops-locked drivers that need to sleep.

missing TEAM from net/config

dev_addr_lists failed:
# selftests: drivers/net/team: dev_addr_lists.sh
# This program is not intended to be run as root.
# TEST: team cleanup mode lacp                                        [FAIL]
# macvlan unicast address not found on a slave
https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding/results/557081/16-dev-addr-lists-sh

Also something fails in TDC but IDK who's to blame for that.
Too many buggy things posted at once.
