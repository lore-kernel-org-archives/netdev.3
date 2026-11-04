Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782081;
	b=knB309RE/ryucokV5zuboJOxaXvbSoxQna8NKm/GQeTAYPqGVjQO4MAepUie/qnZxUMf
	 8yBF1nutvp/hXTVMnPi7a1D31VbjFUAoRKtFocE1vkC2ul6wk8A/0EBjVwHqZdS9UKT+E
	 62bmkFs8J8fkQQzmwMOq+uSinhGGTMg/VMbuAe1O/HhcOAjrzAX0RZ57gm1UrGxfL//vJ
	 iKhRz6aOgFC+/NC2eiXNdb2CPjFSm+7EtVC9ocu1xZ6QDRlIGswR/Asu7ShTU6W2sum9L
	 wDoxRflNOFXdcjUoo1oA5djkCn0Bkwd7b0MsClZmFObfmH6P0Pjc23VsBYWBmsa0FAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782081;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=bKYL0tIwOuQrMDxrCyv61nKmyjjc86ptxINLaNUCb9M=;
	b=fnLKby1d1Ct/Lz7P4GNEQrkEXsnYsK5pcLU/4iMYpqDqrVKyB85bc/G1gxKezGtrHEoB
	 YBeAZrrUlhHxaiJkp2hHCkaS8ADP/ll5ZPfrPJu6MCMeAy8pSFAVgOrD6i2PUZyt2QzHd
	 hGDDUINxodyDgN0S/Dv6we/qoqkGHhIO6nRFCk1e/TxoVKsVlYBj8j9O9MtWQfMiJ2UAy
	 c4JBqNJ6IJC+6K1xQxrlWanFj6Zgrx2h4XO7UiKXKyTYUgGIETJr6BY44VypQSqqZW1fH
	 SAs2OFSrI6+hGzx4ShX0oD5bJD7kshqZyMl/2PQIepyEZZH7SBjoTspsbweJL3bNWQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCB606A32E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFCB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8490a7d6696so218180a34.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793782080; x=1794386880;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bKYL0tIwOuQrMDxrCyv61nKmyjjc86ptxINLaNUCb9M=;
        b=cIZLiP+xm/gxkcprz7OUZj1clz4OytlWZ52u8nqw9A5wo2Il3wWVmZN6ED0eOedqBp
         pXdkSZSiOActZdn28E+bci4LP2D2TM3awqoZMOanejDAT/wQEW1cgZPYYUrQFFOVi1BR
         cz4SVshAC3rl0h6SRHYA9W9FC+4wAlUn+UW/Eph3r7g0RoGPqSlfEpYvUhrH9bTurCFa
         s/M9DAJuQMmX+tqV7Ctnt6+137pOWQwLR3jfggruTazPUS++JP6zLpJD4hK9MyO6zhK3
         lZ0gCtJh5WQL+nfb8+bbjmSOwN5serJkF1cXH1Z9GwY6DU++ep8v1EdCofYplRSWxfKa
         t+yw==
X-Forwarded-Encrypted: i=1; AKwUvBxxPhV7FGhsD5jV43IEvYkevRe7i4ucbvN9bEZTn5XwmgQlP/olnZdeFt+S2+rN/ezvUC0ZlVQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S8obKjxJ8MNc0N9HQR3gih7rP8EF90RG3+gXrLMs1DqKwEtXO
	wMCciqeSQrRLPs3dLz4cCzh1aRmWsaq/L/OAlHnM4nuReWhnhAevfhPpSIF/xJW9roQ=
X-Gm-Gg: AYBFou2XjMR5ifvuDJmufvbNrFaFmIvpJP9vOp9cDhhcFUgo0H6BmiS7z3vtWVRwnMy
	3WCbJv3zL7fxy0kZnQtwmbLYTzMLwe9vMKH5V9j1QFYnIQlaVCR5sb7MedH2cBXfV0KbgyTRm1B
	GRan20jMsPeQtw76Qsboz36ysxwf19vSbtDdOSofqAkhRmExx62KvJoLfocRooNBliVlV9BhYsw
	wQxZxGGPKvNoi1I7D3tiun92e3QFjQdyB+euClWJW9mSAgqkwAO4Y1XBjIPIXG/0vJX9QlBDjji
	oqtUndOzZTB4nOEjqs9zXloZoud0qJWpByVm5PkI+oFTgfVH2J1n1Q1EzCCuTh+eKBFCtmOecuF
	pizy+ipr4oOjx9nJoBcaPi15+SaMq6M6xC6U9JjaRVXh8PKw81ME0n/ncFpyOyMT+bA4OEW6jBs
	ZgDhdK8DqQH4NA1dWyJ52kwt+yXoHRI+YWbx9fNxVkCAUTo1Afl/fSNoktfpaLzWErTm9oDaC0T
	Q50fJRzaRJk10gYGFnCXyht2RWxi7nsWFdrHmo9TqYI7gi7VQqOQlCdIaKkXsy8h8dpgtdbKNOv
	lDE6GoWat8F6nd7mJUB9otZbpZNhGVSAV22IbABqqh5eHHbdCME9wM1vVCVcnSCSjE7xpbG4LZC
	OBa6mO+d/8YVc6ocawNO9OqZJ9Bj5tSqwKP9AxPBg
X-Received: by 2002:a05:6808:1202:b0:50c:bc6f:fba8 with SMTP id 5614622812f47-5640de44ed0mr9781324b6e.65.1793782080244;
        Wed, 04 Nov 2026 00:48:00 -0800 (PST)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f400fasm1130189b6e.8.2026.11.04.00.47.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:47:59 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6dde81a6820so273905eaf.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:47:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwFlEH8RcqLmg+1VvUdCeUCD4eSx7nej0UP5vpQnlGZgVKoEB5DSrDXbjCvogFyG+lNErJkqUQ=@vger.kernel.org
X-Received: by 2002:a05:693c:6407:b0:36a:7b3c:4e0a with SMTP id
 5a478bee46e88-36a7b3c4f8dmr7297124eec.24.1793781644445; Wed, 04 Nov 2026
 00:40:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
 <20261104-sf19a2890-gmac-v1-2-a15965a49574@telaak.dev> <6e8d69e3-9404-4a80-874e-0133f942229e@bootlin.com>
In-Reply-To: <6e8d69e3-9404-4a80-874e-0133f942229e@bootlin.com>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 03:40:32 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ5RZFkQh5G0BbgC7FesQQbQ53AJQv6pYoK+YEVo8k62bA@mail.gmail.com>
X-Gm-Features: AclHuK9Odzf_wS7Gr7Do7DU0hVIY-1521pU5hfzHYwAlyguOls_NqIQeDv60H-0
Message-ID: <CAPY4CJ5RZFkQh5G0BbgC7FesQQbQ53AJQv6pYoK+YEVo8k62bA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: Add Siflower SF19A2890 glue
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chuanhong Guo <gch981213@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> This is only used during the probe sequence, you can simply pass it as
> function parameters, this avoids using up memory to store that :)

Thanks, v2 will pass the device to the delay helpers and drop the
member.
