Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719038A29D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048283; cv=none; b=G6RQUvmyNaUHQLH8XnwaGvhALWjgg4hueUVYfkhyMmHsrvV/XMsfv14LY2ywrhrN6I4wkQPNBZnmBs1Hyf5VRMRj78+yeQMlSaEb35xolrTlIireLyd1KHfiEmVxlG/qKul0DogdHNOEPVPcxBCuii4tv15ymj+2VknzmbGaxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048283; c=relaxed/simple;
	bh=ZtanzfqVjtLAhTMrV/tEbA2ea3TCcc3tEkMuB+uFvC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrMUNq6BYsVaLWG3w0wsj0pnhrMzrnms3iVBPbUXrgxXu/SyhrxKqv+q+P0lWV8uq8/beRj9NjgjqO+w7JS3WqX+473jEK1CL9Xjq5h/NTH13X6T0Cz79/U4dcma4O1pxbk+DPIuF2wH7lTFuBUB+aiNzvAn1rYoIGA//vtPasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxWeETgf; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxWeETgf"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b7070acfdcso510682eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769048281; x=1769653081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw/DgZzvLJTE04Xi6WXYLsL13zpRb3IL+pq9d6F+PXg=;
        b=TxWeETgfn3Pq0p2zTktP+XCQdViHJ8agK3/MAwv8E1UF71OecBlqj33Nb/YOGViuH3
         d4ee3sYMRSSDph3dPf1H9TnTQWbkyWuwj1gDfpJK7labF/n/6gUZdCIiLq40e22N15OR
         BTrLgJfvof1TGy//kF14OO1c50moypBmpx7V+6ojr7J31usImqkT0cX2RVWMlYt7UAn6
         EbIInnvvPcd3G3uQlPt2mSueLY/+6/SvgCpCHnCAQfPF1m9NcGpIWBmHgIsMeqIuypiL
         w19tBxABetNQ6yBMFitjDN5LDZimXGXIRnlPqs8+/01CpCrgRX3ufXM4oZNeGSFRgAh7
         3Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769048281; x=1769653081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dw/DgZzvLJTE04Xi6WXYLsL13zpRb3IL+pq9d6F+PXg=;
        b=W4EFDcpUcvCWddq7Rm3nwkYrGquGDFmQ0NNsgc7vHqINR5ufXQS0HPldJdZEhWs/A/
         dPrKykCzXkKSaogozfQtkZVElr9PdY0HkEOQCO9CKf4lnhIbUjDjB5p7hRACI9BaalR0
         KMkGr8mvB72/U+hSld/0Pyd2vYHNLKvUVTaEm52Rh6A7temeoOAx61LKbauIowL6z+/s
         X8ZXF/LbrOCI49xVEgFLIBJc+CPTgI//6jaiTNlT4TjjUpg3BmEogkCdfhf0NbC6kCCr
         YOHL52gndfwuN3X9qZ27jWn3vaYlruObNo8oys7Q6phCumNUi0LSjfpB4GOID4cKWjbp
         uEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQtkuquALfXnnOXkZb+HBGaclUvp84A+NDha+MXu4eklbbhYyNb0N+Mu3i2YiWkhQP09YyhIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsQqNsc7aPHL8Vb2KTeQqozeGZSggCWxo9Pui2cfA5xOy0ug0
	rHpdxiapeXZ1yi48n8ZatJP7EBUUipmInzYe6CrXwcwDC0OM9CQB7+sK
X-Gm-Gg: AZuq6aKufN2wiuKTAJVQVNTZWo8KMNFv6gRcmwJqWKach9BnPXc8dHoexlyaeVE9mpl
	UU+YywfA83fKa5OQlClHblJQmZq2WorIA3YLksPpIAoqDr3/4spB/7sQgUsI8t4k4dNJe6QS+Dg
	2VN7Tu+WjiedvWCxi0yc9KtPmSKw6vO642DalCcHPNpODBv9f/9ZLNQO3NMWged0YKFUWr96Nk+
	dvFNGHAzKXSsbgTkTv24926syhsIo9hRb7wlMN9PBXlGEkTB8z4ZBp2NxODXyYn5L0vZ4rsZp5S
	o2andc/477P7KHtFov9dYPV0PulXZ7ZcXh7j6idKjrAn/ZWqjx/k+z4M1An7HkV1tez2ZMVZVfO
	GDbp7iblbzoYW+pIU1tzT62EeTy9ZIVBbPGit5UE9DSHlgRmVn1Bnn/tKPFh7BtqP3ohdA4o8Go
	GWflE=
X-Received: by 2002:a05:7300:549:b0:2af:7f2:50b3 with SMTP id 5a478bee46e88-2b6b46c6835mr14542939eec.5.1769048281251;
        Wed, 21 Jan 2026 18:18:01 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11c4sm23694514eec.1.2026.01.21.18.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:18:00 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: realwujing@gmail.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	jis1@chinatelecom.cn,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liyi1@chinatelecom.cn,
	mhocko@suse.com,
	netdev@vger.kernel.org,
	rppt@kernel.org,
	sunshx@chinatelecom.cn,
	surenb@google.com,
	vbabka@suse.cz,
	wangh13@chinatelecom.cn,
	weixugc@google.com,
	willy@infradead.org,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	zhangzq20@chinatelecom.cn,
	ziy@nvidia.com
Subject: Re: [PATCH] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Wed, 21 Jan 2026 21:17:53 -0500
Message-ID: <20260122021753.234007-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122020035.227449-1-realwujing@gmail.com>
References: <20260122020035.227449-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please ignore this patch. I realized that I forgot to label the
subject as v6, and I also forgot to rebase properly, so the changes
from v5 were not correctly merged into this version. 

I will rebase and send a proper v6 shortly. Sorry for the noise.

Best regards,
Qiliang Yuan
