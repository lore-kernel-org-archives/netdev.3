Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4889495041
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791637688; cv=pass; b=dKA+HJKXt3lwL141C6zgp6ds1An+vD+yZCKhWmRtQSwFAK9cxBbQEzu36GOexKn7vM8rX1A76JC2e8qAEzj1qj8zAnl/7t0FhbOXveo/4gKJjFreXooCq/aFowmRSTeZdZT1r0/9VPbHBtrmPH/4AgkxDDRysuC0QvSvNu3cYFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791637688; c=relaxed/simple;
	bh=Peoepvw/CV4v2nNzhaOWVLf6PtcCki7ZSzzGuOeWGYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFucjT0YC1si/EFZ7bDhjG/Zhz3iti/vNZEBFE2NFkmgKR3sIy7zUqlv75wMPJYCN4qQwdKeoFtmLSdeJ/jNg/JNUitYOaLN6CcWQTko8b2vhAiRZUV8a7pJ7eWuAnYw8oS1/7nAmGgef/Es7EoYTg7fktU/6NQFqbOUOZAVldI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFtnxtnM; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFtnxtnM"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a9787a15bdso5616911fa.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791637685; cv=none;
        d=google.com; s=arc-20260327;
        b=Bto9emvHstcWWj2I2r2keHHXYnY3/PkRjsRcr+VkT3hK4WWwJ5l98a5m6BGI0sIqly
         whEftF4ssgIlmiFJQD6AyluGNVXyNjrQmN+jq0Ta2qlO6pJ6UTC86VVvZQIkXKC5qP0c
         a4Hcl7QAmeVIcDcwgMnt7uyraqbL8d8KHjvzsLN1MOd/SaYNNYx6qzRUbDAgsjY+cj7F
         F7SrBSwJdgXy3ldpCxKti84sz6vyKJXRjpIhjrpvfh88pljTvy9ZKETIe8jvBqWdFSPn
         URoFy7Mka9326zE4bd0iIhOSvRpKq3QngoNduhUyrclo3l83o8/deJyRo9/PluxbCa7O
         YQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Peoepvw/CV4v2nNzhaOWVLf6PtcCki7ZSzzGuOeWGYs=;
        fh=Le+fAcJZo7fSZpMIaf5nXbJW5gn+4k8ZJfLiWQShwD8=;
        b=e7PKfjuYwt+ivnITlKq9IIkbv53KUT+a+PByZn7YZ3X4bqCJN0w+tYMxRQMU7gFNKL
         qjQN4rcqOf4Vtd1TrtaUw5t5XRN2ckNYPH2YYET7HuKhQZRLP7f2CGyiDJH/2mFeEOFO
         z/+RTo+rE5xkjYMjxf8p2qnzrM/Kktt5dohTK8L6r4/MWCxV4eggEABPNXRJ/bdqPDhq
         HRmYaT/Pmjw3jdPweHizVnCLEIRzg2/yn3jj8sUJYMmT28Stt5ryB2n3eMKb0+6Mu6cW
         /EsO4yrPtog902q3j2DQsGekTHNP4OcuPDtd3SWa3tSXSZ5e6ANtAGi9GoQfD8CwFnif
         oGIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791637685; x=1792242485; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Peoepvw/CV4v2nNzhaOWVLf6PtcCki7ZSzzGuOeWGYs=;
        b=GFtnxtnMvNaq4SJ1WOB/2/nknKlK/HIOBMPtnwnullEMOFW50Ww9QBWYCmB7X+EGIm
         pSLQif0Qbv3ZdpFrntpTwOaGWMdG2C2o0JkHvV8sXZbSN4R8XnWffx3vOLx9Dwokeqbo
         RDvwQ5hWGi4WdxmfelLKMloPxsce1/vqYNjqYxy507UttrM7ivmtQ86x9kDDa1k/sZoz
         tAZO3IZWS6q7oTC041c3vaFT/UaYF0XMJmFX4Ni9CfgYrAWUdyoE+/YprAdKvfUG9Sy3
         t3Cu2WHAEEx/gI2LXBurteS1cJLERNUo02TzfcKj6ZsXzVAnsbbIT/u8w9dCMfKb64iT
         dd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791637685; x=1792242485;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Peoepvw/CV4v2nNzhaOWVLf6PtcCki7ZSzzGuOeWGYs=;
        b=IlHmzXfXTBVmDEGZZb1iWVPCRwLbkYL/1Eeob9gbz29dNQGVfYxvhinbmkBzIKlnZo
         UpaGk7nVPNFfeJRgoI4DApL3rK0IrJvkd7iDYxhJ8o4ZhG1YJ08UkELajs6l0XKkQkLq
         U8pOtIZzuQffUi10yIlyJHK/HSI/zLxFhNnUfvqtFEfdLgarjOHqYGTskD6K+tFCkDNZ
         VxgjZ7vNWDx6H2SCNwg13OLBcGRFphhg4Dl06Fl7Nh6fLTRyqmc9SOC88LdMgikv/vsG
         EKb8rXwbXLMXpZXd9U1W9DkWICo3vBBgKQ/IcnFvnbnU7jHIBl8HhC8MTmDl5ovwq3X4
         3xqQ==
