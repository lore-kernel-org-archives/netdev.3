Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8F4854ED;
	Mon, 14 Sep 2026 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417681; cv=none; b=fCfYHp+YJFi9rp61sTODNco4XG/OCDIX3DxdEAa6ghj2JCI9uXm2KOwL4EXUgs+HNrSOjZ9oXjFhKpFdHDFgFbjLEp2KozUq+K1tYZT0dHG0ew9Po7vbkHI82OGUhxmb7rIcpGojqVwCVDJjP0HjRR1snHiAXYKAsunEM91vyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417681; c=relaxed/simple;
	bh=kvTpdTnFOY739aIKBAFWWcjGM5SdxKKWqRxWiS7RMuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eP2cG/xXQIUtd+P85I+ylWHowpRNwlk4W6CBOCDw+c2ddsMlagA4TQY41YSOozELYNDqkVcbARN5ec8xcK2GfpFXAvXh2T3Dv99S9mKZiMgj/Dc5F9BJJSyi/yP4N5pVQ0cQ/zEVXFhs3eF44xEpa1p6u5MLSwIw1SNnSBaX9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.33.248) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 14 Sep
 2026 23:27:55 +0300
Message-ID: <892d7aaa-a2c5-4303-805b-7d665bb95ba8@auroraos.dev>
Date: Mon, 14 Sep 2026 23:27:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ch9200: return error on failed register writes in
 ch9200_bind()
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Matthew Garrett <mjg59@srcf.ucam.org>, <linux-kernel@vger.kernel.org>
References: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

Hello!

   Duh, forgot to add v2 to the subject... :-/

MBR, Sergey

