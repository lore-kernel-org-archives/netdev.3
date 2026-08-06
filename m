Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44409362153
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023953; cv=none; b=Sh9y4z6+VcackF4/dyrup4EYszYqeZrt+p+QCrCdLSOKrRHg41vkwCrrM35nVCdrQAU6HnQKheifbJb57JfraLUdWO/BoBz7a6BDsInpAJVvPVLyaSnEyO/QJORASCLQmuEZc+IXm63JHJGIfp4DNBKD4mco9RmgyVepbAqnbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023953; c=relaxed/simple;
	bh=eXG9+d0QTdXuqwsvir1qBXW9xM3RqmfVwE2KRsjrgjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMHVr5oe8GASkjUcZ5N3UAvw0Sabjd7fzsnQ2aFylPTjxUhKKS3ZwdvNxv4sNxgfY2HSlZZEN/uUqSsfYl5ENJLXP8YiOSREAT4W7eI5RX0e33jRLTCeQhoV/6YCgkM3K8PjZ9UponK1Q7sZIrH6XYmzLwD9JSGazMM1A+wwiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXpd9oZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXpd9oZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6A81F000E9;
	Thu,  6 Aug 2026 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023951;
	bh=4z8D8FeiERl/7Szs3iFLO4L8OjK7MBDgwq9J9HcJYew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YXpd9oZRVNvjPRKDT6YOCKIuixUhbH1egF6/aLj7VxFCXPSbzJAcTS67DSd731qiD
	 HH0D/ilTAJm5UUpsQLdJmPzF5jh1urSTOZvnGOD31r6Yw7AtOlVxvGumHX8XmNFQJA
	 1qInzw6q6ufKqCcED7rx0YJ+oGeDz72eUmUqvMNrgQ/a1QIWSpg1NpH3vFwGZ5HOLx
	 BpI0iingVIqqN8yyM4faAYaPvM6sEnYLqJfb5H9vZY26a4H8zPih59FkKZprmqAoHq
	 8HNfLlUU9svZFEjRMkZlpjmcNLdVI7yvn9OdDSEttGFnJXSaayPmnYS4SF1syyQs0A
	 fazsqupiimlKQ==
Date: Thu, 6 Aug 2026 06:45:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 00/11] neighbour: Namespacify arp_tbl and
 nd_tbl.
Message-ID: <20260806064550.7efe9df1@kernel.org>
In-Reply-To: <20260806011152.1170012-1-kuniyu@google.com>
References: <20260806011152.1170012-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 01:11:22 +0000 Kuniyuki Iwashima wrote:
> However, the control paths are serialised by the global
> per-table lock.
> 
> This series converts arp_tbl and nd_tbl to per-netns table.
> 
> Patch 1 ~ 2 are misc cleanup.
> 
> Patch 3 ~ 6 store arp_tbl/nd_tbl to net->neigh_tables[] and
> remove the global neigh_tables[].
> 
> Patch 7 ~ 8 replaces the direct access to arp_tbl/nd_tbl to
> net->neigh_tables[] using new helpers.
> 
> Patch 9 ~ 10 finally replaces the global table with per-netns
> table.
> 
> Patch 11 cleans up unnecessary net_eq().
> 
> Note that some buggy drivers access nd_tbl without checking
> disable_ipv6_mod, so nd_tbl's extern definition is still left.

Hi!

Looks like test_neigh.sh is failing with this