X-Forwarded-Encrypted: i=1; AKwUvByZlCPKIcq8QOWj/6ZnzH7H3GfaDSliJGSQnQjKROD38UhNwg5dSuNxisksOQTL9uTxp9Uc2gU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQIBgN09zwYPD8hodwWrswhK39G7Ezs61FMWUsPkKAtXRNTH0n
	DL44eZGTFuD7XsoyuooFS9f287NsdyBqOEcOEwXhP+rXeBPjMtj3YInQxb0GL53DrODsgNe7c2X
	Cb4PgBTcFFeO1FNe7YgdmfKEKi3vtVTo=
X-Gm-Gg: AYBFou3Co/9brTHaWOnsxluu/Pt3191DFtnIl7+AP6uRGwksBf1Mu8+vgOKe7UpQsbX
	JwyEWDpVHVCS3293IOLECLVQwv7lOhCqPFwyn5ZLrLr4Jt5lYsBrpGqbpJ4DCauuOB7h2M2UGva
	ExCRIrCpd1VGqIg1axGu9BUb7C6+OIlIaRz46fiQwOOir3wYEng0s5KCq1yXituBFagRv1pVU+L
	Dk4grFSJopFYJAw/0elkrsfomVoNgMuYiPWc+rF+6OK3SbN5nMtkn/7WwhZPZkQ/tmLQnmDS706
	Qj7HWWOUmeUPZWG0/SK5H836decCe2bszNoqodnPdZec7qfLxM+IFqBJENRBDxzUvjZJEFlVKkB
	6amz4fjewc7hHKbjWLI+lYXf5AoFKwX/ZzESFjyaDZQDv
X-Received: by 2002:a05:651c:54d:b0:3a4:8913:a259 with SMTP id
 38308e7fff4ca-3a9c56def06mr10678081fa.29.1791637684541; Sat, 10 Oct 2026
 06:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007115821.11332-2-sigefriedhyy@gmail.com> <179154712848.434549.1887332518398499959@kernel.org>
In-Reply-To: <179154712848.434549.1887332518398499959@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Sat, 10 Oct 2026 22:07:54 +0900
X-Gm-Features: AclHuK-XNxBmVqaX_AVuTKFXpvUqvVpdQ0iJJw8t3L0zVc4v9El00m3OF_1B3Gs
Message-ID: <CA+7S2v+hTzSacfnSJi4V2A-oj5woKA+0ffOA2cY1-7iC_LDX8w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 1/6] netlink: specs: rt-addr: fix the type of target-netnsid
To: netdev-bot+sashiko@kernel.org
Cc: ajay.kathat@microchip.com, aleksandr.loktionov@intel.com, 
	andrew+netdev@lunn.ch, claudiu.beznea@tuxon.dev, davem@davemloft.net, 
	dsahern@kernel.org, donald.hunter@gmail.com, edumazet@google.com, 
	idosch@nvidia.com, jacob.e.keller@intel.com, kuba@kernel.org, 
	johannes@sipsolutions.net, kees@kernel.org, kory.maincent@bootlin.com, 
	kuniyu@google.com, nicolas.dichtel@6wind.com, nickgarlis@gmail.com, 
	pabeni@redhat.com, sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, 
	sdf.kernel@gmail.com, vadim.fedorenko@linux.dev, willemb@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Should this have a Fixes: tag?

It is working as intended, already discussed in the previous patch review.
