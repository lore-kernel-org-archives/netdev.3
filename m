Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD84340283
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533691; cv=none; b=KzzsPqXcAOanBAp2+uxLrjZdbw9GUjS1g++FFgZcG3+Cyt7F3RVI7n7SX0vEv/85tmbqDXSXi1iKbbx3zr18OB309g4nRekU/26naGs5ZhlkGcpscRYQ29E6zziFYbakZoQupU5oUxxhzbgZ/ZTlmrpwwtvmebSotkAQrSQQTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533691; c=relaxed/simple;
	bh=P5oqMrC6nNdP5fM4mt6EQ/gEvbrHecgfqSzVQ347qfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmAHJHrRwN356X/14TFnU1xbDQ+RlE15zosNiWx9gXNzWrPp4l2xgDL0mpoqV3uyL/p5u/zLYvMxuveqp2nyhS/A1Bgj8dRWsuQQMDel02wP7nRB0g2ZZK5Q/youHF5yFKjI4Z6Juj5pST1Frh5oDOMwXOOpxfMozvUsSQGAlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cplhSKFQ; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cplhSKFQ"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1569980a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533689; x=1791138489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zCMrpMEMRaSM1k8ewmmU9TW0LZe34kGC/Qs3gXIkvW0=;
        b=cplhSKFQ+qLKMd+P64GCqhKYaPIDi9EKFyQ+hCqycgoS//7Qs0ZQDHXsR+zTUAaf8e
         XxYE95tVR3FPapyEgGS4o61BbShANeADcbl9S9QmeR+rTC5yKHeVLzXCmpvakXNTOaa0
         l4aPTFE1E6pvxqtogWTipZnD1ovf7V+qbyA6CcDubKBT/W0IJg5aKYTHUhqQILodCq0A
         saUbyDtPyepE+jYNfUglpHPF/6p/3CAm4Dwtry5Hip1K2jyWYZUQ4EhrGmhgUl1CMl0X
         9V4/PZNTJMkeXW1JSGjCJ+y5LqPyWg7C0tawpZ8LbzsdKa5D+WiMlPCRXA7f9z/mM6Kq
         s9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533689; x=1791138489;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCMrpMEMRaSM1k8ewmmU9TW0LZe34kGC/Qs3gXIkvW0=;
        b=F/KvmbBDRbfzdj+heBDgi0Rv/UNsjtXsT2rY954Ffy5ZcZJxoJ+sTe/JIr+5dhgteX
         hb9I8SY5CdaVgYhFNo9vCIoIRA5QS0Cq2B4iSFU76lZ2GZstV8MNeg4WYfRNTLFT8Yik
         jKJWlR5o2paDFZTbA7L4R8IUiTv0jwVG5pThWq6vZheUfttEQlBN6VkdEW6h4h/3v4ED
         VmwQCF9MRJi0Z7Ipe+0Xaspsa8aQgIfs4rN2ySBXlOabj5uZ3w1rV7lsQPr99Wto62hn
         VrEw37ivZfB4RIYeqSf4Rr5AyN0LbDjLENq7kRHFTEUY8uHy7yUayjVUK7/JZ8NN0Cot
         H1PQ==
X-Gm-Message-State: AFq9FYKzLpdIjAVDocI/QQ1wntBUh6uC0HJ6vXg2gBE9o9zMljxrL4so
	jki53m17UBGNZc6waMthQzFa+V7pTSVW6tY4Q2A0pOYb9gmOLn4ypZFn
X-Gm-Gg: AYBFou1lHyDW9lFBSo8Kvy/V+/ZDputscSA+sLK6rafucc9zwH1RZbM9ZsYL8LjWkw4
	hNvhxnN3x5RYnb3OzwEeURzlhClpFzThRIvFKd3J8INCUDCrmp4H5Nlc7c6MwcCgW2NOwqcbTBq
	kxlDNbdTkzfg9rjvAljo3UTQRM0zZppTmVlAktRXffwd1pyvEtShRxLBzJweZk3S+e9O/saK7E0
	EjhkYvfdeT9y3M8wzodPX14a6I+5ld7DdcuQ3eCH8OFArybz69suL+WJem+9G9NGU7psvc3RjU/
	nJDtUJE5yJgMYA1oqIVsnfl997fXK1ptQS3GilC8VfQ3vIRC3XHnM7XsaGfFWAmUT94mincejqp
	r9UB34kBYbHhJvPjzcjGq4moPBzhkhWgiIgLzN2u7ThKuQzak8evUzSy9H6pN2X+QLJjknjtvR9
	6W5Bx4kQK1UPPEv0o7TRfoWDmys8t3F4tm9SX0dXB5l4h7q3isvKRbUwHRD2cnB5RFy68u2fqXY
	YDkLewRBDMajt5eLXlT9qCNReLkZ3CdGuUr8B87PPEU3WljJjZWPo4tLhw2klQITVI4oB5APkzM
	3lzNDVsiJvJwg+3kIdsA3m8dJH2YNf/o
X-Received: by 2002:a17:90b:3c4f:b0:3a0:f5fe:74d9 with SMTP id 98e67ed59e1d1-3a0f5fec99amr2593772a91.4.1790533689177;
        Sun, 27 Sep 2026 11:28:09 -0700 (PDT)
Received: from ?IPV6:fd11:4514:2:0:b85f:853e:2051:3f90? ([2001:da8:100f:116::667])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9357f64sm16608751a91.3.2026.09.27.11.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 11:28:07 -0700 (PDT)
Message-ID: <6166ff99-7aa1-4456-aa38-a2d7820ede4a@gmail.com>
Date: Mon, 28 Sep 2026 02:27:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: netdev@vger.kernel.org, pbs05 <xuziyougm@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <tyVeMFhOR4aOm-Y3BnbglQ@gmail.com>
 <f3f5b31e-e434-452b-a77d-72ea740a5753@gmail.com>
 <rKgB0LBiQcWdd3f5aVEwfw@gmail.com>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <rKgB0LBiQcWdd3f5aVEwfw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matheus,

Thanks, that clarifies the test setup.

The numbers are useful as an implementation comparison, although I
think they are not yet enough to attribute the difference specifically
to the kernel/userspace boundary.

In particular, the old SDK-style userspace path and the current
in-kernel implementation differ in more than just where the G.988
agent runs.  A useful follow-up experiment may be to compare the
in-kernel agent against the AN7581/AN7583 userspace implementation
using an ARPHRD_NONE packet interface and AF_PACKET, with the same MIB
size and workload.

That would help separate:

   - cost of userspace/kernel crossings;
   - cost of the transport mechanism;
   - cost of the MIB representation and implementation itself.

Regarding the old SDK netdev, your description also makes me suspect
that the bridge behavior may have come from the way that interface was
constructed as a normal Ethernet-like netdev, rather than from the
net_device abstraction itself.

Andrew has now raised the broader question of whether we need a
separate management net_device at all, so I think that is probably the
more useful interface question to pursue from here.

Thanks,
Gaoyang
