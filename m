Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E437B3F7
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341043; cv=none; b=BaGZzC/4VMZSSqntRzx+kuP5PoWgMlb6fnbxsElo1ryUgptczisev3wJT42C+q1QriktWQKS+6h2QG/rKePTecsWSG6two+T8EXor/Cgy4OL6N3twvUGgPjXC6mV36hzq0nsGeKQtIDadk9M8qXNsvMuPH4ypqbsI1n1BzYvKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341043; c=relaxed/simple;
	bh=dQP+Dh7qe6ostkW1LTN8vytGcK3koLa0h3gzAN0ctS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuVDAx2V76EJoXD+FnU9ul6V4p3Pf7ed6t5vs1OrNmymW9tHmK9+liZBNfAa0ihhAtkxH4lz44QHXpDJOmOhqfpl6jGvAkZwdHs/N1bj7psOnyYAMgvmzIPUvve4MkGQlVakROQ1wMa7gJfWtUXQOIi+Dd9Bf0jwug9Dk0oijt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzrFpWV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzrFpWV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B7F1F00893;
	Mon,  1 Jun 2026 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341039;
	bh=dQP+Dh7qe6ostkW1LTN8vytGcK3koLa0h3gzAN0ctS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TzrFpWV1+qE3ZLlr1UrMlJS6KxABz/a5gK1Cb9ekAhldIqIGga32DSgcJ8CXOTS+m
	 Kw9ALTdT7jvQbf4XYtZ+Twtnyzu4NaZUvlKvBMkkSFAs52yj76nOtrMIoKK3Z9r3r2
	 H/Ks5Mj34504LkAB81DyTGIGNKDtxTua07KpEcUY1vrdcHpKPktu1gTK+r0oJIaZHQ
	 a9KPAfTNNHvwn9upDgIMDD/gTWd71pzLyvT3dMIG3xUOmqP7qHkIzRCbwtP7akFCY2
	 iyYsmr3biQagKhI1i8GAYBL0Ufn8/H3RezD1tIgx+PgQIfwC0L8KMfbNqPXXyFClwF
	 Gum2K9A4uIJow==
Date: Mon, 1 Jun 2026 12:10:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, joshwash@google.com, tariqt@nvidia.com,
 haiyangz@microsoft.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, willemb@google.com,
 ernis@linux.microsoft.com, kory.maincent@bootlin.com, danieller@nvidia.com,
 idosch@nvidia.com
Subject: Re: [PATCH net-next 13/14] net: ethtool: optionally skip rtnl_lock
 on IOCTL path
Message-ID: <20260601121038.3e33a600@kernel.org>
In-Reply-To: <ah2hvWMz70qAYmsG@devvm7509.cco0.facebook.com>
References: <20260528231637.251822-1-kuba@kernel.org>
	<20260528231637.251822-14-kuba@kernel.org>
	<ah2hvWMz70qAYmsG@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 08:17:56 -0700 Stanislav Fomichev wrote:
> GVE's gve_get_ethtool_stats (ETHTOOL_GSTATS) still has ASSERT_RTNL and
> is now reachable with only ops lock?

Good catch, thanks! I'll just delete it, we could switch it to
netdev_assert_locked() but TBH seems like a rather arbitrary
place to add such an assert in the first place.
