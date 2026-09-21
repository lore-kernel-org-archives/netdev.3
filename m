Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3C4F473B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015686; cv=none; b=gdQ0Gu5OqDZxPYvqbUpeNlA3v770QTn9a290AfYGt/3Qh0TV8b0SL6qXV+/XFGoFLtaD6B1K+V1ZKtkq7tpIpsFndaEmKd7vYmTvnM6LzFc43Nx6LN/wCfLliAX3j4NOnCGpPjmAHmlJkJAEhQ3ghZ4lYZuDqhQ/Giuxlr4ojlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015686; c=relaxed/simple;
	bh=WTlDeh9KCnTwuNX8rOi9V6en9d56O/2r1jo4HQIpjh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deonqs8MJDG9E3isRuZX3Yt3XCBxfX54bmsemCYTc/ZkR/KuV6APLtRyzNMfqPxIuIysYzc0SsO1f4HXdV6bdjww4TvyziVIytVdmW299e4S+6v6cncUoq3KArVDiRdCSmVWyKRVyP0k7pBnZduJZOAN9Dp9bAQB1swBTA7oI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRg3t8Y+; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRg3t8Y+"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so1591170a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015684; x=1790620484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/SOrC2Mlf4mf516XX71M7S9zvKGnjamQh8+oPIrfeZw=;
        b=cRg3t8Y+eyvnkSX5yEWrnMhmmBlRcvR5+x0cHYSR3FGZefTKyEN02psDNYnwL1Hovc
         e2STSWCAR8QHBMwUFelCIEQOoD8cRVgKrvEbVVvHHva63f/tYcO5x+N5RpiwQOy14eur
         +H5KzcxCG+CKyhnNCneQu9j9s92oGMtSCC6ngEWjtYKyElKbeoiyQs8yLMyuukTDlntq
         scSN6SLdEbER+/HfGSLWDX9Uv7x2CMl9uDQ9GKXE2EDfuy2vXnIGKw6MsDAMXwxb+JdJ
         whm0V4f2CNwihywga8PSxYxoZYuk67wDOIz/C87XOCcG5QW/cDH1caRRl5Af7diqIlOY
         Srqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015684; x=1790620484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/SOrC2Mlf4mf516XX71M7S9zvKGnjamQh8+oPIrfeZw=;
        b=SvqwmXLBIZCI3uvfExrNNhm89RbkDZUtdZliKaYHMBpmn6CtF39L9VHTZmWUA+EsC1
         vKvNGFevBNjMbhBrf9G/uBfJxvvnxlYdV8bAga1HbMQx0OgtlH+VaGToejMSc67I+vzG
         a4i/7siUX6bv1iVc2ieU8TngmK4xDJwyvEndgKt3QGJ+UbTtMGaoz0QbaWjAPytMnpo4
         WYVtuYLoPqvh7mizX1OAUxt/CNzutDJhiWQVZKyn+ma3H6d3v82MykAcKoDxiSVK75hj
         oq6fgvboA8S45r1vUm+7odDfQY0kaevS0/QlY+U2gPsm7iJuXtvFGJUQNDFNQK+kLN2Y
         AS/w==
X-Forwarded-Encrypted: i=1; AKwUvBwU7Qmpq2u21fiuRD/SxfRe3H3wkLtEr0JBNCOMOxeybpMoh1F17xX3ZIMBJ1F5QRZOrdypvKs=@vger.kernel.org
X-Gm-Message-State: AFuF++k3zw4iGugm10vmVfT1KjI0WfAvsf+nd7yy2R2mhNRXUFjlFkRM
	SAX+eZ9WRnmad6XOBBzAdjB42o1cSc+Hq9YLPXjlrSALmYHGgTL7etwXVXIppj9e
X-Gm-Gg: AYBFou0sL7HYIUw3IMNNrswY+W/sQb5XjUTIF2dC4CtcVl6Ywusoi8aOYeRpdp7oZSH
	un559JMB9tZC5fGzS0yNH4X1LqXlRzzQsynNerPrixgzAfi4O6U1PvSqalC3jpwmJiTp5hUkAE/
	Ii7AHVjZbJ13xE1j3SCIxSP2Npms/DxukJBCG83RpTfqNzGelzhV/BTG9k3cAMo4dPXN5RfK/6r
	XkVq/rKiJvv8D3Wm+I7uSldgC/yqCwsVQHV9kT30x0pfs+FlN+lJLZ1vJqdgPwFqg9UBUS5Pgdh
	AeoY8gxEFQXkuU2KYGKBi5WxuqMPzxh50pns5HQC480kURe3zuRJStB2PgiXka4pL10X5wTppTw
	WikrAg0flf16cRTc5NtUHwiePOkFbV2BlLipXpTnqoIHVk8u7GoNk53TD6ZaS82wwqQoIzJnjf9
	GqbWgZ8Yz5rJZeBnrsLyogcXU2kXiTZCEF8EgyGMuvydBvTnuooFyF6BNyqtSJbLE=
X-Received: by 2002:a17:90a:d005:b0:39d:ba21:fd90 with SMTP id 98e67ed59e1d1-39e54f2bf77mr24473373a91.16.1790015684488;
        Mon, 21 Sep 2026 11:34:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06741d485sm563899a91.8.2026.09.21.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:34:44 -0700 (PDT)
Date: Mon, 21 Sep 2026 11:34:40 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Dairui Zhang <zhangdairui@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei <dw@davidwei.uk>
Subject: Re: [BUG] net: devmem: NETDEV_CMD_BIND_TX has no permission check
 and no accounting
Message-ID: <arF4n8rQtVzxy0da@devvm7509.cco0.facebook.com>
References: <20260920174727.1332115-1-zhangdairui@gmail.com>
 <20260921180715.1411780-1-zhangdairui@gmail.com>
 <CAHS8izOM-Mjh_s=0K=8rDdvDdwORCsNMiKf7eoir97i95DkqEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izOM-Mjh_s=0K=8rDdvDdwORCsNMiKf7eoir97i95DkqEg@mail.gmail.com>

On 09/21, Mina Almasry wrote:
> Sorry that was a typo. bind-tx is meant to be UNprivileged.  It's by
> design. We need to add a comment so people stop suggesting this.

I was gonna do it, but looks like you volunteered yourself? We do get this
almost every day now:

https://lore.kernel.org/netdev/20260918150858.3c98728d@kernel.org/
