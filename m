Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1D414437;
	Thu, 24 Sep 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271607; cv=none; b=nNrLCb/8eCgUXaJ0wXc68z1BROcEWkuhTCLERBjK9SyM4b1ZkRlfL8BM8SZa3T/Vy7mgKGmqJOnWqjQw0d8uLuJQNEQ6A+DM3c0zb9Wv3GiiQX0+x/Bezap0zef31JI3ph7DF17ZTPoo5/n0489Bq/h/zLAbpaG7kG3l2jbtdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271607; c=relaxed/simple;
	bh=GKlZUV39R11ixA8EVgRbYrXg7lRrMUB8Ly61YkIVIJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=le217KQ3riPHaMKKsk3tLthPJpCfw23hGSMRtrRsPFa53e5+H7uVFKTQddGzgbua0fRjjrgsQOVvEGLXGdnIeSu5xvIBLXlOky6JuGbi9k00MKqtn00XuGuji/jVghZiiwgauu6jqyluUuZ5dLrqqoKIdrXsW9Pxz2YP+GUje4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibx0T0aZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibx0T0aZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65431F000FF;
	Thu, 24 Sep 2026 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271606;
	bh=GKlZUV39R11ixA8EVgRbYrXg7lRrMUB8Ly61YkIVIJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ibx0T0aZjk66ETyMi9GnlXL3eDWHpgZ921Kj/xWmEFtNXn+I3FHkt3h6gzbmMipxW
	 yi/qhKxiYSw4rrR6BaNXd2y9Pb1q/l2C90P6ESqo5Syh19CgyAb02kMTOPQKnvhVcP
	 /OO0YyIZHNuEDAatsiJmU7xnApt7McQa+aG6i7al3wZ7o+fMJexl+ugK/sKEAJyGzA
	 NBDAA6lldXq8gqsQqFsp4Sr1RsaT53RRMlddEK0O0q8QAx9vX5A6QdKI3JAAJMg1Kb
	 Q/e3FoLAFK5FaKkSDxjoyWgnoxpOKJs4FjTL1T9PREfN+GbVJnO7ReJF5qYrnIDZ2a
	 3e5tZOfjo7+zw==
Date: Thu, 24 Sep 2026 10:40:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: pass devlink switch id and
 cache representor map
Message-ID: <20260924104005.4f4293a0@kernel.org>
In-Reply-To: <20260923045826.1774338-1-rkannoth@marvell.com>
References: <20260923045826.1774338-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 10:28:26 +0530 Ratheesh Kannoth wrote:
> Extend MBOX_MSG_ESW_CFG with the representor devlink switch_id and
> store it in the AF. Build rep2pfvf_map once on GET_REP_CNT, always
> refresh rep_pcifunc, and protect map access with rsrc_lock. Reset the
> cache on eswitch disable and representor FLR. Add rvu_sw_port_id()
> and share the representor index lookup with rvu_rep_get_vlan_id().

I understand you may not have LLM access but posting patches which do
not build is too much. Seriously, get it together or we'll send you
on forced time off :/
