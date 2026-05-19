Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C848C8BD;
	Tue, 19 May 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200867; cv=none; b=CmkY//bCnuByoFjTliloWEHsSuPTS2g70WtVrGAsnu3uOLAbgXZzwGnvZ9zcGoprHTO8HTVZ3XZR//DgmAnBGO0kGRXtw6YwTI8lZwvom44k9hSy7NnKW2/k2b7ZxHXP7lUbEqCWUB5wfOgvwzYzVyux2hQKJeOv/gp0vCIfkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200867; c=relaxed/simple;
	bh=q8b4RwkzMeJaV1lZdddM80k+XKzaQedUTwKrv8e1G60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckhi5QRxnjwkJ8+IgeDWj59M9XmVLmS3flAWqpfgi4iNUyv+zEIzYnImx7OdZzMTnbYHWFfYfrVYz5XxF+DRefjMimIP04sEeliomqSxngF1ZULXFERXlw9MOre9yQHLzOfCGDPTFcJ5ZfL/y7Gn4bdf19PCQWPBSd56nkymrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=duQ+CwS6; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="duQ+CwS6"
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 64JENlNK2452103;
	Tue, 19 May 2026 16:23:47 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 64JENlNK2452103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1779200627;
	bh=2CHS+c7T5fsbgtULTxDGRi/qFODIoTqysfEc9EnYeuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duQ+CwS6bpIbmb5+GwMma0Soklb8zR/pNj2W/SZVg5H8uict73FxJTfuj3lsFk+vQ
	 3IelXRFon7M8sL6kt9wlHTvUz396C9S1XsTcTHfb5pZhhJNaQdTPaxJmgnmINakvkK
	 ENLLBtAFSIv8Wfts4pYLMd0k04FS3keB19I+YocU=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 64JENjTZ2452102;
	Tue, 19 May 2026 16:23:45 +0200
Date: Tue, 19 May 2026 16:23:45 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop obsolete 3C509 NETWORK DRIVER section
Message-ID: <20260519142345.GA2451985@electric-eye.fr.zoreil.com>
References: <20260519040532.277078-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519040532.277078-1-lukas.bulwahn@redhat.com>
X-Organisation: Land of Sunshine Inc.

Lukas Bulwahn <lbulwahn@redhat.com> :
[...]
> Commit 91f3a27ae9f66 ("drivers: net: 3com: 3c509: Remove this driver")
> removes the 3c509 network driver, but misses to also remove the MAINTAINERS
> section 3C509 NETWORK DRIVER.
> 
> Simply drop the obsolete 3C509 NETWORK DRIVER section.

Actually, the maintainer section was recently added.

See:
https://lore.kernel.org/netdev/alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk/

-- 
Ueimor
