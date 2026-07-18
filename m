Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC13242DF
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784353620; cv=pass; b=iwhN4kgbsz2O3DhXziPSpRpF39fhmWUZnUFFsBCJZVL3RYJTdaUqsOibPb8BChqtbdXVfYKZqWylSFWp3ANnD+Qveh/4TD99j2Di2WUhZHU8y7NiTIFANbMVQ6pd4d5Gbh7+0is3WwocUxwN7Mc9XzVyZ/Xgl0YlZyEb9okLTMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784353620; c=relaxed/simple;
	bh=qrVuOsG+zDRuctc5eZxmdxByA1v+4MUDv8jQDurUMNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOvwjgvhpT/nVZKxen3+iCR55DPfctW5uZRGvPUzbGwvR8ejD3l5JJR2ZxHkDxRFBJLbIUEUot+d8z0ttmvYTPb31UnhWmW+SyUwR802AWiNpWyeuCgPe2khAGAsVGNL25qH7s8vSpmHKxR+M8l13v/ETPQ306pmgXC1iyPkXSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crvw/l7O; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crvw/l7O"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso13758334a12.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784353617; cv=none;
        d=google.com; s=arc-20260327;
        b=c0orcow79OMHobveHD3zz0OzRIWXXZpYDVkwJvrutCyspIDKIiWMwZ2rGeZb6vesas
         jJwMu/89BXnDHCpkYj2+i1kNtDqthcOqLp8w0THdiRVfpE7j7lwpGnUszxssuuTrPwnX
         1nGdLNyNBcX4sPrhqwt5bbLI1cEU20R3OfV9fsk2fWsDVd0puyraD8E1rACxay77XmX7
         y+jry9zy78e76rG5e3kZ1gbsOjGimDZpa0qj912TASPGE+NIHEpQC2GFCA4bA1OLsJpX
         Ae2tiBosiUFQHd2Hq/Lj/sKKyXAzXxZPGzm0jK48NKzA4BfbD3b+vgoN/4ihD0d2VwST
         rY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WJ3qYjjP+Cksc8LeJA11fsfVzLmKBHvIgR/F4SdSPJc=;
        fh=AVU5qrrCPm3vhBz+X+jSoHyulTdYE3LWWcrR8m0l9ZI=;
        b=II6R29p8oOQl+vF8o4QlcX80SulpHfXejX3GO+BF6qcphbJ4IxikVL+Es17/iu5jEh
         4EXW+HyYPX9DiBlSU6REGKK6/ZJ1XATvxHNuV0rCqvDGMzOjawVDBq3z4cNe/pf2Af4C
         inqIIGslKXr5qtxQGfDt+q7keM/Xp/RtviE0SbMZ/IPnFhp/ruUZoSi4XMYjdtvSNwVz
         36FAtVwU0aTSn91VtTMW9VexE2kHhSOgKIjIzbIGMcu0kbwszIsx8CFfwVpmbu5TNwtA
         DyDqmuDHSQFbHI5C+GvtJidEdfFMEudm2hQVpZgUt/wlo2nyP3a4Q72rgkDfUxdVykoh
         R2Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784353617; x=1784958417; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJ3qYjjP+Cksc8LeJA11fsfVzLmKBHvIgR/F4SdSPJc=;
        b=crvw/l7O/LCkOcUpog2MZluZhIDFT/zAgkSAwduLj/8qbCDPqYaSLBRjPOWUJoZzKE
         /RAd3dvnSPvAm3u0u2EzJzSLwmiHZa32yg+uEV7kRGUguLRDlbKMcBHpmnNAxodLWWjJ
         wRBMaIfd0tl35eMFm1v4OxEGSsJ7gqjDwlqd7VxIsy+isTRvEE8o15aJNqYgWF5a8FEU
         dy9Al0F4utDORD6UuN76pc4+XB09WrdU8SDQ4lnCVZHHbPbelgfCFIt3Bgj5P8hcaGR1
         d0HdOXS18GMj7iEQttzkIZBX6w8Qi/iZt17MXUsWDqAXWkO9LcepNYTydjqENAJSXudj
         231w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784353617; x=1784958417;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WJ3qYjjP+Cksc8LeJA11fsfVzLmKBHvIgR/F4SdSPJc=;
        b=hPItqWybbrh1twMDnEx5Vcw477IPGBuYg9DKk7/ZTYe2a7o1AVDnZJ1H6WVQ1MeH2x
         RX1wNk+XGVBB8F5wAzBVegdKi4JkZ860fOBUgLulqUZpUr+QOlcBasIz58D3/TgHoH3T
         e6EK/kX+K7MK8iFXO9GRAnDKSfchG1hKOR6CuDgzSWFM7byAOVjQFuImK8FyhsQ9N8XB
         4RF8ETo8Ms+2FKiqupyNjBt0oMSNYGbdRTR0TQvb99lXnPDb9fNjH5Gpzsy+gW5NXehg
         E0JYFVDzDbsMZ7ynhAxsPMn7XUjZ33cdA0jzs4Uo/aBC/Jw6de7yBV6kO1nKG9F9E7Ax
         gXcw==
