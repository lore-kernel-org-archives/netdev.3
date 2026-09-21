Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7093FD12A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020758; cv=none; b=H7Af/HoaX5rXiCq3q1/99xjdiGqIbKxrpglEr5+H7ynr/v/e/ATne4JQA8594o3cgv/gKlcrDBlWQwaSe+wUF2iBwyRYWvXXaM6eXDek7404Q+YXPZ6wjEHax1/t6Cbb71aPgodQVNB+XCD36QXoJGUhAxj9dtq7n7g5kvLxbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020758; c=relaxed/simple;
	bh=cA6Vcc5T6H9br1qlXldbsPGS4XyiAGI4aAWsUaajofA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adHYMM+2EMGZfzHELlgN+5Z2zsjmsiZMuItyHTbgOehphQdlJlFoKHGPL0wxo1lYDyrLDxZL5JXidIu4YGdzwpwAXEAOGwkbQ8oAVXL7HNJ5ZkEhdwJOmIzt5Au95S7lPwkvHTGstif6Gj1MN2WtitSv+6KkyElpOfBf2FPYyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGwy9m28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGwy9m28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F431F000FF;
	Mon, 21 Sep 2026 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020757;
	bh=Uac+/cz7eI2CQK2Ys1RkHHgYlWkL6fPEEtVc6zmus8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WGwy9m28uDnmHaEdxYAA8hMXEnVf1LhXFmcIHKNCC2A9H3aAyndg1jleuPUYWq7MY
	 AopFI20YXzSm3hk4diDSQKfPh5p24q/ZB11iztAyWwO8ww5gSinK24ocRoVdvjQZ2G
	 ZCAACQBYQjfjbkUfWm17ZpZR4dZiTjE08CqiYqeiU/Nr9V6NyTQZMZz5QeljHEdpwI
	 uRcecHPHCDdZomNDQY3tNI6O/jMQ67K/fQ99nlgn7duLauRI8WZitf2kZBlYn8C9EV
	 oyXu9p6KWQ1LTfRojg9eZ/F3zMHHnIGBhnhMeq0SBke+PvQkhdft9gIFgz0nGngRLI
	 2+5pBqkHwO4qA==
Date: Mon, 21 Sep 2026 12:59:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/5] net: ethtool: generate RSS keys that
 spread flows over all queues
Message-ID: <20260921125916.56821319@kernel.org>
In-Reply-To: <20260921183758.1812310-3-edumazet@google.com>
References: <20260921183758.1812310-1-edumazet@google.com>
	<20260921183758.1812310-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 18:37:55 +0000 Eric Dumazet wrote:
>  net/ethtool/ioctl.c                  | 172 ++++++++++++++++++++++++++-

nit: perhaps we can move this to common.c or rss.c ?
