Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A462D7DC6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809962; cv=none; b=L0rMKVS4tU2A2qxOcFWR8muuuMYlzSKqLFJXUaOKYxoP3vf0jTQHBWRRar0y0VvufbHeVrJmmlM+sDrC7VxqPLcQDmOJ9Fv9SKp898xKhmsz09LRXY4mtDH5QzmC6YtbYv0vx7av+ahV1PzJbsG/Swfo5xCb5qavNIKP7p3uJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809962; c=relaxed/simple;
	bh=P8aSIbkK2BQvZi5dWB854YLDzCXa/yW2NZ0UbGGZBgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKWLydaBFXEtCzTfLF/V/F60bqrJoFHbGkw+XX5GhxBUXH3Lq8Mg4vRuRK5g4HRotB+rJdO+e2pkj7B7rDx5nyvCQe0OntGwxEa3bZjOHuPeIq81qsKFUkTn7JW9OdCDQ2kY5K0q5LtdBfsfDwbHLrUvbOQQsGQq+p6x49Kcqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePBNMRCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePBNMRCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAC91F00A3E;
	Tue,  4 Aug 2026 02:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785809961;
	bh=P8aSIbkK2BQvZi5dWB854YLDzCXa/yW2NZ0UbGGZBgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ePBNMRCN9aRCa3M138IuZ0o6v0EqeQoHK67SqL8vU/tmFxT7PCABtfuc4JxKu2z+P
	 5qS2h5dY6zQ7y59IrbHhT39tVlt4c4nCBh0uVuCsBMCyt7V7f7QDeCYHOgna3Ph0Es
	 bWY2etAeQAZdBPk72gAcqSbm8eegO3/CuMPg9Bqo+8G8JQi6KYUrItUGLTjd7Li8gC
	 Se2JzSfrLv9PbujHRZtxsXeZOvzHz3kgqpBuz+GASjyVqSeMVaftySjnFgOxfg0VjO
	 GWJE3eIoBIywzEpEnMTbIg4kxhdPYZydNysiBSg68tCu/+Efb05Nl8ehTb1/nKspOD
	 9FwX4ZVpP6T4A==
Date: Mon, 3 Aug 2026 19:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
Message-ID: <20260803191920.0e6c5a2c@kernel.org>
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 15:39:03 +0200 Simon Wunderlich wrote:
> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.

Can you look thru the Sashiko comments here (especially Medium+
severity)?

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-11-sw@simonwunderlich.de

At a glance patch 14 does not inspire confidence. I guess patch 15
removes the worst part - but is there a real reason not to use locking?