X-Forwarded-Encrypted: i=1; AHgh+RqIiAsLgpClkUnggRXOg/MUNy4T51ejst4vdt50zReKHZZLrM4Z2auf6UpE/WOE/EvsjPa7YKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztecuE1J+LKxPV+r5n6XREbpeBKBtk/DPOMsPUoTO6KwEIlPnK
	DRgzD3NxNVsMdL3YNILLHfXvfp3D+oXVl/oM/y8bYp/F7UHe695rIFcGRufkdnXQEmYyVtlJgmr
	wS+CresKKckzpp5IiGXIA7jniTkAO6lztv+/Vqig=
X-Gm-Gg: AfdE7cmaxcCBu4zM3g1un/YdH9nUj/IgF9B0qc9WPo57NRDoLLdF6fGHTkKAJ3QGobN
	Ue39TCB3pfhl+L5upinlyUBYhmqQAK1clAXeXyLAsxb29fUA+8OFPG8D/5A92u3K5qaMCSOarBr
	dIhiD+4zQEM1PF5na75W6MBiunkGPy5y8VPQejb4dqflZLf8nDhlpaXQCmzUyJBp3Od37kwMXtN
	ga01QDcfRG2dkJ8F3b3ITcC82nil8iiEpszDQYNEewywTV2N3nDHd7LVbIZSD0pfUW2Yq9mw//T
	PWBmqLgQkrlP5u+M5FehbPnP57LCVA==
X-Received: by 2002:a17:907:25cb:b0:c16:209f:6db5 with SMTP id
 a640c23a62f3a-c16b46b5c24mr250620166b.27.1784353617174; Fri, 17 Jul 2026
 22:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
 <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev> <7b164d90-b57f-4746-8b7f-b5bb7fd7fe51@yahoo.com>
 <03309c370652c5ca36cf9972756efa5c@c127.dev>
In-Reply-To: <03309c370652c5ca36cf9972756efa5c@c127.dev>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 18 Jul 2026 02:46:44 -0300
X-Gm-Features: AUfX_myZhPcQXtSamWEiE1RlWdPVn1dlRsu4xiyVC5gfoDnBmDWHr0Js2PCYg4U
Message-ID: <CAJq09z4Ts3-UX-0h04gk7vpZOxmNneE566FThx=904NLMdpibA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, linusw@kernel.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, kuncy7@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The only model that could use (H)SGMII in a different interface is
RTL8370MB. However, that ASIC and RTL8310SR might need even more
changes in the driver. For now, the code looks good.

Reviewed-by:  Luiz Angelo Daros de Luca <luizluca@gmail.com>
